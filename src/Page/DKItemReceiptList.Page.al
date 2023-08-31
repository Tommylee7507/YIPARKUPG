page 50070 "DK_Item Receipt List"
{
    // 
    // DK34: 20201110
    //   - Add Field: Item Type

    Caption = 'Receipt list';
    CardPageID = "DK_Item Receipt";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Purchase Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Purchase Item"; Rec."Purchase Item")
                {
                }
                field("Item Type"; Rec."Item Type")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Receipt Time"; Rec."Receipt Time")
                {
                }
                field(Status; Rec.Status)
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
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

