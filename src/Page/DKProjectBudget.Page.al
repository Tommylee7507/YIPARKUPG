page 50059 "DK_Project Budget"
{
    AutoSplitKey = true;
    Caption = 'Project Budget';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Project Budget";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project No."; Rec."Project No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Date := WorkDate;
    end;
}

