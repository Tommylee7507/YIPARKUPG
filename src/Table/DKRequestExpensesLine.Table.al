table 50056 "DK_Request Expenses Line"
{
    Caption = 'Request Expenses Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Ddocument Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Vendor';
            OptionMembers = Employee,Vendor;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Item."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Item: Record DK_Item;
            begin
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
        field(5; "Item Name"; Text[50])
        {
            Caption = 'Item Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if xRec.Quantity <> Rec.Quantity then begin
                    CalcAmount;
                end;
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Unit Price" <> Rec."Unit Price" then begin
                    CalcAmount;
                end;
            end;
        }
        field(8; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(9; "Item Main Cat. Code"; Code[20])
        {
            Caption = 'Item Main Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Item Main Cat. Name"; Text[30])
        {
            Caption = 'Item Main Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Item Sub Cat. Code"; Code[20])
        {
            Caption = 'Item Sub Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Item Sub Cat. Name"; Text[30])
        {
            Caption = 'Item Sub Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; StandardSize; Text[30])
        {
            Caption = 'StandardSize';
            DataClassification = ToBeClassified;
        }
        field(14; Purpose; Text[50])
        {
            Caption = 'Purpose';
            DataClassification = ToBeClassified;
        }
        field(15; "Purchased Item"; Text[50])
        {
            Caption = 'Purchased Item';
            DataClassification = ToBeClassified;
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
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _Picture: Record DK_Picture;
    begin

        CheckHeaderStatus;
        HeaderDateModify;

        _Picture.DeletePicture(DATABASE::"DK_Request Expenses Line", "Document No.", "Line No.");
    end;

    trigger OnInsert()
    begin

        CheckHeaderStatus;
        HeaderDateModify;
    end;

    trigger OnModify()
    begin

        CheckHeaderStatus;
        HeaderDateModify;
    end;

    local procedure CalcAmount()
    begin
        if "Unit Price" = 0 then
            Amount := 0
        else
            Amount := Quantity * "Unit Price";
    end;


    procedure HeaderDateModify()
    var
        _RequExpHeader: Record "DK_Request Expenses Header";
    begin

        _RequExpHeader.Reset;
        _RequExpHeader.SetRange("No.", "Document No.");
        if _RequExpHeader.FindSet then begin
            _RequExpHeader."Last Date Modified" := CurrentDateTime;
            _RequExpHeader."Last Modified Person" := UserId;
            _RequExpHeader.Modify;
        end;
    end;

    local procedure CheckHeaderStatus()
    var
        _ReqExpHeader: Record "DK_Request Expenses Header";
    begin

        _ReqExpHeader.Get("Document No.");
        _ReqExpHeader.TestField(Status, _ReqExpHeader.Status::Open);
    end;
}

