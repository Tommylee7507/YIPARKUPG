page 50005 "DK_Unit Price Type"
{
    Caption = 'Unit Price Type';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Unit Price Type";

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

