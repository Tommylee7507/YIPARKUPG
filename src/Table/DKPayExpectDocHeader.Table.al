table 50111 "DK_Pay. Expect Doc. Header"
{
    Caption = 'Payment Expect Document Header';
    DrillDownPageID = "DK_Pay. Expect Document List";
    LookupPageID = "DK_Pay. Expect Document List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;

            trigger OnLookup()
            var
                _PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
            begin
            end;

            trigger OnValidate()
            var
                _PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
            begin

                if "Document No." <> xRec."Document No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Pay. Expect Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _FunSetup: Record "DK_Function Setup";
            begin
                if xRec."Document Date" <> "Document Date" then begin

                    _FunSetup.Get;
                    if "Document Date" = 0D then
                        "Expiration Date" := 0D
                    else begin
                        "Expiration Date" := CalcDate(_FunSetup."Payment Expect Due Period", "Document Date");
                    end;
                end;
            end;
        }
        field(4; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Expiration Date" <> "Expiration Date" then begin

                    CheckUnAssginDate;

                    if "Expiration Date" <> 0D then
                        if "Expiration Date" <= Today then
                            Error(MSG006, FieldCaption("Expiration Date"), Today);
                end;
            end;
        }
        field(5; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No." WHERE(Status = FILTER(Open | Contract | FullPayment | Reservation));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _PaymentExpect: Codeunit "DK_Payment Expect";
                _PayExpectProHis: Record "DK_Pay. Expect Process History";
                _PayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
            begin
                if xRec."Contract No." <> "Contract No." then begin
                    CheckAssginDate;

                    if _Contract.Get("Contract No.") then begin
                        "Cemetery Code" := _Contract."Cemetery Code";
                        "Cemetery No." := _Contract."Cemetery No.";

                        _Contract.CalcFields("Cust. Mobile No.", "Main Associate Mobile No.", "Main Associate Name", "Sub Associate Mobile No.", "Sub Associate Name");

                        case _Contract."Contact Target" of
                            _Contract."Contact Target"::MainCustomer:
                                begin
                                    "Appl. Mobile No." := _Contract."Cust. Mobile No.";
                                    "Appl. Name" := _Contract."Main Customer Name";
                                end;
                            _Contract."Contact Target"::MainAssociate:
                                begin
                                    "Appl. Mobile No." := _Contract."Main Associate Mobile No.";
                                    "Appl. Name" := _Contract."Main Associate Name";
                                end;
                            _Contract."Contact Target"::SubAssociate:
                                begin
                                    "Appl. Mobile No." := _Contract."Sub Associate Mobile No.";
                                    "Appl. Name" := _Contract."Sub Associate Name";
                                end;
                        end;
                    end else begin
                        "Cemetery Code" := '';
                        "Cemetery No." := '';
                        "Appl. Mobile No." := '';
                        "Appl. Name" := '';
                    end;

                    CalcFields("Pay. Remaining Amount");
                end;
            end;
        }
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Direct PG,PG,Virtual Account';
            OptionMembers = DirectPG,PG,VA;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Payment Type" <> "Payment Type" then begin
                    CheckAssginDate;

                    case "Payment Type" of
                        "Payment Type"::DirectPG, "Payment Type"::PG:
                            begin
                                "Virtual Account No." := '';
                                "PG URL" := '';
                                "Issued Cash Receipts" := false;
                                "Issued Cash Rec. Mobile" := '';
                                "Cash Bill Approval No." := '';
                            end;
                        "Payment Type"::VA:
                            begin
                                "PG URL" := '';
                            end;
                    end;
                end;
            end;
        }
        field(7; "Virtual Account No."; Code[20])
        {
            Caption = 'Virtual Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Type" = CONST(VA)) "DK_Virtual Account"."Virtual Account No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                CalcFields("Bank Code", "Bank Name", "Account Holder");
            end;
        }
        field(8; "VA Status Code"; Code[20])
        {
            Caption = 'VA Status Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("VA Status");
            end;
        }
        field(9; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Contract,Service,Publish Admin. Expense';
            OptionMembers = "None",Contract,Service,AdminExpense;
        }
        field(10; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            var
                _Contract: Record DK_Contract;
                _ContractCard: Page "DK_Contract Card";
                _CemServices: Record "DK_Cemetery Services";
                _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
                _PublishAdExpDetail: Page "DK_Publish Ad. Exp. Line Detai";
            begin

                case "Source Type" of
                    "Source Type"::Contract:
                        begin

                            _Contract.Reset;
                            _Contract.SetRange("No.", "Source No.");
                            if _Contract.FindSet then begin
                                Clear(_ContractCard);
                                _ContractCard.LookupMode(true);
                                _ContractCard.SetTableView(_Contract);
                                _ContractCard.SetRecord(_Contract);
                                _ContractCard.RunModal;
                            end;
                        end;
                    "Source Type"::Service:
                        begin
                            _CemServices.Reset;
                            _CemServices.SetRange("No.", "Source No.");
                            if _CemServices.FindSet then begin
                                _CemServices.ShowCemeteryServiceCard(_CemServices);
                            end;
                        end;
                    "Source Type"::AdminExpense:
                        begin
                            _PublishAdminExpDocLine.Reset;
                            _PublishAdminExpDocLine.SetRange("Document No.", "Source No.");
                            _PublishAdminExpDocLine.SetRange("Line No.", "Source Line No.");
                            if _PublishAdminExpDocLine.FindSet then begin
                                Clear(_PublishAdExpDetail);
                                _PublishAdExpDetail.LookupMode(true);
                                _PublishAdExpDetail.SetTableView(_PublishAdminExpDocLine);
                                _PublishAdExpDetail.SetRecord(_PublishAdminExpDocLine);
                                _PublishAdExpDetail.RunModal;
                            end;
                        end;
                end;
            end;
        }
        field(11; "Pay. Receipt Doc. No."; Code[20])
        {
            Caption = 'Payment Receipt Document No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            var
                _PayReceiptDoc: Record "DK_Payment Receipt Document";
            begin
                if "Pay. Receipt Doc. No." <> '' then
                    _PayReceiptDoc.ShowPostedPaymentDocument("Pay. Receipt Doc. No.");
            end;
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(13; "Appl. Mobile No."; Text[30])
        {
            Caption = 'Appl. Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                MSG001: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Appl. Mobile No." <> "Appl. Mobile No." then begin
                    if "Appl. Mobile No." <> '' then begin
                        if not _CommFun.CheckValidMobileNo("Appl. Mobile No.") then
                            Error(MSG001, FieldCaption("Appl. Mobile No."));
                    end;
                end;
            end;
        }
        field(14; "Appl. Name"; Text[30])
        {
            Caption = 'Appl. Name';
            DataClassification = ToBeClassified;
        }
        field(15; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Payment Date" <> "Payment Date" then begin
                    if "Payment Date" <> 0D then
                        "UnAssgin Date" := "Payment Date"
                    else
                        "UnAssgin Date" := 0D;
                end;
            end;
        }
        field(16; "Source Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "PG Approval No."; Text[30])
        {
            Caption = 'PG Approval No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "PG URL"; Text[1024])
        {
            Caption = 'PG URL';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."PG URL" <> "PG URL" then begin
                    if "PG URL" = '' then
                        "Assgin Date" := 0D
                    else
                        "Assgin Date" := Today;
                end;
            end;
        }
        field(20; "Bank Code"; Code[5])
        {
            CalcFormula = Lookup("DK_Virtual Account"."Bank Code" WHERE("Virtual Account No." = FIELD("Virtual Account No.")));
            Caption = 'Bank Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Bank Name"; Text[20])
        {
            CalcFormula = Lookup("DK_Virtual Account"."Bank Name" WHERE("Virtual Account No." = FIELD("Virtual Account No.")));
            Caption = 'Bank Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Account Holder"; Text[30])
        {
            CalcFormula = Lookup("DK_Virtual Account"."Account Holder" WHERE("Virtual Account No." = FIELD("Virtual Account No.")));
            Caption = 'Account Holder';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "VA Status"; Text[50])
        {
            CalcFormula = Lookup("DK_Result Status".Name WHERE(Type = CONST(VA),
                                                                Code = FIELD("VA Status Code")));
            Caption = 'VA Status';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Last SMS Sent Date"; Date)
        {
            Caption = 'Last SMS Sent Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "UnAssgin Date"; Date)
        {
            Caption = 'UnAssgin Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Payment Remark"; Text[100])
        {
            Caption = 'Payment Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
        }
        field(28; "Cemetery No."; Text[30])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
        }
        field(29; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                            Type = CONST(Online));

            trigger OnValidate()
            begin

                PaymentMothed.Reset;
                PaymentMothed.SetRange(Type, PaymentMothed.Type::Online);
                PaymentMothed.SetRange(Code, "Payment Method Code");
                if PaymentMothed.FindSet then begin
                    "Payment Method Name" := PaymentMothed.Name;
                end else begin
                    "Payment Method Name" := '';
                end;
            end;
        }
        field(30; "Payment Method Name"; Text[50])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                            Type = CONST(Online));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Payment Method Code", PaymentMothed.GetCode(PaymentMothed.Type::Online, "Payment Method Name"));
            end;
        }
        field(31; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                CheckAssginDate;
                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(33; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee.Name WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                CheckAssginDate;
                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(34; "Assgin Date"; Date)
        {
            Caption = 'Assgin Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Unit Price Type Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Unit Price Type Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Unit Price Type Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "DK_Unit Price Type";
        }
        field(36; "Payment Target Filter"; Option)
        {
            Caption = 'Payment Target Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Deposit,Contract Amount,Remaining Amount,General,Landscape Architecturee,Service';
            OptionMembers = Blank,Deposit,Contract,Remaining,General,Landscape,Service;
        }
        field(37; "Line Exists"; Boolean)
        {
            CalcFormula = Exist("DK_Pay. Expect Doc. Line" WHERE("Document No." = FIELD("Document No."),
                                                                  "Payment Target" = FIELD("Payment Target Filter")));
            Caption = 'Line Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Befor Expiration Date"; Date)
        {
            Caption = 'Befor Expiration Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Assgin,SendSMS,UnAssgin,Customer Payment,CreatePaymentReceipt';
            OptionMembers = Open,Assgin,SendSMS,UnAssgin,CustomerPayment,CreatePaymentReceipt;
        }
        field(40; "Pay. Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup(DK_Contract."Pay. Remaining Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Pay. Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;

            trigger OnValidate()
            var
                _ContAmtLedger: Record "DK_Contract Amount Ledger";
            begin
            end;
        }
        field(41; "Issued Cash Receipts"; Boolean)
        {
            Caption = 'Issued Cash Receipts';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Issued Cash Receipts" <> "Issued Cash Receipts" then begin


                    if not "Issued Cash Receipts" then begin

                        "Cash Bill Approval No." := '';
                        "Issued Cash Rec. Mobile" := '';
                    end;
                end;
            end;
        }
        field(42; "Issued Cash Rec. Mobile"; Text[30])
        {
            Caption = 'Issued Cash Receipts Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                //IF xRec."Issued Cash Rec. Mobile" <> "Issued Cash Rec. Mobile" THEN BEGIN
                //  IF "Issued Cash Rec. Mobile" <> '' THEN BEGIN
                //    IF NOT _CommFun.CheckValidMobileNo("Issued Cash Rec. Mobile") THEN
                //      ERROR(MSG007, FIELDCAPTION("Issued Cash Rec. Mobile"));
                //  END;
                //END;
            end;
        }
        field(43; "Cash Bill Approval No."; Text[20])
        {
            Caption = 'Cash Bill Approval No.';
            DataClassification = ToBeClassified;
        }
        field(44; "VA Process Status"; Option)
        {
            Caption = 'VA Process Status';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Receipt,Cancel,Settlement';
            OptionMembers = "None",Receipt,Cancel,Settlement;
        }
        field(45; "Pay. Receipt Doc. Posted"; Boolean)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document".Posted WHERE("Document No." = FIELD("Pay. Receipt Doc. No.")));
            Caption = 'Payment Receipt Document Posted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Pay. Receipt Doc. Posting Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Posting Date" WHERE("Document No." = FIELD("Pay. Receipt Doc. No.")));
            Caption = 'Pay. Receipt Doc. Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Payment Time"; Time)
        {
            Caption = 'ß‘ª “ú';
            DataClassification = ToBeClassified;
        }
        field(48; "Line General Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                          "Payment Target" = CONST(General)));
            Caption = 'General Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Line Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                          "Payment Target" = CONST(Landscape)));
            Caption = 'Land. Arc. Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Line Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                          "Payment Target" = CONST(Contract)));
            Caption = 'Contract Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Line Service Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                          "Payment Target" = CONST(Service)));
            Caption = 'Service Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Line Deposit Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                          "Payment Target" = CONST(Deposit)));
            Caption = 'Deposit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Line Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                          "Payment Target" = CONST(Remaining)));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
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
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Date")
        {
        }
        key(Key3; "Expiration Date")
        {
        }
        key(Key4; "Contract No.")
        {
        }
        key(Key5; "Payment Type")
        {
        }
        key(Key6; "Virtual Account No.")
        {
        }
        key(Key7; "Source Type", "Source No.")
        {
        }
        key(Key8; "Pay. Receipt Doc. No.")
        {
        }
        key(Key9; "Appl. Mobile No.")
        {
        }
        key(Key10; "Appl. Name")
        {
        }
        key(Key11; "Payment Date")
        {
        }
        key(Key12; "UnAssgin Date")
        {
        }
        key(Key13; "Cemetery Code")
        {
        }
        key(Key14; "Cemetery No.")
        {
        }
        key(Key15; "Payment Type", "Expiration Date", "Assgin Date", "UnAssgin Date")
        {
        }
        key(Key16; "Payment Type", "Expiration Date", "Assgin Date", "UnAssgin Date", "Pay. Receipt Doc. No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Expiration Date", "Contract No.", "Cemetery No.", "Payment Type", "Last SMS Sent Date", "Virtual Account No.", "Appl. Mobile No.", "Appl. Name", "VA Status", "Assgin Date", "UnAssgin Date")
        {
        }
    }

    trigger OnDelete()
    var
        _PayExpDocLine: Record "DK_Pay. Expect Doc. Line";
    begin
        TestField(Status, Status::Open);

        CheckAssginDate;
        CheckUnAssginDate;

        _PayExpDocLine.Reset;
        _PayExpDocLine.SetRange("Document No.", "Document No.");
        if _PayExpDocLine.FindSet then
            _PayExpDocLine.DeleteAll(true);
    end;

    trigger OnInsert()
    var
        _Employee: Record DK_Employee;
    begin


        if "Document No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Pay. Expect Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Pay. Expect Nos.", xRec."No. Series", "Document Date", "Document No.", "No. Series");
        end;

        TestField("Document No.");

        if "Document Date" = 0D then
            Validate("Document Date", Today);

        if "Employee No." = '' then
            Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));


        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        CheckDocument;

        if "Payment Type" <> "Payment Type"::DirectPG then
            TestField("Document No.");

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
        MSG001: Label '%1 cannot be earlier than today. Today : %2';
        MSG002: Label '%1 cannot be earlier than %2. %2 : %3';
        MSG003: Label 'Documents with %1 cannot be modified or deleted. %1:%2';
        MSG004: Label '%1 %2 is already in use. You cannot use the same %1.';
        PaymentMothed: Record "DK_Payment Method";
        MSG005: Label 'The document with %1 %2 cannot be modified or deleted.';
        MSG006: Label '%1 cannot be less than %2.';
        MSG007: Label 'The value exists in %1.';


    procedure AssistEdit(OldPayExpectDocHeader: Record "DK_Pay. Expect Doc. Header"): Boolean
    var
        _RecPayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
    begin
        with _RecPayExpectDocHeader do begin
            _RecPayExpectDocHeader := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Pay. Expect Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Pay. Expect Nos.", OldPayExpectDocHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                Rec := _RecPayExpectDocHeader;
                exit(true);
            end;
        end;
    end;


    procedure CheckDocument()
    begin
        /*
        IF "Pay. Receipt Doc. No." <> '' THEN
          ERROR(MSG003, FIELDCAPTION("Pay. Receipt Doc. No."),"Pay. Receipt Doc. No.");
        
        IF "Virtual Account No." <> '' THEN
          ERROR(MSG003, FIELDCAPTION("Virtual Account No."),"Virtual Account No.");
        
        IF "Payment Type" = "Payment Type"::DirectPG THEN
          ERROR(MSG005, FIELDCAPTION("Payment Type"), "Payment Type"::DirectPG);
        
        IF "Last SMS Sent Date" <> 0D THEN
          ERROR(MSG003,FIELDCAPTION("Last SMS Sent Date"),"Last SMS Sent Date");
        */

    end;


    procedure UpdatePGURL()
    var
        _FunSetup: Record "DK_Function Setup";
    begin

        if "Document No." <> '' then begin
            _FunSetup.Get;
            _FunSetup.TestField("PG URL");
            "PG URL" := StrSubstNo(_FunSetup."PG URL", "Document No.");
        end;
    end;

    local procedure CheckUnAssginDate()
    begin

        if "UnAssgin Date" <> 0D then
            Error(MSG007, FieldCaption("UnAssgin Date"), "UnAssgin Date");
    end;

    local procedure CheckAssginDate()
    begin

        if "Assgin Date" <> 0D then
            Error(MSG007, FieldCaption("Assgin Date"), "Assgin Date");
    end;
}

