page 50169 "DK_SMS Send"////zzz
{
    // 
    // DK34: 20201026
    //   - Rec. Modify Function: SetMessageType

    // AccessByPermission = Page "DK_SMS Send" = X; ////zzz
    Caption = 'SMS Send';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Image1,Image2,Image3';
    SourceTable = DK_SMS;
    SourceTableTemporary = true;

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             part(SubPage; Rec."DK_SMS Mobile No.")
    //             {
    //                 Caption = 'To Contacts';
    //             }
    //             group(Message)
    //             {
    //                 Caption = 'Message';
    //                 field(WorkMessage; WorkMessage)
    //                 {
    //                     MultiLine = true;

    //                     trigger OnValidate()
    //                     begin
    //                         OnValudateWorkMessage;
    //                     end;
    //                 }
    //                 field("SMS Length"; Rec."SMS Length")
    //                 {
    //                     Caption = 'Length';
    //                 }
    //                 field(CompPhone; Rec.CompPhone)
    //                 {
    //                     Caption = 'Company Phone';

    //                     trigger OnValidate()
    //                     begin
    //                         if CompPhone then
    //                             "From Contact" := CompPhoneNo
    //                         else
    //                             "From Contact" := BusinessContacts;
    //                     end;
    //                 }
    //                 field("From Contact"; Rec."From Contact")
    //                 {
    //                     Caption = 'From Contact';
    //                     Editable = NOT CompPhone;
    //                     Enabled = NOT CompPhone;
    //                 }
    //             }
    //         }
    //         group("Message Type")
    //         {
    //             Caption = 'Message Type';
    //             field(MessageTypeText; MessageTypeText)
    //             {
    //                 Caption = 'Type';
    //                 Editable = false;
    //                 OptionCaption = 'General,Purchase Contract,Remaining Amount,Vehicle,Field Work,Customer Request,Cemetry Service,Receipt,Payment Expect PG,Payment Expect VA';
    //             }
    //             field(MessageType; MessageType)
    //             {
    //                 Caption = 'Message';
    //                 Editable = false;
    //                 MultiLine = true;
    //             }
    //         }
    //         group("Selected Contract")
    //         {
    //             Caption = 'Selected Contract';
    //             field("Contract No."; Rec."Contract No.")
    //             {
    //                 Editable = false;
    //             }
    //             field("Cemetery No."; Rec."Cemetery No.")
    //             {
    //             }
    //             field("Contact Name"; Rec."Contact Name")
    //             {
    //             }
    //             field("Main Customer Name"; Rec."Main Customer Name")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //         }
    //         group(Image)
    //         {
    //             Caption = 'Image';
    //             group(Control15)
    //             {
    //                 ShowCaption = false;
    //                 field(Image1; Rec.Image1)
    //                 {

    //                     trigger OnValidate()
    //                     begin
    //                         Rec. Modify;
    //                         Image1_OnValidate;
    //                     end;
    //                 }
    //                 field(Image2; Rec.Image2)
    //                 {

    //                     trigger OnValidate()
    //                     begin
    //                         Rec. Modify;
    //                         Image2_OnValidate;
    //                     end;
    //                 }
    //                 field(Image3; Rec.Image3)
    //                 {

    //                     trigger OnValidate()
    //                     begin
    //                         Rec. Modify;
    //                         Image3_OnValidate;
    //                     end;
    //                 }
    //             }
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(Send)
    //         {
    //             Caption = 'Send';
    //             Image = SendTo;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin

    //                 SendSMS;
    //             end;
    //         }
    //         action("Select Message")
    //         {
    //             Caption = 'Select Message';
    //             Image = SelectField;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin
    //                 SelectMessage;
    //             end;
    //         }
    //         action("Message View")
    //         {
    //             Caption = 'Message View';
    //             Image = PreviewChecks;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _SMSMobileNo: Page "DK_SMS Mobile No.";
    //             begin

    //                 CurrPage.SubPage.PAGE.PreviewMessage(MessageTypeOption, WorkMessage, "Contract No.");
    //             end;
    //         }
    //         group(Action21)
    //         {
    //             action("Sended SMS History")
    //             {
    //                 Caption = 'Sended SMS History';
    //                 Image = History;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "DK_Sended SMS History";
    //             }
    //         }
    //     }
    // }

    // trigger OnAfterGetRecord()
    // begin
    //     WorkMessage := GetWorkMessage;
    // end;

    // trigger OnOpenPage()
    // var
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _Employee: Record DK_Employee;
    // begin

    //     _FunctionSetup.Get;
    //     _FunctionSetup.TestField("SMS Image Server TempFolder");
    //     _FunctionSetup.TestField("Use SMS");
    //     CompPhoneNo := _FunctionSetup."SMS Phone No.";

    //     _Employee.Reset;
    //     _Employee.SetRange("ERP User ID", UserId);
    //     if _Employee.FindFirst then
    //         BusinessContacts := _Employee."Business Contacts";

    //     Init;
    //     if BusinessContacts = '' then
    //         "From Contact" := CompPhoneNo
    //     else
    //         "From Contact" := BusinessContacts;

    //     Rec.Validate("Contract No.", ContractNo);
    //     Rec.Insert;
    //     ;

    //     if SetContract then
    //         SetToMobile;

    //     SetMessageType(0);
    // end;

    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // begin
    //     if not Confirm(MSG003, false) then
    //         exit(false);
    // end;

    // var
    //     WorkMessage: Text;
    //     SMSLength: Integer;
    //     MSG001: Label 'The message length exceeds 2000 bytes. Only messages of 2000 bytes or less can be sent.';
    //     MSG002: Label 'There is no message to send.';
    //     MSG003: Label 'close this window?';
    //     SetContract: Boolean;
    //     ContractNo: Code[20];
    //     CemeteryCode: Code[20];
    //     CemeteryNo: Text[50];
    //     MSG004: Label 'SMS Sending';
    //     MSG005: Label 'Are you sure you want to clear the Sended SMS message?';
    //     MessageType: Text[2000];
    //     MessageTypeOption: Option General,PurchContract,RemAmount,Vehicle,FieldWork,CustRequest,Service,PaymentExpectPG,PaymentExpectVA;
    //     MSG006: Label 'Not Found Contract.';
    //     GeneralMSG: Label '%1:Customer Name, %2:Cemetery No., %3:General Expiration Date, %4:Landscape Expiration Date, %5: General Non-Payment, %6: Landscape Non-Payment, %7: TODAY, %8: General Start Date, %9: Landscape Start Date, %10: Bank Account NH, %11: Bank Account IBK, %12: General Expiration Date (atfer 5 Year), %13: General Payment (5 Year), %14: Landscape Expiration Date (atfer 5 Year), %15: Landscape Payment (5 year), %16: General Expiration Date (atfer 1 Year), %17: General Payment (1 Year), %18: Landscape Expiration Date (atfer 1 Year), %19: Landscape Payment (1 year), %20: General Expiration Date (atfer 2 Year), %21: General Payment (2 Year), %22: Landscape Expiration Date (atfer 2 Year), %23: Landscape Payment (2 year), %24:Total (5 Year), %25:Total (1 Year), %26:Total (2 Year)';
    //     ServiceMSG: Label '%1: Applicant Name,%2: Field Work Main Category,%3: Field Work Sub Category,%4: Process Date,%5: Process Content';
    //     VehicleMSG: Label '%1: Vehicle No.,%2: Vehicle Name,%3: Repair Date,%4: Repair Item Type,%5: Receiver';
    //     RemAmountMSG: Label '%1: Customer Name,%2: Cemetery No.,%3: Contract Amount,%4: Remaining Amount,%5: Pay. Remaining Amount,%6:Remaining Due Date';
    //     FieldWorkMSG: Label '%1: Applicant Name,%2: Field Work Main Category,%3: Field Work Sub Category,%4: Process Content';
    //     PurchContractMSG: Label '%1: Purhcase Contract Title,%2: Contract Date To,%3: Contract Amount, %4: Department, %5: Contrct Content';
    //     CustRequestMSG: Label '%1: Applicant Name,%2: Field Work Sub Category,%3:Receipt Date,%4: Process Date,%5: Process Content';
    //     ReceiptMSG: Label '%1: Depositor,%2: Payment,%3: Cemetery No.,%4: Payment Target,%5: Process Content';
    //     MessageTypeText: Text;
    //     TempBlob: Record TempBlob temporary;
    //     PaymentExpensePGMSG: Label '%1: Applicant Name,%2: Cemetery No.,%3: Amount,%4: Expiration Date,%5: Link URL';
    //     PaymentExpenseVAMSG: Label '%1: Applicant Name,%2: Cemetery No.,%3: Virtual Account No.,%4: Bank Name,%5: Account Holder,%6: Amount,%7: Expiration Date';
    //     OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
    //     DeleteImageQst: Label 'Are you sure you want to delete the picture?';
    //     SelectPictureTxt: Label 'Select a picture to upload';
    //     CompPhone: Boolean;
    //     BusinessContacts: Text[30];
    //     CompPhoneNo: Text[30];
    //     ContactName: Text[50];
    //     ReagreeMSG: Label '%1: Name, %2: Type, %3: Today, %4: Personal Data concu. Date, %5: Mobile No.';

    // procedure SetWorkMessage(pNewWorkMessage: Text)
    // var
    //     _TempBlob: Record TempBlob temporary;
    // begin
    //     Clear("SMS Message");
    //     if pNewWorkMessage = '' then
    //         exit;

    //     _TempBlob.Blob := "SMS Message";
    //     _TempBlob.WriteAsText(pNewWorkMessage, TEXTENCODING::Windows);
    //     "Short Message" := CopyStr(pNewWorkMessage, 1, 200);
    //     "SMS Message" := _TempBlob.Blob;
    //     Rec. Modify;
    // end;

    // procedure GetWorkMessage(): Text
    // begin
    //    Rec.CalcFields("SMS Message");
    //     exit(GetWorkMessageCalculated);
    // end;

    // procedure GetWorkMessageCalculated(): Text
    // var
    //     _TempBlob: Record TempBlob temporary;
    //     _CR: Text[1];
    // begin
    //     if not "SMS Message".HasValue then
    //         exit('');

    //     _CR[1] := 10;
    //     _TempBlob.Blob := "SMS Message";
    //     exit(_TempBlob.ReadAsText(_CR, TEXTENCODING::Windows));
    // end;

    // local procedure SendSMS()
    // var
    //     _ComFun: Codeunit "DK_Common Function";
    //     _InStream: InStream;
    //     _ImageServerFileName1: Text;
    //     _ImageServerFileName2: Text;
    //     _ImageServerFileName3: Text;
    //     _SMSSending: Codeunit "DK_Batch SMS Sending";
    //     _TempBlob: Record TempBlob temporary;
    // begin

    //     if "SMS Length" = 0 then
    //         Error(MSG002);

    //     if "SMS Length" > 1500 then
    //         Error(MSG001);

    //     if "From Contact" <> '' then
    //         _SMSSending.CheckMobileNo("From Contact");


    //     if Image1.HasValue then begin
    //         _TempBlob.Init;
    //        Rec.CalcFields(Image1);
    //         _TempBlob.Blob := Image1;
    //         _TempBlob.Insert;
    //         _ImageServerFileName1 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
    //         _TempBlob.Delete;
    //     end;

    //     if Image2.HasValue then begin
    //         _TempBlob.Init;
    //        Rec.CalcFields(Image2);
    //         _TempBlob.Blob := Image2;
    //         _TempBlob.Insert;
    //         _ImageServerFileName2 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
    //         _TempBlob.Delete;
    //     end;

    //     if Image3.HasValue then begin

    //         _TempBlob.Init;
    //        Rec.CalcFields(Image3);
    //         _TempBlob.Blob := Image3;
    //         _TempBlob.Insert;
    //         _ImageServerFileName3 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
    //         _TempBlob.Delete;
    //     end;

    //     _SMSSending.SendingSMS_SelectContract(PAGE::"DK_SMS Mobile No.",
    //                           "From Contact",
    //                           '',
    //                           WorkMessage,
    //                           _ImageServerFileName1,
    //                           _ImageServerFileName2,
    //                           _ImageServerFileName3,
    //                           "Contract No.", MessageTypeOption, "Biz Talk Tamplate No.");


    //     if Confirm(MSG005, true, MSG004) then begin
    //         WorkMessage := '';
    //         OnValudateWorkMessage;
    //         Clear(Image1);
    //         Clear(Image2);
    //         Clear(Image3);

    //         CurrPage.Update;
    //     end;
    // end;

    // local procedure SetToMobile()
    // var
    //     _SelContract: Record "DK_Selected Contract";
    //     _ReportBuffer: Record "DK_Report Buffer";
    //     _NewEntryNo: Integer;
    // begin

    //     //Reset;
    //     _ReportBuffer.Reset;
    //     _ReportBuffer.SetRange("OBJECT ID", PAGE::"DK_SMS Mobile No.");
    //     _ReportBuffer.SetRange("USER ID", UserId);
    //     if _ReportBuffer.FindSet then
    //         _ReportBuffer.DeleteAll;


    //     _SelContract.Reset;
    //     _SelContract.SetRange("USER ID", UserId);
    //     _SelContract.SetFilter("Cust. Mobile No.", '<>%1', '');
    //     if _SelContract.FindSet then begin
    //         repeat
    //             _NewEntryNo += 1;

    //             _ReportBuffer.Init;
    //             _ReportBuffer."OBJECT ID" := PAGE::"DK_SMS Mobile No.";
    //             _ReportBuffer."Entry No." := _NewEntryNo;
    //             _ReportBuffer."USER ID" := UserId;
    //             _ReportBuffer.CODE0 := _SelContract."Cust. Mobile No.";
    //             _ReportBuffer.CODE1 := _SelContract."Contract No.";

    //             _ReportBuffer.TEXT0 := _SelContract."Contact Name";
    //             _ReportBuffer.TEXT1 := _SelContract."Cemetery No.";
    //             _ReportBuffer.Insert;

    //         until _SelContract.Next = 0;
    //     end;
    // end;


    // procedure SetSelectContract(pContractNo: Code[20])
    // begin
    //     SetContract := true;
    //     ContractNo := pContractNo;
    // end;

    // local procedure OnValudateWorkMessage()
    // var
    //     _CommonFunction: Codeunit "DK_Common Function";
    // begin

    //     Clear(_CommonFunction);
    //     "SMS Length" := _CommonFunction.GetKoreanCharLen(WorkMessage);

    //     if "SMS Length" > 1500 then
    //         Error(MSG001);

    //     SetWorkMessage(WorkMessage);
    // end;


    // procedure SelectMessage()
    // var
    //     _SMS: Record DK_SMS;
    //     _SMSList: Page "DK_SMS List";
    //                   _CommonFunction: Codeunit "DK_Common Function";
    // begin
    //     Clear(_SMSList);
    //     _SMSList.LookupMode(true);
    //     _SMSList.SetTableView(_SMS);
    //     _SMSList.SetRecord(_SMS);
    //     if _SMSList.RunModal = ACTION::LookupOK then begin
    //         _SMSList.GetRecord(_SMS);

    //         SetWorkMessage(_SMS."Short Message");
    //         MessageTypeText := Format(_SMS.Type);
    //         SetMessageType(_SMS.Type);
    //         "Biz Talk Tamplate No." := _SMS."Biz Talk Tamplate No.";

    //         if "Short Message" <> '' then begin
    //             Clear(_CommonFunction);
    //             "SMS Length" := _CommonFunction.GetKoreanCharLen(_SMS."Short Message");

    //             if "SMS Length" > 1500 then
    //                 Error(MSG001);
    //         end else begin
    //             "SMS Length" := 0;
    //         end;

    //         Rec. Modify;
    //     end;
    // end;

    // local procedure SetMessageType(pType: Option)
    // begin

    //     case pType of
    //         0:
    //             begin
    //                 MessageType := GeneralMSG;
    //             end;
    //         1:
    //             begin
    //                 MessageType := ServiceMSG;
    //             end;
    //         2:
    //             begin
    //                 MessageType := VehicleMSG;
    //             end;
    //         3:
    //             begin
    //                 MessageType := RemAmountMSG;
    //             end;
    //         4:
    //             begin
    //                 MessageType := FieldWorkMSG;
    //             end;
    //         5:
    //             begin
    //                 MessageType := PurchContractMSG;
    //             end;
    //         6:
    //             begin
    //                 MessageType := CustRequestMSG;
    //             end;
    //         7:
    //             begin
    //                 MessageType := ReceiptMSG;
    //             end;
    //         8:
    //             begin
    //                 MessageType := PaymentExpensePGMSG;
    //             end;
    //         9:
    //             begin
    //                 MessageType := PaymentExpenseVAMSG;
    //             end;
    //         10:
    //             begin
    //                 MessageType := ReagreeMSG;    // DK34
    //             end;
    //     end;

    //     CurrPage.Update;
    // end;

    // local procedure PreviewMessage()
    // var
    //     _Contract: Record DK_Contract;
    //     _CemeteryServices: Record "DK_Cemetery Services";
    //     _PreviewMSG: Text;
    //     _BatchSMSSending: Codeunit "DK_Batch SMS Sending";
    // begin

    //     if WorkMessage = '' then
    //         Error(MSG002);

    //     if "Contract No." = '' then
    //         Error(MSG006);

    //     Clear(_BatchSMSSending);
    //     _PreviewMSG := _BatchSMSSending.SetMessageType(MessageTypeOption, WorkMessage, "Contract No.");

    //     Message('%1', _PreviewMSG);
    // end;

    // local procedure Image1_OnValidate()
    // var
    //     _TempBlob: Record TempBlob temporary;
    //     _CommFun: Codeunit "DK_Common Function";
    // begin
    //    Rec.CalcFields(Image1);
    //     if Image1.HasValue then begin
    //         _TempBlob.Blob := Image1;
    //         _CommFun.ResizeImage(_TempBlob, true, true, 200, 200);
    //         Image1 := _TempBlob.Blob;
    //     end;
    // end;

    // local procedure Image2_OnValidate()
    // var
    //     _TempBlob: Record TempBlob temporary;
    //     _CommFun: Codeunit "DK_Common Function";
    // begin
    //    Rec.CalcFields(Image2);
    //     if Image2.HasValue then begin
    //         _TempBlob.Blob := Image2;
    //         _CommFun.ResizeImage(_TempBlob, true, true, 200, 200);
    //         Image2 := _TempBlob.Blob;
    //     end;
    // end;

    // local procedure Image3_OnValidate()
    // var
    //     _TempBlob: Record TempBlob temporary;
    //     _CommFun: Codeunit "DK_Common Function";
    // begin
    //    Rec.CalcFields(Image3);
    //     if Image1.HasValue then begin
    //         _TempBlob.Blob := Image3;
    //         _CommFun.ResizeImage(_TempBlob, true, true, 200, 200);
    //         Image3 := _TempBlob.Blob;
    //     end;
    // end;
}

