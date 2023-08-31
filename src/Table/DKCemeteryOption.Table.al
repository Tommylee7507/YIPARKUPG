table 50003 "DK_Cemetery Option"
{
    Caption = 'Cemetery Option';
    DrillDownPageID = "DK_Cemetery Option";
    LookupPageID = "DK_Cemetery Option";

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
                  _ChangeMasterName.UpdateCemeteryOption(Code,Name,xRec.Name);
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
        _Cemetery.SetRange("Cemetery Option Code",Code);
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

    procedure GetCemeteryOptionCode(pCemeteryOptionText: Text): Text
    begin
        exit(GetCemeteryOptionCodeOpenCard(pCemeteryOptionText));
    end;

    procedure GetCemeteryOptionCodeOpenCard(pCemeteryOptionText: Text): Code[20]
    var
        _CemeteryOption: Record "DK_Cemetery Option";
        _CemeteryOptionCode: Code[20];
        _NoFiltersApplied: Boolean;
        _CemeteryOptionWithoutQuote: Text;
        _CemeteryOptionFilterFromStart: Text;
        _CemeteryOptionFilterContains: Text;
    begin
        if pCemeteryOptionText = '' then
          exit('');

        if StrLen(pCemeteryOptionText) <= MaxStrLen(_CemeteryOption.Code) then
          if _CemeteryOption.Get(CopyStr(pCemeteryOptionText,1,MaxStrLen(_CemeteryOption.Code))) then
            exit(_CemeteryOption.Code);

        _CemeteryOption.SetRange(Name,pCemeteryOptionText);
        if _CemeteryOption.FindFirst then
          exit(_CemeteryOption.Code);

        _CemeteryOption.SetCurrentKey(Name);

        _CemeteryOptionWithoutQuote := ConvertStr(pCemeteryOptionText,'''','?');
        _CemeteryOption.SetFilter(Name,'''@' + _CemeteryOptionWithoutQuote + '''');
        if _CemeteryOption.FindFirst then
          exit(_CemeteryOption.Code);

        _CemeteryOption.SetRange(Name);

        _CemeteryOptionFilterFromStart := '''@' + _CemeteryOptionWithoutQuote + '*''';

        _CemeteryOption.FilterGroup := -1;
        _CemeteryOption.SetFilter(Code,_CemeteryOptionFilterFromStart);
        _CemeteryOption.SetFilter(Name,_CemeteryOptionFilterFromStart);

        if _CemeteryOption.FindFirst then
          exit(_CemeteryOption.Code);

        _CemeteryOptionFilterContains := '''@*' + _CemeteryOptionWithoutQuote + '*''';

        _CemeteryOption.SetFilter(Code,_CemeteryOptionFilterContains);
        _CemeteryOption.SetFilter(Name,_CemeteryOptionFilterContains);

        if _CemeteryOption.Count = 1 then begin
          _CemeteryOption.FindFirst;
          exit(_CemeteryOption.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_CemeteryOption.TableCaption);


        Error(MSG001,_CemeteryOption.TableCaption);
    end;
}

