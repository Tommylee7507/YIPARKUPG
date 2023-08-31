page 50146 "DK_Posted Rev. Contract Card"
{
    // *DK33 : 20200730
    //   - Add Field : "Estate Type"
    // 
    // #2092 : 20200812
    //   - Add Action : ChangeDocument
    //   - Add Variables : ChangeDocVisible
    //   - Add Function : CheckChangeDocVisible
    //   - Rec. Modify Trigger : OnAfterGetRecord

    Caption = 'Posted Revocation Contract Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Revocation Contract";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Contract No." <> Rec."Contract No." then
                            WorkContents := '';
                    end;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
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
                field("Estate Type"; Rec."Estate Type")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Contract Type"; Rec."Contract Type")
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
                field("First Laying Date"; Rec."First Laying Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Revocation Employee No."; Rec."Revocation Employee No.")
                {
                    Importance = Additional;
                }
                field("Revocation Employee Name"; Rec."Revocation Employee Name")
                {
                }
                field("Run Refund Calculation"; Rec."Run Refund Calculation")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
                group("Revocation Contents")
                {
                    Caption = 'Revocation Contents';
                    field(WorkContents; WorkContents)
                    {
                        Editable = false;
                        MultiLine = true;
                        ShowMandatory = false;

                        trigger OnValidate()
                        begin
                            Rec.SetWorkContents(WorkContents);
                        end;
                    }
                }
            }
            group(Revocation)
            {
                Caption = 'Revocation';
                group("System Refund")
                {
                    Caption = 'System Refund';
                    field("Refund Rate"; Rec."Refund Rate")
                    {
                        Editable = false;
                    }
                    field("Sales Rev. Amount"; Rec."Sales Rev. Amount")
                    {
                    }
                    field("Sys. Refund Cemetery Amount"; Rec."Sys. Refund Cemetery Amount")
                    {
                        Caption = 'Cemetery Amount';
                    }
                    field("Sys. Refund Bury Amount"; Rec."Sys. Refund Bury Amount")
                    {
                        Caption = 'Bury Amount';
                    }
                    field("Sys. Refund General Amount"; Rec."Sys. Refund General Amount")
                    {
                        Caption = 'General Amount';
                    }
                    field("Sys. Refund Land. Arc. Amount"; Rec."Sys. Refund Land. Arc. Amount")
                    {
                        Caption = 'Landscape Architecture Amount';
                    }
                    field("System Refund Amount"; Rec."System Refund Amount")
                    {
                        Caption = 'Total Refund Amount';
                    }
                }
                group("Apply Refund")
                {
                    Caption = 'Apply Refund';
                    field("Refund Cemetery Amount"; Rec."Refund Cemetery Amount")
                    {
                        Caption = 'Cemetery Amount';
                    }
                    field("Refund Bury Amount"; Rec."Refund Bury Amount")
                    {
                        Caption = 'Bury Amount';
                    }
                    field("Refund General Amount"; Rec."Refund General Amount")
                    {
                        Caption = 'General Amount';
                    }
                    field("Refund Land. Arc. Amount"; Rec."Refund Land. Arc. Amount")
                    {
                        Caption = 'Landscape Architecture Amount';
                    }
                    field("Apply Refund Amount"; Rec."Apply Refund Amount")
                    {
                        AssistEdit = false;
                        Caption = 'Total Refund Amount';
                        DrillDown = false;
                        Lookup = false;
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                    field(Reason; Rec.Reason)
                    {
                    }
                    field("Refund Starting Date"; Rec."Refund Starting Date")
                    {
                        Importance = Additional;
                    }
                }
                group("Refund Card")
                {
                    Caption = 'Refund Card';
                    field("Payment Card Infor."; Rec."Payment Card Infor.")
                    {
                        MultiLine = true;
                    }
                    field("Cancel Pay. Card Amount"; Rec."Cancel Pay. Card Amount")
                    {
                    }
                }
                group("Refund Bank")
                {
                    Caption = 'Refund Bank';
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
                }
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                field("Contract Status"; Rec."Contract Status")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
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
            part(Control46; "DK_Post Req. Doc. Rec. Factbox")
            {
                SubPageLink = "Table ID" = CONST(50089),
                              "Source No." = FIELD("Document No.");
            }
            part(Control15; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Payment Refund Bill")
            {
                Caption = 'Payment Refund Bill';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    RunPaymentRefundBill;
                end;
            }
            separator(Action70)
            {
            }
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
                    DK_ChangePostedRevContract: Report "DK_Change Posted Rev. Contract";
                begin

                    Clear(DK_ChangePostedRevContract);
                    DK_ChangePostedRevContract.SetRevContract(Rec);
                    DK_ChangePostedRevContract.RunModal;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WorkContents := Rec.GetWorkContents;

        // >> #2092
        CheckChangeDocVisible;
        // <<
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Date" := WorkDate;
    end;

    var
        WorkContents: Text;
        MSG001: Label 'Calculation is complete.';
        ChangeDocVisible: Boolean;

    local procedure RunPaymentRefundBill()
    var
        _PaymentRefundBill: Report "DK_Payment Refund Bill";
    begin

        _PaymentRefundBill.SetParam(Rec."Document No.");
        _PaymentRefundBill.RunModal;
    end;

    local procedure CheckChangeDocVisible()
    var
        _UserSetup: Record "User Setup";
    begin

        ChangeDocVisible := false;

        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Cancel Pay. Rece. Admin.", true);
        if _UserSetup.FindSet then
            ChangeDocVisible := true;
    end;
}

