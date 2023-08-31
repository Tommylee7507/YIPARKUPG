page 50232 "DK_Request Remittance Factbox"
{
    Caption = 'Request Remittance Factbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Request Remittance Ledger";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("GroupWare Doc. No."; Rec."GroupWare Doc. No.")
                {
                }
                field("Request Payment Date"; Rec."Request Payment Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Cancel Pay. Card Amount"; Rec."Cancel Pay. Card Amount")
                {
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Bank Account Holder"; Rec."Bank Account Holder")
                {
                }
                field("Payment Card Infor."; Rec."Payment Card Infor.")
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
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Released)
            {
                Caption = 'Released';
                Image = ReleaseDoc;
                action(Complate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Complete';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        _ReqRemLedger: Record "DK_Request Remittance Ledger";
                    begin
                        CurrPage.SetSelectionFilter(_ReqRemLedger);

                        if _ReqRemLedger.FindFirst then begin
                            repeat
                                _ReqRemLedger.SetCompleted;
                            until _ReqRemLedger.Next = 0;

                            Message(MSG001, _ReqRemLedger.Status::Completed);

                        end;
                    end;
                }
                action(Cancel)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel';
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        _ReqRemLedger: Record "DK_Request Remittance Ledger";
                    begin
                        CurrPage.SetSelectionFilter(_ReqRemLedger);

                        if _ReqRemLedger.FindFirst then begin
                            repeat
                                _ReqRemLedger.SetCanceled;
                            until _ReqRemLedger.Next = 0;

                            Message(MSG001, _ReqRemLedger.Status::Canceled);

                        end;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _ReqRemLedger: Record "DK_Request Remittance Ledger";
                    begin
                        CurrPage.SetSelectionFilter(_ReqRemLedger);

                        if _ReqRemLedger.FindFirst then begin
                            repeat
                                _ReqRemLedger.SetReOpen;
                            until _ReqRemLedger.Next = 0;
                            Message(MSG001, _ReqRemLedger.Status::Open);
                        end;
                    end;
                }
            }
            group(Document)
            {
                Caption = 'Document';
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = ViewDocumentLine;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.ShowDocument;
                    end;
                }
                action("Show Request Remittance Ledger")
                {
                    Caption = 'Show Request Remittance Ledger';
                    Image = InsuranceLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;

    var
        MSG001: Label 'Status change completed. Current Status:%1';
}

