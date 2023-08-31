page 50252 "DK_Deleted Counsel Gen. List"
{
    Caption = 'Deleted Counsel General List';
    CardPageID = "DK_Deleted Counsel General";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Date, "Counsel Time", "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE(Type = CONST(General),
                            "Delete Row" = CONST(true));

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
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Result Process"; Rec."Result Process")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Counsel Level 1"; Rec."Counsel Level 1")
                {
                }
                field("Counsel Level Code 2"; Rec."Counsel Level Code 2")
                {
                }
                field("Counsel Level Name 2"; Rec."Counsel Level Name 2")
                {
                }
                field("Counsel Content"; Rec."Counsel Content")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field("Issue of membership"; Rec."Issue of membership")
                {
                }
                field("Dev. Target Doc. No."; Rec."Dev. Target Doc. No.")
                {
                }
                field("Dev. Target Doc. Line No."; Rec."Dev. Target Doc. Line No.")
                {
                    BlankZero = true;
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
            part(Control32; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control29; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin
        if Rec.FindFirst then;

        //Delete All Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_General Counsel Admin.", true);
        if _UserSetup.FindSet then
            DelAll := true
        else
            DelAll := false;
    end;

    var
        MSG001: Label 'Do you really want to delete it?';
        DelAll: Boolean;
}

