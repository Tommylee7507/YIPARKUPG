page 50256 "DK_Del Liti. Law. History List"
{
    Caption = 'Deleted Liti. Law. History List';
    CardPageID = "DK_Deleted Liti. Law. History";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Litigation Lawsuit History";
    SourceTableView = SORTING(Date)
                      ORDER(Descending)
                      WHERE("Delete Row" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Importance = Additional;
                    Lookup = false;
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    ShowMandatory = true;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Lawsuit Status"; Rec."Lawsuit Status")
                {
                }
                field("Lawsuit Method"; Rec."Lawsuit Method")
                {
                }
                field("Lawsuit Type"; Rec."Lawsuit Type")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Request Del"; Rec."Request Del")
                {
                }
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
                {
                }
                field("Delete Row"; Rec."Delete Row")
                {
                }
                field("Delete DateTime"; Rec."Delete DateTime")
                {
                }
                field("Delete Person"; Rec."Delete Person")
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
            systempart(Control16; Notes)
            {
            }
            part(Control17; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnInit()
    begin
        if Rec.FindFirst then;
    end;

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin

        //Delete All Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Law History Admin.", true);
        if _UserSetup.FindSet then
            DelAll := true
        else
            DelAll := false;
    end;

    var
        MSG001: Label 'Do you really want to delete it?';
        DelAll: Boolean;
}

