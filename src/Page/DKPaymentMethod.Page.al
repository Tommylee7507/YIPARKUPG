page 50131 "DK_Payment Method"
{
    // #DK36: 20211016
    //   - Add Field: "PG Code"

    Caption = 'Payment Method';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Payment Method";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("PG Code"; Rec."PG Code")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

