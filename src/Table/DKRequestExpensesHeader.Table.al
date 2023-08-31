table 50055 "DK_Request Expenses Header"
{
    Caption = 'Request Expenses Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);

                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Request Expesnsed Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Vendor';
            OptionMembers = Employee,Vendor;

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);

                if Rec."Account Type" <> xRec."Account Type" then begin
                    if "Account No." <> '' then begin
                        if not Confirm(MSG001, false) then begin
                            "Account Type" := xRec."Account Type";
                            exit;
                        end;

                        "Account No." := '';
                        "Account Name" := '';
                        "Bank Code" := '';
                        "Bank Name" := '';
                        "Bank Account No." := '';
                        "Account Holder" := '';
                    end;
                end;
            end;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released,Post,Canceled,Completed';
            OptionMembers = Open,Released,Post,Canceled,Completed;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Full Name"; Text[80])
        {
            Caption = 'Full Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Employee)) DK_Employee."No." WHERE(Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Vendor)) DK_Vendor."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
                _Vendor: Record DK_Vendor;
            begin

                TestField(Status, Status::Open);

                if "Account Type" = "Account Type"::Employee then begin
                    if _Employee.Get("Account No.") then begin
                        "Account Name" := _Employee.Name;
                        Validate("Department Code", _Employee."Department Code");
                        GetAccountBank("Account No.");
                    end else begin
                        "Account Name" := '';
                        Validate("Department Code", '');
                        GetAccountBank('');
                    end
                end else begin
                    if _Vendor.Get("Account No.") then begin
                        "Account Name" := _Vendor.Name;
                        GetAccountBank("Account No.");
                    end else begin
                        "Account Name" := '';
                        GetAccountBank('');
                    end;
                end;
            end;
        }
        field(8; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Employee)) DK_Employee."No." WHERE(Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Vendor)) DK_Vendor."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "Account Type" = "Account Type"::Employee then begin
                    Validate("Account No.", Employee.GetEmployeeNo("Account Name"));
                end else begin
                    Validate("Account No.", Vendor.GetVendorNo("Account Name"));
                end;
            end;
        }
        field(9; "Bank Code"; Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(10; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(11; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(12; "Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(19; "Payment Request Date"; Date)
        {
            Caption = 'Payment Request Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(20; "Payment Completion Date"; Date)
        {
            Caption = 'Payment Completion Date';
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(23; "GroupWare Doc. No."; Code[30])
        {
            Caption = 'GroupWare Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(24; TotalAmount; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Request Expenses Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'TotalAmount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(25; "Purchases Date"; Date)
        {
            Caption = 'Purchases Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(26; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                if _Department.Get("Department Code") then
                    "Department Name" := _Department.Name
                else
                    "Department Name" := '';
            end;
        }
        field(27; "Department Name"; Text[30])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code", _Department.GetDeptCode("Department Name"));
            end;
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
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Account Type")
        {
        }
        key(Key3; Status)
        {
        }
        key(Key4; "Account No.")
        {
        }
        key(Key5; "Account Name")
        {
        }
        key(Key6; "Bank Code")
        {
        }
        key(Key7; "Bank Name")
        {
        }
        key(Key8; "Bank Account No.")
        {
        }
        key(Key9; "Payment Request Date")
        {
        }
        key(Key10; "Posting Date", Status, "Department Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Account Type", "Account No.", "Account Name", "Bank Name")
        {
        }
    }

    trigger OnDelete()
    var
        _RequestExpensesLine: Record "DK_Request Expenses Line";
    begin

        TestField(Status, Status::Open);

        _RequestExpensesLine.Reset;
        _RequestExpensesLine.SetRange("Document No.", "No.");
        _RequestExpensesLine.SetRange("Document Type", "Account Type");
        if _RequestExpensesLine.FindSet then
            _RequestExpensesLine.DeleteAll(true);
    end;

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Request Expesnsed Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Request Expesnsed Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;

        _DepartmentBoard.Check_EmployeeUserID(UserId);

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        Employee: Record DK_Employee;
        Vendor: Record DK_Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'The contents of the account are initialized. Do you want to continue?';
        MSG002: Label 'Changes need to be %1.';
        MSG003: Label 'It can not be selected because there is no bank information.';
        MSG004: Label 'The information that exists in the %1. %2 : %3';


    procedure AssistEdit(OldReqExpensesHeader: Record "DK_Request Expenses Header"): Boolean
    begin
        with OldReqExpensesHeader do begin
            OldReqExpensesHeader := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Request Expesnsed Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Request Expesnsed Nos.", OldReqExpensesHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldReqExpensesHeader;
                exit(true);
            end;
        end;
    end;


    procedure SetReleased()
    var
        _ReqExpPost: Codeunit "DK_Request Expenses - Post";
    begin

        if _ReqExpPost.CheckValue(Rec) then begin
            Status := Rec.Status::Released;
            Modify;
        end;
    end;


    procedure SetReOpen()
    begin
        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetPost(): Boolean
    var
        _RequExpPost: Codeunit "DK_Request Expenses - Post";
    begin

        if Status <> Status::Released then
            Error(MSG002, Status::Released)
        else begin
            _RequExpPost.Post(Rec);
            exit(true);
        end;
    end;


    procedure GetAccountBank("pNo.": Code[20])
    var
        _Employee: Record DK_Employee;
        _Vendor: Record DK_Vendor;
    begin
        if "pNo." = '' then begin
            "Bank Code" := '';
            "Bank Name" := '';
            "Bank Account No." := '';
            "Account Holder" := '';
            Modify;
            exit;
        end;


        if "Account Type" = "Account Type"::Employee then begin
            _Employee.Reset;
            _Employee.SetRange("No.", "pNo.");
            if _Employee.FindFirst then begin
                if (_Employee."Bank Code" = '') or
                  (_Employee."Bank Account No." = '') then
                    Error(MSG003);
                Validate("Bank Code", _Employee."Bank Code");
                Validate("Bank Name", _Employee."Bank Name");
                Validate("Bank Account No.", _Employee."Bank Account No.");
                Validate("Account Holder", _Employee."Account Holder");
            end;
        end else begin
            _Vendor.Reset;
            _Vendor.SetRange("No.", "pNo.");
            if _Vendor.FindFirst then begin
                if (_Vendor."Bank Code" = '') or
                  (_Vendor."Bank Account No." = '') then
                    Error(MSG003);
                Validate("Bank Code", _Vendor."Bank Code");
                Validate("Bank Name", _Vendor."Bank Name");
                Validate("Bank Account No.", _Vendor."Bank Account No.");
                Validate("Account Holder", _Vendor."Account Holder");
            end;
        end;

        Modify;
    end;


    procedure Check_ReqRemittLedger(): Boolean
    var
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
    begin

        _ReqRemLedger.Reset;
        _ReqRemLedger.SetRange("Source No.", "No.");
        _ReqRemLedger.SetRange("Source Type", _ReqRemLedger."Source Type"::Expenses);
        if _ReqRemLedger.FindSet then
            Error(MSG004, _ReqRemLedger.TableCaption, _ReqRemLedger.FieldCaption("Source No."), _ReqRemLedger."Source No.");
    end;
}

