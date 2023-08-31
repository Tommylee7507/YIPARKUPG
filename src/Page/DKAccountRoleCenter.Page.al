// page 50196 "DK_Account RoleCenter" ////zzz
// {
//     // 
//     // *DK34 : 20201020
//     //   - Delete Part: Page DK_Certificate History

//     Caption = 'Account RoleCenter';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control5)
//             {
//                 ShowCaption = false;
//                 part(Control46; "DK_Account Activities")
//                 {
//                 }
//             }
//             group(Control2)
//             {
//                 ShowCaption = false;
//                 part(Control52; "DK_Request Remittance Factbox")
//                 {
//                 }
//                 systempart(Control10; MyNotes)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(embedding)
//         {
//             action("Department Board List")
//             {
//                 Caption = 'Department Board List';
//                 RunObject = Page "DK_Department Board List";
//             }
//             action("Request Expenses List")
//             {
//                 Caption = 'Request Expenses List';
//                 RunObject = Page "DK_Request Expenses List";
//             }
//             action("Vehicle Operation List")
//             {
//                 Caption = 'Vehicle Operation List';
//                 RunObject = Page "DK_Vehicle Operation List";
//             }
//             action("Vehicle Refueling List")
//             {
//                 Caption = 'Vehicle Refueling List';
//                 RunObject = Page "DK_Vehicle Refueling List";
//             }
//             action("Vehicle Repair List")
//             {
//                 Caption = 'Vehicle Repair List';
//                 RunObject = Page "DK_Vehicle Repair List";
//             }
//             action("Vehicle Wash List")
//             {
//                 Caption = 'Vehicle Wash List';
//                 RunObject = Page "DK_Vehicle Wash List";
//             }
//         }
//         area(sections)
//         {
//             group(Vehicle)
//             {
//                 Caption = 'Vehicle';
//                 Image = Intrastat;
//                 action("Vehicle Operation Ledger")
//                 {
//                     Caption = 'Vehicle Operation Ledger';
//                     Image = Shipment;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "DK_Vehicle Operation Ledger";
//                 }
//                 action("Vehicle Refueling Ledger")
//                 {
//                     Caption = 'Vehicle Refueling Ledger';
//                     Image = CalculateShipment;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "DK_Vehicle Refueling Ledger";
//                 }
//                 action("Vehicle Repair Ledger")
//                 {
//                     Caption = 'Vehicle Repair Ledger';
//                     Image = ProjectToolsProjectMaintenance;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "DK_Vehicle Repair Ledger";
//                 }
//                 action("Vehicle Wash Leger")
//                 {
//                     Caption = 'Vehicle Wash Leger';
//                     Image = OrderList;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "DK_Vehicle Wash Ledger";
//                 }
//             }
//             group("Post Document")
//             {
//                 Caption = 'Post Document';
//                 Image = FiledPosted;
//                 action("Request Remittance Ledger")
//                 {
//                     Caption = 'Request Remittance Ledger';
//                     RunObject = Page "DK_Request Remittance Ledger";
//                 }
//                 action("Posted Request Expenses List")
//                 {
//                     Caption = 'Posted Request Expenses List';
//                     RunObject = Page "DK_Posted Req. Expenses List";
//                 }
//                 action("Post Payment Receipt Document List")
//                 {
//                     Caption = 'Post Payment Receipt Document List';
//                     RunObject = Page "DK_Post Pay. Receipt Doc. List";
//                 }
//                 action("Posted Rev. Contract List")
//                 {
//                     Caption = 'Posted Rev. Contract List';
//                     RunObject = Page "DK_Posted Rev. Contract List";
//                 }
//                 action("Posted Payment Refund Document List")
//                 {
//                     Caption = 'Posted Payment Refund Document List';
//                     RunObject = Page "DK_Post. Pay. Refund Doc. List";
//                 }
//             }
//             group("Set Up")
//             {
//                 Caption = 'Set Up';
//                 Image = Setup;
//                 action(Bank)
//                 {
//                     Caption = 'Bank';
//                     RunObject = Page DK_Bank;
//                 }
//                 action("Receipt Bank Account")
//                 {
//                     Caption = 'Receipt Bank Account';
//                     RunObject = Page "DK_Receipt Bank Account";
//                 }
//                 action("Payment Method")
//                 {
//                     Caption = 'Payment Method';
//                     RunObject = Page "DK_Payment Method";
//                 }
//                 action("SMS List")
//                 {
//                     Caption = 'SMS List';
//                     RunObject = Page "DK_SMS List";
//                 }
//             }
//         }
//         area(creation)
//         {
//             action("Change &Password")
//             {
//                 Caption = 'Change &Password';
//                 Image = EncryptionKeys;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Change Password";
//             }
//             action("Vehicle Operation")
//             {
//                 Caption = 'Vehicle Operation';
//                 Image = Delivery;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "DK_Vehicle Operation";
//                 RunPageMode = Create;
//             }
//             action("Vehicle Refueling")
//             {
//                 Caption = 'Vehicle Refueling';
//                 Image = UpdateShipment;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "DK_Vehicle Refueling";
//                 RunPageMode = Create;
//             }
//             action("Vehicle Repair")
//             {
//                 Caption = 'Vehicle Repair';
//                 Image = Tools;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "DK_Vehicle Repair";
//                 RunPageMode = Create;
//             }
//             action("Vehicle Wash")
//             {
//                 Caption = 'Vehicle Wash';
//                 Image = SpecialOrder;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "DK_Vehicle Wash";
//                 RunPageMode = Create;
//             }
//         }
//         area(processing)
//         {
//             group(Task)
//             {
//                 Caption = 'Task';
//                 action("E-Sky")
//                 {
//                     Caption = 'E-Sky';
//                     Image = TestDatabase;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "DK_E-Sky Data";
//                 }
//             }
//             group(SMS)
//             {
//                 Caption = 'SMS';
//                 action("SMS Send")
//                 {
//                     Caption = 'SMS Send';
//                     Image = SendTo;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "DK_SMS Send";
//                 }
//             }
//             group(Closing)
//             {
//                 Caption = 'Closing';
//                 action("Closing Setup")
//                 {
//                     Caption = 'Closing Setup';
//                     Image = GeneralPostingSetup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     RunObject = Page "DK_Closing Setup";
//                 }
//             }
//         }
//         area(reporting)
//         {
//             action("Receipt Statistics")
//             {
//                 Caption = 'Receipt Statistics';
//                 Image = PayrollStatistics;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Page "DK_Receipt Statistics";
//             }
//             action("Cemetery Amount Unpaid")
//             {
//                 Caption = 'Cemetery Amount Unpaid';
//                 Image = PaymentHistory;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Report "DK_Cemetery Amount Unpaid";
//             }
//             action("Admin Payment Current Situation")
//             {
//                 Caption = 'Admin Payment Current Situation';
//                 Image = ApplicationWorksheet;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 PromotedOnly = true;
//                 RunObject = Page "DK_Admin. Pay. Cur. Situation";
//             }
//             action("Cemetery Sales By Product")
//             {
//                 Caption = 'Cemetery Sales By Product';
//                 Image = Production;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Page "DK_Cemetery Sales By Product";
//             }
//             action("Report Printing History")
//             {
//                 Caption = 'Report Printing History';
//                 Image = PrintChecklistReport;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Page "DK_Report Printing History";
//             }
//             action("Sended SMS History")
//             {
//                 Caption = 'Sended SMS History';
//                 Image = SendElectronicDocument;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "DK_Sended SMS History";
//             }
//             group(Settlement)
//             {
//                 Caption = 'Settlement';
//                 action("Admin Expense By Year")
//                 {
//                     Caption = 'Admin Expense By Year';
//                     Image = PaymentDays;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Page "DK_Admin. Liti. By Year";
//                 }
//                 action("Prepayment Not Defined")
//                 {
//                     Caption = 'Prepayment Not Defined';
//                     Image = TestReport;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Page "DK_Prepayment Not Defined";
//                 }
//                 action("Deposit Detail By Imputed Year")
//                 {
//                     Caption = 'Deposit Detail By Imputed Year';
//                     Image = ApplicationWorksheet;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Page "DK_Payment Rec. By Year";
//                 }
//                 action("Long-term Not Payer")
//                 {
//                     Caption = 'Long-term Not Payer';
//                     Image = Statistics1099;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Page "DK_Long-term Not Payer";
//                 }
//             }
//         }
//     }
// }

