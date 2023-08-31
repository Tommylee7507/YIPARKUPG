page 50087 "DK_Posted Req. Expenses List"
{
    Caption = 'Posted Request Expenses List';
    CardPageID = "DK_Posted Req. Expenses";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Request Expenses Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Post | Completed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Bank Code"; Rec."Bank Code")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Account Holder"; Rec."Account Holder")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("GroupWare Doc. No."; Rec."GroupWare Doc. No.")
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                field("Purchases Date"; Rec."Purchases Date")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        if Rec.FindFirst then;
    end;
}

