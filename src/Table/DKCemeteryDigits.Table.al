table 50006 "DK_Cemetery Digits"
{
    Caption = 'Cemetery Digits';
    DataCaptionFields = "Code",Name;
    DrillDownPageID = "DK_Cemetery Digits";
    LookupPageID = "DK_Cemetery Digits";

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
        field(3;"Cemetery Conf. Code";Code[20])
        {
            Caption = 'Cemetery Conformation Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Cemetery Conformation";

            trigger OnValidate()
            begin
                CalcFields("Cemetery Conf. Name");
            end;
        }
        field(4;"Cemetery Conf. Name";Text[50])
        {
            CalcFormula = Lookup("DK_Cemetery Conformation".Name WHERE (Code=FIELD("Cemetery Conf. Code")));
            Caption = 'Cemetery Conformation Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Cemetery Conf. Code","Code")
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
        _Cemetery.SetRange("Cemetery Dig. Code",Code);
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
        //ERROR('');
    end;

    var
        MSG001: Label 'You must select an existing %1.';

    procedure GetCemeteryDigitsCode(pCemeteryConfCode: Code[20];pCemeteryDigitsText: Text): Text
    begin
        exit(GetCemeteryDigitsCodeOpenCard(pCemeteryConfCode, pCemeteryDigitsText));
    end;

    procedure GetCemeteryDigitsCodeOpenCard(pCemeteryConfCode: Code[20];pCemeteryDigitsText: Text): Code[20]
    var
        _CemeteryDigits: Record "DK_Cemetery Digits";
        _CemeteryDigitsCode: Code[20];
        _NoFiltersApplied: Boolean;
        _CemeteryDigitsWithoutQuote: Text;
        _CemeteryDigitsFilterFromStart: Text;
        _CemeteryDigitsFilterContains: Text;
    begin
        if pCemeteryDigitsText = '' then
          exit('');

        if StrLen(pCemeteryDigitsText) <= MaxStrLen(_CemeteryDigits.Code) then
          if _CemeteryDigits.Get(pCemeteryConfCode, CopyStr(pCemeteryDigitsText,1,MaxStrLen(_CemeteryDigits.Code))) then
            exit(_CemeteryDigits.Code);


        _CemeteryDigits.SetRange("Cemetery Conf. Code", pCemeteryConfCode);
        _CemeteryDigits.SetRange(Name,pCemeteryDigitsText);
        if _CemeteryDigits.FindFirst then
          exit(_CemeteryDigits.Code);

        _CemeteryDigits.SetCurrentKey(Name);

        _CemeteryDigitsWithoutQuote := ConvertStr(pCemeteryDigitsText,'''','?');
        _CemeteryDigits.SetFilter(Name,'''@' + _CemeteryDigitsWithoutQuote + '''');
        if _CemeteryDigits.FindFirst then
          exit(_CemeteryDigits.Code);

        _CemeteryDigits.SetRange(Name);

        _CemeteryDigitsFilterFromStart := '''@' + _CemeteryDigitsWithoutQuote + '*''';

        _CemeteryDigits.FilterGroup := -1;
        _CemeteryDigits.SetFilter(Code,_CemeteryDigitsFilterFromStart);
        _CemeteryDigits.SetFilter(Name,_CemeteryDigitsFilterFromStart);

        if _CemeteryDigits.FindFirst then
          exit(_CemeteryDigits.Code);

        _CemeteryDigitsFilterContains := '''@*' + _CemeteryDigitsWithoutQuote + '*''';

        _CemeteryDigits.SetFilter(Code,_CemeteryDigitsFilterContains);
        _CemeteryDigits.SetFilter(Name,_CemeteryDigitsFilterContains);

        if _CemeteryDigits.Count = 1 then begin
          _CemeteryDigits.FindFirst;
          exit(_CemeteryDigits.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_CemeteryDigits.TableCaption);


        Error(MSG001,_CemeteryDigits.TableCaption);
    end;
}

