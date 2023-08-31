page 50201 "DK_Payment Refund Document"
{
    // 
    // DK34: 20201201
    //   - Add Field: "Department Code", "Department Name"
    // 
    // #2385: 20210201
    //   - Add Function: getLastAdminPayTargetDocNo

    Caption = 'Payment Refund Document';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Payment Receipt Document";
    SourceTableView = WHERE(Posted = CONST(false),
                            "Document Type" = CONST(Refund));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Target Doc. No."; Rec."Target Doc. No.")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField("Refund Status", Rec."Refund Status"::Open);

                        if Rec."Target Doc. No." <> '' then
                            getLastAdminPayTargetDocNo;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document Time"; Rec."Document Time")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if xRec.Amount <> Rec.Amount then
                            CurrPage.Update;
                    end;
                }
                field("Request Refund Date"; Rec."Request Refund Date")
                {
                }
                field("Refund Reason"; Rec."Refund Reason")
                {
                }
                field(Correction; Rec.Correction)
                {

                    trigger OnValidate()
                    begin
                        if xRec.Correction <> Rec.Correction then begin
                            if Rec.Correction then
                                if not Confirm(MSG004, false, Rec.FieldCaption(Correction)) then
                                    Rec.Correction := xRec.Correction
                        end;
                    end;
                }
                field("Refund Status"; Rec."Refund Status")
                {
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
            }
            group("Bank Account Information")
            {
                Caption = 'Bank Account Information';
                field("Refund Bank Code"; Rec."Refund Bank Code")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Refund Status", Rec."Refund Status"::Open);
                    end;
                }
                field("Refund Bank Name"; Rec."Refund Bank Name")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField("Refund Status", Rec."Refund Status"::Open);
                    end;
                }
                field("Refund Bank Account No."; Rec."Refund Bank Account No.")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField("Refund Status", Rec."Refund Status"::Open);
                    end;
                }
                field("Refund Account Holder"; Rec."Refund Account Holder")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField("Refund Status", Rec."Refund Status"::Open);
                    end;
                }
            }
            group("Payment Receipt Document")
            {
                Caption = 'Payment Receipt Document';
                Editable = false;
                group(Control64)
                {
                    ShowCaption = false;
                    field("Payment Date"; Rec."Payment Date")
                    {
                    }
                    field("Payment Type"; Rec."Payment Type")
                    {
                    }
                    group(Control36)
                    {
                        Enabled = Rec."Payment Type" = Rec."Payment Type"::Bank;
                        ShowCaption = false;
                        Visible = Rec."Payment Type" = Rec."Payment Type"::Bank;
                        field("Bank Account Code"; Rec."Bank Account Code")
                        {

                            trigger OnValidate()
                            begin
                                Rec.CalcFields("Litigation Bank Account");

                                LitigationVisible := Rec."Litigation Bank Account";

                                CurrPage.Update;
                            end;
                        }
                        field("Bank Account Name"; Rec."Bank Account Name")
                        {
                            Editable = false;
                        }
                        field("Bank Account No."; Rec."Bank Account No.")
                        {
                            Editable = false;
                        }
                    }
                    group(Control32)
                    {
                        Enabled = Rec."Payment Type" = Rec."Payment Type"::Card;
                        ShowCaption = false;
                        Visible = Rec."Payment Type" = Rec."Payment Type"::Card;
                        field("Payment Method Code"; Rec."Payment Method Code")
                        {
                            Importance = Additional;
                        }
                        field("Payment Method Name"; Rec."Payment Method Name")
                        {
                        }
                    }
                    group(Control29)
                    {
                        Enabled = (Rec."Payment Type" <> Rec."Payment Type"::Card) AND (Rec."Payment Type" <> Rec."Payment Type"::None);
                        ShowCaption = false;
                        Visible = (Rec."Payment Type" <> Rec."Payment Type"::Card) AND (Rec."Payment Type" <> Rec."Payment Type"::None);
                        field("Issued Cash Receipts"; Rec."Issued Cash Receipts")
                        {
                        }
                        field("Issued Cash Rec. Date"; Rec."Issued Cash Rec. Date")
                        {
                        }
                        field("Issued Cash Rec. Mobile"; Rec."Issued Cash Rec. Mobile")
                        {
                        }
                        field("Cash Bill Approval No."; Rec."Cash Bill Approval No.")
                        {
                        }
                    }
                    group(Control70)
                    {
                        Editable = Rec."Before Document No." = '';
                        ShowCaption = false;
                        Visible = (Rec."Payment Type" = Rec."Payment Type"::Cash) OR (Rec."Payment Type" = Rec."Payment Type"::Bank) OR (Rec."Payment Type" = Rec."Payment Type"::Giro) OR (Rec."Payment Type" = Rec."Payment Type"::VirtualAccount);
                        field("Issued TAX Bill"; Rec."Issued TAX Bill")
                        {
                        }
                        field("Issued TAX Bill Date"; Rec."Issued TAX Bill Date")
                        {
                        }
                    }
                    group(Control67)
                    {
                        Editable = Rec."Before Document No." = '';
                        ShowCaption = false;
                        Visible = (Rec."Payment Type" = Rec."Payment Type"::Card);
                        field("Card Approval No."; Rec."Card Approval No.")
                        {
                        }
                    }
                }
                field("Before Document No."; Rec."Before Document No.")
                {
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowPostedPaymentDocument(Rec."Before Document No.");
                    end;
                }
                field("Missing Contract"; Rec."Missing Contract")
                {
                    Enabled = Rec."Before Document No." = '';
                }
            }
            group(Contract)
            {
                Caption = 'Contract';
                Editable = false;
                field("Contract No."; Rec."Contract No.")
                {
                    Enabled = NOT Rec."Missing Contract";
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Litigation Employee No."; Rec."Litigation Employee No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Litigation Employee Name"; Rec."Litigation Employee Name")
                {
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Importance = Additional;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Litigation Evaluation"; Rec."Litigation Evaluation")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
            }
            group(Litigation)
            {
                Caption = 'Litigation';
                Editable = false;
                Enabled = LitigationVisible;
                Visible = LitigationVisible;
                field(Division; Rec.Division)
                {
                }
                field("Legal Amount"; Rec."Legal Amount")
                {
                }
                field("Advance Payment Amount"; Rec."Advance Payment Amount")
                {
                }
                field("Delay Interest Amount"; Rec."Delay Interest Amount")
                {
                }
                field("Reduction Amount"; Rec."Reduction Amount")
                {
                }
                field("MTG Amount"; Rec."MTG Amount")
                {
                }
                field("Move The Grave"; Rec."Move The Grave")
                {
                }
                field("Final Amount"; Rec."Final Amount")
                {
                }
                field("Withdraw Mothed"; Rec."Withdraw Mothed")
                {
                }
                group(Control46)
                {
                    ShowCaption = false;
                    field("Litigation Ramark"; Rec."Litigation Ramark")
                    {
                        MultiLine = true;
                    }
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
            part(Control13; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _PaymentReceiptPost: Codeunit "DK_Payment Receipt - Post";
                    _ValidatePostingDateMgt: Codeunit "DK_ValidatePostingDate Mgt.";
                    _PayReceiptDocument: Record "DK_Payment Receipt Document";
                begin
                    Rec.TestField("Refund Status", Rec."Refund Status"::Open);
                    Rec.TestField("Request Refund Date");
                    Rec.TestField("Target Doc. No.");
                    Rec.TestField("Posting Date");

                    if Rec."Request Refund Date" <= Today then
                        Error(MSG002, Rec.FieldCaption("Request Refund Date"), Today);

                    if Rec."Payment Completion Date" <> 0D then
                        Error(MSG001, Rec.FieldCaption("Payment Completion Date"), Rec."Payment Completion Date");

                    if Rec.Correction then begin
                        if not Confirm(MSG005, false) then begin
                            Message(MSG006);
                            exit;
                        end;

                        _PaymentReceiptPost.RefundPost2(Rec);
                    end else begin

                        Clear(_PaymentReceiptPost);
                        _PaymentReceiptPost.RequestRemittance(Rec);

                        Message(MSG007);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Litigation Bank Account");

        LitigationVisible := Rec."Litigation Bank Account";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TestField("Refund Status", Rec."Refund Status"::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Request Refund Date" := WorkDate + 1;
    end;

    var
        LitigationVisible: Boolean;
        MSG001: Label '%1 exists. %1:%2';
        MSG002: Label 'Please enter a date after today. today:%2';
        MSG003: Label 'This document can be canceled. %1';
        MSG004: Label 'Do you want to proceed with the correction process for this document?';
        MSG005: Label 'Do you want to proceed with cancellation?';
        MSG006: Label 'Posting was canceled.';
        MSG007: Label 'Request Remittance received.';
        MSG008: Label 'Please refund the maintenance fee first before proceeding. Due to the end date of the administrative fee, refunds must be made in reverse order of deposit.';

    local procedure getLastAdminPayTargetDocNo()
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PaymentReceiptDocument2: Record "DK_Payment Receipt Document";
    begin

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.SetRange("Document No.", Rec."Target Doc. No.");
        if _PaymentReceiptDocument.FindSet then begin
            _PaymentReceiptDocLine.Reset;
            _PaymentReceiptDocLine.SetRange("Document No.", _PaymentReceiptDocument."Document No.");
            _PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2|%3', _PaymentReceiptDocLine."Payment Target"::Contract,
                                                                         _PaymentReceiptDocLine."Payment Target"::Deposit,
                                                                         _PaymentReceiptDocLine."Payment Target"::Remaining);
            if _PaymentReceiptDocLine.FindSet then begin
                _PaymentReceiptDocument2.Reset;
                _PaymentReceiptDocument2.SetFilter("Document No.", '<>%1', _PaymentReceiptDocument."Document No.");
                _PaymentReceiptDocument2.SetRange("Contract No.", _PaymentReceiptDocument."Contract No.");
                _PaymentReceiptDocument2.SetFilter("Line Admin. Expense", '<>%1', 0);
                _PaymentReceiptDocument2.SetRange(Refund, false);
                if _PaymentReceiptDocument2.FindSet then
                    Error(MSG008);
            end;
        end;
    end;
}

