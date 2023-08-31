table 50090 "DK_Selected Contract"
{
    // 
    // DK34: 20201029
    //   - Add Field: "Litigation Evaluation"
    // 
    // DK34: 20201207
    //   - Add Field: "Department Name"

    Caption = 'Selected Contract';

    fields
    {
        field(1;"USER ID";Code[50])
        {
            Caption = 'USER ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;

            trigger OnValidate()
            begin
                CalcFields("Allow Membership Printing", "Allow Mem. Printing DateTime", "Main Customer Name","Cemetery Size", "Litigation Employee Name");
            end;
        }
        field(3;"Cemetery Code";Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _ContractMgt: Codeunit "DK_Contract Mgt.";
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
                _UnitPrice: Decimal;
            begin
            end;
        }
        field(4;"Cemetery No.";Text[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Cust. Mobile No.";Text[30])
        {
            Caption = 'Customer Mobile No.';
            Editable = false;
        }
        field(6;"Allow Membership Printing";Boolean)
        {
            CalcFormula = Exist("DK_Customer Certficate History" WHERE ("Contract No."=FIELD("Contract No."),
                                                                        Apprval=CONST(true)));
            Caption = 'Allow Membership Printing';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7;"Allow Mem. Printing DateTime";DateTime)
        {
            CalcFormula = Lookup(DK_Contract."Allow Mem. Printing DateTime" WHERE ("No."=FIELD("Contract No.")));
            Caption = 'Allow Membership Printing Date/Time';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000;"Main Customer Name";Text[50])
        {
            CalcFormula = Lookup(DK_Contract."Main Customer Name" WHERE ("No."=FIELD("Contract No.")));
            Caption = 'Main Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001;"Cemetery Size";Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery.Size WHERE ("Cemetery Code"=FIELD("Cemetery Code")));
            Caption = 'Cemetery Size';
            DecimalPlaces = 0:2;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(1002;"Litigation Employee Name";Text[30])
        {
            CalcFormula = Lookup(DK_Contract."Litigation Employee Name" WHERE ("No."=FIELD("Contract No.")));
            Caption = 'Litigation Employee Name';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
            end;
        }
        field(1003;"Contact Name";Text[50])
        {
            Caption = 'Contact Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(1004;"Litigation Evaluation";Option)
        {
            CalcFormula = Lookup(DK_Contract."Litigation Evaluation" WHERE ("No."=FIELD("Contract No.")));
            Caption = 'Litigation Evaluation';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(1005;"Department Name";Text[50])
        {
            CalcFormula = Lookup(DK_Contract."Department Name" WHERE ("No."=FIELD("Contract No.")));
            Caption = 'Department Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"USER ID","Contract No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure SetFilterOnUser()
    begin
        FilterGroup(2);
        SetRange("USER ID",UserId);
        FilterGroup(0);
    end;
}

