page 50112 "DK_Contract Amount Ledger"
{
    Caption = 'Contract Amount Ledger';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Contract Amount Ledger";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Ledger Type"; Rec."Ledger Type")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Service No."; Rec."Service No.")
                {
                }
                field("Field Work Main Cat. Code"; Rec."Field Work Main Cat. Code")
                {
                    Importance = Additional;
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                    Importance = Additional;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field(Cancel; Rec.Cancel)
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control13; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control11; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //IF FINDFIRST THEN;
    end;
}

