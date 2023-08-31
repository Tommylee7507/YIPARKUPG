table 50058 "DK_Dev. Target Header"
{
    Caption = 'Development Target Header';
    DataCaptionFields = "No.", Description, "Dev. Date From", "Dev. Date To";
    DrillDownPageID = "DK_Dev. Target List";
    LookupPageID = "DK_Dev. Target List";

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
                    NoSeriesMgt.TestManual(FunctionSetup."Development Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Dev. Date From"; Date)
        {
            Caption = 'Deveploment Date (From)';
            DataClassification = ToBeClassified;
        }
        field(4; "Dev. Date To"; Date)
        {
            Caption = 'Deveploment Date (To)';
            DataClassification = ToBeClassified;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Released;
        }
        field(7; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then
                    "Employee Name" := Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(8; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Employee No.", Employee.GetEmployeeNo("Employee Name"));
            end;
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
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
        key(Key3; "Dev. Date From")
        {
        }
        key(Key4; "Dev. Date To")
        {
        }
        key(Key5; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _DevTargetLine: Record "DK_Dev. Target Line";
    begin
        TestField(Status, Status::Open);

        _DevTargetLine.Reset;
        _DevTargetLine.SetRange("Document No.", "No.");
        if _DevTargetLine.FindFirst then
            _DevTargetLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Development Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Development Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        TestField("No.");
        //<<No

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("No.");
        //<<No

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        FunctionSetup: Record "DK_Function Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record DK_Employee;


    procedure AssistEdit(OldDevTargetHdr: Record "DK_Dev. Target Header"): Boolean
    var
        _RecDevTargetHdr: Record "DK_Dev. Target Header";
    begin
        with _RecDevTargetHdr do begin
            _RecDevTargetHdr := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Development Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Development Nos.", OldDevTargetHdr."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _RecDevTargetHdr;
                exit(true);
            end;
        end;
    end;


    procedure SetReleased()
    begin
        Status := Rec.Status::Released;
        Modify;
    end;


    procedure SetReOpen()
    begin
        Status := Rec.Status::Open;
        Modify;
    end;
}

