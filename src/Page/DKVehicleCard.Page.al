page 50028 "DK_Vehicle Card"
{
    Caption = 'Vehicle Card';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Registration,Report(R)';
    SourceTable = DK_Vehicle;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control60)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                        Importance = Additional;

                        trigger OnAssistEdit()
                        begin
                            Rec.AssistEdit(Rec);
                        end;
                    }
                    field(Type; Rec.Type)
                    {

                        trigger OnValidate()
                        begin

                            if Rec.Type <> xRec.Type then begin
                                CostAmountVisible;
                                Rec."Cost Amount" := 0;
                            end
                        end;
                    }
                    field("Registration Date"; Rec."Registration Date")
                    {
                    }
                    field("Vehicle No."; Rec."Vehicle No.")
                    {
                    }
                    field("Purchase Contract No."; Rec."Purchase Contract No.")
                    {
                    }
                    field(Name; Rec.Name)
                    {
                    }
                    field(Price; Rec.Price)
                    {
                    }
                    field("Cost Amount"; Rec."Cost Amount")
                    {
                        Enabled = CostAVisible;
                    }
                }
                field(Handler; Rec.Handler)
                {
                }
                field(Division; Rec.Division)
                {
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Vehicle Type" <> Rec."Vehicle Type" then begin
                            if not CheckVehicleType then
                                ActivateFields;
                        end;
                    end;
                }
                field("Special Contract"; Rec."Special Contract")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Special Contract" <> Rec."Special Contract" then begin
                            if not CheckSpecialInfor then
                                ActivateFields;
                        end;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            group("Vehicle Information")
            {
                Caption = 'Vehicle Information';
                field(Model; Rec.Model)
                {
                }
                field("Model Year"; Rec."Model Year")
                {
                }
                field(Capacity; Rec.Capacity)
                {
                }
                field("Oil Type"; Rec."Oil Type")
                {
                }
                group(Control54)
                {
                    ShowCaption = false;
                    field("Inspection Date From"; Rec."Inspection Date From")
                    {
                    }
                    field("Inspection Date To"; Rec."Inspection Date To")
                    {
                    }
                }
                field("Standard Grade"; Rec."Standard Grade")
                {
                }
                field(Restrictions; Rec.Restrictions)
                {
                }
            }
            group("lease,lent Information")
            {
                Caption = 'lease,lent Information';
                Visible = leaseVisible;
                field(Term; Rec.Term)
                {
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                }
                field("Monthly Amount"; Rec."Monthly Amount")
                {
                }
            }
            group("Purchase Information")
            {
                Caption = 'Purchase Information';
                Visible = PurchVisible;
                field("Purchase Date"; Rec."Purchase Date")
                {
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                }
                field("Sale Date"; Rec."Sale Date")
                {
                }
                field("Closed Date"; Rec."Closed Date")
                {
                }
            }
            group("Special Contract Information")
            {
                Caption = 'Special Contract Information';
                field(Insurer; Rec.Insurer)
                {
                }
                field("Contract Date From"; Rec."Contract Date From")
                {
                }
                field("Insurance Date From"; Rec."Insurance Date From")
                {
                }
                field("Insurance Date To"; Rec."Insurance Date To")
                {
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control35; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Action55)
            {
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'It is a function to change the document of vehicle to the open Status.';

                    trigger OnAction()
                    begin
                        Rec.SetReOpen;
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Enabled = Rec.Status <> Rec.Status::Confirmation;
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'It is a function to release the document of vehicle.';

                    trigger OnAction()
                    begin
                        Rec.SetRelease;
                    end;
                }
                action(Sale)
                {
                    Caption = 'Sale';
                    Enabled = Rec.Status <> Rec.Status::Sale;
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'It is a function to sale the document of vehicle.';

                    trigger OnAction()
                    begin
                        Rec.SetSales;
                    end;
                }
                action(Exclusion)
                {
                    Caption = 'Exclusion';
                    Enabled = Rec.Status <> Rec.Status::Exclusion;
                    Image = CancelFALedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'It is a function to exclusion the document of vehicle.';

                    trigger OnAction()
                    begin
                        Rec.SetExclusion;
                    end;
                }
            }
            group(Registration)
            {
                Caption = 'Registration';
                action(Operation)
                {
                    Caption = 'Operation';
                    Enabled = Rec.Status = Rec.Status::Confirmation;
                    Image = Delivery;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "DK_Vehicle Operation";
                    RunPageMode = Create;
                    ToolTip = 'It is a function to input the operation record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleOper: Page "DK_Vehicle Operation";
                        _VehicleOperRec: Record "DK_Vehicle Led. Entry Header";
                    begin

                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);
                        /*
                        CLEAR(_VehicleOper);

                        _VehicleOperRec.INIT;
                        _VehicleOperRec."No." := '';
                        _VehicleOperRec.VALIDATE("Vehicle Document No.","No.");

                        _VehicleOper.LOOKUPMODE(TRUE);
                        _VehicleOper.SETTABLEVIEW(_VehicleOperRec);
                        _VehicleOper.RUNMODAL;*/

                    end;
                }
                action(Refueling)
                {
                    Caption = 'Refueling';
                    Enabled = Rec.Status = Rec.Status::Confirmation;
                    Image = UpdateShipment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "DK_Vehicle Refueling";
                    // RunPageLink = "Vehicle Document No." = FIELD("No.");////zzz
                    RunPageMode = Create;
                    ToolTip = 'It is a function to input the refueling record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleRefue: Page "DK_Vehicle Refueling";
                        _VehicleRefueRec: Record "DK_Vehicle Led. Entry Header";
                    begin

                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);
                        /*
                        CLEAR(_VehicleRefue);
                        
                        _VehicleRefueRec.INIT;
                        _VehicleRefueRec.SETRANGE("Vehicle Document No.", "No.");
                        
                        _VehicleRefue.LOOKUPMODE(TRUE);
                        _VehicleRefue.SETTABLEVIEW(_VehicleRefueRec);
                        _VehicleRefue.RUN;*/

                    end;
                }
                action(Repair)
                {
                    Caption = 'Repair';
                    Enabled = Rec.Status = Rec.Status::Confirmation;
                    Image = Tools;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "DK_Vehicle Repair";
                    // RunPageLink = "Vehicle Document No." = FIELD("No.");////zzz
                    RunPageMode = Create;
                    ToolTip = 'It is a function to input the repair record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleRepair: Page "DK_Vehicle Repair";
                        _VehicleRepairRec: Record "DK_Vehicle Led. Entry Header";
                    begin
                        /*
                        CLEAR(_VehicleRepair);
                        
                        _VehicleRepairRec.INIT;
                        _VehicleRepairRec.SETRANGE("Vehicle Document No.", "No.");
                        
                        _VehicleRepair.LOOKUPMODE(TRUE);
                        _VehicleRepair.SETTABLEVIEW(_VehicleRepairRec);
                        _VehicleRepair.RUN;*/

                    end;
                }
                action(Wash)
                {
                    Caption = 'Wash';
                    Enabled = Rec.Status = Rec.Status::Confirmation;
                    Image = SpecialOrder;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "DK_Vehicle Wash";
                    // RunPageLink = "Vehicle Document No." = FIELD("No.");////zzz
                    RunPageMode = Create;
                    ToolTip = 'It is a function to input the wash record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleWash: Page "DK_Vehicle Wash";
                        _VehicleWashRec: Record "DK_Vehicle Led. Entry Header";
                    begin

                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);

                        /*CLEAR(_VehicleWash);
                        
                        _VehicleWashRec.INIT;
                        _VehicleWashRec.SETRANGE("Vehicle Document No.", "No.");
                        
                        _VehicleWash.LOOKUPMODE(TRUE);
                        _VehicleWash.SETTABLEVIEW(_VehicleWashRec);
                        _VehicleWash.RUN;*/

                    end;
                }
            }
            group(Action45)
            {
                action("Operation Ledger Entry")
                {
                    Caption = 'Operation Ledger Entry';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'It is a function to see the input operation record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleOperationLedger: Page "DK_Vehicle Operation Ledger";
                        _VehicleOperRec: Record "DK_Vehicle Led. Entry Header";
                    begin
                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);

                        Clear(_VehicleOperationLedger);

                        _VehicleOperRec.SetRange("Vehicle Document No.", Rec."No.");

                        _VehicleOperationLedger.LookupMode(true);
                        _VehicleOperationLedger.SetTableView(_VehicleOperRec);
                        _VehicleOperationLedger.Run;
                    end;
                }
                action("Refueling Ledger Entry")
                {
                    Caption = 'Refueling Ledger Entry';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = CalculateShipment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'It is a function to see the input refueling record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleRefuelingLedger: Page "DK_Vehicle Refueling Ledger";
                        _VehicleRefuelingRec: Record "DK_Vehicle Led. Entry Header";
                    begin
                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);

                        Clear(_VehicleRefuelingLedger);

                        _VehicleRefuelingRec.SetRange("Vehicle Document No.", Rec."No.");

                        _VehicleRefuelingLedger.LookupMode(true);
                        _VehicleRefuelingLedger.SetTableView(_VehicleRefuelingRec);
                        _VehicleRefuelingLedger.Run;
                    end;
                }
                action("Repair Ledgr Entry")
                {
                    Caption = 'Repair Ledgr Entry';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ProjectToolsProjectMaintenance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'It is a function to see the input repair record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleRepairLedger: Page "DK_Vehicle Repair Ledger";
                        _VehicleRepairRec: Record "DK_Vehicle Led. Entry Header";
                    begin
                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);

                        Clear(_VehicleRepairLedger);

                        _VehicleRepairRec.SetRange("Vehicle Document No.", Rec."No.");

                        _VehicleRepairLedger.LookupMode(true);
                        _VehicleRepairLedger.SetTableView(_VehicleRepairRec);
                        _VehicleRepairLedger.Run;
                    end;
                }
                action("Wash Ledge Entry")
                {
                    Caption = 'Wash Ledge Entry';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = OrderList;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'It is a function to see the input wash record of the corresponding vehicle.';

                    trigger OnAction()
                    var
                        _VehicleWashLedger: Page "DK_Vehicle Wash Ledger";
                        _VehicleWashRec: Record "DK_Vehicle Led. Entry Header";
                    begin
                        if Rec.Type = Rec.Type::equipment then
                            Error(MSG003, Rec.Type::equipment);

                        Clear(_VehicleWashLedger);

                        _VehicleWashRec.SetRange("Vehicle Document No.", Rec."No.");

                        _VehicleWashLedger.LookupMode(true);
                        _VehicleWashLedger.SetTableView(_VehicleWashRec);
                        _VehicleWashLedger.Run;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin

        ActivateFields();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CostAmountVisible;
    end;

    trigger OnOpenPage()
    begin
        CostAmountVisible;
        ActivateFields();
    end;

    var
        InsurVisible: Boolean;
        MSG001: Label 'Special contract information exists. NonJoin,Nontarget the special contract information is initialized.\\Would you like to change it anyway?';
        MSG002: Label 'Purchase information exists. If you change to lease or rent, the information will be initialized.\\Would you like to change it anyway?';
        PurchVisible: Boolean;
        leaseVisible: Boolean;
        MSG003: Label 'You can not type in %1 type.';
        CostAVisible: Boolean;

    local procedure CheckSpecialInfor(): Boolean
    begin

        if (Rec.Insurer <> '') or
           (Rec."Contract Date From" <> 0D) or
           (Rec."Insurance Date From" <> 0D) or
           (Rec."Insurance Date To" <> 0D) then begin

            if not Confirm(MSG001, false) then begin
                Rec."Special Contract" := xRec."Special Contract";
                exit(true);
            end else begin
                Rec.Insurer := '';
                Rec."Contract Date From" := 0D;
                Rec."Insurance Date From" := 0D;
                Rec."Insurance Date To" := 0D;
            end;
        end;
    end;

    local procedure ActivateFields()
    begin
        if (Rec."Vehicle Type" = Rec."Vehicle Type"::New) or
          (Rec."Vehicle Type" = Rec."Vehicle Type"::Used) then begin
            PurchVisible := true;
            leaseVisible := false;
        end;

        if (Rec."Vehicle Type" = Rec."Vehicle Type"::lease) or
          (Rec."Vehicle Type" = Rec."Vehicle Type"::Rent) then begin
            PurchVisible := false;
            leaseVisible := true;
        end;
    end;

    local procedure CheckVehicleType(): Boolean
    begin
        case Rec."Vehicle Type" of
            Rec."Vehicle Type"::New, Rec."Vehicle Type"::Used:
                begin
                    if (Rec."Purchase Date" <> 0D) or
                       (Rec."Purchase Price" <> 0) or
                       (Rec."Sale Date" <> 0D) or
                       (Rec."Closed Date" <> 0D) then begin

                        if not Confirm(MSG002, false) then begin
                            Rec."Vehicle Type" := xRec."Vehicle Type";
                            exit(true);
                        end else begin
                            Rec."Purchase Date" := 0D;
                            Rec."Purchase Price" := 0;
                            Rec."Sale Date" := 0D;
                            Rec."Closed Date" := 0D;
                        end;
                    end;
                end;
            Rec."Vehicle Type"::lease, Rec."Vehicle Type"::Rent:
                begin
                    if Rec."Monthly Amount" <> 0 then begin

                        if not Confirm(MSG002, false) then begin
                            Rec."Vehicle Type" := xRec."Vehicle Type";
                            exit(true);
                        end else begin
                            Rec."Monthly Amount" := 0;
                        end;
                    end;
                end;
        end;
        exit(false);
    end;


    procedure CostAmountVisible()
    begin

        if Rec.Type = Rec.Type::equipment then begin
            CostAVisible := true
        end else begin
            CostAVisible := false;
        end;
    end;
}

