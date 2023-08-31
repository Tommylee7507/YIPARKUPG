table 50037 "DK_Vehicle Wash Led. Entry"
{
    Caption = 'Vehicle Wash Ledger Entry';

    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Vehicle Document No.";Code[20])
        {
            Caption = 'Vehicle Document No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Vehicle."No." WHERE (Status=CONST(Confirmation));

            trigger OnValidate()
            var
                _Vehicle: Record DK_Vehicle;
            begin
                if _Vehicle.Get("Vehicle Document No.") then
                  "Vehicle No." := _Vehicle."Vehicle No."
                else
                  "Vehicle No." := '';
            end;
        }
        field(3;"Wash Date";Date)
        {
            Caption = 'Wash Date';
            DataClassification = ToBeClassified;
        }
        field(4;Amount;Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(5;Remarks;Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(6;"Vehicle No.";Text[30])
        {
            Caption = 'Vehicle No.';
            TableRelation = DK_Vehicle."No." WHERE (Status=CONST(Confirmation));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Vehicle: Record DK_Vehicle;
            begin
                Validate("Vehicle Document No.",_Vehicle.GetVehicleNo("Vehicle No."));
            end;
        }
        field(7;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE (Blocked=CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                if _Employee.Get("Employee No.") then
                  "Employee Name" := _Employee.Name
                else
                  "Employee Name" := '';
            end;
        }
        field(8;"Employee Name";Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Employee No.",_Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(9;"Document No.";Code[20])
        {
            Caption = 'Document No.';
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
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

