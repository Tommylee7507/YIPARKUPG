table 50081 "DK_Receipt Bank Account"
{
    // #DK36: 20211007
    //   - Add Field: "Use PG"

    Caption = 'Receipt Bank Account';
    DataCaptionFields = "Code",Description,"Bank Account No.";
    DrillDownPageID = "DK_Receipt Bank Account";
    LookupPageID = "DK_Receipt Bank Account";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3;"Bank Account No.";Code[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(4;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(5;"Bank Code";Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;

            trigger OnValidate()
            begin
                if Bank.Get("Bank Code") then
                  "Bank Name" := Bank.Name
                else
                  "Bank Name" := '';
            end;
        }
        field(6;"Bank Name";Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Bank Code",Bank.GetBankCode("Bank Name"));
            end;
        }
        field(7;"Admin. Expense";Boolean)
        {
            Caption = 'Admin. Expense';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ReceiptBankAccount: Record "DK_Receipt Bank Account";
            begin
                if xRec."Admin. Expense" <> "Admin. Expense" then begin
                  if "Admin. Expense" then begin
                    _ReceiptBankAccount.Reset;
                    _ReceiptBankAccount.SetRange("Admin. Expense", true);
                    _ReceiptBankAccount.SetFilter(Code, '<>%1', Code);
                    if _ReceiptBankAccount.FindSet then
                      Error(MSG003, _ReceiptBankAccount.FieldCaption(Code),
                                    _ReceiptBankAccount.Code,
                                    _ReceiptBankAccount.FieldCaption(Description),
                                    _ReceiptBankAccount.Description);

                    //Check
                    TestField("Bank Account No.");
                    TestField("Bank Code");
                    TestField(Description);
                  end;
                end;
            end;
        }
        field(8;Litigation;Boolean)
        {
            Caption = 'Litigation';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ReceiptBankAccount: Record "DK_Receipt Bank Account";
            begin

                if xRec.Litigation <> Litigation then begin
                  if Litigation then begin
                    _ReceiptBankAccount.Reset;
                    _ReceiptBankAccount.SetRange(Litigation, true);
                    _ReceiptBankAccount.SetFilter(Code, '<>%1', Code);
                    if _ReceiptBankAccount.FindSet then
                      Error(MSG004, _ReceiptBankAccount.FieldCaption(Code),
                                    _ReceiptBankAccount.Code,
                                    _ReceiptBankAccount.FieldCaption(Description),
                                    _ReceiptBankAccount.Description);

                    //Check
                    TestField("Bank Account No.");
                    TestField("Bank Code");
                    TestField(Description);
                  end;
                end;
            end;
        }
        field(9;"Account Holder";Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(100;"Use PG";Boolean)
        {
            Caption = 'Use PG';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _DK_ReceiptBankAccount: Record "DK_Receipt Bank Account";
            begin
                if "Use PG" then begin
                  _DK_ReceiptBankAccount.Reset();
                  _DK_ReceiptBankAccount.SetFilter(Code,'<>%1',Code);
                  if _DK_ReceiptBankAccount.FindSet then
                    _DK_ReceiptBankAccount.ModifyAll("Use PG",false);
                end;
            end;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
        key(Key2;Description)
        {
        }
        key(Key3;"Bank Account No.")
        {
        }
        key(Key4;"Bank Code")
        {
        }
        key(Key5;"Bank Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Description,"Bank Account No.","Bank Name")
        {
        }
    }

    trigger OnDelete()
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin
        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetRange("Bank Account Code",Code);
        if not _PayReceiptDoc.IsEmpty then
          Error(MSG001, TableCaption, Code, _PayReceiptDoc.TableCaption);
    end;

    trigger OnInsert()
    begin
        TestField(Code);
        TestField(Description);
        TestField("Bank Account No.");
        TestField("Bank Code");
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Description);
        TestField("Bank Account No.");
        TestField("Bank Code");
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'You must select an existing %1.';
        Bank: Record DK_Bank;
        MSG003: Label 'Only one account can be assigned. %1:%2, %3:%4';
        MSG004: Label 'Only one account can be assigned. %1:%2, %3:%4';

    procedure GetCode(pReceiptBankText: Text): Text
    begin
        exit(GetCodeOpenCard(pReceiptBankText));
    end;

    procedure GetCodeOpenCard(pReceiptBankText: Text): Code[20]
    var
        _ReceiptBank: Record "DK_Receipt Bank Account";
        _Code: Code[20];
        _NoFiltersApplied: Boolean;
        _WithoutQuote: Text;
        _FilterFromStart: Text;
        _FilterContains: Text;
    begin
        if pReceiptBankText = '' then
          exit('');

        if StrLen(pReceiptBankText) <= MaxStrLen(_ReceiptBank.Code) then
          if _ReceiptBank.Get(CopyStr(pReceiptBankText,1,MaxStrLen(_ReceiptBank.Code))) then
            exit(_ReceiptBank.Code);

        _ReceiptBank.SetRange(Blocked,false);
        _ReceiptBank.SetRange(Description,pReceiptBankText);
        if _ReceiptBank.FindFirst then
          exit(_ReceiptBank.Code);

        _ReceiptBank.SetCurrentKey(Description);

        _WithoutQuote := ConvertStr(pReceiptBankText,'''','?');
        _ReceiptBank.SetFilter(Description,'''@' + _WithoutQuote + '''');
        if _ReceiptBank.FindFirst then
          exit(_ReceiptBank.Code);
        _ReceiptBank.SetRange(Description);

        _FilterFromStart := '''@' + _WithoutQuote + '*''';

        _ReceiptBank.FilterGroup := -1;
        _ReceiptBank.SetFilter(Code,_FilterFromStart);
        _ReceiptBank.SetFilter(Description,_FilterFromStart);

        if _ReceiptBank.FindFirst then
          exit(_ReceiptBank.Code);

        _FilterContains := '''@*' + _WithoutQuote + '*''';

        _ReceiptBank.SetFilter(Code,_FilterContains);
        _ReceiptBank.SetFilter(Description,_FilterContains);

        if _ReceiptBank.Count = 1 then begin
          _ReceiptBank.FindFirst;
          exit(_ReceiptBank.Code);
        end;

        if not GuiAllowed then
          Error(MSG002,_ReceiptBank.TableCaption);

        Error(MSG002,_ReceiptBank.TableCaption);
    end;
}

