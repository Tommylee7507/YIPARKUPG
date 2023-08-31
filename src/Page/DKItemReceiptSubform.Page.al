page 50072 "DK_Item Receipt Subform"
{
    AutoSplitKey = true;
    Caption = 'Item Receipt Line';
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "DK_Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Name"; Rec."Item Name")
                {
                }
                field("Item Main Cat. Code"; Rec."Item Main Cat. Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Item Main Cat. Name"; Rec."Item Main Cat. Name")
                {
                }
                field("Item Sub Cat. Code"; Rec."Item Sub Cat. Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Item Sub Cat. Name"; Rec."Item Sub Cat. Name")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Additional;
                }
                field("Location Name"; Rec."Location Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
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
                field("Vendor No."; Rec."Vendor No.")
                {
                    Importance = Additional;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Location Code", xRec."Location Code");
        Rec.Validate("Vendor No.", xRec."Vendor No.");
    end;
}

