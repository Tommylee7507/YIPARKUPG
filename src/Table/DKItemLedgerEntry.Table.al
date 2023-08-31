table 50052 "DK_Item Ledger Entry"
{
    // 
    // DK34: 20201202
    //   - Modify Field: "Reverse"

    Caption = 'Item Ledger Entry';
    DataCaptionFields = "Entry Type", "Document No.", "Document Line No.", "Item Name";
    DrillDownPageID = "DK_Item Ledger Entry";
    LookupPageID = "DK_Item Ledger Entry";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Receipt,Shipment';
            OptionMembers = Receipt,Shipment;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Item;
        }
        field(7; "Item Name"; Text[50])
        {
            Caption = 'Item Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Item Main Cat. Code"; Code[20])
        {
            Caption = 'Item Main Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Item Main Category".Code;
        }
        field(9; "Item Main Cat. Name"; Text[30])
        {
            Caption = 'Item Main Category Name';
            DataClassification = ToBeClassified;
        }
        field(10; "Item Sub Cat. Code"; Code[20])
        {
            Caption = 'Item Sub Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Item Sub Category".Code WHERE("Item Main Cat. Code" = FIELD("Item Main Cat. Code"));
        }
        field(11; "Item Sub Cat. Name"; Text[30])
        {
            Caption = 'Item Sub Category Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Serial No."; Text[30])
        {
            Caption = 'Serial No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Location.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Location: Record DK_Location;
            begin
                if _Location.Get("Location Code") then
                    "Location Name" := _Location.Name
                else
                    "Location Name" := '';
            end;
        }
        field(14; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Location.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Location Code", Location.GetLocationCode("Location Name"));
            end;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
        }
        field(16; "Shipment Type Code"; Code[20])
        {
            Caption = 'Shipment Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Shipment Type".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _ShipmentType: Record "DK_Shipment Type";
            begin
                if _ShipmentType.Get("Shipment Type Code") then
                    "Shipment Type" := _ShipmentType.Name
                else
                    "Shipment Type" := '';
            end;
        }
        field(17; "Shipment Type"; Text[50])
        {
            Caption = 'Shipment Type';
            TableRelation = "DK_Shipment Type".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Shipment Type Code", ShipmentType.GetShipmentTypeCode("Shipment Type"));
            end;
        }
        field(18; "Working Group Code"; Code[20])
        {
            Caption = 'Working Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkGroup: Record "DK_Work Group";
            begin
                if _WorkGroup.Get("Working Group Code") then
                    "Working Group Name" := _WorkGroup.Name
                else
                    "Working Group Name" := '';
            end;
        }
        field(19; "Working Group Name"; Text[50])
        {
            Caption = 'Working Group Name';
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Working Group Code", WorkGroup.GetWorkGroupCode("Working Group Name"));
            end;
        }
        field(20; "Use Area"; Text[30])
        {
            Caption = 'Use area';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Cemetery No."; Text[50])
        {
            Caption = 'Cemetery No.';
        }
        field(23; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(25; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(26; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            var
                _PostPurchReceipt: Record "DK_Posted Purchase Receipt";
                _ItemLedgerEntry: Record "DK_Item Ledger Entry";
                _SumQty: Decimal;
            begin
                if Rec."Qty. to Ship" <> xRec."Qty. to Ship" then begin
                    CalcFields(Inventory);
                    if "Qty. to Ship" > Inventory then
                        Error(MSG001, FieldCaption(Inventory));

                    GetSumQtyPosted("Qty. to Ship");
                end;
            end;
        }
        field(27; "Qty. Shipped"; Decimal)
        {
            Caption = 'Qty. Shipped';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
        }
        field(29; Inventory; Decimal)
        {
            CalcFormula = Sum("DK_Item Ledger Entry".Quantity WHERE("Source No." = FIELD("Document No."),
                                                                     "Source Line No." = FIELD("Document Line No."),
                                                                     "Serial No." = FIELD("Serial No.")));
            Caption = 'Inventory';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; Reverse; Boolean)
        {
            Caption = 'Reverse';
            DataClassification = ToBeClassified;
        }
        field(31; "QR Code"; BLOB)
        {
            Caption = 'QR Code';
            DataClassification = SystemMetadata;
            SubType = Bitmap;
        }
        field(32; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                if _Employee.Get("Employee No.") then
                    Employee := _Employee.Name
                else
                    Employee := '';
            end;
        }
        field(33; Employee; Text[30])
        {
            Caption = 'Employee';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                Validate("Employee No.", _Employee.GetEmployeeNo(Employee));
            end;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Cration Date';
            DataClassification = ToBeClassified;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
        }
        field(50000; "Virtual QR Code 1"; BLOB)
        {
            Caption = 'Virtual QR Code 1';
            DataClassification = SystemMetadata;
            SubType = Bitmap;
        }
        field(50001; "Virtual QR Code 2"; BLOB)
        {
            Caption = 'Virtual QR Code 2';
            DataClassification = SystemMetadata;
            SubType = Bitmap;
        }
        field(50002; "Virtual QR Code 3"; BLOB)
        {
            Caption = 'Virtual QR Code 3';
            DataClassification = SystemMetadata;
            SubType = Bitmap;
        }
        field(50003; "Virtual QR Code 4"; BLOB)
        {
            Caption = 'Virtual QR Code 4';
            DataClassification = SystemMetadata;
            SubType = Bitmap;
        }
        field(50004; "Virtual QR Code 5"; BLOB)
        {
            Caption = 'Virtual QR Code 5';
            DataClassification = SystemMetadata;
            SubType = Bitmap;
        }
        field(50005; "Virtual Serial No. 1"; Text[30])
        {
            Caption = 'Virtual Serial No. 1';
            DataClassification = ToBeClassified;
        }
        field(50006; "Virtual Serial No. 2"; Text[30])
        {
            Caption = 'Virtual Serial No. 2';
            DataClassification = ToBeClassified;
        }
        field(50007; "Virtual Serial No. 3"; Text[30])
        {
            Caption = 'Virtual Serial No. 3';
            DataClassification = ToBeClassified;
        }
        field(50008; "Virtual Serial No. 4"; Text[30])
        {
            Caption = 'Virtual Serial No. 4';
            DataClassification = ToBeClassified;
        }
        field(50009; "Virtual Serial No. 5"; Text[30])
        {
            Caption = 'Virtual Serial No. 5';
            DataClassification = ToBeClassified;
        }
        field(59000; IDX; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
        key(Key3; "Serial No.")
        {
        }
        key(Key4; Quantity)
        {
        }
        key(Key5; "Item No.")
        {
        }
        key(Key6; "Item Name")
        {
        }
        key(Key7; "Source No.", "Source Line No.", "Serial No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Item No.", "Item Name", "Serial No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    var
        MSG001: Label 'Numbers greater than the %1 can not be entered.';
        Location: Record DK_Location;
        ShipmentType: Record "DK_Shipment Type";
        WorkGroup: Record "DK_Work Group";

    local procedure GetNextEntryNo(): Integer
    var
        _DK_ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin
        _DK_ItemLedgerEntry.SetCurrentKey("Entry No.");
        if _DK_ItemLedgerEntry.FindLast then
            exit(_DK_ItemLedgerEntry."Entry No." + 1);

        exit(1);
    end;


    procedure GetSumQtyPosted(pQty: Decimal)
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _PostPurchRec: Record "DK_Posted Purchase Receipt";
        _SumQty: Decimal;
    begin
        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Document No.", "Document No.");
        _ItemLedgerEntry.SetRange("Document Line No.", "Document Line No.");
        _ItemLedgerEntry.SetFilter("Entry No.", '<>%1', "Entry No.");
        if _ItemLedgerEntry.FindSet then begin
            _ItemLedgerEntry.CalcSums("Qty. to Ship");
            _SumQty := _ItemLedgerEntry."Qty. to Ship";
        end;


        _PostPurchRec.Reset;
        _PostPurchRec.SetRange("Document No.", "Document No.");
        _PostPurchRec.SetRange("Line No.", "Document Line No.");
        if _PostPurchRec.FindSet then begin
            _PostPurchRec."Qty. to Ship" := _SumQty + pQty;
            _PostPurchRec.Modify;
        end;
    end;
}

