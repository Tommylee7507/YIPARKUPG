page 50261 "DK_Sales User Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup("No. of Cemetery")
            {
                Caption = 'No. of Cemetery';
                field(Control3; Rec."No. of Cemetery")
                {
                }
            }
            cuegroup("No. of Unsold Cemetery1")
            {
                Caption = 'No. of Unsold Cemetery1';
                field("No. of Unsold Cemetery Conf1"; Rec."No. of Unsold Cemetery Conf1")
                {
                }
                field("No. of Unsold Cemetery Conf2"; Rec."No. of Unsold Cemetery Conf2")
                {
                }
                field("No. of Unsold Cemetery Conf3"; Rec."No. of Unsold Cemetery Conf3")
                {
                }
            }
            cuegroup("No. of Unsold Cemetery2")
            {
                Caption = 'No. of Unsold Cemetery2';
                field("No. of Unsold Cemetery Conf4"; Rec."No. of Unsold Cemetery Conf4")
                {
                }
                field("No. of Unsold Cemetery Conf5"; Rec."No. of Unsold Cemetery Conf5")
                {
                }
                field("No. of Unsold Cemetery Conf6"; Rec."No. of Unsold Cemetery Conf6")
                {
                }
                field("No. of Unsold Cemetery Conf7"; Rec."No. of Unsold Cemetery Conf7")
                {
                }
            }
            cuegroup(Contract)
            {
                Caption = 'Contract';
                field("No. of Open Contract"; Rec."No. of Open Contract")
                {

                    trigger OnDrillDown()
                    begin
                        Contract.Reset;
                        Contract.SetRange(Status, Contract.Status::Open);

                        Clear(SalesContractList);
                        SalesContractList.LookupMode(true);
                        SalesContractList.SetTableView(Contract);
                        SalesContractList.SetRecord(Contract);
                        SalesContractList.Run;
                    end;
                }
                field("No. of Reserv. Contract"; Rec."No. of Reserv. Contract")
                {
                    Caption = 'No. of Reservation Contract';

                    trigger OnDrillDown()
                    begin
                        Contract.Reset;
                        Contract.SetRange(Status, Contract.Status::Revocation);

                        Clear(SalesContractList);
                        SalesContractList.LookupMode(true);
                        SalesContractList.SetTableView(Contract);
                        SalesContractList.SetRecord(Contract);
                        SalesContractList.Run;
                    end;
                }
                field("No. of Temp. Contract"; Rec."No. of Temp. Contract")
                {
                    Caption = 'No. of Temporary Contract';

                    trigger OnDrillDown()
                    begin
                        Contract.Reset;
                        Contract.SetRange(Status, Contract.Status::Contract);

                        Clear(SalesContractList);
                        SalesContractList.LookupMode(true);
                        SalesContractList.SetTableView(Contract);
                        SalesContractList.SetRecord(Contract);
                        SalesContractList.Run;
                    end;
                }
                field("No. of Overdue Bal. Cont."; Rec."No. of Overdue Bal. Cont.")
                {

                    trigger OnDrillDown()
                    begin
                        Contract.Reset;
                        Contract.SetRange(Status, Contract.Status::Contract);
                        Contract.SetFilter("Pay. Remaining Amount", '<>0');
                        Contract.SetFilter("Remaining Due Date", '<%1', WorkDate);

                        Clear(SalesContractList);
                        SalesContractList.LookupMode(true);
                        SalesContractList.SetTableView(Contract);
                        SalesContractList.SetRecord(Contract);
                        SalesContractList.Run;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Date Filter", '<%1', WorkDate);
        Rec.FilterGroup(0);
    end;

    var
        SalesContractList: Page "DK_Sales Contract List";
        Contract: Record DK_Contract;
}

