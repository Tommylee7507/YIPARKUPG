page 50084 "DK_Request Expenses List"
{
    Caption = 'Request Expenses List';
    CardPageID = "DK_Request Expenses";
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
                      WHERE(Status = FILTER(Open | Released | Canceled));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Purchases Date"; Rec."Purchases Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Full Name"; Rec."Full Name")
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
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
                field(Remarks; Rec.Remarks)
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
            }
        }
        area(factboxes)
        {
            systempart(Control29; Notes)
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

