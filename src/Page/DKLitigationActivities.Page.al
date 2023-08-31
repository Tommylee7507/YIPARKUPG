page 50192 "DK_Litigation Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup(Contract)
            {
                Caption = 'Contract';
                field("No. of Pay. Bal. Contract"; Rec."No. of Pay. Bal. Contract")
                {
                }
                field("No. of Overdue Bal. Cont."; Rec."No. of Overdue Bal. Cont.")
                {
                }
                field("No. of Transfer Litigation"; Rec."No. of Transfer Litigation")
                {
                }
            }
            cuegroup(Payment)
            {
                Caption = 'Payment';
                field("Post Pay. Receipt Document"; Rec."Post Pay. Receipt Document")
                {
                }
                field("General Admin. Expense"; Rec."General Admin. Expense")
                {
                }
                field("Land. Admin. Expense"; Rec."Land. Admin. Expense")
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
        Rec.SetFilter("Date Filter", '<%1', WorkDate);
        Rec.SetFilter("Date Filter 2", '%1', WorkDate);
    end;
}

