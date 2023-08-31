table 50002 "DK_Cemetery Conformation"
{
    Caption = 'Cemetery Conformation';
    DrillDownPageID = "DK_Cemetery Conformation";
    LookupPageID = "DK_Cemetery Conformation";

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

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdateCemeteryConformation(Code,Name,xRec.Name);
            end;
        }
    }

    keys
    {
        key(Key1;"Code")
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
        _Cemetery: Record DK_Cemetery;
        MSG001: Label 'The value is currently in use on %1 and can not be deleted.';
    begin

        // DK_Cemetery Delete check
        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery Conf. Code",Code);
        if _Cemetery.FindFirst then
          Error(MSG001,_Cemetery.TableCaption);
    end;

    trigger OnInsert()
    begin

        TestField(Code);
        TestField(Name);
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Name);
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'You must select an existing %1.';

    procedure GetCemeteryConfCode(pCemeteryConfText: Text): Text
    begin
        exit(GetCemeteryConfCodeOpenCard(pCemeteryConfText));
    end;

    procedure GetCemeteryConfCodeOpenCard(pCemeteryConfText: Text): Code[20]
    var
        _CemeteryConf: Record "DK_Cemetery Conformation";
        _CemeteryConfCode: Code[20];
        _NoFiltersApplied: Boolean;
        _CemeteryConfWithoutQuote: Text;
        _CemeteryConfFilterFromStart: Text;
        _CemeteryConfFilterContains: Text;
    begin
        if pCemeteryConfText = '' then
          exit('');

        if StrLen(pCemeteryConfText) <= MaxStrLen(_CemeteryConf.Code) then
          if _CemeteryConf.Get(CopyStr(pCemeteryConfText,1,MaxStrLen(_CemeteryConf.Code))) then
            exit(_CemeteryConf.Code);

        _CemeteryConf.SetRange(Name,pCemeteryConfText);
        if _CemeteryConf.FindFirst then
          exit(_CemeteryConf.Code);

        _CemeteryConf.SetCurrentKey(Name);

        _CemeteryConfWithoutQuote := ConvertStr(pCemeteryConfText,'''','?');
        _CemeteryConf.SetFilter(Name,'''@' + _CemeteryConfWithoutQuote + '''');
        if _CemeteryConf.FindFirst then
          exit(_CemeteryConf.Code);

        _CemeteryConf.SetRange(Name);

        _CemeteryConfFilterFromStart := '''@' + _CemeteryConfWithoutQuote + '*''';

        _CemeteryConf.FilterGroup := -1;
        _CemeteryConf.SetFilter(Code,_CemeteryConfFilterFromStart);
        _CemeteryConf.SetFilter(Name,_CemeteryConfFilterFromStart);

        if _CemeteryConf.FindFirst then
          exit(_CemeteryConf.Code);

        _CemeteryConfFilterContains := '''@*' + _CemeteryConfWithoutQuote + '*''';

        _CemeteryConf.SetFilter(Code,_CemeteryConfFilterContains);
        _CemeteryConf.SetFilter(Name,_CemeteryConfFilterContains);

        if _CemeteryConf.Count = 1 then begin
          _CemeteryConf.FindFirst;
          exit(_CemeteryConf.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_CemeteryConf.TableCaption);


        Error(MSG001,_CemeteryConf.TableCaption);
    end;
}

