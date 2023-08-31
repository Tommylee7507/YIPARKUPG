page 50073 "DK_Posted Item Receipt"
{
    // 
    // DK34: 20201201
    //   - Add Field: "Item Type"

    Caption = 'Posted Item Receipt';
    CardPageID = "DK_Item Shipment";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Posted Purchase Receipt";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Receipt Time"; Rec."Receipt Time")
                {
                }
                field("Last Shipment Date"; Rec."Last Shipment Date")
                {
                }
                field(Untreated; Rec.Untreated)
                {
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                }
                field("Purchase Item"; Rec."Purchase Item")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Item Type"; Rec."Item Type")
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
                    Visible = false;
                }
                field("Item Main Cat. Name"; Rec."Item Main Cat. Name")
                {
                }
                field("Item Sub Cat. Code"; Rec."Item Sub Cat. Code")
                {
                    Visible = false;
                }
                field("Item Sub Cat. Name"; Rec."Item Sub Cat. Name")
                {
                }
                field("Qty. to Receipt"; Rec."Qty. to Receipt")
                {
                }
                field("Qty. Shipped"; Rec."Qty. Shipped")
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Employee; Rec.Employee)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                }
                field("Shipment Type Code"; Rec."Shipment Type Code")
                {
                }
                field("Shipment Type"; Rec."Shipment Type")
                {
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field(Reverse; Rec.Reverse)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control26; "DK_Posted Picture Factbox")
            {
                Editable = false;
                SubPageLink = "Table ID" = CONST(50057),
                              "Source No." = FIELD("Document No."),
                              "Source Line No." = FIELD("Line No.");
            }
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Receipt Reverse")
            {
                Caption = 'Receipt Reverse';
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
                    _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
                begin

                    CurrPage.SetSelectionFilter(_PostedPurchaseReceipt);

                    if _PurchaseItemPost.ReceiptReverse(_PostedPurchaseReceipt) then
                        Message(MSG001);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;

    var
        MSG001: Label 'Reverse is complete.';
        MSG002: Label 'You can not cancel because you have %1. Please check the %2.';
}

