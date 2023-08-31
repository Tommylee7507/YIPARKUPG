page 50160 "DK_Department Board List"
{
    Caption = 'Department Board List';
    CardPageID = "DK_Department Board";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Department Board";
    SourceTableView = SORTING("No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Contents; Rec.Contents)
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
            part(Control18; "DK_Posted Attched Files Facbox")
            {
                SubPageLink = "Table ID" = CONST(50103),
                              //   "Source No." = FIELD("No."),////zzz
                              "Source Line No." = CONST(0);
            }
            part(Control17; "DK_Posted Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50103),
                              //   "Source No." = FIELD("No."),////zzz
                              "Source Line No." = CONST(0);
            }
            systempart(Control16; Notes)
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

