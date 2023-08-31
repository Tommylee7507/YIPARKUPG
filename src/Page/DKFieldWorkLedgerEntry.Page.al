page 50121 "DK_Field Work Ledger Entry"
{
    Caption = 'Field Work Ledger Entry';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Field Work Ledger Entry";
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
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Work Tiem Spent"; Rec."Work Tiem Spent")
                {
                }
                field("Estate Code"; Rec."Estate Code")
                {
                }
                field("Estate Name"; Rec."Estate Name")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Work Main Cat. Code"; Rec."Work Main Cat. Code")
                {
                }
                field("Work Main Cat. Name"; Rec."Work Main Cat. Name")
                {
                }
                field("Work Sub Cat. Code"; Rec."Work Sub Cat. Code")
                {
                }
                field("Work Sub Cat. Name"; Rec."Work Sub Cat. Name")
                {
                }
                field("Work Group Code"; Rec."Work Group Code")
                {
                }
                field("Work Group"; Rec."Work Group")
                {
                }
                field("Work Personnel"; Rec."Work Personnel")
                {
                }
                field("Work Manager Code"; Rec."Work Manager Code")
                {
                }
                field("Work Manager"; Rec."Work Manager")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control28; Notes)
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

