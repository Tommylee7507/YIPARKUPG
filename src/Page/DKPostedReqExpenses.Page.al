page 50107 "DK_Posted Req. Expenses"
{
    Caption = 'Posted Request Expenses';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Request Expenses Header";
    SourceTableView = WHERE(Status = FILTER(Post | Completed));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field("Purchases Date"; Rec."Purchases Date")
                {
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                field("GroupWare Doc. No."; Rec."GroupWare Doc. No.")
                {
                }
                group(Control27)
                {
                    ShowCaption = false;
                    field("Account Type"; Rec."Account Type")
                    {
                    }
                    field("Account No."; Rec."Account No.")
                    {
                        Importance = Additional;
                    }
                    field("Account Name"; Rec."Account Name")
                    {
                    }
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            group("Bank Information")
            {
                Caption = 'Bank Information';
                field("Bank Code"; Rec."Bank Code")
                {
                    Importance = Additional;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Account Holder"; Rec."Account Holder")
                {
                }
            }
            part(Line; "DK_Posted Req. Exp. Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'It is a line where the Request Expenses has been posted in large quantities.';
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Importance = Additional;
                }
                group(Control29)
                {
                    ShowCaption = false;
                    field("Last Date Modified"; Rec."Last Date Modified")
                    {
                    }
                    field("Last Modified Person"; Rec."Last Modified Person")
                    {
                    }
                    field("Full Name"; Rec."Full Name")
                    {
                    }
                }
            }
        }
        area(factboxes)
        {
            part(Control31; "DK_Posted Picture Factbox")
            {
                Provider = Line;
                SubPageLink = "Table ID" = CONST(50056),
                              "Source No." = FIELD("Document No."),
                              "Source Line No." = FIELD("Line No.");
            }
            systempart(Control26; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Recycle)
            {
                Caption = 'Recycle';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'It is a function to reuse the document canceled by the remittance request document.';
                Visible = Rec.Status = Rec.Status::Canceled;

                trigger OnAction()
                begin

                    if not Confirm(MSG001, false) then exit;

                    Rec.SetReOpen;

                    Message(MSG002, Rec.Status::Open);
                end;
            }
        }
    }

    var
        MSG001: Label 'Do you want to reuse canceled documents?';
        MSG002: Label 'Status change completed. Current Status:%1';
}

