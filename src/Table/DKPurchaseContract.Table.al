table 50011 "DK_Purchase Contract"
{
    Caption = 'Purchase Contract';
    DataCaptionFields = "No.", Title, "Contract Date", "Vendor Name";
    DrillDownPageID = "DK_Purchase Contract List";
    LookupPageID = "DK_Purchase Contract List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Purchase Contract Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Title; Text[50])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Hold);
            end;
        }
        field(3; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Hold);
            end;
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Vendor."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Vendor: Record DK_Vendor;
            begin
                TestField(Status, Status::Hold);

                if _Vendor.Get("Vendor No.") then
                    "Vendor Name" := _Vendor.Name
                else
                    "Vendor Name" := '';
            end;
        }
        field(5; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            TableRelation = DK_Vendor."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Vendor: Record DK_Vendor;
            begin
                TestField(Status, Status::Hold);

                Validate("Vendor No.", _Vendor.GetVendorNo("Vendor Name"));
            end;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Hold,Contract,Cancel,Expiration';
            OptionMembers = Hold,Contract,Cancel,Expiration;
        }
        field(7; Relation; Option)
        {
            Caption = 'Relation';
            DataClassification = ToBeClassified;
            OptionCaption = 'A,B';
            OptionMembers = A,B;

            trigger OnValidate()
            begin
                TestField(Status, Status::Hold);
            end;
        }
        field(8; Notice; Boolean)
        {
            Caption = 'Notice';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _AlarmMgt: Codeunit "DK_Alarm Mgt.";
            begin

                _AlarmMgt.InsertCancelAlarm_Purch(Rec);
            end;
        }
        field(9; "Automatic Extension"; Boolean)
        {
            Caption = 'Automatic Extension';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _AlarmMgt: Codeunit "DK_Alarm Mgt.";
            begin
                _AlarmMgt.InsertCancelExtension_Purch(Rec);
            end;
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Alarm Date"; Date)
        {
            Caption = 'Alarm Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Notice, false);
            end;
        }
        field(13; Contents; Text[250])
        {
            Caption = 'Alarm Contents';
            DataClassification = ToBeClassified;
        }
        field(14; "Recipient Type"; Option)
        {
            Caption = 'Recipient Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Department,Employee';
            OptionMembers = Department,Employee;

            trigger OnValidate()
            begin
                TestField(Notice, false);

                if "Recipient Type" <> xRec."Recipient Type" then begin
                    Validate("Recipient Code", '');
                end;
            end;
        }
        field(15; "Recipient Code"; Code[20])
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
                TestField(Notice, false);

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
        field(16; "Recipient Name"; Text[30])
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
        field(17; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));

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
        field(18; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code", _Department.GetDeptCode("Department Name"));
            end;
        }
        field(19; "Max Contract Date To"; Date)
        {
            CalcFormula = Max("DK_Purchase Contract Line"."Contract Date To" WHERE("Purchase Contract No." = FIELD("No.")));
            Caption = 'Max Contract Date To';
            Editable = false;
            FieldClass = FlowField;
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
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59000; idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Title)
        {
        }
        key(Key3; "Contract Date")
        {
        }
        key(Key4; Status)
        {
        }
        key(Key5; Relation)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Title, "Contract Date", Status, Relation)
        {
        }
    }

    trigger OnDelete()
    var
        _AttchedFiles: Record "DK_Attched Files";
        _PurchaseContLine: Record "DK_Purchase Contract Line";
        _PurchaseContractAuthority: Record "DK_Purchase Contract Authority";
    begin

        //>>DK_Purchase Contract Delete check
        TestField(Status, Status::Hold);

        Check_Vehicle;

        _PurchaseContLine.Reset;
        _PurchaseContLine.SetRange("Purchase Contract No.", "No.");
        if _PurchaseContLine.FindSet then
            _PurchaseContLine.DeleteAll;
        //<<DK_Purchase Contract Delete check

        _AttchedFiles.Reset;
        _AttchedFiles.SetRange("Table ID", DATABASE::"DK_Purchase Contract");
        _AttchedFiles.SetRange("Source No.", "No.");
        if _AttchedFiles.FindFirst then
            _AttchedFiles.DeleteAll;

        _PurchaseContractAuthority.Reset;
        _PurchaseContractAuthority.SetRange("Document No.", "No.");
        if _PurchaseContractAuthority.FindSet then
            _PurchaseContractAuthority.DeleteAll;
    end;

    trigger OnInsert()
    var
        _PurchaseContractAuthority: Codeunit "DK_Purchase Contract Authority";
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Purchase Contract Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Purchase Contract Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        //<<No

        _PurchaseContractAuthority.Insert_Authority(Rec);

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        //TESTFIELD("No.");


        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        //ERROR('');
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'There is no %1 entered.';
        MSG002: Label 'There are no %3 greater than the %1 %2.';
        MSG003: Label 'Do you want to change the Status of the %1?';
        MSG004: Label 'It is used by %1. %2';
        MSG005: Label 'It can not be modified in %1 Status.';
        MSG006: Label 'Data is generated from the %1.\Would you like to continue?';
        MSG007: Label 'The data created in the %1 is canceled.\Would you like to continue?';


    procedure AssistEdit("OldPurchase Contract": Record "DK_Purchase Contract"): Boolean
    var
        "_Purchase Contract": Record "DK_Purchase Contract";
    begin
        with "_Purchase Contract" do begin
            "_Purchase Contract" := Rec;
            FunctionSetup.Get;
            FunctionSetup.TestField("Purchase Contract Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Purchase Contract Nos.", "OldPurchase Contract"."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := "_Purchase Contract";
                exit(true);
            end;
        end;
    end;


    procedure SetOpen()
    begin
        Check_Vehicle;

        Status := Rec.Status::Hold;
        Modify;
    end;


    procedure SetContract()
    var
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
    begin

        Check_PurchContract;

        if _PurchaseContractLine.FindLast then begin
            if _PurchaseContractLine."Contract Date To" <= "Contract Date" then begin
                Error(MSG002, _PurchaseContractLine."Line No.", _PurchaseContractLine.FieldCaption("Contract Date To"));
            end;
        end;

        if not Confirm(MSG003, false, Status::Contract) then exit;

        Status := Rec.Status::Contract;
        Modify;
    end;


    procedure SetCanceled()
    begin

        Check_PurchContract;

        if not Confirm(MSG003, false, Status::Cancel) then exit;

        Status := Rec.Status::Cancel;
        Modify;
    end;


    procedure Check_PurchContract()
    var
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
    begin

        TestField(Title);
        TestField("Contract Date");
        TestField("Vendor No.");
        //TESTFIELD("Department Code");

        _PurchaseContractLine.Reset;
        _PurchaseContractLine.SetRange("Purchase Contract No.", "No.");
        if not _PurchaseContractLine.FindSet then begin
            Error(MSG001, _PurchaseContractLine.TableCaption);
        end;
    end;


    procedure Check_Vehicle()
    var
        _Vehicle: Record DK_Vehicle;
    begin

        _Vehicle.Reset;
        _Vehicle.SetRange("Purchase Contract No.", "No.");
        _Vehicle.SetFilter(Status, '<>%1', _Vehicle.Status::Confirmation);

        if _Vehicle.FindSet then
            Error(MSG004, _Vehicle.TableCaption, _Vehicle."No.");
    end;
}

