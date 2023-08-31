page 50258 "DK_Change Evaluation History"
{
    // 
    // DK34: 20201130
    //   - Add Field: "Before Department Code", "Before Department Name", "After Department Code", "After Department Name"

    Caption = 'Change Evaluation History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Change Evaluation History";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Before Evaluation"; Rec."Before Evaluation")
                {
                }
                field("After Evaluation"; Rec."After Evaluation")
                {
                }
                field("Before Department Code"; Rec."Before Department Code")
                {
                    Visible = false;
                }
                field("Before Department Name"; Rec."Before Department Name")
                {
                }
                field("After Department Code"; Rec."After Department Code")
                {
                    Visible = false;
                }
                field("After Department Name"; Rec."After Department Name")
                {
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

