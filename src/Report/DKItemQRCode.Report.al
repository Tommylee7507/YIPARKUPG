report 50020 "DK_Item QR Code" ////zzz
{
    // // //À‹Ó ¯“Ë× „ÔÎ QR”À…Î “Ë‡’
    // DefaultLayout = RDLC;
    // RDLCLayout = './src/layout/DKItemQRCode.rdl';

    // Caption = 'Item QR Code';
    // PreviewMode = PrintLayout;
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;

    // dataset
    // {
    //     dataitem("DK_Item Ledger Entry"; "DK_Item Ledger Entry")
    //     {
    //         DataItemTableView = SORTING("Entry No.");
    //         UseTemporary = true;
    //         column(ItemNo; "DK_Item Ledger Entry"."Item No.")
    //         {
    //         }
    //         column(ItemName; "DK_Item Ledger Entry"."Item Name")
    //         {
    //         }
    //         column(SerialNo; "DK_Item Ledger Entry"."Serial No.")
    //         {
    //         }
    //         column(QRCode; "DK_Item Ledger Entry"."QR Code")
    //         {
    //         }
    //         column(VirtualQRCode1; "DK_Item Ledger Entry"."Virtual QR Code 1")
    //         {
    //         }
    //         column(VirtualQRCode2; "DK_Item Ledger Entry"."Virtual QR Code 2")
    //         {
    //         }
    //         column(VirtualQRCode3; "DK_Item Ledger Entry"."Virtual QR Code 3")
    //         {
    //         }
    //         column(VirtualQRCode4; "DK_Item Ledger Entry"."Virtual QR Code 4")
    //         {
    //         }
    //         column(VirtualQRCode5; "DK_Item Ledger Entry"."Virtual QR Code 5")
    //         {
    //         }
    //         column(VirtualSerialNo1; "DK_Item Ledger Entry"."Virtual Serial No. 1")
    //         {
    //         }
    //         column(VirtualSerialNo2; "DK_Item Ledger Entry"."Virtual Serial No. 2")
    //         {
    //         }
    //         column(VirtualSerialNo3; "DK_Item Ledger Entry"."Virtual Serial No. 3")
    //         {
    //         }
    //         column(VirtualSerialNo4; "DK_Item Ledger Entry"."Virtual Serial No. 4")
    //         {
    //         }
    //         column(VirtualSerialNo5; "DK_Item Ledger Entry"."Virtual Serial No. 5")
    //         {
    //         }

    //         trigger OnPreDataItem()
    //         begin
    //             InsertVirtualQRCode(ItemLedEntryText);
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             field(ItemLedEntryText; ItemLedEntryText)
    //             {
    //                 Caption = 'Item Ledger Entry';
    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    //     OrderLbl = 'Orders:';
    //     ShipperLbl = 'Shipper:';
    //     CustomerNameLbl = 'Name:';
    //     AddressLbl = 'Address:';
    //     ShipmentDateLbl = 'Shipment Date:';
    //     ItemDescLbl = 'Recipe Name';
    //     QtyLbl = 'Qty.';
    //     OrderNoLbl = 'Order #:';
    //     CountryRegionLbl = 'Region:';
    // }

    // var
    //     Separator: Label '#';
    //     TextToQR: Text;
    //     [RunOnClient]
    //     ImageFormat: DotNet ImageFormat;
    //     [RunOnClient]
    //     QrCodeBitmap: DotNet Bitmap;
    //     MyURL: Text;
    //     [RunOnClient]
    //     BarcodeFormat: DotNet BarcodeFormat;
    //     [RunOnClient]
    //     BarcodeWriter: DotNet BarcodeWriter;
    //     [RunOnClient]
    //     EncodingOption: DotNet EncodingOptions;
    //     [RunOnClient]
    //     BitMatrix: DotNet BitMatrix;
    //     TempLocation: Label 'C:\temp\';
    //     BmpFormat: Label '.bmp';
    //     FileManagement: Codeunit "File Management";
    //     TempBlob: Record TempBlob;
    //     ItemLedgerEntry: Record "DK_Item Ledger Entry";
    //     ItemLedEntryText: Text;
    //     SerialNo: Text;
    //     MSG001: Label 'Please select %1';

    // local procedure InsertVirtualQRCode(pItemLedEntryText: Text)
    // var
    //     _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    //     _TmpQRCode: Integer;
    //     _TmpEntry: Integer;
    // begin
    //     _TmpQRCode := 0;
    //     /*ItemLedgerEntry.RESET;
    //     ItemLedgerEntry.SETCURRENTKEY("Entry No.");
    //     ItemLedgerEntry.SETRANGE("Item No.",ItemNo);
    //     ItemLedgerEntry.SETFILTER("Serial No.",'<>%1','');*/
    //     ItemLedgerEntry.Reset;
    //     ItemLedgerEntry.SetFilter("Entry No.", pItemLedEntryText);
    //     if ItemLedgerEntry.FindSet then begin
    //         repeat
    //             ItemLedgerEntry.CalcFields(Inventory, "QR Code");
    //             if not (ItemLedgerEntry.Inventory = 0) and
    //               (ItemLedgerEntry."QR Code".HasValue) then begin
    //                 _TmpQRCode += 1;

    //                 if _TmpQRCode = 1 then begin
    //                     _TmpEntry += 1;
    //                     "DK_Item Ledger Entry".Reset;
    //                     "DK_Item Ledger Entry".Init;
    //                     "DK_Item Ledger Entry".TransferFields(ItemLedgerEntry);
    //                     "DK_Item Ledger Entry"."Entry No." := _TmpEntry;
    //                     "DK_Item Ledger Entry"."Virtual QR Code 1" := ItemLedgerEntry."QR Code";
    //                     "DK_Item Ledger Entry"."Virtual Serial No. 1" := ItemLedgerEntry."Serial No.";
    //                     "DK_Item Ledger Entry".Insert;
    //                 end;

    //                 if _TmpQRCode = 2 then begin
    //                     "DK_Item Ledger Entry"."Virtual QR Code 2" := ItemLedgerEntry."QR Code";
    //                     "DK_Item Ledger Entry"."Virtual Serial No. 2" := ItemLedgerEntry."Serial No.";
    //                     "DK_Item Ledger Entry".Modify;
    //                 end;

    //                 if _TmpQRCode = 3 then begin
    //                     "DK_Item Ledger Entry"."Virtual QR Code 3" := ItemLedgerEntry."QR Code";
    //                     "DK_Item Ledger Entry"."Virtual Serial No. 3" := ItemLedgerEntry."Serial No.";
    //                     "DK_Item Ledger Entry".Modify;
    //                 end;

    //                 if _TmpQRCode = 4 then begin
    //                     "DK_Item Ledger Entry"."Virtual QR Code 4" := ItemLedgerEntry."QR Code";
    //                     "DK_Item Ledger Entry"."Virtual Serial No. 4" := ItemLedgerEntry."Serial No.";
    //                     "DK_Item Ledger Entry".Modify;
    //                 end;

    //                 if _TmpQRCode = 5 then begin
    //                     "DK_Item Ledger Entry"."Virtual QR Code 5" := ItemLedgerEntry."QR Code";
    //                     "DK_Item Ledger Entry"."Virtual Serial No. 5" := ItemLedgerEntry."Serial No.";
    //                     "DK_Item Ledger Entry".Modify;
    //                     _TmpQRCode := 0;
    //                 end;

    //             end;
    //         until ItemLedgerEntry.Next = 0;
    //     end;

    // end;

    // local procedure CalcQRCode()
    // var
    //     SaveLocation: Text;
    // begin
    //     ConcatContent();

    //     EncodingOption := EncodingOption.EncodingOptions();
    //     EncodingOption.Height := 100;
    //     EncodingOption.Width := 100;

    //     BarcodeWriter := BarcodeWriter.BarcodeWriter();
    //     BarcodeWriter.Format := BarcodeFormat.QR_CODE;
    //     BarcodeWriter.Options := EncodingOption;
    //     BitMatrix := BarcodeWriter.Encode(TextToQR);
    //     QrCodeBitmap := BarcodeWriter.Write(BitMatrix);

    //     SaveLocation := TempLocation + Format("DK_Item Ledger Entry"."Entry No.") + BmpFormat;

    //     if not IsServiceTier then
    //         if Exists(SaveLocation) then
    //             Erase(SaveLocation);


    //     QrCodeBitmap.Save(SaveLocation, ImageFormat.Bmp);

    //     FileManagement.BLOBImportFromServerFile(TempBlob, SaveLocation);
    //     "DK_Item Ledger Entry"."QR Code" := TempBlob.Blob;
    //     "DK_Item Ledger Entry".Modify;
    // end;

    // local procedure ConcatContent()
    // var
    //     SalesLine: Record "Sales Line";
    // begin
    //     TextToQR := '';
    //     TextToQR := AddToSeparator(TextToQR);
    //     TextToQR += AddToSeparator("DK_Item Ledger Entry"."Serial No.")
    // end;

    // local procedure AddToSeparator(InText: Text): Text
    // begin
    //     exit(InText + Separator);
    // end;


    // procedure SetParam(pText: Text)
    // begin

    //     ItemLedEntryText := pText;
    // end;
}

