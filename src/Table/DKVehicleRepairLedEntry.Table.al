table 50015 "DK_Vehicle Repair Led. Entry"
{
    Caption = 'Vehicle Repair Ledger Entry';
    DrillDownPageID = "DK_Vehicle Repair Ledger";
    LookupPageID = "DK_Vehicle Repair Ledger";

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
        field(3;"Repair Date";Date)
        {
            Caption = 'Repair Date';
            DataClassification = ToBeClassified;
        }
        field(4;"Item No.";Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Item;

            trigger OnValidate()
            var
                _Item: Record DK_Item;
            begin
                if _Item.Get("Item No.") then
                  "Item Name" := _Item.Name
                else
                  "Item Name" := '';
            end;
        }
        field(5;"Item Name";Text[50])
        {
            CalcFormula = Lookup(DK_Item.Name WHERE ("No."=FIELD("Item No.")));
            Caption = 'Item Name';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _Item: Record DK_Item;
            begin
                Validate("Item No.",_Item.GetItemNo("Item Name"));
            end;
        }
        field(6;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Breakdown,Repair';
            OptionMembers = Regular,Breakdown,Repair;
        }
        field(7;Quantity;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(8;Amount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(9;Remarks;Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(10;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(11;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
        }
        field(14;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE (Blocked=CONST(false));

            trigger OnLookup()
            var
                _Employee: Record DK_Employee;
            begin
            end;

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
        field(15;"Employee Name";Text[50])
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
        field(16;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(17;"Vehicle No.";Text[30])
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
        field(18;"Repair Item";Text[30])
        {
            Caption = 'Repair Item';
            DataClassification = ToBeClassified;
        }
        field(19;"Repair Item Type";Option)
        {
            Caption = 'Repair Item Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Part,Expendables';
            OptionMembers = "Part",Expendables;
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

    trigger OnInsert()
    begin
        TestField("Vehicle Document No.");
        TestField("Item No.");

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Vehicle Document No.");
        TestField("Item No.");
    end;
}

