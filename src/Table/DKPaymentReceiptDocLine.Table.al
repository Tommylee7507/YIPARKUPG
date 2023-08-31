table 50083 "DK_Payment Receipt Doc. Line"
{
    // #2542 : 20200416
    //   - Add Field : "Cemetery No."
    //                 "Description"
    //                 "Main Customer Birthday"
    //                 "Main Customer No."

    Caption = 'Payment Receipt Doc. Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Payment Target"; Option)
        {
            Caption = 'Payment Target';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Deposit,Contract Amount,Remaining Amount,General,Landscape Architecturee,Service';
            OptionMembers = Blank,Deposit,Contract,Remaining,General,Landscape,Service;

            trigger OnValidate()
            var
                _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
            begin
                if xRec."Payment Target" <> "Payment Target" then begin
                    CalcFields("Payment Type", "Contract No.");

                    if "Contract No." = '' then
                        Error(MSG013, FieldCaption("Contract No."));

                    if ("Payment Type" = "Payment Type"::DebtRelief) and
                      ("Payment Target" <> "Payment Target"::Blank) then begin

                        if not ("Payment Target" in ["Payment Target"::General, "Payment Target"::Landscape]) then
                            Error(MSG011, "Payment Type"::DebtRelief, "Payment Target"::General, "Payment Target"::Landscape);
                    end;

                    if "Payment Target" in ["Payment Target"::Deposit, "Payment Target"::Contract] then begin
                        _PayReceiptDocLine.Reset;
                        _PayReceiptDocLine.SetRange("Document No.", "Document No.");
                        _PayReceiptDocLine.SetRange("Payment Target", "Payment Target");
                        _PayReceiptDocLine.SetFilter("Line No.", '<>%1', "Line No.");
                        if _PayReceiptDocLine.FindFirst then begin
                            _PayReceiptDocLine.CalcFields(Posted);

                            Error(MSG006, _PayReceiptDocLine."Payment Target",
                                      _PayReceiptDocLine.FieldCaption("Document No."),
                                      _PayReceiptDocLine."Document No.",
                                      _PayReceiptDocLine.FieldCaption(Amount),
                                      _PayReceiptDocLine.Amount,
                                      _PayReceiptDocLine.FieldCaption(Posted),
                                      _PayReceiptDocLine.Posted);
                        end;

                    end;


                    Validate("Cem. Services No.", '');

                    Validate(Amount, CalcDefAmount);

                end;
            end;
        }
        field(3; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Diff: Decimal;
                _LineTotal: Decimal;
                _CemeteryServices: Record "DK_Cemetery Services";
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _Contract: Record DK_Contract;
                _AdminExpenseType: Option;
            begin
                //IF xRec.Amount <> Amount THEN BEGIN

                if not ("Payment Target" in ["Payment Target"::General, "Payment Target"::Landscape]) then
                    "Start Date" := 0D;

                "Expiration Date" := 0D;
                "Period Amount" := 0;
                "Diff. Amount" := 0;

                if Amount <> 0 then begin

                    CalcFields("Payment Amount");
                    _LineTotal := TotalLineAmount("Line No.");
                    _Diff := "Payment Amount" - (_LineTotal + Amount);

                    if _Diff < 0 then
                        Error(MSG002, FieldCaption(Amount), FieldCaption("Payment Amount"), "Payment Amount" - _LineTotal);

                    if "Cem. Services No." <> '' then begin
                        _CemeteryServices.Get("Cem. Services No.");
                        if Amount > (_CemeteryServices.Amount - _CemeteryServices."Receipt Amount") then
                            Error(MSG008, FieldCaption(Amount), _CemeteryServices."No.");
                    end;

                    case "Payment Target" of
                        "Payment Target"::General, "Payment Target"::Landscape:
                            begin
                                CalcFields("Contract No.");
                                if _Contract.Get("Contract No.") then begin
                                    if "Payment Target" = "Payment Target"::General then begin
                                        if _Contract."General Expiration Date" <> 0D then
                                            "Start Date" := _Contract."General Expiration Date" + 1;

                                        _AdminExpenseType := 0;
                                    end else begin
                                        _Contract.CalcFields("Landscape Architecture");
                                        if not _Contract."Landscape Architecture" then
                                            Error(MSG012);
                                        if _Contract."Land. Arc. Expiration Date" <> 0D then
                                            "Start Date" := _Contract."Land. Arc. Expiration Date" + 1;

                                        _AdminExpenseType := 1;
                                    end;

                                    if "Start Date" <> 0D then begin
                                        CalcFields("Payment Date", "Missing Contract");
                                        "Expiration Date" := _AdminExpenseMgt.GetCalcAdminExpenseEndingDateForAmount("Contract No.", _AdminExpenseType, Amount, "Period Amount", "Diff. Amount",
                                                                                                                      "Payment Date", "Missing Contract");
                                        "Befor Expiration Date" := "Expiration Date";
                                    end;
                                end;
                            end;
                    end;
                end;

                if ("Expiration Date" = 0D) or ("Start Date" = 0D) then begin
                    "Period Amount" := 0;
                    "Diff. Amount" := 0;
                end;
                //END;
            end;
        }
        field(4; Remark; Text[50])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(5; "AR Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'AR Remaining Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Contract No."; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Contract No." WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Contract No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Payment Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup("DK_Payment Receipt Document"."Final Amount" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Payment Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Period Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount in Period';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Diff. Amount" := Amount - "Period Amount";
            end;
        }
        field(10; "Diff. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Diff. Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Regular Type"; Option)
        {
            Caption = 'Regular Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'None,Regular,Unpaid';
            OptionMembers = "None",Regular,Unpaid;
        }
        field(1000; "Payment Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Payment Date" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Payment Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001; "Bank Account Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Bank Account Code" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Bank Account Code';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(1002; "Bank Account Name"; Text[50])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Bank Account Name" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Bank Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1003; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(1004; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseType: Option;
            begin
                if xRec."Expiration Date" <> "Expiration Date" then begin
                    if "Expiration Date" <> 0D then begin

                        case "Payment Target" of
                            "Payment Target"::General, "Payment Target"::Landscape:
                                begin
                                    if "Payment Target" = "Payment Target"::General then begin
                                        _AdminExpenseType := 0;
                                    end else begin
                                        _AdminExpenseType := 1;
                                    end;
                                    CalcFields("Contract No.", "Payment Date", "Missing Contract");
                                    Validate("Period Amount", _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate("Contract No.", _AdminExpenseType, "Expiration Date", "Payment Date", "Missing Contract"));
                                end;
                        end;
                    end;
                end;
            end;
        }
        field(1005; "Payment Type"; Option)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Payment Type" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Payment Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Bank Transfer,Credit Card,Cash,Giro,Onlie Credit Card,Virtual Account,Debt Relief';
            OptionMembers = "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount,DebtRelief;
        }
        field(1006; "Cem. Services No."; Code[20])
        {
            Caption = 'Cem. Services No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Target" = CONST(Service),
                                Posted = CONST(false)) "DK_Cemetery Services"."No." WHERE("Contract No." = FIELD("Contract No."),
                                                                                         Status = CONST(Release),
                                                                                         "Receipt Amount Date" = FILTER(0D));

            trigger OnValidate()
            begin

                if "Cem. Services No." <> xRec."Cem. Services No." then begin
                    if "Cem. Services No." <> '' then begin
                        TestField("Payment Target", "Payment Target"::Service);
                        DuplicateServiceNo;
                        CheckCemServices("Cem. Services No.");
                        GetCemServiceNo;
                    end;
                    CalcFields("Field Work Main Cat. Name", "Field Work Sub Cat. Name");
                end;
            end;
        }
        field(1007; "Bef. Non-Pay. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Before Non-Payment Amount';
            DataClassification = ToBeClassified;
        }
        field(1008; Posted; Boolean)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document".Posted WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Posted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1009; "Missing Contract"; Boolean)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Missing Contract" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Missing Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1010; "Document Type"; Option)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Document Type" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Document Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Receipt,Refund';
            OptionMembers = Receipt,Refund;
        }
        field(1012; "Cemetery Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Cemetery Code" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Cemetery Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1013; "Befor Liti. Eval."; Option)
        {
            Caption = 'AfterLitigation Evaluation';
            Description = '#3202';
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(1014; "After Liti. Eval."; Option)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."After Liti. Eval." WHERE("Document No." = FIELD("Document No.")));
            Caption = 'After Litigation Evaluation';
            Description = '#3202';
            Editable = true;
            FieldClass = FlowField;
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(1015; "Posting Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Posting Date" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1016; "Befor Expiration Date"; Date)
        {
            Caption = 'Befor Expiration Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseType: Option;
            begin
            end;
        }
        field(1017; "Field Work Main Cat. Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Cemetery Services"."Field Work Main Cat. Name" WHERE("No." = FIELD("Cem. Services No.")));
            Caption = 'Field Work Main Cat. Name';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
            end;
        }
        field(1018; "Field Work Sub Cat. Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Cemetery Services"."Field Work Sub Cat. Name" WHERE("No." = FIELD("Cem. Services No.")));
            Caption = 'Field Work Sub Cat. Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1019; Refund; Boolean)
        {
            Caption = 'Refund';
            Editable = false;
        }
        field(1020; "Field Work Main Cat. Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Cemetery Services"."Field Work Main Cat. Code" WHERE("No." = FIELD("Cem. Services No.")));
            Caption = 'Field Work Main Cat. Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1021; "Field Work Sub Cat. Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Cemetery Services"."Field Work Sub Cat. Code" WHERE("No." = FIELD("Cem. Services No.")));
            Caption = 'Field Work Sub Cat. Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2000; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(2001; "Led. Gen. Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("DK_Admin. Expense Ledger".Amount WHERE("Contract No." = FIELD("Contract No."),
                                                                        "Source No." = FIELD("Document No."),
                                                                        "Source Line No." = FIELD("Line No."),
                                                                        "Admin. Expense Type" = CONST(General),
                                                                        "Ledger Type" = CONST(Daily)));
            Caption = 'Led. Gen. Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2002; "Led. Gen. SubTot Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("DK_Admin. Expense Ledger".Amount WHERE("Contract No." = FIELD("Contract No."),
                                                                        "Admin. Expense Type" = CONST(General),
                                                                        "Ledger Type" = CONST(Daily),
                                                                        Date = FIELD("Date Filter")));
            Caption = 'Led. Gen. SubTotal Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2003; "Led. Lan. Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("DK_Admin. Expense Ledger".Amount WHERE("Contract No." = FIELD("Contract No."),
                                                                        "Source No." = FIELD("Document No."),
                                                                        "Source Line No." = FIELD("Line No."),
                                                                        "Admin. Expense Type" = CONST(Landscape),
                                                                        "Ledger Type" = CONST(Daily)));
            Caption = 'Led. Lan. Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2004; "Led. Lan. SubTot Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("DK_Admin. Expense Ledger".Amount WHERE("Contract No." = FIELD("Contract No."),
                                                                        "Admin. Expense Type" = CONST(Landscape),
                                                                        "Ledger Type" = CONST(Daily),
                                                                        Date = FIELD("Date Filter")));
            Caption = 'Led. Lan. SubTot Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2005; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Cemetery No." WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Cemetery No.';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2006; Description; Text[100])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document".Description WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Description';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2007; "Main Customer No."; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."Main Customer No." WHERE("No." = FIELD("Contract No.")));
            Caption = 'Main Customer No.';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2008; "Main Customer Birthday"; Date)
        {
            CalcFormula = Lookup(DK_Customer.Birthday WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Birthday';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59000; Idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59001; contractNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59002; PaymentDate; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Payment Target", "Start Date", "Expiration Date")
        {
        }
        key(Key3; "Payment Target")
        {
        }
        key(Key4; "Start Date")
        {
        }
        key(Key5; "Expiration Date")
        {
        }
        key(Key6; "Document No.", "Payment Target")
        {
        }
        key(Key7; "Document No.", "Cem. Services No.")
        {
        }
        key(Key8; "Payment Target", "Regular Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Payment Target" = "Payment Target"::Blank then
            Error(MSG004, FieldCaption("Payment Target"));

        TestField(Amount);
    end;

    trigger OnModify()
    begin
        if "Payment Target" = "Payment Target"::Blank then
            Error(MSG004, FieldCaption("Payment Target"));

        TestField(Amount);
    end;

    var
        MSG001: Label 'Enter the %2 first in %1';
        MSG002: Label 'The sum of %1 entered in the line can not exceed %2. Available Amount: %3';
        MSG003: Label 'You can edit and delete it only if the Status is ''Open''.';
        MSG004: Label 'Enter the %1.';
        MSG005: Label 'You cannot specify the same %1. %2';
        MSG006: Label '% 1 has already been added to the Receipt Document. %2:%3, %4:%5, %6:%7';
        MSG007: Label 'This document has been successfully deposited. %1';
        MSG008: Label 'You can not enter greater than the %1 from amount to receipt. Document No. : %2';
        MSG009: Label 'This is different from the %1 of the payment receipt document. %2';
        MSG010: Label 'If the %1 is not %2, it is not selectable.';
        MSG011: Label 'If %1, only %2 and %3 can be processed.';
        MSG012: Label 'You cannot select it.';
        MSG013: Label 'Contract No. not specified. Please enter a contract No. first.';


    procedure CheckHeader(): Boolean
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
    begin

        _PayRecDoc.Reset;
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange("Document No.", "Document No.");
        if _PayRecDoc.FindSet then begin

            if _PayRecDoc.Litigation then begin
                if _PayRecDoc."Final Amount" = 0 then
                    Error(MSG001, _PayRecDoc.TableCaption, _PayRecDoc.FieldCaption("Final Amount"));
            end else begin
                if _PayRecDoc.Amount = 0 then
                    Error(MSG001, _PayRecDoc.TableCaption, _PayRecDoc.FieldCaption(Amount));
            end;
            case _PayRecDoc."Payment Type" of
                _PayRecDoc."Payment Type"::Bank:
                    begin
                        if _PayRecDoc."Bank Account Code" = '' then
                            Error(MSG001, _PayRecDoc.TableCaption, _PayRecDoc.FieldCaption("Bank Account Code"));
                    end;
                _PayRecDoc."Payment Type"::Card:
                    begin
                        if _PayRecDoc."Payment Method Code" = '' then
                            Error(MSG001, _PayRecDoc.TableCaption, _PayRecDoc.FieldCaption("Payment Method Code"));
                    end;
            end;

            if _PayRecDoc."Contract No." = '' then
                Error(MSG001, _PayRecDoc.TableCaption, _PayRecDoc.FieldCaption("Contract No."));

            if _PayRecDoc."Cemetery Code" = '' then
                Error(MSG001, _PayRecDoc.TableCaption, _PayRecDoc.FieldCaption("Cemetery Code"));

            exit(true);
        end;
    end;


    procedure CheckCemServices(pCemServicesNo: Code[20])
    var
        _CemeteryServices: Record "DK_Cemetery Services";
    begin

        _CemeteryServices.Reset;
        _CemeteryServices.SetRange("No.", pCemServicesNo);
        if _CemeteryServices.FindFirst then begin
            CalcFields("Contract No.");
            if _CemeteryServices."Contract No." <> "Contract No." then begin
                Error(MSG009, FieldCaption("Contract No."), "Contract No.");
            end;
        end;
    end;

    local procedure GetContractOriginalAmount(pRec: Record "DK_Payment Receipt Doc. Line"): Decimal
    var
        _ContAmtLedger: Record "DK_Contract Amount Ledger";
        _Contract: Record DK_Contract;
    begin

        pRec.CalcFields("Contract No.");

        if _Contract.Get(pRec."Contract No.") then begin
            exit(_Contract."Pay. Remaining Amount");
        end;
    end;

    procedure CalcTotalAmount(var PayReceDocLine: Record "DK_Payment Receipt Doc. Line"; LastPayReceDocLine: Record "DK_Payment Receipt Doc. Line"; var TotalAmount: Decimal)
    var
        TempPayReceDocLine: Record "DK_Payment Receipt Doc. Line";
    begin
        TempPayReceDocLine.CopyFilters(PayReceDocLine);

        TempPayReceDocLine.SetRange("Document No.", PayReceDocLine."Document No.");
        TempPayReceDocLine.CalcSums(Amount);

        TotalAmount := TempPayReceDocLine.Amount;
    end;

    local procedure TotalLineAmount(pLineNo: Integer): Decimal
    var
        _PayReceDocLine: Record "DK_Payment Receipt Doc. Line";
    begin

        _PayReceDocLine.Reset;
        _PayReceDocLine.SetRange("Document No.", "Document No.");
        _PayReceDocLine.SetFilter("Line No.", '<>%1', pLineNo);
        if _PayReceDocLine.FindFirst then begin

            _PayReceDocLine.CalcSums(Amount);
            exit(_PayReceDocLine.Amount);
        end;
    end;


    procedure CalcDefAmount(): Decimal
    var
        _RemAmount: Decimal;
    begin

        //Calc. Amount
        if CheckHeader then begin
            CalcFields("Payment Amount");
            _RemAmount := "Payment Amount" - TotalLineAmount("Line No.");

            case "Payment Target" of
                "Payment Target"::Remaining:
                    begin
                        "AR Remaining Amount" := GetContractOriginalAmount(Rec);
                    end;
                else begin
                    exit(_RemAmount);
                end;
            end;

            if _RemAmount < "AR Remaining Amount" then
                exit(_RemAmount)
            else
                exit("AR Remaining Amount");
        end;
    end;

    local procedure UpdateHeader()
    var
        _PayReceiptDocument: Record "DK_Payment Receipt Document";
    begin

        _PayReceiptDocument.Reset;
        _PayReceiptDocument.SetRange("Document Type", _PayReceiptDocument."Document Type"::Receipt);
        _PayReceiptDocument.SetRange("Document No.", "Document No.");
        if _PayReceiptDocument.FindSet then begin

            _PayReceiptDocument."Last Date Modified" := CurrentDateTime;
            _PayReceiptDocument."Last Modified Person" := UserId;
            _PayReceiptDocument.Modify;
        end;
    end;

    local procedure CalcDuplicatePaymentTarget(pLineNo: Integer; pPaymentTarget: Option)
    var
        _PayReceDocLine: Record "DK_Payment Receipt Doc. Line";
    begin

        _PayReceDocLine.Reset;
        _PayReceDocLine.SetRange("Document No.", "Document No.");
        _PayReceDocLine.SetRange("Payment Target", pPaymentTarget);
        _PayReceDocLine.SetFilter("Line No.", '<>%1', pLineNo);
        if _PayReceDocLine.FindFirst then
            Error(MSG005, _PayReceDocLine.FieldCaption("Payment Target"), _PayReceDocLine."Payment Target");
    end;


    procedure GetCemServiceNo()
    var
        _CemeteryServices: Record "DK_Cemetery Services";
        _CalcAmount: Decimal;
        _TotalAmount: Decimal;
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    begin
        if "Cem. Services No." = '' then begin
            Amount := 0;
            exit;
        end;

        if _CemeteryServices.Get("Cem. Services No.") then begin

            _CemServicesPost.Check_FieldWork(_CemeteryServices);

            if _CemeteryServices."Receipt Amount" >= _CemeteryServices.Amount then begin
                "Cem. Services No." := xRec."Cem. Services No.";
                Error(MSG007, "Cem. Services No.");
            end;

            _CalcAmount := _CemeteryServices.Amount - _CemeteryServices."Receipt Amount";

            CalcFields("Payment Amount");
            if "Payment Amount" <= _CalcAmount then
                Amount := "Payment Amount"
            else
                Amount := _CalcAmount;

        end;
    end;


    procedure DuplicateServiceNo()
    var
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
    begin

        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", "Document No.");
        _PayRecDocLine.SetRange("Payment Target", "Payment Target");
        _PayRecDocLine.SetRange("Cem. Services No.", "Cem. Services No.");
        if _PayRecDocLine.FindFirst then
            Error(MSG005, FieldCaption("Cem. Services No."), _PayRecDocLine."Cem. Services No.");
    end;
}

