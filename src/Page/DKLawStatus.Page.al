page 50210 "DK_Law Status"
{
    Caption = 'Law Status';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SaveValues = true;
    SourceTable = "DK_Litigation Status";
    SourceTableView = SORTING(Type, Code)
                      WHERE(Type = CONST(LawStatus));

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
            systempart(Control7; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

