table 50131 DK_Quotation
{
    // 
    // DK34: 20201105
    //   - Create

    Caption = 'Quotation';

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

    procedure GetQuotationCode(pQuotationText: Text): Text
    begin
        exit(GetQuotationName(pQuotationText));
    end;

    procedure GetQuotationName(pQuotationText: Text): Code[20]
    var
        _Quotation: Record DK_Quotation;
        _QuotationWithoutQuote: Text;
        _QuotationFilterFromStart: Text;
        _QuotationFilterContains: Text;
    begin
        if pQuotationText = '' then
          exit('');

        if StrLen(pQuotationText) <= MaxStrLen(_Quotation.Code) then
          if _Quotation.Get(CopyStr(pQuotationText,1,MaxStrLen(_Quotation.Code))) then
            exit(_Quotation.Code);

        _Quotation.SetRange(Blocked,false);
        _Quotation.SetRange(Name,pQuotationText);
        if _Quotation.FindFirst then
          exit(_Quotation.Code);

        _Quotation.SetCurrentKey(Name);

        _QuotationWithoutQuote := ConvertStr(pQuotationText,'''','?');
        _Quotation.SetFilter(Name,'''@' + _QuotationWithoutQuote + '''');
        if _Quotation.FindFirst then
          exit(_Quotation.Code);
        _Quotation.SetRange(Name);

        _QuotationFilterFromStart := '''@' + _QuotationWithoutQuote + '*''';

        _Quotation.FilterGroup := -1;
        _Quotation.SetFilter(Code,_QuotationFilterFromStart);
        _Quotation.SetFilter(Name,_QuotationFilterFromStart);

        if _Quotation.FindFirst then
          exit(_Quotation.Code);

        _QuotationFilterContains := '''@*' + _QuotationWithoutQuote + '*''';

        _Quotation.SetFilter(Code,_QuotationFilterContains);
        _Quotation.SetFilter(Name,_QuotationFilterContains);

        if _Quotation.Count = 1 then begin
          _Quotation.FindFirst;
          exit(_Quotation.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_Quotation.TableCaption);

        Error(MSG001,_Quotation.TableCaption);
    end;

    local procedure CheckOnDelete()
    var
        _LitigationLawProgress: Record "DK_Litigation Law Progress";
    begin

        _LitigationLawProgress.Reset;
        _LitigationLawProgress.FilterGroup(-1);
        _LitigationLawProgress.SetRange("Deposit Quotation Code",Code);
        _LitigationLawProgress.SetRange("Insurance Quotation Code",Code);
        _LitigationLawProgress.SetRange("Corporeal Quotation Code",Code);
        _LitigationLawProgress.SetRange("Obligation Quotation Code",Code);
        if _LitigationLawProgress.FindSet then
          Error(MSG002,_LitigationLawProgress.TableCaption,_LitigationLawProgress.FieldCaption("No."),_LitigationLawProgress."No.");
    end;
}

