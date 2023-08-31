table 50040 "DK_CRM External Sales"
{
    Caption = 'CRM External Sales';
    DrillDownPageID = "DK_CRM External Sales";
    LookupPageID = "DK_CRM External Sales";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3;"Sales Type";Option)
        {
            Caption = 'Sales Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Online,Funeral Hall,Funeral Service,Golf,Team Leader,Transfer,Life,Undefine-1,Undefine-2,Undefine-3';
            OptionMembers = " ",Online,"Funeral Hall","Funeral Service",Golf,"Team Leader",Transfer,Life,"Undefine-1","Undefine-2","Undefine-3";
        }
        field(4;Company;Text[50])
        {
            Caption = 'Company';
            DataClassification = ToBeClassified;
        }
        field(5;Contact;Text[20])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
        field(6;"E-Mail";Text[50])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(7;Remark;Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(8;"Bank Name";Text[10])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(9;"Bank Account No.";Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(10;Holder;Text[15])
        {
            Caption = 'Holder';
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
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _Contract: Record DK_Contract;
    begin
        _Contract.Reset;
        _Contract.SetRange("CRM External Sales Code", Code);
        if not _Contract.IsEmpty then
          Error(MSG001, TableCaption, Code, _Contract.TableCaption);
    end;

    trigger OnInsert()
    begin
        TestField(Code);
        TestField(Name);
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Name);
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
}

