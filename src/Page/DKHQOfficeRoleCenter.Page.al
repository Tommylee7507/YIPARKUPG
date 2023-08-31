page 50194 "DK_HQ Office RoleCenter"
{
    Caption = 'HQ Office RoleCenter';
    PageType = RoleCenter;

    // layout ////zzz
    // {
    //     area(rolecenter)
    //     {
    //         group(Control2)
    //         {
    //             ShowCaption = false;
    //             part(Control45; "DK_HQ Office Activities")
    //             {
    //                 AccessByPermission = TableData DK_Item=R;
    //             }
    //         }
    //         group(Control5)
    //         {
    //             ShowCaption = false;
    //             part(Control57;"DK_Item Facbox")
    //             {
    //             }
    //             part(Control38;"DK_Department Board Facbox")
    //             {
    //             }
    //             systempart(Control10;MyNotes)
    //             {
    //                 ApplicationArea = Basic,Suite;
    //             }
    //         }
    //     }
    // }

    // actions
    // {
    //     area(embedding)
    //     {
    //         action("Department Board List")
    //         {
    //             Caption = 'Department Board List';
    //             RunObject = Page "DK_Department Board List";
    //         }
    //         action("Request Expenses List")
    //         {
    //             Caption = 'Request Expenses List';
    //             RunObject = Page "DK_Request Expenses List";
    //         }
    //         action("Purchase Contract List")
    //         {
    //             Caption = 'Purchase Contract List';
    //             RunObject = Page "DK_Purchase Contract List";
    //         }
    //         action("Posted Item Receipt")
    //         {
    //             Caption = 'Posted Item Receipt';
    //             RunObject = Page "DK_Posted Item Receipt";
    //         }
    //         action("Developer Terget List")
    //         {
    //             Caption = 'Developer Terget List';
    //             RunObject = Page "DK_Dev. Target List";
    //         }
    //         action("Alaram List")
    //         {
    //             Caption = 'Alaram List';
    //             RunObject = Page "DK_Alarm List";
    //         }
    //         action("Vehicle Operation List")
    //         {
    //             Caption = 'Vehicle Operation List';
    //             RunObject = Page "DK_Vehicle Operation List";
    //         }
    //         action("Vehicle Refuling List")
    //         {
    //             Caption = 'Vehicle Refuling List';
    //             RunObject = Page "DK_Vehicle Refueling List";
    //         }
    //         action("Vehicle Repair List")
    //         {
    //             Caption = 'Vehicle Repair List';
    //             RunObject = Page "DK_Vehicle Repair List";
    //         }
    //         action("Vehicle Wash List")
    //         {
    //             Caption = 'Vehicle Wash List';
    //             RunObject = Page "DK_Vehicle Wash List";
    //         }
    //     }
    //     area(sections)
    //     {
    //         group(Vehicle)
    //         {
    //             Caption = 'Vehicle';
    //             Image = Intrastat;
    //             ToolTip = 'You can register the vehicle and check the usage history.';
    //             action("Vehicle List")
    //             {
    //                 Caption = 'Vehicle List';
    //                 Image = Delivery;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Vehicle List";
    //             }
    //             action("Vehicle Operation Ledger")
    //             {
    //                 Caption = 'Vehicle Operation Ledger';
    //                 Image = Shipment;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Vehicle Operation Ledger";
    //             }
    //             action("Vehicle Refueling Ledger")
    //             {
    //                 Caption = 'Vehicle Refueling Ledger';
    //                 Image = CalculateShipment;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Vehicle Refueling Ledger";
    //             }
    //             action("Vehicle Repair Ledger")
    //             {
    //                 Caption = 'Vehicle Repair Ledger';
    //                 Image = ProjectToolsProjectMaintenance;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Vehicle Repair Ledger";
    //             }
    //             action("Vehicle Wash Leger")
    //             {
    //                 Caption = 'Vehicle Wash Leger';
    //                 Image = OrderList;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Vehicle Wash Ledger";
    //             }
    //         }
    //         group(Item)
    //         {
    //             Caption = 'Item';
    //             Image = Purchasing;
    //             ToolTip = 'You can register assets and check for forwarding.';
    //             action("Item Category")
    //             {
    //                 Caption = 'Item Category';
    //                 RunObject = Page "DK_Item Main Category";
    //             }
    //             action("Item List")
    //             {
    //                 Caption = 'Item List';
    //                 RunObject = Page "DK_Item List";
    //             }
    //             action("Item Receipt")
    //             {
    //                 Caption = 'Item Receipt';
    //                 RunObject = Page "DK_Item Receipt List";
    //             }
    //             action("Item Shipment")
    //             {
    //                 Caption = 'Item Shipment';
    //                 RunObject = Page "DK_Posted Item Receipt";
    //             }
    //         }
    //         group("Posted Document")
    //         {
    //             Caption = 'Posted Document';
    //             Image = FiledPosted;
    //             ToolTip = 'You can view the documents that have been printed.';
    //             action("Item Ledger Entry")
    //             {
    //                 Caption = 'Item Ledger Entry';
    //                 RunObject = Page "DK_Item Ledger Entry";
    //             }
    //             action("Posted Rqeust Expenses List")
    //             {
    //                 Caption = 'Posted Rqeust Expenses List';
    //                 RunObject = Page "DK_Posted Req. Expenses List";
    //             }
    //         }
    //         group(SetUp)
    //         {
    //             Caption = 'SetUp';
    //             Image = SetUp;
    //             action(Department)
    //             {
    //                 Caption = 'Department';
    //                 RunObject = Page DK_Department;
    //             }
    //             action("Employee List")
    //             {
    //                 Caption = 'Employee List';
    //                 RunObject = Page "DK_Employee List";
    //             }
    //             action("Vendor List")
    //             {
    //                 Caption = 'Vendor List';
    //                 RunObject = Page "DK_Vendor List";
    //             }
    //             action(Location)
    //             {
    //                 Caption = 'Location';
    //                 RunObject = Page DK_Location;
    //             }
    //             action("Shipment Type")
    //             {
    //                 Caption = 'Shipment Type';
    //                 RunObject = Page "DK_Shipment Type";
    //             }
    //             action("SMS List")
    //             {
    //                 Caption = 'SMS List';
    //                 RunObject = Page "DK_SMS List";
    //             }
    //         }
    //     }
    //     area(creation)
    //     {
    //         action("Change &Password")
    //         {
    //             Caption = 'Change &Password';
    //             Image = EncryptionKeys;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             RunObject = Page "Change Password";
    //         }
    //         action(Action36)
    //         {
    //             Caption = 'Item Receipt';
    //             Image = Receipt;
    //             Promoted = false;
    //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
    //             //PromotedCategory = Process;
    //             RunObject = Page "DK_Item Receipt";
    //                             RunPageMode = Create;
    //         }
    //         action(Project)
    //         {
    //             Caption = 'Project';
    //             Image = Skills;
    //             RunObject = Page DK_Project;
    //                             RunPageMode = Create;
    //         }
    //         action("Vehicle Operation")
    //         {
    //             Caption = 'Vehicle Operation';
    //             Image = Delivery;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Operation";
    //                             RunPageMode = Create;
    //         }
    //         action("Vehicle Refueling")
    //         {
    //             Caption = 'Vehicle Refueling';
    //             Image = UpdateShipment;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Refueling";
    //                             RunPageMode = Create;
    //         }
    //         action("Vehicle Repair")
    //         {
    //             Caption = 'Vehicle Repair';
    //             Image = Tools;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Repair";
    //                             RunPageMode = Create;
    //         }
    //         action("Vehicle Wash")
    //         {
    //             Caption = 'Vehicle Wash';
    //             Image = SpecialOrder;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Wash";
    //                             RunPageMode = Create;
    //         }
    //     }
    //     area(processing)
    //     {
    //         group(SMS)
    //         {
    //             Caption = 'SMS';
    //             action("SMS Send")
    //             {
    //                 Caption = 'SMS Send';
    //                 Image = SendTo;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_SMS Send";
    //             }
    //         }
    //     }
    //     area(reporting)
    //     {
    //         action("Purch. Contract By Month")
    //         {
    //             Caption = 'Purch. Contract By Month';
    //             Image = "Report";
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Report "DK_Purch. Contract By Month";
    //         }
    //         action("Monthly I/O Status")
    //         {
    //             Caption = 'Monthly I/O Status';
    //             Image = DocumentsMaturity;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Monthly I/O Status";
    //         }
    //         action("Monthly Refuling Statistic")
    //         {
    //             Caption = 'Monthly Refuling Statistic';
    //             Image = StatisticsDocument;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Monthly Refueling Statistic";
    //         }
    //         action("Field Work Ledger Entry")
    //         {
    //             Caption = 'Field Work Ledger Entry';
    //             Image = ServiceTasks;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Field Work Ledger Entry";
    //         }
    //         action("Report Printing History")
    //         {
    //             Caption = 'Report Printing History';
    //             Image = PrintChecklistReport;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Report Printing History";
    //         }
    //         action("Sneded SMS History")
    //         {
    //             Caption = 'Sneded SMS History';
    //             Image = SendElectronicDocument;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Sended SMS History";
    //         }
    //     }
    // }
}

