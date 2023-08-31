table 50080 "DK_Payment Receipt Document"
{
    // 
    // #2177: 20200921
    //   - Add Field: Target Line Service Amount
    // 
    // *DK34: 20201028
    //   - Modify Trigger: Litigation Employee Name - OnValidate()
    //      : 20201117
    //   - Add Field: "Department Code", "Department Name"
    //   - Modify Trigger: Litigation Employee No. - OnValidate(), Contract No. - OnValidate(), Target Doc. No. - OnValidate()

    Caption = 'Payment Receipt Ledger';
    DataCaptionFields = "Document No.", "Payment Date", "Payment Type";
    DrillDownPageID = "DK_Post Pay. Receipt Doc. List";
    LookupPageID = "DK_Post Pay. Receipt Doc. List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bank Transfer,Credit Card,Cash,Giro,Onlie Credit Card,Virtual Account,Debt Relief';
            OptionMembers = "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount,DebtRelief;

            trigger OnValidate()
            begin
                if xRec."Payment Type" <> "Payment Type" then begin

                    Clear("Payment Method Code");
                    Clear("Payment Method Name");
                    Clear("Bank Account Code");
                    Clear("Bank Account Name");
                    Clear("Bank Account No.");
                    Clear("Payment Mothed Type");

                    case "Payment Type" of
                        "Payment Type"::DebtRelief, "Payment Type"::None:
                            begin

                                if CheckLine then begin
                                    Clear("Card Approval No.");
                                    Clear("Issued Cash Receipts");
                                    Clear("Issued Cash Rec. Date");
                                    Clear("Issued Cash Rec. Mobile");
                                    Clear("Cash Bill Approval No.");
                                    Clear("Issued TAX Bill");
                                    Clear("Issued TAX Bill Date");
                                end else begin
                                    "Payment Type" := xRec."Payment Type";
                                end;
                            end;
                        "Payment Type"::Card, "Payment Type"::OnlineCard:
                            begin
                                Clear("Issued Cash Receipts");
                                Clear("Issued Cash Rec. Date");
                                Clear("Issued Cash Rec. Mobile");
                                Clear("Cash Bill Approval No.");
                                Clear("Issued TAX Bill");
                                Clear("Issued TAX Bill Date");
                            end;
                        else begin
                            Clear("Card Approval No.");
                        end;
                    end;
                end;
            end;
        }
        field(5; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Payment Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec.Amount <> Amount then begin

                    CalcFinalAmount;

                end;
            end;
        }
        field(6; "Issued Cash Receipts"; Boolean)
        {
            Caption = 'Issued Cash Receipts';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Issued Cash Receipts" <> "Issued Cash Receipts" then begin
                    if "Issued TAX Bill" then
                        Error(MSG008);

                    if "Issued Cash Receipts" then
                        "Issued Cash Rec. Date" := WorkDate
                    else begin
                        "Issued Cash Rec. Date" := 0D;
                        "Cash Bill Approval No." := '';
                        "Issued Cash Rec. Mobile" := '';
                    end;
                end;
            end;
        }
        field(7; "Issued Cash Rec. Date"; Date)
        {
            Caption = 'Issued Cash Receipts Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Issued Cash Rec. Date" <> "Issued Cash Rec. Date" then
                    if "Issued Cash Rec. Date" <> 0D then
                        TestField("Issued Cash Receipts");
            end;
        }
        field(8; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Type" = CONST(Card)) "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                                                            Type = CONST(Card))
            ELSE
            IF ("Payment Type" = CONST(Giro)) "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                                                                                                                                 Type = CONST(Giro))
            ELSE
            IF ("Payment Type" = CONST(OnlineCard)) "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                                                                                                                                                                                                            Type = CONST(Online));

            trigger OnValidate()
            begin

                PaymentMothed.Reset;

                case "Payment Type" of
                    "Payment Type"::Card:
                        PaymentMothed.SetRange(Type, PaymentMothed.Type::Card);
                    "Payment Type"::Giro:
                        PaymentMothed.SetRange(Type, PaymentMothed.Type::Giro);
                    "Payment Type"::OnlineCard:
                        PaymentMothed.SetRange(Type, PaymentMothed.Type::Online);
                end;
                PaymentMothed.SetRange(Code, "Payment Method Code");
                if PaymentMothed.FindSet then begin
                    "Payment Method Name" := PaymentMothed.Name;
                    "Payment Mothed Type" := PaymentMothed.Type;
                end else begin
                    "Payment Method Name" := '';
                    Clear("Payment Mothed Type");
                end;
            end;
        }
        field(9; "Payment Method Name"; Text[50])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Type" = CONST(Card)) "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                                                            Type = CONST(Card))
            ELSE
            IF ("Payment Type" = CONST(Giro)) "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                                                                                                                                 Type = CONST(Giro))
            ELSE
            IF ("Payment Type" = CONST(OnlineCard)) "DK_Payment Method".Code WHERE(Blocked = CONST(false),
                                                                                                                                                                                                                                            Type = CONST(Online));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                case "Payment Type" of
                    "Payment Type"::Card:
                        Validate("Payment Method Code", PaymentMothed.GetCode("Payment Mothed Type"::Card, "Payment Method Name"));
                    "Payment Type"::Giro:
                        Validate("Payment Method Code", PaymentMothed.GetCode("Payment Mothed Type"::Giro, "Payment Method Name"));
                    "Payment Type"::OnlineCard:
                        Validate("Payment Method Code", PaymentMothed.GetCode("Payment Mothed Type"::Online, "Payment Method Name"));
                end;
            end;
        }
        field(10; "Bank Account Code"; Code[20])
        {
            Caption = 'Bank Account Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Receipt Bank Account".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _ReceiptBankAcc: Record "DK_Receipt Bank Account";
            begin
                if xRec."Bank Account Code" <> "Bank Account Code" then begin

                    if _ReceiptBankAcc.Get("Bank Account Code") then begin
                        "Bank Account Name" := _ReceiptBankAcc.Description;
                        "Bank Account No." := _ReceiptBankAcc."Bank Account No.";
                    end else begin
                        "Bank Account Name" := '';
                        "Bank Account No." := '';
                    end;

                    CalcFields("Litigation Bank Account");

                    //RESET;
                    "Legal Amount" := 0;
                    "Advance Payment Amount" := 0;
                    "Delay Interest Amount" := 0;
                    "MTG Amount" := 0;
                    "Move The Grave" := false;
                    "Reduction Amount" := 0;
                    "Reduction Amount 1" := 0;
                    "Reduction Amount 2" := 0;
                    "Withdraw Mothed" := '';
                    "Litigation Ramark" := '';

                    CalcFinalAmount;


                end;
            end;
        }
        field(11; "Bank Account Name"; Text[50])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Virtual Account No."; Code[20])
        {
            Caption = 'Virtual Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Virtual Account";
        }
        field(13; "Pay. Expect Doc. No."; Code[20])
        {
            Caption = 'Payment Expect Document No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Pay. Expect Doc. Header";
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(16; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(17; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract WHERE(Status = FILTER(<> Revocation));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Contract No." <> "Contract No." then begin
                    if "Contract No." <> '' then
                        TestField("Missing Contract", false);

                    if CheckLine then begin

                        if _Contract.Get("Contract No.") then begin
                            Validate("Supervise No.", _Contract."Supervise No.");
                            Validate("Cemetery Code", _Contract."Cemetery Code");
                            Validate("Litigation Employee No.", _Contract."Litigation Employee No.");
                            Validate("Litigation Employee Name", _Contract."Litigation Employee Name");
                            // >> DK34
                            Validate("Department Code", _Contract."Department Code");
                            Validate("Department Name", _Contract."Department Name");
                            // <<
                            Validate("Litigation Evaluation", _Contract."Litigation Evaluation");
                            Validate("Main Customer Name", _Contract."Main Customer Name");

                            _Contract.CalcFields("Cust. Mobile No.", "Main Associate Mobile No.", "Main Associate Name", "Sub Associate Mobile No.", "Sub Associate Name");

                            case _Contract."Contact Target" of
                                _Contract."Contact Target"::MainCustomer:
                                    begin
                                        "Appl. Mobile No." := _Contract."Cust. Mobile No.";
                                        Depositor := _Contract."Main Customer Name";
                                    end;
                                _Contract."Contact Target"::MainAssociate:
                                    begin
                                        "Appl. Mobile No." := _Contract."Main Associate Mobile No.";
                                        Depositor := _Contract."Main Associate Name";
                                    end;
                                _Contract."Contact Target"::SubAssociate:
                                    begin
                                        "Appl. Mobile No." := _Contract."Sub Associate Mobile No.";
                                        Depositor := _Contract."Sub Associate Name";
                                    end;
                            end;

                        end else begin
                            Validate("Supervise No.", '');
                            Validate("Cemetery Code", '');
                            Validate("Litigation Employee No.", '');
                            Validate("Litigation Employee Name", '');
                            // >> DK34
                            Validate("Department Code", '');
                            Validate("Department Name", '');
                            // <<
                            Validate("Main Customer Name", '');
                            Depositor := '';
                            "Appl. Mobile No." := '';
                        end;
                    end else begin
                        "Contract No." := xRec."Contract No.";
                    end;
                end;
            end;
        }
        field(19; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin

                if _Cemetery.Get("Cemetery Code") then
                    "Cemetery No." := _Cemetery."Cemetery No."
                else
                    "Cemetery No." := '';
            end;
        }
        field(21; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Cemetery Code", _Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(22; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Document Time"; Time)
        {
            Caption = 'Document Time';
            DataClassification = ToBeClassified;
        }
        field(25; "Missing Contract"; Boolean)
        {
            Caption = 'Missing Contract';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Missing Contract" <> "Missing Contract" then begin
                    if "Missing Contract" then begin
                        if "Before Document No." <> '' then
                            TestField("Missing Contract", false);

                        if Description = '' then
                            Error(MSG005, FieldCaption(Description), FieldCaption("Missing Contract"));

                        if CheckLine then
                            Validate("Contract No.", '');


                        Clear("Card Approval No.");
                        Clear("Issued Cash Receipts");
                        Clear("Issued Cash Rec. Date");
                        Clear("Issued Cash Rec. Mobile");
                        Clear("Cash Bill Approval No.");
                        Clear("Issued TAX Bill");
                        Clear("Issued TAX Bill Date");
                        Clear("Appl. Mobile No.");
                        Clear(Depositor);
                    end;

                end;
            end;
        }
        field(26; "Before Document No."; Code[20])
        {
            Caption = 'Before Document No.';
            DataClassification = ToBeClassified;
        }
        field(27; "After Document No."; Code[20])
        {
            Caption = 'After Document No.';
            DataClassification = ToBeClassified;
        }
        field(28; "Contract Status"; Option)
        {
            CalcFormula = Lookup(DK_Contract.Status WHERE("No." = FIELD("Contract No.")));
            Caption = 'Contract Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Contract,Full Payment,Revocation of Contract,Reservation';
            OptionMembers = Open,Contract,FullPayment,Revocation,Reservation;
        }
        field(29; "Service Doc. No. Filter"; Code[100])
        {
            Caption = 'Service Document No. Filter';
            FieldClass = FlowFilter;
        }
        field(30; "Exitx. Service No."; Boolean)
        {
            CalcFormula = Exist("DK_Payment Receipt Doc. Line" WHERE("Document No." = FIELD("Document No.")));////,"Diff. Amount" = FIELD("Service Doc. No. Filter")));
            Caption = 'Exitx. Service No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Litigation Bank Account"; Boolean)
        {
            CalcFormula = Lookup("DK_Receipt Bank Account".Litigation WHERE(Code = FIELD("Bank Account Code")));
            Caption = 'Litigation Bank Account';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; Division; Boolean)
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec.Division <> Division then
                    TestField("Contract No.");
            end;
        }
        field(33; "Legal Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Legal Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Legal Amount" <> "Legal Amount" then begin
                    TestField("Contract No.");
                    CalcFinalAmount;

                end;
            end;
        }
        field(34; "Advance Payment Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Advance Payment Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Advance Payment Amount" <> "Advance Payment Amount" then
                    TestField("Contract No.");
            end;
        }
        field(35; "Delay Interest Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Delay Interest Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Delay Interest Amount" <> "Delay Interest Amount" then begin
                    TestField("Contract No.");
                    CalcFinalAmount;
                end;
            end;
        }
        field(36; "MTG Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'MTG Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."MTG Amount" <> "MTG Amount" then begin
                    TestField("Contract No.");
                    if "MTG Amount" <> 0 then
                        "Move The Grave" := true
                    else
                        "Move The Grave" := false;

                end;
            end;
        }
        field(37; "Move The Grave"; Boolean)
        {
            Caption = 'Move The Grave';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Move The Grave" <> "Move The Grave" then begin
                    TestField("Contract No.");
                end;
            end;
        }
        field(38; "Reduction Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Reduction Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin

                if xRec."Reduction Amount" <> "Reduction Amount" then begin
                    TestField("Contract No.");
                    CalcFinalAmount;
                end;
            end;
        }
        field(39; "Withdraw Mothed"; Text[50])
        {
            Caption = 'Withdraw Mothed';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Withdraw Mothed" <> "Withdraw Mothed" then begin
                    TestField("Contract No.");
                end;
            end;
        }
        field(40; "Litigation Ramark"; Text[250])
        {
            Caption = 'Litigation Ramark';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Litigation Ramark" <> "Litigation Ramark" then begin
                    TestField("Contract No.");
                end;
            end;
        }
        field(41; "Final Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Final Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Final Amount" <> "Final Amount" then begin

                    if "Litigation Bank Account" then begin
                        if "Final Amount" <> 0 then begin
                            CalcFields("Total Amount");
                            if "Final Amount" < "Total Amount" then
                                Error(MSG002, FieldCaption("Final Amount"), "Total Amount");
                        end;
                    end else begin
                        if Amount <> 0 then begin
                            CalcFields("Total Amount");
                            if Amount < "Total Amount" then
                                Error(MSG002, FieldCaption("Final Amount"), "Total Amount");
                        end;
                    end;
                end;
            end;
        }
        field(42; "Litigation Employee No."; Code[20])
        {
            Caption = 'Litigation Employee No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
                _UserSetup: Record "User Setup";
            begin
                // >> DK34
                //IF xRec."Litigation Employee No." <> "Litigation Employee No." THEN BEGIN

                //END;
                // <<
            end;
        }
        field(43; "Litigation Employee Name"; Text[30])
        {
            Caption = 'Litigation Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
                _UserSetup: Record "User Setup";
            begin
            end;
        }
        field(44; "Litigation Evaluation"; Option)
        {
            Caption = 'Litigation Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            Editable = false;
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(45; "Before Contract No."; Code[20])
        {
            Caption = 'Before Contract No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Contract WHERE(Status = FILTER(<> Revocation));
        }
        field(46; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Receipt,Refund';
            OptionMembers = Receipt,Refund;
        }
        field(47; Refund; Boolean)
        {
            CalcFormula = Exist("DK_Payment Receipt Document" WHERE("Target Doc. No." = FIELD("Document No."),
                                                                     "Document Type" = CONST(Refund),
                                                                     Posted = CONST(true)));
            Caption = 'Refund';
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Refund Document No."; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Document No." WHERE("Target Doc. No." = FIELD("Document No."),
                                                                                     "Document Type" = CONST(Refund)));
            Caption = 'Refund Document No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                CalcFields("Refund Document No.");

                if "Refund Document No." <> '' then
                    ShowPostedPaymentDocument("Refund Document No.");
            end;
        }
        field(49; "Line Contact Amount"; Boolean)
        {
            CalcFormula = Exist("DK_Payment Receipt Doc. Line" WHERE("Document No." = FIELD("Document No."),
                                                                      "Payment Target" = FILTER(Deposit | Contract | Remaining)));
            Caption = 'Line Contact Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Payment Time"; Time)
        {
            Caption = 'Payment Time';
            DataClassification = ToBeClassified;
        }
        field(51; "Aproval No."; Text[30])
        {
            Caption = 'Aproval No.';
            DataClassification = ToBeClassified;
        }
        field(52; "Document Datetime"; DateTime)
        {
            Caption = 'Document Datetime';
            DataClassification = ToBeClassified;
        }
        field(53; "Payment Mothed Type"; Option)
        {
            Caption = 'Payment Mothed Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Online Card,Card,Giro';
            OptionMembers = Online,Card,Giro;
        }
        field(54; "Issued Cash Rec. Mobile"; Text[30])
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
        field(55; Depositor; Text[20])
        {
            Caption = 'Depositor';
            DataClassification = ToBeClassified;
        }
        field(56; Litigation; Boolean)
        {
            Caption = 'Litigation';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _UserSetup: Record "User Setup";
            begin
                if xRec.Litigation <> Litigation then begin
                    // >> DK34
                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Litigation Pay. Admin.", true);
                    if not _UserSetup.FindSet then
                        Error(MSG010);
                    /*
                    IF NOT Litigation THEN BEGIN
                        Division := FALSE;
                        "Legal Amount" := 0;
                        "Advance Payment Amount" := 0;
                        "Delay Interest Amount" := 0;
                        "MTG Amount" := 0;
                        "Move The Grave" := FALSE;
                        "Reduction Amount" := 0;
                        "Reduction Amount 1" := 0;
                        "Reduction Amount 2" := 0;
                        "Withdraw Mothed" := '';
                        "Litigation Ramark" := '';
                        "Debt Relief Amount" := 0;
                        CalcFinalAmount;
                    END;
                    */
                    // <<
                end;

            end;
        }
        field(57; "Debt Relief Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Debt Relief Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Debt Relief Amount" <> "Debt Relief Amount" then begin
                    TestField("Contract No.");
                    CalcFinalAmount;

                end;
            end;
        }
        field(58; "Line General Start Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line"."Start Date" WHERE("Document No." = FIELD("Document No."),
                                                                                    "Payment Target" = CONST(General)));
            Caption = 'General Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Line General Expiration Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line"."Expiration Date" WHERE("Document No." = FIELD("Document No."),
                                                                                         "Payment Target" = CONST(General)));
            Caption = 'GGeneral Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Line Land. Arc. Start Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line"."Start Date" WHERE("Document No." = FIELD("Document No."),
                                                                                    "Payment Target" = CONST(Landscape)));
            Caption = 'Land. Arc. Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Line Land. Arc. Exp. Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line"."Expiration Date" WHERE("Document No." = FIELD("Document No."),
                                                                                         "Payment Target" = CONST(Landscape)));
            Caption = 'Land. Arc. Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Line General Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                              "Payment Target" = CONST(General)));
            Caption = 'General Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Line Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                              "Payment Target" = CONST(Landscape)));
            Caption = 'Land. Arc. Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Main Customer Name"; Text[30])
        {
            Caption = 'Main Customer Name';
            Editable = false;
        }
        field(65; "Non-Pay. General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Non-Payment General Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(66; "Non-Pay. Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Non-Payment Landscape Arc. Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(67; "Line Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                              "Payment Target" = CONST(Contract)));
            Caption = 'Contract Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = ToBeClassified;
        }
        field(71; "Cash Bill Approval No."; Text[20])
        {
            Caption = 'Cash Bill Approval No.';
            DataClassification = ToBeClassified;
        }
        field(72; "Card Approval No."; Text[20])
        {
            Caption = 'Card Approval No.';
            DataClassification = ToBeClassified;
        }
        field(73; "Issued TAX Bill"; Boolean)
        {
            Caption = 'Issued TAX Bill';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Issued TAX Bill" <> "Issued TAX Bill" then begin

                    if "Issued Cash Receipts" then
                        Error(MSG009);

                    if "Issued TAX Bill" then
                        "Issued TAX Bill Date" := WorkDate
                    else
                        "Issued TAX Bill Date" := 0D;
                end;
            end;
        }
        field(74; "Issued TAX Bill Date"; Date)
        {
            Caption = 'Issued TAX Bill Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Issued TAX Bill Date" <> "Issued TAX Bill Date" then
                    if "Issued TAX Bill Date" <> 0D then
                        TestField("Issued TAX Bill");
            end;
        }
        field(75; "Befor Liti. Eval."; Option)
        {
            Caption = 'AfterLitigation Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            Editable = false;
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(78; "After Liti. Eval."; Option)
        {
            Caption = 'After Litigation Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            Editable = true;
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(79; "Appl. Mobile No."; Text[30])
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
        field(80; "Line Service Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                              "Payment Target" = CONST(Service)));
            Caption = 'Service Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(81; "Line Deposit Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                              "Payment Target" = CONST(Deposit)));
            Caption = 'Deposit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82; "Line Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                              "Payment Target" = CONST(Remaining)));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(83; "Line Admin. Expense"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                           "Payment Target" = FILTER(General | Landscape)));
            Caption = 'Line Admin. Expense';
            Editable = false;
            FieldClass = FlowField;
        }
        field(84; "Refund Posting Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Posting Date" WHERE("Target Doc. No." = FIELD("Document No."),
                                                                                     "Document Type" = CONST(Refund),
                                                                                     Posted = CONST(true)));
            Caption = 'Refund Posting Date';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                CalcFields("Refund Document No.");

                if "Refund Document No." <> '' then
                    ShowPostedPaymentDocument("Refund Document No.");
            end;
        }
        field(85; "Refund Pay. Comp. Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Payment Completion Date" WHERE("Target Doc. No." = FIELD("Document No."),
                                                                                                "Document Type" = CONST(Refund),
                                                                                                Posted = CONST(true)));
            Caption = 'Refund Pay. Comp. Date';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                CalcFields("Refund Document No.");

                if "Refund Document No." <> '' then
                    ShowPostedPaymentDocument("Refund Document No.");
            end;
        }
        field(86; "Created Auto."; Boolean)
        {
            Caption = 'Created Auto.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(87; "Reduction Amount 1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Reduction Amount (General)';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin

                if xRec."Reduction Amount 1" <> "Reduction Amount 1" then begin
                    TestField("Contract No.");
                    "Reduction Amount" := "Reduction Amount 1" + "Reduction Amount 2";
                    CalcFinalAmount;
                end;
            end;
        }
        field(88; "Reduction Amount 2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Reduction Amount (Land.)';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin

                if xRec."Reduction Amount 2" <> "Reduction Amount 2" then begin
                    TestField("Contract No.");
                    "Reduction Amount" := "Reduction Amount 1" + "Reduction Amount 2";
                    CalcFinalAmount;
                end;
            end;
        }
        field(89; "Cemetery Size"; Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery.Size WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Size';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(90; "Line Cem. Services No."; Code[20])
        {
            CalcFormula = Max("DK_Payment Receipt Doc. Line"."Cem. Services No." WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Line Cem. Services No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Liti. Delay Interest Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Litigation Delay Interest Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin

                if "Liti. Delay Interest Amount" <> xRec."Liti. Delay Interest Amount" then begin
                    TestField("Contract No.");
                    CalcFinalAmount;
                end;
            end;
        }
        field(500; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin

                if _Department.Get("Department Code") then begin
                    "Department Name" := _Department.Name;

                    if _Department.Litigation then
                        Litigation := true
                end else begin
                    "Department Name" := '';
                    Litigation := false;
                end;
            end;
        }
        field(502; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code", _Department.GetDeptCode("Department Name"));
            end;
        }
        field(503; "New Admin. Expense"; Boolean)
        {
            Caption = 'New Admin. Expense';
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
        field(50000; "Target Doc. No."; Code[20])
        {
            Caption = 'Target Document No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Type" = CONST(Refund)) "DK_Payment Receipt Document"."Document No." WHERE("Document Type" = CONST(Receipt),
                                                                                                                   Refund = CONST(false),
                                                                                                                   Posted = CONST(true),
                                                                                                                   IDX = CONST(0));

            trigger OnValidate()
            var
                _PayReceiptDoc: Record "DK_Payment Receipt Document";
            begin
                if xRec."Target Doc. No." <> "Target Doc. No." then begin
                    //Refund
                    _PayReceiptDoc.Reset;
                    _PayReceiptDoc.SetRange("Document Type", _PayReceiptDoc."Document Type"::Receipt);
                    _PayReceiptDoc.SetRange("Document No.", "Target Doc. No.");
                    if _PayReceiptDoc.FindSet then begin

                        Validate(Amount, _PayReceiptDoc.Amount);
                        Validate("Contract No.", _PayReceiptDoc."Contract No.");
                        Validate("Supervise No.", _PayReceiptDoc."Supervise No.");
                        Validate("Cemetery Code", _PayReceiptDoc."Cemetery Code");

                        "Payment Date" := _PayReceiptDoc."Payment Date";
                        "Payment Type" := _PayReceiptDoc."Payment Type";
                        "Bank Account Code" := _PayReceiptDoc."Bank Account Code";
                        "Bank Account Name" := _PayReceiptDoc."Bank Account Name";
                        "Bank Account No." := _PayReceiptDoc."Bank Account No.";
                        "Virtual Account No." := _PayReceiptDoc."Virtual Account No.";
                        "Pay. Expect Doc. No." := _PayReceiptDoc."Pay. Expect Doc. No.";
                        "Before Contract No." := _PayReceiptDoc."Before Contract No.";
                        "Before Document No." := _PayReceiptDoc."Before Document No.";
                        "Missing Contract" := _PayReceiptDoc."Missing Contract";
                        Division := _PayReceiptDoc.Division;
                        "Legal Amount" := _PayReceiptDoc."Legal Amount";
                        "Advance Payment Amount" := _PayReceiptDoc."Advance Payment Amount";
                        "Delay Interest Amount" := _PayReceiptDoc."Delay Interest Amount";
                        "MTG Amount" := _PayReceiptDoc."MTG Amount";
                        "Move The Grave" := _PayReceiptDoc."Move The Grave";
                        "Reduction Amount" := _PayReceiptDoc."Reduction Amount";
                        "Reduction Amount 1" := _PayReceiptDoc."Reduction Amount 1";
                        "Reduction Amount 2" := _PayReceiptDoc."Reduction Amount 2";
                        "Withdraw Mothed" := _PayReceiptDoc."Withdraw Mothed";
                        "Litigation Ramark" := _PayReceiptDoc."Litigation Ramark";
                        "Litigation Employee No." := _PayReceiptDoc."Litigation Employee No.";
                        "Litigation Employee Name" := _PayReceiptDoc."Litigation Employee Name";
                        // >> DK34
                        "Department Code" := _PayReceiptDoc."Department Code";
                        "Department Name" := _PayReceiptDoc."Department Name";
                        // <<
                        "Litigation Evaluation" := _PayReceiptDoc."Litigation Evaluation";
                        "Issued Cash Receipts" := _PayReceiptDoc."Issued Cash Receipts";
                        "Issued Cash Rec. Date" := _PayReceiptDoc."Issued Cash Rec. Date";
                        "Issued Cash Rec. Mobile" := _PayReceiptDoc."Issued Cash Rec. Mobile";
                        "Cash Bill Approval No." := _PayReceiptDoc."Cash Bill Approval No.";
                        "Card Approval No." := _PayReceiptDoc."Card Approval No.";
                        "Issued TAX Bill" := _PayReceiptDoc."Issued TAX Bill";
                        "Issued TAX Bill Date" := _PayReceiptDoc."Issued TAX Bill Date";
                        "Final Amount" := _PayReceiptDoc."Final Amount";

                        "Payment Method Code" := _PayReceiptDoc."Payment Method Code";
                        "Payment Method Name" := _PayReceiptDoc."Payment Method Name";
                    end else begin

                        Validate(Amount, 0);
                        Validate("Contract No.", '');
                        Validate("Supervise No.", '');
                        Validate("Cemetery Code", '');

                        "Payment Date" := 0D;
                        "Bank Account Code" := '';
                        "Bank Account Name" := '';
                        "Bank Account No." := '';
                        "Virtual Account No." := '';
                        "Pay. Expect Doc. No." := '';
                        "Before Contract No." := '';
                        "Before Document No." := '';
                        "Missing Contract" := false;
                        Division := false;
                        "Legal Amount" := 0;
                        "Advance Payment Amount" := 0;
                        "Delay Interest Amount" := 0;
                        "MTG Amount" := 0;
                        "Move The Grave" := false;
                        "Reduction Amount" := 0;
                        "Reduction Amount 1" := 0;
                        "Reduction Amount 2" := 0;
                        "Withdraw Mothed" := '';
                        "Litigation Ramark" := '';
                        "Litigation Employee No." := '';
                        "Litigation Employee Name" := '';
                        // >> DK34
                        "Department Code" := '';
                        "Department Name" := '';
                        // <<
                        "Issued Cash Receipts" := false;
                        "Issued Cash Rec. Date" := 0D;
                        "Issued Cash Rec. Mobile" := '';
                        "Cash Bill Approval No." := '';
                        "Card Approval No." := '';
                        "Issued TAX Bill" := false;
                        "Issued TAX Bill Date" := 0D;
                        "Payment Method Code" := '';
                        "Payment Method Name" := '';
                        "Final Amount" := 0;
                    end;
                end;
            end;
        }
        field(50001; "Refund Reason"; Text[50])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;
        }
        field(50002; "Refund Bank Code"; Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;

            trigger OnValidate()
            var
                Bank: Record DK_Bank;
            begin
                if Bank.Get("Refund Bank Code") then
                    "Refund Bank Name" := Bank.Name
                else
                    "Refund Bank Name" := '';
            end;
        }
        field(50003; "Refund Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Bank: Record DK_Bank;
            begin
                Validate("Refund Bank Code", Bank.GetBankCode("Refund Bank Name"));
            end;
        }
        field(50004; "Refund Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(50005; "Refund Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(50006; "Payment Completion Date"; Date)
        {
            Caption = 'Payment Completion Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "GroupWare Doc. No."; Code[30])
        {
            Caption = 'GroupWare Document No.';
            DataClassification = ToBeClassified;
        }
        field(50008; "Payment Request Date"; Date)
        {
            Caption = 'Payment Request Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Refund Status"; Option)
        {
            Caption = 'Refund Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Request Payment,Complate';
            OptionMembers = Open,Request,Complate;
        }
        field(50010; "Request Refund Date"; Date)
        {
            Caption = 'Request Refund Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Request Refund Date" <> "Request Refund Date" then begin
                    if "Request Refund Date" <> 0D then
                        if "Request Refund Date" <= Today then
                            Error(MSG006, Today);
                end;
            end;
        }
        field(50011; "Target Line Admin. Expense"; Decimal)
        {
            CalcFormula = Sum("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Target Doc. No."),
                                                                           "Payment Target" = FILTER(General | Landscape)));
            Caption = 'Target Line Admin. Expense';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Target Line Service Amount"; Decimal)
        {
            CalcFormula = Sum("DK_Payment Receipt Doc. Line".Amount WHERE("Document No." = FIELD("Target Doc. No."),
                                                                           "Payment Target" = CONST(Service)));
            Caption = 'Target Line Service Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59000; IDX; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Payment Date", "Payment Type")
        {
        }
        key(Key3; "Document Datetime")
        {
        }
        key(Key4; "Payment Date")
        {
        }
        key(Key5; "Payment Type")
        {
        }
        key(Key6; Amount)
        {
        }
        key(Key7; "Contract No.")
        {
        }
        key(Key8; Description)
        {
        }
        key(Key9; "Payment Date", "Payment Type", Posted, "Contract No.", "Document Type", "Document No.")
        {
        }
        key(Key10; "Cemetery Code")
        {
        }
        key(Key11; "Posting Date")
        {
        }
        key(Key12; "Payment Method Code")
        {
        }
        key(Key13; Posted)
        {
        }
        key(Key14; "Contract No.", Posted)
        {
        }
        key(Key15; "Target Doc. No.", "Document Type")
        {
        }
        key(Key16; "Document Type", "Posting Date", Posted, "Missing Contract")
        {
        }
        key(Key17; "Document Type", "Posting Date", Posted, "Missing Contract", "Payment Type")
        {
        }
        key(Key18; "Document Type", "Befor Liti. Eval.", "Posting Date")
        {
        }
        key(Key19; "Befor Liti. Eval.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Payment Date", "Payment Type", Amount, "Contract No.", "Cemetery No.", Description, "Posting Date")
        {
        }
    }

    trigger OnDelete()
    var
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PaymentReceiptPost: Codeunit "DK_Payment Receipt - Post";
    begin
        if Posted then begin
            //TESTFIELD(Posted, FALSE);

            if "After Document No." <> '' then
                Error(MSG004, FieldCaption("Missing Contract"),
                          FieldCaption("Document No."), "After Document No.");

            //Delete Contract Amount Ledger
            Clear(_PaymentReceiptPost);
            //// _PaymentReceiptPost.DelContractAmountLedger(Rec);

        end else begin
            if "Before Document No." <> '' then begin
                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetRange("Document No.", "Before Document No.");
                _PayReceiptDoc.SetRange("After Document No.", "Document No.");
                if _PayReceiptDoc.FindFirst then begin
                    _PayReceiptDoc."After Document No." := '';
                    _PayReceiptDoc.Modify;
                end;

            end;
        end;

        _PayReceiptDocLine.Reset;
        _PayReceiptDocLine.SetRange("Document No.", "Document No.");
        if _PayReceiptDocLine.FindFirst then
            _PayReceiptDocLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "Document No." = '' then begin

            FunctionSetup.Get;

            if "Document Type" = "Document Type"::Receipt then begin
                FunctionSetup.TestField("Payment Receipt Nos.");
                NoSeriesMgt.InitSeries(FunctionSetup."Payment Receipt Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
            end else begin
                FunctionSetup.TestField("Payment Cr. Memo Nos.");
                NoSeriesMgt.InitSeries(FunctionSetup."Payment Cr. Memo Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
            end;
        end;

        TestField("Document No.");
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;

        "Document Time" := Time;
        "Document Datetime" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
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
        PaymentMothed: Record "DK_Payment Method";
        MSG001: Label 'The %1 data entered in the line will be deleted. Do you want to continue?';
        MSG002: Label 'You can not enter an %1 less than the sum of the amounts entered in the line. Total Line Amount: %2';
        MSG003: Label 'There is data registered in the line does not exist.';
        MSG004: Label 'This %1 copy is currently being used as a different  Document. %2:%3';
        MSG005: Label 'It can not be %2 with the %1 empty.';
        MSG006: Label 'Please enter a date after today. today:%1';
        MSG007: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG008: Label 'ŒŒ€¦Ð‹ÓŒ¡ ‘ÈŠ‰ˆ‡ž ‰È—Ê“‚ˆ« —­ Œ÷ Ž°„Ÿ„¾.';
        MSG009: Label '—÷€¦…Œ÷‘ã· ‘ÈŠ‰ˆ‡ž ‰È—Ê“‚ˆ« —­ Œ÷ Ž°„Ÿ„¾.';
        MSG010: Label 'You are not authorized. Please contact your administrator.';


    procedure AssistEdit(OldPayReceiptDoc: Record "DK_Payment Receipt Document"): Boolean
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin
        with OldPayReceiptDoc do begin
            _PayReceiptDoc := Rec;

            FunctionSetup.Get;
            if OldPayReceiptDoc."Document Type" = OldPayReceiptDoc."Document Type"::Receipt then begin
                FunctionSetup.TestField("Payment Receipt Nos.");
                if NoSeriesMgt.SelectSeries(FunctionSetup."Payment Receipt Nos.", OldPayReceiptDoc."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Document No.");
                    Rec := _PayReceiptDoc;
                    exit(true);
                end;
            end else begin
                FunctionSetup.TestField("Payment Cr. Memo Nos.");
                if NoSeriesMgt.SelectSeries(FunctionSetup."Payment Cr. Memo Nos.", OldPayReceiptDoc."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Document No.");
                    Rec := _PayReceiptDoc;
                    exit(true);
                end;
            end;
        end;
    end;

    local procedure CheckLine(): Boolean
    var
        _PayReceDocLine: Record "DK_Payment Receipt Doc. Line";
    begin

        _PayReceDocLine.Reset;
        _PayReceDocLine.SetRange("Document No.", "Document No.");
        if _PayReceDocLine.FindFirst then begin
            if not Confirm(MSG001, false, _PayReceDocLine.Count) then exit(false);

            _PayReceDocLine.DeleteAll;

        end;

        exit(true);
    end;


    procedure ShowPostedPaymentDocument(pDocNo: Code[20])
    var
        _RecPayReceDoc: Record "DK_Payment Receipt Document";
        _PostedPayReceiptDoc: Page "DK_Posted Pay. Receipt Doc.";
        _PayRecDocument: Page "DK_Payment Receipt Document";
        _PaymentRefundDoc: Page "DK_Payment Refund Document";
        _PostedPayRefundDoc: Page "DK_Posted Pay. Refund Document";
    begin

        _RecPayReceDoc.Reset;
        _RecPayReceDoc.SetRange("Document No.", pDocNo);
        if _RecPayReceDoc.FindSet then begin

            if _RecPayReceDoc."Document Type" = _RecPayReceDoc."Document Type"::Receipt then begin
                if _RecPayReceDoc.Posted then begin
                    Clear(_PostedPayReceiptDoc);
                    _PostedPayReceiptDoc.LookupMode(true);
                    _PostedPayReceiptDoc.SetTableView(_RecPayReceDoc);
                    _PostedPayReceiptDoc.SetRecord(_RecPayReceDoc);
                    _PostedPayReceiptDoc.RunModal;
                end else begin
                    Clear(_PayRecDocument);
                    _PayRecDocument.LookupMode(true);
                    _PayRecDocument.SetTableView(_RecPayReceDoc);
                    _PayRecDocument.SetRecord(_RecPayReceDoc);
                    _PayRecDocument.RunModal;
                end;
            end else begin

                if _RecPayReceDoc.Posted then begin
                    Clear(_PostedPayRefundDoc);
                    _PostedPayRefundDoc.LookupMode(true);
                    _PostedPayRefundDoc.SetTableView(_RecPayReceDoc);
                    _PostedPayRefundDoc.SetRecord(_RecPayReceDoc);
                    _PostedPayRefundDoc.RunModal;
                end else begin
                    Clear(_PaymentRefundDoc);
                    _PaymentRefundDoc.LookupMode(true);
                    _PaymentRefundDoc.SetTableView(_RecPayReceDoc);
                    _PaymentRefundDoc.SetRecord(_RecPayReceDoc);
                    _PaymentRefundDoc.RunModal;
                end;

            end;
        end;
    end;

    local procedure CalcFinalAmount()
    begin

        //¯€¦Ž¸ - ‰²Š±Ô - ×„ŒŽ• ‘÷¼œÀ - ŒÁ‰½ ‘÷¼œÀ + ¿ˆÒŽ¸ + “ñ‰½•‘¿Ž¸
        Validate("Final Amount", Amount - "Legal Amount" - "Delay Interest Amount" - "Liti. Delay Interest Amount" + "Reduction Amount" + "Debt Relief Amount");
    end;
}

