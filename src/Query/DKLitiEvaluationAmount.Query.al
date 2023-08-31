query 50001 "DK_Liti. Evaluation Amount"
{
    Caption = 'Liti. Evaluation Amount';

    elements
    {
        dataitem(DK_Contract;DK_Contract)
        {
            filter(Litigation_Evaluation;"Litigation Evaluation")
            {
            }
            filter(Date_Filter;"Date Filter")
            {
            }
            column(Sum_Cemetery_Size;"Cemetery Size")
            {
                Method = Sum;
            }
            column(Sum_Non_Pay_General_Amount;"Non-Pay. General Amount")
            {
                Method = Sum;
            }
            column(Sum_Non_Pay_Land_Arc_Amount;"Non-Pay. Land. Arc. Amount")
            {
                Method = Sum;
            }
        }
    }
}

