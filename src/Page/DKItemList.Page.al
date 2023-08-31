page 50064 "DK_Item List"
{
    Caption = 'Item List';
    CardPageID = "DK_Item Card";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field("Item Main Cat. Code"; Rec."Item Main Cat. Code")
                {
                }
                field("Item Main Cat. Name"; Rec."Item Main Cat. Name")
                {
                }
                field("Item Sub Cat. Code"; Rec."Item Sub Cat. Code")
                {
                }
                field("Item Sub Cat. Name"; Rec."Item Sub Cat. Name")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("QR Code Use"; Rec."QR Code Use")
                {
                }
                field("Notice Use"; Rec."Notice Use")
                {
                }
                field("Notice Quantity"; Rec."Notice Quantity")
                {
                }
                field(Price; Rec.Price)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

