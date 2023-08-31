table 50113 "DK_Result Status"
{
    Caption = 'Result Status';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            Caption = '»—ý';
            DataClassification = ToBeClassified;
            OptionCaption = 'Virtual Account,SMS';
            OptionMembers = VA,SMS;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
        key(Key3; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    trigger OnInsert()
    begin
        TestField(Code);
        TestField(Name);
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Name);
    end;
}

