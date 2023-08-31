page 50226 "DK_Department Main Category"
{
    Caption = 'Department Main Category';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Department Main Category";

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
    }

    actions
    {
    }
}

