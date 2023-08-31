table 50135 "DK_Report Target Value"
{
    // 
    // DK34: 20201113
    //   - Create

    Caption = 'Report Target Value';
    DrillDownPageID = "DK_Report Target Value";
    LookupPageID = "DK_Report Target Value";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3;"OBJECT ID";Code[20])
        {
            Caption = 'OBJECT ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Report Target"."OBJECT ID" WHERE (Blocked=CONST(false));
        }
        field(4;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(5;"Field Work Main Cat. Code";Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE (Blocked=CONST(false));
        }
        field(6;"Report Target Name";Text[50])
        {
            CalcFormula = Lookup("DK_Report Target".Name WHERE ("OBJECT ID"=FIELD("OBJECT ID")));
            Caption = 'Report Target Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"OBJECT ID","Code")
        {
            Clustered = true;
        }
        key(Key2;Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Name)
        {
        }
    }

    trigger OnDelete()
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin
        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("OBJECT ID","OBJECT ID");
        _KPITargetLine.SetRange("Report Taget Value Code",Code);
        _KPITargetLine.SetRange(Status,_KPITargetLine.Status::Open);
        if _KPITargetLine.FindSet then
          Error(MSG001,_KPITargetLine.TableCaption,_KPITargetLine.FieldCaption("Document No."),_KPITargetLine."Document No.");
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'Document being created exists in %1. Please delete it and try again. %2: %3';
        MSG002: Label 'You must select an existing %1.';

    procedure GetRepTargetValCode(pRepTargetValText: Text;pRepTargetCode: Code[20]): Text
    begin
        exit(GetRepTargetValName(pRepTargetValText,pRepTargetCode));
    end;

    procedure GetRepTargetValName(pRepTargetValText: Text;pRepTargetCode: Code[20]): Code[20]
    var
        _RepTargetVal: Record "DK_Report Target Value";
        _RepTargetValWithoutQuate: Text;
        _RepTargetValFilterFromStart: Text;
        _RepTargetValFilterContains: Text;
    begin
        if (pRepTargetValText = '') or
          (pRepTargetCode= '') then
          exit('');

        if StrLen(pRepTargetValText) <= MaxStrLen(_RepTargetVal.Code) then
          if _RepTargetVal.Get(CopyStr(pRepTargetValText,1,MaxStrLen(_RepTargetVal.Code))) then
            exit(_RepTargetVal.Code);

        _RepTargetVal.SetRange(Blocked,false);
        _RepTargetVal.SetRange("Field Work Main Cat. Code", pRepTargetCode);
        _RepTargetVal.SetRange(Name,pRepTargetValText);
        if _RepTargetVal.FindFirst then
          exit(_RepTargetVal.Code);

        _RepTargetVal.SetCurrentKey(Name);

        _RepTargetValWithoutQuate := ConvertStr(pRepTargetValText,'''','?');
        _RepTargetVal.SetFilter(Name,'''@' + _RepTargetValWithoutQuate + '''');
        if _RepTargetVal.FindFirst then
          exit(_RepTargetVal.Code);
        _RepTargetVal.SetRange(Name);

        _RepTargetValFilterFromStart := '''@' + _RepTargetValWithoutQuate + '*''';

        _RepTargetVal.SetRange("Field Work Main Cat. Code",pRepTargetCode);

        _RepTargetVal.FilterGroup := -1;
        _RepTargetVal.SetFilter(Code,_RepTargetValFilterFromStart);
        _RepTargetVal.SetFilter(Name,_RepTargetValFilterFromStart);

        if _RepTargetVal.FindFirst then
          exit(_RepTargetVal.Code);

        _RepTargetValFilterContains := '''@*' + _RepTargetValWithoutQuate + '*''';

        _RepTargetVal.SetRange("Field Work Main Cat. Code",pRepTargetCode);
        _RepTargetVal.SetFilter(Code, _RepTargetValFilterContains);
        _RepTargetVal.SetFilter(Name, _RepTargetValFilterContains);

        if _RepTargetVal.Count = 1 then begin
          _RepTargetVal.FindFirst;
          exit(_RepTargetVal.Code);
        end;

        if not GuiAllowed then
          Error(MSG002,_RepTargetVal.TableCaption);

        Error(MSG002,_RepTargetVal.TableCaption);
    end;
}

