report 50034 "DK_Admin. Enco. Payment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAdminEncoPayment.rdl';
    Caption = 'Admin Encouragement Payment';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Contract; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            column(MainCustomerName; "SHORT TEXT1")
            {
            }
            column(CemeteryNo; "SHORT TEXT0")
            {
            }
            column(LitigationAmount; DECIMAL1)
            {
            }
            column(AdvanceAmount; DECIMAL2)
            {
            }
            column(ExpirationDate; DATE1)
            {
            }
            column(BankAccountHolder; BankAccountHolder)
            {
            }
            column(TotalAmount; TotalAmountText)
            {
            }
            column(LitigationAmountText; LitigationAmountText)
            {
            }
            column(LitigationPeriod; LitigationPeriodText)
            {
            }
            column(AdvanceAmountText; AdvanceAmountText)
            {
            }
            column(AdvancePeriod; AdvancePeriodText)
            {
            }
            column(Bank; BankText)
            {
            }
            column(BankAccountHolderText; BankAccountHolderText)
            {
            }
            column(PaymentDate; PaymentDateText)
            {
            }
            column(ReferenceDate; ReferenceDateText)
            {
            }
            column(CaptionText; CaptionText)
            {
            }

            trigger OnAfterGetRecord()
            var
                _FunctionSetup: Record "DK_Function Setup";
                _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
                _Employee: Record DK_Employee;
                _Contract: Record DK_Contract;
                _ReportPrtHisLitigation: Codeunit "DK_Report Printing";
            begin


                TotalAmountText := StrSubstNo(WonMSG, (Contract.DECIMAL1 + Contract.DECIMAL2));
                LitigationAmountText := StrSubstNo(WonMSG, Contract.DECIMAL1);
                AdvanceAmountText := StrSubstNo(WonMSG, Contract.DECIMAL2);
                LitigationPeriodText := StrSubstNo(LitigationMSG, Format(Contract.DATE2, 0, '<Year4>.<Month,2>.<Day,2>'), Format(Contract.DATE3, 0, '<Year4>.<Month,2>.<Day,2>'), Format(_RevocationContractMgt.CalcContractPreiodMonth(Contract.DATE2, Contract.DATE3)));
                AdvancePeriodText := StrSubstNo(AdvanceMSG, Format(Contract.DATE4, 0, '<Year4>.<Month,2>.<Day,2>'), Format(Contract.DATE5, 0, '<Year4>.<Month,2>.<Day,2>'), Format(_RevocationContractMgt.CalcContractPreiodMonth(Contract.DATE4, Contract.DATE5)));
                BankText := StrSubstNo(BankMSG, BankName, BankAccountNo);
                BankAccountHolderText := StrSubstNo(AccountHolderMSG, BankAccountHolder);
                PaymentDateText := Format(PaymentDate, 0, PaymentDateMSG);
                ReferenceDateText := Format(Today, 0, ReferenceDateMSG);

                _Employee.Reset;
                _Employee.SetRange("ERP User ID", UserId);
                if _Employee.FindSet then begin

                    _Contract.Reset;
                    _Contract.SetRange("No.", CODE0);
                    if _Contract.FindSet then begin
                        Clear(_ReportPrtHisLitigation);
                        _ReportPrtHisLitigation.InsertPrintingHistory(_Contract, _Contract."No.", REPORT::"DK_Admin. Enco. Payment",
                                                                      _Employee."No.", _Employee.Name, '', 0D);
                    end;
                end;


                _FunctionSetup.Get;
                CaptionText := StrSubstNo(CaptionMSG, _FunctionSetup."SMS Phone No.");
            end;

            trigger OnPreDataItem()
            begin
                SetRange("OBJECT ID", PAGE::"DK_Admin. Payment Target");
                SetRange("USER ID", UserId);
                SetRange(BOOLEAN0, true);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    Caption = 'General';
                    field(PaymentDate; PaymentDate)
                    {
                        Caption = 'Payment Date';

                        trigger OnValidate()
                        begin
                            PaymentDate_Validate;
                        end;
                    }
                    field(BankCode; BankCode)
                    {
                        Caption = 'Bank Code';
                        TableRelation = "DK_Receipt Bank Account".Code WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        var
                            _ReceiptBankAccount: Record "DK_Receipt Bank Account";
                        begin

                            SetBankCode;
                        end;
                    }
                    field(BankName; BankName)
                    {
                        Caption = 'Bank Name';
                        Editable = false;
                    }
                    field(BankAccountNo; BankAccountNo)
                    {
                        Caption = 'AccountNo';
                        Editable = false;
                    }
                    field(BankAccountHolder; BankAccountHolder)
                    {
                        Caption = 'Account Holder';
                        Editable = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        var
            _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        begin

            _ReceiptBankAccount.Reset;
            _ReceiptBankAccount.SetRange("Admin. Expense", true);
            if _ReceiptBankAccount.FindSet then
                BankCode := _ReceiptBankAccount.Code;

            PaymentDate := WorkDate;

            SetBankCode;
        end;
    }

    labels
    {
        Title1lbl = '[ Admin Encouragement Payment ]';
        Cap1lbl = 'Ð      ŽÊ      À';
        Cap2lbl = '‰ª   ‘÷   ‰°  ˜ú';
        Cap3lbl = 'ý      ˆ«      Š±';
        Cap4lbl = 'ýˆ«€Ëú ‘Ž‡ßŸ';
        Cap5lbl = 'ý ˆ« Š± ‚‹ ¬';
        Cap6lbl = '¯   €¦   ‰µ  ‰²';
        Cap7lbl = '‚‚   Šž   €Ë  —©';
        Cap8lbl = '€—ŸŒ¡„’ Ôž°° ‰ª‘÷ýˆ«Š±í Î€Ë ‰œ‚‚…—ŽØ, „Ï‹Ï„’ Œ÷ ’ð‡ší ™“” ‚‚ŠžŽ˜‚‹ ‰¸';
        Cap9lbl = '•Ô×ˆª —Ÿ„ˆ‚¬ €—Ÿ„’ œí —Ÿ‘÷ ŽšŽ­„Ÿ„¾.';
        Cap10lbl = 'ýˆ«Š±„’ 5‚ËŽ Œ€‚‚—ŸŒ•ŽÈ —ŸˆÏ, ¼×À— —‰½ ¯„Ÿ„¾.';
        Cap11lbl = '„Ï‹Ïí …Ø‡Ÿ…˜ ‘´Œ­‘÷í Š­Š¨ˆ×—­ µÕ, ‘´Œ­˜«ž‹ º—© —Ê‘ñ²’ðí ‘°—Ê…—ˆÏ Î€Ëøˆ‡ž';
        Cap12lbl = '°°ýˆ«Š±í ‚‚Šž…—‘÷ Žš‹ “, ý‰« “ñ€—“È™€Ëýˆ‡ž œý…™ Œ÷ ´‹ Ž›‡‘…Îˆ‚„Ÿ„¾.';
        Cap13lbl = '€Ë•ˆ ‰«— ‹Ï—¸Š Ôž°° ×„ŒŽ•‡ž ¼†Þ‘´“€Ë ‰¾†°„Ÿ„¾.';
        Cap15lbl = '(¯€¦Àˆ×· ÐŽÊÀˆ×œ ‹Ýœ—­ µÕ, ý˜¡Íˆ‘)';
        Cap16lbl = '2. Ôž°° ˜¿–Íœ‘÷ ( http://www.yongin-park.com )';
        Cap17lbl = '•Ô”½…Îß‘ª (”½…Î ‰½œÀ—­Šž œŠÑ–« ‘°—Ê)';
        Cap18lbl = '3. ý˜¡ •Ô”½…Î ß‘ª (‹ÙŒŠ”½…Î 6‚õ, •—©”½…Î 5‚õ, €‰‰ž/Š±ŽŽ”½…Î Ÿ“Š­)';
        Footerlbl = 'Ï„Â‰²ž Ôž°°';
    }

    var
        BankCode: Code[20];
        BankName: Text;
        BankAccountNo: Text;
        BankAccountHolder: Text;
        PaymentDate: Date;
        TotalAmountText: Text;
        LitigationAmountText: Text;
        AdvanceAmountText: Text;
        LitigationPeriodText: Text;
        AdvancePeriodText: Text;
        WonMSG: Label '%1Won';
        LitigationMSG: Label 'Litigation Period : %1 ~ %2 (%3)';
        AdvanceMSG: Label 'Advance Period : %1 ~ %2 (%3)';
        BankMSG: Label '1. %1 : %2';
        AccountHolderMSG: Label 'Account Holder : %1';
        BankText: Text;
        BankAccountHolderText: Text;
        PaymentDateText: Text;
        ReferenceDateText: Text;
        PaymentDateMSG: Label 'By <Year4>-<Month,2>-<Day,2>';
        ReferenceDateMSG: Label 'í¹ Reference Date : <Year4>-<Month,2>-<Day,2>';
        CaptionMSG: Label '[ Yongin : %1 ]';
        CaptionText: Text;
        MSG001: Label 'You cannot enter a date smaller than today''s date.';
        MSG002: Label 'The due date is required.';


    procedure SetBankCode()
    var
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
    begin

        _ReceiptBankAccount.Reset;
        _ReceiptBankAccount.SetRange(Code, BankCode);
        if _ReceiptBankAccount.FindSet then begin
            BankName := _ReceiptBankAccount."Bank Name";
            BankAccountNo := _ReceiptBankAccount."Bank Account No.";
            BankAccountHolder := _ReceiptBankAccount."Account Holder";
        end else begin
            BankName := '';
            BankAccountNo := '';
            BankAccountHolder := '';
        end;
    end;


    procedure PaymentDate_Validate()
    begin

        if PaymentDate <> 0D then begin
            if PaymentDate < WorkDate then
                Error(MSG001);
        end else
            Error(MSG002);
    end;
}

