page 50195 "DK_Park RoleCenter"
{
    Caption = 'Park RoleCenter';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                ShowCaption = false;
                part(Control7; "DK_Park Activities")
                {
                    AccessByPermission = TableData "DK_Field Work Header" = R;
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control5)
            {
                ShowCaption = false;
                part("Today Funeral"; "DK_Today Funeral Factbox")
                {
                    Caption = 'Today Funeral';
                }
                part(Control4; "DK_Department Board Facbox")
                {
                }
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
            action("Department Board List")
            {
                Caption = 'Department Board List';
                RunObject = Page "DK_Department Board List";
            }
            action("Item Shipment")
            {
                Caption = 'Item Shipment';
                RunObject = Page "DK_Posted Item Receipt";
            }
            action("Request Expenses List")
            {
                Caption = 'Request Expenses List';
                RunObject = Page "DK_Request Expenses List";
            }
            action("Customer Requests List")
            {
                Caption = 'Customer Requests List';
                RunObject = Page "DK_Customer Requests List";
            }
            action("Today Funeral List")
            {
                Caption = 'Today Funeral List';
                RunObject = Page "DK_Today Funeral List";
            }
            action("Cemetery Services List")
            {
                Caption = 'Cemetery Services List';
                RunObject = Page "DK_Cem. Services List";
            }
            action("Project List")
            {
                Caption = 'Project List';
                RunObject = Page "DK_Project List";
            }
            action("Cemetery List")
            {
                Caption = 'Cemetery List';
                RunObject = Page "DK_Cemetery List";
            }
            action("Vehicle Operation List")
            {
                Caption = 'Vehicle Operation List';
                RunObject = Page "DK_Vehicle Operation List";
            }
            action("Vehicle Refuling List")
            {
                Caption = 'Vehicle Refuling List';
                RunObject = Page "DK_Vehicle Refueling List";
            }
            action("Vehicle Repair List")
            {
                Caption = 'Vehicle Repair List';
                RunObject = Page "DK_Vehicle Repair List";
            }
            action("Vehicle Wash List")
            {
                Caption = 'Vehicle Wash List';
                RunObject = Page "DK_Vehicle Wash List";
            }
            action("Field Work List")
            {
                Caption = 'Field Work List';
                RunObject = Page "DK_Field Work List";
            }
            action(Action54)
            {
                Caption = 'Customer Requests List';
                RunObject = Page "DK_Customer Requests All";
            }
        }
        area(sections)
        {
            group("Field Work")
            {
                Caption = 'Field Work';
                Image = HumanResources;
                action("Posted Field Work List")
                {
                    Caption = 'Posted Field Work List';
                    RunObject = Page "DK_Posted Field Work List";
                }
                action("Field Work Ledger Entry")
                {
                    Caption = 'Field Work Ledger Entry';
                    RunObject = Page "DK_Field Work Ledger Entry";
                }
            }
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
            group("Posted Document")
            {
                Caption = 'Posted Document';
                Image = FiledPosted;
                action("Posted Request Expenses List")
                {
                    Caption = 'Posted Request Expenses List';
                    RunObject = Page "DK_Posted Req. Expenses List";
                }
            }
            group("Set up")
            {
                Caption = 'Set up';
                Image = Setup;
                action("Work Manager")
                {
                    Caption = 'Work Manager';
                    RunObject = Page "DK_Work Manager";
                }
                action("Work Group")
                {
                    Caption = 'Work Group';
                    RunObject = Page "DK_Work Group";
                }
                action("Field Work Category")
                {
                    Caption = 'Field Work Category';
                    RunObject = Page "DK_Field Work Main Category";
                }
            }
        }
        area(creation)
        {
            action("Change &Password")
            {
                Caption = 'Change &Password';
                Image = EncryptionKeys;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Change Password";
            }
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
            action("Vehicl Wash")
            {
                Caption = 'Vehicl Wash';
                Image = SpecialOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Vehicle Wash";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            group(SMS)
            {
                Caption = 'SMS';
                action("SMS Send")
                {
                    Caption = 'SMS Send';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_SMS Send";
                }
            }
            group(Action39)
            {
                Caption = 'Field Work';
                action(Action40)
                {
                    Caption = 'Field Work';
                    Image = ServiceMan;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Field Work";
                }
            }
        }
        area(reporting)
        {
            action("Park Manager DailyReport")
            {
                Caption = 'Park Manager DailyReport';
                Image = ServiceTasks;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_Park Mang. DailyReport";
            }
            action("Field Work Ledge Entry")
            {
                Caption = 'Field Work Ledge Entry';
                Image = ServiceLedger;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Field Work Ledger Entry";
            }
            action("Sended SMS History")
            {
                Caption = 'Sended SMS History';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Sended SMS History";
            }
            action("Report Printing History")
            {
                Caption = 'Report Printing History';
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Report Printing History";
            }
            action("Monthly I/O Status")
            {
                Caption = 'Monthly I/O Status';
                Image = DocumentsMaturity;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Monthly I/O Status";
            }
        }
    }
}

