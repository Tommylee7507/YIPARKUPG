report 50031 "DK_Calc. Admin. Expense Detail"
{
    RDLCLayout = './src/layout/DKCalcAdminExpenseDetail.rdl';
    Caption = 'Calc. Admin. Expense Detail';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(RecContract; DK_Contract)
        {
            DataItemTableView = SORTING("No. Series");
            column(Doc_SuperviseNo; "Supervise No.")
            {
            }
            column(Doc_ContractNo; "No.")
            {
            }
            column(Doc_CemeteryNo; RecContract."Cemetery No.")
            {
            }
            column(Doc_CustName; "Main Customer Name")
            {
            }
            column(Doc_ContractDate; "Contract Date")
            {
            }
            column(TotalAmount_; TotalAmount)
            {
            }
            column(ApplyAmount_; ApplyAmount)
            {
            }
            column(BankName_; ReceiptBankName)
            {
            }
            column(BankAccountNo_; ReceiptBankAccountNo)
            {
            }
            column(AccountHolder_; ReceiptBankAccountHolder)
            {
            }
            dataitem(Line; "DK_Report Buffer")
            {
                DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.") ORDER(Ascending);
                UseTemporary = true;
                column(Line_AdminExpenseType; Line.TEXT0)
                {
                }
                column(Line_StartDate; Line.DATE0)
                {
                }
                column(Line_EndDate; Line.DATE1)
                {
                }
                column(Line_Cost; Line.DECIMAL0)
                {
                }
                column(Line_Size; Line.DECIMAL1)
                {
                }
                column(Line_Amount; Line.DECIMAL2)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                RecContract.CalcFields("Unit Price Type Code", RecContract."Cemetery Size");

                CalcAdminExpense;

                ApplyAmount += Round(TotalAmount, 100, '>');
            end;

            trigger OnPreDataItem()
            begin
                RecContract.SetRange("No.", ContractNo);
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
                    field(ReceiptBankCode; ReceiptBankCode)
                    {
                        Caption = 'Bank';
                        TableRelation = "DK_Receipt Bank Account".Code WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        begin

                            SetBankAccount;
                        end;
                    }
                    field(ReceiptBankName; ReceiptBankName)
                    {
                        Caption = 'Bank';
                        Editable = false;
                    }
                    field(ReceiptBankAccountNo; ReceiptBankAccountNo)
                    {
                        Caption = 'Account No';
                        Editable = false;
                    }
                    field(ReceiptBankAccountHolder; ReceiptBankAccountHolder)
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
            if _ReceiptBankAccount.FindFirst then
                ReceiptBankCode := _ReceiptBankAccount.Code
            else
                ReceiptBankCode := '';

            SetBankAccount;
        end;
    }

    labels
    {
        Reportlbl = 'Reportlbl';
        Cap001001 = 'Cap001001';
        Cap001002 = 'Cap001002';
        Cap001003 = 'Cap001003';
        Cap001004 = 'Cap001004';
        Cap001005 = 'Cap001005';
        Cap001006 = 'Cap001006';
        Cap001007 = 'Cap001007';
        Cap002000 = 'Cap002000';
        Cap002001 = 'Cap002001';
        Cap002002 = 'Cap002002';
        Cap002003 = 'Cap002003';
        Cap002004 = 'Cap002004';
        Cap002005 = 'Cap002005';
        Cap002006 = 'Cap002006';
    }

    trigger OnInitReport()
    begin
        ReceiptBankAccount.Reset;
        ReceiptBankAccount.SetRange("Admin. Expense", true);
        if not ReceiptBankAccount.FindSet then
            Error(MSG001, ReceiptBankAccount.TableCaption);
    end;

    var
        AdminExpenseType: Option;
        ReceiptBankAccount: Record "DK_Receipt Bank Account";
        CalcEndingDate: Date;
        MSG001: Label 'Receipt account information not found.';
        TotalAmount: Decimal;
        ApplyAmount: Decimal;
        ContractNo: Code[20];
        MSG002: Label 'General';
        MSG003: Label 'Landscape';
        InputDate: Date;
        EntryNo: Integer;
        ReceiptBankCode: Code[20];
        ReceiptBankName: Text;
        ReceiptBankAccountNo: Text;
        ReceiptBankAccountHolder: Text;


    procedure SetParameter(pContractNo: Code[20]; pInputDate: Date; pAdminExpenseType: Option)
    begin

        ContractNo := pContractNo;
        InputDate := pInputDate;
        AdminExpenseType := pAdminExpenseType;
    end;

    local procedure CalcAdminExpense()
    var
        _StartDate: Date;
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
        _AdminExpensePrice_StartDate: Date;
        _Price: Decimal;
        _Loop_StartDate: Date;
        _UnitPrice: Decimal;
        _Cemetery: Record DK_Cemetery;
        _UpdateStartDate: Date;
    begin

        if AdminExpenseType = 0 then
            _StartDate := RecContract."General Expiration Date"
        else
            _StartDate := RecContract."Land. Arc. Expiration Date";

        if _StartDate = 0D then
            Error('');

        _StartDate += 1;

        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
        _AdminExpensePrice.SetRange("Price Type", AdminExpenseType);
        _AdminExpensePrice.SetRange("Unit Price Type Code", RecContract."Unit Price Type Code");
        _AdminExpensePrice.SetRange("Starting Date", 0D, _StartDate);
        if _AdminExpensePrice.FindLast then begin
            _UnitPrice := _AdminExpensePrice."Unit Price";

        end;
        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetRange("Price Type", AdminExpenseType);
        _AdminExpensePrice.SetRange("Unit Price Type Code", RecContract."Unit Price Type Code");
        _AdminExpensePrice.SetRange("Starting Date", _StartDate, InputDate);
        if _AdminExpensePrice.FindSet then begin
            repeat

                if _StartDate < _AdminExpensePrice."Starting Date" then begin
                    TempInsert(_StartDate, _AdminExpensePrice."Starting Date" - 1, _UnitPrice);
                    _StartDate := _AdminExpensePrice."Starting Date";
                    _UnitPrice := _AdminExpensePrice."Unit Price";
                end;
            until _AdminExpensePrice.Next = 0;
            TempInsert(_StartDate, InputDate, _UnitPrice);
        end else begin
            TempInsert(_StartDate, InputDate, _UnitPrice);
        end;
    end;

    local procedure TempInsert(pStartDate: Date; pEndDate: Date; pPrice: Decimal)
    var
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    begin
        EntryNo += 1;
        Line.Init;
        Line."Entry No." := EntryNo;
        if AdminExpenseType = 0 then
            Line.TEXT0 := MSG002
        else
            Line.TEXT0 := MSG003;
        Line.DATE0 := pStartDate;
        Line.DATE1 := pEndDate;
        Line.DECIMAL0 := pPrice;
        Line.DECIMAL1 := RecContract."Cemetery Size";
        Line.DECIMAL2 := _AdminExpenseMgt.GetCalcAdminExpenseAmountForPeriod2(RecContract."No.", AdminExpenseType, pStartDate, pEndDate);
        Line.Insert;

        TotalAmount += Line.DECIMAL2;
    end;


    procedure SetBankAccount()
    var
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
    begin

        _ReceiptBankAccount.Reset;
        _ReceiptBankAccount.SetRange(Code, ReceiptBankCode);
        if _ReceiptBankAccount.FindSet then begin
            ReceiptBankName := _ReceiptBankAccount."Bank Name";
            ReceiptBankAccountNo := _ReceiptBankAccount."Bank Account No.";
            ReceiptBankAccountHolder := _ReceiptBankAccount."Account Holder";
        end else begin
            ReceiptBankName := '';
            ReceiptBankAccountNo := '';
            ReceiptBankAccountHolder := '';
        end;
    end;
}

