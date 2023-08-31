page 50048 "DK_Detail Publish Ad. Ex. List"
{
    Caption = 'Publish Admin. Expense';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Publish Admin. Exp. Doc. Li";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
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
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    Editable = false;
                }
                field("Check Customer Infor."; Rec."Check Customer Infor.")
                {
                }
                field("Check Cust. User ID"; Rec."Check Cust. User ID")
                {
                }
                field("Check Cust. DateTime"; Rec."Check Cust. DateTime")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
                {
                    Editable = false;
                }
                field("General Amount"; Rec."General Amount")
                {
                }
                field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
                {
                    Editable = false;
                }
                field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                {
                }
                field("Non-Payment From Date 1"; Rec."Non-Payment From Date 1")
                {
                    Editable = false;
                }
                field("Prepayment From Date 1"; Rec."Prepayment From Date 1")
                {
                    Editable = false;
                }
                field("Prepayment To Date 1"; Rec."Prepayment To Date 1")
                {
                }
                field("Non-Payment From Date 2"; Rec."Non-Payment From Date 2")
                {
                    Editable = false;
                }
                field("Prepayment From Date 2"; Rec."Prepayment From Date 2")
                {
                }
                field("Prepayment To Date 2"; Rec."Prepayment To Date 2")
                {
                    Editable = false;
                }
                field("Payment Due Date"; Rec."Payment Due Date")
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
            action("Publish Admin. Expense")
            {
                Caption = 'Publish Admin. Expense';
                Image = VendorBill;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _PublishAdExpLineDetail: Page "DK_Publish Ad. Exp. Line Detai";
                    _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
                begin

                    _PublishAdminExpDocLine.SetRange("Document No.", Rec."Document No.");
                    _PublishAdminExpDocLine.SetRange("Line No.", Rec."Line No.");

                    if _PublishAdminExpDocLine.FindSet then begin
                        Clear(_PublishAdExpLineDetail);
                        _PublishAdExpLineDetail.LookupMode(true);
                        _PublishAdExpLineDetail.SetTableView(_PublishAdminExpDocLine);
                        _PublishAdExpLineDetail.SetRecord(_PublishAdminExpDocLine);
                        _PublishAdExpLineDetail.Editable(false);
                        _PublishAdExpLineDetail.RunModal
                    end else
                        Error(MSG001);
                end;
            }
        }
    }

    var
        MSG001: Label 'Related data does not exist.';
}

