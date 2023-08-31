page 50120 "DK_Posted Field Work"
{
    Caption = 'Posted Field Work';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,SMS';
    SourceTable = "DK_Field Work Header";
    SourceTableView = WHERE(Status = CONST(Post));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control31)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                    }
                    field(Date; Rec.Date)
                    {
                    }
                    field("Work Time Spent"; Rec."Work Time Spent")
                    {
                    }
                    field(Type; Rec.Type)
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
                    field("Corpse Name"; Rec."Corpse Name")
                    {
                    }
                    field("Corpse Quantity"; Rec."Corpse Quantity")
                    {
                    }
                    field("Funeral Type Code"; Rec."Funeral Type Code")
                    {
                        Importance = Additional;
                    }
                    field("Funeral Type Name"; Rec."Funeral Type Name")
                    {
                    }
                    field("Work Manager Code"; Rec."Work Manager Code")
                    {
                        Importance = Additional;
                    }
                    field("Work Manager Name"; Rec."Work Manager Name")
                    {
                    }
                    field("Work Division"; Rec."Work Division")
                    {
                    }
                    field(TotalAmount; Rec.TotalAmount)
                    {
                    }
                    field("SMS Not Sent"; Rec."SMS Not Sent")
                    {
                    }
                    field("Picture Send"; Rec."Picture Send")
                    {
                    }
                    field(Status; Rec.Status)
                    {
                    }
                    field("Process Content"; Rec."Process Content")
                    {
                    }
                }
                group(Memo)
                {
                    Caption = 'Memo';
                    field(WorkMemo; WorkMemo)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.SetWorkMemo(WorkMemo);
                        end;
                    }
                }
            }
            group("Field Work Picture")
            {
                Caption = 'Field Work Picture';
                group("Work Before Picture")
                {
                    Caption = 'Work Before Picture';
                    field(Control19; Rec."Work Before Picture")
                    {
                        ShowCaption = false;
                    }
                }
                group("Work After Picture")
                {
                    Caption = 'Work After Picture';
                    field("Work after Picture2"; Rec."Work after Picture")
                    {
                        ShowCaption = false;
                    }
                }
            }
            part("Field Work Item Line"; "DK_Field Work Item Subform")
            {
                Caption = 'Field Work Item Line';
                Editable = false;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            part("Field Work Cemetery Line"; "DK_Field Work Cem. Subform")
            {
                Caption = 'Field Work Cemetery Line';
                Editable = false;
                SubPageLink = "Document No." = FIELD("No."),
                              Type = FIELD(Type);
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
                field("User ID"; Rec."User ID")
                {
                }
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
        area(factboxes)
        {
            part(Control40; "DK_Today Funeral Detail")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = Rec."Source Type" = Rec."Source Type"::Today;
            }
            part(Control41; "DK_Customer Requests Factbox")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = Rec."Source Type" = Rec."Source Type"::Request;
            }
            part(Control42; "DK_Cem. Services Factbox")
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
            separator(Action44)
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

    trigger OnAfterGetRecord()
    begin
        WorkMemo := Rec.GetWorkMemo;
    end;

    var
        WorkMemo: Text;
        MSG001: Label 'The result is cancel.';
}

