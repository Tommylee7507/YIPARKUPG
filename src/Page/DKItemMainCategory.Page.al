page 50062 "DK_Item Main Category"
{
    Caption = 'Item Main Category';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Item Main Category";

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
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
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
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DK_Item Sub Category";
                RunPageLink = "Item Main Cat. Code" = FIELD(Code);
            }
        }
    }
}

