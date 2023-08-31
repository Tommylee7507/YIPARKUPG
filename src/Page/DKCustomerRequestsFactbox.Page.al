page 50078 "DK_Customer Requests Factbox"
{
    Caption = 'Customer Requests Factbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "DK_Customer Requests";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {

                trigger OnDrillDown()
                var
                    _CustomerRequestCard: Page "DK_Customer Request Card";
                    _CustomerRequests: Record "DK_Customer Requests";
                begin

                    if _CustomerRequests.Get(REc."No.") then begin

                        Clear(_CustomerRequestCard);
                        _CustomerRequestCard.LookupMode(true);
                        _CustomerRequestCard.SetTableView(_CustomerRequests);
                        _CustomerRequestCard.SetRecord(_CustomerRequests);
                        _CustomerRequestCard.Run;
                    end;
                end;
            }
            field("Contract No."; Rec."Contract No.")
            {
            }
            field("Employee No."; Rec."Employee No.")
            {
            }
            field("Employee name"; Rec."Employee name")
            {
            }
            field("Main Customer Name"; Rec."Main Customer Name")
            {
            }
            field("Cust. Mobile No."; Rec."Cust. Mobile No.")
            {
            }
            field("Appl. Name"; Rec."Appl. Name")
            {
            }
            field("Appl. Mobile No."; Rec."Appl. Mobile No.")
            {
            }
            field("Relationship With Cust."; Rec."Relationship With Cust.")
            {
            }
            field("Receipt Date"; Rec."Receipt Date")
            {
            }
            field("Receipt Contents"; Rec."Receipt Contents")
            {
            }
            field("Work Cemetery No."; Rec."Work Cemetery No.")
            {
            }
            field("Receipt Method"; Rec."Receipt Method")
            {
            }
            field("Receipt Division"; Rec."Receipt Division")
            {
            }
            field("Work Division"; Rec."Work Division")
            {
            }
            field("Process No."; Rec."Process No.")
            {
            }
            field("Process Date"; Rec."Process Date")
            {
            }
            field(Status; Rec.Status)
            {
            }
            field(Lawn; Rec.Lawn)
            {
            }
            field(Remarks; Rec.Remarks)
            {
            }
        }
    }

    actions
    {
    }
}

