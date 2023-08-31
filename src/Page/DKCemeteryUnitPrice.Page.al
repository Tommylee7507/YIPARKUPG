page 50183 "DK_Cemetery Unit Price"
{
    Caption = 'Cemetery Unit Price';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Cemetery Unit Price";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Estate Name"; Rec."Estate Name")
                {
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Cemetery Option Name"; Rec."Cemetery Option Name")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

