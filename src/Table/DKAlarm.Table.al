table 50104 DK_Alarm
{
    Caption = 'Alarm';
    DrillDownPageID = "DK_Alarm List";
    LookupPageID = "DK_Alarm List";

    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("Sending Date","Sending Time");
            end;
        }
        field(2;"Source Type";Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Vehicle,Purchase Contract';
            OptionMembers = Vehicle,PurchaseContract;
        }
        field(3;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(4;"Source Line No.";Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(5;"Vehicle Document No.";Code[20])
        {
            Caption = 'Vehicle Document No.';
            DataClassification = ToBeClassified;

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
        field(6;"Vehicle No.";Text[30])
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
        field(7;Subject;Text[50])
        {
            Caption = 'Subject';
            DataClassification = ToBeClassified;
        }
        field(8;Contents;Text[250])
        {
            Caption = 'Contents';
            DataClassification = ToBeClassified;
        }
        field(9;"Alarm Date";Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(10;"Recipient Type";Option)
        {
            Caption = 'Recipient Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Department,Employee';
            OptionMembers = Department,Employee;
        }
        field(11;"Recipient Code";Code[20])
        {
            Caption = 'Recipient Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Recipient Type"=CONST(Department)) DK_Department.Code WHERE (Blocked=CONST(false))
                            ELSE IF ("Recipient Type"=CONST(Employee)) DK_Employee."No." WHERE (Blocked=CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
                _Employee: Record DK_Employee;
            begin
                if "Recipient Type" = "Recipient Type"::Department then begin
                  if _Department.Get("Recipient Code") then
                    "Recipient Name" := _Department.Name
                  else
                    "Recipient Name" := '';
                end else begin
                  if _Employee.Get("Recipient Code") then
                    "Recipient Name" := _Employee.Name
                  else
                    "Recipient Name" := '';
                end;
            end;
        }
        field(12;"Recipient Name";Text[30])
        {
            Caption = 'Recipient Name';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Recipient Type"=CONST(Department)) DK_Department.Code WHERE (Blocked=CONST(false))
                            ELSE IF ("Recipient Type"=CONST(Employee)) DK_Employee."No." WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
                _Employee: Record DK_Employee;
            begin
                if "Recipient Type" = "Recipient Type"::Department then
                  Validate("Recipient Code",_Department.GetDeptCode("Recipient Name"))
                else
                  Validate("Recipient Code",_Employee.GetEmployeeNo("Recipient Name"));
            end;
        }
        field(13;Division;Option)
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'Km,Date';
            OptionMembers = Km,Date;
        }
        field(15;"Sending Date";Date)
        {
            CalcFormula = Lookup("DK_Sended SMS History"."Sending Date" WHERE ("Source No."=CONST(''),
                                                                               "Source Line No."=FIELD("Entry No.")));
            Caption = 'Sending Date';
            FieldClass = FlowField;
        }
        field(16;"Sending Time";Time)
        {
            CalcFormula = Lookup("DK_Sended SMS History"."Sending Time" WHERE ("Source No."=CONST(''),
                                                                               "Source Line No."=FIELD("Entry No.")));
            Caption = 'Sending Time';
            FieldClass = FlowField;
        }
        field(17;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Alarm,Extension';
            OptionMembers = Alarm,Extension;
        }
        field(18;"Alarm Km";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Alarm Km';
            DataClassification = ToBeClassified;
            MinValue = 0;
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
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CalcFields("Sending Date");
        TestField("Sending Date",0D);
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
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;
}

