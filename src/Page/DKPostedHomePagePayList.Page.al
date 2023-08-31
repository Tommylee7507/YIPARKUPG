page 50313 "DK_Posted HomePage Pay. List"
{
    Caption = 'Posted HomePage Payment List';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_HomePage Payment Entry";
    SourceTableView = WHERE(Status = FILTER(Canceled | Completed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("General Amount"; Rec."General Amount")
                {
                }
                field("Landscape Amount"; Rec."Landscape Amount")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Payment Method Name"; Rec."Payment Method Name")
                {
                }
                field("Card Approval No."; Rec."Card Approval No.")
                {
                }
                field("Receipt Bank Account"; Rec."Receipt Bank Account")
                {
                }
                field("Receipt Bank Account Desc."; Rec."Receipt Bank Account Desc.")
                {
                }
                field("Old Receipt No."; Rec."Old Receipt No.")
                {
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control18; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control19; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Payment Receipt Document")
            {
                Caption = 'View Payment Receipt Document';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = View;

                trigger OnAction()
                var
                    _BatchReceiptedPGVA: Codeunit "DK_Batch Receipted PG/VA";
                begin
                    if Rec."Receipt No." = '' then
                        exit;
                    if Rec.Status in [Rec.Status::Open, Rec.Status::Canceled] then
                        exit;
                    OpenCard();
                end;
            }
        }
    }

    local procedure OpenCard()
    var
        _DK_PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _DK_PaymentReceiptDocumentPage: Page "DK_Payment Receipt Document";
        _DK_PostedPayReceiptDocPage: Page "DK_Posted Pay. Receipt Doc.";
    begin
        _DK_PaymentReceiptDocument.Reset();
        _DK_PaymentReceiptDocument.SetRange("Document Type", _DK_PaymentReceiptDocument."Document Type"::Receipt);
        _DK_PaymentReceiptDocument.SetRange("Document No.", Rec."Receipt No.");
        if _DK_PaymentReceiptDocument.FindSet(false) then begin
            if not _DK_PaymentReceiptDocument.Posted then begin
                _DK_PaymentReceiptDocumentPage.SetTableView(_DK_PaymentReceiptDocument);
                _DK_PaymentReceiptDocumentPage.Run;
            end else begin
                _DK_PostedPayReceiptDocPage.SetTableView(_DK_PaymentReceiptDocument);
                _DK_PostedPayReceiptDocPage.Run;
            end;
        end;
    end;
}

