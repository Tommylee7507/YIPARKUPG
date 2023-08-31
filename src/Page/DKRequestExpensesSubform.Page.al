page 50086 "DK_Request Expenses Subform"
{
    AutoSplitKey = true;
    Caption = 'Request Expenses Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "DK_Request Expenses Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Purchased Item"; Rec."Purchased Item")
                {
                }
                field(StandardSize; Rec.StandardSize)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Purpose; Rec.Purpose)
                {
                }
            }
        }
    }

    actions
    {
    }
}

