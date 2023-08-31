table 50116 "DK_E-Sky Data"
{
    Caption = 'E-Sky Data';

    fields
    {
        field(1;"Base Year";Integer)
        {
            Caption = 'Base Year';
            DataClassification = ToBeClassified;
        }
        field(2;"Base Month";Option)
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
            OptionCaption = '1,2,3,4,5,6,7,8,9,10,11,12';
            OptionMembers = "1","2","3","4","5","6","7","8","9","10","11","12";
        }
        field(3;"Line No";Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(4;"E-Sequence";Integer)
        {
            Caption = 'E-Sequence';
            DataClassification = ToBeClassified;
        }
        field(5;"Company Name";Text[30])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
        }
        field(6;Type;Text[30])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(7;Nationality;Text[30])
        {
            Caption = 'Nationality';
            DataClassification = ToBeClassified;
        }
        field(8;Sex;Text[30])
        {
            Caption = 'Sex';
            DataClassification = ToBeClassified;
        }
        field(9;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(10;"Social Security No.";Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = ToBeClassified;
        }
        field(11;"Date of death";Date)
        {
            Caption = 'Date of death';
            DataClassification = ToBeClassified;
        }
        field(12;"Start Date";Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(13;"End Date";Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(14;Address;Text[200])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(15;"Post Code";Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(16;"Reg. Date";Date)
        {
            Caption = 'Reg. Date';
            DataClassification = ToBeClassified;
        }
        field(17;"Nationality 2";Text[30])
        {
            Caption = 'Nationality';
            DataClassification = ToBeClassified;
        }
        field(18;"Sex 2";Text[30])
        {
            Caption = 'Sex';
            DataClassification = ToBeClassified;
        }
        field(19;"Name 2";Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(20;"Birth Date";Date)
        {
            Caption = 'Birth Date';
            DataClassification = ToBeClassified;
        }
        field(21;Relation;Text[30])
        {
            Caption = 'Relation';
            DataClassification = ToBeClassified;
        }
        field(22;"Tel No.";Text[30])
        {
            Caption = 'Tel No.';
            DataClassification = ToBeClassified;
        }
        field(23;"Address 2";Text[200])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(24;"Post Code 2";Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(25;Remark;Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(26;"Upload Date";Date)
        {
            Caption = 'Upload Date';
            DataClassification = ToBeClassified;
        }
        field(100;Sequence;Integer)
        {
            Caption = 'Sequence';
            DataClassification = ToBeClassified;
        }
        field(101;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;
        }
        field(102;"Cemetery Code";Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
            end;
        }
        field(103;"Cemetery No.";Text[50])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
            end;
        }
        field(104;"Main Customer No.";Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
        }
        field(105;"Main Customer Name";Text[50])
        {
            Caption = 'Main Customer Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
            ValidateTableRelation = false;
        }
        field(106;"Cust. Social Security No.";Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Social Security No." WHERE ("No."=FIELD("Main Customer No.")));
            Caption = 'Customer Social Security No.';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(107;"Field Work Sub Cat. Code";Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category";

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
            end;
        }
        field(108;"Field Work Sub Cat. Name";Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
            end;
        }
        field(109;"Death Date";Date)
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;
        }
        field(110;"Laying Date";Date)
        {
            Caption = 'Laying Date';
            DataClassification = ToBeClassified;
        }
        field(111;"Name 3";Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(112;"Social Security No 2.";Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = ToBeClassified;
        }
        field(113;"Cemetery Dig. Code";Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Dig. Code" WHERE ("Cemetery Code"=FIELD("Cemetery Code")));
            Caption = 'Digits Code';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(114;"Cemetery Dig. Name";Code[20])
        {
            CalcFormula = Lookup("DK_Cemetery Digits".Name WHERE (Code=FIELD("Cemetery Dig. Code")));
            Caption = 'Digits Name';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(115;"Cemetery Conf. Code";Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Conf. Code" WHERE ("Cemetery Code"=FIELD("Cemetery Code")));
            Caption = 'Cemetery Conformation Code';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(116;"Cemetery Conf. Name";Code[20])
        {
            CalcFormula = Lookup("DK_Cemetery Conformation".Name WHERE (Code=FIELD("Cemetery Conf. Code")));
            Caption = 'Cemetery Conformation Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(117;"Date of death Text";Text[50])
        {
            Caption = 'Date of death';
            DataClassification = ToBeClassified;
        }
        field(200;"Style No.";Integer)
        {
            Caption = 'Style No.';
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
        key(Key1;"Base Year","Base Month","Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
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

    procedure SetStyle(): Text
    begin
        if "Style No." = 1 then
          exit('Standard')
        else if "Style No." = 2 then
          exit('StandardAccent')
        else if "Style No." = 3 then
          exit('Attention')
        else if "Style No." = 4 then
          exit('AttentionAccent')
        else if "Style No." = 5 then
          exit('Favorable')
        else if "Style No." = 6 then
          exit('Unfavorable')
        else if "Style No." = 7 then
          exit('Ambiguous')
        else if "Style No." = 8 then
          exit('Subordinate')
        else
          exit('');
    end;
}

