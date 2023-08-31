table 50077 "DK_Field Work Ledger Entry"
{
    Caption = 'Field Work Ledger Entry';
    DrillDownPageID = "DK_Field Work Ledger Entry";
    LookupPageID = "DK_Field Work Ledger Entry";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Estate,Cemetery';
            OptionMembers = Estate,Cemetery;
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
        field(6; "Estate Code"; Code[20])
        {
            Caption = 'Estate Code';
            DataClassification = ToBeClassified;
        }
        field(7; "Estate Name"; Text[30])
        {
            Caption = 'Estate Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
        }
        field(9; "Cemetery No."; Text[30])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Time From"; Time)
        {
            Caption = 'Time From';
            DataClassification = ToBeClassified;
        }
        field(11; "Time To"; Time)
        {
            Caption = 'Time To';
            DataClassification = ToBeClassified;
        }
        field(12; "Time Spent"; Text[30])
        {
            Caption = 'Time Spent';
            DataClassification = ToBeClassified;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(14; "Work Main Cat. Code"; Code[20])
        {
            Caption = 'Work Main Cat. Code';
            DataClassification = ToBeClassified;
        }
        field(15; "Work Main Cat. Name"; Text[30])
        {
            Caption = 'Work Main Cat. Name';
            DataClassification = ToBeClassified;
        }
        field(16; "Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Work Sub Cat. Code';
            DataClassification = ToBeClassified;
        }
        field(17; "Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Work Sub Cat. Name';
            DataClassification = ToBeClassified;
        }
        field(18; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            DataClassification = ToBeClassified;
        }
        field(19; "Work Group"; Text[30])
        {
            Caption = 'Work Group';
            DataClassification = ToBeClassified;
        }
        field(20; "Work Personnel"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Work Personnel';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(21; "Work Manager Code"; Code[20])
        {
            Caption = 'Work Manager Code';
            DataClassification = ToBeClassified;
        }
        field(22; "Work Manager"; Text[30])
        {
            Caption = 'Work Manager';
            DataClassification = ToBeClassified;
        }
        field(23; "Work Tiem Spent"; Integer)
        {
            Caption = 'Work Tiem Spent';
            DataClassification = ToBeClassified;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
    begin
        _FieldWorkLedgerEntry.SetCurrentKey("Entry No.");
        if _FieldWorkLedgerEntry.FindLast then
            exit(_FieldWorkLedgerEntry."Entry No." + 1);

        exit(1);
    end;
}

