page 50095 "DK_Contract Detail Factbox"
{
    Caption = 'Contract Detail';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = DK_Contract;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                LookupPageID = "DK_Contract Card";

                trigger OnDrillDown()
                var
                    _ContractCard: Page "DK_Contract Card";
                    _Contract: Record DK_Contract;
                begin
                    if _Contract.Get(Rec."No.") then begin

                        Clear(_ContractCard);
                        _ContractCard.LookupMode(true);
                        _ContractCard.SetTableView(_Contract);
                        _ContractCard.SetRecord(_Contract);
                        _ContractCard.Run;
                    end;
                end;
            }
            field("Contract Date"; Rec."Contract Date")
            {
            }
            field("Revocation Date"; Rec."Revocation Date")
            {
            }
            field("Contract Type"; Rec."Contract Type")
            {
            }
            field("Group Contract No."; Rec."Group Contract No.")
            {
            }
            field("Supervise No."; Rec."Supervise No.")
            {
            }
            field("Estate Name"; Rec."Estate Name")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Estate Type"; Rec."Estate Type")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cemetery No."; Rec."Cemetery No.")
            {
            }
            field("Cemetery Size"; Rec."Cemetery Size")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Main Customer No."; Rec."Main Customer No.")
            {
            }
            field("Main Customer Name"; Rec."Main Customer Name")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cemetery Class"; Rec."Cemetery Class")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Management Unit"; Rec."Management Unit")
            {
            }
            field(Status; Rec.Status)
            {
            }
            field("Admin. Expense Method"; Rec."Admin. Expense Method")
            {
            }
            field("Admin. Expense Option"; Rec."Admin. Expense Option")
            {
            }
            field("Admin. Exp. Start Date"; Rec."Admin. Exp. Start Date")
            {
            }
            field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
            {
            }
            field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
            {
            }
            field("General Expiration Date"; Rec."General Expiration Date")
            {
            }
            field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
            {
            }
            field("Payment Amount"; Rec."Payment Amount")
            {
            }
            field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
            {
            }
            field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
            {

                trigger OnDrillDown()
                begin
                    Rec.OpenAdminExpeseLedger(0);
                end;
            }
            field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
            {

                trigger OnDrillDown()
                begin
                    Rec.OpenAdminExpeseLedger(1);
                end;
            }
            field("Cust. Mobile No."; Rec."Cust. Mobile No.")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cust. Phone No."; Rec."Cust. Phone No.")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cust. E-Mail"; Rec."Cust. E-Mail")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cust. Address"; Rec."Cust. Address")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Cust. Address 2"; Rec."Cust. Address 2")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Customer Name 2"; Rec."Customer Name 2")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Customer Name 3"; Rec."Customer Name 3")
            {
                AssistEdit = false;
                DrillDown = false;
                Lookup = false;
            }
            field("Remaining Due Date"; Rec."Remaining Due Date")
            {
            }
            field("No. of Corpse"; Rec."No. of Corpse")
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Estate Name");
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("Date Filter", 0D, Today);
    end;
}

