page 50126 "DK_Detail Admin. Exp. Ledger"
{
    Caption = 'Detail Admin. Expense Ledger';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Detail Admin. Exp. Ledger";
    SourceTableView = SORTING("Contract No.", "Admin. Expense Type", "Ledger Type", Date, "Line No.", Sequence);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Sequence; Rec.Sequence)
                {
                }
                field("Admin. Expense Type"; Rec."Admin. Expense Type")
                {
                }
                field("Ledger Type"; Rec."Ledger Type")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Apply Date"; Rec."Apply Date")
                {
                }
                field("Apply Line No."; Rec."Apply Line No.")
                {
                }
                field(Applied; Rec.Applied)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control19; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

