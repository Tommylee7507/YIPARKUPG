table 50046 "DK_Customer Requests"
{
    Caption = 'Customer Requests';
    DataCaptionFields = "No.";
    DrillDownPageID = "DK_Customer Requests List";
    LookupPageID = "DK_Customer Requests List";

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
                    NoSeriesMgt.TestManual(FunctionSetup."Customer Requests Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Title; Text[30])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(3; "Customer Status"; Option)
        {
            Caption = 'Customer Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,NonCustomer';
            OptionMembers = Customer,NonCustomer;

            trigger OnValidate()
            var
                _Customer: Record DK_Customer;
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if "Customer Status" = "Customer Status"::NonCustomer then
                    Validate("Contract No.", '');
            end;
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                TestField(Status, Status::Open);

                if _Employee.Get("Employee No.") then
                    "Employee name" := _Employee.Name
                else
                    "Employee name" := '';
            end;
        }
        field(5; "Employee name"; Text[50])
        {
            Caption = 'Employee name';
            TableRelation = DK_Employee;

            trigger OnValidate()
            begin
                Validate("Employee No.", Employee.GetEmployeeNo("Employee name"));
            end;
        }
        field(6; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if _Contract.Get("Contract No.") then begin
                    Validate("Main Customer No.", _Contract."Main Customer No.");
                    Validate("Cemetery Code", _Contract."Cemetery Code");
                    Validate("Work Cemetery Code", _Contract."Cemetery Code");
                end else begin
                    Validate("Main Customer No.", '');
                    Validate("Cemetery Code", '');
                    Validate("Work Cemetery Code", '');
                end;
            end;
        }
        field(7; "Main Customer Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Cust. Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Cust. Mobile No." <> "Cust. Mobile No." then begin
                    if "Cust. Mobile No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Cust. Mobile No.") then
                            Error(MSG006, FieldCaption("Cust. Mobile No."));
                end;
            end;
        }
        field(9; "Cust. Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Cust. Phone No." <> "Cust. Phone No." then begin
                    if "Cust. Phone No." <> '' then
                        if not _CommFun.CheckValidPhoneNo("Cust. Phone No.") then
                            Error(MSG006, FieldCaption("Cust. Phone No."));
                end;
            end;
        }
        field(10; "Cust. E-mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer E-Mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."Cust. E-mail" <> "Cust. E-mail" then begin
                    _MailMgt.ValidateEmailAddressField("Cust. E-mail");
                end;
            end;
        }
        field(12; "Appl. Name"; Text[30])
        {
            Caption = 'Appl. Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(13; "Appl. Mobile No."; Text[30])
        {
            Caption = 'Appl. Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if xRec."Appl. Mobile No." <> "Appl. Mobile No." then begin
                    if "Appl. Mobile No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Appl. Mobile No.") then
                            Error(MSG006, FieldCaption("Appl. Mobile No."));
                end;
            end;
        }
        field(14; "Appl. Phone No."; Text[30])
        {
            Caption = 'Appl. Phone No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if xRec."Appl. Phone No." <> "Appl. Phone No." then begin
                    if "Appl. Phone No." <> '' then
                        if not _CommFun.CheckValidPhoneNo("Appl. Phone No.") then
                            Error(MSG006, FieldCaption("Appl. Phone No."));
                end;
            end;
        }
        field(15; "Appl. E-mail"; Text[80])
        {
            Caption = 'Appl. E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if xRec."Appl. E-mail" <> "Appl. E-mail" then begin
                    _MailMgt.ValidateEmailAddressField("Appl. E-mail");
                end;
            end;
        }
        field(16; "Relationship With Cust."; Text[30])
        {
            Caption = 'Relationship With Cust.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(17; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(18; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            Editable = false;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(19; "Receipt Method"; Option)
        {
            Caption = 'Receipt Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'Visit,Homepage,Phone,Park,Other';
            OptionMembers = Visit,Homepage,Phone,Park,Other;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(20; "Receipt Division"; Option)
        {
            Caption = 'Receipt Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'Demand,Indicate';
            OptionMembers = Demand,Indicate;
        }
        field(21; "Work Division"; Option)
        {
            Caption = 'Work Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Urgency';
            OptionMembers = Normal,Urgency;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(22; "Receipt Contents"; Text[250])
        {
            Caption = 'Receipt Contents';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(23; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
        }
        field(24; "Process Date"; Date)
        {
            Caption = 'Process Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FieldWorkHeader: Record "DK_Field Work Header";
            begin

                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
                WorkBlockedCheck(Rec);
            end;
        }
        field(25; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Post,Complete,Impossible,Release,Cancel,Hold';
            OptionMembers = Open,Post,Complete,Impossible,Release,Cancel,Hold;
        }
        field(26; "Feedback Date"; Date)
        {
            Caption = 'Feedback Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(27; Lawn; Text[30])
        {
            Caption = 'Lawn';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(28; "Work Indicator"; Text[30])
        {
            Caption = 'Work Indicator';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(29; "Work Manager"; Text[50])
        {
            Caption = 'Work Manager';
            TableRelation = "DK_Work Manager".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Work Manager Code", WorkManager.GetWorkManagerCode("Work Manager"));
            end;
        }
        field(30; "Work Group"; Text[30])
        {
            Caption = 'Work Group';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Work Group Code", WorkGroup.GetWorkGroupCode("Work Group"));
            end;
        }
        field(31; "Work Personnel"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Work Personnel';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(32; "Work Time Spent"; Decimal)
        {
            Caption = 'Work Time Spent';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(33; "Process Content"; Text[250])
        {
            Caption = 'Process Content';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FieldWorkHeader: Record "DK_Field Work Header";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
                WorkBlockedCheck(Rec);
            end;
        }
        field(34; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(35; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(37; "Work Manager Code"; Code[20])
        {
            Caption = 'Work Manager Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Manager".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkManager: Record "DK_Work Manager";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if _WorkManager.Get("Work Manager Code") then
                    "Work Manager" := _WorkManager.Name
                else
                    "Work Manager" := '';
            end;
        }
        field(38; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkGroup: Record "DK_Work Group";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
                if _WorkGroup.Get("Work Manager Code") then
                    "Work Group" := _WorkGroup.Name
                else
                    "Work Group" := '';
            end;
        }
        field(39; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            Editable = false;
        }
        field(40; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Receipt Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                else
                    "Field Work Sub Cat. Name" := '';

                "Receipt Contents" := '';
                "Process Content" := '';
                "Process Date" := 0D;
            end;
        }
        field(41; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Receipt Type Name';
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Field Work Sub Cat. Code", FieldWorkSubCategory.GetFieldWorkSCode("Field Work Sub Cat. Name", "Field Work Main Cat. Code"));
            end;
        }
        field(42; "Work Time From"; Time)
        {
            Caption = 'Work Time From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(43; "Work Time to"; Time)
        {
            Caption = 'Work Time to';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);
            end;
        }
        field(44; "Field Work Header No."; Code[20])
        {
            Caption = 'Field Work Header No.';
            DataClassification = ToBeClassified;
        }
        field(45; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                CalcFields("Main Customer Name", "Cust. Phone No.", "Cust. Mobile No.", "Cust. E-mail");
            end;
        }
        field(46; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if _Cemetery.Get("Cemetery Code") then begin
                    "Cemetery No." := _Cemetery."Cemetery No.";
                    _Cemetery.CalcFields("Estate Type");

                    if Rec."Service Type" = 0 then begin

                        if _Cemetery."Estate Type" = _Cemetery."Estate Type"::Charnelhouse then begin
                            Error(ERR002);
                        end;
                    end else begin
                        if _Cemetery."Estate Type" <> _Cemetery."Estate Type"::Charnelhouse then begin
                            Error(ERR001);
                        end;
                    end;

                end else begin
                    "Cemetery No." := '';
                end;
            end;
        }
        field(47; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Work Cemetery Code"; Code[20])
        {
            Caption = 'Work Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                TestField(Status, Status::Open);
                Check_FieldWork(Rec);

                if _Cemetery.Get("Work Cemetery Code") then
                    "Work Cemetery No." := _Cemetery."Cemetery No."
                else
                    "Work Cemetery No." := '';
            end;
        }
        field(49; "Work Cemetery No."; Text[20])
        {
            Caption = 'Work Cemetery No.';
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Work Cemetery Code", Cemetery.GetCemeteryCode("Work Cemetery No."));
            end;
        }
        field(50; "Per. Info. Aggreement"; Boolean)
        {
            Caption = 'Personal Information Aggreement';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(51; "Email Status"; Boolean)
        {
            Caption = 'Email Status';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "Email Status" then begin
                    "Appl. E-mail" := '';
                end;
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
        field(50000; "Service Type"; Option)
        {
            Caption = 'Œ¡Š±Š ‘Ž‡õ';
            DataClassification = ToBeClassified;
            Description = 'DK';
            OptionCaption = 'normal,honorstone';
            OptionMembers = "0","1";
        }
        field(59000; idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59001; crm_voc_guid; Text[40])
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
        key(Key2; "Receipt Date")
        {
        }
        key(Key3; "Contract No.")
        {
        }
        key(Key4; "Employee name")
        {
        }
        key(Key5; "Employee No.")
        {
        }
        key(Key6; "Customer Status")
        {
        }
        key(Key7; "Process Date")
        {
        }
        key(Key8; "Receipt Method")
        {
        }
        key(Key9; "Receipt Date", Status)
        {
        }
        key(Key10; "Process Date", Status)
        {
        }
        key(Key11; "Receipt Date", "Process Date", Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        if Status = Rec.Status::Complete then
            Error(MSG003, FieldCaption(Status), Status::Complete);

        TestField(Status, Status::Open);

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("No.", "Field Work Header No.");
        _FieldWorkHeader.SetRange("Field Work Main Cat. Code", Rec."Field Work Main Cat. Code");
        if _FieldWorkHeader.FindSet then begin
            Error(MSG004, _FieldWorkHeader.TableCaption, _FieldWorkHeader."No.");
        end;
    end;

    trigger OnInsert()
    var
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
        _DepartmentBoard: Record "DK_Department Board";
    begin

        FunctionSetup.Get;
        if FunctionSetup."Receipt Type Code" = '' then
            Error(MSG002, FunctionSetup.TableCaption, FunctionSetup.FieldCaption("Receipt Type Code"));

        if "Field Work Main Cat. Code" = '' then begin
            "Field Work Main Cat. Code" := FunctionSetup."Receipt Type Code";
            if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then
                "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name;
        end;

        if UserId <> 'ADMIN' then
            _DepartmentBoard.Check_EmployeeUserID(UserId);

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Customer Requests Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Customer Requests Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        TestField("No.");

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        FunctionSetup.Get;
        if FunctionSetup."Receipt Type Code" = '' then
            Error(MSG002, FunctionSetup.TableCaption, FunctionSetup.FieldCaption("Receipt Type Code"));

        TestField("No.");
        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        Employee: Record DK_Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'No %1 information available.';
        WorkManager: Record "DK_Work Manager";
        WorkGroup: Record "DK_Work Group";
        FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        MSG002: Label 'The %2 has not been set in %1.';
        MSG003: Label 'If %1 is not %2, you can not modify or delete it.';
        MSG004: Label 'It is a document transferred to the %1.';
        MSG005: Label 'Documents for which %1 have been %2 can not be Modify or deleted.';
        Cemetery: Record DK_Cemetery;
        MSG006: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG007: Label 'It''s already %1.';
        MSG008: Label 'Not %1. Check %2';
        ERR001: Label 'Ÿ‰¦ ‰ª¬…Ø‡ŸŠ Ÿ‰¦ ×„ Í“‹íŒ¡ …Ø‡Ÿ—¹ŽÈ —³„Ÿ„¾. ';
        ERR002: Label 'Ž–‚šŠ•µ ‰ª¬…Ø‡ŸŠ Ž–‚šŠ•µ ×„ Í“‹íŒ¡ …Ø‡Ÿ—¹ŽÈ —³„Ÿ„¾. ';


    procedure AssistEdit(OldCustomerReq: Record "DK_Customer Requests"): Boolean
    var
        _CustomerReq: Record "DK_Customer Requests";
    begin
        with _CustomerReq do begin
            _CustomerReq := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Customer Requests Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Customer Requests Nos.", OldCustomerReq."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _CustomerReq;
                exit(true);
            end;
        end;
    end;


    procedure AppllicantInset(Cofirm: Boolean)
    var
        _Customer: Record DK_Customer;
    begin
        if Cofirm then begin
            Check_FieldWork(Rec);
            if "Contract No." <> '' then begin
                "Appl. Name" := "Main Customer Name";
                "Appl. Mobile No." := "Cust. Mobile No.";
                "Appl. Phone No." := "Cust. Phone No.";
                "Appl. E-mail" := "Cust. E-mail";
                "Work Cemetery Code" := "Cemetery Code";
                "Work Cemetery No." := "Cemetery No.";
            end
            else
                Error(MSG001, _Customer.TableCaption);
        end;
    end;


    procedure Check_FieldWork(pCustomerReq: Record "DK_Customer Requests")
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Source No.", "No.");
        _FieldWorkHeader.SetRange("Field Work Main Cat. Code", pCustomerReq."Field Work Main Cat. Code");
        _FieldWorkHeader.SetRange("Field Work Sub Cat. Code", pCustomerReq."Field Work Sub Cat. Code");
        if _FieldWorkHeader.FindSet then
            Error(MSG004, _FieldWorkHeader.TableCaption, _FieldWorkHeader."No.");
    end;


    procedure SetOpen()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        if Status = Rec.Status::Complete then
            Error(MSG007, Format(Status::Complete));

        Check_FieldWork(Rec);

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetComplete()
    var
        _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
    begin

        WorkBlockedCheck(Rec);
        _CustomerRequestPost.SetComplete(Rec);
    end;


    procedure WorkBlockedCheck(pCustomerReq: Record "DK_Customer Requests")
    var
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkSubCategory.Reset;
        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", pCustomerReq."Field Work Main Cat. Code");
        _FieldWorkSubCategory.SetRange(Code, pCustomerReq."Field Work Sub Cat. Code");
        _FieldWorkSubCategory.SetRange("Work Blocked", false);
        if _FieldWorkSubCategory.FindSet then
            Error(MSG008, _FieldWorkSubCategory.FieldCaption("Work Blocked"), _FieldWorkSubCategory.TableCaption);
    end;


    procedure SetRelease()
    var
        _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
    begin
        Check_FieldWork(Rec);
        if Status = Rec.Status::Complete then
            Error(MSG007, Format(Status::Complete));

        if not _CustomerRequestPost.CheckValue(Rec) then exit;

        if "Customer Status" = "Customer Status"::Customer then
            TestField("Contract No.");

        Status := Rec.Status::Release;
        Modify;
    end;
}

