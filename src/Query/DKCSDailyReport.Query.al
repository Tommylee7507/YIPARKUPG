query 50007 "DK_CS Daily Report"
{
    Caption = 'CS Daily Report';

    elements
    {
        dataitem(PaymentReceiptDocument; "DK_Payment Receipt Document")
        {
            filter(PostingDateFilter; "Posting Date")
            {
                ColumnFilter = PostingDateFilter = FILTER(= 20191030D);
            }
            filter(DocumentType; "Document Type")
            {
                ColumnFilter = DocumentType = CONST(Receipt);
            }
            column(PostingDate; "Posting Date")
            {
            }
            dataitem(PaymentReceiptDocLine; "DK_Payment Receipt Doc. Line")
            {
                DataItemLink = "Document No." = PaymentReceiptDocument."Document No.";
                column(CemServicesNo; "Cem. Services No.")
                {
                }
                column(AmountSum; Amount)
                {
                    Method = Sum;
                }
                column("Count")
                {
                    Method = Count;
                }
                dataitem(CemeteryServices; "DK_Cemetery Services")
                {
                    DataItemLink = "No." = PaymentReceiptDocLine."Cem. Services No.";
                    filter(MainCatCodeFilter; "Field Work Main Cat. Code")
                    {
                        ColumnFilter = MainCatCodeFilter = CONST('908');
                    }
                    filter(MainCatNameFilter; "Field Work Main Cat. Name")
                    {
                    }
                    filter(SubCatCodeFilter; "Field Work Sub Cat. Code")
                    {
                        ColumnFilter = SubCatCodeFilter = CONST('001');
                    }
                    filter(SubCatNameFilter; "Field Work Sub Cat. Name")
                    {
                    }
                    column(MainCatCode; "Field Work Main Cat. Code")
                    {
                    }
                    column(MainCatName; "Field Work Main Cat. Name")
                    {
                    }
                    column(SubCatCode; "Field Work Sub Cat. Code")
                    {
                    }
                    column(SubCatName; "Field Work Sub Cat. Name")
                    {
                    }
                }
            }
        }
    }
}

