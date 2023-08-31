page 50083 "DK_SMS List"
{
    Caption = 'SMS List';
    CardPageID = DK_SMS;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_SMS;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Department Code"; Rec."Department Code")
                {
                    Visible = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Biz Talk Tamplate No."; Rec."Biz Talk Tamplate No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Short Message"; Rec."Short Message")
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

