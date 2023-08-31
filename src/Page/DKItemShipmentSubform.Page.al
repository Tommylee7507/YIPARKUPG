page 50077 "DK_Item Shipment Subform"
{
    Caption = 'Item Shipment Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Line No."; Rec."Document Line No.")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Item Name"; Rec."Item Name")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Receipt Quantity';
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    var
        MSG001: Label 'Cancel is complete.';
}

