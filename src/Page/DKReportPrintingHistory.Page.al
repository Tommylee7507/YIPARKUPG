page 50180 "DK_Report Printing History"
{
    Caption = 'Report Printing History';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Report Prt. History";
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
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Printing Date"; Rec."Printing Date")
                {
                }
                field("Printing Time"; Rec."Printing Time")
                {
                }
                field("Report ID"; Rec."Report ID")
                {
                }
                field("Report Caption"; Rec."Report Caption")
                {
                }
                field("Printed Report"; Rec."Printed Report")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Contacts; Rec.Contacts)
                {
                }
                field("Add.Remaining Due Date"; Rec."Add.Remaining Due Date")
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
            systempart(Control15; Notes)
            {
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

