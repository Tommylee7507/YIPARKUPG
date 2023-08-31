table 50014 "DK_Vehicle Refue. Led. Entry"
{
    Caption = 'Vehicle Refueling Ledger Entry';
    DrillDownPageID = "DK_Vehicle Refueling Ledger";
    LookupPageID = "DK_Vehicle Refueling Ledger";

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
        field(3;"Oiling Date";Date)
        {
            Caption = 'Oiling Date';
            DataClassification = ToBeClassified;
        }
        field(4;"Oiling Machine";Text[20])
        {
            Caption = 'Oiling Machine';
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
        field(7;"Unit Price";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(8;Amount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(9;Liter;Decimal)
        {
            Caption = 'Liter';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(10;"Km Cumulative";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Km Cumulative';
            DataClassification = ToBeClassified;
        }
        field(11;"Km Difference";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Km Difference';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;Mileage;Decimal)
        {
            Caption = 'Mileage';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
            Editable = false;
        }
        field(13;Remarks;Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(14;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(19;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(20;"Vehicle No.";Text[30])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Vehicle."No." WHERE (Status=CONST(Confirmation));
            ValidateTableRelation = false;

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
        fieldgroup(DropDown;"Entry No.","Vehicle Document No.","Oiling Date","Employee Name",Amount,Liter)
        {
        }
    }

    trigger OnInsert()
    begin
        TestField("Vehicle Document No.");

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Vehicle Document No.");
    end;
}

