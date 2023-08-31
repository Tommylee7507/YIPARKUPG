page 50285 "DK_Report Taget"
{
    Caption = 'Report Target';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Report Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("OBJECT ID"; Rec."OBJECT ID")
                {
                }
                field(Name; Rec.Name)
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
        area(processing)
        {
            action(Value)
            {
                Caption = 'Value';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Report Target Value";
                RunPageLink = "OBJECT ID" = FIELD("OBJECT ID");
            }
        }
    }
}

