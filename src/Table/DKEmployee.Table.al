table 50020 DK_Employee
{
    Caption = 'Employee';
    DataCaptionFields = "No.", Name, "Department Name";
    DrillDownPageID = "DK_Employee List";
    LookupPageID = "DK_Employee List";

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
                    NoSeriesMgt.TestManual(FunctionSetup."Employee Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department;

            trigger OnValidate()
            begin
                if Department.Get("Department Code") then
                    "Department Name" := Department.Name
                else
                    "Department Name" := '';

                CalcFields(Litigation);
            end;
        }
        field(4; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            TableRelation = DK_Department;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Department Code", Department.GetDeptCode("Department Name"));
            end;
        }
        field(5; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(7; "Phone No."; Text[20])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Phone No." <> "Phone No." then begin
                    if "Phone No." <> '' then
                        if not _CommFun.CheckValidPhoneNo("Phone No.") then
                            Error(MSG005, FieldCaption("Phone No."));
                end;
            end;
        }
        field(8; "Mobile No."; Text[20])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Mobile No." <> "Mobile No." then begin

                    if "Mobile No." = '' then begin
                        TestField("SMS Notification", false)
                    end else begin
                        if not _CommFun.CheckValidMobileNo("Mobile No.") then
                            Error(MSG005, FieldCaption("Mobile No."));
                    end;
                end;
            end;
        }
        field(9; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."E-Mail" <> "E-Mail" then begin

                    _MailMgt.ValidateEmailAddressField("E-Mail");

                end;
            end;
        }
        field(10; "Visual Cemetery Account"; Text[20])
        {
            Caption = 'Visual Cemetery Account';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Visual Cemetery Account" <> Rec."Visual Cemetery Account" then
                    DuplicateERPUserID("No.", "Visual Cemetery Account");
            end;
        }
        field(11; "Visual Cemetery PW"; Text[20])
        {
            Caption = 'Visual Cemetery PW';
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13; "ERP User ID"; Code[50])
        {
            Caption = 'ERP User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                if xRec."ERP User ID" <> Rec."ERP User ID" then
                    DuplicateERPUserID("No.", "ERP User ID");
            end;
        }
        field(14; "SMS Notification"; Boolean)
        {
            Caption = 'SMS Notification';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Mobile No.");
            end;
        }
        field(15; "Bank Code"; Code[5])
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
        field(16; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Bank Code", Bank.GetBankCode("Bank Name"));
            end;
        }
        field(17; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(19; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
            DataClassification = ToBeClassified;
        }
        field(20; "Business Contacts"; Text[20])
        {
            Caption = 'Business Contacts';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Business Contacts" <> "Business Contacts" then begin
                    if "Business Contacts" <> '' then
                        if not _CommFun.CheckValidMobileNo("Business Contacts") then
                            Error(MSG005, FieldCaption("Business Contacts"));
                end;
            end;
        }
        field(21; Litigation; Boolean)
        {
            CalcFormula = Lookup(DK_Department.Litigation WHERE(Code = FIELD("Department Code")));
            Caption = 'Litigation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Visual Cemetery Admin."; Boolean)
        {
            Caption = 'Visual Cemetery Admin.';
            DataClassification = ToBeClassified;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50000; "Bef. No."; Code[20])
        {
            Caption = 'Bef. No.';
            DataClassification = ToBeClassified;
            Editable = false;
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
        key(Key3; "E-Mail")
        {
        }
        key(Key4; "Mobile No.")
        {
        }
        key(Key5; "Phone No.")
        {
        }
        key(Key6; "Department Name")
        {
        }
        key(Key7; "ERP User ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Department Name", "E-Mail", "Mobile No.", "Phone No.")
        {
        }
    }

    trigger OnDelete()
    var
        _AutoNotiEntry: Record "DK_Auto. Noti. Entry";
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
        _ReqExpHeader: Record "DK_Request Expenses Header";
    begin

        _AutoNotiEntry.Reset;
        _AutoNotiEntry.SetRange("Employee No.", "No.");
        if not _AutoNotiEntry.IsEmpty then
            Error(MSG002, TableCaption, "No.", _AutoNotiEntry.TableCaption);

        _ReqRemLedger.Reset;
        _ReqRemLedger.SetRange("Account Type", _ReqRemLedger."Account Type"::Employee);
        _ReqRemLedger.SetRange("Account No.", "No.");
        if not _ReqRemLedger.IsEmpty then
            Error(MSG002, TableCaption, "No.", _ReqRemLedger.TableCaption);

        _ReqExpHeader.Reset;
        _ReqExpHeader.SetRange("Account Type", _ReqExpHeader."Account Type"::Employee);
        _ReqExpHeader.SetRange("Account No.", "No.");
        if not _ReqExpHeader.IsEmpty then
            Error(MSG002, TableCaption, "No.", _ReqExpHeader.TableCaption);
    end;

    trigger OnInsert()
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Employee Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        TestField("No.");
        //<<No

        "Visual Cemetery Account" := "No.";
        "Visual Cemetery PW" := FunctionSetup."Init. Visual Cemetery PW";

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
        MSG001: Label 'It is already assigned to %1 %2 employees. %3 : %4';
        MSG002: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG003: Label 'You must select an existing %1.';
        Bank: Record DK_Bank;
        Department: Record DK_Department;
        MSG004: Label 'The %2 has not been set in %1.';
        MSG005: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';


    procedure AssistEdit(OldEmployee: Record DK_Employee): Boolean
    var
        _Employee: Record DK_Employee;
    begin
        with _Employee do begin
            _Employee := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Employee Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Employee Nos.", OldEmployee."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _Employee;
                exit(true);
            end;
        end;
    end;

    local procedure DuplicateERPUserID(pEmployeeNo: Code[20]; pERPUserID: Code[50])
    var
        _Employee: Record DK_Employee;
    begin
        if pERPUserID = '' then exit;

        _Employee.Reset;
        _Employee.SetFilter("No.", '<>%1', pEmployeeNo);
        _Employee.SetRange("ERP User ID", pERPUserID);
        if _Employee.FindFirst then
            Error(MSG001, _Employee."No.", _Employee.Name, FieldCaption("ERP User ID"), pERPUserID);
    end;

    local procedure DuplicateVisualAccount(pEmployeeNo: Code[20]; pVisualAccount: Code[20])
    var
        _Employee: Record DK_Employee;
    begin

        if pVisualAccount = '' then exit;

        _Employee.Reset;
        _Employee.SetFilter("No.", '<>%1', pEmployeeNo);
        _Employee.SetRange("Visual Cemetery Account", pVisualAccount);
        if _Employee.FindFirst then
            Error(MSG001, _Employee."No.", _Employee.Name, FieldCaption("Visual Cemetery Account"), pVisualAccount);
    end;

    procedure GetEmployeeNo(pEmployeeText: Text): Text
    begin
        exit(GetEmployeeNoOpenCard(pEmployeeText));
    end;

    procedure GetEmployeeNoOpenCard(pEmployeeText: Text): Code[20]
    var
        _Employee: Record DK_Employee;
        _EmployeeNo: Code[20];
        _NoFiltersApplied: Boolean;
        _EmployeeWithoutQuote: Text;
        _EmployeeFilterFromStart: Text;
        _EmployeeFilterContains: Text;
    begin
        if pEmployeeText = '' then
            exit('');

        if StrLen(pEmployeeText) <= MaxStrLen(_Employee."No.") then
            if _Employee.Get(CopyStr(pEmployeeText, 1, MaxStrLen(_Employee."No."))) then
                exit(_Employee."No.");

        _Employee.SetRange(Blocked, false);
        _Employee.SetRange(Name, pEmployeeText);
        if _Employee.FindFirst then
            exit(_Employee."No.");

        _Employee.SetCurrentKey(Name);

        _EmployeeWithoutQuote := ConvertStr(pEmployeeText, '''', '?');
        _Employee.SetFilter(Name, '''@' + _EmployeeWithoutQuote + '''');
        if _Employee.FindFirst then
            exit(_Employee."No.");

        _Employee.SetRange(Name);

        _EmployeeFilterFromStart := '''@' + _EmployeeWithoutQuote + '*''';

        _Employee.FilterGroup := -1;
        _Employee.SetFilter("No.", _EmployeeFilterFromStart);
        _Employee.SetFilter(Name, _EmployeeFilterFromStart);

        if _Employee.FindFirst then
            exit(_Employee."No.");

        _EmployeeFilterContains := '''@*' + _EmployeeWithoutQuote + '*''';

        _Employee.SetFilter("No.", _EmployeeFilterContains);
        _Employee.SetFilter(Name, _EmployeeFilterContains);

        if _Employee.Count = 1 then begin
            _Employee.FindFirst;
            exit(_Employee."No.");
        end;

        if not GuiAllowed then
            Error(MSG003, _Employee.TableCaption);


        Error(MSG003, _Employee.TableCaption);
    end;

    procedure GetEmployeeNoUserID(pUserID: Code[50]): Code[20]
    var
        _Employee: Record DK_Employee;
    begin

        _Employee.Reset;
        _Employee.SetRange(Blocked, false);
        _Employee.SetRange("ERP User ID", pUserID);
        if _Employee.FindSet then
            exit(_Employee."No.");
    end;

    procedure GetDepartmentCode(pEmployeeNo: Code[20]): Code[20]
    var
        _Employee: Record DK_Employee;
    begin
        if pEmployeeNo = '' then
            exit;

        _Employee.Reset;
        _Employee.SetRange("No.", pEmployeeNo);
        _Employee.SetRange(Blocked, false);
        if _Employee.FindSet then begin
            if _Employee."Department Code" = '' then
                Error(MSG004, _Employee.TableCaption, FieldCaption("Department Code"));

            exit(_Employee."Department Code");
        end;

        Error(MSG003, _Employee.TableCaption);
    end;


    procedure GetERPUserIDEmployee(pUSERID: Code[50]; var pEmployeeNo: Code[20]; var pEmployeeName: Text[50])
    var
        _Employee: Record DK_Employee;
    begin

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", pUSERID);
        if _Employee.FindSet then begin
            pEmployeeNo := _Employee."No.";
            pEmployeeName := _Employee.Name;
        end;
    end;
}

