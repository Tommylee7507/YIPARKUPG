page 50053 "DK_CRM Funeral Hall"
{
    Caption = 'CRM Funeral Hall';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_CRM Funeral Hall";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field(Address; Rec.Address)
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
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

