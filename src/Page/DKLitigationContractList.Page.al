page 50156 "DK_Litigation Contract List" ////zzz
{
    // // 
    // // #2026: 20200721
    // //   - Add Action: ChangeEvaluation
    // // 
    // // DK34: 20201030
    // //   - Add Field: "Fur. Main Cat. Code", "Fur. Main Cat. Name", "Fur. Sub Cat. Code", "Fur. Sub Cat. Name","Litigation Progress Code", "Litigation Progress Name"
    // //     : 20201117
    // //   - Add Field: "Department Code", "Department Name"
    // //   - Rec. Modify Field: "Litigation Employee Name" - Visible False

    // Caption = 'Litigation Contract List';
    // CardPageID = "DK_Litigation Contract";
    // DeleteAllowed = false;
    // Editable = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // PageType = List;
    // ApplicationArea = All;
    // UsageCategory = Lists;
    // PromotedActionCategories = 'New,Process,Report,Relation Infomation';
    // SourceTable = DK_Contract;

    // layout
    // {
    //     area(content)
    //     {
    //         repeater(Group)
    //         {
    //             field("No."; Rec."No.")
    //             {
    //             }
    //             field("Contract Date"; Rec."Contract Date")
    //             {
    //             }
    //             field("Supervise No."; Rec."Supervise No.")
    //             {
    //             }
    //             field("Litigation Employee Name"; Rec."Litigation Employee Name")
    //             {
    //                 Visible = false;
    //             }
    //             field("Department Code"; Rec."Department Code")
    //             {
    //                 Visible = false;
    //             }
    //             field("Department Name"; Rec."Department Name")
    //             {
    //             }
    //             field("Contract Type"; Rec."Contract Type")
    //             {
    //             }
    //             field("Group Contract No."; Rec."Group Contract No.")
    //             {
    //             }
    //             field(Status; Rec.Status)
    //             {
    //             }
    //             field("Litigation Evaluation"; Rec."Litigation Evaluation")
    //             {
    //             }
    //             field("Cemetery No."; Rec."Cemetery No.")
    //             {
    //             }
    //             field("Main Customer Name"; Rec."Main Customer Name")
    //             {
    //             }
    //             field("Litigation Status Name"; Rec."Litigation Status Name")
    //             {
    //             }
    //             field("Law Status Name"; Rec."Law Status Name")
    //             {
    //             }
    //             field("Fur. Main Cat. Code"; Rec."Fur. Main Cat. Code")
    //             {
    //                 Visible = false;
    //             }
    //             field("Fur. Main Cat. Name"; Rec."Fur. Main Cat. Name")
    //             {
    //             }
    //             field("Fur. Sub Cat. Code"; Rec."Fur. Sub Cat. Code")
    //             {
    //                 Visible = false;
    //             }
    //             field("Fur. Sub Cat. Name"; Rec."Fur. Sub Cat. Name")
    //             {
    //             }
    //             field("Litigation Progress Code"; Rec."Litigation Progress Code")
    //             {
    //                 Visible = false;
    //             }
    //             field("Litigation Progress Name"; Rec."Litigation Progress Name")
    //             {
    //             }
    //             field("Cemetery Size"; Rec."Cemetery Size")
    //             {
    //             }
    //             field("Cemetery Amount"; Rec."Cemetery Amount")
    //             {
    //                 ShowMandatory = true;
    //             }
    //             field("Cemetery Class Dis. Rate"; Rec."Cemetery Class Dis. Rate")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("Cemetery Class Discount"; Rec."Cemetery Class Discount")
    //             {
    //             }
    //             field("General Amount"; Rec."General Amount")
    //             {
    //                 CaptionClass = ComFunction.GetCaptionWithContract('1');
    //             }
    //             field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
    //             {
    //                 CaptionClass = ComFunction.GetCaptionWithContract('2');
    //             }
    //             field("Bury Amount"; Rec."Bury Amount")
    //             {
    //             }
    //             field("Cemetery Discount"; Rec."Cemetery Discount")
    //             {
    //             }
    //             field("Payment Amount"; Rec."Payment Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Deposit Amount"; Rec."Deposit Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Contract Amount"; Rec."Contract Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Rece. Remaining Amount"; Rec."Rece. Remaining Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Pay. Contract Rece. Date"; Rec."Pay. Contract Rece. Date")
    //             {
    //             }
    //             field("Remaining Due Date"; Rec."Remaining Due Date")
    //             {
    //             }
    //             field("Alarm Period 1"; Rec."Alarm Period 1")
    //             {
    //             }
    //             field("Alarm Period 2"; Rec."Alarm Period 2")
    //             {
    //             }
    //             field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
    //             {
    //             }
    //             field("General Expiration Date"; Rec."General Expiration Date")
    //             {
    //             }
    //             field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
    //             {
    //             }
    //             field("General Litigation Date"; Rec."General Litigation Date")
    //             {
    //             }
    //             field("Land. Arc. Litigation Date"; Rec."Land. Arc. Litigation Date")
    //             {
    //             }
    //             field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
    //             {

    //                 trigger OnDrillDown()
    //                 begin
    //                     OpenAdminExpeseLedger(0);
    //                 end;
    //             }
    //             field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
    //             {

    //                 trigger OnDrillDown()
    //                 begin
    //                     OpenAdminExpeseLedger(1);
    //                 end;
    //             }
    //             field("Recently Pay. Receipt Date"; Rec."Recently Pay. Receipt Date")
    //             {
    //             }
    //             field("Last Deposit Plan Date"; Rec."Last Deposit Plan Date")
    //             {
    //             }
    //             field("Counsel Date"; Rec."Counsel Date")
    //             {
    //             }
    //             field("Main Customer No."; Rec."Main Customer No.")
    //             {
    //             }
    //             field(gSocialSecurityNo; Rec.GSocialSecurityNo)
    //             {
    //                 Caption = 'Customer Social Security No.';
    //                 Editable = false;
    //             }
    //             field("Cust. Mobile No."; Rec."Cust. Mobile No.")
    //             {
    //             }
    //             field("Cust. Phone No."; Rec."Cust. Phone No.")
    //             {
    //             }
    //             field("Cust. E-Mail"; Rec."Cust. E-Mail")
    //             {
    //             }
    //             field("Cust. Post Code"; Rec."Cust. Post Code")
    //             {
    //             }
    //             field("Cust. Address"; Rec."Cust. Address")
    //             {
    //             }
    //             field("Cust. Address 2"; Rec."Cust. Address 2")
    //             {
    //             }
    //             field("Contact Target"; Rec."Contact Target")
    //             {
    //             }
    //             field("Main Associate No."; Rec."Main Associate No.")
    //             {
    //             }
    //             field("Main Associate Name"; Rec."Main Associate Name")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Main Associate Mobile No."; Rec."Main Associate Mobile No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Main Associate Phone No."; Rec."Main Associate Phone No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Main Associate Address"; Rec."Main Associate Address")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Main Associate Address 2"; Rec."Main Associate Address 2")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Sub Associate No."; Rec."Sub Associate No.")
    //             {
    //             }
    //             field("Sub Associate Name"; Rec."Sub Associate Name")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Sub Associate Mobile No."; Rec."Sub Associate Mobile No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Sub Associate Phone No."; Rec."Sub Associate Phone No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Sub Associate Address"; Rec."Sub Associate Address")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Sub Associate Address 2"; Rec."Sub Associate Address 2")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Customer No. 2"; Rec."Customer No. 2")
    //             {
    //                 Visible = false;
    //             }
    //             field("Customer Name 2"; Rec."Customer Name 2")
    //             {
    //                 Visible = false;
    //             }
    //             field("Customer No. 3"; Rec."Customer No. 3")
    //             {
    //                 Visible = false;
    //             }
    //             field("Customer Name 3"; Rec."Customer Name 3")
    //             {
    //                 Visible = false;
    //             }
    //             field("Transfer Litigation"; Rec."Transfer Litigation")
    //             {
    //             }
    //             field("Transfer Date"; Rec."Transfer Date")
    //             {
    //             }
    //             field("Reminder Date 1"; Rec."Reminder Date 1")
    //             {
    //             }
    //             field("Reminder Date 2"; Rec."Reminder Date 2")
    //             {
    //             }
    //             field("Revocation Register"; Rec."Revocation Register")
    //             {
    //                 Visible = false;
    //             }
    //             field("Revocation Date"; Rec."Revocation Date")
    //             {
    //             }
    //             field("Revocation Document No."; Rec."Revocation Document No.")
    //             {
    //             }
    //             field("Revocation Employee Name"; Rec."Revocation Employee Name")
    //             {
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control20; Rec."DK_Selected Contract Facbox")
    //         {
    //         }
    //         part(Control5;Rec."DK_Cemetery Detail Factbox")
    //         {
    //             SubPageLink = "Cemetery Code"=FIELD("Cemetery Code");
    //         }
    //         systempart(Control92;Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Corpse Filter")
    //         {
    //             AccessByPermission = TableData DK_Contract=R;
    //             ApplicationArea = Basic,Suite;
    //             Caption = 'Corpse Filter';
    //             Image = EditFilter;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _CloseAction: Action;
    //                 _TempCorpse: Record DK_Corpse temporary;
    //             begin
    //                 _TempCorpse.Init;
    //                 _TempCorpse."Contract No." := 'TEST';
    //                 _TempCorpse.Insert;


    //                 _CloseAction := PAGE.RunModal(PAGE::"DK_Filter Corpse in Contract", _TempCorpse);
    //                 if (_CloseAction <> ACTION::LookupOK) then
    //                   exit;

    //                 if _TempCorpse.Name <> '' then begin
    //                   SetRange("Corpse Name Filter", _TempCorpse.Name);
    //                   SetRange("Corpse Exists", true);
    //                 end else begin
    //                   SetRange("Corpse Name Filter");
    //                   SetRange("Corpse Exists");
    //                 end;
    //             end;
    //         }
    //         action("Clear Corpse Filter")
    //         {
    //             ApplicationArea = Basic,Suite;
    //             Caption = 'Clear Corpse Filter';
    //             Image = RemoveFilterLines;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _CloseAction: Action;
    //                 _TempCorpse: Record DK_Corpse temporary;
    //             begin
    //                 SetRange("Corpse Name Filter");
    //                 SetRange("Corpse Exists");
    //             end;
    //         }
    //         action("Select Contract")
    //         {
    //             Caption = 'Select Contract';
    //             Image = SelectLineToApply;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _SelectedContract: Record "DK_Selected Contract";
    //                 _Contract: Record DK_Contract;
    //             begin

    //                 CurrPage.SetSelectionFilter(_Contract);

    //                 if _Contract.FindFirst then begin
    //                   repeat
    //                     if not _SelectedContract.Get(UserId, _Contract."No.") then begin
    //                         _SelectedContract.Init;
    //                         _SelectedContract."USER ID" := UserId;
    //                         _SelectedContract."Contract No." := _Contract."No.";
    //                         _SelectedContract."Cemetery Code" := _Contract."Cemetery Code";
    //                         _SelectedContract."Cemetery No." := _Contract."Cemetery No.";

    //                         _Contract.CalcFields("Cust. Mobile No.");
    //                         _SelectedContract."Cust. Mobile No." := _Contract."Cust. Mobile No.";

    //                         _SelectedContract.Insert;
    //                     end;
    //                   until _Contract.Next = 0;
    //                 end;
    //             end;
    //         }
    //         action("Evaluation Change")
    //         {
    //             Caption = 'Evaluation Change';
    //             Image = CustomerRating;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _Contract: Record DK_Contract;
    //                 _EvaluationChange: Report "DK_Evaluation Change";
    //             begin

    //                 Clear(_EvaluationChange);
    //                 CurrPage.SetSelectionFilter(_Contract);
    //                 if _Contract.IsEmpty then
    //                   Error(MSG001,_Contract.TableCaption);

    //                 _EvaluationChange.SetTableView(_Contract);
    //                 _EvaluationChange.RunModal;

    //                 CurrPage.Update;
    //             end;
    //         }
    //         action("Send SMS")
    //         {
    //             Caption = 'Send SMS';
    //             Image = SendTo;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _SMSSend: Page "DK_SMS Send";
    //             begin
    //                 Clear(_SMSSend);
    //                 _SMSSend.Editable(true);
    //                 _SMSSend.SetSelectContract("No.");
    //                 _SMSSend.RunModal;
    //             end;
    //         }
    //         action("Calculation of Admin. Expense")
    //         {
    //             Caption = 'Calculation of Admin. Expense';
    //             Image = CalculateBalanceAccount;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _CalcAdminExpense: Page "DK_Calc. Admin. Expense";
    //                                        _Contract: Record DK_Contract;
    //             begin

    //                 _Contract.Reset;
    //                 _Contract.SetRange("No." ,"No.");
    //                 if _Contract.FindSet then begin
    //                   Clear(_CalcAdminExpense);
    //                   _CalcAdminExpense.LookupMode(true);
    //                   _CalcAdminExpense.SetTableView(_Contract);
    //                   _CalcAdminExpense.SetRecord(_Contract);
    //                   _CalcAdminExpense.RunModal;
    //                 end else begin
    //                   Error(MSG001);
    //                 end;
    //             end;
    //         }
    //         action("Delay Interest Amount")
    //         {
    //             Caption = 'Delay Interest Amount';
    //             Enabled = false;
    //             Image = CalculateBalanceAccount;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             Visible = false;

    //             trigger OnAction()
    //             var
    //                 _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    //             begin
    //                 Clear(_AdminExpenseMgt);
    //                 _AdminExpenseMgt.MessageDelayInterestAmount("No.");
    //             end;
    //         }
    //         action("Calculation of Delay Interest")
    //         {
    //             Caption = 'Calculation of Delay Interest';
    //             Image = CalculateBalanceAccount;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _Contract: Record DK_Contract;
    //                 _CalcDelayIntAmount: Page "DK_Calc. Delay Int. Amount";
    //                                          _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    //                                          _DelayInterestAmt: Decimal;
    //             begin

    //                 if "No." = '' then
    //                   Error(MSG004);

    //                 _Contract.Reset;
    //                 _Contract.SetRange("No.","No.");
    //                 if _Contract.FindSet then begin
    //                   if (_Contract."General Expiration Date" = 0D) and (_Contract."Land. Arc. Expiration Date" = 0D) then
    //                     Error(MSG005);

    //                   if (_Contract."General Expiration Date" > Today) and (_Contract."Land. Arc. Expiration Date" = 0D) then
    //                     Error(MSG005);

    //                   if (_Contract."General Expiration Date" > Today) and (_Contract."Land. Arc. Expiration Date" > Today) then
    //                     Error(MSG005);

    //                   Clear(_CalcDelayIntAmount);
    //                   _CalcDelayIntAmount.SetParameter(0D,'');
    //                   _CalcDelayIntAmount.LookupMode(true);
    //                   _CalcDelayIntAmount.SetTableView(_Contract);
    //                   _CalcDelayIntAmount.SetRecord(_Contract);
    //                   _CalcDelayIntAmount.RunModal;
    //                 end else begin
    //                   Error(MSG004);
    //                 end;
    //             end;
    //         }
    //         action("Open NAS Contract Folder")
    //         {
    //             Caption = 'Open NAS Contract Folder';
    //             Image = BOMVersions;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _FunSetup: Record "DK_Function Setup";
    //                 _CommFunction: Codeunit "DK_Common Function";
    //             begin
    //                 _FunSetup.Get;
    //                 if _FunSetup."NAS Contract File Folder" = '' then
    //                   Error(MSG002);

    //                 if "Cemetery No." = '' then
    //                   Error(MSG003, FieldCaption("Cemetery No."));

    //                 Clear(_CommFunction);
    //                 _CommFunction.OpenFolderClient(_FunSetup."NAS Contract File Folder", "Cemetery No.");
    //             end;
    //         }
    //         action(ChangeEvaluation)
    //         {
    //             Caption = 'Change Litigation Evaluation';
    //             Image = ChangeLog;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _ChangeLitiEvaluation: Page "DK_Change Liti. Evaluation";
    //             begin

    //                 _ChangeLitiEvaluation.Run;
    //             end;
    //         }
    //         group(Action73)
    //         {
    //             action("Posted Payment Receipt")
    //             {
    //                 Caption = 'Posted Payment Receipt';
    //                 Image = PostedPayment;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Post Pay. Receipt Doc. List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Posted Payment Refund")
    //             {
    //                 Caption = 'Posted Payment Refund';
    //                 Image = PostedCreditMemo;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Post. Pay. Refund Doc. List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Contract Amount Ledger")
    //             {
    //                 Caption = 'Contract Amount Ledger';
    //                 Image = LedgerEntries;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Contract Amount Ledger";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Admin. Expense Ledger")
    //             {
    //                 Caption = 'Admin. Expense Ledger';
    //                 Image = LedgerEntries;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Admin. Expense Ledger";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Report Printing History")
    //             {
    //                 Caption = 'Report Printing History';
    //                 Image = PrintChecklistReport;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Report Printing History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Sended SMS History")
    //             {
    //                 Caption = 'Sended SMS History';
    //                 Image = SendElectronicDocument;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Sended SMS History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Litigation Lawsuit History")
    //             {
    //                 Caption = 'Litigation Lawsuit History';
    //                 Image = CheckList;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Liti. Law. History List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Change Evaluation History")
    //             {
    //                 Caption = 'Change Evaluation History';
    //                 Image = History;
    //                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
    //                 //PromotedCategory = "Report";
    //                 RunObject = Page "DK_Change Evaluation History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //         }
    //     }
    // }

    // trigger OnAfterGetRecord()
    // begin
    //     GetSocialSecurityNo;
    // end;

    // trigger OnOpenPage()
    // begin
    //     FilterGroup(2);
    //     SetRange("Date Filter",0D,Today);
    //     FilterGroup(0);
    // end;

    // var
    //     MSG001: Label 'Please select %1.';
    //     ComFunction: Codeunit "DK_Common Function";
    //     gSocialSecurityNo: Text[30];
    //     MSG002: Label 'The NAS server folder was not specified in the Function settings. Please contact your administrator.';
    //     MSG003: Label 'The %1 could not be found in this Contract Document.';
    //     MSG004: Label 'Please enter your Contract No first';
    //     MSG005: Label 'Delay interest did not occur.';

    // local procedure ProcessingHistory()
    // var
    //     _DK_SelectedContractMatrix: Page "DK_Selected Contract Matrix";
    // begin
    //     _DK_SelectedContractMatrix.Run;
    // end;

    // local procedure GetSocialSecurityNo()
    // var
    //     _DK_Customer: Record DK_Customer;
    // begin
    //     Clear(gSocialSecurityNo);
    //     if _DK_Customer.Get("Main Customer No.") then begin
    //       gSocialSecurityNo := _DK_Customer.GetSSNSSNCalculated;
    //     end;
    // end;
}

