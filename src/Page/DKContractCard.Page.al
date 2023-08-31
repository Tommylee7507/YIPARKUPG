page 50038 "DK_Contract Card"////zzz
{
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2019 - 2020-07-14
    //   - Rec. Modify Trigger: OnOpenPage
    //   - Add Function: CheckVIPCaution
    // *DK32 : 20200716
    //   - Add Field : "Estate Code"
    //                 "Admin. Expense Method"
    //                 "Admin. Exp. Start Date"
    //   - Rec. Modify Function : OnAfterGetRecord
    // 
    // #2087 : 20200821
    //   - Add Field : "VIP Reason Content"
    //   - Add Text Constants: MSG012
    //   - Rec. Modify Function: CheckVIPCaution
    //   - Rec. Modify Text Constants: MSG010
    // 
    // #2044 : 20200904
    //   - Rec. Modify Filed Caption: <DK_Counsel Litigation Subform>(ŒÁ‰½ ‹Ý„Ì †Ýž -> ×„ ‹Ý„Ì †Ýž)
    // 
    // *DK34 : 20201016
    //   - Add Field : "Counsel History Op. Count"
    //       : 20201020
    //   - Rec. Modify Action : Action156 -> visible: FALSE
    //       : 20201022
    //   - Add Var: ExchangeVisible
    //   - Add Function: SetExchangeActionVisible
    //   - Rec. Modify Trigger: OnAfterGetRecord(), OnAfterGetCurrRecord()
    // 
    // DK35: 20210121
    //   - Add Page Part: DK_Friends And Rel. Subform

    Caption = 'Contract Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Contract;////zzz

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             group(Control154)
    //             {
    //                 ShowCaption = false;
    //                 field("No."; Rec."No.")
    //                 {
    //                     Editable = false;
    //                     ShowMandatory = true;

    //                     trigger OnAssistEdit()
    //                     begin
    //                         Rec.AssistEdit(Rec);
    //                     end;
    //                 }
    //                 field("Supervise No."; Rec."Supervise No.")
    //                 {
    //                     Editable = false;
    //                     ShowMandatory = true;
    //                 }
    //                 field("Contract Type"; Rec."Contract Type")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Group Contract No."; Rec."Group Contract No.")
    //                 {
    //                     Editable = false;
    //                     Enabled = Rec."Contract Type" = Rec."Contract Type"::Sub;
    //                 }
    //                 field("Contract Date"; Rec."Contract Date")
    //                 {
    //                     Editable = false;
    //                     ShowMandatory = true;
    //                 }
    //                 field("Main Customer No."; Rec."Main Customer No.")
    //                 {
    //                     Editable = false;
    //                     ShowMandatory = true;
    //                 }
    //                 field("Main Customer Name"; Rec."Main Customer Name")
    //                 {
    //                     AssistEdit = false;
    //                     DrillDown = false;
    //                     Editable = false;
    //                     Lookup = false;
    //                 }
    //                 group(Control93)
    //                 {
    //                     ShowCaption = false;
    //                     field("Cemetery Code"; Rec."Cemetery Code")
    //                     {
    //                         Editable = false;
    //                         Importance = Additional;
    //                         ShowMandatory = true;

    //                         trigger OnValidate()
    //                         var
    //                             _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    //                             _UnitPrice: Decimal;
    //                             _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    //                             _Cemetery: Record DK_Cemetery;
    //                             _Contract: Record DK_Contract;
    //                             _CemeteryPrice: Codeunit "DK_Cemetery Price";
    //                         begin
    //                             if Rec."Cemetery Code" <> '' then begin
    //                                 if (Rec."Contract Type" = Rec."Contract Type"::General) or
    //                                     ((Rec."Contract Type" = Rec."Contract Type"::Group) and (Rec."Admin. Expense Option" = Rec."Admin. Expense Option"::"Per Group")) or
    //                                     ((Rec."Contract Type" = Rec."Contract Type"::Sub) and (Rec."Admin. Expense Option" = Rec."Admin. Expense Option"::"Per Contract")) then begin

    //                                     Rec.CalcFields("Admin. Expense Method");//DK32
    //                                     if _Cemetery.Get(Rec."Cemetery Code") then begin

    //                                         //>>DK32
    //                                         if Rec."Group Contract No." = '' then begin
    //                                             Rec.Validate("Cemetery Amount", _CemeteryPrice.GetCemAmount(_Cemetery, Rec."Contract Date") * _Cemetery.Size);
    //                                         end else begin
    //                                             if _Contract.Get(Rec."Group Contract No.") then begin
    //                                                 if Rec."Admin. Expense Option" = _Contract."Admin. Expense Option"::"Per Contract" then begin
    //                                                     Rec.Validate("Cemetery Amount", _CemeteryPrice.GetCemAmount(_Cemetery, Rec."Contract Date") * _Cemetery.Size);
    //                                                 end;
    //                                             end;
    //                                         end;
    //                                         //<<DK32

    //                                         if not (Rec."Admin. Expense Method" in [Rec."Admin. Expense Method"::"After Corpse 10"]) then begin//DK32
    //                                             Clear(_AdminExpenseMgt);
    //                                             _UnitPrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(Rec."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::General, Rec."Contract Date");
    //                                             Rec.Validate("General Amount", _AdminExpenseMgt.GetContractAdminExpense(Rec."Cemetery Code", _UnitPrice, Rec."Management Unit"));
    //                                             if _Cemetery."Landscape Architecture" then begin
    //                                                 Clear(_AdminExpenseMgt);
    //                                                 _UnitPrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(Rec."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::Landscape, Rec."Contract Date");
    //                                                 Rec.Validate("Landscape Arc. Amount", _AdminExpenseMgt.GetContractAdminExpense(Rec."Cemetery Code", _UnitPrice, Rec."Management Unit"));
    //                                             end else begin
    //                                                 Rec.Validate("Landscape Arc. Amount", 0);
    //                                             end;
    //                                         end else begin
    //                                             Rec.Validate("General Amount", 0);
    //                                             Rec.Validate("Landscape Arc. Amount", 0);
    //                                         end;
    //                                     end else begin
    //                                         Rec.Validate("General Amount", 0);
    //                                         Rec.Validate("Landscape Arc. Amount", 0);
    //                                     end;
    //                                 end;
    //                             end else begin
    //                                 Rec.Validate("General Amount", 0);
    //                                 Rec.Validate("Landscape Arc. Amount", 0);
    //                             end;
    //                         end;
    //                     }
    //                     field("Cemetery No."; Rec."Cemetery No.")
    //                     {
    //                     }
    //                     field("Landscape Architecture"; Rec."Landscape Architecture")
    //                     {
    //                         AssistEdit = false;
    //                         DrillDown = false;
    //                         Lookup = false;
    //                     }
    //                 }
    //                 group(Control107)
    //                 {
    //                     ShowCaption = false;
    //                     field("Admin. Expense Method"; Rec."Admin. Expense Method")
    //                     {
    //                         AssistEdit = false;
    //                         DrillDown = false;
    //                         Lookup = false;
    //                     }
    //                     field("General Expiration Date"; Rec."General Expiration Date")
    //                     {
    //                         Editable = false;
    //                     }
    //                     field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
    //                     {
    //                         Editable = false;
    //                     }
    //                     field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
    //                     {

    //                         trigger OnDrillDown()
    //                         begin
    //                             OpenAdminExpeseLedger(0);
    //                         end;
    //                     }
    //                     field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
    //                     {

    //                         trigger OnDrillDown()
    //                         begin
    //                             OpenAdminExpeseLedger(1);
    //                         end;
    //                     }
    //                     field("Management Unit"; Rec."Management Unit")
    //                     {
    //                         Editable = false;
    //                     }
    //                 }
    //             }
    //             group(Control181)
    //             {
    //                 ShowCaption = false;
    //                 field("VIP Exists"; Rec."VIP Exists")
    //                 {
    //                 }
    //                 field(Caution; Rec.Caution)
    //                 {
    //                 }
    //                 field("Last Date Cust. Request"; Rec."Last Date Cust. Request")
    //                 {
    //                 }
    //                 field("Customer Request Count"; Rec."Customer Request Count")
    //                 {
    //                 }
    //                 field("Counsel History Op. Count"; Rec."Counsel History Op. Count")
    //                 {

    //                     trigger OnLookup(var Text: Text): Boolean
    //                     var
    //                         _CounselHistory: Record "DK_Counsel History";
    //                         _CounselLitigationList: Page "DK_Counsel Litigation List";
    //                     begin

    //                         _CounselHistory.Reset;
    //                         _CounselHistory.SetRange("Contract No.", "No.");
    //                         _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
    //                         _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::OpenRequest);
    //                         _CounselHistory.SetRange(Date, CalcDate('<-CY>', WorkDate), CalcDate('<CY>', WorkDate));
    //                         _CounselHistory.SetRange("Result Process", _CounselHistory."Result Process"::Completed);

    //                         Clear(_CounselLitigationList);
    //                         _CounselLitigationList.SetRecord(_CounselHistory);
    //                         _CounselLitigationList.SetTableView(_CounselHistory);
    //                         _CounselLitigationList.Run;
    //                     end;
    //                 }
    //             }
    //             group(Control155)
    //             {
    //                 ShowCaption = false;
    //                 field("Litigation Evaluation"; Rec."Litigation Evaluation")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field(Status; Rec.Status)
    //                 {
    //                     Editable = false;
    //                 }
    //                 group(Memo)
    //                 {
    //                     Caption = 'Memo';
    //                     field(WorkMemo; WorkMemo)
    //                     {
    //                         MultiLine = true;

    //                         trigger OnValidate()
    //                         begin
    //                             SetWorkMemo(WorkMemo);
    //                         end;
    //                     }
    //                 }
    //             }
    //         }
    //         group("Group Contract")
    //         {
    //             Caption = 'Group Contract';
    //             Editable = "Contract Type" = "Contract Type"::Group;
    //             Visible = "Contract Type" <> "Contract Type"::General;
    //             field("Admin. Expense Option"; Rec."Admin. Expense Option")
    //             {
    //                 Editable = false;
    //             }
    //             field("Group Estate Code"; Rec."Group Estate Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Group Estate Name"; Rec."Group Estate Name")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //         }
    //         group(Cemetery)
    //         {
    //             Caption = 'Cemetery';
    //             Visible = false;
    //             field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
    //             {
    //             }
    //             field("Cemetery Dig. Code"; Rec."Cemetery Dig. Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
    //             {
    //             }
    //             field("Cemetery Class"; Rec."Cemetery Class")
    //             {
    //                 Editable = false;
    //             }
    //             field("Cemetery Landscape Archit."; Rec."Cemetery Landscape Archit.")
    //             {
    //             }
    //             field("Cemetery Size"; Rec."Cemetery Size")
    //             {
    //             }
    //             field("Cemetery Size 2"; Rec."Cemetery Size 2")
    //             {
    //             }
    //         }
    //         group(Amounts)
    //         {
    //             Caption = 'Amounts';
    //             group(Control76)
    //             {
    //                 ShowCaption = false;
    //                 field("Cemetery Amount"; Rec."Cemetery Amount")
    //                 {
    //                     Editable = false;
    //                     ShowMandatory = true;
    //                 }
    //                 field("Cemetery Class Dis. Rate"; Rec."Cemetery Class Dis. Rate")
    //                 {
    //                     Importance = Additional;
    //                 }
    //                 field("Cemetery Class Discount"; Rec."Cemetery Class Discount")
    //                 {
    //                 }
    //                 field("Cemetery Discount"; Rec."Cemetery Discount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("General Amount"; Rec."General Amount")
    //                 {
    //                     CaptionClass = ComFunction.GetCaptionWithContract('1');
    //                     Editable = false;
    //                 }
    //                 field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
    //                 {
    //                     CaptionClass = ComFunction.GetCaptionWithContract('2');
    //                     Editable = false;
    //                 }
    //                 field("Bury Amount"; Rec."Bury Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Payment Amount"; Rec."Payment Amount")
    //                 {
    //                     Editable = false;
    //                     Style = Strong;
    //                     StyleExpr = TRUE;
    //                 }
    //                 field("Deposit Amount"; Rec."Deposit Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Contract Amount"; Rec."Contract Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Total Contract Amount"; Rec."Total Contract Amount")
    //                 {
    //                     Style = AttentionAccent;
    //                     StyleExpr = TRUE;
    //                 }
    //                 field("Rece. Remaining Amount"; Rec."Rece. Remaining Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
    //                 {
    //                     Editable = false;
    //                     Style = Strong;
    //                     StyleExpr = TRUE;
    //                 }
    //             }
    //             group(Control77)
    //             {
    //                 ShowCaption = false;
    //                 field("Etc. Amount"; Rec."Etc. Amount")
    //                 {
    //                     Editable = false;
    //                     Visible = false;
    //                 }
    //                 field("Etc. Discount"; Rec."Etc. Discount")
    //                 {
    //                     Editable = false;
    //                     Visible = false;
    //                 }
    //                 field("Allow Ston"; Rec."Allow Ston")
    //                 {
    //                 }
    //                 field("Sales Amount"; Rec."Sales Amount")
    //                 {
    //                     Editable = false;
    //                     Visible = false;
    //                 }
    //                 field("Deposit Receipt Date"; Rec."Deposit Receipt Date")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Pay. Contract Rece. Date"; Rec."Pay. Contract Rece. Date")
    //                 {
    //                 }
    //                 field("Remaining Due Date"; Rec."Remaining Due Date")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Alarm Period 1"; Rec."Alarm Period 1")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Sended Alarm 1"; Rec."Sended Alarm 1")
    //                 {
    //                 }
    //                 field("Alarm Period 2"; Rec."Alarm Period 2")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Sended Alarm 2"; Rec."Sended Alarm 2")
    //                 {
    //                 }
    //                 field("Transfer Litigation"; Rec."Transfer Litigation")
    //                 {
    //                 }
    //                 field("Transfer Date"; Rec."Transfer Date")
    //                 {
    //                 }
    //                 field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
    //                 {
    //                 }
    //                 field("Admin. Exp. Start Date"; Rec."Admin. Exp. Start Date")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
    //                 {
    //                     Editable = false;
    //                 }
    //             }
    //         }
    //         group(Contacts)
    //         {
    //             Caption = 'Contacts';
    //             field("Cust. Mobile No."; Rec."Cust. Mobile No.")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'Mobile No.';
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Cust. Phone No."; Rec."Cust. Phone No.")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'Phone No.';
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Cust. E-Mail"; Rec."Cust. E-Mail")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'E-Mail';
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Address Confirmation"; Rec."Address Confirmation")
    //             {
    //                 Editable = false;
    //             }
    //             field("Cust. Post Code"; Rec."Cust. Post Code")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'Post Code';
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Cust. Address"; Rec."Cust. Address")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'Address';
    //                 DrillDown = false;
    //                 Lookup = false;
    //                 MultiLine = true;
    //             }
    //             field("Cust. Address 2"; Rec."Cust. Address 2")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'Address 2';
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field(gSocialSecurityNo; Rec.GSocialSecurityNo)
    //             {
    //                 Caption = 'Social Security No.';
    //                 Editable = false;

    //                 trigger OnDrillDown()
    //                 begin
    //                     GetSocialSecurityNo;
    //                 end;
    //             }
    //         }
    //         group(Associate)
    //         {
    //             Caption = 'Associate';
    //             field("Contact Target"; Rec."Contact Target")
    //             {
    //             }
    //             group(Control33)
    //             {
    //                 Caption = 'Main Associate';
    //                 field("Main Associate No."; Rec."Main Associate No.")
    //                 {
    //                     Caption = 'No.';
    //                 }
    //                 field("Main Associate Name"; Rec."Main Associate Name")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Name';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Main Associate Mobile No."; Rec."Main Associate Mobile No.")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Mobile No.';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Main Associate Phone No."; Rec."Main Associate Phone No.")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Phone No.';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Main Associate Post Code"; Rec."Main Associate Post Code")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Post Code';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Main Associate Address"; Rec."Main Associate Address")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Address';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Main Associate Address 2"; Rec."Main Associate Address 2")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Address 2';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //             }
    //             group(Control169)
    //             {
    //                 Caption = 'Sub Associate';
    //                 field("Sub Associate No."; Rec."Sub Associate No.")
    //                 {
    //                     Caption = 'No.';
    //                 }
    //                 field("Sub Associate Name"; Rec."Sub Associate Name")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Name';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Sub Associate Mobile No."; Rec."Sub Associate Mobile No.")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Mobile No.';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Sub Associate Phone No."; Rec."Sub Associate Phone No.")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Phone No.';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Sub Associate Post Code"; Rec."Sub Associate Post Code")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Post Code';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Sub Associate Address"; Rec."Sub Associate Address")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Address';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //                 field("Sub Associate Address 2"; Rec."Sub Associate Address 2")
    //                 {
    //                     AssistEdit = false;
    //                     Caption = 'Address 2';
    //                     DrillDown = false;
    //                     Lookup = false;
    //                 }
    //             }
    //             field("Associate Remark"; Rec."Associate Remark")
    //             {
    //             }
    //         }
    //         group("Joint Tenancy")
    //         {
    //             Caption = 'Joint Tenancy';
    //             group("Joint Tenancy 2")
    //             {
    //                 Caption = 'Joint Tenancy 2';
    //                 field("Customer No. 2"; Rec."Customer No. 2")
    //                 {
    //                     Caption = 'Customer No.';
    //                     Editable = false;
    //                 }
    //                 field("Customer Name 2"; Rec."Customer Name 2")
    //                 {
    //                     Caption = 'Customer Name';
    //                     Editable = false;
    //                 }
    //                 field("Cust. Mobile No. 2"; Rec."Cust. Mobile No. 2")
    //                 {
    //                     Caption = 'Customer Mobile No.';
    //                 }
    //             }
    //             group("Joint Tenancy 3")
    //             {
    //                 Caption = 'Joint Tenancy 3';
    //                 field("Customer No. 3"; Rec."Customer No. 3")
    //                 {
    //                     Caption = 'Customer No.';
    //                     Editable = false;
    //                 }
    //                 field("Customer Name 3"; Rec."Customer Name 3")
    //                 {
    //                     Caption = 'Customer Name';
    //                     Editable = false;
    //                 }
    //                 field("Cust. Mobile No. 3"; Rec."Cust. Mobile No. 3")
    //                 {
    //                     Caption = 'Customer Mobile No.';
    //                 }
    //             }
    //         }
    //         part("Friends And Relatives"; Rec."DK_Friends And Rel. Subform")
    //         {
    //             Caption = 'Friends And Relatives';
    //             SubPageLink = "Contract No."=FIELD("No.");
    //         }
    //         group("Allow Membership Printing")
    //         {
    //             Caption = 'Allow Membership Printing';
    //             Editable = false;
    //             field("Allow Employee No.";Rec."Allow Employee No.")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Allow Employee Name";Rec."Allow Employee Name")
    //             {
    //             }
    //             field("Allow Mem. Printing DateTime";Rec."Allow Mem. Printing DateTime")
    //             {
    //             }
    //         }
    //         group("Revocation Contract")
    //         {
    //             Caption = 'Revocation Contract';
    //             field("Revocation Register";Rec."Revocation Register")
    //             {
    //             }
    //             field("Revocation Date";Rec."Revocation Date")
    //             {
    //             }
    //             field("Revocation Amount";Rec."Revocation Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Close Amount";Rec."Close Amount")
    //             {
    //                 Editable = false;
    //             }
    //             field("Been Transp. Type";Rec."Been Transp. Type")
    //             {
    //             }
    //             field("Revocation Document No.";Rec."Revocation Document No.")
    //             {
    //             }
    //             field("Revocation Employee No.";Rec."Revocation Employee No.")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Revocation Employee Name";Rec."Revocation Employee Name")
    //             {
    //             }
    //             field("Revocation Remark";Rec."Revocation Remark")
    //             {
    //                 MultiLine = true;
    //             }
    //         }
    //         group("Etc.")
    //         {
    //             Caption = 'Etc.';
    //             field("Before Cemetery Code";Rec."Before Cemetery Code")
    //             {
    //             }
    //             field("Overdue Sticker";Rec."Overdue Sticker")
    //             {
    //             }
    //             field("Overdue Sticker Date";Rec."Overdue Sticker Date")
    //             {
    //             }
    //             field("VIP Reason Content";Rec."VIP Reason Content")
    //             {
    //                 MultiLine = true;
    //             }
    //         }
    //         part("Counsel General Line";Rec."DK_Counsel General Subform")
    //         {
    //             Caption = 'Counsel General Line';
    //             SubPageLink = "Contract No."=FIELD("No."),
    //                           Type=CONST(General),
    //                           "Delete Row"=CONST(false);
    //         }
    //         part("Counsel Litigation Line";Rec."DK_Counsel Litigation Subform")
    //         {
    //             Caption = 'Counsel Litigation Line';
    //             SubPageLink = "Contract No."=FIELD("No."),
    //                           Type=CONST(Litigation),
    //                           "Delete Row"=CONST(false);
    //         }
    //         group(CRM)
    //         {
    //             Caption = 'CRM';
    //             field("CRM Key";Rec."CRM Key")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("CRM SalesPerson Code";Rec."CRM SalesPerson Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("CRM SalesPerson";Rec."CRM SalesPerson")
    //             {
    //             }
    //             field("CRM External Sales Code";Rec."CRM External Sales Code")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("CRM External Sales";Rec."CRM External Sales")
    //             {
    //             }
    //             field("CRM Funeral Hall Code";Rec."CRM Funeral Hall Code")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("CRM Funeral Hall";Rec."CRM Funeral Hall")
    //             {
    //             }
    //             field("CRM Funeral Service Code";Rec."CRM Funeral Service Code")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("CRM Funeral Service";Rec."CRM Funeral Service")
    //             {
    //             }
    //             field("CRM Channel Vendor No.";Rec."CRM Channel Vendor No.")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("CRM Channel Vendor";Rec."CRM Channel Vendor")
    //             {
    //             }
    //             field("CRM Sales Type Seq";Rec."CRM Sales Type Seq")
    //             {
    //                 Editable = false;
    //                 Importance = Additional;
    //             }
    //             field("CRM Sales Type";Rec."CRM Sales Type")
    //             {
    //             }
    //         }
    //         group(Information)
    //         {
    //             Caption = 'Information';
    //             field("Creation Date";Rec."Creation Date")
    //             {
    //             }
    //             field("Creation Person";Rec."Creation Person")
    //             {
    //             }
    //             field("Last Date Modified";Rec."Last Date Modified")
    //             {
    //             }
    //             field("Last Modified Person";Rec."Last Modified Person")
    //             {
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control139;Rec."DK_Selected Contract Facbox")
    //         {
    //         }
    //         part(Control94;Rec."DK_Cemetery Detail Factbox")
    //         {
    //             SubPageLink = "Cemetery Code"=FIELD("Cemetery Code");
    //         }
    //         part(Control129;Rec."DK_Interest Cemetery Log")
    //         {
    //             SubPageLink = "Cemetery Code"=FIELD("Cemetery Code");
    //         }
    //         part("Group Contract Detail";Rec."DK_Contract Detail Factbox")
    //         {
    //             Caption = 'Group Contract Detail';
    //             SubPageLink = "No."=FIELD("Group Contract No.");
    //         }
    //         systempart(Control54;Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         group(Action81)
    //         {
    //             group("Customer Card")
    //             {
    //                 Caption = 'Customer Card';
    //                 Image = Receivables;
    //                 action("Main Customer")
    //                 {
    //                     Caption = 'Main Customer';
    //                     Image = Customer;
    //                     Promoted = true;
    //                     PromotedCategory = "Report";
    //                     RunObject = Page "DK_Customer Card";
    //                                     RunPageLink = "No."=FIELD("Main Customer No.");
    //                 }
    //                 action("Main Associate")
    //                 {
    //                     Caption = 'Main Associate';
    //                     Image = Customer;
    //                     Promoted = true;
    //                     PromotedCategory = "Report";
    //                     RunObject = Page "DK_Customer Card";
    //                                     RunPageLink = "No."=FIELD("Main Associate No.");
    //                 }
    //                 action("Sub Associate")
    //                 {
    //                     Caption = 'Sub Associate';
    //                     Image = Customer;
    //                     Promoted = true;
    //                     PromotedCategory = "Report";
    //                     RunObject = Page "DK_Customer Card";
    //                                     RunPageLink = "No."=FIELD("Sub Associate No.");
    //                 }
    //             }
    //             action(Corpse)
    //             {
    //                 Caption = 'Corpse';
    //                 Image = BusinessRelation;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _Corpse: Page "DK_Corpse List";
    //                                  _CorpseRec: Record DK_Corpse;
    //                 begin

    //                     Clear(_Corpse);

    //                     _CorpseRec.SetRange("Contract No.", "No.");

    //                     _Corpse.SetParameter("No.","Supervise No.", "Cemetery Code");

    //                     _Corpse.LookupMode(true);
    //                     _Corpse.SetTableView(_CorpseRec);
    //                     _Corpse.Run;
    //                 end;
    //             }
    //             action("Relationship Family")
    //             {
    //                 Caption = 'Relationship Family';
    //                 Image = AssemblyBOM;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _RelationshipFamily: Page "DK_Relationship Family List";
    //                                              _RelationshipFamilyRec: Record "DK_Relationship Family";
    //                 begin
    //                     Clear(_RelationshipFamily);

    //                     _RelationshipFamilyRec.SetRange("Contract No.", "No.");

    //                     _RelationshipFamily.SetParameter("No.","Supervise No.", "Cemetery Code");

    //                     _RelationshipFamily.LookupMode(true);
    //                     _RelationshipFamily.SetTableView(_RelationshipFamilyRec);
    //                     _RelationshipFamily.Run;
    //                 end;
    //             }
    //             action("Landscape Architecture Picture")
    //             {
    //                 Caption = 'Landscape Architecture Picture';
    //                 Image = Picture;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _LandArchPicture: Page "DK_Land. Arch. Picture";
    //                                           _LandArchPictureRec: Record "DK_Land. Arch. Picture";
    //                 begin
    //                     Clear(_LandArchPicture);

    //                     _LandArchPictureRec.SetRange("Contract No.", "No.");

    //                     _LandArchPicture.SetParameter("No.","Supervise No.", "Cemetery Code");

    //                     _LandArchPicture.LookupMode(true);
    //                     _LandArchPicture.SetTableView(_LandArchPictureRec);
    //                     _LandArchPicture.Run;
    //                 end;
    //             }
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
    //             action("Payment Receipt Document")
    //             {
    //                 Caption = 'Payment Receipt Document';
    //                 Image = ReceiptLines;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Payment Receipt Doc. List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Select Contract")
    //             {
    //                 Caption = 'Select Contract';
    //                 Image = SelectLineToApply;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _SelectedContract: Record "DK_Selected Contract";
    //                     _Contract: Record DK_Contract;
    //                 begin

    //                     CurrPage.SetSelectionFilter(_Contract);

    //                     if _Contract.FindFirst then begin
    //                       repeat
    //                         if not _SelectedContract.Get(UserId, _Contract."No.") then begin
    //                             _SelectedContract.Init;
    //                             _SelectedContract."USER ID" := UserId;
    //                             _SelectedContract."Contract No." := _Contract."No.";
    //                             _SelectedContract."Cemetery Code" := _Contract."Cemetery Code";
    //                             _SelectedContract."Cemetery No." := _Contract."Cemetery No.";

    //                             if _Contract."Contact Target" = _Contract."Contact Target"::MainAssociate then begin

    //                               _Contract.CalcFields("Main Associate Mobile No.","Main Associate Name");
    //                               _SelectedContract."Cust. Mobile No." := _Contract."Main Associate Mobile No.";
    //                               _SelectedContract."Contact Name" := _Contract."Main Associate Name";

    //                             end else if _Contract."Contact Target" = _Contract."Contact Target"::SubAssociate then begin

    //                               _Contract.CalcFields("Sub Associate Mobile No.","Sub Associate Name");
    //                               _SelectedContract."Cust. Mobile No." := _Contract."Sub Associate Mobile No.";
    //                               _SelectedContract."Contact Name" := _Contract."Sub Associate Name";
    //                             end else begin
    //                               //Main Customer
    //                               _Contract.CalcFields("Cust. Mobile No.");
    //                               _SelectedContract."Cust. Mobile No." := _Contract."Cust. Mobile No.";
    //                               _SelectedContract."Contact Name" := _Contract."Main Customer Name";
    //                             end;

    //                             _SelectedContract.Insert;
    //                         end;
    //                       until _Contract.Next = 0;
    //                     end;
    //                 end;
    //             }
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

    //                     if "No." = '' then
    //                       Error(MSG006);

    //                     _Contract.Reset;
    //                     _Contract.SetRange("No." ,"No.");
    //                     if _Contract.FindSet then begin
    //                       Clear(_CalcAdminExpense);
    //                       _CalcAdminExpense.LookupMode(true);
    //                       _CalcAdminExpense.SetTableView(_Contract);
    //                       _CalcAdminExpense.SetRecord(_Contract);
    //                       _CalcAdminExpense.RunModal;
    //                     end else begin
    //                       Error(MSG007);
    //                     end;
    //                 end;
    //             }
    //             action("Send SMS")
    //             {
    //                 Caption = 'Send SMS';
    //                 Image = SendTo;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _SMSSend: Page "DK_SMS Send";
    //                 begin
    //                     Clear(_SMSSend);
    //                     _SMSSend.Editable(true);
    //                     _SMSSend.SetSelectContract("No.");
    //                     _SMSSend.RunModal;
    //                 end;
    //             }
    //             action("Open NAS Contract Folder")
    //             {
    //                 Caption = 'Open NAS Contract Folder';
    //                 Image = BOMVersions;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;

    //                 trigger OnAction()
    //                 var
    //                     _FunSetup: Record "DK_Function Setup";
    //                     _CommFunction: Codeunit "DK_Common Function";
    //                 begin
    //                     _FunSetup.Get;
    //                     if _FunSetup."NAS Contract File Folder" = '' then
    //                       Error(MSG001);

    //                     if "Cemetery No." = '' then
    //                       Error(MSG002, FieldCaption("Cemetery No."));

    //                     Clear(_CommFunction);
    //                     _CommFunction.OpenFolderClient(_FunSetup."NAS Contract File Folder", "Cemetery No.");
    //                 end;
    //             }
    //             action("Change Customer in Contract")
    //             {
    //                 Caption = 'Change Customer in Contract';
    //                 Image = ChangeCustomer;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 RunObject = Page "DK_Cng. Cust. in Contract List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Evaluation Change")
    //             {
    //                 Caption = 'Evaluation Change';
    //                 Image = CustomerRating;
    //                 Promoted = true;
    //                 PromotedCategory = Process;

    //                 trigger OnAction()
    //                 var
    //                     _Contract: Record DK_Contract;
    //                     _EvaluationChange: Report "DK_Evaluation Change";
    //                 begin

    //                     Clear(_EvaluationChange);
    //                     CurrPage.SetSelectionFilter(_Contract);
    //                     if _Contract.IsEmpty then
    //                       Error(MSG001,_Contract.TableCaption);

    //                     _EvaluationChange.SetTableView(_Contract);
    //                     _EvaluationChange.RunModal;

    //                     CurrPage.Update;
    //                 end;
    //             }
    //             action("Customer Certficate Request")
    //             {
    //                 Caption = 'Customer Certficate Request';
    //                 Image = Approval;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 Visible = false;

    //                 trigger OnAction()
    //                 var
    //                     _Contract: Record DK_Contract;
    //                     _CustomerCertficateHistory: Codeunit "DK_Customer Certficate History";
    //                 begin
    //                     /*
    //                     CurrPage.SETSELECTIONFILTER(_Contract);
    //                     IF _Contract.FINDSET THEN BEGIN
    //                       IF NOT CONFIRM(MSG003,FALSE) THEN EXIT;

    //                       REPEAT
    //                         _CustomerCertficateHistory.Request(_Contract);
    //                       UNTIL _Contract.NEXT = 0;
    //                       MESSAGE(MSG005);
    //                     END ELSE BEGIN
    //                       ERROR(MSG004);
    //                     END;
    //                     */

    //                 end;
    //             }
    //             action("Cemetery Change")
    //             {
    //                 Caption = 'Cemetery Change';
    //                 Image = ChangeLog;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //             }
    //             action("Customer Requests List")
    //             {
    //                 Caption = 'Customer Requests List';
    //                 Ellipsis = true;
    //                 Image = Absence;
    //                 Promoted = true;
    //                 PromotedCategory = Process;

    //                 trigger OnAction()
    //                 begin
    //                     DK_CustomerRequestsAll.SetContract(Rec);
    //                     DK_CustomerRequestsAll.Run;
    //                 end;
    //             }
    //             action(ExchangeOfLand)
    //             {
    //                 Caption = 'ExchangeOfLand';
    //                 Ellipsis = true;
    //                 Image = ChangeTo;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ToolTip = 'This function is available for Bongandang or Sky Damjae graveyard. The Status and the end of management change when using the feature.';
    //                 Visible = ExchangeVisible;

    //                 trigger OnAction()
    //                 var
    //                     _ContractMgt: Codeunit "DK_Contract Mgt.";
    //                 begin

    //                     if Confirm(MSG013) then
    //                       _ContractMgt.ExchangeOfLand(Rec);
    //                 end;
    //             }
    //             action("Exchange Of Land Cancel")
    //             {
    //                 Caption = 'Exchange Of Land Cancel';
    //                 Ellipsis = true;
    //                 Image = ReopenCancelled;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ToolTip = 'This function is available for Bongandang or Sky Damjae graveyard. The Status and the end of management change when using the feature.';
    //                 Visible = ExchangeVisible;

    //                 trigger OnAction()
    //                 var
    //                     _ContractMgt: Codeunit "DK_Contract Mgt.";
    //                 begin

    //                     if Confirm(MSG013) then
    //                       _ContractMgt.ExchangeOfLandCancel(Rec);
    //                 end;
    //             }
    //         }
    //         group(Action85)
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
    //             action("Cemetery Payment Confirm")
    //             {
    //                 Caption = 'Cemetery Payment Confirm';
    //                 Image = "Report";
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 begin
    //                     CementeryPaymentRun;
    //                 end;
    //             }
    //             action("Publish Admin. Expense List")
    //             {
    //                 Caption = 'Publish Admin. Expense List';
    //                 Image = ReceivableBill;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedOnly = true;

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
    //                 Image = History;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Sended SMS History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Report Printing History")
    //             {
    //                 Caption = 'Report Printing History';
    //                 Image = History;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 RunObject = Page "DK_Report Printing History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Change Evaluation History")
    //             {
    //                 Caption = 'Change Evaluation History';
    //                 Image = History;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
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

    // trigger OnAfterGetCurrRecord()
    // begin

    //     //>> #2019
    //     CheckVIPCaution;
    //     //<<

    //     //>>DK34
    //     ExchangeVisible := SetExchangeActionVisible();
    //     //<<
    // end;

    // trigger OnAfterGetRecord()
    // begin
    //     WorkMemo := GetWorkMemo;
    //     GetSocialSecurityNoDisplay;

    //     //>>DK32
    //    Rec.CalcFields("Estate Code", "Admin. Expense Method");
    //     //<<DK32

    //     //>>DK34
    //     ExchangeVisible := SetExchangeActionVisible();
    //     //<<
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     "Contract Date" := WorkDate;
    //     FunctionSetup.Get;
    //     "Management Unit" := FunctionSetup."Management Unit";
    // end;

    // trigger OnOpenPage()
    // begin
    //     //FILTERGROUP(2);
    //     SetRange("Date Filter",0D,Today);
    //     //FILTERGROUP(0);

    //     SetRange("Date Filter 2",CalcDate('<-CY>',WorkDate),CalcDate('<CY>',WorkDate));
    // end;

    // var
    //     ContractMgt: Codeunit "DK_Contract Mgt.";
    //     ComFunction: Codeunit "DK_Common Function";
    //     FunctionSetup: Record "DK_Function Setup";
    //     WorkMemo: Text;
    //     gSocialSecurityNo: Text[30];
    //     MSG001: Label 'The NAS server folder was not specified in the Function settings. Please contact your administrator.';
    //     MSG002: Label 'The %1 could not be found in this Contract Document.';
    //     MSG003: Label 'Would you like to request approval for the selected contracts?';
    //     MSG004: Label 'No contract selected.';
    //     MSG005: Label 'Request for approval has been completed.';
    //     MSG006: Label 'Please enter your Contract No first';
    //     MSG007: Label 'No contract found.';
    //     MSG008: Label '%1 in this contract is %2. Could not Create PAyment Expect Documents.';
    //     MSG009: Label '%1 in this contract is %2. You''ll only be able to Create Payment Expect Documents for Admin. Expense if you have %3.';
    //     MSG010: Label 'VIP: %1';
    //     MSG011: Label 'The customer needs attention.';
    //     MSG012: Label '%1 has not been entered.';
    //     ExchangeVisible: Boolean;
    //     MSG013: Label 'The Status and end-of-management date are changed. Do you want to continue?';
    //     DK_CustomerRequestsAll: Page "DK_Customer Requests All";

    // local procedure AddressLookup()
    // var
    //     _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
    //     _TmpCode: Code[20];
    //     _TmpText: Text[50];
    // begin

    //     Clear(_DK_KoreanRoadAddrMgt);

    //     _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress("Associate Address", "Associate Address 2", "Associate Post Code", _TmpText, _TmpCode);
    // end;

    // local procedure CementeryPaymentRun()
    // var
    //     _CemeteryPaymentConfirm: Report "DK_Cemetery Payment Confirm";
    // begin
    //     _CemeteryPaymentConfirm.SetParm("No.");
    //     _CemeteryPaymentConfirm.RunModal;
    // end;

    // local procedure GetSocialSecurityNo()
    // var
    //     _DK_Customer: Record DK_Customer;
    // begin
    //     Clear(gSocialSecurityNo);
    //     if _DK_Customer.Get("Main Customer No.") then begin
    //         gSocialSecurityNo := _DK_Customer.GetSSNSSNCalculated;
    //     end;
    // end;

    // local procedure GetSocialSecurityNoDisplay()
    // var
    //     _DK_Customer: Record DK_Customer;
    // begin
    //     Clear(gSocialSecurityNo);
    //     if _DK_Customer.Get(Rec."Main Customer No.") then begin
    //         gSocialSecurityNo := _DK_Customer.GetSSN;
    //     end;
    // end;

    // local procedure CheckVIPCaution()
    // begin

    //     if "VIP Exists" then begin
    //         if "VIP Reason Content" = '' then
    //             Message(StrSubstNo(MSG010, StrSubstNo(MSG012, FieldCaption("VIP Reason Content"))))
    //         else
    //             Message(StrSubstNo(MSG010, "VIP Reason Content"));
    //     end;

    //     if Caution then
    //         Message(MSG011);
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

