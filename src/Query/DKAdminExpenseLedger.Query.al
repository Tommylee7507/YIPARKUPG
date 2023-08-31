query 50003 "DK_Admin. Expense Ledger"
{
    Caption = 'Admin. Expense Ledger';

    elements
    {
        dataitem(DK_Payment_Receipt_Document;"DK_Payment Receipt Document")
        {
            filter(Posting_Date_Filter;"Posting Date")
            {
            }
            dataitem(DK_Admin_Expense_Ledger;"DK_Admin. Expense Ledger")
            {
                DataItemLink = "Source No."=DK_Payment_Receipt_Document."Document No.";
                filter(First_Contract_Filter;"First Contract")
                {
                }
                filter(Ledger_Type_Filter;"Ledger Type")
                {
                }
                filter(Admin_Expense_Type_Filter;"Admin. Expense Type")
                {
                }
                column(Amount;Amount)
                {
                }
            }
        }
    }
}

