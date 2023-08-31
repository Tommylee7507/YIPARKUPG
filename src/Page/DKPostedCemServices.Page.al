page 50128 "DK_Posted Cem. Services"
{
    Caption = 'Posted Cemetery Services';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Copy,Payment Expect,Payment';
    SourceTable = "DK_Cemetery Services";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group("Service Information")
                {
                    Caption = 'Service Information';
                    field("No."; Rec."No.")
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
                    field("Process Content"; Rec."Process Content")
                    {
                    }
                    field("Contract No."; Rec."Contract No.")
                    {
                    }
                    field("Cemetery Code"; Rec."Cemetery Code")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Importance = Additional;
                        Lookup = false;
                    }
                    field("Cemetery No."; Rec."Cemetery No.")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field(Description; Rec.Description)
                    {
                    }
                    field(Unit; Rec.Unit)
                    {
                    }
                    field("Cost Amount"; Rec."Cost Amount")
                    {
                    }
                    field(Quantity; Rec.Quantity)
                    {
                    }
                    field(Amount; Rec.Amount)
                    {
                    }
                    field("Receipt Amount"; Rec."Receipt Amount")
                    {
                    }
                }
                group("Receipt Information")
                {
                    Caption = 'Receipt Information';
                    field("Corpse Name"; Rec."Corpse Name")
                    {
                    }
                    field("Receipt Date"; Rec."Receipt Date")
                    {
                    }
                    field("Work Date"; Rec."Work Date")
                    {
                    }
                    field("Desired Date"; Rec."Desired Date")
                    {
                    }
                    field("SMS Send Date"; Rec."SMS Send Date")
                    {
                    }
                    field("Employee No."; Rec."Employee No.")
                    {
                        Importance = Additional;
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                    }
                    field(Religion; Rec.Religion)
                    {
                    }
                    field(Remarks; Rec.Remarks)
                    {
                    }
                    field(Status; Rec.Status)
                    {
                    }
                }
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Importance = Additional;
                    Lookup = false;
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. E-mail"; Rec."Cust. E-mail")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
            }
            group(Applicant)
            {
                Caption = 'Applicant Information';
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("Appl. Phone No."; Rec."Appl. Phone No.")
                {
                }
                field("Email Status"; Rec."Email Status")
                {
                }
                field("Appl. E-mail"; Rec."Appl. E-mail")
                {
                    Enabled = Rec."Email Status" = FALSE;
                }
                field("Relationship With Cust."; Rec."Relationship With Cust.")
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
            part(Control43; "DK_Contract Detail Factbox")
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
            action(DK_PaymentDocumetView)
            {
                Caption = 'Payment Document View';
                Enabled = PaymentDocView;
                Image = ReceiptLines;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Visible = PaymentDocView;

                trigger OnAction()
                var
                    _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
                    _PostedItemReceipt: Page "DK_Post Pay. Receipt Doc. List";
                begin

                    _PaymentReceiptDocument.Reset;
                    _PaymentReceiptDocument.CalcFields("Line Cem. Services No.");
                    _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
                    _PaymentReceiptDocument.SetRange("Line Cem. Services No.", Rec."No.");
                    _PaymentReceiptDocument.SetRange(Posted, true);
                    if _PaymentReceiptDocument.FindSet then begin
                        Clear(_PostedItemReceipt);
                        _PostedItemReceipt.LookupMode(true);
                        _PostedItemReceipt.SetTableView(_PaymentReceiptDocument);
                        _PostedItemReceipt.SetRecord(_PaymentReceiptDocument);
                        _PostedItemReceipt.RunModal;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PaymentDocActionView;
    end;

    var
        PaymentDocView: Boolean;

    local procedure PaymentDocActionView()
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _PostPayReceiptDocList: Page "DK_Post Pay. Receipt Doc. List";
    begin

        PaymentDocView := false;

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.CalcFields("Line Cem. Services No.");
        _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
        _PaymentReceiptDocument.SetRange("Line Cem. Services No.", Rec."No.");
        _PaymentReceiptDocument.SetRange(Posted, true);
        if _PaymentReceiptDocument.FindSet then begin
            PaymentDocView := true;
        end;
    end;
}

