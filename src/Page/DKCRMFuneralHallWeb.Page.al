page 50297 "DK_CRM Funeral Hall (Web)"
{
    Caption = 'CRM Funeral Hall (Web)';
    DelayedInsert = true;
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
            }
        }
    }

    actions
    {
    }
}

