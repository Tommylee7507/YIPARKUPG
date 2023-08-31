table 50107 "DK_Tree Type"
{
    Caption = 'Tree Type';
    DrillDownPageID = "DK_Tree Type";
    LookupPageID = "DK_Tree Type";

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
                  _ChangeMasterName.UpdateTreeType(Code,Name,xRec.Name);
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
        _Cemetery.SetRange("Tree Type Code",Code);
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

    var
        MSG001: Label 'You must select an existing %1.';

    procedure GetTreeTypeCode(pTreeTypeText: Text): Text
    begin
        exit(GetTreeTypeCodeOpenCard(pTreeTypeText));
    end;

    procedure GetTreeTypeCodeOpenCard(pTreeTypeText: Text): Code[20]
    var
        _TreeType: Record "DK_Tree Type";
        _TreeTypeCode: Code[20];
        _NoFiltersApplied: Boolean;
        _TreeTypeWithoutQuote: Text;
        _TreeTypeFilterFromStart: Text;
        _TreeTypeFilterContains: Text;
    begin
        if pTreeTypeText = '' then
          exit('');

        if StrLen(pTreeTypeText) <= MaxStrLen(_TreeType.Code) then
          if _TreeType.Get(CopyStr(pTreeTypeText,1,MaxStrLen(_TreeType.Code))) then
            exit(_TreeType.Code);

        _TreeType.SetRange(Name,pTreeTypeText);
        if _TreeType.FindFirst then
          exit(_TreeType.Code);

        _TreeType.SetCurrentKey(Name);

        _TreeTypeWithoutQuote := ConvertStr(pTreeTypeText,'''','?');
        _TreeType.SetFilter(Name,'''@' + _TreeTypeWithoutQuote + '''');
        if _TreeType.FindFirst then
          exit(_TreeType.Code);

        _TreeType.SetRange(Name);

        _TreeTypeFilterFromStart := '''@' + _TreeTypeWithoutQuote + '*''';

        _TreeType.FilterGroup := -1;
        _TreeType.SetFilter(Code,_TreeTypeFilterFromStart);
        _TreeType.SetFilter(Name,_TreeTypeFilterFromStart);

        if _TreeType.FindFirst then
          exit(_TreeType.Code);

        _TreeTypeFilterContains := '''@*' + _TreeTypeWithoutQuote + '*''';

        _TreeType.SetFilter(Code,_TreeTypeFilterContains);
        _TreeType.SetFilter(Name,_TreeTypeFilterContains);

        if _TreeType.Count = 1 then begin
          _TreeType.FindFirst;
          exit(_TreeType.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_TreeType.TableCaption);


        Error(MSG001,_TreeType.TableCaption);
    end;
}

