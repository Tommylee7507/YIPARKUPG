page 50106 "DK_Work Group"
{
    Caption = 'Work Group';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Work Group";

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
                field("Cost Amount"; Rec."Cost Amount")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

