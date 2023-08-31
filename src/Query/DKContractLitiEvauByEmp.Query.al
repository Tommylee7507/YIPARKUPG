query 50006 "DK_Contract Liti. Evau. By Emp"
{
    Caption = 'Contract Liti. Evau. By Emp';
    OrderBy = Ascending(Litigation_Evaluation), Descending(Litigation_Employee_No);

    elements
    {
        dataitem(DK_Contract; DK_Contract)
        {
            DataItemTableFilter = Status = FILTER(FullPayment | Revocation);
            column(Litigation_Evaluation; "Litigation Evaluation")
            {
            }
            column(Litigation_Employee_No; "Litigation Employee No.")
            {
            }
            column(Count_)
            {
                Method = Count;
            }
            filter(Landscape_Architecture; "Landscape Architecture")
            {
            }
        }
    }
}

