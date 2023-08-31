page 50158 "DK_Pay. Rec. Doc. Line Facbox"
{
    Caption = 'Payment Receipt Documnet Line Facbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Payment Receipt Doc. Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Payment Target"; Rec."Payment Target")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Expiration Date"; Rec."Expiration Date")
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

