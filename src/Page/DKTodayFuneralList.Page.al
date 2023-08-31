page 50088 "DK_Today Funeral List"
{
    // 
    // DK34: 20201202
    //   - Add Field: "Move The Grave Type"
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Today Funeral List';
    CardPageID = "DK_Today Funeral Card";
    Editable = false;
    PageType = List;
    SourceTable = "DK_Today Funeral";
    SourceTableView = SORTING(Date) ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                }
                field("Opening Time"; Rec."Opening Time")
                {
                }
                field(Applicant; Rec.Applicant)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Working Group Code"; Rec."Working Group Code")
                {
                    Visible = false;
                }
                field("Working Group Name"; Rec."Working Group Name")
                {
                }
                field("Move The Grave Type"; Rec."Move The Grave Type")
                {
                }
                field("Cemetery Digits"; Rec."Cemetery Digits")
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
            systempart(Control23; Notes)
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

    var
        SalesList: Page "Sales Order List";
}

