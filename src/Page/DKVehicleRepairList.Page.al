page 50043 "DK_Vehicle Repair List"
{
    Caption = 'Vehicle Repair';
    CardPageID = "DK_Vehicle Repair";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE("Document Type" = FILTER(Repair),
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
                field("Repair Item Type"; Rec."Repair Item Type")
                {
                }
                field("Repair Item"; Rec."Repair Item")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Repair Type"; Rec."Repair Type")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Repair Date"; Rec."Repair Date")
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
            part(Control20; "DK_Alarm Factbox")
            {
                SubPageLink = "Source No." = FIELD("No."),
                              "Source Type"=CONST(Vehicle),
                              "Source Line No."=CONST(0);
                UpdatePropagation = Both;
            }
            systempart(Control18; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

