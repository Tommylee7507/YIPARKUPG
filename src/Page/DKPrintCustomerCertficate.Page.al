page 50204 "DK_Print Customer Certficate"
{
    Caption = 'Allow Membership Printing';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = DK_Contract;
    SourceTableView = WHERE("Allow Membership Printing" = CONST(false),
                            Status = CONST(FullPayment),
                            "Pay. Remaining Amount" = CONST(0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                    Visible = false;
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                }
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
                    Visible = false;
                }
                field("Pay. Contract Rece. Date"; Rec."Pay. Contract Rece. Date")
                {
                    Visible = false;
                }
                field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Printing Approval")
            {
                Caption = 'Printing Approval';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                begin

                    CurrPage.SetSelectionFilter(_Contract);

                    if _Contract.FindSet then begin
                        if not Confirm(MSG002, false, _Contract.Count) then
                            exit;
                        repeat
                            _Contract.Validate("Allow Membership Printing", true);
                            _Contract.Modify;
                        until _Contract.Next = 0;
                        CurrPage.Update;
                    end else begin
                        Error(MSG001);
                    end;
                end;
            }
            separator(Action14)
            {
            }
            action("Show Contract")
            {
                Caption = 'Show Contract';
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Contract Card";
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }

    var
        MSG001: Label 'The selected contract does not exist.';
        MSG002: Label 'Do you want to allow membership card Print? Contrants : %1';
}

