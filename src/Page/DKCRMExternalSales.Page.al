page 50052 "DK_CRM External Sales"
{
    Caption = 'CRM External Sales';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

