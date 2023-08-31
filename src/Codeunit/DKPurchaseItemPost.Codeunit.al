codeunit 50003 "DK_Purchase Item - Post"
{
    // 
    // DK34: 20201110
    //   - Modify Function: Post


    trigger OnRun()
    begin
    end;

    var
        TextToQR: Text;
        ////zzz++
        // [RunOnClient]
        // ImageFormat: DotNet ImageFormat;
        // [RunOnClient]
        // QrCodeBitmap: DotNet Bitmap;
        // MyURL: Text;
        // [RunOnClient]
        // BarcodeFormat: DotNet BarcodeFormat;
        // [RunOnClient]
        // BarcodeWriter: DotNet BarcodeWriter;
        // [RunOnClient]
        // EncodingOption: DotNet EncodingOptions;
        // [RunOnClient]
        // BitMatrix: DotNet BitMatrix;
        ////zzz--
        FileManagement: Codeunit "File Management";
        TempBlob: Record TempBlob;
        ItemLedgerEntry: Record "DK_Item Ledger Entry";
        MSG001: Label '%2,%3 is a required value if it is currently specified as a %1.';
        MSG002: Label 'The %3 of %1 %2 is empty.';
        MSG003: Label 'The %1  is empty.';
        MSG004: Label 'A %2 less than 0 was entered in the %1.';
        MSG005: Label 'Numbers greater than the %1 can not be entered.';
        MSG006: Label 'Line and header values are different.';
        MSG007: Label 'It will be removed from the %1 and %2. Are you sure?';
        MSG008: Label 'You can not cancel because you have %1. Please check the %2.';
        MSG009: Label 'Your shipment will be canceled. Are you sure?';
        MSG010: Label '%1 that have not been shipped can not be reverse.';
        MSG011: Label '%1 is equal to %2. %3 : %4';
        MSG012: Label '%1 is %2.';
        Separator: Label '#';
        TempLocation: Label 'C:\temp\';
        BmpFormat: Label 'bmp';
        URL: Label 'http://www.yongin-park.com/yp_admin/materials/goods_out.asp?idx=';


    procedure CheckValue(pPurchHeader: Record "DK_Purchase Header"): Boolean
    var
        _PurchaseLine: Record "DK_Purchase Line";
    begin
        pPurchHeader.TestField("No.");
        //pPurchHeader.TESTFIELD(Remarks);
        pPurchHeader.TestField("Receipt Date");
        pPurchHeader.TestField("Employee Name");

        //>>Code to verify the line if the item is yes
        if pPurchHeader."Purchase Item" = pPurchHeader."Purchase Item"::Yes then begin
            /*_PurchaseLine.RESET;
            _PurchaseLine.SETRANGE("Document No.", pPurchHeader."No.");
            _PurchaseLine.SETFILTER("Item No.",'<>%1','');
            _PurchaseLine.SETRANGE("Vendor No.",'');
            _PurchaseLine.SETRANGE("Unit Price",0);
            IF _PurchaseLine.FINDFIRST THEN
              ERROR(MSG001,pPurchHeader.FIELDCAPTION("Purchase Item"),
                          _PurchaseLine.FIELDCAPTION("Vendor No."),_PurchaseLine.FIELDCAPTION("Unit Price"));
                          */
        end;
        //<<Code to verify the line if the item is yes
        _PurchaseLine.Reset;
        _PurchaseLine.SetRange("Document No.", pPurchHeader."No.");
        if _PurchaseLine.FindSet then begin
            repeat
                if _PurchaseLine."Location Code" = '' then
                    Error(MSG002, _PurchaseLine.FieldCaption("Line No."), _PurchaseLine."Line No.", _PurchaseLine.FieldCaption("Location Code"));
                if _PurchaseLine.Quantity <= 0 then
                    Error(MSG002, _PurchaseLine.FieldCaption("Line No."), _PurchaseLine."Line No.", _PurchaseLine.FieldCaption(Quantity));
            until _PurchaseLine.Next = 0;
        end;


        exit(true);

    end;


    procedure Post(var pPurchHeader: Record "DK_Purchase Header")
    var
        _Item: Record DK_Item;
        _PurchHeader: Record "DK_Purchase Header";
        _PurchLine: Record "DK_Purchase Line";
        _PostedPurchReceipt: Record "DK_Posted Purchase Receipt";
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        TmpQuantity: Decimal;
        TmpQRInteger: Integer;
        _ItemLedgerEntry2: Record "DK_Item Ledger Entry";
        _Picture: Record DK_Picture;
        _Picture2: Record DK_Picture;
    begin

        if not CheckValue(pPurchHeader) then exit;

        _PurchLine.Reset;
        _PurchLine.SetRange("Document No.", pPurchHeader."No.");
        _PurchLine.SetFilter("Item No.", '<>%1', '');
        if not _PurchLine.FindSet then
            Error(MSG003, _PurchLine.TableCaption)
        else begin
            repeat
                //>>Insert to PostedPurchReceipt
                with _PostedPurchReceipt do begin
                    LockTable;
                    Init;

                    Validate("Document No.", pPurchHeader."No.");
                    Validate("Receipt Date", pPurchHeader."Receipt Date");
                    Validate("Receipt Time", pPurchHeader."Receipt Time");
                    Validate("Purchase Item", pPurchHeader."Purchase Item");
                    Validate(Remarks, pPurchHeader.Remarks);
                    Validate("Line No.", _PurchLine."Line No.");
                    Validate("Item No.", _PurchLine."Item No.");
                    Validate("Item Name", _PurchLine."Item Name");
                    Validate("Item Main Cat. Code", _PurchLine."Item Main Cat. Code");
                    Validate("Item Main Cat. Name", _PurchLine."Item Main Cat. Name");
                    Validate("Item Sub Cat. Code", _PurchLine."Item Sub Cat. Code");
                    Validate("Item Sub Cat. Name", _PurchLine."Item Sub Cat. Name");
                    Validate("Qty. to Receipt", _PurchLine.Quantity);
                    Validate("Location Code", _PurchLine."Location Code");
                    Validate("Unit Price", _PurchLine."Unit Price");
                    Validate(Amount, _PurchLine.Amount);
                    Validate("Vendor No.", _PurchLine."Vendor No.");
                    Validate("Vendor Name", _PurchLine."Vendor Name");
                    //>> DK34
                    Validate("Item Type", pPurchHeader."Item Type");
                    //<<
                    //>>Transfer pictures
                    _Picture.Reset;
                    _Picture.SetCurrentKey("Table ID");
                    _Picture.SetRange("Table ID", DATABASE::"DK_Purchase Line");
                    _Picture.SetRange("Source No.", pPurchHeader."No.");
                    if _Picture.FindSet then begin
                        _Picture.CalcFields(Picture);
                        _Picture.SetRange("Source Line No.", _PurchLine."Line No.");
                        _Picture2.Init;
                        _Picture2.TransferFields(_Picture);
                        _Picture2.Picture := _Picture.Picture;
                        _Picture2.Validate("Table ID", DATABASE::"DK_Posted Purchase Receipt");
                        _Picture2.Insert;
                    end;

                    Insert(true);
                end;
                //<<Insert to PostedPurchReceipt

                //>>Insert to ItemLedgerEntry
                _Item.Reset;
                _Item.SetRange("No.", _PurchLine."Item No.");
                if _Item.FindSet then begin
                    if _Item."QR Code Use" = _Item."QR Code Use"::Yes then begin
                        TmpQuantity := 1; //QRcode sequence Number
                        while TmpQuantity <= _PurchLine.Quantity do begin
                            Insert_ItemLedgerEntry_Rec(pPurchHeader, _PurchLine, TmpQuantity, true);
                            TmpQuantity += 1;
                        end;
                    end else begin
                        Insert_ItemLedgerEntry_Rec(pPurchHeader, _PurchLine, 0, false);
                    end;
                end;
            //<<Insert to ItemLedgerEntry
            until _PurchLine.Next = 0;
        end;

        pPurchHeader.Validate(Posted, true);
        pPurchHeader.Modify;
    end;


    procedure Insert_ItemLedgerEntry_Rec(pPurchHeader: Record "DK_Purchase Header"; pPurchLine: Record "DK_Purchase Line"; pQty: Decimal; pQr: Boolean)
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _Picture: Record DK_Picture;
        _Picture2: Record DK_Picture;
    begin
        with _ItemLedgerEntry do begin
            LockTable;
            Init;
            "Entry No." := 0;
            Validate("Entry Type", "Entry Type"::Receipt);
            Validate("Document No.", pPurchHeader."No.");
            Validate("Document Line No.", pPurchLine."Line No.");
            Validate("Source No.", pPurchHeader."No.");
            Validate("Source Line No.", pPurchLine."Line No.");
            Validate(Date, pPurchHeader."Receipt Date");
            Validate(Remarks, pPurchHeader.Remarks);
            Validate("Item No.", pPurchLine."Item No.");
            Validate("Item Name", pPurchLine."Item Name");
            Validate("Item Main Cat. Code", pPurchLine."Item Main Cat. Code");
            Validate("Item Main Cat. Name", pPurchLine."Item Main Cat. Name");
            Validate("Item Sub Cat. Code", pPurchLine."Item Sub Cat. Code");
            Validate("Item Sub Cat. Name", pPurchLine."Item Sub Cat. Name");
            Validate("Location Code", pPurchLine."Location Code");
            Validate("Employee No.", pPurchHeader."Employee No.");

            if pQr then begin
                Validate(Quantity, 1);
                Validate("Serial No.", StrSubstNo('%1-%2-%3', pPurchHeader."No.", pPurchLine."Line No.", pQty));
                CalcQRCode(_ItemLedgerEntry);
            end
            else
                Validate(Quantity, pPurchLine.Quantity);

            Insert(true);
        end;
    end;


    procedure PostShipCheck(pPostPurchRec: Record "DK_Posted Purchase Receipt"): Boolean
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _SumQty: Decimal;
    begin

        pPostPurchRec.TestField("Shipment Type Code");
        pPostPurchRec.TestField("Shipment Date");
        pPostPurchRec.TestField("Qty. to Ship");
        pPostPurchRec.TestField(Employee);

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Document No.", pPostPurchRec."Document No.");
        _ItemLedgerEntry.SetRange("Document Line No.", pPostPurchRec."Line No.");
        if _ItemLedgerEntry.FindSet then begin
            repeat
                _ItemLedgerEntry.CalcSums("Qty. to Ship");
                _SumQty := _ItemLedgerEntry."Qty. to Ship";
            until _ItemLedgerEntry.Next = 0;

            if _SumQty <> pPostPurchRec."Qty. to Ship" then
                Error(MSG006);

            if (_SumQty > pPostPurchRec.Inventory) or
              (pPostPurchRec."Qty. to Ship" > pPostPurchRec.Inventory) then
                Error(MSG005, pPostPurchRec.FieldCaption(Inventory));
        end;

        exit(true);
    end;


    procedure PostShip(pPostPurchRec: Record "DK_Posted Purchase Receipt"): Boolean
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _QtyShip: Decimal;
    begin

        if not PostShipCheck(pPostPurchRec) then exit;
        if pPostPurchRec."Qty. to Ship" = 0 then exit;

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Document No.", pPostPurchRec."Document No.");
        _ItemLedgerEntry.SetRange("Document Line No.", pPostPurchRec."Line No.");
        _ItemLedgerEntry.SetFilter("Qty. to Ship", '<>0');
        if _ItemLedgerEntry.FindSet then begin
            repeat
                Insert_ItemLedgerEntry_Ship(pPostPurchRec, _ItemLedgerEntry);
            until _ItemLedgerEntry.Next = 0;

            ModifyPostedPurchRec(pPostPurchRec);

            exit(true);
        end;

        exit(false);
    end;


    procedure Insert_ItemLedgerEntry_Ship(pPostPurchRec: Record "DK_Posted Purchase Receipt"; pItemLedgerEntry: Record "DK_Item Ledger Entry")
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin
        with _ItemLedgerEntry do begin
            LockTable;
            Init;
            "Entry No." := 0;
            Validate("Entry Type", "Entry Type"::Shipment);
            Validate("Source No.", pItemLedgerEntry."Source No.");
            Validate("Source Line No.", pItemLedgerEntry."Source Line No.");
            Validate("Item No.", pItemLedgerEntry."Item No.");
            Validate("Item Name", pItemLedgerEntry."Item Name");
            Validate("Item Main Cat. Code", pItemLedgerEntry."Item Main Cat. Code");
            Validate("Item Main Cat. Name", pItemLedgerEntry."Item Main Cat. Name");
            Validate("Item Sub Cat. Code", pItemLedgerEntry."Item Sub Cat. Code");
            Validate("Item Sub Cat. Name", pItemLedgerEntry."Item Sub Cat. Name");
            Validate("Location Code", pItemLedgerEntry."Location Code");
            Validate("Use Area", pPostPurchRec."Cemetry No.");
            Validate(Date, pPostPurchRec."Shipment Date");
            Validate(Remarks, pPostPurchRec.Remarks);
            Validate("Shipment Type Code", pPostPurchRec."Shipment Type Code");
            Validate("Working Group Code", pPostPurchRec."Working Group Code");
            Validate("Use Area", pPostPurchRec."Use Area");
            Validate(Quantity, -pItemLedgerEntry."Qty. to Ship");
            Validate("Serial No.", pItemLedgerEntry."Serial No.");
            Validate("Employee No.", pPostPurchRec."Employee No.");
            Insert(true);
        end;
    end;


    procedure ModifyPostedPurchRec(pPostPurchRec: Record "DK_Posted Purchase Receipt")
    begin
        pPostPurchRec.Validate("Shipment Type Code", '');
        pPostPurchRec.Validate("Shipment Date", 0D);
        pPostPurchRec.Validate("Qty. to Ship", 0);
        pPostPurchRec.Validate("Working Group Code", '');
        pPostPurchRec.Validate("Cemetry No.", '');
        pPostPurchRec.Validate("Use Area", '');
        pPostPurchRec.Validate("Employee No.", '');
        pPostPurchRec.Modify;
    end;


    procedure ReceiptReverse(var pPostPurchReceipt: Record "DK_Posted Purchase Receipt"): Boolean
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _ItemLedgerEntry2: Record "DK_Item Ledger Entry";
        _Picture: Record DK_Picture;
        _Picture2: Record DK_Picture;
        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
    begin
        //Receipt Reverse
        _PostedPurchaseReceipt.CopyFilters(pPostPurchReceipt);

        if _PostedPurchaseReceipt.FindFirst then begin
            repeat
                _PostedPurchaseReceipt.CalcFields(Inventory);
                if _PostedPurchaseReceipt.Inventory < _PostedPurchaseReceipt."Qty. to Receipt" then begin
                    Error(MSG008, _PostedPurchaseReceipt.FieldCaption(Inventory), _PostedPurchaseReceipt."Document No.");
                    exit(false);
                end;
            until _PostedPurchaseReceipt.Next = 0;
        end;

        if not Confirm(MSG007, false, pPostPurchReceipt.TableCaption, _ItemLedgerEntry.TableCaption) then exit(false);

        if _PostedPurchaseReceipt.FindFirst then begin
            repeat
                _ItemLedgerEntry.Reset;
                _ItemLedgerEntry.SetRange("Document No.", _PostedPurchaseReceipt."Document No.");
                _ItemLedgerEntry.SetRange("Document Line No.", _PostedPurchaseReceipt."Line No.");
                _ItemLedgerEntry.SetRange("Entry Type", _ItemLedgerEntry."Entry Type"::Receipt);
                _ItemLedgerEntry.SetFilter(Quantity, '>%1', 0);
                _ItemLedgerEntry.SetRange(Reverse, false);
                if _ItemLedgerEntry.FindFirst then begin
                    repeat
                        //Second
                        _ItemLedgerEntry2.Init;
                        _ItemLedgerEntry2."Entry No." := 0;
                        _ItemLedgerEntry2."Entry Type" := _ItemLedgerEntry."Entry Type";
                        _ItemLedgerEntry2.Date := WorkDate;
                        _ItemLedgerEntry2."Document No." := _ItemLedgerEntry."Document No.";
                        _ItemLedgerEntry2."Document Line No." := _ItemLedgerEntry."Document Line No.";
                        _ItemLedgerEntry2."Source No." := _ItemLedgerEntry."Source No.";
                        _ItemLedgerEntry2."Source Line No." := _ItemLedgerEntry."Source Line No.";
                        _ItemLedgerEntry2."Item No." := _ItemLedgerEntry."Item No.";
                        _ItemLedgerEntry2."Item Name" := _ItemLedgerEntry."Item Name";
                        _ItemLedgerEntry2."Item Main Cat. Code" := _ItemLedgerEntry."Item Main Cat. Code";
                        _ItemLedgerEntry2."Item Main Cat. Name" := _ItemLedgerEntry."Item Main Cat. Name";
                        _ItemLedgerEntry2."Item Sub Cat. Code" := _ItemLedgerEntry."Item Sub Cat. Code";
                        _ItemLedgerEntry2."Item Sub Cat. Name" := _ItemLedgerEntry."Item Sub Cat. Name";
                        _ItemLedgerEntry2."Serial No." := _ItemLedgerEntry."Serial No.";
                        _ItemLedgerEntry2."Location Code" := _ItemLedgerEntry."Location Code";
                        _ItemLedgerEntry2."Location Name" := _ItemLedgerEntry."Location Name";
                        _ItemLedgerEntry2.Quantity := -_ItemLedgerEntry.Quantity;
                        _ItemLedgerEntry2.Remarks := _ItemLedgerEntry.Remarks;
                        _ItemLedgerEntry2.Reverse := true;
                        _ItemLedgerEntry2.Insert(true);

                        //Original
                        _ItemLedgerEntry.Validate(Reverse, true);
                        _ItemLedgerEntry.Modify;

                    until _ItemLedgerEntry.Next = 0;
                end;
                //Original Update
                _PostedPurchaseReceipt.Validate(Reverse, true);
                _PostedPurchaseReceipt.Modify;
            until _PostedPurchaseReceipt.Next = 0;
            exit(true);

        end;
    end;


    procedure ShipmentReverse(var pItemLedgerEntry: Record "DK_Item Ledger Entry"): Boolean
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _CheckItemLedgerEntry: Record "DK_Item Ledger Entry";
        _Employee: Record DK_Employee;
    begin

        if pItemLedgerEntry.FindSet then begin
            repeat
                _CheckItemLedgerEntry.Reset;
                _CheckItemLedgerEntry.SetRange("Source No.", pItemLedgerEntry."Source No.");
                _CheckItemLedgerEntry.SetRange("Source Line No.", pItemLedgerEntry."Source Line No.");
                _CheckItemLedgerEntry.SetRange("Entry Type", _CheckItemLedgerEntry."Entry Type"::Receipt);
                if _CheckItemLedgerEntry.FindSet then begin
                    _CheckItemLedgerEntry.CalcFields(Inventory);
                    if _CheckItemLedgerEntry.Inventory >= _CheckItemLedgerEntry.Quantity then begin
                        pItemLedgerEntry.CalcFields(Inventory);
                        Error(MSG011, _CheckItemLedgerEntry.FieldCaption(Inventory), _CheckItemLedgerEntry.FieldCaption(Quantity),
                        _CheckItemLedgerEntry.FieldCaption("Entry No."), _CheckItemLedgerEntry."Entry No.");
                        exit(false);
                    end;
                end;
                if pItemLedgerEntry."Entry Type" <> pItemLedgerEntry."Entry Type"::Shipment then begin
                    Error(MSG012, pItemLedgerEntry.FieldCaption("Entry Type"), Format(pItemLedgerEntry."Entry Type"));
                    exit(false);
                end;
                if pItemLedgerEntry.Reverse then begin
                    Error(MSG011, pItemLedgerEntry."Item Name", pItemLedgerEntry.FieldCaption("Entry No."), pItemLedgerEntry."Entry No.");
                    exit(false);
                end;
            until pItemLedgerEntry.Next = 0;
        end;

        if not Confirm(MSG009, false) then exit(false);

        if pItemLedgerEntry.FindSet then begin
            repeat
                //_ItemLedgerEntry2.RESET;
                //_ItemLedgerEntry2.SETRANGE("Source No.",pItemLedgerEntry."Source No.");
                //_ItemLedgerEntry2.SETRANGE("Source Line No.",pItemLedgerEntry."Source Line No.");
                //_ItemLedgerEntry2.SETRANGE("Serial No.",pItemLedgerEntry."Serial No.");
                //_ItemLedgerEntry2.SETRANGE("Entry Type",pItemLedgerEntry."Entry Type"::Shipment);
                //IF _ItemLedgerEntry2.FINDFIRST THEN BEGIN
                _ItemLedgerEntry.Init;
                _ItemLedgerEntry."Entry No." := 0;
                _ItemLedgerEntry."Entry Type" := pItemLedgerEntry."Entry Type"::Shipment;
                _ItemLedgerEntry.Date := WorkDate;
                _ItemLedgerEntry."Source No." := pItemLedgerEntry."Source No.";
                _ItemLedgerEntry."Source Line No." := pItemLedgerEntry."Source Line No.";
                _ItemLedgerEntry."Item No." := pItemLedgerEntry."Item No.";
                _ItemLedgerEntry."Item Name" := pItemLedgerEntry."Item Name";
                _ItemLedgerEntry."Item Main Cat. Code" := pItemLedgerEntry."Item Main Cat. Code";
                _ItemLedgerEntry."Item Main Cat. Name" := pItemLedgerEntry."Item Main Cat. Name";
                _ItemLedgerEntry."Item Sub Cat. Code" := pItemLedgerEntry."Item Sub Cat. Code";
                _ItemLedgerEntry."Item Sub Cat. Name" := pItemLedgerEntry."Item Sub Cat. Name";
                _ItemLedgerEntry."Serial No." := pItemLedgerEntry."Serial No.";
                _ItemLedgerEntry."Location Code" := pItemLedgerEntry."Location Code";
                _ItemLedgerEntry."Location Name" := pItemLedgerEntry."Location Name";
                _ItemLedgerEntry.Quantity := -(pItemLedgerEntry.Quantity);
                _ItemLedgerEntry."Shipment Type Code" := pItemLedgerEntry."Shipment Type Code";
                _ItemLedgerEntry."Shipment Type" := pItemLedgerEntry."Shipment Type";
                _ItemLedgerEntry."Working Group Code" := pItemLedgerEntry."Working Group Code";
                _ItemLedgerEntry."Working Group Name" := pItemLedgerEntry."Working Group Name";
                _ItemLedgerEntry."Use Area" := pItemLedgerEntry."Use Area";
                _ItemLedgerEntry.Remarks := pItemLedgerEntry.Remarks;
                _ItemLedgerEntry.Reverse := true;
                _Employee.Reset;
                _Employee.SetRange("ERP User ID", UserId);
                if _Employee.FindSet then begin
                    _ItemLedgerEntry."Employee No." := _Employee."No.";
                    _ItemLedgerEntry.Employee := _Employee.Name;
                end;
                _ItemLedgerEntry.Insert(true);
            //END;
            until pItemLedgerEntry.Next = 0;
            exit(true);
        end;
    end;


    procedure CalcQRCode(var pItemLedgerEntry: Record "DK_Item Ledger Entry")
    var
        SaveLocation: Text;
    begin
        ConcatContent(pItemLedgerEntry);
        ////zzz++
        // EncodingOption := EncodingOption.EncodingOptions();
        // EncodingOption.Height := 100;
        // EncodingOption.Width := 100;

        // BarcodeWriter := BarcodeWriter.BarcodeWriter();
        // BarcodeWriter.Format := BarcodeFormat.QR_CODE;
        // BarcodeWriter.Options := EncodingOption;
        // BitMatrix := BarcodeWriter.Encode(TextToQR);
        // QrCodeBitmap := BarcodeWriter.Write(BitMatrix);
        ////zzz--

        //SaveLocation := TempLocation + FORMAT(pItemLedgerEntry."Serial No.") + BmpFormat;

        // SaveLocation := FileManagement.ClientTempFileName(BmpFormat);////zzz

        /*
        IF NOT ISSERVICETIER THEN
          IF EXISTS(SaveLocation) THEN
            ERASE(SaveLocation);
            */

        // QrCodeBitmap.Save(SaveLocation, ImageFormat.Bmp);////zzz

        //FileManagement.BLOBImportFromServerFile(TempBlob, SaveLocation);
        FileManagement.BLOBImport(TempBlob, SaveLocation);
        pItemLedgerEntry."QR Code" := TempBlob.Blob;

    end;

    local procedure ConcatContent(pItemLedgerEntry: Record "DK_Item Ledger Entry")
    var
        SalesLine: Record "Sales Line";
        _FunctionSetup: Record "DK_Function Setup";
    begin
        _FunctionSetup.Get;

        TextToQR := _FunctionSetup."QRCode URL";
        TextToQR += pItemLedgerEntry."Serial No.";

    end;
}

