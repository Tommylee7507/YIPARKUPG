page 50036 "DK_Vehicle Refueling List"
{
    Caption = 'Vehicle Refueling List';
    CardPageID = "DK_Vehicle Refueling";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE("Document Type" = FILTER(Refueling),
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
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Oiling Date"; Rec."Oiling Date")
                {
                }
                field("Oiling Machine"; Rec."Oiling Machine")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Liter; Rec.Liter)
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
            systempart(Control20; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

