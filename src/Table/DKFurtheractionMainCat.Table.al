table 50126 "DK_Further action Main Cat."
{
    // 
    // DK34: 20201030
    //   - Create

    Caption = 'Further action Main Category';
    DrillDownPageID = "DK_Further action Main Cat.";
    LookupPageID = "DK_Further action Main Cat.";

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
        _FurtheractionSubCat: Record "DK_Further action Sub Cat.";
        _Contract: Record DK_Contract;
    begin
        _FurtheractionSubCat.Reset;
        _FurtheractionSubCat.SetRange("Further action Main Cat. Code",Code);
        if _FurtheractionSubCat.FindSet then
          Error(MSG001,_FurtheractionSubCat.TableCaption);

        _Contract.Reset;
        _Contract.SetRange("Fur. Main Cat. Code",Code);
        if _Contract.FindSet then
          Error(MSG003,_Contract.TableCaption,_Contract.FieldCaption("No."),_Contract."No.");
    end;

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    trigger OnModify()
    begin
        TestField(Code);
    end;

    var
        MSG001: Label 'It can not be deleted because it is being used in %1.';
        MSG002: Label 'You must select an existing %1.';
        MSG003: Label 'In use by %1. %2: %3';

    procedure GetFutheractionMCode(pFutheractionMText: Text): Text
    begin
        exit(GetFutheractionMName(pFutheractionMText));
    end;

    procedure GetFutheractionMName(pFutheractionMText: Text): Code[20]
    var
        _FurtheractionMainCat: Record "DK_Further action Main Cat.";
        _FurtheractionMCatWithoutQuote: Text;
        _FurtheractionMCatFilterFromStart: Text;
        _FurtheractionMCatFilterContains: Text;
    begin
        if pFutheractionMText = '' then
          exit('');

        if StrLen(pFutheractionMText) <= MaxStrLen(_FurtheractionMainCat.Code) then
          if _FurtheractionMainCat.Get(CopyStr(pFutheractionMText,1,MaxStrLen(_FurtheractionMainCat.Code))) then
            exit(_FurtheractionMainCat.Code);

        _FurtheractionMainCat.SetRange(Blocked,false);
        _FurtheractionMainCat.SetRange(Name,pFutheractionMText);
        if _FurtheractionMainCat.FindFirst then
          exit(_FurtheractionMainCat.Code);

        _FurtheractionMainCat.SetCurrentKey(Name);

        _FurtheractionMCatWithoutQuote := ConvertStr(pFutheractionMText,'''','?');
        _FurtheractionMainCat.SetFilter(Name,'''@' + _FurtheractionMCatWithoutQuote + '''');
        if _FurtheractionMainCat.FindFirst then
          exit(_FurtheractionMainCat.Code);
        _FurtheractionMainCat.SetRange(Name);

        _FurtheractionMCatFilterFromStart := '''@' + _FurtheractionMCatWithoutQuote + '*''';

        _FurtheractionMainCat.FilterGroup := -1;
        _FurtheractionMainCat.SetFilter(Code,_FurtheractionMCatFilterFromStart);
        _FurtheractionMainCat.SetFilter(Name,_FurtheractionMCatFilterFromStart);

        if _FurtheractionMainCat.FindFirst then
          exit(_FurtheractionMainCat.Code);

        _FurtheractionMCatFilterContains := '''@*' + _FurtheractionMCatWithoutQuote + '*''';

        _FurtheractionMainCat.SetFilter(Code,_FurtheractionMCatFilterContains);
        _FurtheractionMainCat.SetFilter(Name,_FurtheractionMCatFilterContains);

        if _FurtheractionMainCat.Count = 1 then begin
          _FurtheractionMainCat.FindFirst;
          exit(_FurtheractionMainCat.Code);
        end;

        if not GuiAllowed then
          Error(MSG002,_FurtheractionMainCat.TableCaption);

        Error(MSG002,_FurtheractionMainCat.TableCaption);
    end;
}

