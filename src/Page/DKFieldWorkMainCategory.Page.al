page 50113 "DK_Field Work Main Category"
{
    Caption = 'Field Work Main Category';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Field Work Main Category";

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
                field("Connect Work"; Rec."Connect Work")
                {
                }
                field("Cemetery Services"; Rec."Cemetery Services")
                {
                }
                field("Other Services"; Rec."Other Services")
                {
                }
                field("Funeral Type"; Rec."Funeral Type")
                {
                    Visible = false;
                }
                field(Unassigned; Rec.Unassigned)
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
            action("Sub Category")
            {
                Caption = 'Sub Category';
                Enabled = Rec.Blocked <> TRUE;
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DK_Field Work Sub Category";
                RunPageLink = "Field Work Main Cat. Code" = FIELD(Code);
            }
        }
    }
}

