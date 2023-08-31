page 50298 "DK_CRM External Sales (Web)"
{
    Caption = 'CRM External Sales (Web)';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_CRM External Sales";

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
                field("Sales Type"; Rec."Sales Type")
                {
                }
                field(Company; Rec.Company)
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field(Holder; Rec.Holder)
                {
                }
            }
        }
    }

    actions
    {
    }
}

