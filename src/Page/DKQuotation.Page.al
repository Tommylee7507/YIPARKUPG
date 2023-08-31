page 50280 DK_Quotation
{
    // 
    // DK34: 20201105
    //   - Create

    Caption = 'Quotation';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Quotation;

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

