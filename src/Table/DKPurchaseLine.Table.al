table 50050 "DK_Purchase Line"
{
    Caption = 'Purchase Line';

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
            Editable = false;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Item."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Item: Record DK_Item;
            begin
                DuplicateLineCheck("Item No.");

                if xRec."Item No." <> "Item No." then begin

                    Quantity := 0;
                    "Unit Price" := 0;
                    Amount := 0;

                    if _Item.Get("Item No.") then begin
                        "Item Name" := _Item.Name;
                        "Item Main Cat. Code" := _Item."Item Main Cat. Code";
                        "Item Main Cat. Name" := _Item."Item Main Cat. Name";
                        "Item Sub Cat. Code" := _Item."Item Sub Cat. Code";
                        "Item Sub Cat. Name" := _Item."Item Sub Cat. Name";

                    end else begin
                        "Item Name" := '';
                        "Item Main Cat. Code" := '';
                        "Item Main Cat. Name" := '';
                        "Item Sub Cat. Code" := '';
                        "Item Sub Cat. Name" := '';
                    end;
                end;
            end;
        }
        field(4; "Item Name"; Text[50])
        {
            Caption = 'Item Name';
            Editable = false;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec.Quantity <> Quantity then
                    CalcAmount;
            end;
        }
        field(6; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                _RecShipHeader: Record "DK_Purchase Header";
            begin
                if xRec."Unit Price" <> "Unit Price" then begin
                    if "Unit Price" <> 0 then begin
                        CalcFields("Purchase Item");
                        if "Purchase Item" = "Purchase Item"::No then
                            Error(MSG001, FieldCaption("Purchase Item"), FieldCaption("Unit Price"));
                    end;

                    CalcAmount;
                end;
            end;
        }
        field(7; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Item Main Cat. Code"; Code[20])
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
        field(9; "Item Main Cat. Name"; Text[30])
        {
            Caption = 'Item Main Cat. Name';
            Editable = false;
        }
        field(10; "Item Sub Cat. Code"; Code[20])
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
        field(11; "Item Sub Cat. Name"; Text[30])
        {
            Caption = 'Item Sub Cat. Name';
            Editable = false;
        }
        field(12; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Vendor."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Vendor: Record DK_Vendor;
            begin
                if xRec."Vendor No." <> "Vendor No." then begin

                    if "Vendor No." <> '' then begin
                        CalcFields("Purchase Item");
                        if "Purchase Item" = "Purchase Item"::No then
                            Error(MSG001, FieldCaption("Purchase Item"), FieldCaption("Vendor No."));
                    end;

                    if _Vendor.Get("Vendor No.") then
                        "Vendor Name" := _Vendor.Name
                    else
                        "Vendor Name" := '';
                end;
            end;
        }
        field(13; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            TableRelation = DK_Vendor."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin

                if xRec."Vendor Name" <> "Vendor Name" then begin

                    if "Vendor Name" <> '' then begin
                        CalcFields("Purchase Item");
                        if "Purchase Item" = "Purchase Item"::No then
                            Error(MSG001, FieldCaption("Purchase Item"), FieldCaption("Vendor Name"));
                    end;

                    Validate("Vendor No.", Vendor.GetVendorNo("Vendor Name"));
                end;
            end;
        }
        field(14; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Location WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Location: Record DK_Location;
            begin
                if _Location.Get("Location Code") then
                    "Location Name" := _Location.Name;
            end;
        }
        field(15; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
            TableRelation = DK_Location WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Location Code", Location.GetLocationCode("Location Name"));
            end;
        }
        field(16; "Purchase Item"; Option)
        {
            CalcFormula = Lookup("DK_Purchase Header"."Purchase Item" WHERE("No." = FIELD("Document No.")));
            Caption = 'Purchase Item';
            FieldClass = FlowField;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            var
                _RecShipLine: Record "DK_Purchase Line";
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _Picture: Record DK_Picture;
    begin
        CheckHeaderStatus;

        _Picture.DeletePicture(DATABASE::"DK_Purchase Line", "Document No.", "Line No.");
    end;

    trigger OnInsert()
    var
        _RecShipHeader: Record "DK_Purchase Header";
    begin

        CheckHeaderStatus;
        HeaderDateModify();
    end;

    trigger OnModify()
    var
        _RecShipHeader: Record "DK_Purchase Header";
    begin
        CheckHeaderStatus;
        HeaderDateModify;
    end;

    var
        ItemMainCategory: Record "DK_Item Main Category";
        MSG001: Label 'It is not currently designated as a %1. %2 can not be specified.';
        ItemSubCategory: Record "DK_Item Sub Category";
        Location: Record DK_Location;
        Vendor: Record DK_Vendor;
        MSG002: Label 'The same% 1 exists.';


    procedure HeaderDateModify()
    var
        _PurchaseHeader: Record "DK_Purchase Header";
    begin

        _PurchaseHeader.Reset;
        _PurchaseHeader.SetRange("No.", "Document No.");
        if _PurchaseHeader.FindSet then begin
            _PurchaseHeader."Last Date Modified" := CurrentDateTime;
            _PurchaseHeader."Last Modified Person" := UserId;
            _PurchaseHeader.Modify;
        end;
    end;

    local procedure CalcAmount()
    begin
        if "Unit Price" = 0 then
            Amount := 0
        else
            Amount := Quantity * "Unit Price";
    end;

    local procedure CheckHeaderStatus()
    var
        _PurchaseHeader: Record "DK_Purchase Header";
    begin

        _PurchaseHeader.Get("Document No.");
        _PurchaseHeader.TestField(Status, _PurchaseHeader.Status::Open);
    end;

    local procedure DuplicateLineCheck("pItemNo.": Code[20])
    var
        _PurchaseLine: Record "DK_Purchase Line";
    begin

        _PurchaseLine.Reset;
        _PurchaseLine.SetRange("Document No.", "Document No.");
        if _PurchaseLine.FindSet then begin
            repeat
                if _PurchaseLine."Item No." = "pItemNo." then
                    Error(MSG002, "pItemNo.");
            until _PurchaseLine.Next = 0;
        end;
    end;
}

