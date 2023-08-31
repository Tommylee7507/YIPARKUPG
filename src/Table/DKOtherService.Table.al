table 50132 "DK_Other Service"
{
    // 
    // DK34: 20201111
    //   - Create

    Caption = 'Other Service';
    DrillDownPageID = "DK_Other Service List";
    LookupPageID = "DK_Other Service List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Other Service Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _OtherService: Record "DK_Other Service";
            begin
                TestField(Status, Status::Open);

                if Date <> xRec.Date then begin
                    _OtherService.Reset;
                    _OtherService.SetFilter("No.", '<>%1', Rec."No.");
                    _OtherService.SetRange(Date, Rec.Date);
                    if _OtherService.FindSet then
                        Error(MSG002);

                    UpdateLineData;
                end;
            end;
        }
        field(3; Title; Text[250])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(4; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;

            trigger OnValidate()
            begin

                if Status <> xRec.Status then
                    UpdateLineData;
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
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _OtherServiceLine: Record "DK_Other Service Line";
    begin
        TestField(Status, Status::Open);

        _OtherServiceLine.Reset;
        _OtherServiceLine.SetRange("Document No.", "No.");
        if _OtherServiceLine.FindSet then
            _OtherServiceLine.DeleteAll;
    end;

    trigger OnInsert()
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Other Service Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Other Service Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
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
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'No value in line.';
        MSG002: Label 'Document exists with same date.';


    procedure AssistEdit(OldOtherService: Record "DK_Other Service"): Boolean
    var
        _OtherService: Record "DK_Other Service";
    begin
        with _OtherService do begin
            _OtherService := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Other Service Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Other Service Nos.", OldOtherService."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _OtherService;
                exit(true);
            end;
        end;
    end;

    local procedure UpdateLineData()
    var
        _OtherServiceLine: Record "DK_Other Service Line";
    begin

        with _OtherServiceLine do begin
            Rec.Reset;
            SetRange("Document No.", "No.");
            if FindSet then
                repeat
                    Date := Rec.Date;
                    Status := Rec.Status;
                    Modify(true);
                until _OtherServiceLine.Next = 0;
        end;
    end;


    procedure SetReopen()
    begin

        if Status = Rec.Status::Open then
            exit;

        TestField("No.");
        TestField(Date);

        Validate(Status, Status::Open);
        Modify(true);
    end;


    procedure SetRelease()
    var
        _OtherServiceLine: Record "DK_Other Service Line";
    begin

        if Status = Rec.Status::Release then
            exit;

        TestField("No.");
        TestField(Date);

        if not CheckLineData then
            Error(MSG001);

        Validate(Status, Status::Release);
        Modify(true);
    end;


    procedure CheckLineData(): Boolean
    var
        _OtherServiceLine: Record "DK_Other Service Line";
    begin

        _OtherServiceLine.Reset;
        _OtherServiceLine.SetRange("Document No.", "No.");
        if _OtherServiceLine.FindSet then
            exit(true)
        else
            exit(false);
    end;
}

