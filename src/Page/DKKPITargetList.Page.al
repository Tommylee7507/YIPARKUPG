page 50287 "DK_KPI Target List"
{
    // 
    // DK34: 20201113
    //   - Create

    Caption = 'KPI Target List';
    CardPageID = "DK_KPI Target Document";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_KPI Target";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field("OBJECT ID"; Rec."OBJECT ID")
                {
                    Visible = false;
                }
                field("Report Taget Name"; Rec."Report Taget Name")
                {
                }
                field(Year; Rec.Year)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Remarks; Rec.Remarks)
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
            systempart(Control15; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

