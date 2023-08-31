page 50027 "DK_Vehicle List"
{
    Caption = 'Vehicle List';
    CardPageID = "DK_Vehicle Card";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Vehicle;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Purchase Contract No."; Rec."Purchase Contract No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Handler; Rec.Handler)
                {
                }
                field(Model; Rec.Model)
                {
                }
                field("Model Year"; Rec."Model Year")
                {
                }
                field(Division; Rec.Division)
                {
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                }
                field("Oil Type"; Rec."Oil Type")
                {
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                }
                field("Registration Date"; Rec."Registration Date")
                {
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                }
                field(Term; Rec.Term)
                {
                }
                field("Closed Date"; Rec."Closed Date")
                {
                }
                field("Sale Date"; Rec."Sale Date")
                {
                }
                field(Price; Rec.Price)
                {
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                }
                field("Monthly Amount"; Rec."Monthly Amount")
                {
                }
                field("Inspection Date From"; Rec."Inspection Date From")
                {
                }
                field("Inspection Date To"; Rec."Inspection Date To")
                {
                }
                field(Capacity; Rec.Capacity)
                {
                }
                field("Standard Grade"; Rec."Standard Grade")
                {
                }
                field(Restrictions; Rec.Restrictions)
                {
                }
                field("Special Contract"; Rec."Special Contract")
                {
                }
                field(Insurer; Rec.Insurer)
                {
                }
                field("Contract Date From"; Rec."Contract Date From")
                {
                }
                field("Insurance Date From"; Rec."Insurance Date From")
                {
                }
                field("Insurance Date To"; Rec."Insurance Date To")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control35; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

