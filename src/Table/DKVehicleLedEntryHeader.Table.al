table 50031 "DK_Vehicle Led. Entry Header"
{
    Caption = 'Vehicle Ledger Enty Header';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Documnet Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Operation,Refueling,Repair,Wash';
            OptionMembers = Operation,Refueling,Repair,Wash;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Notice, false);

                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Vehicle Header Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Vehicle Document No."; Code[20])
        {
            Caption = 'Vehicle Document No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Vehicle."No." WHERE(Status = CONST(Confirmation),
                                                    Type = CONST(Vehicle));

            trigger OnValidate()
            var
                _Vehicle: Record DK_Vehicle;
            begin
                TestField(Notice, false);

                if _Vehicle.Get("Vehicle Document No.") then
                    "Vehicle No." := _Vehicle."Vehicle No."
                else
                    "Vehicle No." := '';
            end;
        }
        field(4; "Vehicle No."; Text[50])
        {
            Caption = 'Vehicle No.';
            TableRelation = DK_Vehicle."No." WHERE(Status = CONST(Confirmation),
                                                    Type = CONST(Vehicle));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Vehicle: Record DK_Vehicle;
            begin
                Validate("Vehicle Document No.", _Vehicle.GetVehicleNo("Vehicle No."));
            end;
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

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
        field(6; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Employee No.", Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(7; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Item."No." WHERE(Blocked = CONST(false));

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
        field(8; "Item Name"; Text[50])
        {
            Caption = 'Item Name';
            TableRelation = DK_Item."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Item: Record DK_Item;
            begin
                Validate("Item No.", _Item.GetItemNo("Item Name"));
            end;
        }
        field(9; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::Refueling then begin
                    CalcRefulingLiter;
                end;
            end;
        }
        field(10; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = Open;
            OptionCaption = 'Open,Complete';
            OptionMembers = Open,Complete;
        }
        field(1000; "Departure Date"; Date)
        {
            Caption = 'Departure Date';
            DataClassification = ToBeClassified;
        }
        field(1001; "Arrival Date"; Date)
        {
            Caption = 'Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(1002; "Departure Time"; Time)
        {
            Caption = 'Departure Time';
            DataClassification = ToBeClassified;
        }
        field(1003; "Arrival Time"; Time)
        {
            Caption = 'Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(1004; "Km Cumulative"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Km Cumulative';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Km Cumulative" <> xRec."Km Cumulative" then
                    Check_KmCumulative("Km Cumulative");
            end;
        }
        field(1005; "Km Difference"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Km Difference';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(1006; Mileage; Decimal)
        {
            BlankZero = true;
            Caption = 'Mileage';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 1;
            Editable = false;
        }
        field(2000; "Oiling Date"; Date)
        {
            Caption = 'Oiling Date';
            DataClassification = ToBeClassified;
        }
        field(2001; "Oiling Machine"; Text[20])
        {
            Caption = 'Oiling Machine';
            DataClassification = ToBeClassified;
        }
        field(2002; "Unit Price"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::Refueling then begin
                    CalcRefulingLiter;
                end;
            end;
        }
        field(2003; Liter; Decimal)
        {
            BlankZero = true;
            Caption = 'Liter';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(3000; "Repair Type"; Option)
        {
            Caption = 'Repair Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Breakdown,Repair';
            OptionMembers = Regular,Breakdown,Repair;
        }
        field(3001; Quantity; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(3002; "Repair Date"; Date)
        {
            Caption = 'Repair Date';
            DataClassification = ToBeClassified;
        }
        field(3003; "Repair Item"; Text[30])
        {
            Caption = 'Repair Item';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Repair Item" <> xRec."Repair Item" then begin
                    Quantity := 1;
                    if "Repair Item" = '' then
                        Quantity := 0;
                end;
            end;
        }
        field(3004; "Repair Item Type"; Option)
        {
            Caption = 'Repair Item Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Part,Expendables';
            OptionMembers = "Part",Expendables;
        }
        field(3005; "Alarm Division"; Option)
        {
            Caption = 'Alarm Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'Km,Date';
            OptionMembers = Km,Date;

            trigger OnValidate()
            begin
                if "Alarm Division" <> xRec."Alarm Division" then begin
                    "Alarm Date" := 0D;
                    "Alarm Km" := 0;
                end;
            end;
        }
        field(3006; "Alarm Date"; Date)
        {
            Caption = 'Alarm Date';
            DataClassification = ToBeClassified;
        }
        field(3007; "Alarm Km"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Alarm Km';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Alarm Km" <> xRec."Alarm Km" then
                    Check_KmCumulative("Alarm Km");
            end;
        }
        field(3008; Notice; Boolean)
        {
            Caption = 'Notice';
            DataClassification = ToBeClassified;
        }
        field(3009; "Recipient Type"; Option)
        {
            Caption = 'Recipient Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Department,Employee';
            OptionMembers = Department,Employee;

            trigger OnValidate()
            begin
                if "Recipient Type" <> xRec."Recipient Type" then begin
                    Validate("Recipient Code", '');
                end;
            end;
        }
        field(3010; "Recipient Code"; Code[20])
        {
            Caption = 'Recipient Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Recipient Type" = CONST(Department)) DK_Department.Code WHERE(Blocked = CONST(false))
            ELSE
            IF ("Recipient Type" = CONST(Employee)) DK_Employee."No." WHERE(Blocked = CONST(false));

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
        field(3011; "Recipient Name"; Text[30])
        {
            Caption = 'Recipient Name';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Recipient Type" = CONST(Department)) DK_Department.Code WHERE(Blocked = CONST(false))
            ELSE
            IF ("Recipient Type" = CONST(Employee)) DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
                _Employee: Record DK_Employee;
            begin
                if "Recipient Type" = "Recipient Type"::Department then
                    Validate("Recipient Code", _Department.GetDeptCode("Recipient Name"))
                else
                    Validate("Recipient Code", _Employee.GetEmployeeNo("Recipient Name"));
            end;
        }
        field(4000; "Wash Date"; Date)
        {
            Caption = 'Wash Date';
            DataClassification = ToBeClassified;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5004; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
        }
        key(Key3; "Vehicle Document No.")
        {
        }
        key(Key4; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Vehicle Header Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Vehicle Header Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        TestField("No.");

        //_DepartmentBoard.Check_EmployeeUserID(USERID);

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("No.");

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'This vehicle is in %1 condition and can not be used.';
        Employee: Record DK_Employee;
        MSG002: Label 'You can not enter a value smaller than the %2 of %1. Km cumulative : %3';
        MSG003: Label 'There is no content setting to send. Check %1.';


    procedure AssistEdit(OldVehicleLed: Record "DK_Vehicle Led. Entry Header"): Boolean
    var
        _VehicleLed: Record "DK_Vehicle Led. Entry Header";
    begin
        with _VehicleLed do begin
            _VehicleLed := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Vehicle Header Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Vehicle Header Nos.", OldVehicleLed."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _VehicleLed;
                exit(true);
            end;
        end;
    end;


    procedure CalcRefulingLiter()
    begin

        Liter := Amount / "Unit Price";
    end;


    procedure InsertAlarm()
    var
        _AlarmMgt: Codeunit "DK_Alarm Mgt.";
        _SMS: Record DK_SMS;
    begin
        TestField("Recipient Code");

        if "Alarm Division" = Rec."Alarm Division"::Date then
            TestField("Alarm Date")
        else
            TestField("Alarm Km");

        _SMS.Reset;
        _SMS.SetRange(Type, _SMS.Type::Vehicle);
        if not _SMS.FindFirst then
            Error(MSG003, _SMS.TableCaption);

        _AlarmMgt.InsertAlarm_Vehicle(Rec);
    end;


    procedure CancelAlarm()
    var
        _Alarm: Record DK_Alarm;
    begin
        _Alarm.Reset;
        _Alarm.SetRange("Source Type", _Alarm."Source Type"::Vehicle);
        _Alarm.SetRange("Source No.", "No.");
        _Alarm.SetRange("Source Line No.", 0);
        _Alarm.SetRange(Type, _Alarm.Type::Alarm);

        _Alarm.CalcFields("Sending Date");
        _Alarm.SetRange("Sending Date", 0D);
        if _Alarm.FindSet then
            _Alarm.DeleteAll;

        Notice := false;
    end;


    procedure Check_KmCumulative(pKm: Decimal)
    var
        _VehicleOperLedEntry: Record "DK_Vehicle Oper. Led. Entry";
    begin
        if "Vehicle Document No." = '' then
            exit;

        _VehicleOperLedEntry.Reset;
        _VehicleOperLedEntry.SetRange("Vehicle Document No.", "Vehicle Document No.");
        if _VehicleOperLedEntry.FindLast then begin
            if _VehicleOperLedEntry."Km Cumulative" > pKm then
                Error(MSG002, "Vehicle No.", _VehicleOperLedEntry.FieldCaption("Km Cumulative"), _VehicleOperLedEntry."Km Cumulative");
        end;
    end;
}

