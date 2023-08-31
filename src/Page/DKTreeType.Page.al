page 50234 "DK_Tree Type"
{
    Caption = 'Tree Type';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Tree Type";

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
            }
        }
        area(factboxes)
        {
            systempart(Control5; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

