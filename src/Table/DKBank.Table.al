table 50053 DK_Bank
{
    Caption = 'Bank';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = DK_Bank;
    LookupPageID = DK_Bank;

    fields
    {
        field(1; "Code"; Code[5])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[20])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
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
        _Employee: Record DK_Employee;
        _Vendor: Record DK_Vendor;
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
    begin
        //‹Ð‘ª ‘í› „Ô‹Ý

        _Employee.Reset;
        _Employee.SetRange("Bank Code", Code);
        if not _Employee.IsEmpty then
            Error(MSG001, TableCaption, Code, _Employee.TableCaption);

        _Vendor.Reset;
        _Vendor.SetRange("Bank Code", Code);
        if not _Vendor.IsEmpty then
            Error(MSG001, TableCaption, Code, _Vendor.TableCaption);

        _ReqRemLedger.Reset;
        _ReqRemLedger.SetRange("Bank Code", Code);
        if not _ReqRemLedger.IsEmpty then
            Error(MSG001, TableCaption, Code, _ReqRemLedger.TableCaption);
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

    procedure GetBankCode(pBankText: Text): Text
    begin
        exit(GetBankCodeOpenCard(pBankText));
    end;

    procedure GetBankCodeOpenCard(pBankText: Text): Code[20]
    var
        _Bank: Record DK_Bank;
        _BankCode: Code[20];
        _NoFiltersApplied: Boolean;
        _BankWithoutQuote: Text;
        _BankFilterFromStart: Text;
        _BankFilterContains: Text;
    begin
        if pBankText = '' then
            exit('');

        if StrLen(pBankText) <= MaxStrLen(_Bank.Code) then
            if _Bank.Get(CopyStr(pBankText, 1, MaxStrLen(_Bank.Code))) then
                exit(_Bank.Code);

        _Bank.SetRange(Blocked, false);
        _Bank.SetRange(Name, pBankText);
        if _Bank.FindFirst then
            exit(_Bank.Code);

        _Bank.SetCurrentKey(Name);

        _BankWithoutQuote := ConvertStr(pBankText, '''', '?');
        _Bank.SetFilter(Name, '''@' + _BankWithoutQuote + '''');
        if _Bank.FindFirst then
            exit(_Bank.Code);
        _Bank.SetRange(Name);

        _BankFilterFromStart := '''@' + _BankWithoutQuote + '*''';

        _Bank.FilterGroup := -1;
        _Bank.SetFilter(Code, _BankFilterFromStart);
        _Bank.SetFilter(Name, _BankFilterFromStart);

        if _Bank.FindFirst then
            exit(_Bank.Code);

        _BankFilterContains := '''@*' + _BankWithoutQuote + '*''';

        _Bank.SetFilter(Code, _BankFilterContains);
        _Bank.SetFilter(Name, _BankFilterContains);

        if _Bank.Count = 1 then begin
            _Bank.FindFirst;
            exit(_Bank.Code);
        end;

        if not GuiAllowed then
            Error(MSG002, _Bank.TableCaption);

        Error(MSG002, _Bank.TableCaption);
    end;
}

