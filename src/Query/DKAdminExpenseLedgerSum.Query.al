query 50004 "DK_Admin. Expense Ledger Sum"
{

    elements
    {
        dataitem(DK_Admin_Expense_Ledger;"DK_Admin. Expense Ledger")
        {
            filter(Posting_Date_Filter;"Posting Date")
            {
            }
            filter(Admin_Expense_Type_Filter;"Admin. Expense Type")
            {
            }
            filter(Ledger_Type_Filter;"Ledger Type")
            {
            }
            filter(First_Contract_Filter;"First Contract")
            {
            }
            column(Count_)
            {
                Method = Count;
            }
            column(Sum_Amount;Amount)
            {
                Method = Sum;
            }
        }
    }
}

