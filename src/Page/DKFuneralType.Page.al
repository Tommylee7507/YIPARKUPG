page 50262 "DK_Funeral Type"
{
    Caption = 'Funeral Type';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Funeral Type";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                ShowCaption = false;
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
            systempart(Control7; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

