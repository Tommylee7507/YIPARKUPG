table 50096 "DK_Purchase Contract Authority"
{
    Caption = 'Purchase Contract Authority';

    fields
    {
        field(1;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Department Code";Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department WHERE (Blocked=CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                if _Department.Get("Department Code") then
                  "Department Name" := _Department.Name
                else
                  "Department Name" := '';
            end;
        }
        field(4;"Department Name";Text[30])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code",_Department.GetDeptCode("Department Name"));
            end;
        }
        field(5;"First Creater";Boolean)
        {
            Caption = 'Creater';
            DataClassification = ToBeClassified;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(5001;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
        }
        field(5002;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
        }
        field(5003;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Department Code")
        {
        }
        key(Key3;"Department Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if "First Creater" then
          Error(MSG001);
    end;

    trigger OnInsert()
    begin

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        if "First Creater" then
          Error(MSG001);

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'You Can not moify or delete.';
}

