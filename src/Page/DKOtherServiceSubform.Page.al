page 50284 "DK_Other Service Subform"
{
    AutoSplitKey = true;
    Caption = 'Other Service Line';
    DelayedInsert = true;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "DK_Other Service Line";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

