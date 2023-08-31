page 50243 "DK_Customer Certficate History"
{
    Caption = 'Customer Certficate History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Customer Certficate History";
    SourceTableView = ORDER(Descending)
                      WHERE(Apprval = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
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
                field("Contract Status"; Rec."Contract Status")
                {
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                }
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
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
                    _CustomerCertficateHistory: Record "DK_Customer Certficate History";
                    _CustomerCertficateHistoryCodeUnit: Codeunit "DK_Customer Certficate History";
                begin

                    CurrPage.SetSelectionFilter(_CustomerCertficateHistory);
                    if _CustomerCertficateHistory.FindSet then begin
                        repeat
                            _CustomerCertficateHistoryCodeUnit.Approval(_CustomerCertficateHistory);
                        until _CustomerCertficateHistory.Next = 0;
                    end;
                    CurrPage.Update;
                end;
            }
            separator(Action25)
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
                RunPageLink = "No." = FIELD("Contract No.");
            }
        }
    }
}

