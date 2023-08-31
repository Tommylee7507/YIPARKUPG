page 50157 "DK_Litigation Contract" ////zzz
{
    // // 
    // // *»‘÷ŠˆŒ÷ ‰°˜ú: #2037 - 2020-07-20
    // //   - Rec. Modify Trigger: OnOpenPage
    // //   - Add Function: CheckVIPCaution
    // // 
    // // #2087 : 20200821
    // //   - Add Field : "VIP Reason Content"
    // //   - Add Text Constants: MSG006
    // //   - Rec. Modify Function: CheckVIPCaution
    // //   - Rec. Modify Text Constants: MSG004
    // // 
    // // #2044 : 20200904
    // //   - Rec. Modify Filed Caption: <DK_Counsel Litigation Subform>(ŒÁ‰½ ‹Ý„Ì †Ýž -> ×„ ‹Ý„Ì †Ýž)
    // // 
    // // DK34: 20201030
    // //   - Add Field: "Fur. Main Cat. Code", "Fur. Main Cat. Name", "Fur. Sub Cat. Code", "Fur. Sub Cat. Name"
    // //     : 20201117
    // //   - Add Field: "Department Code", "Department Name"
    // //   - Rec. Modify Field: "Litigation Employee No.", "Litigation Employee Name" - Visible False

    // Caption = 'Litigation Contract';
    // DataCaptionFields = "No.", "Litigation Evaluation", "Litigation Employee Name", "Litigation Status Name";
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // PageType = Card;
    // RefreshOnActivate = true;
    // SourceTable = DK_Contract;

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             group(Control11)
    //             {
    //                 ShowCaption = false;
    //                 field("No."; Rec."No.")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Supervise No."; Rec."Supervise No.")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Contract Type"; Rec."Contract Type")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Group Contract No."; Rec."Group Contract No.")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Contract Date"; Rec."Contract Date")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Main Customer No."; Rec."Main Customer No.")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Main Customer Name"; Rec."Main Customer Name")
    //                 {
    //                     Editable = false;
    //                 }
    //                 group(Control13)
    //                 {
    //                     ShowCaption = false;
    //                     field("Cemetery No."; Rec."Cemetery No.")
    //                     {
    //                     }
    //                     field("Landscape Architecture"; Rec."Landscape Architecture")
    //                     {
    //                     }
    //                 }
    //                 group(Control16)
    //                 {
    //                     ShowCaption = false;
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
    //                             Rec.OpenAdminExpeseLedger(0);
    //                         end;
    //                     }
    //                     field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
    //                     {

    //                         trigger OnDrillDown()
    //                         begin
    //                             Rec.OpenAdminExpeseLedger(1);
    //                         end;
    //                     }
    //                     field("Management Unit"; Rec."Management Unit")
    //                     {
    //                         Editable = false;
    //                     }
    //                 }
    //             }
    //             group(Control45)
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
    //                         _CounselHistory.SetRange("Contract No.", Rec."No.");
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
    //             group(Control23)
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
    //             Editable = Rec."Contract Type" = Rec."Contract Type"::Group;
    //             Visible = Rec."Contract Type" <> Rec."Contract Type"::General;
    //             field("Group Estate Code"; Rec."Group Estate Code")
    //             {
    //             }
    //             field("Group Estate Name"; Rec."Group Estate Name")
    //             {
    //             }
    //             field("Admin. Expense Option"; Rec."Admin. Expense Option")
    //             {
    //                 Editable = false;
    //             }
    //             field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
    //             {
    //                 Editable = false;
    //             }
    //             field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
    //             {
    //                 Editable = false;
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
    //         group(Ligation)
    //         {
    //             Caption = 'Ligation';
    //             field("Litigation Status Code"; Rec."Litigation Status Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Litigation Status Name"; Rec."Litigation Status Name")
    //             {
    //             }
    //             field("Law Status Code"; Rec."Law Status Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Law Status Name"; Rec."Law Status Name")
    //             {
    //             }
    //             field("Fur. Main Cat. Code"; Rec."Fur. Main Cat. Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Fur. Main Cat. Name"; Rec."Fur. Main Cat. Name")
    //             {
    //             }
    //             field("Fur. Sub Cat. Code"; Rec."Fur. Sub Cat. Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Fur. Sub Cat. Name"; Rec."Fur. Sub Cat. Name")
    //             {
    //             }
    //             field("Litigation Progress Code"; Rec."Litigation Progress Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Litigation Progress Name"; Rec."Litigation Progress Name")
    //             {
    //             }
    //             field("Litigation Employee No."; Rec."Litigation Employee No.")
    //             {
    //                 Importance = Additional;
    //                 Visible = false;
    //             }
    //             field("Litigation Employee Name"; Rec."Litigation Employee Name")
    //             {
    //                 Visible = false;
    //             }
    //             field("Department Code"; Rec."Department Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Department Name"; Rec."Department Name")
    //             {
    //             }
    //             field("Last Deposit Plan Date"; Rec."Last Deposit Plan Date")
    //             {
    //             }
    //             field("Reminder Date 1"; Rec."Reminder Date 1")
    //             {
    //             }
    //             field("Reminder Date 2"; Rec."Reminder Date 2")
    //             {
    //             }
    //         }
    //         group(Amounts)
    //         {
    //             Caption = 'Amounts';
    //             group(Control132)
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
    //                 field("Deposit Amount"; Rec."Deposit Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Contract Amount"; Rec."Contract Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Rece. Remaining Amount"; Rec."Rece. Remaining Amount")
    //                 {
    //                     Editable = false;
    //                 }
    //             }
    //             group(Control121)
    //             {
    //                 ShowCaption = false;
    //                 field("Payment Amount"; Rec."Payment Amount")
    //                 {
    //                     Editable = false;
    //                     Style = Strong;
    //                     StyleExpr = TRUE;
    //                 }
    //                 field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
    //                 {
    //                     Editable = false;
    //                     Style = Strong;
    //                     StyleExpr = TRUE;
    //                 }
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
    //                 field("Transfer Litigation"; Rec."Transfer Litigation")
    //                 {
    //                 }
    //                 field("Transfer Date"; Rec."Transfer Date")
    //                 {
    //                 }
    //                 field("Alarm Period 1"; Rec."Alarm Period 1")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Alarm Period 2"; Rec."Alarm Period 2")
    //                 {
    //                     Editable = false;
    //                 }
    //                 field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
    //                 {
    //                 }
    //             }
    //         }
    //         group(Contacts)
    //         {
    //             Caption = 'Contacts';
    //             field(gSocialSecurityNo; GSocialSecurityNo)
    //             {
    //                 Caption = 'Customer Social Security No.';
    //                 Editable = false;
    //             }
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
    //             }
    //             field("Cust. Address 2"; Rec."Cust. Address 2")
    //             {
    //                 AssistEdit = false;
    //                 Caption = 'Address 2';
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //         }
    //         group(Associate)
    //         {
    //             Caption = 'Associate';
    //             field("Contact Target"; Rec."Contact Target")
    //             {
    //             }
    //             group("Main Associate")
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
    //             group("Sub Associate")
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
    //         part("Friends And Relatives"; "DK_Friends And Rel. Subform")
    //         {
    //             Caption = 'Friends And Relatives';
    //             SubPageLink = "Contract No."=FIELD("No.");
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
    //             field("Revocation Document No.";Rec."Revocation Document No.")
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
    //         part("Payment Receipt Line";"DK_Pay. Rec. Doc. Line Facbox")
    //         {
    //             Caption = 'Payment Receipt Line';
    //             SubPageLink = "Contract No."=FIELD("No."),
    //                           "Payment Target"=FILTER(General|Landscape);
    //         }
    //         part("Counsel Litigation Line";"DK_Counsel Litigation Subform")
    //         {
    //             Caption = 'Counsel Litigation Line';
    //             SubPageLink = "Contract No."=FIELD("No."),
    //                           Type=CONST(Litigation),
    //                           "Delete Row"=CONST(false);
    //         }
    //         part("Counsel General Line";"DK_Counsel General Subform")
    //         {
    //             Caption = 'Counsel General Line';
    //             SubPageLink = "Contract No."=FIELD("No."),
    //                           Type=CONST(General),
    //                           "Delete Row"=CONST(false);
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
    //         part(Control71;"DK_Selected Contract Facbox")
    //         {
    //         }
    //         part(Control72;"DK_Cemetery Detail Factbox")
    //         {
    //             SubPageLink = "Cemetery Code"=FIELD("Cemetery Code");
    //         }
    //         systempart(Control100;Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
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
    //             begin

    //                 if not _SelectedContract.Get(UserId, "No.") then begin
    //                     _SelectedContract.Init;
    //                     _SelectedContract."USER ID" := UserId;
    //                     _SelectedContract."Contract No." := "No.";
    //                     _SelectedContract."Cemetery Code" := "Cemetery Code";
    //                     _SelectedContract."Cemetery No." := "Cemetery No.";
    //                     _SelectedContract.Insert;
    //                 end;
    //             end;
    //         }
    //         action("Send SMS")
    //         {
    //             Caption = 'Send SMS';
    //             Image = SendTo;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

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
    //             PromotedIsBig = true;
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
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             Visible = false;

    //             trigger OnAction()
    //             var
    //                 _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    //             begin
    //                 Clear(_AdminExpenseMgt);
    //                 _AdminExpenseMgt.MessageDelayInterestAmount(Rec."No.");
    //             end;
    //         }
    //         action("Calculation of Delay Interest")
    //         {
    //             Caption = 'Calculation of Delay Interest';
    //             Image = CalculateBalanceAccount;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _Contract: Record DK_Contract;
    //                 _CalcDelayIntAmount: Page "DK_Calc. Delay Int. Amount";
    //                                          _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    //                                          _DelayInterestAmt: Decimal;
    //             begin

    //                 if Rec."No." = '' then
    //                   Error(MSG007);

    //                 _Contract.Reset;
    //                 _Contract.SetRange("No.",Rec."No.");
    //                 if _Contract.FindSet then begin
    //                   if (_Contract."General Expiration Date" = 0D) and (_Contract."Land. Arc. Expiration Date" = 0D) then
    //                     Error(MSG008);

    //                   if (_Contract."General Expiration Date" > Today) and (_Contract."Land. Arc. Expiration Date" = 0D) then
    //                     Error(MSG008);

    //                   if (_Contract."General Expiration Date" > Today) and (_Contract."Land. Arc. Expiration Date" > Today) then
    //                     Error(MSG008);

    //                   Clear(_CalcDelayIntAmount);
    //                   _CalcDelayIntAmount.SetParameter(0D,'');
    //                   _CalcDelayIntAmount.LookupMode(true);
    //                   _CalcDelayIntAmount.SetTableView(_Contract);
    //                   _CalcDelayIntAmount.SetRecord(_Contract);
    //                   _CalcDelayIntAmount.RunModal;
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
    //             PromotedIsBig = true;

    //             trigger OnAction()
    //             var
    //                 _FunSetup: Record "DK_Function Setup";
    //                 _CommFunction: Codeunit "DK_Common Function";
    //             begin
    //                 _FunSetup.Get;
    //                 if _FunSetup."NAS Contract File Folder" = '' then
    //                   Error(MSG002);

    //                 if Rec."Cemetery No." = '' then
    //                   Error(MSG003, Rec.FieldCaption("Cemetery No."));

    //                 Clear(_CommFunction);
    //                 _CommFunction.OpenFolderClient(_FunSetup."NAS Contract File Folder", Rec."Cemetery No.");
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
    //         group(Action85)
    //         {
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

    //                     _CorpseRec.SetRange("Contract No.", Rec."No.");

    //                     _Corpse.SetParameter(Rec."No.",Rec."Supervise No.", Rec."Cemetery Code");

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

    //                     _RelationshipFamilyRec.SetRange("Contract No.", Rec."No.");

    //                     _RelationshipFamily.SetParameter(Rec."No.",Rec."Supervise No.", Rec."Cemetery Code");

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

    //                     _LandArchPictureRec.SetRange("Contract No.", Rec."No.");

    //                     _LandArchPicture.SetParameter(Rec."No.",Rec."Supervise No.", Rec."Cemetery Code");

    //                     _LandArchPicture.LookupMode(true);
    //                     _LandArchPicture.SetTableView(_LandArchPictureRec);
    //                     _LandArchPicture.Run;
    //                 end;
    //             }
    //             action("Payment Receipt Document")
    //             {
    //                 Caption = 'Payment Receipt Document';
    //                 Image = ReceiptLines;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Payment Receipt Doc. List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //         }
    //         group(Action90)
    //         {
    //             action("Posted Payment Receipt")
    //             {
    //                 Caption = 'Posted Payment Receipt';
    //                 Image = PostedPayment;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Post Pay. Receipt Doc. List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Posted Payment Refund")
    //             {
    //                 Caption = 'Posted Payment Refund';
    //                 Image = PostedCreditMemo;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Post. Pay. Refund Doc. List";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Contract Amount Ledger")
    //             {
    //                 Caption = 'Contract Amount Ledger';
    //                 Image = LedgerEntries;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Contract Amount Ledger";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Admin. Expense Ledger")
    //             {
    //                 Caption = 'Admin. Expense Ledger';
    //                 Image = LedgerEntries;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Admin. Expense Ledger";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Report Printing History")
    //             {
    //                 Caption = 'Report Printing History';
    //                 Image = PrintChecklistReport;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Report Printing History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Sended SMS History")
    //             {
    //                 Caption = 'Sended SMS History';
    //                 Image = SendElectronicDocument;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Sended SMS History";
    //                                 RunPageLink = "Contract No."=FIELD("No.");
    //             }
    //             action("Litigation Lawsuit History")
    //             {
    //                 Caption = 'Litigation Lawsuit History';
    //                 Image = CheckList;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
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

    // trigger OnAfterGetCurrRecord()
    // begin

    //     // >> #2037
    //     CheckVIPCaution;
    //     // <<
    // end;

    // trigger OnAfterGetRecord()
    // var
    //     _Customer: Record DK_Customer;
    // begin
    //     WorkMemo := Rec.GetWorkMemo;
    //     GetSocialSecurityNo;
    // end;

    // trigger OnOpenPage()
    // begin
    //     //FILTERGROUP(2);
    //     Rec.SetRange("Date Filter",0D,Today);
    //     //FILTERGROUP(0);

    //     Rec.SetRange("Date Filter 2",CalcDate('<-CY>',WorkDate),CalcDate('<CY>',WorkDate));
    // end;

    // var
    //     ComFunction: Codeunit "DK_Common Function";
    //     gSocialSecurityNo: Text[30];
    //     MSG001: Label 'No contract found.';
    //     MSG002: Label 'The NAS server folder was not specified in the Function settings. Please contact your administrator.';
    //     MSG003: Label 'The %1 could not be found in this Contract Document.';
    //     WorkMemo: Text;
    //     MSG004: Label 'VIP: %1';
    //     MSG005: Label 'The customer needs attention.';
    //     MSG006: Label '%1 has not been entered.';
    //     MSG007: Label 'Please enter your Contract No first';
    //     MSG008: Label 'Delay interest did not occur.';

    // local procedure GetSocialSecurityNo()
    // var
    //     _DK_Customer: Record DK_Customer;
    // begin
    //     Clear(gSocialSecurityNo);
    //     if _DK_Customer.Get(Rec."Main Customer No.") then begin
    //       gSocialSecurityNo := _DK_Customer.GetSSNSSNCalculated;
    //     end;
    // end;

    // local procedure CheckVIPCaution()
    // begin

    //     if Rec."VIP Exists" then begin
    //       if Rec."VIP Reason Content" = '' then
    //         Message(StrSubstNo(MSG004,StrSubstNo(MSG006,Rec.FieldCaption("VIP Reason Content"))))
    //       else
    //         Message(StrSubstNo(MSG004,Rec."VIP Reason Content"));
    //     end;

    //     if Rec.Caution then
    //       Message(MSG005);
    // end;
}

