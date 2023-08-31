page 50228 "DK_Purchase Contract Authority"
{
    AutoSplitKey = true;
    Caption = 'Purchase Contract Authority';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Purchase Contract Authority";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

