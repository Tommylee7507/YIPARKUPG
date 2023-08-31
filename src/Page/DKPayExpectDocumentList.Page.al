page 50171 "DK_Pay. Expect Document List"
{
    Caption = 'Payment Expect Document List';
    CardPageID = "DK_Pay. Expect Document";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Pay. Expect Doc. Header";
    SourceTableView = SORTING("Document No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("VA Process Status"; Rec."VA Process Status")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Last SMS Sent Date"; Rec."Last SMS Sent Date")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Virtual Account No."; Rec."Virtual Account No.")
                {
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Assgin Date"; Rec."Assgin Date")
                {
                }
                field("UnAssgin Date"; Rec."UnAssgin Date")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Account Holder"; Rec."Account Holder")
                {
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("PG URL"; Rec."PG URL")
                {
                }
                field("PG Approval No."; Rec."PG Approval No.")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Importance = Additional;
                }
                field("Payment Method Name"; Rec."Payment Method Name")
                {
                }
                field("Payment Remark"; Rec."Payment Remark")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Pay. Receipt Doc. No."; Rec."Pay. Receipt Doc. No.")
                {
                }
                field("Pay. Receipt Doc. Posted"; Rec."Pay. Receipt Doc. Posted")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Issued Cash Receipts"; Rec."Issued Cash Receipts")
                {
                }
                field("Issued Cash Rec. Mobile"; Rec."Issued Cash Rec. Mobile")
                {
                }
                field("Cash Bill Approval No."; Rec."Cash Bill Approval No.")
                {
                }
                field("Line General Amount"; Rec."Line General Amount")
                {
                }
                field("Line Land. Arc. Amount"; Rec."Line Land. Arc. Amount")
                {
                }
                field("Line Contract Amount"; Rec."Line Contract Amount")
                {
                }
                field("Line Service Amount"; Rec."Line Service Amount")
                {
                }
                field("Line Deposit Amount"; Rec."Line Deposit Amount")
                {
                }
                field("Line Remaining Amount"; Rec."Line Remaining Amount")
                {
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
            }
        }
        area(factboxes)
        {
            part(Control38; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            part(Control34; "DK_Pay. Expect Pro. His. Factb")
            {
                SubPageLink = "Pay. Expect Doc. No." = FIELD("Document No.");
            }
            systempart(Control18; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Result")
            {
                Caption = 'Update Result';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _BatchReceiptedPGVA: Codeunit "DK_Batch Receipted PG/VA";
                begin

                    Clear(_BatchReceiptedPGVA);
                    _BatchReceiptedPGVA.Run;

                    Message(MSG016);
                end;
            }
            separator(Action54)
            {
            }
            action("Sended SMS History")
            {
                Caption = 'Sended SMS History';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Sended SMS History";
                RunPageLink = "Source Type" = FILTER(PaymentExpectPG | PaymentExpectVA),
                              "Source No." = FIELD("Document No.");
            }
            action("PG Payment History")
            {
                Caption = 'PG Payment History';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Receipted PG Document";
                RunPageLink = "Payment Type" = FILTER(PG | DirectPG),
                              "Pay. Expect Doc No." = FIELD("Document No.");
            }
            action("Virtual Account Error Log")
            {
                Caption = 'Virtual Account Error Log';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    _VAErrorLog: Page "DK_Virtual Account Error Log";
                begin
                    //í‹ÝÐ‘’ í‡» ‡ž€¸
                    if Rec."Payment Type" <> Rec."Payment Type"::VA then
                        Error(MSG013, Rec."Payment Type", Rec."Payment Type"::VA);

                    if Rec."Virtual Account No." = '' then
                        Error(MSG014, Rec.FieldCaption("Virtual Account No."));

                    if Rec."Assgin Date" = 0D then
                        Error(MSG015, Rec.FieldCaption("Assgin Date"));

                    Clear(_VAErrorLog);
                    _VAErrorLog.SetParameter(Rec."Assgin Date", Rec."Virtual Account No.");
                    _VAErrorLog.RunModal;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("VA Status");
    end;

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;

    var
        MSG013: Label 'This function is available when %1 is %2.';
        MSG014: Label '%1 does not exist.';
        MSG015: Label 'This Payment Expect Document has not been Assignment a virtual account.';
        MSG016: Label 'Complate Update!';
}

