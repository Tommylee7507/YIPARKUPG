report 50033 "DK_Admin. Cooperation Payment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAdminCooperationPayment.rdl';
    Caption = 'Admin. Cooperation Payment';
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
            column(CemeteryNo; "SHORT TEXT2")
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
            column(CaptionText; CaptionText)
            {
            }
            column(PaymentDateText; PaymentDateText)
            {
            }
            column(CemeteryNoText; CemeteryNoText)
            {
            }
            column(TotalAmountText; TotalAmountText)
            {
            }
            column(LitigationAmountText; LitigationAmountText)
            {
            }
            column(AdvanceAmountText; AdvanceAmountText)
            {
            }
            column(LitigationPeriodText; LitigationPeriodText)
            {
            }
            column(AdvancePeriodText; AdvancePeriodText)
            {
            }
            column(BankNameText; BankNameText)
            {
            }
            column(BankAccountNoText; BankAccountNoText)
            {
            }
            column(ReferenceDateText; ReferenceDateText)
            {
            }
            column(Employee; Employee)
            {
            }
            column(CompanyPhoneNo; CompanyPhoneNo)
            {
            }

            trigger OnAfterGetRecord()
            var
                _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
                _Employee: Record DK_Employee;
                _FunctionSetup: Record "DK_Function Setup";
                _ReportPrtHisLitigation: Codeunit "DK_Report Printing";
                _Contract: Record DK_Contract;
            begin

                CaptionText := StrSubstNo(CaptionMSG, Contract."SHORT TEXT1");
                PaymentDateText := Format(PaymentDate, 0, PaymentDateMSG);
                CemeteryNoText := StrSubstNo(CemeteryMSG, Contract."SHORT TEXT0");
                TotalAmountText := StrSubstNo(WonMSG, (Contract.DECIMAL1 + Contract.DECIMAL2));
                LitigationAmountText := StrSubstNo(WonMSG, Contract.DECIMAL1);
                AdvanceAmountText := StrSubstNo(WonMSG, Contract.DECIMAL2);
                LitigationPeriodText := StrSubstNo(LitigationMSG, Format(Contract.DATE2, 0, '<Year4>.<Month,2>.<Day,2>'), Format(Contract.DATE3, 0, '<Year4>.<Month,2>.<Day,2>'), _RevocationContractMgt.CalcContractPreiodMonth(Contract.DATE2, Contract.DATE3));
                AdvancePeriodText := StrSubstNo(AdvanceMSG, Format(Contract.DATE4, 0, '<Year4>.<Month,2>.<Day,2>'), Format(Contract.DATE5, 0, '<Year4>.<Month,2>.<Day,2>'), _RevocationContractMgt.CalcContractPreiodMonth(Contract.DATE4, Contract.DATE5));
                BankNameText := StrSubstNo(BankNameMSG, BankName);
                BankAccountNoText := StrSubstNo(BankAccountNoMSG, BankAccountNo);
                ReferenceDateText := Format(Today, 0, TodayMSG);

                _Employee.Reset;
                _Employee.SetRange("ERP User ID", UserId);
                if _Employee.FindSet then begin
                    Employee := _Employee.Name;

                    _Contract.Reset;
                    _Contract.SetRange("No.", CODE0);
                    if _Contract.FindSet then begin
                        Clear(_ReportPrtHisLitigation);
                        _ReportPrtHisLitigation.InsertPrintingHistory(_Contract, _Contract."No.", REPORT::"DK_Admin. Cooperation Payment",
                                                                      _Employee."No.", _Employee.Name, '', 0D);
                    end;
                end;

                _FunctionSetup.Get;
                CompanyPhoneNo := _FunctionSetup."SMS Phone No.";
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
        Title1lbl = 'Admin Coopertion Payment';
        Cap1lbl = 'You';
        Cap2lbl = '°°— Œ€…ýˆ« ‰Èý‹ º—¹ ýˆ«Š± ‚‚Šž—‰½ˆª „¾—¹ ‘´—‹ „ÏŠž…Îˆ‚„Ÿ„¾.';
        Cap3lbl = '2  „Ï ‰²žŠ ÐŽÊÀí¯ ‡»’ð‡š ý˜¡ ‰¸ Õ–×‹ •Ô—¹ ×‘÷—Ÿ„ˆ‚¬ Ž–‘ð€Ø‘÷ ‚‚Šží Ž˜…—× ´„Ÿ„¾.';
        Cap4lbl = 'ýˆ«Š±„’ 5‚ËŠ¨Ž Œ€‚‚ˆ‡ž ‚‚Šž—ŸŒ•ŽÈ —³„Ÿ„¾.';
        Cap5lbl = '‰ª¬— ýˆ«Š± ‚‚Šž„’ ‰ª¬‹ œÔ—Ÿ× Ð• …Ž˜ ‚‚Šž—ŸŽÈ —Ÿ„’ ¼×À— —‰½¯„Ÿ„¾.';
        Cap6lbl = '3  ˜ˆ°„¯Œ¡ ˆˆŽÊ „Ï ‰²žˆ‡ž ¼†Þ“‚í ‹Ýœ—­ µÕ Š»µ—Ÿ ‘´“‘÷ Žš‹ µÕí„’ ‘´Œ­˜«ž‹ º—©';
        Cap7lbl = '²’ðí ‘°—Ê…™ Œ÷ ´‹ Ž›‡‘…Îˆ‚„Ÿ„¾.';
        Cap8lbl = '- ýˆ«Š± ‚‹¬ -';
        Cap9lbl = 'Ð      ŽÊ      À';
        Cap10lbl = 'ý      ˆ«      Š±';
        Cap11lbl = 'ý ˆ« Š± ‚‹ ¬';
        Cap12lbl = 'ýˆ«€Ëú ‘Ž‡ßŸ';
        Cap13lbl = 'ß   ‘ª   ‰µ  ‰²';
        Cap14lbl = '‰      €¦      ‘´';
        Cap15lbl = '„Ì      „Ï      À';
        Cap16lbl = 'óž Ôž°° ý˜¡‰°˜ú';
        Cap17lbl = 'í¹ ¯€¦Àˆ×œ ÐŽÊÀˆ×· ‹Ýœ—­ µÕ ý˜¡‘´“ˆÒ ¿‹Ï—ŸÀ„Ÿ„¾.';
        Cap18lbl = 'í¹ ý˜¡•Ô˜¡‡ž •Ô”½…Î ß‘ªí í„™—³„Ÿ„¾. (‹ÙŒŠ”½…Î 6‚õ, •—©”½…Î 5‚õ, €‰‰ž/Š±ŽŽ”½…Î Ÿ“Š­)';
        Cap19lbl = 'í¹ Ôž°° ˜¿–Íœ‘÷(http://www.yongin-park.com)íŒ¡ •Ô”½…Î ß‘ªí í„™—³„Ÿ„¾.';
        Cap20lb = '(”½…Î ‰½œÀ —­Šž œŠÑ–« ‘°—Ê)';
        Footer1lbl = 'Ï„Â‰²ž Ôž°°';
    }

    var
        BankCode: Code[20];
        BankName: Text;
        BankAccountNo: Text;
        BankAccountHolder: Text;
        PaymentDate: Date;
        CaptionMSG: Label '1  %1 has signed a contract with Yongin Park Cemetery and is using the Park Cemetery.';
        PaymentDateMSG: Label 'Payment Duration: By <Year4>-<Month,2>-<Day,2>';
        CemeteryMSG: Label 'Cemetery No.: %1';
        WonMSG: Label '%1Won';
        LitigationMSG: Label 'Litigation Date: %1 ~ %2 (%3)';
        AdvanceMSG: Label 'Advance Date: %1 ~ %2 (%3)';
        BankNameMSG: Label 'Bank: %1';
        BankAccountNoMSG: Label 'Bank Account No.: %1';
        TodayMSG: Label 'í¹ Creation Base Date: <Year4>-<Month,2>-<Day,2>';
        CaptionText: Text;
        PaymentDateText: Text;
        CemeteryNoText: Text;
        TotalAmountText: Text;
        LitigationAmountText: Text;
        AdvanceAmountText: Text;
        LitigationPeriodText: Text;
        AdvancePeriodText: Text;
        BankNameText: Text;
        BankAccountNoText: Text;
        ReferenceDateText: Text;
        Employee: Text;
        CompanyPhoneNo: Text;
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

