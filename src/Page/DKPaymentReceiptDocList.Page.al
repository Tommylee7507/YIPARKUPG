page 50132 "DK_Payment Receipt Doc. List"
{
    // 
    // DK34: 20201117
    //   - Add Field: "Department Code", "Department Name"

    Caption = 'Payment Receipt Document List';
    CardPageID = "DK_Payment Receipt Document";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Payment Receipt Document";
    SourceTableView = SORTING("Document Type", "Document No.")
                      ORDER(Descending)
                      WHERE(Posted = CONST(false),
                            "Document Type" = CONST(Receipt));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {

                    trigger OnValidate()
                    begin

                        //IF Rec."Payment Type" = Rec."Payment Type"::DebtRelief THEN
                        //MESSAGE(MSG008, Rec."Payment Type", FIELDCAPTION("Debt Relief Amount"));
                    end;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Final Amount"; Rec."Final Amount")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Line General Start Date"; Rec."Line General Start Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line General Expiration Date"; Rec."Line General Expiration Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line General Amount"; Rec."Line General Amount")
                {
                    AssistEdit = false;
                    BlankZero = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Land. Arc. Start Date"; Rec."Line Land. Arc. Start Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Land. Arc. Exp. Date"; Rec."Line Land. Arc. Exp. Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Land. Arc. Amount"; Rec."Line Land. Arc. Amount")
                {
                    AssistEdit = false;
                    BlankZero = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Deposit Amount"; Rec."Line Deposit Amount")
                {
                    AssistEdit = false;
                    BlankZero = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Contract Amount"; Rec."Line Contract Amount")
                {
                    AssistEdit = false;
                    BlankZero = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Remaining Amount"; Rec."Line Remaining Amount")
                {
                    AssistEdit = false;
                    BlankZero = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Line Service Amount"; Rec."Line Service Amount")
                {
                    AssistEdit = false;
                    BlankZero = true;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Depositor; Rec.Depositor)
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("Before Document No."; Rec."Before Document No.")
                {

                    trigger OnDrillDown()
                    begin
                        Rec.ShowPostedPaymentDocument(Rec."Before Document No.");
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Payment Method Name"; Rec."Payment Method Name")
                {
                }
                field("Bank Account Code"; Rec."Bank Account Code")
                {
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
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
                field("Card Approval No."; Rec."Card Approval No.")
                {
                }
                field("Virtual Account No."; Rec."Virtual Account No.")
                {
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
                {
                }
                field("Issued TAX Bill"; Rec."Issued TAX Bill")
                {
                }
                field("Issued TAX Bill Date"; Rec."Issued TAX Bill Date")
                {
                }
                field("Missing Contract"; Rec."Missing Contract")
                {
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
                    Visible = false;
                }
                field("Litigation Employee Name"; Rec."Litigation Employee Name")
                {
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Visible = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Litigation Evaluation"; Rec."Litigation Evaluation")
                {
                }
                field(Litigation; Rec.Litigation)
                {
                }
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
                field("MTG Amount"; Rec."MTG Amount")
                {
                }
                field("Move The Grave"; Rec."Move The Grave")
                {
                }
                field("Reduction Amount"; Rec."Reduction Amount")
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
                }
                field("Cemetery Code"; Rec."Cemetery Code")
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
            }
        }
        area(factboxes)
        {
            part(Control29; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

