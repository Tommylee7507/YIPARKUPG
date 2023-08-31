page 50102 DK_Location
{
    Caption = 'Location';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Location;

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

