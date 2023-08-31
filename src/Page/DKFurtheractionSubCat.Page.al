page 50276 "DK_Further action Sub Cat."
{
    // 
    // DK34: 20201030
    //   - Create

    Caption = 'Further action Sub Category';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Further action Sub Cat.";

    layout
    {
        area(content)
        {
            repeater(Control2)
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

