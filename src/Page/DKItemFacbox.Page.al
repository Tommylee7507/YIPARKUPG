page 50230 "DK_Item Facbox"
{
    Caption = 'Item Inventory Alarm';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Item No.';
                    Visible = false;
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Item Name';

                    trigger OnDrillDown()
                    var
                        _Item: Record DK_Item;
                        _ItemCard: Page "DK_Item Card";
                    begin
                        _Item.Reset;
                        _Item.SetRange("No.", Rec.CODE0);

                        Clear(_ItemCard);
                        _ItemCard.LookupMode(true);
                        _ItemCard.SetTableView(_Item);
                        _ItemCard.SetRecord(_Item);
                        _ItemCard.Run;
                    end;
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Item Main Catgory';
                }
                field("SHORT TEXT2"; Rec."SHORT TEXT2")
                {
                    Caption = 'Item Sub Category';
                }
                field("SHORT TEXT3"; Rec."SHORT TEXT3")
                {
                    Caption = 'Employee';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Safty Quantity';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'Inventory';
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    var
                        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
                        _PostedItemReceipt: Page "DK_Posted Item Receipt";
                    begin
                        _PostedPurchaseReceipt.Reset;
                        _PostedPurchaseReceipt.SetRange("Item No.", Rec.CODE0);

                        Clear(_PostedItemReceipt);
                        _PostedItemReceipt.LookupMode(true);
                        _PostedItemReceipt.SetTableView(_PostedPurchaseReceipt);
                        _PostedItemReceipt.SetRecord(_PostedPurchaseReceipt);
                        _PostedItemReceipt.Run;
                    end;
                }
                field("SHORT TEXT4"; Rec."SHORT TEXT4")
                {
                    Caption = 'QR Use';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Inquiry)
            {
                Caption = 'Inquiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    SetDelete;
                    DataInquiry;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin
        SetData;
    end;

    local procedure SetData()
    begin
        SetDelete;
        DataInquiry;
    end;


    procedure DataInquiry()
    var
        _Item: Record DK_Item;
        _EntryNo: Integer;
    begin
        _Item.Reset;
        _Item.SetRange(Blocked, false);
        _Item.SetRange("Notice Use", _Item."Notice Use"::Yes);
        if _Item.FindSet then begin
            repeat
                _Item.CalcFields(Inventory);
                if _Item."Notice Quantity" >= _Item.Inventory then begin
                    _EntryNo += 1;
                    Rec.Init;
                    Rec."USER ID" := UserId;
                    Rec."OBJECT ID" := PAGE::"DK_Item Facbox";
                    Rec."Entry No." := _EntryNo;
                    Rec.CODE0 := _Item."No.";
                    Rec."SHORT TEXT0" := _Item.Name;
                    Rec."SHORT TEXT1" := _Item."Item Main Cat. Name";
                    Rec."SHORT TEXT2" := _Item."Item Sub Cat. Name";
                    Rec."SHORT TEXT3" := _Item."Employee Name";
                    Rec.DECIMAL0 := _Item."Notice Quantity";
                    Rec.DECIMAL1 := _Item.Inventory;
                    Rec."SHORT TEXT4" := Format(_Item."QR Code Use");
                    Rec.Insert;
                    ;
                end;
            until _Item.Next = 0;
        end;
    end;


    procedure SetDelete()
    begin
        Rec.Reset;
        Rec.DeleteAll;
    end;
}

