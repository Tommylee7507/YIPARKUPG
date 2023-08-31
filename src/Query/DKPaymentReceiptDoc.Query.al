query 50002 "DK_Payment Receipt Doc."
{
    Caption = 'Payment Receipt Doc.';

    elements
    {
        dataitem(ReceiptDoc;"DK_Payment Receipt Document")
        {
            DataItemTableFilter = "Missing Contract"=CONST(false),Posted=CONST(true),"Payment Type"=FILTER(<>None&<>DebtRelief),"Document Type"=CONST(Receipt);
            filter(PaymentDateFilter;"Payment Date")
            {
            }
            column(Document_No;"Document No.")
            {
            }
            column(Payment_Date;"Payment Date")
            {
            }
            column(Posted;Posted)
            {
            }
            column(Contract_No;"Contract No.")
            {
            }
            column(Cemetery_Code;"Cemetery Code")
            {
            }
            column(Cemetery_No;"Cemetery No.")
            {
            }
            dataitem(Contract;DK_Contract)
            {
                DataItemLink = "No."=ReceiptDoc."Contract No.";
                column(Unit_Price_Type_Code;"Unit Price Type Code")
                {
                }
                column(Main_Customer_Name;"Main Customer Name")
                {
                }
                column(Cemetery_Size;"Cemetery Size")
                {
                }
                dataitem(ReceiptDocLine;"DK_Payment Receipt Doc. Line")
                {
                    DataItemLink = "Document No."=ReceiptDoc."Document No.";
                    SqlJoinType = LeftOuterJoin;
                    DataItemTableFilter = "Payment Target"=FILTER(General|Landscape);
                    filter(PaymentTargetFilter;"Payment Target")
                    {
                    }
                    filter(DateFilter;"Date Filter")
                    {
                    }
                    column(Payment_Target;"Payment Target")
                    {
                    }
                    column(Amount;Amount)
                    {
                    }
                    column(Start_Date;"Start Date")
                    {
                    }
                    column(Expiration_Date;"Expiration Date")
                    {
                    }
                }
            }
        }
    }
}

