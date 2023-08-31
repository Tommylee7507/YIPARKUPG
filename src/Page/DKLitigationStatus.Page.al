page 50109 "DK_Litigation Status"
{
    Caption = 'Litigation Status';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SaveValues = true;
    SourceTable = "DK_Litigation Status";
    SourceTableView = SORTING(Type, Code)
                      WHERE(Type = CONST(LitigationStatus));

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

