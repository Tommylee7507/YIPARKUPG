page 50071 "DK_Item Receipt"
{
    // 
    // DK34: 20201110
    //   - Add Field: Item Type

    Caption = 'Purchase Receipt';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Purchase Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Purchase Item"; Rec."Purchase Item")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Item Type"; Rec."Item Type")
                {
                }
                group(Control19)
                {
                    ShowCaption = false;
                    field("Receipt Date"; Rec."Receipt Date")
                    {
                        ShowMandatory = true;
                    }
                    field("Receipt Time"; Rec."Receipt Time")
                    {
                        ShowMandatory = true;
                    }
                }
                field(Status; Rec.Status)
                {
                }
            }
            part(Lines; "DK_Item Receipt Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
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
            part(Control24; "DK_Picture Factbox")
            {
                Provider = Lines;
                SubPageLink = "Table ID" = CONST(50050),
                              "Source No." = FIELD("Document No."),
                              "Source Line No." = FIELD("Line No.");
            }
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action23)
            {
                action(Released)
                {
                    Caption = 'Released';
                    Enabled = Rec.Status <> Rec.Status::Release;
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.SetReleased;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.SetReOpen;
                    end;
                }
            }
            group(Action22)
            {
                action(Post)
                {
                    Caption = 'Post';
                    Enabled = Rec.Status = Rec.Status::Release;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec.SetPost() then
                            Message(MSG002);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        Rec."Receipt Date" := WorkDate;
        Rec."Receipt Time" := Time;

        _Employee.Reset;
        _Employee.SetRange(Blocked, false);
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then begin
            Rec.Validate("Employee No.", _Employee."No.");
        end;
    end;

    var
        MSG001: Label 'Confirmation is completed.';
        MSG002: Label 'The Post is completed.';
}

