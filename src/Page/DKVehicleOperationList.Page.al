page 50032 "DK_Vehicle Operation List"
{
    Caption = 'Vehicle Operation';
    CardPageID = "DK_Vehicle Operation";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE("Document Type" = FILTER(Operation),
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
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Departure Time"; Rec."Departure Time")
                {
                }
                field("Arrival Date"; Rec."Arrival Date")
                {
                }
                field("Departure Date"; Rec."Departure Date")
                {
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                }
                field("Km Cumulative"; Rec."Km Cumulative")
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
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Action24)
            {
            }
        }
    }
}

