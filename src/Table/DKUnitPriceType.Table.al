table 50005 "DK_Unit Price Type"
{
    Caption = 'Unit Price Type';
    DataCaptionFields = "Code",Name;
    DrillDownPageID = "DK_Unit Price Type";
    LookupPageID = "DK_Unit Price Type";

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
        _Cemetery.SetRange("Unit Price Type Code",Code);
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

    procedure GetUnitPriceTypeCode(pUnitPriceTypeText: Text): Text
    begin
        exit(GetUnitPriceTypeOpenCard(pUnitPriceTypeText));
    end;

    procedure GetUnitPriceTypeOpenCard(pUnitPriceTypeText: Text): Code[20]
    var
        _UnitPriceType: Record "DK_Unit Price Type";
        _UnitPriceTypeCode: Code[20];
        _NoFiltersApplied: Boolean;
        _UnitPriceTypeWithoutQuote: Text;
        _UnitPriceTypeFilterFromStart: Text;
        _UnitPriceTypeFilterContains: Text;
    begin
        if pUnitPriceTypeText = '' then
          exit('');

        if StrLen(pUnitPriceTypeText) <= MaxStrLen(_UnitPriceType.Code) then
          if _UnitPriceType.Get(CopyStr(pUnitPriceTypeText,1,MaxStrLen(_UnitPriceType.Code))) then
            exit(_UnitPriceType.Code);

        _UnitPriceType.SetRange(Name,pUnitPriceTypeText);
        if _UnitPriceType.FindFirst then
          exit(_UnitPriceType.Code);

        _UnitPriceType.SetCurrentKey(Name);

        _UnitPriceTypeWithoutQuote := ConvertStr(pUnitPriceTypeText,'''','?');
        _UnitPriceType.SetFilter(Name,'''@' + _UnitPriceTypeWithoutQuote + '''');
        if _UnitPriceType.FindFirst then
          exit(_UnitPriceType.Code);

        _UnitPriceType.SetRange(Name);

        _UnitPriceTypeFilterFromStart := '''@' + _UnitPriceTypeWithoutQuote + '*''';

        _UnitPriceType.FilterGroup := -1;
        _UnitPriceType.SetFilter(Code,_UnitPriceTypeFilterFromStart);
        _UnitPriceType.SetFilter(Name,_UnitPriceTypeFilterFromStart);

        if _UnitPriceType.FindFirst then
          exit(_UnitPriceType.Code);

        _UnitPriceTypeFilterContains := '''@*' + _UnitPriceTypeWithoutQuote + '*''';

        _UnitPriceType.SetFilter(Code,_UnitPriceTypeFilterContains);
        _UnitPriceType.SetFilter(Name,_UnitPriceTypeFilterContains);

        if _UnitPriceType.Count = 1 then begin
          _UnitPriceType.FindFirst;
          exit(_UnitPriceType.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_UnitPriceType.TableCaption);


        Error(MSG001,_UnitPriceType.TableCaption);
    end;
}

