table 50013 "DK_Vehicle Oper. Led. Entry"
{
    Caption = 'Vehicle Operation Ledger Entry';
    DrillDownPageID = "DK_Vehicle Operation Ledger";
    LookupPageID = "DK_Vehicle Operation Ledger";

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
        field(3;"Departure Date";Date)
        {
            Caption = 'Departure Time';
            DataClassification = ToBeClassified;
        }
        field(4;"Arrival Date";Date)
        {
            Caption = 'Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(5;"Employee No.";Code[20])
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
        field(6;"Employee Name";Text[50])
        {
            Caption = 'Employee Name';
            TableRelation = DK_Employee."No." WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Employee No.",_Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(7;"Km Cumulative";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Km Cumulative';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _VehicleOper: Record "DK_Vehicle Oper. Led. Entry";
                MSG001: Label 'There is no cumulative Km for that vehicle.';
            begin
            end;
        }
        field(8;"Km Difference";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Km Difference';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Creation Person";Code[50])
        {
            Caption = 'Cration Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;"Departure Time";Time)
        {
            Caption = 'Departure Time';
            DataClassification = ToBeClassified;
        }
        field(15;"Arrival Time";Time)
        {
            Caption = 'Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(16;Remarks;Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(17;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(18;"Vehicle No.";Text[30])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Vehicle: Record DK_Vehicle;
            begin
                Validate("Vehicle Document No.",_Vehicle.GetVehicleNo("Vehicle No."));
            end;
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
        fieldgroup(DropDown;"Entry No.","Vehicle Document No.","Departure Date","Arrival Date","Employee Name")
        {
        }
    }

    trigger OnInsert()
    begin
        //TESTFIELD("Vehicle No.");
        //TESTFIELD("Employee No.");

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    trigger OnModify()
    begin
        //TESTFIELD("Vehicle No.");
        //TESTFIELD("Employee No.");
    end;
}

