codeunit 50045 "DK_KPI Target Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'No data entered in line.';
        MSG002: Label 'Šˆ×Œ¡ ˆ±—Ñ Š¨‡õ —¸ˆ± Ž°„Ÿ„¾.';


    procedure InitKPITargetLine(pKPITarget: Record "DK_KPI Target")
    var
        _KPITargetLine: Record "DK_KPI Target Line";
        _FINDKPITargetLine: Record "DK_KPI Target Line";
        _ReportTargetValue: Record "DK_Report Target Value";
        _LineNo: Integer;
    begin

        with _KPITargetLine do begin
            _ReportTargetValue.Reset;
            _ReportTargetValue.SetRange("OBJECT ID", pKPITarget."OBJECT ID");
            _ReportTargetValue.SetRange(Blocked, false);
            if _ReportTargetValue.FindSet then begin
                repeat
                    Init;
                    "Document No." := pKPITarget."No.";
                    "OBJECT ID" := pKPITarget."OBJECT ID";
                    Validate("Report Taget Value Code", _ReportTargetValue.Code);
                    Month := 1;
                    Year := pKPITarget.Year;
                    Status := pKPITarget.Status;
                    Insert(true);
                until _ReportTargetValue.Next = 0;
            end else
                Error(MSG002);
        end;
    end;


    procedure SetRelease(var pKPITarget: Record "DK_KPI Target")
    begin

        with pKPITarget do begin
            TestField("No.");
            TestField("OBJECT ID");
            TestField(Year);

            CheckKPILineData(pKPITarget);

            Validate(Status, Status::Release);
            Modify(true);
        end;
    end;


    procedure SetReopen(pKPITarget: Record "DK_KPI Target")
    begin

        with pKPITarget do begin
            TestField("No.");
            TestField("OBJECT ID");
            TestField(Year);

            Validate(Status, Status::Open);
            Modify(true);
        end;
    end;

    local procedure CheckKPILineData(pKPITarget: Record "DK_KPI Target")
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin

        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("Document No.", pKPITarget."No.");
        if not _KPITargetLine.FindSet then
            Error(MSG001);
    end;
}

