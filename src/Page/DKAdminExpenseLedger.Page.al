page 50137 "DK_Admin. Expense Ledger"
{
    Caption = 'Admin. Expense Ledger';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Admin. Expense Ledger";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Admin. Expense Type"; Rec."Admin. Expense Type")
                {
                }
                field("Ledger Type"; Rec."Ledger Type")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                }
                field(Cancel; Rec.Cancel)
                {
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
                field("Exempt Target"; Rec."Exempt Target")
                {
                }
                field("Hike Exemption"; Rec."Hike Exemption")
                {
                }
                field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Add. Period"; Rec."Add. Period")
                {
                }
                field(Open; Rec.Open)
                {
                }
                field("Detail Max Seq."; Rec."Detail Max Seq.")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control17; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Detail Admin. Expense Ledger")
            {
                Caption = 'Detail Admin. Expense Ledger';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Detail Admin. Exp. Ledger";
                RunPageLink = "Contract No." = FIELD("Contract No.");
            }
        }
    }

    trigger OnOpenPage()
    begin
        //IF FINDFIRST THEN;
    end;
}

