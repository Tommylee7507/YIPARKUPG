page 50022 "DK_Purchase Contract Line List"
{
    AutoSplitKey = true;
    Caption = 'Purchase Contract Line';
    CardPageID = "DK_Purchase Contract Line Card";
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Purchase Contract Line";
    SourceTableView = SORTING("Purchase Contract No.", "Line No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Contract Date From"; Rec."Contract Date From")
                {
                }
                field("Contract Date To"; Rec."Contract Date To")
                {
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                }
                field("Short Contents"; Rec."Short Contents")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Department Name"; Rec."Department Name")
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
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

