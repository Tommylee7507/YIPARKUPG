page 50199 "DK_Litigation RC"////zzz
{
    // // 
    // // #2044: 20200806
    // //   - Rec. Modify Action: Page DK_Counsel Litigation List(ŒÁ‰½ ‹Ý„Ì ˆ±‡Ÿ -> ×„ ‹Ý„Ì ˆ±‡Ÿ)

    // Caption = 'YIPARK RoleCenter';
    // PageType = RoleCenter;

    // layout
    // {
    //     area(rolecenter)
    //     {
    //         group(Control2)
    //         {
    //             ShowCaption = false;
    //             part(Control52; Rec."DK_Litigation Activities")
    //             {
    //             }
    //         }
    //         group(Control5)
    //         {
    //             ShowCaption = false;
    //             part(Control61;Rec."DK_Schedule Run His. Factbox")
    //             {
    //             }
    //             part(Control54;Rec."DK_Department Board Facbox")
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
    //         action("Dk_Request Expenses List")
    //         {
    //             Caption = 'Dk_Request Expenses List';
    //             RunObject = Page "DK_Request Expenses List";
    //         }
    //         action("Litigation contract List")
    //         {
    //             Caption = 'Litigation contract List';
    //             RunObject = Page "DK_Litigation Contract List";
    //         }
    //         action("Purchase Contract List")
    //         {
    //             Caption = 'Purchase Contract List';
    //             RunObject = Page "DK_Purchase Contract List";
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
    //         action("Vehile Refueling List")
    //         {
    //             Caption = 'Vehile Refueling List';
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
    //         group(Customer)
    //         {
    //             Caption = 'Customer';
    //             Image = HumanResources;
    //             action("Customer List")
    //             {
    //                 Caption = 'Customer List';
    //                 RunObject = Page "DK_Customer List";
    //             }
    //             action("Revocation Contract List")
    //             {
    //                 Caption = 'Revocation Contract List';
    //                 RunObject = Page "DK_Revocation Contract List";
    //             }
    //             separator(Action38)
    //             {
    //             }
    //             action("Counsel General List")
    //             {
    //                 Caption = 'Counsel General List';
    //                 RunObject = Page "DK_Counsel General List";
    //             }
    //             action("Counsel Litigation List")
    //             {
    //                 Caption = 'Counsel Litigation List';
    //                 RunObject = Page "DK_Counsel Litigation List";
    //             }
    //         }
    //         group(Vehicle)
    //         {
    //             Caption = 'Vehicle';
    //             Image = Intrastat;
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
    //         group("Post Document")
    //         {
    //             Caption = 'Post Document';
    //             Image = FiledPosted;
    //             action("Posted Request Exepnses List")
    //             {
    //                 Caption = 'Posted Request Exepnses List';
    //                 RunObject = Page "DK_Posted Req. Expenses List";
    //             }
    //             action("Posted Revocation Contract List")
    //             {
    //                 Caption = 'Posted Revocation Contract List';
    //                 RunObject = Page "DK_Posted Rev. Contract List";
    //             }
    //         }
    //         group("Set up")
    //         {
    //             Caption = 'Set up';
    //             Image = Setup;
    //             action("Litigation Status")
    //             {
    //                 Caption = 'Litigation Status';
    //                 RunObject = Page "DK_Litigation Status";
    //             }
    //             action("Law Status")
    //             {
    //                 Caption = 'Law Status';
    //                 RunObject = Page "DK_Law Status";
    //             }
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
    //         action("Item Receipt")
    //         {
    //             Caption = 'Item Receipt';
    //             Image = Receipt;
    //             Promoted = false;
    //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
    //             //PromotedCategory = Process;
    //             RunObject = Page "DK_Item Receipt";
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
    //         group(Process)
    //         {
    //             Caption = 'Process';
    //             action("Litigation List")
    //             {
    //                 Caption = 'Litigation List';
    //                 Image = OpportunitiesList;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Litigation Contract List";
    //             }
    //             action("E-Sky")
    //             {
    //                 Caption = 'E-Sky';
    //                 Image = TestDatabase;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_E-Sky Data";
    //             }
    //             action("Counsel General")
    //             {
    //                 Caption = 'Counsel General';
    //                 Image = NewDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Counsel General";
    //                                 RunPageMode = Create;
    //             }
    //             action("Counsel Litigation")
    //             {
    //                 Caption = 'Counsel Litigation';
    //                 Image = NewDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Counsel General";
    //                                 RunPageMode = Create;
    //             }
    //         }
    //     }
    //     area(reporting)
    //     {
    //         action("CS 1_2part Daily Report")
    //         {
    //             Caption = 'CS 1_2part Daily Report';
    //             Image = "Report";
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Report "DK_CS 1_2part Daily Report";
    //         }
    //         action("CS 3part Receipt Status")
    //         {
    //             Caption = 'CS 3part Receipt Status';
    //             Image = "Report";
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Report "DK_CS 3part Receipt Status";
    //         }
    //         action("Litigation Payment")
    //         {
    //             Caption = 'Litigation Payment';
    //             Image = PaymentHistory;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Litigation Payment";
    //         }
    //         action("Litigation Evaluation Amount")
    //         {
    //             Caption = 'Litigation Evaluation Amount';
    //             Image = Evaluate;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Liti. Evaluation Amount";
    //         }
    //         action("Long-term Not Payer")
    //         {
    //             Caption = 'Long-term Not Payer';
    //             Image = PrepaymentInvoice;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Long-term Not Payer";
    //         }
    //         action("Litigation Performance")
    //         {
    //             Caption = 'Litigation Performance';
    //             Image = PayrollStatistics;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             RunObject = Page "DK_Litigation Performance";
    //         }
    //         action("Litigation Counsel Statics")
    //         {
    //             Caption = 'Litigation Counsel Statics';
    //             Image = EntryStatistics;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Litigation Counsel Statics";
    //         }
    //         action("Sended SMS History")
    //         {
    //             Caption = 'Sended SMS History';
    //             Image = SendElectronicDocument;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Sended SMS History";
    //         }
    //         action("Report Printing History")
    //         {
    //             Caption = 'Report Printing History';
    //             Image = PrintChecklistReport;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_Report Printing History";
    //         }
    //     }
    // }
}

