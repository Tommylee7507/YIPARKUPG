page 50153 "DK_Counsel Litigation" ////zzz
{
    // 
    // #2044 : 2020-07-23
    //   - Rec. Modify Page Caption: ŒÁ‰½ ‹Ý„Ì -> ×„ ‹Ý„Ì

    Caption = 'Counsel Litigtion';
    DelayedInsert = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Counsel History";
    SourceTableView = WHERE(Type = CONST(Litigation));

    // layout 
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             field(Date; Rec.Date)
    //             {
    //                 Editable = false;
    //                 ShowMandatory = true;
    //             }
    //             field("Counsel Time"; Rec."Counsel Time")
    //             {
    //                 ShowMandatory = true;
    //             }
    //             field("Employee No."; Rec."Employee No.")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Employee Name"; Rec."Employee Name")
    //             {
    //                 ShowMandatory = true;
    //             }
    //             field("Contract No."; Rec."Contract No.")
    //             {
    //                 ShowMandatory = true;
    //             }
    //             field("Supervise No."; Rec."Supervise No.")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("Cemetery Code"; Rec."Cemetery Code")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Importance = Additional;
    //                 Lookup = false;
    //                 Visible = false;
    //             }
    //             field("Cemetery No."; Rec."Cemetery No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 ShowMandatory = true;
    //             }
    //             group(Control13)
    //             {
    //                 ShowCaption = false;
    //                 field("Litigation Type"; Rec."Litigation Type")
    //                 {
    //                     ShowMandatory = true;
    //                 }
    //                 field("Contact Method"; Rec."Contact Method")
    //                 {
    //                     ShowMandatory = true;
    //                 }
    //                 field("Counsel Target"; Rec."Counsel Target")
    //                 {
    //                     ShowMandatory = true;
    //                 }
    //             }
    //             field("Deposit Plan Date"; Rec."Deposit Plan Date")
    //             {
    //             }
    //             field("Result Process"; Rec."Result Process")
    //             {
    //             }
    //         }
    //         group(Content)
    //         {
    //             Caption = 'Content';
    //             group("Counsel Content")
    //             {
    //                 Caption = 'Counsel Content';
    //                 field(Control19; Rec."Counsel Content")
    //                 {
    //                     Editable = NOT EditWorkLitiCon;
    //                     MultiLine = true;
    //                     ShowCaption = false;
    //                     ShowMandatory = true;

    //                     trigger OnValidate()
    //                     begin
    //                         if Rec."Result Process" <> Rec."Result Process"::Receipt then
    //                             Error(MSG002);

    //                         Rec.SetWorkLitigationContent(WorkLitigationContent);
    //                     end;
    //                 }
    //             }
    //         }
    //         group(Control35)
    //         {
    //             Caption = 'Request Delete';
    //             field("Request Del"; Rec."Request Del")
    //             {
    //             }
    //             field("Request DateTime"; Rec."Request DateTime")
    //             {
    //             }
    //             field("Request Person"; Rec."Request Person")
    //             {
    //             }
    //         }
    //         group(Information)
    //         {
    //             Caption = 'Information';
    //             field("Creation Date"; Rec."Creation Date")
    //             {
    //             }
    //             field("Creation Person"; Rec."Creation Person")
    //             {
    //             }
    //             field("Last Date Modified"; Rec."Last Date Modified")
    //             {
    //             }
    //             field("Last Modified Person"; Rec."Last Modified Person")
    //             {
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control11; Rec."DK_Counsel Litigation Factbox")
    //         {
    //             SubPageLink = Rec."Contract No." = FIELD("Contract No."),
    //                           Type = FIELD(Type),
    //                           Rec."Delete Row" = CONST(false);
    //         }
    //         part(Control14; Rec."DK_Contract Detail Factbox")
    //         {
    //             SubPageLink = Rec."No." = FIELD("Contract No.");
    //         }
    //         systempart(Control27; Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(ReOpen)
    //         {
    //             Caption = 'ReOpen';
    //             Enabled = Rec."Result Process" <> Rec."Result Process"::Receipt;
    //             Image = ReOpen;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;

    //             trigger OnAction()
    //             begin
    //                 Rec.SetReceipt;
    //             end;
    //         }
    //         action(Completed)
    //         {
    //             Caption = 'Completed';
    //             Enabled = Rec."Result Process" = Rec."Result Process"::Receipt;
    //             Image = Completed;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;

    //             trigger OnAction()
    //             begin
    //                 Rec.SetCompleted;

    //                 Message(MSG001, Rec.FieldCaption("Result Process"), Rec."Result Process"::Completed);
    //             end;
    //         }
    //         group(Action34)
    //         {
    //             action("Calculation of Admin. Expense")
    //             {
    //                 Caption = 'Calculation of Admin. Expense';
    //                 Image = CalculateBalanceAccount;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _CalcAdminExpense: Page "DK_Calc. Admin. Expense";
    //                                            _Contract: Record DK_Contract;
    //                 begin
    //                     if Rec."Contract No." = '' then
    //                         Error(MSG004, Rec.FieldCaption("Contract No."));


    //                     _Contract.Reset;
    //                     _Contract.SetRange("No.", Rec."Contract No.");
    //                     if _Contract.FindSet then begin
    //                         Clear(_CalcAdminExpense);
    //                         _CalcAdminExpense.LookupMode(true);
    //                         _CalcAdminExpense.SetTableView(_Contract);
    //                         _CalcAdminExpense.SetRecord(_Contract);
    //                         _CalcAdminExpense.RunModal;
    //                     end else begin
    //                         Error(MSG005);
    //                     end;
    //                 end;
    //             }
    //             action("Delay Interest Amount")
    //             {
    //                 Caption = 'Delay Interest Amount';
    //                 Image = CalculateBalanceAccount;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    //                 begin
    //                     if Rec."Contract No." = '' then
    //                         Error(MSG004, Rec.FieldCaption("Contract No."));

    //                     Clear(_AdminExpenseMgt);
    //                     _AdminExpenseMgt.MessageDelayInterestAmount(Rec."Contract No.");
    //                 end;
    //             }
    //             action("Litigation Info")
    //             {
    //                 Caption = 'Litigation Info';
    //                 Ellipsis = true;
    //                 Image = PreviewChecks;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;

    //                 trigger OnAction()
    //                 var
    //                     _Contract: Record DK_Contract;
    //                     _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    //                 begin

    //                     _Contract.Reset;
    //                     _Contract.SetRange("No.", Rec."Contract No.");
    //                     _Contract.SetRange("Date Filter", 0D, Today);
    //                     if _Contract.FindSet then begin
    //                         _Contract.CalcFields("Cemetery Size", Rec."Non-Pay. General Amount", Rec."Non-Pay. Land. Arc. Amount");

    //                         Message(MSG006,
    //                         _Contract."General Expiration Date", // Ÿ‰¦ ýˆ« ‘Ž‡ßŸ
    //                         _Contract."Land. Arc. Expiration Date", // ‘†µ ýˆ« ‘Ž‡ßŸ
    //                         _RevocationContractMgt.CalcContractYearPreiod(_Contract."General Expiration Date", Today), // Ÿ‰¦ ‰œ‚‚ €Ëú
    //                         _RevocationContractMgt.CalcContractYearPreiod(_Contract."Land. Arc. Expiration Date", Today), // ‘†µ ‰œ‚‚ €Ëú
    //                         _Contract."Non-Pay. General Amount", // Ÿ‰¦ ‰œ‚‚Ž¸
    //                         _Contract."Non-Pay. Land. Arc. Amount", // ‘†µ ‰œ‚‚Ž¸
    //                         _Contract."Cemetery Size"); // –ÛŒ÷
    //                     end;
    //                 end;
    //             }
    //         }
    //         group(Action42)
    //         {
    //             action("Request Delete")
    //             {
    //                 Caption = 'Request Delete';
    //                 Image = DeleteAllBreakpoints;
    //                 Promoted = true;
    //                 PromotedCategory = Process;

    //                 trigger OnAction()
    //                 begin
    //                     if Rec."Contract No." <> '' then begin
    //                         Rec.Validate("Request Del", true);
    //                         Rec.Modify;
    //                     end;
    //                 end;
    //             }
    //             action("Cancel Request Delete")
    //             {
    //                 Caption = 'Cancel Request Delete';
    //                 Image = CancelAllLines;
    //                 Promoted = true;
    //                 PromotedCategory = Process;

    //                 trigger OnAction()
    //                 begin
    //                     if Rec."Contract No." <> '' then begin
    //                         Rec.Validate("Request Del", false);
    //                         Rec.Modify;
    //                     end;
    //                 end;
    //             }
    //         }
    //     }
    // }

    // trigger OnAfterGetRecord()
    // begin
    //     WorkLitigationContent := Rec.GetWorkLitigationContent;

    //     if Rec."Result Process" = Rec."Result Process"::Receipt then
    //         EditWorkLitiCon := false
    //     else
    //         EditWorkLitiCon := true;
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // var
    //     _Employee: Record DK_Employee;
    // begin
    //     Rec.Date := Today;
    //     Rec."Counsel Time" := Time;
    //     Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    // end;

    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // begin
    //     if (Rec."Line No." <> 0) and (idx = 0) then begin
    //         if Rec."Result Process" = Rec."Result Process"::Receipt then begin
    //             if Rec."Counsel Time" = 0T then
    //                 Error(MSG003, FieldCaption("Counsel Time"));
    //             if Rec."Employee Name" = '' then
    //                 Error(MSG003, FieldCaption("Employee Name"));
    //             if Rec."Contract No." = '' then
    //                 Error(MSG003, FieldCaption("Contract No."));
    //             if Rec."Litigation Type" = Rec."Litigation Type"::Blank then
    //                 Error(MSG003, FieldCaption("Litigation Type"));
    //             if Rec."Contact Method" = Rec."Contact Method"::Blank then
    //                 Error(MSG003, FieldCaption("Contact Method"));
    //             if Rec."Counsel Target" = Rec."Counsel Target"::Blank then
    //                 Error(MSG003, FieldCaption("Counsel Target"));
    //             if Rec."Counsel Content" = '' then
    //                 Error(MSG003, FieldCaption("Counsel Content"));
    //         end;
    //     end;
    // end;

    // var
    //     WorkLitigationContent: Text;
    //     MSG001: Label 'The %1 has been Rec. Modify to a %2.';
    //     EditWorkLitiCon: Boolean;
    //     MSG002: Label 'I can not change Value.';
    //     MSG003: Label '%1 is a required input value. You cannot exit this window.';
    //     MSG004: Label '%1 must be specified.';
    //     MSG005: Label 'Contract information not found';
    //     MSG006: Label 'Ÿ‰¦ ýˆ« ‘Ž‡ßŸ: %1\‘†µýˆ« ‘Ž‡ßŸ: %2\Ÿ‰¦ ýˆ«Š± ‰œ‚‚ €Ëú(‚Ë): %3\‘†µ ýˆ«Š± ‰œ‚‚ €Ëú(‚Ë): %4\Ÿ‰¦ ýˆ«Š± ‰œ‚‚ €¦Ž¸: %5\‘†µ ýˆ«Š± ‰œ‚‚ €¦Ž¸: %6\–ÛŒ÷: %7';
}

