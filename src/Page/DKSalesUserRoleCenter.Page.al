page 50260 "DK_SalesUser RoleCenter"
{
    Caption = '…Žð „Ì„ÏÀ ‡©ŒŽ•';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                ShowCaption = false;
                part(Control13; "DK_Sales User Activities")
                {
                    AccessByPermission = TableData DK_Contract = R;
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control5)
            {
                ShowCaption = false;
                systempart(Control10; MyNotes)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Cotnract List")
            {
                Caption = 'Cotnract List';
                RunObject = Page "DK_Sales Contract List";
            }
            // action("Vehicle Operation List") ////zzz
            // {
            //     Caption = 'Vehicle Operation List';
            //     RunObject = Page "DK_Vehicle Operation List";
            // }
            // action("Vehile Refueling List")////zzz
            // {
            //     Caption = 'Vehile Refueling List';
            //     RunObject = Page "DK_Vehicle Refueling List";
            // }
            // action("Vehicle Repair List")////zzz
            // {
            //     Caption = 'Vehicle Repair List';
            //     RunObject = Page "DK_Vehicle Repair List";
            // }
            // action("Vehicle Wash List")////zzz
            // {
            //     Caption = 'Vehicle Wash List';
            //     RunObject = Page "DK_Vehicle Wash List";
            // }
        }
        area(sections)
        {
            group(Vehicle)
            {
                Caption = 'Vehicle';
                Image = Intrastat;
                action("Vehicle Operation Ledger")
                {
                    Caption = 'Vehicle Operation Ledger';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Vehicle Operation Ledger";
                }
                action("Vehicle Refueling Ledger")
                {
                    Caption = 'Vehicle Refueling Ledger';
                    Image = CalculateShipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Vehicle Refueling Ledger";
                }
                action("Vehicle Repair Ledger")
                {
                    Caption = 'Vehicle Repair Ledger';
                    Image = ProjectToolsProjectMaintenance;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Vehicle Repair Ledger";
                }
                action("Vehicle Wash Leger")
                {
                    Caption = 'Vehicle Wash Leger';
                    Image = OrderList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Vehicle Wash Ledger";
                }
            }
        }
        area(creation)
        {
            action("Vehicle Operation")
            {
                Caption = 'Vehicle Operation';
                Image = Delivery;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Vehicle Operation";
                RunPageMode = Create;
            }
            action("Vehicle Refueling")
            {
                Caption = 'Vehicle Refueling';
                Image = UpdateShipment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Vehicle Refueling";
                RunPageMode = Create;
            }
            action("Vehicle Repair")
            {
                Caption = 'Vehicle Repair';
                Image = Tools;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Vehicle Repair";
                RunPageMode = Create;
            }
            action("Vehicle Wash")
            {
                Caption = 'Vehicle Wash';
                Image = SpecialOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Vehicle Wash";
                RunPageMode = Create;
            }
        }
    }
}

