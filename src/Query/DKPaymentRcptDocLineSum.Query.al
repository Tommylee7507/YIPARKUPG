query 50005 "DK_Payment Rcpt Doc. Line Sum"
{

    elements
    {
        dataitem(DK_Payment_Receipt_Doc_Line;"DK_Payment Receipt Doc. Line")
        {
            filter(Posting_Date_Filter;"Posting Date")
            {
            }
            filter(Posted_Filter;Posted)
            {
            }
            filter(Document_Type_Filter;"Document Type")
            {
            }
            filter(Payment_Target_Filter;"Payment Target")
            {
            }
            filter(Regular_Type_Filter;"Regular Type")
            {
            }
            filter(Befor_Liti_Eval_Filter;"Befor Liti. Eval.")
            {
            }
            filter(Led_Gen_Total_Amount_Filter;"Led. Gen. Total Amount")
            {
            }
            filter(Led_Lan_Total_Amount_Filter;"Led. Lan. Total Amount")
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

