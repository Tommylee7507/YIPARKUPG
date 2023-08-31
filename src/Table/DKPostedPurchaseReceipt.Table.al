table 50057 "DK_Posted Purchase Receipt"
{
    // 
    // DK34: 20201110
    //   - Add Field: "Item Type", "Total Inventory", "Total Shipment"

    Caption = 'Posted Purchase Receipt';
    DataCaptionFields = "Document No.", "Item Name";
    DrillDownPageID = "DK_Posted Item Receipt";
    LookupPageID = "DK_Posted Item Receipt";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
        }
        field(4; "Receipt Time"; Time)
        {
            Caption = 'Receipt Time';
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
        }
        field(5; "Purchase Item"; Option)
        {
            Caption = 'Purchase Item';
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            var
                _PurchaseLine: Record "DK_Purchase Line";
            begin
            end;
        }
        field(6; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec.Remarks <> xRec.Remarks then
                    ItemLedRemark(Remarks);
            end;
        }
        field(7; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Item."No.";

            trigger OnValidate()
            var
                _Item: Record DK_Item;
            begin
            end;
        }
        field(8; "Item Name"; Text[50])
        {
            Caption = 'Item Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Qty. to Receipt"; Decimal)
        {
            Caption = 'Qty. to Receipt';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
            MinValue = 0;
        }
        field(10; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                _RecShipHeader: Record "DK_Purchase Header";
            begin
            end;
        }
        field(11; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Item Main Cat. Code"; Code[20])
        {
            Caption = 'Item Main Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Item Main Category".Code;

            trigger OnValidate()
            var
                _ItemMainCategory: Record "DK_Item Main Category";
            begin
            end;
        }
        field(13; "Item Main Cat. Name"; Text[30])
        {
            Caption = 'Item Main Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Item Sub Cat. Code"; Code[20])
        {
            Caption = 'Item Sub Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Item Sub Category".Code WHERE("Item Main Cat. Code" = FIELD("Item Main Cat. Code"));

            trigger OnValidate()
            var
                _ItemSubCategory: Record "DK_Item Sub Category";
            begin
            end;
        }
        field(15; "Item Sub Cat. Name"; Text[30])
        {
            Caption = 'Item Sub Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Vendor."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Vendor: Record DK_Vendor;
            begin
            end;
        }
        field(17; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(18; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(19; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
            Editable = false;
            TableRelation = DK_Location.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Location Code", Location.GetLocationCode("Location Name"));
            end;
        }
        field(20; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                if Rec."Qty. to Ship" <> xRec."Qty. to Ship" then begin
                    CalcFields(Inventory);
                    if "Qty. to Ship" > Inventory then
                        Error(MSG003, FieldCaption(Inventory));

                    ItemLedQtytoShip("Qty. to Ship");

                    if "Qty. to Ship" <> 0 then
                        Untreated := true
                    else
                        Untreated := false;
                end;
            end;
        }
        field(22; "Qty. Shipped"; Decimal)
        {
            CalcFormula = Sum("DK_Item Ledger Entry".Quantity WHERE("Source No." = FIELD("Document No."),
                                                                     "Source Line No." = FIELD("Line No."),
                                                                     "Entry Type" = CONST(Shipment)));
            Caption = 'Qty. Shipped';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; Inventory; Decimal)
        {
            CalcFormula = Sum("DK_Item Ledger Entry".Quantity WHERE("Source No." = FIELD("Document No."),
                                                                     "Source Line No." = FIELD("Line No.")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Shipment Type Code"; Code[20])
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
        field(25; "Shipment Type"; Text[50])
        {
            Caption = 'Shipment Type';
            TableRelation = "DK_Shipment Type".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Shipment Type Code", ShipmentType.GetShipmentTypeCode("Shipment Type"));
            end;
        }
        field(26; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = ToBeClassified;
        }
        field(27; "Working Group Code"; Code[20])
        {
            Caption = 'Working Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkGroup: Record "DK_Work Group";
            begin
                if _WorkGroup.Get("Working Group Code") then
                    "Working Group" := _WorkGroup.Name
                else
                    "Working Group" := '';
            end;
        }
        field(28; "Working Group"; Text[50])
        {
            Caption = 'Working Group';
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Working Group Code", WorkGroup.GetWorkGroupCode("Working Group"));
            end;
        }
        field(29; "Cemetry No."; Text[30])
        {
            Caption = 'Cemetry No.';
            DataClassification = ToBeClassified;
        }
        field(31; Reverse; Boolean)
        {
            Caption = 'Reverse';
            DataClassification = ToBeClassified;
        }
        field(32; "Use Area"; Text[30])
        {
            Caption = 'Use Area';
            DataClassification = ToBeClassified;
        }
        field(33; "GroupWare Doc. No."; Code[30])
        {
            Caption = 'GroupWare Doc. No.';
            DataClassification = ToBeClassified;
        }
        field(34; "Employee No."; Code[20])
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
        field(35; Employee; Text[30])
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
        field(36; Untreated; Boolean)
        {
            Caption = 'Untreated';
        }
        field(37; "Last Shipment Date"; Date)
        {
            CalcFormula = Max("DK_Item Ledger Entry".Date WHERE("Source No." = FIELD("Document No."),
                                                                 "Source Line No." = FIELD("Line No."),
                                                                 "Entry Type" = CONST(Shipment)));
            Caption = 'Last Shipment Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(200; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            Editable = false;
            OptionCaption = 'Consumable,Assets';
            OptionMembers = Consumable,Assets;
        }
        field(201; "Total Shipment"; Decimal)
        {
            CalcFormula = Sum("DK_Item Ledger Entry".Quantity WHERE("Entry Type" = CONST(Shipment),
                                                                     "Item No." = FIELD("Item No.")));
            Caption = 'Total Shipment Count';
            Description = 'DK34';
            Editable = false;
            FieldClass = FlowField;
        }
        field(202; "Total Inventory"; Decimal)
        {
            CalcFormula = Sum("DK_Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No.")));
            Caption = 'Total Inventory Count';
            Description = 'DK34';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Line No.")
        {
        }
        key(Key3; "Item No.")
        {
        }
        key(Key4; "Item Name")
        {
        }
        key(Key5; "Qty. to Receipt")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    var
        MSG001: Label 'Can not shipment because there is no %1.';
        MSG002: Label 'If there is no %1, it can not be modified.';
        MSG003: Label 'Numbers greater than the %1 can not be entered.';
        Location: Record DK_Location;
        ShipmentType: Record "DK_Shipment Type";
        WorkGroup: Record "DK_Work Group";


    procedure setPost(): Boolean
    var
        _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
    begin

        if _PurchaseItemPost.PostShip(Rec) then
            exit(true);
    end;


    procedure ItemLedQtytoShip(pPQty: Decimal)
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetCurrentKey("Entry No.");
        _ItemLedgerEntry.SetRange("Document No.", "Document No.");
        _ItemLedgerEntry.SetRange("Document Line No.", "Line No.");
        if _ItemLedgerEntry.FindSet then begin
            repeat
                if pPQty = 0 then begin
                    _ItemLedgerEntry."Qty. to Ship" := 0;
                    _ItemLedgerEntry.Modify;
                end else begin
                    _ItemLedgerEntry.CalcFields(Inventory);
                    if _ItemLedgerEntry.Inventory <> 0 then begin
                        if _ItemLedgerEntry.Inventory >= pPQty then begin
                            _ItemLedgerEntry."Qty. to Ship" := pPQty;
                        end else begin
                            _ItemLedgerEntry."Qty. to Ship" := _ItemLedgerEntry.Inventory;
                        end;
                        _ItemLedgerEntry.Modify;
                        pPQty -= _ItemLedgerEntry."Qty. to Ship";
                    end;
                end;
            until _ItemLedgerEntry.Next = 0;
        end;
    end;


    procedure ItemLedRemark(pRemark: Text)
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetCurrentKey("Entry No.");
        _ItemLedgerEntry.SetRange("Document No.", "Document No.");
        _ItemLedgerEntry.SetRange("Document Line No.", "Line No.");
        if _ItemLedgerEntry.FindSet then begin
            repeat
                if pRemark = '' then begin
                    _ItemLedgerEntry.Remarks := '';
                    _ItemLedgerEntry.Modify
                end else begin
                    _ItemLedgerEntry.Remarks := pRemark;
                    _ItemLedgerEntry.Modify;
                end;
            until _ItemLedgerEntry.Next = 0;
        end;
    end;
}

