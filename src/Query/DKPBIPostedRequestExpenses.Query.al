query 50022 "DK_PBI Posted Request Expenses"
{
    Caption = 'Power BI Posted Request Expenses';

    elements
    {
        dataitem(DK_Request_Expenses_Header; "DK_Request Expenses Header")
        {
            DataItemTableFilter = Status = FILTER(Post | Completed);
            column(No; "No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Status; Status)
            {
            }
            dataitem(DK_Request_Expenses_Line; "DK_Request Expenses Line")
            {
                DataItemLink = "Document No." = DK_Request_Expenses_Header."No.";
                column(Item_No; "Item No.")
                {
                }
                column(Item_Name; "Item Name")
                {
                }
                column(Purpose; Purpose)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Amount; Amount)
                {
                }
            }
        }
    }
}

