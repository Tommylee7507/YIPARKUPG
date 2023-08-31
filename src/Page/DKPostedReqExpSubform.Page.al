page 50108 "DK_Posted Req. Exp. Subform"
{
    Caption = 'Posted Request Expenses Subform';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Request Expenses Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Purchased Item"; Rec."Purchased Item")
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

