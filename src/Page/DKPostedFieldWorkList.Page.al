page 50119 "DK_Posted Field Work List"
{
    Caption = 'Posted Field Work List';
    CardPageID = "DK_Posted Field Work";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,SMS';
    SourceTable = "DK_Field Work Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Post | Impossible));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Work Time Spent"; Rec."Work Time Spent")
                {
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Source Cemetery No."; Rec."Source Cemetery No.")
                {
                }
                field("Funeral Type Name"; Rec."Funeral Type Name")
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                field("Work Manager Name"; Rec."Work Manager Name")
                {
                }
                field(Memo; Rec.Memo)
                {
                }
                field("Work Before Picture"; Rec."Work Before Picture")
                {
                }
                field("Work after Picture"; Rec."Work after Picture")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Type"; Rec."Source Type")
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
            part(Control34; "DK_Today Funeral Detail")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = Rec."Source Type" = Rec."Source Type"::Today;
            }
            part(Control35; "DK_Customer Requests Factbox")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = Rec."Source Type" = Rec."Source Type"::Request;
            }
            part(Control36; "DK_Cem. Services Factbox")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = Rec."Source Type" = Rec."Source Type"::Service;
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
            action(Cancel)
            {
                Caption = 'Cancel';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _FieldWorkHeader: Record "DK_Field Work Header";
                    _FieldWorkPost: Codeunit "DK_Field Work - Post";
                begin
                    CurrPage.SetSelectionFilter(_FieldWorkHeader);
                    if _FieldWorkPost.CanCel(_FieldWorkHeader) then
                        Message(MSG001);
                end;
            }
            separator(Action32)
            {
            }
            action("SMS Send")
            {
                Caption = 'SMS Send';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Message('SMS Send');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        if Rec.FindFirst then;
    end;

    var
        MSG001: Label 'The result is cancel.';
}

