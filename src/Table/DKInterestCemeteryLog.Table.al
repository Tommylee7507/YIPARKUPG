table 50038 "DK_Interest Cemetery Log"
{
    Caption = 'Interest Cemetery Log';
    DrillDownPageID = 50050;
    LookupPageID = 50050;

    fields
    {
        field(1;"Cemetery Code";Code[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code";

            trigger OnValidate()
            begin
                CalcFields("Line No.");
            end;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3;"Cemetery No.";Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE ("Cemetery Code"=FIELD("Cemetery Code")));
            Caption = 'Cemetery Description';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
            end;
        }
        field(4;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No.";

            trigger OnValidate()
            begin
                CalcFields("Employee Name");
            end;
        }
        field(5;"Employee Name";Text[50])
        {
            CalcFormula = Lookup(DK_Employee.Name WHERE ("No."=FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Interest DateTime";DateTime)
        {
            Caption = 'Interest Date/Time';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Cemetery Code","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Employee No.")
        {
        }
        key(Key3;"Interest DateTime")
        {
        }
    }

    fieldgroups
    {
    }
}

