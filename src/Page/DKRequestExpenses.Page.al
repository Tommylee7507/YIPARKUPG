page 50085 "DK_Request Expenses"
{
    Caption = 'Request Expenses';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Request Expenses Header";
    SourceTableView = WHERE(Status = FILTER(Open | Released | Canceled));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Purchases Date"; Rec."Purchases Date")
                {
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("GroupWare Doc. No."; Rec."GroupWare Doc. No.")
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                group(Control32)
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
            part(Line; "DK_Request Expenses Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'A large number of Request Expenses can be registered.';
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
                group(Control35)
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
            part(Control36; "DK_Picture Factbox")
            {
                Provider = Line;
                SubPageLink = "Table ID" = CONST(50056),
                              "Source No." = FIELD("Document No."),
                              "Source Line No." = FIELD("Line No.");
            }
            systempart(Control28; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action18)
            {
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Enabled = Rec.Status = Rec.Status::Released;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.SetReOpen;
                    end;
                }
                action(Released)
                {
                    Caption = 'Released';
                    Enabled = Rec.Status <> Rec.Status::Released;
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.SetReleased;
                    end;
                }
            }
            group(Action29)
            {
                action(Post)
                {
                    Caption = 'Post';
                    Enabled = Rec.Status = Rec.Status::Released;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec.SetPost() then
                            Message(MSG001);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetNewData;
    end;

    var
        MSG001: Label 'The post is completed.';

    local procedure SetNewData()
    var
        _Employee: Record DK_Employee;
    begin
        Rec."Payment Request Date" := WorkDate;
        Rec."Purchases Date" := WorkDate;
        Rec."Posting Date" := WorkDate;
        Rec."Account Type" := Rec."Account Type"::Employee;
        //VALIDATE("Account No.",_Employee.GetEmployeeNoUserID(USERID));
    end;
}

