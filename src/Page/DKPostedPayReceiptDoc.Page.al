page 50136 "DK_Posted Pay. Receipt Doc."
{
    // 
    // DK34: 20201126
    //   - Add Field: "Liti. Delay Interest Amount"

    Caption = 'Posted Payment Receipt Document';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "DK_Payment Receipt Document";
    SourceTableView = WHERE(Posted = CONST(true),
                            "Document Type" = CONST(Receipt));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Final Amount"; Rec."Final Amount")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
                {
                    Visible = Rec."Pay. Expect Doc. No." <> '';
                }
                group(Control79)
                {
                    Editable = Rec."Before Document No." = '';
                    ShowCaption = false;
                    Visible = Rec."Payment Type" = Rec."Payment Type"::VirtualAccount;
                    field("Virtual Account No."; Rec."Virtual Account No.")
                    {
                        Editable = false;
                    }
                }
                group(Control29)
                {
                    ShowCaption = false;
                    Visible = Rec."Payment Type" = Rec."Payment Type"::Bank;
                    field("Bank Account Code"; Rec."Bank Account Code")
                    {
                        Caption = 'Bank Account Code';
                    }
                    field("Bank Account Name"; Rec."Bank Account Name")
                    {
                        Caption = 'Bank Account Name';
                        Editable = false;
                    }
                    field("Bank Account No."; Rec."Bank Account No.")
                    {
                        Caption = 'Bank Account No.';
                        Editable = false;
                    }
                }
                group(Control18)
                {
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Card) OR (Rec."Payment Type" = Rec."Payment Type"::OnlineCard) OR (Rec."Payment Type" = Rec."Payment Type"::Giro);
                    field("Payment Method Code"; Rec."Payment Method Code")
                    {
                        Caption = 'Payment Method Code';
                        Importance = Additional;
                    }
                    field("Payment Method Name"; Rec."Payment Method Name")
                    {
                    }
                }
                group(Control8)
                {
                    ShowCaption = false;
                    field("Contract No."; Rec."Contract No.")
                    {
                    }
                    field("Cemetery No."; Rec."Cemetery No.")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Posting Date"; Rec."Posting Date")
                    {
                    }
                    field(Litigation; Rec.Litigation)
                    {
                    }
                    field(Depositor; Rec.Depositor)
                    {
                        Editable = NOT Rec."Missing Contract";
                        Enabled = NOT Rec."Missing Contract";
                    }
                    field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                    {
                        Editable = NOT Rec."Missing Contract";
                        Enabled = NOT Rec."Missing Contract";
                    }
                    field("Missing Contract"; Rec."Missing Contract")
                    {
                    }
                    field(Description; Rec.Description)
                    {
                        MultiLine = true;
                    }
                    field(Refund; Rec.Refund)
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Before Document No."; Rec."Before Document No.")
                    {

                        trigger OnDrillDown()
                        begin
                            Rec.ShowPostedPaymentDocument(Rec."Before Document No.");
                        end;
                    }
                    field("After Document No."; Rec."After Document No.")
                    {

                        trigger OnDrillDown()
                        begin
                            Rec.ShowPostedPaymentDocument(Rec."After Document No.");
                        end;
                    }
                }
            }
            group("Payment Bill")
            {
                Caption = 'Payment Bill';
                Visible = (Rec."Payment Type" <> Rec."Payment Type"::None);
                group(Control76)
                {
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Cash) OR (Rec."Payment Type" = Rec."Payment Type"::Bank) OR (Rec."Payment Type" = Rec."Payment Type"::Giro) OR (Rec."Payment Type" = Rec."Payment Type"::VirtualAccount);
                    field("Issued Cash Receipts"; Rec."Issued Cash Receipts")
                    {
                    }
                    field("Issued Cash Rec. Date"; Rec."Issued Cash Rec. Date")
                    {
                        Caption = 'Issued Cash Receipts Date';
                        Editable = Rec."Issued Cash Receipts";
                        Enabled = Rec."Issued Cash Receipts";
                    }
                    field("Issued Cash Rec. Mobile"; Rec."Issued Cash Rec. Mobile")
                    {
                        Caption = 'Issued Cash Receipts Mobile No.';
                        Editable = Rec."Issued Cash Receipts";
                        Enabled = Rec."Issued Cash Receipts";
                    }
                    field("Cash Bill Approval No."; Rec."Cash Bill Approval No.")
                    {
                        Caption = 'Cash Bill Approval No.';
                        Editable = Rec."Issued Cash Receipts";
                        Enabled = Rec."Issued Cash Receipts";
                    }
                }
                group(Control72)
                {
                    Editable = false;
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Cash) OR (Rec."Payment Type" = Rec."Payment Type"::Bank) OR (Rec."Payment Type" = Rec."Payment Type"::Giro) OR (Rec."Payment Type" = Rec."Payment Type"::VirtualAccount);
                    field("Issued TAX Bill"; Rec."Issued TAX Bill")
                    {
                    }
                    field("Issued TAX Bill Date"; Rec."Issued TAX Bill Date")
                    {
                    }
                }
                group(Control27)
                {
                    Editable = false;
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Card) OR (Rec."Payment Type" = Rec."Payment Type"::OnlineCard);
                    field("Card Approval No."; Rec."Card Approval No.")
                    {
                    }
                }
            }
            group(Control57)
            {
                Caption = 'Litigation';
                Editable = false;
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
                field("Liti. Delay Interest Amount"; Rec."Liti. Delay Interest Amount")
                {
                }
                field("Reduction Amount 1"; Rec."Reduction Amount 1")
                {
                }
                field("Reduction Amount 2"; Rec."Reduction Amount 2")
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
                field("Debt Relief Amount"; Rec."Debt Relief Amount")
                {
                }
                field("Withdraw Mothed"; Rec."Withdraw Mothed")
                {
                }
                field("Litigation Ramark"; Rec."Litigation Ramark")
                {
                    MultiLine = true;
                }
            }
            part(Line; "DK_Payment Rec. Doc. Line")
            {
                Caption = 'Line';
                Editable = false;
                SubPageLink = "Document No." = FIELD("Document No.");
            }
            group(Contract)
            {
                Caption = 'Contract';
                Editable = false;
                field("Before Contract No."; Rec."Before Contract No.")
                {
                    Importance = Additional;
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
            }
            group(Control64)
            {
                Caption = 'Refund';
                field("Refund Document No."; Rec."Refund Document No.")
                {
                }
                field("Refund Posting Date"; Rec."Refund Posting Date")
                {
                }
                field("Refund Pay. Comp. Date"; Rec."Refund Pay. Comp. Date")
                {
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Created Auto."; Rec."Created Auto.")
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
            part(Control35; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            part(Control62; "DK_Cem. Services Factbox")
            {
                Provider = Line;
                SubPageLink = "No." = FIELD("Cem. Services No.");
            }
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action37)
            {
                action("Admin. Expense Ledger")
                {
                    Caption = 'Admin. Expense Ledger';
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DK_Contract Amount Ledger";
                    RunPageLink = "Contract No." = FIELD("Contract No."),
                                  "Source No." = FIELD("Document No.");
                }
                action("Contract Amount Ledger")
                {
                    Caption = 'Contract Amount Ledger';
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DK_Admin. Expense Ledger";
                    RunPageLink = "Contract No." = FIELD("Contract No."),
                                  "Source No." = FIELD("Document No.");

                    trigger OnAction()
                    var
                        _RecContAmountLedger: Record "DK_Contract Amount Ledger";
                        _ContAmountLedger: Page "DK_Contract Amount Ledger";
                    begin
                    end;
                }
                action("Show Refund Document")
                {
                    Caption = 'Show Refund Document';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _PayReceiptDoc: Record "DK_Payment Receipt Document";
                    begin
                        Rec.CalcFields("Refund Document No.");
                        if Rec."Refund Document No." = '' then
                            Error(MSG009);

                        _PayReceiptDoc.ShowPostedPaymentDocument(Rec."Refund Document No.");
                    end;
                }
                action("Admin Expense Payment")
                {
                    Caption = 'Admin Expense Payment';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        AdminExpensePaymentRun;
                    end;
                }
            }
            group(Action45)
            {
                action("Cancel Posted")
                {
                    Caption = 'Cancel Posted';
                    Enabled = CancelPosted;
                    Image = PostedReturnReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = CancelPosted;

                    trigger OnAction()
                    var
                        _PayRecPost: Codeunit "DK_Payment Receipt - Post";
                    begin
                        if Rec.IDX <> 0 then
                            Error(MSG010);

                        if Rec."Posting Date" < 20191001D then
                            Error(MSG010);

                        if not _PayRecPost.CheckCencalPayReceAdmin then
                            Error(MSG002);

                        Rec.CalcFields("Refund Document No.");
                        if Rec."Refund Document No." <> '' then
                            Error(MSG005, Rec."Refund Document No.");

                        //IF ("Created Auto.") AND (Rec."Payment Type" <> Rec."Payment Type"::VirtualAccount) THEN
                        //  ERROR(MSG011,FIELDCAPTION("Pay. Expect Doc. No."), "Pay. Expect Doc. No.");

                        if not Confirm(MSG001, false) then exit;

                        _PayRecPost.PostCancel(Rec);
                    end;
                }
                action("Change Contract No.")
                {
                    Caption = 'Change Contract No.';
                    Image = ChangeLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _ChangeContractNo: Report "DK_Change Contract No.";
                        _PayReceiptDoc: Record "DK_Payment Receipt Document";
                    begin
                        if Rec.IDX <> 0 then
                            Error(MSG010);

                        Rec.CalcFields("Litigation Bank Account");

                        if Rec."Contract No." = '' then
                            Error(MSG004, Rec.FieldCaption("Contract No."));

                        Rec.CalcFields(Refund);
                        if Rec.Refund then begin
                            _PayReceiptDoc.Reset;
                            _PayReceiptDoc.SetRange("Document Type", _PayReceiptDoc."Document Type"::Refund);
                            _PayReceiptDoc.SetRange("Target Doc. No.", Rec."Document No.");
                            if _PayReceiptDoc.FindSet then begin
                                if _PayReceiptDoc.Posted then
                                    Error(MSG006, _PayReceiptDoc."Document No.")
                                else
                                    Error(MSG005, _PayReceiptDoc."Document No.");
                            end;
                        end;

                        if Rec."Litigation Bank Account" then
                            Error(MSG003);

                        Clear(_ChangeContractNo);
                        _ChangeContractNo.SetParameter(Rec."Contract No.");
                        _ChangeContractNo.RunModal;

                        CurrPage.Update;
                    end;
                }
                action("Create Refund Document")
                {
                    Caption = 'Create Refund Document';
                    Image = CreateCreditMemo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _PayRefundDoc: Page "DK_Payment Refund Document";
                        _PayReceiptDoc: Record "DK_Payment Receipt Document";
                    begin
                        //˜»Š­ ‰«Œ¡ ‹²ŒŠ
                        if Rec.IDX <> 0 then
                            Error(MSG010);
                        Rec.CalcFields("Refund Document No.", "Line Contact Amount");

                        if Rec."Refund Document No." <> '' then
                            Error(MSG008, Rec.FieldCaption("Refund Document No."), Rec."Refund Document No.");

                        if Rec."Line Contact Amount" then
                            Error(MSG007);

                        _PayReceiptDoc.Init;
                        _PayReceiptDoc.Validate("Document Type", _PayReceiptDoc."Document Type"::Refund);
                        _PayReceiptDoc.Validate("Document No.", '');
                        _PayReceiptDoc.Validate("Target Doc. No.", Rec."Document No.");
                        _PayReceiptDoc.Insert(true);

                        _PayRefundDoc.SetTableView(_PayReceiptDoc);
                        _PayRefundDoc.SetRecord(_PayReceiptDoc);
                        _PayRefundDoc.Run;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin

        //Cancel Posted Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Cancel Pay. Rece. Admin.", true);
        if _UserSetup.FindSet then
            CancelPosted := true
        else
            CancelPosted := false;
    end;

    var
        MSG001: Label 'Do you really want to cancel?';
        MSG002: Label 'This Function is only available to Permission users. Please contact your administrator.';
        MSG003: Label 'You can not use the Change Contract No. Function for Payment Receipt Document.';
        MSG004: Label '%1 is not specified. Contract No. change function is not available.';
        MSG005: Label 'This Document is currently in the process of refunding. Refund Document No.: %1';
        MSG006: Label 'This Document is currently in the process of refunded. Refund Document No.: %1';
        MSG007: Label 'You can not create a Refund Document for this posted Payment Receipt Document.';
        MSG008: Label 'This posted Payment Receipt document has been created with a refund document. Please use the refund document Show function for details. %1:%2';
        MSG009: Label 'There is no Refund Documentassociated with this posted Payment Receipt Document.';
        MSG010: Label 'This document is the opening data. This feature is not available.';
        CancelPosted: Boolean;
        MSG011: Label 'This posted payment document has been automatically Payment Receipt the due payment document. You cannot cancel the Posted. %1:%2';

    local procedure AdminExpensePaymentRun()
    var
        _AdminExpPaymentCofirm: Report "DK_Admin. Exp. Payment Cofirm";
    begin
        _AdminExpPaymentCofirm.SetParam(Rec."Document No.");
        _AdminExpPaymentCofirm.RunModal;
    end;
}

