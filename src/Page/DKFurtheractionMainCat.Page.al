page 50275 "DK_Further action Main Cat."
{
    // 
    // DK34: 20201030
    //   - Create

    Caption = 'Further action Main Catetory';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Further action Main Cat.";

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
                RunObject = Page "DK_Further action Sub Cat.";
                RunPageLink = "Further action Main Cat. Code" = FIELD(Code);
            }
        }
    }
}

