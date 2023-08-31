table 50130 "DK_Law Fu. dir. of progress"
{
    // 
    // DK34: 20201104
    //   - Create

    Caption = 'Law Future Direction of Progress';

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

    trigger OnDelete()
    begin

        CheckOnDelete;
    end;

    trigger OnInsert()
    begin

        TestField(Code);
    end;

    trigger OnModify()
    begin

        TestField(Code);
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'You must select an existing %1.';
        MSG002: Label '%1íŒ¡ ‹ÏÔ‘Èœ‰—‡ž ‹Ð‘ª—­ Œ÷ Ž°„Ÿ„¾. %2: %3';

    procedure GetLawFuDirCode(pLawFuDirText: Text): Text
    begin
        exit(GetLawFuDirName(pLawFuDirText));
    end;

    procedure GetLawFuDirName(pLawFuDirText: Text): Code[20]
    var
        _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
        _LawFudirWithoutQuote: Text;
        _LawFudirFilterFromStart: Text;
        _LawFudirFilterContains: Text;
    begin
        if pLawFuDirText = '' then
          exit('');

        if StrLen(pLawFuDirText) <= MaxStrLen(_LawFudirofprogress.Code) then
          if _LawFudirofprogress.Get(CopyStr(pLawFuDirText,1,MaxStrLen(_LawFudirofprogress.Code))) then
            exit(_LawFudirofprogress.Code);

        _LawFudirofprogress.SetRange(Blocked,false);
        _LawFudirofprogress.SetRange(Name,pLawFuDirText);
        if _LawFudirofprogress.FindFirst then
          exit(_LawFudirofprogress.Code);

        _LawFudirofprogress.SetCurrentKey(Name);

        _LawFudirWithoutQuote := ConvertStr(pLawFuDirText,'''','?');
        _LawFudirofprogress.SetFilter(Name,'''@' + _LawFudirWithoutQuote + '''');
        if _LawFudirofprogress.FindFirst then
          exit(_LawFudirofprogress.Code);
        _LawFudirofprogress.SetRange(Name);

        _LawFudirFilterFromStart := '''@' + _LawFudirWithoutQuote + '*''';

        _LawFudirofprogress.FilterGroup := -1;
        _LawFudirofprogress.SetFilter(Code,_LawFudirFilterFromStart);
        _LawFudirofprogress.SetFilter(Name,_LawFudirFilterFromStart);

        if _LawFudirofprogress.FindFirst then
          exit(_LawFudirofprogress.Code);

        _LawFudirFilterContains := '''@*' + _LawFudirWithoutQuote + '*''';

        _LawFudirofprogress.SetFilter(Code,_LawFudirFilterContains);
        _LawFudirofprogress.SetFilter(Name,_LawFudirFilterContains);

        if _LawFudirofprogress.Count = 1 then begin
          _LawFudirofprogress.FindFirst;
          exit(_LawFudirofprogress.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_LawFudirofprogress.TableCaption);

        Error(MSG001,_LawFudirofprogress.TableCaption);
    end;

    local procedure CheckOnDelete()
    var
        _LitigationLawProgress: Record "DK_Litigation Law Progress";
    begin

        _LitigationLawProgress.Reset;
        _LitigationLawProgress.FilterGroup(-1);
        _LitigationLawProgress.SetRange("Lawsuit Future Dir. Code",Code);
        _LitigationLawProgress.SetRange("Deposit Future Dir. Code",Code);
        _LitigationLawProgress.SetRange("Insurance Future Dir. Code",Code);
        _LitigationLawProgress.SetRange("Corporeal Future Dir. Code",Code);
        _LitigationLawProgress.SetRange("Obligation Future Dir. Code",Code);
        if _LitigationLawProgress.FindSet then
          Error(MSG002,_LitigationLawProgress.TableCaption,_LitigationLawProgress.FieldCaption("No."),_LitigationLawProgress."No.");
    end;
}

