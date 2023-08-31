table 50066 "DK_Work Manager"
{
    Caption = 'Work Manager';
    DrillDownPageID = "DK_Work Manager";
    LookupPageID = "DK_Work Manager";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdateWorkManager(Code,Name,xRec.Name);
            end;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
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

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    trigger OnModify()
    begin
        TestField(Code);
    end;

    var
        MSG001: Label 'You must select an existing %1.';

    procedure GetWorkManagerCode(pWorkMagText: Text): Text
    begin
        exit(GetWorkManagerName(pWorkMagText));
    end;

    procedure GetWorkManagerName(pWorkMagText: Text): Code[20]
    var
        _WorkMag: Record "DK_Work Manager";
        _WorkMagWithoutQuote: Text;
        _WorkMagFilterFromStart: Text;
        _WorkMagFilterContains: Text;
    begin
        if pWorkMagText = '' then
          exit('');

        if StrLen(pWorkMagText) <= MaxStrLen(_WorkMag.Code) then
          if _WorkMag.Get(CopyStr(pWorkMagText,1,MaxStrLen(_WorkMag.Code))) then
            exit(_WorkMag.Code);

        _WorkMag.SetRange(Blocked,false);
        _WorkMag.SetRange(Name,pWorkMagText);
        if _WorkMag.FindFirst then
          exit(_WorkMag.Code);

        _WorkMag.SetCurrentKey(Name);

        _WorkMagWithoutQuote := ConvertStr(pWorkMagText,'''','?');
        _WorkMag.SetFilter(Name,'''@' + _WorkMagWithoutQuote + '''');
        if _WorkMag.FindFirst then
          exit(_WorkMag.Code);
        _WorkMag.SetRange(Name);

        _WorkMagFilterFromStart := '''@' + _WorkMagWithoutQuote + '*''';

        _WorkMag.FilterGroup := -1;
        _WorkMag.SetFilter(Code,_WorkMagFilterFromStart);
        _WorkMag.SetFilter(Name,_WorkMagFilterFromStart);

        if _WorkMag.FindFirst then
          exit(_WorkMag.Code);

        _WorkMagFilterContains := '''@*' + _WorkMagWithoutQuote + '*''';

        _WorkMag.SetFilter(Code,_WorkMagFilterContains);
        _WorkMag.SetFilter(Name,_WorkMagFilterContains);

        if _WorkMag.Count = 1 then begin
          _WorkMag.FindFirst;
          exit(_WorkMag.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_WorkMag.TableCaption);

        Error(MSG001,_WorkMag.TableCaption);
    end;
}

