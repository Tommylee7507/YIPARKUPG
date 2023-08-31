page 50189 "DK_Account Activities"
{
    // //Date Filter : WORKDATE €Ë‘¹

    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup("Payment Document")
            {
                Caption = 'Payment Document';
                field("Post Pay. Receipt Document"; Rec."Post Pay. Receipt Document")
                {
                    Image = Cash;
                }
                field("General Admin. Expense"; Rec."General Admin. Expense")
                {
                    Image = Cash;
                }
                field("Land. Admin. Expense"; Rec."Land. Admin. Expense")
                {
                    Image = Cash;
                }
                field("Service Amount Count"; Rec."Service Amount Count")
                {
                    Image = Cash;
                }
            }
            cuegroup(Contract)
            {
                Caption = 'Contract';
                field("Deposit Amount Count"; Rec."Deposit Amount Count")
                {
                }
                field("Contract Amount Count"; Rec."Contract Amount Count")
                {
                }
                field("Remaining Amount Count"; Rec."Remaining Amount Count")
                {
                }
            }
            cuegroup("Request Expense")
            {
                Caption = 'Request Expense';
                field("Post Req. Expenses"; Rec."Post Req. Expenses")
                {
                }
                field("Request Remittance"; Rec."Request Remittance")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Date Filter", '%1', WorkDate);
        Rec.SetFilter("Date Filter 2", '%1', WorkDate);
        Rec.FilterGroup(0);
    end;
}

