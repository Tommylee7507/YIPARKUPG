page 50245 "DK_Customer Request Fact. List"
{
    Caption = 'Customer Request Fact. List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Customer Requests";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Date"; Rec."Receipt Date")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _CustomerRequests: Record "DK_Customer Requests";
                        _CustomerRequestCard: Page "DK_Customer Request Card";
                    begin

                        _CustomerRequests.SetRange("Contract No.", Rec."Contract No.");

                        Clear(_CustomerRequestCard);
                        _CustomerRequestCard.LookupMode(true);
                        _CustomerRequestCard.SetTableView(_CustomerRequests);
                        _CustomerRequestCard.SetRecord(_CustomerRequests);
                        _CustomerRequestCard.RunModal;
                    end;
                }
                field("Receipt Contents"; Rec."Receipt Contents")
                {
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Detail)
            {
                Caption = 'Detail';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _CustomerRequests: Record "DK_Customer Requests";
                    _CustomerRequestCard: Page "DK_Customer Request Card";
                begin
                    _CustomerRequests.SetRange("Contract No.", Rec."Contract No.");

                    Clear(_CustomerRequestCard);
                    _CustomerRequestCard.LookupMode(true);
                    _CustomerRequestCard.SetTableView(_CustomerRequests);
                    _CustomerRequestCard.SetRecord(_CustomerRequests);
                    _CustomerRequestCard.RunModal;
                end;
            }
        }
    }
}

