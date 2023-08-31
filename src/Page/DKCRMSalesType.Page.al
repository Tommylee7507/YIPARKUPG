page 50237 "DK_CRM Sales Type"
{
    Caption = 'CRM Sales Type';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_CRM Sales Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Seq; Rec.Seq)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Item; Rec.Item)
                {
                }
                field(Indicator; Rec.Indicator)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

