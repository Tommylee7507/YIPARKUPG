table 50123 "DK_Funeral Type"
{
    Caption = 'Funeral Type';
    DrillDownPageID = "DK_Funeral Type";
    LookupPageID = "DK_Funeral Type";

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
    }

    fieldgroups
    {
    }

    var
        MSG001: Label 'You must select an existing %1.';

    procedure GetFuneralTypeCode(pFuneralTypeText: Text): Text
    begin
        exit(GmFuneralTypeName(pFuneralTypeText));
    end;

    procedure GmFuneralTypeName(pFuneralTypeText: Text): Code[20]
    var
        _FuneralType: Record "DK_Funeral Type";
        _FuneralTypeWithoutQuote: Text;
        _FuneralTypeFilterFromStart: Text;
        _FuneralTypeFilterContains: Text;
    begin
        if pFuneralTypeText = '' then
          exit('');

        if StrLen(pFuneralTypeText) <= MaxStrLen(_FuneralType.Code) then
          if _FuneralType.Get(CopyStr(pFuneralTypeText,1,MaxStrLen(_FuneralType.Code))) then
            exit(_FuneralType.Code);

        _FuneralType.SetRange(Blocked,false);
        _FuneralType.SetRange(Name,pFuneralTypeText);
        if _FuneralType.FindFirst then
          exit(_FuneralType.Code);

        _FuneralType.SetCurrentKey(Name);

        _FuneralTypeWithoutQuote := ConvertStr(pFuneralTypeText,'''','?');
        _FuneralType.SetFilter(Name,'''@' + _FuneralTypeWithoutQuote + '''');
        if _FuneralType.FindFirst then
          exit(_FuneralType.Code);
        _FuneralType.SetRange(Name);

        _FuneralTypeFilterFromStart := '''@' + _FuneralTypeWithoutQuote + '*''';

        _FuneralType.FilterGroup := -1;
        _FuneralType.SetFilter(Code,_FuneralTypeFilterFromStart);
        _FuneralType.SetFilter(Name,_FuneralTypeFilterFromStart);

        if _FuneralType.FindFirst then
          exit(_FuneralType.Code);

        _FuneralTypeFilterContains := '''@*' + _FuneralTypeWithoutQuote + '*''';

        _FuneralType.SetFilter(Code,_FuneralTypeFilterContains);
        _FuneralType.SetFilter(Name,_FuneralTypeFilterContains);

        if _FuneralType.Count = 1 then begin
          _FuneralType.FindFirst;
          exit(_FuneralType.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_FuneralType.TableCaption);

        Error(MSG001,_FuneralType.TableCaption);
    end;
}

