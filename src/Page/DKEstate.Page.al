page 50001 DK_Estate
{
    // *DK32 : 20200716
    //   - Add Field : "Admin. Expense Type"

    Caption = 'Estate';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Estate;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Admin. Expense Method"; Rec."Admin. Expense Method")
                {
                }
                field("Group Code"; Rec."Group Code")
                {
                }
                field("Group Name"; Rec."Group Name")
                {
                }
                field("Group Contract"; Rec."Group Contract")
                {
                }
                field("No. of Cemetery"; Rec."No. of Cemetery")
                {
                }
                field("No. of Unsold Cemetery"; Rec."No. of Unsold Cemetery")
                {
                }
                field("No. of Reserved Cemetery"; Rec."No. of Reserved Cemetery")
                {
                }
                field("No. of Contracted Cemetery"; Rec."No. of Contracted Cemetery")
                {
                }
                field("No. of Used Cemetery"; Rec."No. of Used Cemetery")
                {
                }
                field("No. of Been Transp. Ceme."; Rec."No. of Been Transp. Ceme.")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control4; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

