query 50021 "DK_PBI Completed Cust. Req."
{
    Caption = 'Power BI Completed Customer Requests';

    elements
    {
        dataitem(DK_Customer_Requests; "DK_Customer Requests")
        {
            DataItemTableFilter = Status = FILTER(Complete | Impossible);
            column(No; "No.")
            {
            }
            column(Cemetery_No; "Cemetery No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Employee_name; "Employee name")
            {
            }
            column(Receipt_Contents; "Receipt Contents")
            {
            }
            column(Status; Status)
            {
            }
            column(Process_Date; "Process Date")
            {
            }
            column(Field_Work_Sub_Cat_Code; "Field Work Sub Cat. Code")
            {
            }
            column(Field_Work_Sub_Cat_Name; "Field Work Sub Cat. Name")
            {
            }
            column(Work_Division; "Work Division")
            {
            }
            column(Receipt_Division; "Receipt Division")
            {
            }
        }
    }
}

