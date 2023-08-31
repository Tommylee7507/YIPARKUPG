table 50036 "DK_Land. Arch. Picture"
{
    Caption = 'Landscape Architecture Picture';
    DataCaptionFields = "Contract No.", "Supervise No.", "Cemetery No.";
    DrillDownPageID = "DK_Land. Arch. Picture";
    LookupPageID = "DK_Land. Arch. Picture";

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery;

            trigger OnValidate()
            begin
                CalcFields("Cemetery No.");
            end;
        }
        field(5; "Cemetery No."; Text[50])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(8; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Upload Date"; Date)
        {
            Caption = 'Upload Date';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Contract No.", "Line No.")
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

        _Picture.DeletePicture(DATABASE::"DK_Land. Arch. Picture", "Contract No.", "Line No.");
    end;

    trigger OnInsert()
    begin
        "Upload Date" := Today;

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


    procedure DeletePicture(pTableID: Integer; pSourceNo: Code[10]; pSourceLineNo: Integer)
    var
        _Picture: Record DK_Picture;
    begin

        _Picture.Reset;
        _Picture.SetRange("Table ID", pTableID);
        _Picture.SetRange("Source No.", pSourceNo);
        if pSourceLineNo <> 0 then
            _Picture.SetRange("Source Line No.", pSourceLineNo);
        if _Picture.FindFirst then
            _Picture.DeleteAll;
    end;
}

