page 50188 "DK_HQ Office Activities"
{
    // 
    // DK34: 20201103
    //   - Rec. Modify Trigger: OnOpenPage()
    //   - Add Field: "Due to Exire Purchase Contract"

    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup("Purchase Contract")
            {
                Caption = 'Purchase Contract';
                field(Control8; Rec."Purchase Contract")
                {
                    Image = Document;
                }
                field("Expiry Purchase Contract"; Rec."Expiry Purchase Contract")
                {
                    Image = Document;
                }
                field("Due to Exire Purchase Contract"; Rec."Due to Exire Purchase Contract")
                {
                }
            }
            cuegroup("Vehicle Ledger")
            {
                Caption = 'Vehicle Ledger';
                field("Vehicle Operation"; Rec."Vehicle Operation")
                {
                    Image = "Key";
                }
                field("Vehicle Refuling"; Rec."Vehicle Refuling")
                {
                    Image = "Key";
                }
                field("Vehicle Repair"; Rec."Vehicle Repair")
                {
                    Image = "Key";
                }
                field("Vehicle Wash"; Rec."Vehicle Wash")
                {
                    Image = "Key";
                }
            }
            cuegroup(Item)
            {
                Caption = 'Item';
                field("Item Receipt"; Rec."Item Receipt")
                {
                }
                field("Item Shipment"; Rec."Item Shipment")
                {
                    Image = Receipt;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Date Filter", '%1', WorkDate);
        //>>DK34
        Rec.SetFilter("Date Filter 2", '>=%1&<=%2', WorkDate, CalcDate('<1M>', WorkDate));
    end;
}

