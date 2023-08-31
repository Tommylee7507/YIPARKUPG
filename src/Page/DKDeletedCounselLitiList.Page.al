page 50253 "DK_Deleted Counsel Liti. List"
{
    // 
    // #2044: 20200904
    //   - Rec. Modify Page Caption: ‹Ð‘ª…˜ ŒÁ‰½ ‹Ý„Ì ˆ±‡Ÿ -> ‹Ð‘ª…˜ ×„ ‹Ý„Ì ˆ±‡Ÿ

    Caption = 'Delete Counsel Litigation List';
    CardPageID = "DK_Deleted Counsel Litigation";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Date, "Counsel Time", "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE(Type = CONST(Litigation),
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
                field("Counsel Time"; Rec."Counsel Time")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Deposit Plan Date"; Rec."Deposit Plan Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Litigation Type"; Rec."Litigation Type")
                {
                }
                field("Contact Method"; Rec."Contact Method")
                {
                }
                field("Counsel Target"; Rec."Counsel Target")
                {
                }
                field("Counsel Content"; Rec."Counsel Content")
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
            part(Control6; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control27; Notes)
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
        _UserSetup.SetRange("DK_Litigation Counsel Admin.", true);
        if _UserSetup.FindSet then
            DelAll := true
        else
            DelAll := false;
    end;

    var
        MSG001: Label 'Do you really want to delete it?';
        DelAll: Boolean;
}

