page 50075 "DK_Item Ledger Entry"
{
    Caption = 'Item Ledger Entry';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Item Ledger Entry";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Employee; Rec.Employee)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Name"; Rec."Item Name")
                {
                }
                field("Item Main Cat. Name"; Rec."Item Main Cat. Name")
                {
                }
                field("Item Sub Cat. Name"; Rec."Item Sub Cat. Name")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Location Name"; Rec."Location Name")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field("Shipment Type"; Rec."Shipment Type")
                {
                }
                field("Working Group Name"; Rec."Working Group Name")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Use Area"; Rec."Use Area")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field(Reverse; Rec.Reverse)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control34; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("QR Code")
            {
                Caption = 'QR Code';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RunReport
                end;
            }
            action("Shipmnet Reverse")
            {
                Caption = 'Shipmnet Reverse';
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _ItemLedgerEntry: Record "DK_Item Ledger Entry";
                    _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
                    MSG001: Label 'Cancel is complete.';
                begin

                    CurrPage.SetSelectionFilter(_ItemLedgerEntry);

                    if _PurchaseItemPost.ShipmentReverse(_ItemLedgerEntry) then
                        Message(MSG001);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;

    procedure GetSelectionFilter(): Text
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(_ItemLedgerEntry);
        // exit(SelectionFilterManagement.DK_GetSelectionFilterForItemLedger(_ItemLedgerEntry));////zzz
    end;

    local procedure RunReport()
    var
        _DK_ItemQRCode: Report "DK_Item QR Code";
    begin
        //_DK_ItemQRCode.ru
        // _DK_ItemQRCode.SetParam(GetSelectionFilter);////zzz
        _DK_ItemQRCode.RunModal;
    end;
}

