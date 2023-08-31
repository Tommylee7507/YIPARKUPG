page 50140 "DK_Publish Admin. Exp. Subform"
{
    Caption = 'Publish Admin. Exp. Line';
    CardPageID = "DK_Publish Ad. Exp. Line Detai";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Publish Admin. Exp. Doc. Li";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Print Select"; Rec."Print Select")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    StyleExpr = StyleTxt;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Check Customer Infor."; Rec."Check Customer Infor.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Check Cust. User ID"; Rec."Check Cust. User ID")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Check Cust. DateTime"; Rec."Check Cust. DateTime")
                {
                    StyleExpr = StyleTxt;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    StyleExpr = StyleTxt;
                }
                field("General Amount"; Rec."General Amount")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Non-Payment From Date 1"; Rec."Non-Payment From Date 1")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Prepayment From Date 1"; Rec."Prepayment From Date 1")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Prepayment To Date 1"; Rec."Prepayment To Date 1")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Non-Payment From Date 2"; Rec."Non-Payment From Date 2")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Prepayment From Date 2"; Rec."Prepayment From Date 2")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Prepayment To Date 2"; Rec."Prepayment To Date 2")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Payment Due Date"; Rec."Payment Due Date")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Account Code"; Rec."Account Code")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    StyleExpr = StyleTxt;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    StyleExpr = StyleTxt;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    StyleExpr = StyleTxt;
                }
                field("Account Holder"; Rec."Account Holder")
                {
                    StyleExpr = StyleTxt;
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field(System; Rec.System)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Custmer Card")
            {
                Caption = 'Custmer Card';
                Enabled = Rec."Customer No." <> '';
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Customer Card";
                RunPageLink = "No." = FIELD("Customer No.");
                Visible = false;
            }
            action("Select All")
            {
                Caption = 'Select All';
                Image = ChangeToLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Select All
                    SetSelectPrint(true);
                end;
            }
            action("UnSelect All")
            {
                Caption = 'UnSelect All';
                Image = CancelAllLines;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    //UnSelect All
                    SetSelectPrint(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Check Customer Infor." then
            StyleTxt := 'StandardAccent'
        else
            StyleTxt := '';
    end;

    var
        StyleTxt: Text[30];

    local procedure SetSelectPrint(pSelect: Boolean)
    var
        _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
    begin

        CurrPage.SetSelectionFilter(_PublishAdminExpDocLine);
        if _PublishAdminExpDocLine.FindSet then begin
            repeat

                if pSelect then begin
                    if _PublishAdminExpDocLine."Check Customer Infor." then begin
                        _PublishAdminExpDocLine."Print Select" := pSelect;
                        _PublishAdminExpDocLine.Modify;
                    end;
                end else begin
                    _PublishAdminExpDocLine."Print Select" := pSelect;
                    _PublishAdminExpDocLine.Modify;
                end;

            until _PublishAdminExpDocLine.Next = 0;
        end;

        CurrPage.Update;
    end;
}

