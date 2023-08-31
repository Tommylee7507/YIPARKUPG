table 50136 "DK_KPI Target"
{
    Caption = 'KPI Target';

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
                    NoSeriesMgt.TestManual(FunctionSetup."KPI Target Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "OBJECT ID"; Code[20])
        {
            Caption = 'OBJECT ID';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Report Target"."OBJECT ID" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _ReportTarget: Record "DK_Report Target";
                _KPITargetMgt: Codeunit "DK_KPI Target Mgt.";
            begin
                TestField(Status, Status::Open);
                CheckIdenticalDoc;

                if _ReportTarget.Get("OBJECT ID") then
                    "Report Taget Name" := _ReportTarget.Name
                else
                    "Report Taget Name" := '';

                _KPITargetMgt.InitKPITargetLine(Rec);
            end;
        }
        field(3; "Report Taget Name"; Text[50])
        {
            Caption = 'Report Taget Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Report Target"."OBJECT ID" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _ReportTarget: Record "DK_Report Target";
            begin
                Validate("OBJECT ID", _ReportTarget.GetReportTargetCode("Report Taget Name"));
            end;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
            MaxValue = 2999;
            MinValue = 1900;

            trigger OnValidate()
            begin
                if Year <> xRec.Year then begin
                    TestField(Status, Status::Open);
                    CheckIdenticalDoc;
                    UpdateLineData;
                end;
            end;
        }
        field(5; Title; Text[250])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(6; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; Status; Option)
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
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin
        TestField(Status, Status::Open);

        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("Document No.", "No.");
        if _KPITargetLine.FindSet then
            _KPITargetLine.DeleteAll;
    end;

    trigger OnInsert()
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("KPI Target Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."KPI Target Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
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

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'Document exists with the same %1.';


    procedure AssistEdit(OldKPITarget: Record "DK_KPI Target"): Boolean
    var
        _KPITarget: Record "DK_KPI Target";
    begin
        with _KPITarget do begin
            _KPITarget := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("KPI Target Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."KPI Target Nos.", OldKPITarget."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _KPITarget;
                exit(true);
            end;
        end;
    end;


    procedure CheckIdenticalDoc()
    var
        _KPITarget: Record "DK_KPI Target";
    begin

        if (Year <> 0) and ("OBJECT ID" <> '') then begin
            _KPITarget.Reset;
            _KPITarget.SetFilter("No.", '<>%1', "No.");
            _KPITarget.SetRange(Year, Year);
            _KPITarget.SetRange("OBJECT ID", "OBJECT ID");
            if _KPITarget.FindSet then
                Error(MSG001, _KPITarget.FieldCaption(Year));
        end;
    end;


    procedure UpdateLineData()
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin

        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("Document No.", "No.");
        if _KPITargetLine.FindSet then
            repeat
                _KPITargetLine.Year := Year;
                _KPITargetLine.Status := Rec.Status;
                _KPITargetLine.Modify(true);
            until _KPITargetLine.Next = 0;
    end;
}

