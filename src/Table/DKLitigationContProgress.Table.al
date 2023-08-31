table 50128 "DK_Litigation Cont. Progress"
{
    // 
    // DK34: 20201030
    //   - Create

    Caption = 'Litigation Contract Progress';

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
    var
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("Litigation Progress Code",Code);
        if _Contract.FindSet then
          Error(MSG002,_Contract.TableCaption,_Contract.FieldCaption("No."),_Contract."No.");
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
        MSG001: Label 'You must select an existing %1.';
        MSG002: Label 'In use by %1. %2: %3';

    procedure GetLitigationProgressCode(pLitiprogText: Text): Text
    begin
        exit(GetLitigationProgressName(pLitiprogText));
    end;

    procedure GetLitigationProgressName(pLitiprogText: Text): Code[20]
    var
        _LitigationProgress: Record "DK_Litigation Cont. Progress";
        _LitiProgWithoutQuote: Text;
        _LitiProgFilterFromStart: Text;
        _LitiProgFilterContains: Text;
    begin
        if pLitiprogText = '' then
          exit('');

        if StrLen(pLitiprogText) <= MaxStrLen(_LitigationProgress.Code) then
          if _LitigationProgress.Get(CopyStr(pLitiprogText,1,MaxStrLen(_LitigationProgress.Code))) then
            exit(_LitigationProgress.Code);

        _LitigationProgress.SetRange(Blocked,false);
        _LitigationProgress.SetRange(Name,pLitiprogText);
        if _LitigationProgress.FindFirst then
          exit(_LitigationProgress.Code);

        _LitigationProgress.SetCurrentKey(Name);

        _LitiProgWithoutQuote := ConvertStr(pLitiprogText,'''','?');
        _LitigationProgress.SetFilter(Name,'''@' + _LitiProgWithoutQuote + '''');
        if _LitigationProgress.FindFirst then
          exit(_LitigationProgress.Code);
        _LitigationProgress.SetRange(Name);

        _LitiProgFilterFromStart := '''@' + _LitiProgWithoutQuote + '*''';

        _LitigationProgress.FilterGroup := -1;
        _LitigationProgress.SetFilter(Code,_LitiProgFilterFromStart);
        _LitigationProgress.SetFilter(Name,_LitiProgFilterFromStart);

        if _LitigationProgress.FindFirst then
          exit(_LitigationProgress.Code);

        _LitiProgFilterContains := '''@*' + _LitiProgWithoutQuote + '*''';

        _LitigationProgress.SetFilter(Code,_LitiProgFilterContains);
        _LitigationProgress.SetFilter(Name,_LitiProgFilterContains);

        if _LitigationProgress.Count = 1 then begin
          _LitigationProgress.FindFirst;
          exit(_LitigationProgress.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_LitigationProgress.TableCaption);

        Error(MSG001,_LitigationProgress.TableCaption);
    end;
}

