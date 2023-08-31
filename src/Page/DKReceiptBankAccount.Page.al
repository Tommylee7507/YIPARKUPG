page 50130 "DK_Receipt Bank Account"
{
    // #DK36: 20211007
    //   - Add Field: "Use PG"

    Caption = 'Receipt Bank Account';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Receipt Bank Account";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Bank Code"; Rec."Bank Code")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Account Holder"; Rec."Account Holder")
                {
                }
                field("Admin. Expense"; Rec."Admin. Expense")
                {
                }
                field(Litigation; Rec.Litigation)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Use PG"; Rec."Use PG")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

