page 50111 "DK_Move The Grave"
{
    // 
    // DK34: 20201130
    //   - Add Field: "Conversion Agency"

    Caption = 'Move The Grave';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Move The Grave";

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
                field(Type; Rec.Type)
                {

                    trigger OnValidate()
                    begin

                        if Rec.Type <> xRec.Type then begin
                            SetServiceStonVisible;
                        end
                    end;
                }
                field(Service; Rec.Service)
                {
                    Enabled = ServiceVisible;
                }
                field("Move Type"; Rec."Move Type")
                {
                    Enabled = ServiceVisible;
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                    Enabled = ServiceVisible;
                    Importance = Additional;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                    Enabled = ServiceVisible;
                }
                field("Ston Type"; Rec."Ston Type")
                {
                    Enabled = StonTypeVisible;
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Completion Date"; Rec."Completion Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                group(Control23)
                {
                    ShowCaption = false;
                    field(Religion; Rec.Religion)
                    {
                    }
                    field(TotalAmount; Rec.TotalAmount)
                    {
                    }
                    field("Contract Amount"; Rec."Contract Amount")
                    {
                    }
                    field("Remaining Amount"; Rec."Remaining Amount")
                    {
                    }
                    field("Payment Type"; Rec."Payment Type")
                    {
                    }
                    field("Contract Amount Date"; Rec."Contract Amount Date")
                    {
                    }
                    field("Remaining Amount Date"; Rec."Remaining Amount Date")
                    {
                    }
                    field("Conversion Agency"; Rec."Conversion Agency")
                    {
                    }
                    field(Remarks; Rec.Remarks)
                    {
                    }
                    field(Control6; Rec.Status)
                    {
                    }
                }
            }
            part(Line; "DK_Move The Grave Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("No."),
                              "Contract No." = FIELD("Contract No.");
                ToolTip = 'You can enter multiple corpse for move the grave.';
            }
            group("Customer Infromation")
            {
                Caption = 'Customer Infromation';
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Contact"; Rec."Cust. Contact")
                {
                }
                field("Cust. E-mail"; Rec."Cust. E-mail")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Cemetery Digits"; Rec."Cemetery Digits")
                {
                }
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
            part(Control33; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control30; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Status)
            {
                Caption = 'Status';
                ToolTip = 'The ability to change the Status of the move the grave document. It is not connected with field work.';
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Enabled = Rec.Status <> Rec.Status::Receipt;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'It is a function to change the document of move the grave to receipt Status.';

                    trigger OnAction()
                    begin
                        Rec.SetReceipt;
                    end;
                }
                action(Completion)
                {
                    Caption = 'Completion';
                    Enabled = Rec.Status <> Rec.Status::Completion;
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'It is a function to change the document of move the grave to completion Status.';

                    trigger OnAction()
                    begin
                        Rec.SetCompletion;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin

        SetServiceStonVisible;
        Rec."Receipt Date" := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    trigger OnOpenPage()
    begin
        SetServiceStonVisible;
    end;

    var
        ServiceVisible: Boolean;
        StonTypeVisible: Boolean;


    procedure SetServiceStonVisible()
    begin

        if Rec.Type = Rec.Type::"Move The Grave" then begin
            ServiceVisible := true;
            StonTypeVisible := false;
        end else begin
            ServiceVisible := false;
            StonTypeVisible := true;
        end;
    end;
}

