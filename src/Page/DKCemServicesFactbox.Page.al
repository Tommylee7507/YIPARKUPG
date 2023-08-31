page 50129 "DK_Cem. Services Factbox"
{
    Caption = 'Cemetery Services Factbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "DK_Cemetery Services";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {

                trigger OnDrillDown()
                var
                    _CemeteryServices: Record "DK_Cemetery Services";
                    _CemServicesCard: Page "DK_Cem. Services";
                    _PostedCemServicesCard: Page "DK_Posted Cem. Services";
                begin

                    if _CemeteryServices.Get(Rec."No.") then begin

                        if _CemeteryServices.Status <> _CemeteryServices.Status::Complete then begin
                            Clear(_CemServicesCard);
                            _CemServicesCard.LookupMode(true);
                            _CemServicesCard.SetTableView(_CemeteryServices);
                            _CemServicesCard.SetRecord(_CemeteryServices);
                            _CemServicesCard.Run;
                        end else begin
                            Clear(_PostedCemServicesCard);
                            _PostedCemServicesCard.LookupMode(true);
                            _PostedCemServicesCard.SetTableView(_CemeteryServices);
                            _PostedCemServicesCard.SetRecord(_CemeteryServices);
                            _PostedCemServicesCard.Run;
                        end;
                    end;
                end;
            }
            field("Receipt Date"; Rec."Receipt Date")
            {
            }
            field("Desired Date"; Rec."Desired Date")
            {
            }
            field("SMS Send Date"; Rec."SMS Send Date")
            {
            }
            field("Employee Name"; Rec."Employee Name")
            {
            }
            field(Religion; Rec.Religion)
            {
            }
            field("Payment Type"; Rec."Payment Type")
            {
            }
            field("Contract No."; Rec."Contract No.")
            {
            }
            field("Main Customer No."; Rec."Main Customer No.")
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
            field("Cemetery No."; Rec."Cemetery No.")
            {
            }
            field(Size; Rec.Size)
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Corpse Name"; Rec."Corpse Name")
            {
            }
            field(Remarks; Rec.Remarks)
            {
            }
            field("Work Division"; Rec."Work Division")
            {
            }
            field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
            {
            }
            field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
            {
            }
            field("Cost Amount"; Rec."Cost Amount")
            {
            }
            field(Unit; Rec.Unit)
            {
            }
            field(Description; Rec.Description)
            {
            }
            field(Quantity; Rec.Quantity)
            {
            }
            field(Amount; Rec.Amount)
            {
            }
        }
    }

    actions
    {
    }
}

