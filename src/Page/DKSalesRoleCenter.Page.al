page 50198 "DK_Sales RoleCenter"
{
    // 
    // #2044: 20200806
    //   - Rec. Modify Action: Page DK_Counsel Litigation List(ŒÁ‰½ ‹Ý„Ì ˆ±‡Ÿ -> ×„ ‹Ý„Ì ˆ±‡Ÿ)

    Caption = 'SalesAdmin RoleCenter';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                ShowCaption = false;
                part(Control13; "DK_Sales Activities")
                {
                    AccessByPermission = TableData DK_Contract = R;
                    ApplicationArea = Basic, Suite;
                }
                part(Control61; "DK_Schedule Run His. Factbox")
                {
                }
            }
            group(Control5)
            {
                ShowCaption = false;
                part("Today Funeral"; "DK_Today Funeral Factbox")
                {
                    Caption = 'Today Funeral';
                }
                part(Control89; "DK_Pay. Expect Pro. His. Fact2")
                {
                }
                part(Control12; "DK_Department Board Facbox")
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
            ////zzz++
            // action("Department Board List")
            // {
            //     Caption = 'Department Board List';
            //     RunObject = Page "DK_Department Board List";
            // }
            // action("Dk_Request Expenses List")
            // {
            //     Caption = 'Dk_Request Expenses List';
            //     RunObject = Page "DK_Request Expenses List";
            // }
            // action("Cemetery List")
            // {
            //     Caption = 'Cemetery List';
            //     RunObject = Page "DK_Cemetery List";
            // }
            ////zzz--
            group(Contract)
            {
                Caption = 'Contract';
                action("Cotnract List")
                {
                    Caption = 'Cotnract List';
                    RunObject = Page "DK_Contract List";
                }
            }
            action("Customer Request List")
            {
                Caption = 'Customer Request List';
                // RunObject = Page "DK_Customer Requests List";////zzz
            }
            action("Cemetery Services List")
            {
                Caption = 'Cemetery Services List';
                // RunObject = Page "DK_Cem. Services List";////zzz
            }
            action("Today funeral List")
            {
                Caption = 'Today funeral List';
                // RunObject = Page "DK_Today Funeral List";////zzz
            }
            action("Move The Grave List")
            {
                Caption = 'Move The Grave List';
                RunObject = Page "DK_Move The Grave List";
            }
            action("Evenet Product Sales Status")
            {
                Caption = 'Evenet Product Sales Status';
                RunObject = Page "DK_Event Product Sales Status";
            }
            action("Vehicle Operation List")
            {
                Caption = 'Vehicle Operation List';
                // RunObject = Page "DK_Vehicle Operation List";////zzz
            }
            action("Vehile Refueling List")
            {
                Caption = 'Vehile Refueling List';
                // RunObject = Page "DK_Vehicle Refueling List";////zzz
            }
            action("Vehicle Repair List")
            {
                Caption = 'Vehicle Repair List';
                // RunObject = Page "DK_Vehicle Repair List";////zzz
            }
            action("Vehicle Wash List")
            {
                Caption = 'Vehicle Wash List';
                // RunObject = Page "DK_Vehicle Wash List";////zzz
            }
            action("Sended SMS History")
            {
                Caption = 'Sended SMS History';
                // RunObject = Page "DK_Sended SMS History";////zzz
            }
        }
        area(sections)
        {
            group(Customer)
            {
                Caption = 'Customer';
                Image = HumanResources;
                action("Customer List")
                {
                    Caption = 'Customer List';
                    RunObject = Page "DK_Customer List";
                }
                action("Revocation Contract List")
                {
                    Caption = 'Revocation Contract List';
                    RunObject = Page "DK_Revocation Contract List";
                }
                action("Change Customer in Contract List")
                {
                    Caption = 'Change Customer in Contract List';
                    RunObject = Page "DK_Cng. Cust. in Contract List";
                }
                separator(Action52)
                {
                }
                action("Counsel General List")
                {
                    Caption = 'Counsel General List';
                    RunObject = Page "DK_Counsel General List";
                }
                action("Counsel Litigation List")
                {
                    Caption = 'Counsel Litigation List';
                    RunObject = Page "DK_Counsel Litigation List";
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
            group(Payment)
            {
                Caption = 'Payment';
                Image = CashFlow;
                action("Payment Expect Document List")
                {
                    Caption = 'Payment Expect Document List';
                    RunObject = Page "DK_Pay. Expect Document List";
                }
                action("Payment Receipt Document List")
                {
                    Caption = 'Payment Receipt Document List';
                    RunObject = Page "DK_Payment Receipt Doc. List";
                }
                action("Payment Refund Document List")
                {
                    Caption = 'Payment Refund Document List';
                    RunObject = Page "DK_Payment Refund Doc. List";
                }
                action("Publish Admin Expense List")
                {
                    Caption = 'Publish Admin Expense List';
                    RunObject = Page "DK_Publish Admin. Exp. List";
                }
            }
            group("Post Document")
            {
                Caption = 'Post Document';
                Image = FiledPosted;
                action("Post Payment Receipt Document List")
                {
                    Caption = 'Post Payment Receipt Document List';
                    RunObject = Page "DK_Post Pay. Receipt Doc. List";
                }
                action("Post Payment Refund Document List")
                {
                    Caption = 'Post Payment Refund Document List';
                    RunObject = Page "DK_Post. Pay. Refund Doc. List";
                }
                action("Posted Revocation Contract List")
                {
                    Caption = 'Posted Revocation Contract List';
                    RunObject = Page "DK_Posted Rev. Contract List";
                }
                action("Posted Request Exepnses List")
                {
                    Caption = 'Posted Request Exepnses List';
                    RunObject = Page "DK_Posted Req. Expenses List";
                }
                action("Posted Cemetery Services List")
                {
                    Caption = 'Posted Cemetery Services List';
                    RunObject = Page "DK_Posted Cem. Services List";
                }
                action("Customer Request Complte List")
                {
                    Caption = 'Customer Request Complte List';
                    RunObject = Page "DK_Cust. Request Complte List";
                }
            }
            group("Set up")
            {
                Caption = 'Set up';
                Image = Setup;
                action(Estate)
                {
                    Caption = 'Estate';
                    RunObject = Page DK_Estate;
                }
                action("Estate Group")
                {
                    Caption = 'Estate Group';
                    RunObject = Page "DK_Estate Group";
                }
                action("Cemetery Coformation")
                {
                    Caption = 'Cemetery Coformation';
                    RunObject = Page "DK_Cemetery Conformation";
                }
                action("Cemetery Option")
                {
                    Caption = 'Cemetery Option';
                    RunObject = Page "DK_Cemetery Option";
                }
                action("Unit Price Type")
                {
                    Caption = 'Unit Price Type';
                    RunObject = Page "DK_Unit Price Type";
                }
                action("Cemetery Class Discount")
                {
                    Caption = 'Cemetery Class Discount';
                    RunObject = Page "DK_Cemetery Class Discount";
                }
                action("Tree Type")
                {
                    Caption = 'Tree Type';
                    RunObject = Page "DK_Tree Type";
                }
                action(Action21)
                {
                    Caption = 'Cemetery List';
                    RunObject = Page "DK_Cemetery List";
                }
                separator(Action49)
                {
                }
                action("SMS List")
                {
                    Caption = 'SMS List';
                    RunObject = Page "DK_SMS List";
                }
                action("Request Document Setup")
                {
                    Caption = 'Request Document Setup';
                    RunObject = Page "DK_Request Doc. Setup";
                }
                action("Contract Refud Table List")
                {
                    Caption = 'Contract Refud Table List';
                    RunObject = Page "DK_Cont. Ref. Ref. Table List";
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
                // RunObject = Page "Change Password";////zzz
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
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                action("Counsel General")
                {
                    Caption = 'Counsel General';
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Counsel General";
                    RunPageMode = Create;
                }
                action("Create Payment Expect Document")
                {
                    Caption = 'Create Payment Expect Document';
                    Image = NewPurchaseInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Pay. Expect Document";
                    RunPageMode = Create;
                }
                action("Create Payment Receipt Doc.")
                {
                    Caption = 'Create Payment Receipt Doc.';
                    Image = CashReceiptJournal;
                    RunObject = Page "DK_Payment Receipt Document";
                    RunPageMode = Create;
                }
                action("New Customer Request")
                {
                    Caption = 'New Customer Request';
                    Image = NewToDo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "DK_Customer Request Card";
                    RunPageMode = Create;
                }
            }
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
            group(Process)
            {
                Caption = 'Process';
                action("E-Sky")
                {
                    Caption = 'E-Sky';
                    Image = TestDatabase;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_E-Sky Data";
                }
            }
            group(Action64)
            {
                Caption = 'Set up';
                Image = Setup;
                action("Cemetery Digits")
                {
                    Caption = 'Cemetery Digits';
                    Image = Category;
                    RunObject = Page "DK_Cemetery Digits2";
                }
                action("Admin Expense Setup")
                {
                    Caption = 'Admin Expense Setup';
                    Image = PaymentForecast;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Admin. Expense Setup";
                }
            }
        }
        area(reporting)
        {
            action("Marketing DailyReport")
            {
                Caption = 'Marketing DailyReport';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_HQ Office DailyReport";
            }
            action("Admin Expense Daily Report")
            {
                Caption = 'Admin Expense Daily Report';
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_Admin. Expense Daily Report";
            }
            action("Analysis Cotract")
            {
                Caption = 'Analysis Cotract';
                Image = SubcontractingWorksheet;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Analysis Contract";
            }
            action("Cmetery Sales By Product")
            {
                Caption = 'Cmetery Sales By Product';
                Image = Production;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Cemetery Sales By Product";
            }
            action("New Customer By Year")
            {
                Caption = 'New Customer By Year';
                Image = SalesTaxStatement;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_New Customer by Year";
            }
            action("Sales Performance Statu")
            {
                Caption = 'Sales Performance Statu';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_Sales Performance Status";
            }
            action("Customer Salesman Status")
            {
                Caption = 'Customer Salesman Status';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_Customer Salesman Status";
            }
            action("Sales Product Status")
            {
                Caption = 'Sales Product Status';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_Sales Product Status";
            }
            action("Sales Inventory Status")
            {
                Caption = 'Sales Inventory Status';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "DK_Sales Inventory Status";
            }
            action(Action30)
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
        }
    }
}

