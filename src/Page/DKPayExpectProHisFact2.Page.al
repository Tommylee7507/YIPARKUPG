page 50178 "DK_Pay. Expect Pro. His. Fact2"
{
    Caption = 'Payment Expect Posting History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Pay. Expect Doc. Header";
    SourceTableView = SORTING("Payment Date")
                      ORDER(Descending)
                      WHERE(Status = FILTER(CustomerPayment | CreatePaymentReceipt));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Date"; Rec."Payment Date")
                {
                    StyleExpr = StyleTxt;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    StyleExpr = StyleTxt;
                }
                field("Payment Method Name"; Rec."Payment Method Name")
                {
                    StyleExpr = StyleTxt;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    StyleExpr = StyleTxt;
                }
                field(Status; Rec.Status)
                {
                    StyleExpr = StyleTxt;
                }
                field("Document No."; Rec."Document No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Pay. Receipt Doc. No."; Rec."Pay. Receipt Doc. No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Pay. Receipt Doc. Posted"; Rec."Pay. Receipt Doc. Posted")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    StyleExpr = StyleTxt;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    StyleExpr = StyleTxt;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Payment Expect Document")
            {
                Caption = 'Payment Expect Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Pay. Expect Document";
                RunPageLink = "Document No." = FIELD("Document No.");
                RunPageMode = View;
            }
            action("Payment Receipt Document")
            {
                Caption = 'Payment Receipt Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    _PayReceiptDoc: Record "DK_Payment Receipt Document";
                begin

                    _PayReceiptDoc.ShowPostedPaymentDocument(Rec."Pay. Receipt Doc. No.");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Payment Date" = Today then
            StyleTxt := 'Attention'
        else
            StyleTxt := '';
    end;

    trigger OnOpenPage()
    begin

        Rec.SetRange("Payment Date", CalcDate('<-1W>', Today), Today);
        if Rec.FindFirst then;
    end;

    var
        StyleTxt: Text[20];
}

