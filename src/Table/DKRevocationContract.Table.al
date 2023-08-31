table 50089 "DK_Revocation Contract"
{
    // //CRM ¼…
    // *DK33 : 2020-07-30
    //   - Add Field : "Estate Type"
    //   - Modify Function : Cemetery Code - OnValidate()
    // 
    // *DK34 : 2020-11-29
    //   - Add Field : "CRM SalesPerson Code"
    //       : 2020-11-30
    //   - Modify Field : "Contract Type"
    //   - Modify Trigger : Contract Type - OnValidate()

    Caption = 'Revocation Contract';
    DataCaptionFields = "Document No.", "Document Date", "Contract No.", "Customer Name", "Contract Date", "Revocation Date";
    DrillDownPageID = "DK_Revocation Contract List";
    LookupPageID = "DK_Revocation Contract List";

    fields
    {
        field(1; "Document No."; Code[10])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Revocation Contract Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract WHERE(Status = FILTER(<> Revocation & <> Open),
                                               "Revocation Register" = FILTER(false));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _RevContract: Record "DK_Revocation Contract";
            begin
                if xRec."Contract No." <> "Contract No." then begin
                    TestField(Status, Status::Open);

                    if "Contract No." <> '' then begin
                        _RevContract.Reset;
                        _RevContract.SetFilter("Document No.", '<>%1', "Document No.");
                        _RevContract.SetRange("Contract No.", "Contract No.");
                        _RevContract.SetFilter(Status, '<>%1', _RevContract.Status::Complate);
                        if _RevContract.FindSet then
                            Error(MSG014, FieldCaption("Document No."), "Document No.");
                    end;

                    CalcFields("Contract Status", "Deposit Amount", "Contract Amount");
                    CalcFields("Remaining Amount", "Payment Amount", "Pay. Remaining Amount");

                    DelRequestDocumentRec("Document No.");

                    Validate("Revocation Date", 0D);
                    //CLEAR(Contents);
                    //"Short Contents" := '';
                    "Refund Rate" := 0;
                    "Sales Rev. Amount" := 0;
                    "Sys. Refund Cemetery Amount" := 0;
                    "Sys. Refund General Amount" := 0;
                    "Sys. Refund Land. Arc. Amount" := 0;
                    "Sys. Refund Bury Amount" := 0;
                    "System Refund Amount" := 0;
                    "Refund Cemetery Amount" := 0;
                    "Refund General Amount" := 0;
                    "Refund Land. Arc. Amount" := 0;
                    "Refund Bury Amount" := 0;
                    Validate("Apply Refund Amount", 0);
                    Validate("Refund Starting Date", 0D);
                    Validate("Bank Code", '');
                    Validate("Bank Account No.", '');

                    if _Contract.Get("Contract No.") then begin
                        Validate("Supervise No.", _Contract."Supervise No.");
                        Validate("Cemetery Code", _Contract."Cemetery Code");
                        Validate("Customer No.", _Contract."Main Customer No.");
                        Validate("Customer Name", _Contract."Main Customer Name");
                        Validate("Contract Date", _Contract."Contract Date");
                        Validate("Account Holder", _Contract."Main Customer Name");
                        case _Contract.Status of
                            _Contract.Status::Revocation:
                                begin
                                    Validate("Contract Type", "Contract Type"::Deposit);
                                end;
                            _Contract.Status::FullPayment, _Contract.Status::Contract:
                                begin
                                    CalcFields("Pay. Remaining Amount");
                                    if "Pay. Remaining Amount" <> 0 then
                                        Validate("Contract Type", "Contract Type"::"Non-Payment")
                                    else
                                        Validate("Contract Type", "Contract Type"::"Full Payment");

                                    //Document
                                    SetRequestDoc;
                                end;
                        end;

                    end else begin
                        Validate("Supervise No.", '');
                        Validate("Cemetery Code", '');
                        Validate("Customer No.", '');
                        Validate("Customer Name", '');
                        Validate("Contract Date", 0D);
                    end;

                    CalcFields("Deposit Amount", "Contract Amount", "Remaining Amount", "Payment Amount");
                    CalcFields("Pay. Remaining Amount", "General Expiration Date", "Land. Arc. Expiration Date");

                    "Run Refund Calculation" := false;
                end;
            end;
        }
        field(4; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE("Contract No." = FIELD("Contract No."));

            trigger OnValidate()
            begin
                //>>DK32
                //CALCFIELDS("Cemetery No.");
                CalcFields("Cemetery No.", "Estate Code", "Estate Type");
                //<<DK32
            end;
        }
        field(6; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
        }
        field(8; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Revocation Date"; Date)
        {
            Caption = 'Revocation Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _RevContractMgt: Codeunit "DK_Revocation Contract Mgt.";
            begin
                if xRec."Revocation Date" <> "Revocation Date" then begin
                    TestField(Status, Status::Open);

                    if ("Contract Date" > "Revocation Date") and ("Revocation Date" <> 0D) then
                        Error(MSG005, FieldCaption("Contract Date"), "Contract Date",
                                  FieldCaption("Revocation Date"), "Revocation Date");

                    Clear(_RevContractMgt);
                    "Contract Period" := _RevContractMgt.CalcContractPreiod("Contract Date", "Revocation Date");

                    "Run Refund Calculation" := false;
                    "Refund Rate" := 0;
                    "Sales Rev. Amount" := 0;
                    "Sys. Refund Cemetery Amount" := 0;
                    "Sys. Refund General Amount" := 0;
                    "Sys. Refund Land. Arc. Amount" := 0;
                    "Sys. Refund Bury Amount" := 0;
                    "Refund Cemetery Amount" := 0;
                    "Refund General Amount" := 0;
                    "Refund Land. Arc. Amount" := 0;
                    "System Refund Amount" := 0;
                    Validate("Apply Refund Amount", 0);
                    "Refund Starting Date" := 0D;


                end;
            end;
        }
        field(11; Contents; BLOB)
        {
            Caption = 'Contents';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(12; "Short Contents"; Text[250])
        {
            Caption = 'Short Contents';
            DataClassification = ToBeClassified;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(14; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Request Payment,Complate';
            OptionMembers = Open,Released,Request,Complate;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
            begin
                if xRec.Status <> Status then begin

                    case Status of
                        Status::Complate:
                            begin
                                if _Contract.Get("Contract No.") then begin
                                    _Contract.Validate(Status, _Contract.Status::Revocation);
                                    _Contract."Revocation Date" := "Revocation Date";
                                    _Contract."Revocation Document No." := "Document No.";
                                    _Contract."Revocation Amount" := "Apply Refund Amount";
                                    _Contract."Close Amount" := "Sales Rev. Amount";
                                    _Contract."Revocation Employee No." := "Revocation Employee No.";
                                    _Contract."Revocation Employee Name" := "Revocation Employee Name";
                                    _Contract."Been Transp. Type" := "Been Transp. Type";
                                    _Contract.Modify(true);
                                end;
                            end;
                        else begin
                            if _Contract.Get("Contract No.") then begin
                                if _Contract."Deposit Amount" <> 0 then begin
                                    _Contract.Validate(Status, _Contract.Status::Contract);
                                end else begin
                                    _Contract.Validate(Status, _Contract.Status::FullPayment);
                                end;

                                _Contract."Revocation Date" := 0D;
                                _Contract."Revocation Document No." := '';
                                _Contract."Revocation Amount" := 0;
                                _Contract."Close Amount" := 0;
                                _Contract."Revocation Employee No." := '';
                                _Contract."Revocation Employee Name" := '';
                                _Contract."Been Transp. Type" := _Contract."Been Transp. Type"::None;
                                _Contract.Modify(true);
                            end;
                        end;
                    end;

                    //CRM
                    Clear(_CRMDataInterlink);
                    _CRMDataInterlink.OutboundContract(_Contract);
                    //CRM
                end;
            end;
        }
        field(15; "Contract Status"; Option)
        {
            CalcFormula = Lookup(DK_Contract.Status WHERE("No." = FIELD("Contract No.")));
            Caption = 'Contract Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Contract,Full Payment,Revocation of Contract,Reservation';
            OptionMembers = Open,Contract,FullPayment,Revocation,Reservation;
        }
        field(16; "Deposit Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup(DK_Contract."Deposit Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Deposit Amount';
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(17; "Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup(DK_Contract."Contract Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Contract Amount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(18; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup(DK_Contract."Remaining Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(19; "Payment Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup(DK_Contract."Payment Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Payment Amount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(20; "Pay. Remaining Amount"; Decimal)
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
        field(21; "General Expiration Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."General Expiration Date" WHERE("No." = FIELD("Contract No.")));
            Caption = 'General Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Land. Arc. Expiration Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."Land. Arc. Expiration Date" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Land. Arc. Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Refund Rate"; Decimal)
        {
            Caption = 'Refund Rate(%)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(24; "System Refund Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'System Refund Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."System Refund Amount" <> "System Refund Amount" then
                    Validate("Apply Refund Amount", "System Refund Amount");
            end;
        }
        field(25; "Apply Refund Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Apply Refund Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Apply Refund Amount" <> "Apply Refund Amount" then begin
                    TestField(Status, Status::Open);

                    if "System Refund Amount" = "Apply Refund Amount" then
                        Reason := '';

                    if ("Apply Refund Amount" - "Cancel Pay. Card Amount") > 0 then
                        Validate("Bank Request Amount", "Apply Refund Amount" - "Cancel Pay. Card Amount")
                    else
                        Validate("Bank Request Amount", 0);
                end;
            end;
        }
        field(26; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Deposit,Non-Payment,Non-Payment(Change Location),Full Payment,Full Payment(Change Location)';
            OptionMembers = Deposit,"Non-Payment","Change Location","Full Payment","Full Pay Change Location";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Contract Type" <> "Contract Type" then begin
                    TestField(Status, Status::Open);

                    CalcFields("Contract Status", "Pay. Remaining Amount");

                    _Contract.Reset;
                    _Contract.SetRange("No.", "Contract No.");
                    if _Contract.FindSet then begin


                        case "Contract Type" of
                            "Contract Type"::Deposit:
                                begin
                                    if _Contract.Status <> _Contract.Status::Revocation then
                                        Error(MSG001, FieldCaption("Contract Type"), "Contract Type"::Deposit, _Contract.Status);
                                end;
                            "Contract Type"::"Non-Payment", "Contract Type"::"Change Location":
                                begin
                                    if _Contract.Status <> _Contract.Status::Contract then
                                        Error(MSG004, FieldCaption("Contract Status"), _Contract.Status::Contract, _Contract.Status);

                                    if "Pay. Remaining Amount" = 0 then
                                        Error(MSG002, FieldCaption("Pay. Remaining Amount"));
                                end;
                            //>> DK34
                            "Contract Type"::"Full Payment", "Contract Type"::"Full Pay Change Location":
                                begin
                                    if _Contract.Status <> _Contract.Status::FullPayment then
                                        Error(MSG001, FieldCaption("Contract Status"), _Contract.Status::FullPayment, _Contract.Status);

                                    if "Pay. Remaining Amount" <> 0 then
                                        Error(MSG003, FieldCaption("Pay. Remaining Amount"), "Pay. Remaining Amount");

                                end;
                        //<<
                        end;
                    end;
                end;
            end;
        }
        field(27; "Refund Starting Date"; Date)
        {
            Caption = 'Refund Starting Date';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Cont. Refund Ref. Table";
        }
        field(28; "Contract Period"; Text[30])
        {
            Caption = 'Contract Period';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(29; Reason; Text[50])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec.Reason <> Reason then begin
                    TestField(Status, Status::Open);

                    if Reason <> '' then
                        if "System Refund Amount" = "Apply Refund Amount" then
                            Error(MSG006, FieldCaption(Reason),
                                  FieldCaption("System Refund Amount"),
                                  FieldCaption("Apply Refund Amount"));
                end;
            end;
        }
        field(30; "Bank Code"; Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;

            trigger OnValidate()
            var
                Bank: Record DK_Bank;
            begin
                if xRec."Bank Code" <> "Bank Code" then begin
                    TestField(Status, Status::Open);

                    if "Bank Code" <> '' then begin
                        if "Bank Request Amount" = 0 then
                            Error(MSG013, FieldCaption("Bank Request Amount"));
                    end;
                end;

                if Bank.Get("Bank Code") then
                    "Bank Name" := Bank.Name
                else
                    "Bank Name" := '';
            end;
        }
        field(31; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if xRec."Bank Name" <> "Bank Name" then begin
                    TestField(Status, Status::Open);

                    if "Bank Name" <> '' then begin
                        if "Bank Request Amount" = 0 then
                            Error(MSG013, FieldCaption("Bank Request Amount"));
                    end;
                end;

                Validate("Bank Code", Bank.GetBankCode("Bank Name"));
            end;
        }
        field(32; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Bank Account No." <> "Bank Account No." then begin
                    TestField(Status, Status::Open);

                    if "Bank Account No." <> '' then begin
                        if "Bank Request Amount" = 0 then
                            Error(MSG013, FieldCaption("Bank Request Amount"));
                    end;
                end;
            end;
        }
        field(33; "Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Account Holder" <> "Account Holder" then begin
                    TestField(Status, Status::Open);

                    if "Bank Account No." <> '' then begin
                        if "Bank Request Amount" = 0 then
                            Error(MSG013, FieldCaption("Bank Request Amount"));
                    end;
                end;
            end;
        }
        field(34; "Payment Completion Date"; Date)
        {
            Caption = 'Payment Completion Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
            begin

                if "Payment Completion Date" <> 0D then // ‘÷€ÃŸ‡ßŸÀí ¯‡’…—Ž·‹ µÕ
                begin

                    //IF _Contract.GET("Contract No.") THEN // ÐŽÊ‘ñŠˆ— —¹ŽÊŸÀˆª Žð…Ñœ–« —³„Ÿ„¾.
                    //BEGIN
                    //    _Contract."Revocation Date" := Rec."Payment Completion Date";
                    //    _Contract.MODIFY;

                    //    _CRMDataInterlink.OutboundContract(_Contract); // CRM ˆ‡ž …Ñœ• ýŒÁ
                    //END;

                end;
            end;
        }
        field(35; "GroupWare Doc. No."; Code[30])
        {
            Caption = 'GroupWare Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."GroupWare Doc. No." <> "GroupWare Doc. No." then
                    if Status = Rec.Status::Complate then
                        Error(MSG007, FieldCaption(Status), Status);
            end;
        }
        field(36; "Refund Cemetery Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Refund Cemetery Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Refund Cemetery Amount" <> "Refund Cemetery Amount" then begin
                    CalcFields("Payment Amount", "Pay. Remaining Amount");

                    case "Contract Type" of
                        "Contract Type"::"Non-Payment", "Contract Type"::"Change Location":
                            begin
                                if ("Payment Amount" - "Pay. Remaining Amount") < ("Refund Cemetery Amount" + "Refund General Amount" + "Refund Land. Arc. Amount" + "Refund Bury Amount") then
                                    Error(MSG010, "Payment Amount" - "Pay. Remaining Amount");

                            end;
                    end;

                    _Contract.Get("Contract No.");
                    if "Refund Cemetery Amount" > (_Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount") then
                        Error(MSG011, _Contract.FieldCaption("Cemetery Amount"),
                                      _Contract.FieldCaption("Cemetery Class Discount"),
                                      _Contract.FieldCaption("Cemetery Discount"),
                                      (_Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount"),
                                      FieldCaption("Refund Cemetery Amount"));

                    CalcApplyRefundAmount;
                end;
            end;
        }
        field(37; "Refund General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Refund General Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Refund General Amount" <> "Refund General Amount" then
                    CalcApplyRefundAmount;
            end;
        }
        field(38; "Refund Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Refund Landscape Architecture Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Refund Land. Arc. Amount" <> "Refund Land. Arc. Amount" then
                    CalcApplyRefundAmount;
            end;
        }
        field(39; "Run Refund Calculation"; Boolean)
        {
            Caption = 'Run Refund Calculation';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Payment Request Date"; Date)
        {
            Caption = 'Payment Request Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Revocation,Refund';
            OptionMembers = Revocation,Refund;
        }
        field(42; "Revocation Employee No."; Code[20])
        {
            Caption = 'Litigation Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                _Employee.Reset;
                _Employee.SetRange("No.", "Revocation Employee No.");
                if _Employee.FindSet then
                    "Revocation Employee Name" := _Employee.Name
                else
                    "Revocation Employee Name" := '';
            end;
        }
        field(43; "Revocation Employee Name"; Text[30])
        {
            Caption = 'Litigation Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Revocation Employee No.", _Employee.GetEmployeeNo("Revocation Employee Name"));
            end;
        }
        field(44; "Refund Bury Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Refund Bury Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Refund Bury Amount" <> "Refund Bury Amount" then
                    CalcApplyRefundAmount;
            end;
        }
        field(45; "First Laying Date"; Date)
        {
            CalcFormula = Min(DK_Corpse."Laying Date" WHERE("Contract No." = FIELD("Contract No.")));
            Caption = 'First Laying Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Sys. Refund Cemetery Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'System Refund Contract Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Sys. Refund General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'System Refund General Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Sys. Refund Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'System Refund Landscape Architecture Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; "Sys. Refund Bury Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'System Bury Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(50; "General Starting Date"; Date)
        {
            Caption = 'General Starting Date';
            DataClassification = ToBeClassified;
        }
        field(52; "General Refund Term"; Integer)
        {
            Caption = 'General Refund Term Day';
            DataClassification = ToBeClassified;
        }
        field(53; "Landscape Starting Date"; Date)
        {
            Caption = 'Landscape Starting Date';
            DataClassification = ToBeClassified;
        }
        field(55; "Landscape Refund Term"; Integer)
        {
            Caption = 'Landscape Refund Term';
            DataClassification = ToBeClassified;
        }
        field(56; "Been Transp. Type"; Option)
        {
            Caption = 'Been Transp. Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Give up,Non-Give up';
            OptionMembers = "None",Giveup,NonGiveup;
        }
        field(57; "Bank Request Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bank Request Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "Bank Request Amount" = 0 then begin
                    "Bank Code" := '';
                    "Bank Name" := '';
                    "Bank Account No." := '';
                    "Account Holder" := '';
                end;
            end;
        }
        field(58; "Payment Card Infor."; Text[30])
        {
            Caption = 'Payment Card Infor.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Payment Card Infor." <> "Payment Card Infor." then begin
                    TestField(Status, Status::Open);

                    if "Payment Card Infor." <> '' then begin
                        if "Cancel Pay. Card Amount" = 0 then
                            Error(MSG013, FieldCaption("Cancel Pay. Card Amount"));
                    end;
                end;
            end;
        }
        field(59; "Cancel Pay. Card Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cancel Pay. Card Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Cancel Pay. Card Amount" <> "Cancel Pay. Card Amount" then begin
                    TestField(Status, Status::Open);
                    if "Apply Refund Amount" < "Cancel Pay. Card Amount" then
                        Error(MSG012, FieldCaption("Apply Refund Amount"), "Apply Refund Amount");

                    if "Cancel Pay. Card Amount" = 0 then
                        "Payment Card Infor." := '';

                    if ("Apply Refund Amount" - "Cancel Pay. Card Amount") > 0 then
                        Validate("Bank Request Amount", "Apply Refund Amount" - "Cancel Pay. Card Amount")
                    else
                        Validate("Bank Request Amount", 0);
                end;
            end;
        }
        field(60; "Giving Up"; Boolean)
        {
            Caption = 'Giving Up';
            DataClassification = ToBeClassified;
        }
        field(61; "CRM Sales Type Seq"; Integer)
        {
            CalcFormula = Lookup(DK_Contract."CRM Sales Type Seq" WHERE("No." = FIELD("Contract No.")));
            Caption = 'CRM Sales Type Seq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "CRM Channel Vendor No."; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."CRM Channel Vendor No." WHERE("No." = FIELD("Contract No.")));
            Caption = 'CRM Channel Vendor No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Cemetery Conf. Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Conf. Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Conf. Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Cemetery Digits Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Dig. Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Digits Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Sales Rev. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Rev. Amount';
            DataClassification = ToBeClassified;
        }
        field(66; "CRM External Sales Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."CRM External Sales Code" WHERE("No." = FIELD("Contract No.")));
            Caption = 'CRM External Sales Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Estate Type"; Option)
        {
            CalcFormula = Lookup(DK_Estate.Type WHERE(Code = FIELD("Estate Code")));
            Caption = 'Estate Code';
            Description = 'DK33';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Stairs,Funeral Urn,Tree,Nature,Charnel house';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature,Charnelhouse;
        }
        field(68; "Estate Code"; Code[10])
        {
            CalcFormula = Lookup(DK_Cemetery."Estate Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Estate Code';
            Description = 'DK33';
            Editable = false;
            FieldClass = FlowField;
        }
        field(200; "CRM SalesPerson Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."CRM SalesPerson Code" WHERE("No." = FIELD("Contract No.")));
            Caption = 'CRM SalesPerson Code';
            Description = 'DK34';
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
        key(Key2; "Contract No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Contract No.", "Cemetery No.", "Customer Name", "Contract Date", "Revocation Date")
        {
        }
    }

    trigger OnDelete()
    begin
        DelRequestDocumentRec("Document No.");
    end;

    trigger OnInsert()
    var
        _Employee: Record DK_Employee;
    begin
        //>>"Document No."
        if "Document No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Revocation Contract Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Revocation Contract Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
        end;
        TestField("Document No.");
        //<<"Document No."

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then begin
            "Revocation Employee No." := _Employee."No.";
            "Revocation Employee Name" := _Employee.Name;
        end;
    end;

    trigger OnModify()
    begin
        TestField("Document No.");
        //<<No

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        FunctionSetup: Record "DK_Function Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MSG001: Label 'This is the case when the %1 is a %2. Current %1 : %3';
        MSG002: Label 'The %1 is (0).';
        MSG003: Label 'The %1 is not (0). %1 :%2';
        MSG004: Label 'This is the case when the %1 is a %2. Current %1 : %3';
        MSG005: Label 'The %3 can not be earlier than the %1. %1:%2, %3:%4';
        MSG006: Label '%1 can only be specified if there is a difference between %2 and %3.';
        Bank: Record DK_Bank;
        MSG007: Label 'You can not change the value in the current %1. %1:%2';
        MSG008: Label 'There is an unpaid amount in %1. %1:%2\\Can not continue.';
        MSG009: Label 'Run a Refund calculation first';
        MSG010: Label 'You can not refund more than the Receipt Amount. Receipt Amount : %1';
        MSG011: Label 'You can not enter an %5 greater than %1 entered in the contract.';
        MSG012: Label 'You cannot specify an amount greater than %1. %1:%2';
        MSG013: Label 'The %1 does not exist.';
        MSG014: Label 'This contract number is currently entered in other Documents. %1:%2';


    procedure AssistEdit(OldRevocationContract: Record "DK_Revocation Contract"): Boolean
    var
        _RevocationContract: Record "DK_Revocation Contract";
    begin
        with _RevocationContract do begin
            _RevocationContract := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Revocation Contract Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Revocation Contract Nos.", OldRevocationContract."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                Rec := _RevocationContract;
                exit(true);
            end;
        end;
    end;

    procedure SetWorkContents(pNewWorkContents: Text)
    var
        _TempBlob: Record TempBlob temporary;
    begin
        Clear(Contents);
        if pNewWorkContents = '' then
            exit;


        _TempBlob.Blob := Contents;
        _TempBlob.WriteAsText(pNewWorkContents, TEXTENCODING::Windows);
        "Short Contents" := CopyStr(pNewWorkContents, 1, 200);
        Contents := _TempBlob.Blob;
        Modify;
    end;

    procedure GetWorkContents(): Text
    begin
        CalcFields(Contents);
        exit(GetWorkContentsCalculated);
    end;

    procedure GetWorkContentsCalculated(): Text
    var
        _TempBlob: Record TempBlob temporary;
        _CR: Text[1];
    begin
        if not Contents.HasValue then
            exit('');

        _CR[1] := 10;
        _TempBlob.Blob := Contents;
        exit(_TempBlob.ReadAsText(_CR, TEXTENCODING::Windows));
    end;


    procedure SetReleased()
    begin
        TestField("Contract No.");
        TestField("Revocation Date");
        TestField(Status, Status::Open);

        if not "Run Refund Calculation" then
            Error(MSG009);

        if "Apply Refund Amount" > 0 then begin

            if "Bank Request Amount" <> 0 then begin
                TestField("Bank Code");
                TestField("Bank Account No.");
                TestField("Account Holder");
            end;

            if "Cancel Pay. Card Amount" <> 0 then begin
                TestField("Payment Card Infor.");
            end;


        end else
            if "Apply Refund Amount" < 0 then begin
                Error(MSG008, FieldCaption("Apply Refund Amount"), "Apply Refund Amount");
            end;

        if ("System Refund Amount" <> "Apply Refund Amount") and
          (Reason = '') then
            TestField(Reason);

        Validate(Status, Status::Released);
        Modify(true);
    end;


    procedure SetRequest()
    var
        _RevoContMgt: Codeunit "DK_Revocation Contract Mgt.";
    begin
        TestField("Contract No.");
        TestField("Revocation Date");
        TestField(Status, Status::Released);

        Clear(_RevoContMgt);
        _RevoContMgt.CheckRequestDoc(Rec);
        _RevoContMgt.RequestRemittance(Rec);

        Validate("Payment Request Date", Today);
        Validate(Status, Status::Request);
        Modify(true);
    end;


    procedure SetComplete()
    begin
        TestField("Contract No.");
        TestField("Revocation Date");
        //VALIDATE(Status, Status::Released);

        Validate(Status, Status::Complate);
        Modify(true);
    end;


    procedure SetReOpen()
    var
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    begin
        //VALIDATE(Status, Status::Released);
        if Status <> Status::Complate then begin
            Validate(Status, Status::Open);
            Modify(true);

            _RevocationContractMgt.CancelRequestRemittance(Rec);
        end;
    end;


    procedure DelRequestDocumentRec(pDocNo: Code[20])
    var
        _ReqDocRec: Record "DK_Request Document Rec.";
    begin
        _ReqDocRec.Reset;
        _ReqDocRec.SetRange("Table ID", DATABASE::"DK_Revocation Contract");
        _ReqDocRec.SetRange("Source No.", pDocNo);
        if _ReqDocRec.FindFirst then
            _ReqDocRec.DeleteAll(true);
    end;


    procedure SetRequestDoc()
    var
        _ReqDocRec: Record "DK_Request Document Rec.";
        _RequestDocSetup: Record "DK_Request Doc. Setup";
    begin

        _RequestDocSetup.Reset;
        _RequestDocSetup.SetRange(Type, _RequestDocSetup.Type::Cancellation);
        if _RequestDocSetup.FindSet then begin
            repeat
                _ReqDocRec.Init;
                _ReqDocRec."Table ID" := DATABASE::"DK_Revocation Contract";
                _ReqDocRec."Source No." := "Document No.";
                _ReqDocRec."Line No." := _RequestDocSetup."Line No.";
                _ReqDocRec."Document Name" := _RequestDocSetup."Document Name";
                _ReqDocRec.Insert;
            until _RequestDocSetup.Next = 0;
        end;
    end;

    local procedure CalcApplyRefundAmount()
    begin
        Validate("Apply Refund Amount", "Refund Cemetery Amount" + "Refund General Amount" + "Refund Land. Arc. Amount" + "Refund Bury Amount");
    end;
}

