report 50049 "DK_Calc. Delay Int. Detail"
{
    // 
    // DK34: 20201116
    //   - Create
    RDLCLayout = './src/layout/DKCalcDelayIntDetail.rdl';

    Caption = 'Calc. Delay Int. Detail';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(RecContract; DK_Contract)
        {
            DataItemTableView = SORTING("No.");
            column(ContractNo; "No.")
            {
            }
            column(CemeteryNo; "Cemetery No.")
            {
            }
            column(MainCustName; "Main Customer Name")
            {
            }
            column(ContractDate; "Contract Date")
            {
            }
            column(BankName; ReceiptBankName)
            {
            }
            column(BankAccountNo; ReceiptBankAccountNo)
            {
            }
            column(BankAccountHolder; ReceiptBankAccountHolder)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(InputDate; InputDate)
            {
            }
            column(CemeterySize; CemeterySize)
            {
            }
            column(DelayIntAmount; DelayIntAmount)
            {
            }
            column(AdminExpenseTypeTxt; AdminExpenseTypeTxt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecContract.CalcFields("Unit Price Type Code", "Cemetery Size");

                CalcDelayIntAmount;
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
                        Caption = 'Bank Code';
                        TableRelation = "DK_Receipt Bank Account".Code WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        begin

                            SetBankAccount;
                        end;
                    }
                    field(ReceiptBankName; ReceiptBankName)
                    {
                        Caption = 'Bank Name';
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
        Cap002007 = 'Delay Int. Amount ';
        Cap002008 = 'Delay Interest Total Amount';
    }

    var
        ReceiptBankCode: Code[20];
        ReceiptBankName: Text;
        ReceiptBankAccountNo: Text;
        ReceiptBankAccountHolder: Text;
        ContractNo: Code[20];
        InputDate: Date;
        AdminExpenseType: Option General,Landscape;
        CemeterySize: Decimal;
        StartDate: Date;
        DelayIntAmount: Decimal;
        MSG001: Label 'General ';
        MSG002: Label 'Landscape ';
        AdminExpenseTypeTxt: Text;


    procedure SetParameter(pContractNo: Code[20]; pInputDate: Date; pAdminExpenseType: Option)
    begin

        ContractNo := pContractNo;
        InputDate := pInputDate;
        AdminExpenseType := pAdminExpenseType;
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

    local procedure CalcDelayIntAmount()
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _UnitPrice: Decimal;
    begin

        if AdminExpenseType = 0 then
            AdminExpenseTypeTxt := MSG001
        else
            AdminExpenseTypeTxt := MSG002;

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date);
        _AdminExpenseLedger.SetRange("Contract No.", ContractNo);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", AdminExpenseType);
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
        _AdminExpenseLedger.SetFilter("Remaining Amount", '<>0');
        _AdminExpenseLedger.SetRange(Date, 0D, InputDate);
        if _AdminExpenseLedger.FindFirst then
            StartDate := _AdminExpenseLedger.Date;

        if StartDate = 0D then
            Error('');

        CemeterySize := RecContract."Cemetery Size";
        DelayIntAmount := _AdminExpenseMgt.CalcDelayInterestAmount(RecContract, InputDate, AdminExpenseType);
    end;
}

