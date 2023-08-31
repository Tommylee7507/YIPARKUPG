page 50175 "DK_Receipted PG Document"
{
    Caption = 'Receipted PG Document';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Receipted PG Document";
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
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field("Payment Time"; Rec."Payment Time")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Pay. Expect Doc No."; Rec."Pay. Expect Doc No.")
                {
                }
                field("Card Comp. Code"; Rec."Card Comp. Code")
                {
                }
                field("Card Comp. Name"; Rec."Card Comp. Name")
                {
                }
                field("Approval No."; Rec."Approval No.")
                {
                }
                field("Pay. Amount"; Rec."Pay. Amount")
                {
                }
                field("General Amount"; Rec."General Amount")
                {
                }
                field("Land. Amount"; Rec."Land. Amount")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control14; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control20; Notes)
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

