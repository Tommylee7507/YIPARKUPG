page 50037 "DK_Contract List"////zzz
{
    // 
    // #HO005 :2020-07-14
    //   - Add Field :"Honorstone Fir. Cor. Ex. Date"
    // *DK32 : 20200715
    //   - Add Field : "Admin. Exp. Start Date"
    // 
    // *DK34 : 20201019
    //   - Add Field : "Main Kinsman Name","Main Kinsman Mobile No.","Main Kinsman Phone No.","Main Kinsman E-Mail"
    //                 "Main Kinsman Post Code","Main Kinsman Address","Main Kinsman Address 2"
    //                 "Sub Kinsman Name","Sub Kinsman Mobile No.","Sub Kinsman Phone No.","Sub Kinsman E-Mail"
    //                 "Sub Kinsman Post Code","Sub Kinsman Address","Sub Kinsman Address 2"
    //       : 20201020
    //   - Rec. Modify Action : Action156 -> visible: FALSE
    //       : 20201022
    //   - Add Var: ExchangeVisible
    //   - Add Function: SetExchangeActionVisible
    //   - Rec. Modify Trigger: OnOpenPage()
    //       : 20201117
    //   - Add Field: "Department Code", "Department Name"
    // 
    // DK35: 20210121
    //   - Delete Field: Kinsman Field...

    Caption = 'Contract List';
    CardPageID = "DK_Contract Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Contract;
    ////zzz
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
    //             field("First Laying Date"; Rec."First Laying Date")
    //             {
    //             }
    //             field("Contract Date Check"; Rec."Contract Date Check")
    //             {
    //             }
    //             field("Supervise No."; Rec."Supervise No.")
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
    //             field("Main Customer No."; Rec."Main Customer No.")
    //             {
    //             }
    //             field("Main Customer Name"; Rec."Main Customer Name")
    //             {
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
    //             field("Cemetery Code"; Rec."Cemetery Code")
    //             {
    //                 ShowMandatory = true;
    //                 Visible = false;
    //             }
    //             field("Cemetery No."; Rec."Cemetery No.")
    //             {
    //             }
    //             field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
    //             {
    //             }
    //             field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
    //             {
    //             }
    //             field("Cemetery Class"; Rec."Cemetery Class")
    //             {
    //             }
    //             field("Unit Price Type Name"; Rec."Unit Price Type Name")
    //             {
    //             }
    //             field("Cemetery Size"; Rec."Cemetery Size")
    //             {
    //             }
    //             field("Cemetery Size 2"; Rec."Cemetery Size 2")
    //             {
    //                 Visible = false;
    //             }
    //             field("Landscape Architecture"; Rec."Landscape Architecture")
    //             {
    //             }
    //             field("Litigation Evaluation"; Rec."Litigation Evaluation")
    //             {
    //             }
    //             field("General Expiration Date"; Rec."General Expiration Date")
    //             {
    //                 Editable = false;
    //             }
    //             field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
    //             {
    //                 Editable = false;
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
    //                     Rec.OpenAdminExpeseLedger(1);
    //                 end;
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
    //             field("Total Contract Amount"; Rec."Total Contract Amount")
    //             {
    //                 Style = AttentionAccent;
    //                 StyleExpr = TRUE;
    //             }
    //             field("Rece. Remaining Amount"; Rec."Rece. Remaining Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
    //             {
    //                 Editable = false;
    //                 Style = Attention;
    //                 StyleExpr = TRUE;
    //             }
    //             field("Deposit Receipt Date"; Rec."Deposit Receipt Date")
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
    //             field("Associate Relationship"; Rec."Associate Relationship")
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
    //             field("Cust. Mobile No. 2"; Rec."Cust. Mobile No. 2")
    //             {
    //                 Visible = false;
    //             }
    //             field("Cust. Mobile No. 3"; Rec."Cust. Mobile No. 3")
    //             {
    //                 Visible = false;
    //             }
    //             field("Overdue Sticker"; Rec."Overdue Sticker")
    //             {
    //                 Visible = false;
    //             }
    //             field("Overdue Sticker Date"; Rec."Overdue Sticker Date")
    //             {
    //                 Visible = false;
    //             }
    //             field("Revocation Register"; Rec."Revocation Register")
    //             {
    //                 Visible = false;
    //             }
    //             field("Revocation Date"; Rec."Revocation Date")
    //             {
    //             }
    //             field("Revocation Amount"; Rec."Revocation Amount")
    //             {
    //             }
    //             field("Close Amount"; Rec."Close Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Revocation Document No."; Rec."Revocation Document No.")
    //             {
    //             }
    //             field("Revocation Employee Name"; Rec."Revocation Employee Name")
    //             {
    //             }
    //             field("Admin. Exp. Start Date"; Rec."Admin. Exp. Start Date")
    //             {
    //             }
    //             field("VIP Exists"; Rec."VIP Exists")
    //             {
    //             }
    //             field(Caution; Rec.Caution)
    //             {
    //             }
    //             field("Counsel History Op. Count"; Rec."Counsel History Op. Count")
    //             {
    //                 Visible = false;
    //             }
    //             field("Last Date Cust. Request"; Rec."Last Date Cust. Request")
    //             {
    //             }
    //             field("Customer Request Count"; Rec."Customer Request Count")
    //             {
    //             }
    //             field("Transfer Litigation"; Rec."Transfer Litigation")
    //             {
    //             }
    //             field("Transfer Date"; Rec."Transfer Date")
    //             {
    //             }
    //             field("Department Code"; Rec."Department Code")
    //             {
    //             }
    //             field("Department Name"; Rec."Department Name")
    //             {
    //             }
    //             field("CRM SalesPerson"; Rec."CRM SalesPerson")
    //             {
    //                 Visible = false;
    //             }
    //             field("CRM External Sales"; Rec."CRM External Sales")
    //             {
    //                 Visible = false;
    //             }
    //             field("CRM Funeral Hall"; Rec."CRM Funeral Hall")
    //             {
    //                 Visible = false;
    //             }
    //             field("CRM Funeral Service"; Rec."CRM Funeral Service")
    //             {
    //                 Visible = false;
    //             }
    //             field("CRM Channel Vendor"; Rec."CRM Channel Vendor")
    //             {
    //             }
    //             field("CRM Sales Type"; Rec."CRM Sales Type")
    //             {
    //             }
    //             field("Last Daily Batch Run Date"; Rec."Last Daily Batch Run Date")
    //             {
    //                 Visible = false;
    //             }
    //             field("CRM SEDN ISSUE"; Rec."CRM SEDN ISSUE")
    //             {
    //             }
    //             field("CRM ISSUE DATE"; Rec."CRM ISSUE DATE")
    //             {
    //             }
    //             field("CRM ISSUE TIME"; Rec."CRM ISSUE TIME")
    //             {
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control87; Rec."DK_Selected Contract Facbox")
    //         {
    //         }
    //         part(Control64;Rec."DK_Cemetery Detail Factbox")
    //         {
    //             SubPageLink = "Cemetery Code"=FIELD("Cemetery Code");
    //         }
    //         part(Control85;Rec."DK_Interest Cemetery Log")
    //         {
    //             SubPageLink = "Cemetery Code"=FIELD("Cemetery Code");
    //         }
    //         systempart(Control9;Notes)
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

    //                         if _Contract."Contact Target" = _Contract."Contact Target"::MainAssociate then begin

    //                           _Contract.CalcFields("Main Associate Mobile No.","Main Associate Name");
    //                           _SelectedContract."Cust. Mobile No." := _Contract."Main Associate Mobile No.";
    //                           _SelectedContract."Contact Name" := _Contract."Main Associate Name";

    //                         end else if _Contract."Contact Target" = _Contract."Contact Target"::SubAssociate then begin

    //                           _Contract.CalcFields("Sub Associate Mobile No.","Sub Associate Name");
    //                           _SelectedContract."Cust. Mobile No." := _Contract."Sub Associate Mobile No.";
    //                           _SelectedContract."Contact Name" := _Contract."Sub Associate Name";
    //                         end else begin
    //                           //Main Customer
    //                           _Contract.CalcFields("Cust. Mobile No.");
    //                           _SelectedContract."Cust. Mobile No." := _Contract."Cust. Mobile No.";
    //                           _SelectedContract."Contact Name" := _Contract."Main Customer Name";
    //                         end;

    //                         _SelectedContract.Insert;
    //                     end;
    //                   until _Contract.Next = 0;
    //                 end;
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
    //         action(Corpse)
    //         {
    //             Caption = 'Corpse';
    //             Image = BusinessRelation;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _Corpse: Page "DK_Corpse List";
    //                              _CorpseRec: Record DK_Corpse;
    //             begin
    //                 Clear(_Corpse);

    //                 _CorpseRec.SetRange("Contract No.", "No.");

    //                 _Corpse.SetParameter("No.","Supervise No.", "Cemetery Code");

    //                 _Corpse.LookupMode(true);
    //                 _Corpse.SetTableView(_CorpseRec);
    //                 _Corpse.Run;
    //             end;
    //         }
    //         action("Relationship Family")
    //         {
    //             Caption = 'Relationship Family';
    //             Image = AssemblyBOM;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _RelationshipFamily: Page "DK_Relationship Family List";
    //                                          _RelationshipFamilyRec: Record "DK_Relationship Family";
    //             begin
    //                 Clear(_RelationshipFamily);

    //                 _RelationshipFamilyRec.SetRange("Contract No.", "No.");

    //                 _RelationshipFamily.SetParameter("No.","Supervise No.", "Cemetery Code");

    //                 _RelationshipFamily.LookupMode(true);
    //                 _RelationshipFamily.SetTableView(_RelationshipFamilyRec);
    //                 _RelationshipFamily.Run;
    //             end;
    //         }
    //         action("Landscape Architecture Picture")
    //         {
    //             Caption = 'Landscape Architecture Picture';
    //             Image = Picture;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             var
    //                 _LandArchPicture: Page "DK_Land. Arch. Picture";
    //                                       _LandArchPictureRec: Record "DK_Land. Arch. Picture";
    //             begin
    //                 Clear(_LandArchPicture);

    //                 _LandArchPictureRec.SetRange("Contract No.", "No.");

    //                 _LandArchPicture.SetParameter("No.","Supervise No.", "Cemetery Code");

    //                 _LandArchPicture.LookupMode(true);
    //                 _LandArchPicture.SetTableView(_LandArchPictureRec);
    //                 _LandArchPicture.Run;
    //             end;
    //         }
    //         action("Calculation of Admin. Expense")
    //         {
    //             Caption = 'Calculation of Admin. Expense';
    //             Image = CalculateBalanceAccount;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _CalcAdminExpense: Page "DK_Calc. Admin. Expense";
    //                                        _Contract: Record DK_Contract;
    //             begin

    //                 if "No." = '' then
    //                   Error(MSG006);

    //                 _Contract.Reset;
    //                 _Contract.SetRange("No." ,"No.");
    //                 if _Contract.FindSet then begin
    //                   Clear(_CalcAdminExpense);
    //                   _CalcAdminExpense.LookupMode(true);
    //                   _CalcAdminExpense.SetTableView(_Contract);
    //                   _CalcAdminExpense.SetRecord(_Contract);
    //                   _CalcAdminExpense.RunModal;
    //                 end else begin
    //                   Error(MSG007);
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
    //                   Error(MSG001);

    //                 if "Cemetery No." = '' then
    //                   Error(MSG002, FieldCaption("Cemetery No."));

    //                 Clear(_CommFunction);
    //                 _CommFunction.OpenFolderClient(_FunSetup."NAS Contract File Folder", "Cemetery No.");
    //             end;
    //         }
    //         action("Change Customer in Customer")
    //         {
    //             Caption = 'Change Customer in Customer';
    //             Image = ChangeCustomer;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             RunObject = Page "DK_Cng. Cust. in Contract List";
    //                             RunPageLink = "Contract No."=FIELD("No.");
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
    //         action("Customer Certficate Request")
    //         {
    //             Caption = 'Customer Certficate Request';
    //             Image = Approval;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             Visible = false;

    //             trigger OnAction()
    //             var
    //                 _Contract: Record DK_Contract;
    //                 _CustomerCertficateHistory: Codeunit "DK_Customer Certficate History";
    //             begin
    //                 /*
    //                 CurrPage.SETSELECTIONFILTER(_Contract);
    //                 IF _Contract.FINDSET THEN BEGIN
    //                   IF NOT CONFIRM(MSG003,FALSE) THEN EXIT;

    //                   REPEAT
    //                     _CustomerCertficateHistory.Request(_Contract);
    //                   UNTIL _Contract.NEXT = 0;
    //                   MESSAGE(MSG005);
    //                 END ELSE BEGIN
    //                   ERROR(MSG004);
    //                 END;
    //                 */

    //             end;
    //         }
    //         action("Customer Requests List")
    //         {
    //             Caption = 'Customer Requests List';
    //             Ellipsis = true;
    //             Image = Absence;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             begin


    //                 DK_CustomerRequestsAll.SetContract(Rec);
    //                 DK_CustomerRequestsAll.Run;
    //                 // "DK_Customer Requests All"
    //             end;
    //         }
    //         action(ExchangeOfLand)
    //         {
    //             Caption = 'ExchangeOfLand';
    //             Ellipsis = true;
    //             Image = ChangeTo;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             ToolTip = 'This function is available for Bongandang or Sky Damjae graveyard. The Status and the end of management change when using the feature.';
    //             Visible = ExchangeVisible;

    //             trigger OnAction()
    //             var
    //                 _ContractMgt: Codeunit "DK_Contract Mgt.";
    //             begin

    //                 if Confirm(MSG008) then
    //                   _ContractMgt.ExchangeOfLand(Rec);
    //             end;
    //         }
    //         action("Exchange Of Land Cancel")
    //         {
    //             Caption = 'Exchange Of Land Cancel';
    //             Ellipsis = true;
    //             Image = ReopenCancelled;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             ToolTip = 'This function is available for Bongandang or Sky Damjae graveyard. The Status and the end of management change when using the feature.';
    //             Visible = ExchangeVisible;

    //             trigger OnAction()
    //             var
    //                 _ContractMgt: Codeunit "DK_Contract Mgt.";
    //             begin

    //                 if Confirm(MSG008) then
    //                   _ContractMgt.ExchangeOfLandCancel(Rec);
    //             end;
    //         }
    //         group(Action23)
    //         {
    //             action("Payment Expect Document")
    //             {
    //                 Caption = 'Payment Expect Document';
    //                 Image = ReceiptLines;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Pay. Expect Document List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");

    //                 trigger OnAction()
    //                 var
    //                     _PayRecDoc: Record "DK_Payment Receipt Document";
    //                 begin
    //                 end;
    //             }
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
    //             action("Cemetery Payment Confirm")
    //             {
    //                 Caption = 'Cemetery Payment Confirm';
    //                 Image = "Report";
    //                 Promoted = true;
    //                 PromotedCategory = "Report";

    //                 trigger OnAction()
    //                 begin
    //                     CementeryPaymentRun;
    //                 end;
    //             }
    //             action("Cemetry Ledger N")
    //             {
    //                 Caption = 'Cemetry Ledger N';
    //                 Image = PrintReport;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";

    //                 trigger OnAction()
    //                 var
    //                     _Contract: Record DK_Contract;
    //                     _CemetryLedgerN: Report "DK_Cemetry Ledger N";
    //                 begin

    //                     _Contract.Reset;
    //                     _Contract.SetRange("No.","No.");

    //                     Clear(_CemetryLedgerN);
    //                     _CemetryLedgerN.SetTableView(_Contract);
    //                     _CemetryLedgerN.RunModal;
    //                 end;
    //             }
    //             action("Publish Admin. Expense List")
    //             {
    //                 Caption = 'Publish Admin. Expense List';
    //                 Image = ReceivableBill;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";

    //                 trigger OnAction()
    //                 var
    //                     _DetailPublishAdExList: Page "DK_Detail Publish Ad. Ex. List";
    //                                                 _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
    //                 begin

    //                     _PublishAdminExpDocLine.Reset;
    //                     _PublishAdminExpDocLine.SetRange("Contract No.", "No.");

    //                     Clear(_DetailPublishAdExList);
    //                     _DetailPublishAdExList.LookupMode(true);
    //                     _DetailPublishAdExList.SetTableView(_PublishAdminExpDocLine);
    //                     _DetailPublishAdExList.SetRecord(_PublishAdminExpDocLine);
    //                     _DetailPublishAdExList.Editable(false);
    //                     _DetailPublishAdExList.RunModal;
    //                 end;
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
    //             action("Report Printing History")
    //             {
    //                 Caption = 'Report Printing History';
    //                 Image = PrintChecklistReport;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Report Printing History";
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
    //             action("Group Sub List")
    //             {
    //                 Caption = 'Group Sub List';
    //                 Enabled = "Contract Type" = "Contract Type"::Group;
    //                 Image = CustomerList;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";

    //                 trigger OnAction()
    //                 var
    //                     _Contract: Record DK_Contract;
    //                     _ContractList: Page "DK_Contract List";
    //                 begin

    //                     _Contract.Reset;
    //                     _Contract.SetRange("Group Contract No.","No.");
    //                     _Contract.SetRange("Contract Type",_Contract."Contract Type"::Sub);

    //                     Clear(_ContractList);
    //                     _ContractList.LookupMode(true);
    //                     _ContractList.SetTableView(_Contract);
    //                     _ContractList.SetRecord(_Contract);
    //                     _ContractList.RunModal;
    //                 end;
    //             }
    //         }
    //     }
    // }

    // trigger OnOpenPage()
    // begin
    //     FilterGroup(2);
    //     SetRange("Date Filter",0D,Today);
    //     FilterGroup(0);

    //     //>>DK34
    //     ExchangeVisible := SetExchangeActionVisible();
    //     //<<
    // end;

    // var
    //     ContractMgt: Codeunit "DK_Contract Mgt.";
    //     ComFunction: Codeunit "DK_Common Function";
    //     MSG001: Label 'The NAS server folder was not specified in the Function settings. Please contact your administrator.';
    //     MSG002: Label 'The %1 could not be found in this Contract Document.';
    //     MSG003: Label 'Would you like to request approval for the selected contracts?';
    //     MSG004: Label 'No contract selected.';
    //     MSG005: Label 'Request for approval has been completed.';
    //     MSG006: Label 'Please enter your Contract No first';
    //     MSG007: Label 'No contract found.';
    //     ExchangeVisible: Boolean;
    //     MSG008: Label 'The Status and end-of-management date are changed. Do you want to continue?';
    //     DK_CustomerRequestsAll: Page "DK_Customer Requests All";

    // procedure SelectActiveContracts(): Text
    // var
    //     _Contract: Record DK_Contract;
    // begin
    //     exit(SelectInContractList(_Contract));
    // end;

    // procedure GetSelectionFilter(): Text
    // var
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;
    //     _Contract: Record DK_Contract;
    // begin
    //     CurrPage.SetSelectionFilter(_Contract);
    //     exit(SelectionFilterManagement.GetSelectionFilterForContract(_Contract));
    // end;

    // local procedure SelectInContractList(var pContract: Record DK_Contract): Text
    // var
    //     ContractListPage: Page "DK_Contract List";
    // begin

    //     ContractListPage.SetTableView(pContract);
    //     ContractListPage.LookupMode(true);
    //     if ContractListPage.RunModal = ACTION::LookupOK then
    //         exit(ContractListPage.GetSelectionFilter);
    // end;

    // local procedure CementeryPaymentRun()
    // var
    //     _CemeteryPaymentConfirm: Report "DK_Cemetery Payment Confirm";
    // begin
    //     _CemeteryPaymentConfirm.SetParm("No.");
    //     _CemeteryPaymentConfirm.RunModal;
    // end;

    // local procedure SetExchangeActionVisible(): Boolean
    // var
    //     _UserSetup: Record "User Setup";
    // begin

    //     _UserSetup.Reset;
    //     _UserSetup.SetRange("User ID", UserId);
    //     _UserSetup.SetRange("DK_Exchange of Land Admin.", true);
    //     if _UserSetup.FindSet then
    //         exit(true);
    // end;
}

