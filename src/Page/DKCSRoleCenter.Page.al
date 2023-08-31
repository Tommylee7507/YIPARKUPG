page 50197 "DK_CS RoleCenter" ////zzz
{
    // // 
    // // #2044: 20200904
    // //   - Rec. Modify Action: Action64(ŒÁ‰½ ‹Ý„Ì ˆ±‡Ÿ -> ×„ ‹Ý„Ì ˆ±‡Ÿ)

    // Caption = 'Customer Service RoleCenter';
    // PageType = RoleCenter;

    // layout
    // {
    //     area(rolecenter)
    //     {
    //         group(Control2)
    //         {
    //             ShowCaption = false;
    //             part(Control44; "DK_CS Activities")
    //             {
    //             }
    //             part(Control51; "DK_Schedule Run His. Factbox")
    //             {
    //             }
    //         }
    //         group(Control5)
    //         {
    //             ShowCaption = false;
    //             part("Today Funeral"; "DK_Today Funeral Factbox")
    //             {
    //                 Caption = 'Today Funeral';
    //             }
    //             part(Control83; "DK_Pay. Expect Pro. His. Fact2")
    //             {
    //             }
    //             part(Control23; "DK_Department Board Facbox")
    //             {
    //             }
    //             systempart(Control10; MyNotes)
    //             {
    //                 ApplicationArea = Basic, Suite;
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
    //         action("Cemetery List")
    //         {
    //             Caption = 'Cemetery List';
    //             RunObject = Page "DK_Cemetery List";
    //         }
    //         group(Contract)
    //         {
    //             Caption = 'Contract';
    //             action("Contract List")
    //             {
    //                 Caption = 'Contract List';
    //                 RunObject = Page "DK_Contract List";
    //             }
    //         }
    //         action("Customer Requests List")
    //         {
    //             Caption = 'Customer Requests List';
    //             RunObject = Page "DK_Customer Requests List";
    //         }
    //         action("Cemetery Services List")
    //         {
    //             Caption = 'Cemetery Services List';
    //             RunObject = Page "DK_Cem. Services List";
    //         }
    //         action("Today funeral List")
    //         {
    //             Caption = 'Today funeral List';
    //             RunObject = Page "DK_Today Funeral List";
    //         }
    //         action("Move The Grave List")
    //         {
    //             Caption = 'Move The Grave List';
    //             RunObject = Page "DK_Move The Grave List";
    //         }
    //         action("Evenet Product Sales Status")
    //         {
    //             Caption = 'Evenet Product Sales Status';
    //             RunObject = Page "DK_Event Product Sales Status";
    //         }
    //         action("Vehicle Operation List")
    //         {
    //             Caption = 'Vehicle Operation List';
    //             RunObject = Page "DK_Vehicle Operation List";
    //         }
    //         action("Vehicle Refueling List")
    //         {
    //             Caption = 'Vehicle Refueling List';
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
    //         action("Sended SMS History")
    //         {
    //             Caption = 'Sended SMS History';
    //             RunObject = Page "DK_Sended SMS History";
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
    //             action("Change Custmer in Contract")
    //             {
    //                 Caption = 'Change Custmer in Contract';
    //                 RunObject = Page "DK_Cng. Cust. in Contract List";
    //             }
    //             action("Revocation Contract List")
    //             {
    //                 Caption = 'Revocation Contract List';
    //                 RunObject = Page "DK_Revocation Contract List";
    //             }
    //             separator(Action66)
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
    //         group(Payment)
    //         {
    //             Caption = 'Payment';
    //             Image = CashFlow;
    //             action("HomePage Payment List")
    //             {
    //                 Caption = 'HomePage Payment List';
    //                 RunObject = Page "DK_HomePage Payment List";
    //             }
    //             action("Payment Expect Document List")
    //             {
    //                 Caption = 'Payment Expect Document List';
    //                 RunObject = Page "DK_Pay. Expect Document List";
    //             }
    //             action("Payment Receipt Document List")
    //             {
    //                 Caption = 'Payment Receipt Document List';
    //                 RunObject = Page "DK_Payment Receipt Doc. List";
    //             }
    //             action("Payment Refund Document List")
    //             {
    //                 Caption = 'Payment Refund Document List';
    //                 RunObject = Page "DK_Payment Refund Doc. List";
    //             }
    //             action("Publish Admin Expense List")
    //             {
    //                 Caption = 'Publish Admin Expense List';
    //                 RunObject = Page "DK_Publish Admin. Exp. List";
    //             }
    //         }
    //         group("Post Document")
    //         {
    //             Caption = 'Post Document';
    //             Image = FiledPosted;
    //             action("Posted HomePage Payment List")
    //             {
    //                 Caption = 'Posted HomePage Payment List';
    //                 RunObject = Page "DK_Posted HomePage Pay. List";
    //             }
    //             action("Post Payment Receipt Document List")
    //             {
    //                 Caption = 'Post Payment Receipt Document List';
    //                 RunObject = Page "DK_Post Pay. Receipt Doc. List";
    //             }
    //             action("Post Payment Refund Document List")
    //             {
    //                 Caption = 'Post Payment Refund Document List';
    //                 RunObject = Page "DK_Post. Pay. Refund Doc. List";
    //             }
    //             action("Posted Revocation Contract List")
    //             {
    //                 Caption = 'Posted Revocation Contract List';
    //                 RunObject = Page "DK_Posted Rev. Contract List";
    //             }
    //             action("Posted Request Exepnses List")
    //             {
    //                 Caption = 'Posted Request Exepnses List';
    //                 RunObject = Page "DK_Posted Req. Expenses List";
    //             }
    //             action("Posted Cemetery Services List")
    //             {
    //                 Caption = 'Posted Cemetery Services List';
    //                 RunObject = Page "DK_Posted Cem. Services List";
    //             }
    //             action("Customer Request Complte List")
    //             {
    //                 Caption = 'Customer Request Complte List';
    //                 RunObject = Page "DK_Cust. Request Complte List";
    //             }
    //         }
    //         group("Set up")
    //         {
    //             Caption = 'Set up';
    //             Image = Setup;
    //             action("Contract Refund Table List")
    //             {
    //                 Caption = 'Contract Refund Table List';
    //                 RunObject = Page "DK_Cont. Ref. Ref. Table List";
    //             }
    //             action("Request Document Setup")
    //             {
    //                 Caption = 'Request Document Setup';
    //                 RunObject = Page "DK_Request Doc. Setup";
    //             }
    //             action("SMS List")
    //             {
    //                 Caption = 'SMS List';
    //                 RunObject = Page "DK_SMS List";
    //             }
    //             action("Receipt Bank Account")
    //             {
    //                 Caption = 'Receipt Bank Account';
    //                 RunObject = Page "DK_Receipt Bank Account";
    //             }
    //             separator(Action60)
    //             {
    //             }
    //             action("Work Manager")
    //             {
    //                 Caption = 'Work Manager';
    //                 RunObject = Page "DK_Work Manager";
    //             }
    //             action("Work Group")
    //             {
    //                 Caption = 'Work Group';
    //                 RunObject = Page "DK_Work Group";
    //             }
    //             action("Field Work Category")
    //             {
    //                 Caption = 'Field Work Category';
    //                 RunObject = Page "DK_Field Work Main Category";
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
    //         action("Vehicle Operation")
    //         {
    //             Caption = 'Vehicle Operation';
    //             Image = Delivery;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Operation";
    //             RunPageMode = Create;
    //         }
    //         action("Vehicle Refueling")
    //         {
    //             Caption = 'Vehicle Refueling';
    //             Image = UpdateShipment;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Refueling";
    //             RunPageMode = Create;
    //         }
    //         action("Vehicle Repair")
    //         {
    //             Caption = 'Vehicle Repair';
    //             Image = Tools;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Repair";
    //             RunPageMode = Create;
    //         }
    //         action("Vehicle Wash")
    //         {
    //             Caption = 'Vehicle Wash';
    //             Image = SpecialOrder;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Vehicle Wash";
    //             RunPageMode = Create;
    //         }
    //     }
    //     area(processing)
    //     {
    //         group(New)
    //         {
    //             Caption = 'New';
    //             action("Counsel General")
    //             {
    //                 Caption = 'Counsel General';
    //                 Image = NewDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Counsel General";
    //                 RunPageMode = Create;
    //             }
    //             action("Create Payment Expect Document")
    //             {
    //                 Caption = 'Create Payment Expect Document';
    //                 Image = NewPurchaseInvoice;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Pay. Expect Document";
    //                 RunPageMode = Create;
    //             }
    //             action("Create Payment Receipt Doc.")
    //             {
    //                 Caption = 'Create Payment Receipt Doc.';
    //                 Image = CashReceiptJournal;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Payment Receipt Document";
    //                 RunPageMode = Create;
    //             }
    //             action("Create Change Customer in Contract")
    //             {
    //                 Caption = 'Create Change Customer in Contract';
    //                 Image = ChangeCustomer;
    //                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
    //                 //PromotedCategory = Process;
    //                 RunObject = Page "DK_Cng. Customer in Contract";
    //                 RunPageMode = Create;
    //             }
    //             action("New Customer Request")
    //             {
    //                 Caption = 'New Customer Request';
    //                 Image = NewToDo;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Customer Request Card";
    //                 RunPageMode = Create;
    //             }
    //         }
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
    //             action("E-Sky")
    //             {
    //                 Caption = 'E-Sky';
    //                 Image = TestDatabase;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_E-Sky Data";
    //             }
    //         }
    //         group(Action17)
    //         {
    //             Caption = 'Set up';
    //             Image = Setup;
    //             action("Payment Methods")
    //             {
    //                 Caption = 'Payment Methods';
    //                 Image = SetupPayment;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Payment Methods";
    //             }
    //             action("Admin Expense Setup")
    //             {
    //                 Caption = 'Admin Expense Setup';
    //                 Image = PaymentForecast;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Admin. Expense Setup";
    //             }
    //         }
    //     }
    //     area(reporting)
    //     {
    //         action("Admin Expense Daily Report")
    //         {
    //             Caption = 'Admin Expense Daily Report';
    //             Image = "Report";
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Report "DK_Admin. Expense Daily Report";
    //         }
    //         action("CS Daily Report")
    //         {
    //             Caption = 'CS Daily Report';
    //             Image = "Report";
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             PromotedIsBig = true;
    //             RunObject = Report Report50035;
    //         }
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
    //         action("Admin Payment Target")
    //         {
    //             Caption = 'Admin Payment Target';
    //             Image = PayrollStatistics;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             PromotedOnly = true;
    //             RunObject = Page "DK_Admin. Payment Target";
    //         }
    //         action(Action49)
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
    //         action("New Customer By Year")
    //         {
    //             Caption = 'New Customer By Year';
    //             Image = SalesTaxStatement;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             RunObject = Page "DK_New Customer by Year";
    //         }
    //     }
    // }
}

