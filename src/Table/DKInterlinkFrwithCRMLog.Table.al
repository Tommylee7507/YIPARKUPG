table 50139 "DK_Interlink Fr. with CRM Log"
{
    Caption = 'Interlink Fr. with CRM Log';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Data Type"; Option)
        {
            Caption = 'Data Type';
            DataClassification = ToBeClassified;
            InitValue = Inbound;
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
        }
        field(3; "Data Date"; Date)
        {
            Caption = 'Data Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Relation No."; Code[20])
        {
            Caption = 'Relation No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(7; Relation; Text[30])
        {
            Caption = 'Relation';
            DataClassification = ToBeClassified;
        }
        field(8; "Record Del"; Boolean)
        {
            Caption = 'Record Del';
            DataClassification = ToBeClassified;
        }
        field(9; "Applied Date"; Date)
        {
            Caption = 'Applied Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Line No"; Integer)
        {
            Caption = 'Line No';
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
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;

        "Data Date" := Today;
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    local procedure GetNextEntryNo(): BigInteger
    var
        _InterlinkFrwithCRMLog: Record "DK_Interlink Fr. with CRM Log";
    begin
        _InterlinkFrwithCRMLog.SetCurrentKey("Entry No.");
        if _InterlinkFrwithCRMLog.FindLast then
            exit(_InterlinkFrwithCRMLog."Entry No." + 1);

        exit(1);
    end;
}

