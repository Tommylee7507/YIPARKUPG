page 50181 "DK_Estate Group"
{
    Caption = 'Estate Group';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Estate Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; Rec."Group Code")
                {

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Group Name"; Rec."Group Name")
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

