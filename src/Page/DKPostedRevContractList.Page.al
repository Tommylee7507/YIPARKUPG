page 50145 "DK_Posted Rev. Contract List"
{
    // *DK33 : 20200730
    //   - Add Field : "Estate Type"

    Caption = 'Posted Revocation Contract List';
    CardPageID = "DK_Posted Rev. Contract Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Revocation Contract";
    SourceTableView = SORTING("Document No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Complate));

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
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Estate Type"; Rec."Estate Type")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Revocation Employee Name"; Rec."Revocation Employee Name")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
                field("Revocation Date"; Rec."Revocation Date")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Giving Up"; Rec."Giving Up")
                {
                }
                field("Short Contents"; Rec."Short Contents")
                {
                    Caption = 'Contents';
                }
                field(Status; Rec.Status)
                {
                }
                field("Refund Rate"; Rec."Refund Rate")
                {
                }
                field("Sales Rev. Amount"; Rec."Sales Rev. Amount")
                {
                }
                field("Sys. Refund Cemetery Amount"; Rec."Sys. Refund Cemetery Amount")
                {
                }
                field("Sys. Refund Bury Amount"; Rec."Sys. Refund Bury Amount")
                {
                }
                field("Sys. Refund General Amount"; Rec."Sys. Refund General Amount")
                {
                }
                field("Sys. Refund Land. Arc. Amount"; Rec."Sys. Refund Land. Arc. Amount")
                {
                }
                field("System Refund Amount"; Rec."System Refund Amount")
                {
                }
                field("Refund Cemetery Amount"; Rec."Refund Cemetery Amount")
                {
                }
                field("Refund Bury Amount"; Rec."Refund Bury Amount")
                {
                }
                field("Refund General Amount"; Rec."Refund General Amount")
                {
                }
                field("Refund Land. Arc. Amount"; Rec."Refund Land. Arc. Amount")
                {
                }
                field("Apply Refund Amount"; Rec."Apply Refund Amount")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Payment Card Infor."; Rec."Payment Card Infor.")
                {
                }
                field("Cancel Pay. Card Amount"; Rec."Cancel Pay. Card Amount")
                {
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    Importance = Additional;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Account Holder"; Rec."Account Holder")
                {
                }
                field("Bank Request Amount"; Rec."Bank Request Amount")
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
            part(Control15; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            part(Control26; "DK_Post Req. Doc. Rec. Factbox")
            {
                SubPageLink = "Table ID" = CONST(50089),
                              "Source No." = FIELD("Document No.");
            }
            systempart(Control21; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;

    local procedure RunPaymentRefundBill()
    var
        _PaymentRefundBill: Report "DK_Payment Refund Bill";
    begin

        // _PaymentRefundBill.SetParam(Rec."Document No.");////zzz
        _PaymentRefundBill.RunModal;
    end;
}

