page 50099 "DK_Event Product Sales Status"
{
    Caption = 'Event Product Sales Status';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Event Product Sales Status";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field("Registration Date"; Rec."Registration Date")
                {
                }
                field(Division; Rec.Division)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Payment Method"; Rec."Payment Method")
                {
                }
                field("Sales Category"; Rec."Sales Category")
                {
                }
                field("Product Code"; Rec."Product Code")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Paymnet Amount"; Rec."Paymnet Amount")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(Address2; Rec.Address2)
                {
                }
            }
        }
    }

    actions
    {
    }
}

