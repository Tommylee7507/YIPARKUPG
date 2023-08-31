table 50067 "DK_Work Group"
{
    Caption = 'Work Group';
    DrillDownPageID = "DK_Work Group";
    LookupPageID = "DK_Work Group";

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
                if (xRec.Name <> Name) and (Name <> '')then
                  _ChangeMasterName.UpdateWorkGroup(Code,Name,xRec.Name);
            end;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(4;"Cost Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
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

    procedure GetWorkGroupCode(pWorkGroupText: Text): Text
    begin
        exit(GetWorkGroupName(pWorkGroupText));
    end;

    procedure GetWorkGroupName(pWorkGroupText: Text): Code[20]
    var
        _WorkGroup: Record "DK_Work Group";
        _WorkGroupWithoutQuote: Text;
        _WorkGroupFilterFromStart: Text;
        _WorkGroupFilterContains: Text;
    begin
        if pWorkGroupText = '' then
          exit('');

        if StrLen(pWorkGroupText) <= MaxStrLen(_WorkGroup.Code) then
          if _WorkGroup.Get(CopyStr(pWorkGroupText,1,MaxStrLen(_WorkGroup.Code))) then
            exit(_WorkGroup.Code);

        _WorkGroup.SetRange(Blocked,false);
        _WorkGroup.SetRange(Name,pWorkGroupText);
        if _WorkGroup.FindFirst then
          exit(_WorkGroup.Code);

        _WorkGroup.SetCurrentKey(Name);

        _WorkGroupWithoutQuote := ConvertStr(pWorkGroupText,'''','?');
        _WorkGroup.SetFilter(Name,'''@' + _WorkGroupWithoutQuote + '''');
        if _WorkGroup.FindFirst then
          exit(_WorkGroup.Code);
        _WorkGroup.SetRange(Name);

        _WorkGroupFilterFromStart := '''@' + _WorkGroupWithoutQuote + '*''';

        _WorkGroup.FilterGroup := -1;
        _WorkGroup.SetFilter(Code,_WorkGroupFilterFromStart);
        _WorkGroup.SetFilter(Name,_WorkGroupFilterFromStart);

        if _WorkGroup.FindFirst then
          exit(_WorkGroup.Code);

        _WorkGroupFilterContains := '''@*' + _WorkGroupWithoutQuote + '*''';

        _WorkGroup.SetFilter(Code,_WorkGroupFilterContains);
        _WorkGroup.SetFilter(Name,_WorkGroupFilterContains);

        if _WorkGroup.Count = 1 then begin
          _WorkGroup.FindFirst;
          exit(_WorkGroup.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_WorkGroup.TableCaption);

        Error(MSG001,_WorkGroup.TableCaption);
    end;
}

