table 50060 "DK_Upload Cemetery Buffer"
{
    Caption = 'Upload Cemetery Buffer';
    DrillDownPageID = "DK_Upload Cemetery";
    LookupPageID = "DK_Upload Cemetery";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
            end;
        }
        field(3; "Estate Name"; Text[50])
        {
            Caption = 'Estate Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Cemetery Conf. Name"; Text[50])
        {
            Caption = 'Cemetery Conformation Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Cemetery Option Name"; Text[50])
        {
            Caption = 'Cemetery Option Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Unit Price Type Name"; Text[50])
        {
            Caption = 'Unit Price Type Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Cemetery Dig. Name"; Text[50])
        {
            Caption = 'Digits Name';
            DataClassification = ToBeClassified;
        }
        field(9; Class; Option)
        {
            Caption = 'Class';
            DataClassification = ToBeClassified;
            OptionCaption = 'A,B,C,D';
            OptionMembers = A,B,C,D;
        }
        field(10; Size; Decimal)
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(11; "Size 2"; Decimal)
        {
            Caption = 'Size 2';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(12; "Corpse Size"; Decimal)
        {
            Caption = 'Corpse Size';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(13; "Landscape Architecture"; Boolean)
        {
            Caption = 'Landscape Architecture';
            DataClassification = ToBeClassified;
        }
        field(15; "Position Row"; Integer)
        {
            BlankZero = true;
            Caption = 'Position Row';
            DataClassification = ToBeClassified;
            MaxValue = 10;
            MinValue = 0;
        }
        field(16; "Position Column"; Integer)
        {
            BlankZero = true;
            Caption = 'Position Column';
            DataClassification = ToBeClassified;
            MaxValue = 500;
            MinValue = 0;
        }
        field(17; Stone; Boolean)
        {
            Caption = 'Stone';
            DataClassification = ToBeClassified;
        }
        field(18; "Tree Type Name"; Text[50])
        {
            Caption = 'Cemetery Option Name';
            DataClassification = ToBeClassified;
        }
        field(19; "Data Validation"; Option)
        {
            Caption = 'Data Validation';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Error,Normal';
            OptionMembers = Error,Normal;
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
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Cemetery No.")
        {
        }
        key(Key3; "Estate Name")
        {
        }
        key(Key4; "Cemetery Conf. Name")
        {
        }
        key(Key5; "Cemetery Option Name")
        {
        }
        key(Key6; "Unit Price Type Name")
        {
        }
        key(Key7; "Cemetery Dig. Name")
        {
        }
        key(Key8; Stone)
        {
        }
        key(Key9; "Data Validation")
        {
        }
        key(Key10; "Tree Type Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        _UploadCemeteryBuffer: Record "DK_Upload Cemetery Buffer";
    begin

        if "Entry No." = 0 then begin
            Rec."Entry No." := GetNextEntryNo;
        end;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        _UploadCemeteryBuffer: Record "DK_Upload Cemetery Buffer";
    begin
        _UploadCemeteryBuffer.SetCurrentKey("Entry No.");
        if _UploadCemeteryBuffer.FindLast then
            exit(_UploadCemeteryBuffer."Entry No." + 1);


        exit(1);
    end;
}

