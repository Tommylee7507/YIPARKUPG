page 50203 "DK_Posted Pay. Refund Document"
{
    // 
    // DK34: 20201201
    //   - Add Field: "Department Code", "Department Name"

    Caption = 'Posted Payment Refund Document';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Payment Receipt Document";
    SourceTableView = WHERE(Posted = CONST(true),
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
                        Rec.CalcFields("Litigation Bank Account");

                        LitigationVisible := Rec."Litigation Bank Account";
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
                field(Correction; Rec.Correction)
                {
                }
                field("Request Refund Date"; Rec."Request Refund Date")
                {
                }
                field("Refund Reason"; Rec."Refund Reason")
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
                }
                field("Refund Bank Name"; Rec."Refund Bank Name")
                {
                }
                field("Refund Bank Account No."; Rec."Refund Bank Account No.")
                {
                }
                field("Refund Account Holder"; Rec."Refund Account Holder")
                {
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
                    group(Control69)
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
                    group(Control68)
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
            group(Action63)
            {
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
            }
            group(Action73)
            {
                action(ChangeDocument)
                {
                    Caption = 'Change Document';
                    Enabled = ChangeDocVisible;
                    Image = ChangeLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = ChangeDocVisible;

                    trigger OnAction()
                    var
                        _ChangePostedPayRef: Report "DK_Change Posted Pay. Ref";
                    begin

                        Clear(_ChangePostedPayRef);
                        _ChangePostedPayRef.SetPayRefundDoc(Rec);
                        _ChangePostedPayRef.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Litigation Bank Account");

        LitigationVisible := Rec."Litigation Bank Account";

        CheckChangeDocVisible;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Posting Date" := WorkDate;
        Rec."Document Time" := Time;
    end;

    var
        LitigationVisible: Boolean;
        ChangeDocVisible: Boolean;

    local procedure CheckChangeDocVisible()
    var
        _UserSetup: Record "User Setup";
    begin
        // ý€Ë…˜ ˜»Š­‰«Œ¡ Œ÷‘ñ €——© “Œ•

        ChangeDocVisible := false;

        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Cancel Pay. Rece. Admin.", true);
        if _UserSetup.FindSet then
            ChangeDocVisible := true;
    end;
}

