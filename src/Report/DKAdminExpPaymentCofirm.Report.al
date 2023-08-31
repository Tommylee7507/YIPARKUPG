report 50016 "DK_Admin. Exp. Payment Cofirm"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAdminExpPaymentCofirm.rdl';
    Caption = 'Admin Expense Payment Cofirmation';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    Permissions =
        tabledata DK_Contract = R,
        tabledata "DK_Payment Method" = R,
        tabledata "DK_Payment Receipt Document" = R,
        tabledata "DK_Receipt Bank Account" = R;

    dataset
    {
        dataitem("DK_Payment Receipt Document"; "DK_Payment Receipt Document")
        {
            DataItemTableView = SORTING("Document Type", "Document No.");
            PrintOnlyIfDetail = true;
            column(PaymentDate; "DK_Payment Receipt Document"."Payment Date")
            {
            }
            column(PaymentType; "DK_Payment Receipt Document"."Payment Type")
            {
            }
            column(BankAccountCode; "DK_Payment Receipt Document"."Bank Account Code")
            {
            }
            column(PaymentAmount; "DK_Payment Receipt Document".Amount)
            {
            }
            column(Today; Format(Today, 0, '<Year4>. <Month,2>. <Day,2>.'))
            {
            }
            column(PaymentTypeText; PaymentTypeText)
            {
            }
            column(GeneralTerm; GeneralTermText)
            {
            }
            column(LandscapeTerm; LandscapeTermText)
            {
            }
            column(AdminPayAmount; AdminPayAmount)
            {
            }
            column(BodyLineText_; BodyLineText)
            {
            }
            column(AmountText_; AmountText)
            {
            }
            dataitem(DK_Contract; DK_Contract)
            {
                DataItemLink = "No." = FIELD("Contract No.");
                DataItemTableView = SORTING("No.");
                column(MainCustomerName; DK_Contract."Main Customer Name")
                {
                }
                column(CemeteryNo; DK_Contract."Cemetery No.")
                {
                }
                column(CemeterySize; DK_Contract."Cemetery Size")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                _ReceiptBankAccount: Record "DK_Receipt Bank Account";
                _CreditCardCompany: Record "DK_Payment Method";
                _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
                _DateFrom: Date;
                _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
            begin
                "DK_Payment Receipt Document".CalcFields("Line General Start Date", "Line General Expiration Date", "Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date", "Line Admin. Expense");

                case "Payment Type" of
                    "Payment Type"::Bank:
                        begin
                            _ReceiptBankAccount.Reset;
                            _ReceiptBankAccount.SetRange(Code, "Bank Account Code");
                            if _ReceiptBankAccount.FindSet then
                                PaymentTypeText := Format("Payment Type"::Bank) + ' (' + _ReceiptBankAccount."Bank Name" + ')';
                        end;
                    "Payment Type"::Card:
                        begin
                            _CreditCardCompany.Get("DK_Payment Receipt Document"."Payment Mothed Type", "DK_Payment Receipt Document"."Payment Method Code");
                            PaymentTypeText := Format("Payment Type"::Card) + ' (' + _CreditCardCompany.Name + ')';
                        end;
                    "Payment Type"::Cash:
                        begin
                            PaymentTypeText := Format("Payment Type"::Cash);
                        end;
                    "Payment Type"::Giro:
                        begin
                            PaymentTypeText := Format("Payment Type"::Giro);
                        end;
                    "Payment Type"::OnlineCard:
                        begin
                            PaymentTypeText := Format("Payment Type"::OnlineCard);
                        end;
                end;
                /*
                WITH _AdminExpenseLedger DO BEGIN
                 SetCurrentKey(Date);
                 SetRange("Contract No.","DK_Payment Receipt Document"."Contract No.");
                 SetRange("Source No.","DK_Payment Receipt Document"."Document No.");
                 SetRange("Ledger Type","Ledger Type"::Daily);
                 */
                //Ÿ‰¦ýˆ«Š± €Ëú
                // SetRange("Admin. Expense Type","Admin. Expense Type"::General);
                //  IF FINDFIRST THEN BEGIN
                if "DK_Payment Receipt Document"."Line General Start Date" <> 0D then begin
                    GeneralTermText := Format("DK_Payment Receipt Document"."Line General Start Date", 0, MSG004);
                    GeneralTermText += '~';
                    _DateFrom := "DK_Payment Receipt Document"."Line General Start Date";
                    // END;
                    //IF FINDLAST THEN BEGIN
                    GeneralTermText += Format("DK_Payment Receipt Document"."Line General Expiration Date", 0, MSG004);
                    GeneralTermText += '(';
                    GeneralTermText += _RevocationContractMgt.CalcContractPreiod(_DateFrom, "DK_Payment Receipt Document"."Line General Expiration Date");
                    GeneralTermText += ')';
                    // END;
                end;

                //‘†µýˆ«Š± €Ëú
                //SetRange("Admin. Expense Type","Admin. Expense Type"::Landscape);
                // IF FINDFIRST THEN BEGIN
                if "DK_Payment Receipt Document"."Line Land. Arc. Start Date" <> 0D then begin
                    LandscapeTermText := Format("DK_Payment Receipt Document"."Line Land. Arc. Start Date", 0, MSG004);
                    LandscapeTermText += '~';
                    _DateFrom := "DK_Payment Receipt Document"."Line Land. Arc. Start Date";
                    // END;
                    // IF FINDLAST THEN BEGIN
                    LandscapeTermText += Format("DK_Payment Receipt Document"."Line Land. Arc. Exp. Date", 0, MSG004);
                    LandscapeTermText += '(';
                    LandscapeTermText += _RevocationContractMgt.CalcContractPreiod(_DateFrom, "DK_Payment Receipt Document"."Line Land. Arc. Exp. Date");
                    LandscapeTermText += ')';
                    //END;
                end;

                //SetRange("Admin. Expense Type");
                //SETRANGE(Date,"DK_Payment Receipt Document"."Payment Date");
                //SetRange("Ledger Type",_AdminExpenseLedger."Ledger Type"::Receipt);

                // IF FINDSET THEN BEGIN
                //   CALCSUMS(Amount);
                AdminPayAmount := "DK_Payment Receipt Document"."Line Admin. Expense";
                // END;
                //END;

                BodyLineText := StrSubstNo(MSG002, Format(AdminPayAmount),
                        Format("DK_Payment Receipt Document"."Payment Date", 0, MSG004));

                AmountText := StrSubstNo(MSG003, Format(AdminPayAmount));

            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Type", "Document Type"::Receipt);

                if DocumentNo <> '' then
                    SetRange("Document No.", DocumentNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DocumentNo; DocumentNo)
                {
                    Caption = 'Document No.';
                    TableRelation = "DK_Payment Receipt Document"."Document No." WHERE(Posted = CONST(true));
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TitleLb = 'Admin Expense Payment Confrimation';
        PaymentTypeLb = 'Payment Type';
        MainCustNameLb = 'Main Customer Name';
        CemeteryNoLb = 'Cemetery No.';
        AmountLb = 'Amount';
        GeneralTermLb = 'General Term';
        LandscapeTermLb = 'Landscape Term';
        BodyLb1 = 'Foundation Coporation Yongin Park';
        BodyLb2 = 'Cemetery Management Cost';
        BodyLb3 = 'Of';
        BodyLb4 = 'Confirm the standard payment';
        BracketStart = '(';
        BracketEnd = ')';
        UnitLb = 'Won';
        SizeLb = 'Size';
    }

    var
        DocumentNo: Code[20];
        MSG001: Label 'Only the posted documents can be selected.';
        PaymentTypeText: Text[50];
        GeneralTermText: Text;
        LandscapeTermText: Text;
        AdminPayAmount: Decimal;
        MSG002: Label 'I confirm the payment of the %1 won Yuan management fee of the Yongin Park burial ground foundation foundation on the %2.';
        BodyLineText: Text;
        MSG003: Label '%1won';
        AmountText: Text;
        MSG004: Label '<Year4>-<Month,2>-<Day,2>';


    procedure SetParam(pNo: Code[20])
    begin

        DocumentNo := pNo;
    end;
}

