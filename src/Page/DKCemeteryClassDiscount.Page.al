page 50016 "DK_Cemetery Class Discount"
{
    Caption = 'Cemetery Class Discount';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Cemetery Class Discount";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Estate Code"; Rec."Estate Code")
                {
                    Visible = false;
                }
                field("Estate Name"; Rec."Estate Name")
                {
                }
                field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
                {
                    Visible = false;
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Cemetery Option Code"; Rec."Cemetery Option Code")
                {
                    Visible = false;
                }
                field("Cemetery Option Name"; Rec."Cemetery Option Name")
                {
                }
                field(Class; Rec.Class)
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field(Discount; Rec.Discount)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

