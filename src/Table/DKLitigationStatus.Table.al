table 50068 "DK_Litigation Status"
{
    Caption = 'Litigation/Law Status';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = "DK_Law Status 2";
    LookupPageID = "DK_Law Status 2";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
            end;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Litigation Status,Law Status';
            OptionMembers = LitigationStatus,LawStatus;
        }
        field(59000; "Old Value"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    trigger OnDelete()
    var
        _Contract: Record DK_Contract;
    begin
        _Contract.Reset;
        _Contract.SetRange("Litigation Status Code", Code);
        if not _Contract.IsEmpty then
            Error(MSG001, TableCaption, Code, _Contract.TableCaption);
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
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'You must select an existing %1.';

    procedure GetCode(pType: Option; pLitigationStatusText: Text): Text
    begin
        exit(GetCodeOpenCard(pType, pLitigationStatusText));
    end;

    procedure GetCodeOpenCard(pType: Option; pLitigationStatusText: Text): Code[20]
    var
        _LitigationStatus: Record "DK_Litigation Status";
        _Code: Code[20];
        _NoFiltersApplied: Boolean;
        _WithoutQuote: Text;
        _FilterFromStart: Text;
        _FilterContains: Text;
    begin
        if pLitigationStatusText = '' then
            exit('');

        if StrLen(pLitigationStatusText) <= MaxStrLen(_LitigationStatus.Code) then
            if _LitigationStatus.Get(pType, CopyStr(pLitigationStatusText, 1, MaxStrLen(_LitigationStatus.Code))) then
                exit(_LitigationStatus.Code);

        _LitigationStatus.SetRange(Type, pType);
        _LitigationStatus.SetRange(Blocked, false);
        _LitigationStatus.SetRange(Name, pLitigationStatusText);
        if _LitigationStatus.FindFirst then
            exit(_LitigationStatus.Code);

        _LitigationStatus.SetCurrentKey(Name);

        _WithoutQuote := ConvertStr(pLitigationStatusText, '''', '?');
        _LitigationStatus.SetFilter(Name, '''@' + _WithoutQuote + '''');
        if _LitigationStatus.FindFirst then
            exit(_LitigationStatus.Code);
        _LitigationStatus.SetRange(Name);

        _FilterFromStart := '''@' + _WithoutQuote + '*''';

        _LitigationStatus.FilterGroup := -1;
        _LitigationStatus.SetFilter(Code, _FilterFromStart);
        _LitigationStatus.SetFilter(Name, _FilterFromStart);

        if _LitigationStatus.FindFirst then
            exit(_LitigationStatus.Code);

        _FilterContains := '''@*' + _WithoutQuote + '*''';

        _LitigationStatus.SetFilter(Code, _FilterContains);
        _LitigationStatus.SetFilter(Name, _FilterContains);

        if _LitigationStatus.Count = 1 then begin
            _LitigationStatus.FindFirst;
            exit(_LitigationStatus.Code);
        end;

        if not GuiAllowed then
            Error(MSG002, _LitigationStatus.TableCaption);

        Error(MSG002, _LitigationStatus.TableCaption);
    end;
}

