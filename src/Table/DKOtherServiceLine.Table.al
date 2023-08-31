table 50133 "DK_Other Service Line"
{
    Caption = 'Other Service Line';

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
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(5; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false),
                                                                      "Other Services" = CONST(true));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                GetHeaderData;

                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name
                else
                    "Field Work Main Cat. Name" := '';

                Validate("Field Work Sub Cat. Code", '');
                Quantity := 0;
                Amount := 0;
            end;
        }
        field(6; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false),
                                                                      "Other Services" = CONST(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", _FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(7; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin

                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                else
                    "Field Work Sub Cat. Name" := '';
            end;
        }
        field(8; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                Validate("Field Work Sub Cat. Code", _FieldWorkSubCategory.GetFieldWorkSCode("Field Work Sub Cat. Name", "Field Work Main Cat. Code"));
            end;
        }
        field(9; Quantity; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
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
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
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
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Field Work Main Cat. Code");
        TestField("Field Work Sub Cat. Code");
        TestField(Quantity);
        TestField(Amount);

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    local procedure GetHeaderData()
    var
        _OtherService: Record "DK_Other Service";
    begin

        _OtherService.Reset;
        _OtherService.SetRange("No.", "Document No.");
        if _OtherService.FindSet then begin
            Date := _OtherService.Date;
            Status := _OtherService.Status;
        end;
    end;
}

