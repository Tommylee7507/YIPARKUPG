table 50022 DK_Vendor
{
    Caption = 'Vendor';
    DataCaptionFields = "No.", Name, "VAT Registration No.";
    DrillDownPageID = "DK_Vendor List";
    LookupPageID = "DK_Vendor List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Vendor Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_Connect;
            end;
        }
        field(4; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
        }
        field(5; Contact; Text[20])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec.Contact <> Contact then begin
                    if Contact <> '' then
                        if not _CommFun.CheckValidPhoneNo(Contact) then
                            Error(MSG004, FieldCaption(Contact));
                end;
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Phone No." <> "Phone No." then begin
                    if "Phone No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Phone No.") then
                            Error(MSG004, FieldCaption("Phone No."));
                end;
            end;
        }
        field(7; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = ToBeClassified;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(10; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."E-mail" <> "E-mail" then begin
                    _MailMgt.ValidateEmailAddressField("E-mail");
                end;
            end;
        }
        field(11; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(12; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(13; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(15; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(16; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Bank Code"; Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;

            trigger OnValidate()
            begin
                if Bank.Get("Bank Code") then
                    "Bank Name" := Bank.Name;
            end;
        }
        field(21; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;

            trigger OnValidate()
            begin
                Validate("Bank Code", Bank.GetBankCode("Bank Name"));
            end;
        }
        field(22; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(23; "Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(59000; Idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
        key(Key3; "VAT Registration No.")
        {
        }
        key(Key4; "Phone No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "VAT Registration No.", "Phone No.")
        {
        }
    }

    trigger OnDelete()
    var
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
        _ReqExpHeader: Record "DK_Request Expenses Header";
    begin

        Check_Connect;
    end;

    trigger OnInsert()
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Vendor Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Vendor Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        TestField("No.");
        //<<No

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        TestField("No.");

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin

        Error('');
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'You must select an existing %1.';
        Bank: Record DK_Bank;
        MSG002: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG003: Label 'It is in use in the %1.';
        MSG004: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';


    procedure AssistEdit(OldVendor: Record DK_Vendor): Boolean
    var
        _Vendor: Record DK_Vendor;
    begin
        with _Vendor do begin
            _Vendor := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Vendor Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Vendor Nos.", OldVendor."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _Vendor;
                exit(true);
            end;
        end;
    end;

    procedure GetVendorNo(pVendorText: Text): Text
    begin
        exit(GetVendorNoOpenCard(pVendorText));
    end;

    procedure GetVendorNoOpenCard(pVenodrText: Text): Code[20]
    var
        _Vendor: Record DK_Vendor;
        _VendorWithoutQuote: Text;
        _VenodrFilterFromStart: Text;
        _VendorFilterContains: Text;
    begin
        if pVenodrText = '' then
            exit('');

        if StrLen(pVenodrText) <= MaxStrLen(_Vendor."No.") then
            if _Vendor.Get(CopyStr(pVenodrText, 1, MaxStrLen(_Vendor."No."))) then
                exit(_Vendor."No.");

        _Vendor.SetRange(Blocked, false);
        _Vendor.SetRange(Name, pVenodrText);
        if _Vendor.FindFirst then
            exit(_Vendor."No.");

        _Vendor.SetCurrentKey(Name);

        _VendorWithoutQuote := ConvertStr(pVenodrText, '''', '?');
        _Vendor.SetFilter(Name, '''@' + _VendorWithoutQuote + '''');
        if _Vendor.FindFirst then
            exit(_Vendor."No.");
        _Vendor.SetRange(Name);

        _VenodrFilterFromStart := '''@' + _VendorWithoutQuote + '*''';

        _Vendor.FilterGroup := -1;
        _Vendor.SetFilter("No.", _VenodrFilterFromStart);
        _Vendor.SetFilter(Name, _VenodrFilterFromStart);

        if _Vendor.FindFirst then
            exit(_Vendor."No.");

        _VendorFilterContains := '''@*' + _VendorWithoutQuote + '*''';

        _Vendor.SetFilter("No.", _VendorFilterContains);
        _Vendor.SetFilter(Name, _VendorFilterContains);
        _Vendor.SetFilter("VAT Registration No.", _VendorFilterContains);
        _Vendor.SetFilter("Phone No.", _VendorFilterContains);
        _Vendor.SetFilter("E-mail", _VendorFilterContains);

        if _Vendor.Count = 1 then begin
            _Vendor.FindFirst;
            exit(_Vendor."No.");
        end;

        if not GuiAllowed then
            Error(MSG001, _Vendor.TableCaption);

        Error(MSG001, _Vendor.TableCaption);
    end;


    procedure Check_Connect()
    var
        _PurchaseContract: Record "DK_Purchase Contract";
        _RequestExpensesHeader: Record "DK_Request Expenses Header";
        _RequestRemittanceLedger: Record "DK_Request Remittance Ledger";
    begin

        _PurchaseContract.Reset;
        _PurchaseContract.SetRange("Vendor No.", "No.");
        if not _PurchaseContract.IsEmpty then begin
            Error(MSG003, _PurchaseContract.TableCaption);
        end;

        _RequestExpensesHeader.Reset;
        _RequestExpensesHeader.SetRange("Account Type", _RequestExpensesHeader."Account Type"::Vendor);
        _RequestExpensesHeader.SetRange("Account No.", "No.");
        if not _RequestExpensesHeader.IsEmpty then begin
            Error(MSG003, _RequestExpensesHeader.TableCaption);
        end;

        _RequestRemittanceLedger.Reset;
        _RequestRemittanceLedger.SetRange("Account Type", _RequestRemittanceLedger."Account Type"::Vendor);
        _RequestRemittanceLedger.SetRange("Account No.", "No.");
        if not _RequestRemittanceLedger.IsEmpty then
            Error(MSG003, _RequestRemittanceLedger.TableCaption);
    end;
}

