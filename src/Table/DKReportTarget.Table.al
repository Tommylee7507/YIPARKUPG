table 50134 "DK_Report Target"
{
    // 
    // DK34: 20201112
    //   - Create

    Caption = 'Report Target';
    DrillDownPageID = "DK_Report Taget";
    LookupPageID = "DK_Report Taget";

    fields
    {
        field(1;"OBJECT ID";Code[20])
        {
            Caption = 'OBJECT ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _KPITargetLine: Record "DK_KPI Target Line";
            begin
                if "OBJECT ID" <> xRec."OBJECT ID" then
                  if "OBJECT ID" <> '' then begin
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID","OBJECT ID");
                    if _KPITargetLine.FindSet then
                      _KPITargetLine.ModifyAll("OBJECT ID","OBJECT ID");
                  end
            end;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"OBJECT ID")
        {
            Clustered = true;
        }
        key(Key2;Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"OBJECT ID",Name)
        {
        }
    }

    trigger OnDelete()
    var
        _ReportTargetValue: Record "DK_Report Target Value";
        _KPITarget: Record "DK_KPI Target";
    begin

        _KPITarget.Reset;
        _KPITarget.SetRange("OBJECT ID");
        _KPITarget.SetRange(Status,_KPITarget.Status::Open);
        if _KPITarget.FindSet then
          Error(MSG001);

        _ReportTargetValue.Reset;
        _ReportTargetValue.SetRange("OBJECT ID","OBJECT ID");
        if _ReportTargetValue.FindSet then
          _ReportTargetValue.DeleteAll;
    end;

    trigger OnRename()
    begin
        //ERROR('');
    end;

    var
        MSG001: Label 'Document being created exists in %1. Please delete it and try again. %2: %3';
        MSG002: Label 'You must select an existing %1.';

    procedure GetReportTargetCode(pReportTargetText: Text): Text
    begin
        exit(GetReportTargetName(pReportTargetText));
    end;

    procedure GetReportTargetName(pReportTargetText: Text): Code[20]
    var
        _ReportTarget: Record "DK_Report Target";
        _ReportTargetWithoutQuote: Text;
        _ReportTargetFilterFromStart: Text;
        _ReportTargetFilterContains: Text;
    begin
        if pReportTargetText = '' then
          exit('');

        if StrLen(pReportTargetText) <= MaxStrLen(_ReportTarget."OBJECT ID") then
          if _ReportTarget.Get(CopyStr(pReportTargetText,1,MaxStrLen(_ReportTarget."OBJECT ID"))) then
            exit(_ReportTarget."OBJECT ID");

        _ReportTarget.SetRange(Blocked,false);
        _ReportTarget.SetRange(Name,pReportTargetText);
        if _ReportTarget.FindFirst then
          exit(_ReportTarget."OBJECT ID");

        _ReportTarget.SetCurrentKey(Name);

        _ReportTargetWithoutQuote := ConvertStr(pReportTargetText,'''','?');
        _ReportTarget.SetFilter(Name,'''@' + _ReportTargetWithoutQuote + '''');
        if _ReportTarget.FindFirst then
          exit(_ReportTarget."OBJECT ID");
        _ReportTarget.SetRange(Name);

        _ReportTargetFilterFromStart := '''@' + _ReportTargetWithoutQuote + '*''';

        _ReportTarget.FilterGroup := -1;
        _ReportTarget.SetFilter("OBJECT ID",_ReportTargetFilterFromStart);
        _ReportTarget.SetFilter(Name,_ReportTargetFilterFromStart);

        if _ReportTarget.FindFirst then
          exit(_ReportTarget."OBJECT ID");

        _ReportTargetFilterContains := '''@*' + _ReportTargetWithoutQuote + '*''';

        _ReportTarget.SetFilter("OBJECT ID",_ReportTargetFilterContains);
        _ReportTarget.SetFilter(Name,_ReportTargetFilterContains);

        if _ReportTarget.Count = 1 then begin
          _ReportTarget.FindFirst;
          exit(_ReportTarget."OBJECT ID");
        end;

        if not GuiAllowed then
          Error(MSG002,_ReportTarget.TableCaption);

        Error(MSG002,_ReportTarget.TableCaption);
    end;
}

