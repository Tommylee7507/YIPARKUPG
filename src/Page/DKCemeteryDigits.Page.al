page 50006 "DK_Cemetery Digits"
{
    Caption = 'Cemetery Digits';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Cemetery Digits";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
                {
                    Editable = false;
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
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

