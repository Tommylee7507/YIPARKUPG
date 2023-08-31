table 50042 "DK_CRM Funeral Service"
{
    Caption = 'CRM Funeral Service';
    DrillDownPageID = "DK_CRM Funeral Service";
    LookupPageID = "DK_CRM Funeral Service";

    fields
    {
        field(1;"No.";Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.",Name)
        {
        }
    }

    trigger OnDelete()
    var
        _Contract: Record DK_Contract;
    begin
        _Contract.Reset;
        _Contract.SetRange("CRM Funeral Service Code", "No.");
        if not _Contract.IsEmpty then
          Error(MSG001, TableCaption, "No.", _Contract.TableCaption);
    end;

    trigger OnInsert()
    begin
        TestField("No.");
        TestField(Name);
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("No.");
        TestField(Name);
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
}

