query 50023 "DK_PBI Payment Rcpt. Document"
{
    Caption = 'Power BI Payment Receipt Document';

    elements
    {
        dataitem(DK_Payment_Receipt_Document;"DK_Payment Receipt Document")
        {
            DataItemTableFilter = Posted=CONST(true),"Document Type"=CONST(Receipt);
            column(Document_No;"Document No.")
            {
            }
            column(Contract_No;"Contract No.")
            {
            }
            column(Cemetery_No;"Cemetery No.")
            {
            }
            column(Bank_Account_Code;"Bank Account Code")
            {
            }
            column(Bank_Account_Name;"Bank Account Name")
            {
            }
            column(Payment_Type;"Payment Type")
            {
            }
            column(Payment_Method_Code;"Payment Method Code")
            {
            }
            column(Payment_Method_Name;"Payment Method Name")
            {
            }
            column(Refund;Refund)
            {
            }
            column(Refund_Posting_Date;"Refund Posting Date")
            {
            }
            column(Refund_Pay_Comp_Date;"Refund Pay. Comp. Date")
            {
            }
            column(Missing_Contract;"Missing Contract")
            {
            }
            column(Card_Approval_No;"Card Approval No.")
            {
            }
            column(Payment_Date;"Payment Date")
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(Litigation_Employee_No;"Litigation Employee No.")
            {
            }
            column(Litigation_Employee_Name;"Litigation Employee Name")
            {
            }
            column(Line_General_Amount;"Line General Amount")
            {
            }
            column(Legal_Amount;"Legal Amount")
            {
            }
            column(Advance_Payment_Amount;"Advance Payment Amount")
            {
            }
            column(Delay_Interest_Amount;"Delay Interest Amount")
            {
            }
            column(Reduction_Amount_1;"Reduction Amount 1")
            {
            }
            column(Litigation_Evaluation;"Litigation Evaluation")
            {
            }
            dataitem(DK_Payment_Receipt_Doc_Line;"DK_Payment Receipt Doc. Line")
            {
                DataItemLink = "Document No."=DK_Payment_Receipt_Document."Document No.";
                column(Payment_Target;"Payment Target")
                {
                }
                column(Amount;Amount)
                {
                }
                column(Field_Work_Sub_Cat_Code;"Field Work Sub Cat. Code")
                {
                }
                column(Field_Work_Sub_Cat_Name;"Field Work Sub Cat. Name")
                {
                }
                column(Start_Date;"Start Date")
                {
                }
                column(Expiration_Date;"Expiration Date")
                {
                }
                dataitem(DK_Contract;DK_Contract)
                {
                    DataItemLink = "No."=DK_Payment_Receipt_Document."Contract No.";
                    column(Main_Customer_No;"Main Customer No.")
                    {
                    }
                    column(Main_Customer_Name;"Main Customer Name")
                    {
                    }
                    column(Cemetery_Size;"Cemetery Size")
                    {
                    }
                    column(Cemetery_Size_2;"Cemetery Size 2")
                    {
                    }
                    column(Cemetery_Dig_Code;"Cemetery Dig. Code")
                    {
                    }
                    column(CRM_SalesPerson_Code;"CRM SalesPerson Code")
                    {
                    }
                    column(CRM_Sales_Type;"CRM Sales Type")
                    {
                    }
                    column(Contract_Date;"Contract Date")
                    {
                    }
                    column(Status;Status)
                    {
                    }
                }
            }
        }
    }
}

