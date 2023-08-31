page 50044 "DK_Vehicle Wash List"
{
    Caption = 'Vehicle Wash List';
    CardPageID = "DK_Vehicle Wash";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE("Document Type" = FILTER(Wash),
                            Status = FILTER(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Vehicle Document No."; Rec."Vehicle Document No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Wash Date"; Rec."Wash Date")
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
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

