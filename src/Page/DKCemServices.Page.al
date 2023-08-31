page 50125 "DK_Cem. Services"////zzz
{
    Caption = 'Cemetery Services';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Copy,Payment Expect,Payment';
    SourceTable = "DK_Cemetery Services";
    SourceTableView = WHERE(Status = FILTER(<> Complete));

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             group("Service Information")
    //             {
    //                 Caption = 'Service Information';
    //                 field("No."; Rec."No.")
    //                 {
    //                     Editable = false;
    //                     Importance = Additional;

    //                     trigger OnAssistEdit()
    //                     begin
    //                         Rec.AssistEdit(Rec);
    //                     end;
    //                 }
    //                 field("Contract No."; Rec."Contract No.")
    //                 {
    //                 }
    //                 field("Cemetery Code"; Rec."Cemetery Code")
    //                 {
    //                     Importance = Additional;
    //                 }
    //                 field("Cemetery No."; Rec."Cemetery No.")
    //                 {
    //                 }
    //                 field("Field Work Main Cat. Code"; Rec."Field Work Main Cat. Code")
    //                 {
    //                     Importance = Additional;
    //                 }
    //                 field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
    //                 {
    //                 }
    //                 field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
    //                 {
    //                     Importance = Additional;
    //                 }
    //                 field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
    //                 {
    //                 }
    //                 field(Description; Rec.Description)
    //                 {
    //                     Enabled = false;
    //                 }
    //                 field(Unit; Rec.Unit)
    //                 {
    //                     Enabled = false;
    //                 }
    //                 field("Cost Amount"; Rec."Cost Amount")
    //                 {
    //                 }
    //                 field(Quantity; Rec.Quantity)
    //                 {
    //                 }
    //                 field("Discount Amount"; Rec."Discount Amount")
    //                 {
    //                 }
    //                 field(Amount; Rec.Amount)
    //                 {
    //                 }
    //                 field("Receipt Amount"; Rec."Receipt Amount")
    //                 {
    //                 }
    //                 field("Receipt Amount Date"; Rec."Receipt Amount Date")
    //                 {
    //                 }
    //                 field("Payment Type"; Rec."Payment Type")
    //                 {
    //                 }
    //                 field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
    //                 {
    //                 }
    //             }
    //             group("Receipt Information")
    //             {
    //                 Caption = 'Receipt Information';
    //                 field("Receipt Date"; Rec."Receipt Date")
    //                 {
    //                 }
    //                 field("Desired Date"; Rec."Desired Date")
    //                 {
    //                 }
    //                 field(Religion; Rec.Religion)
    //                 {
    //                 }
    //                 field("Corpse Name"; Rec."Corpse Name")
    //                 {
    //                 }
    //                 field("Date Of Birth"; Rec."Date Of Birth")
    //                 {
    //                 }
    //                 field("Death Date"; Rec."Death Date")
    //                 {
    //                 }
    //                 field(Remarks; Rec.Remarks)
    //                 {
    //                 }
    //                 field("Work Date"; Rec."Work Date")
    //                 {
    //                 }
    //                 field("SMS Send Date"; Rec."SMS Send Date")
    //                 {
    //                     Editable = false;
    //                     Importance = Additional;
    //                 }
    //                 field("Employee No."; Rec."Employee No.")
    //                 {
    //                     Importance = Additional;
    //                 }
    //                 field("Employee Name"; Rec."Employee Name")
    //                 {
    //                 }
    //                 field(Status; Rec.Status)
    //                 {
    //                 }
    //             }
    //         }
    //         group(Contract)
    //         {
    //             Caption = 'Contract Information';
    //             field("Supervise No."; Rec."Supervise No.")
    //             {
    //             }
    //             field("Main Customer No."; Rec."Main Customer No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Importance = Additional;
    //                 Lookup = false;
    //             }
    //             field("Main Customer Name"; Rec."Main Customer Name")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Cust. Mobile No."; Rec."Cust. Mobile No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Cust. Phone No."; Rec."Cust. Phone No.")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //             field("Cust. E-mail"; Rec."Cust. E-mail")
    //             {
    //                 AssistEdit = false;
    //                 DrillDown = false;
    //                 Lookup = false;
    //             }
    //         }
    //         group(Applicant)
    //         {
    //             Caption = 'Applicant Information';
    //             field("Appl. Name"; Rec."Appl. Name")
    //             {
    //             }
    //             field("Appl. Mobile No."; Rec."Appl. Mobile No.")
    //             {
    //             }
    //             field("Appl. Phone No."; Rec."Appl. Phone No.")
    //             {
    //             }
    //             field("Email Status"; Rec."Email Status")
    //             {
    //             }
    //             field("Appl. E-mail"; Rec."Appl. E-mail")
    //             {
    //                 Enabled = Rec."Email Status" = FALSE;
    //             }
    //             field("Relationship With Cust."; Rec."Relationship With Cust.")
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
    //         part(Control46; Rec."DK_Contract Detail Factbox")
    //         {
    //             SubPageLink = "No." = FIELD("Contract No.");
    //         }
    //         systempart(Control32; Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Payment Receipt Document")
    //         {
    //             Caption = 'Payment Receipt Document';
    //             Image = ReceiptLines;
    //             Promoted = true;
    //             PromotedCategory = Category5;
    //             PromotedIsBig = true;
    //             RunObject = Page "DK_Pay. Expect Document List";
    // ////  RunPageLink = Rec."Source Type" = CONST(Service),"Source No." = FIELD("No.");

    // trigger OnAction()
    // var
    //     _PayRecDoc: Record "DK_Payment Receipt Document";
    // begin
    // end;
    //         }
    //         action("Create Payment Receipt Doc.")
    //         {
    //             Caption = 'Create Payment Receipt Doc.';
    //             Image = NewBank;
    //             Promoted = true;
    //             PromotedCategory = Category5;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             var
    //                 _PaymentExpect: Codeunit "DK_Payment Expect";
    //                 _PayExpectDocument: Page "DK_Pay. Expect Document";
    //                                         _PayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
    //                                         _PayExpectDocNo: Code[20];
    //             begin
    //                 //ß‘ª ‰‘ñ‰«Œ¡ ‹²ŒŠ
    //                 if Status <> Status::Release then
    //                     Error(MSG003, Rec.FieldCaption(Status), Status::Release);

    //                 if Rec."Pay. Expect Doc. No." <> '' then
    //                     Error(MSG004, Rec.FieldCaption("Pay. Expect Doc. No."), Rec."Pay. Expect Doc. No.");

    //                 if Rec."Payment Rec. Doc. No." <> '' then
    //                     Error(MSG004, Rec.FieldCaption("Payment Rec. Doc. No."), Rec."Payment Rec. Doc. No.");

    //                 Clear(_PaymentExpect);
    //                 _PayExpectDocNo := _PaymentExpect.CreateFromCemeteryService(Rec);

    //                 if _PayExpectDocNo = '' then exit;

    //                 if _PayExpectDocHeader.Get(_PayExpectDocNo) then begin
    //                     Clear(_PayExpectDocument);
    //                     _PayExpectDocument.LookupMode(true);
    //                     _PayExpectDocument.SetTableView(_PayExpectDocHeader);
    //                     _PayExpectDocument.SetRecord(_PayExpectDocHeader);
    //                     _PayExpectDocument.RunModal;
    //                 end;
    //             end;
    //         }
    //         action(DK_PaymentDocumetView)
    //         {
    //             Caption = 'Payment Document View';
    //             Enabled = PaymentDocView;
    //             Image = ReceiptLines;
    //             Promoted = true;
    //             PromotedCategory = Category6;
    //             PromotedIsBig = true;
    //             Visible = PaymentDocView;

    //             trigger OnAction()
    //             var
    //                 _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    //                 _PostedItemReceipt: Page "DK_Post Pay. Receipt Doc. List";
    //             begin

    //                 _PaymentReceiptDocument.Reset;
    //                 _PaymentReceiptDocument.CalcFields("Line Cem. Services No.");
    //                 _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
    //                 _PaymentReceiptDocument.SetRange("Line Cem. Services No.", Rec."No.");
    //                 _PaymentReceiptDocument.SetRange(Posted, true);
    //                 if _PaymentReceiptDocument.FindSet then begin
    //                     Clear(_PostedItemReceipt);
    //                     _PostedItemReceipt.LookupMode(true);
    //                     _PostedItemReceipt.SetTableView(_PaymentReceiptDocument);
    //                     _PostedItemReceipt.SetRecord(_PaymentReceiptDocument);
    //                     _PostedItemReceipt.RunModal;
    //                 end;
    //             end;
    //         }
    //         action(Action64)
    //         {
    //             Caption = 'Create Payment Receipt Doc.';
    //             Image = NewBank;
    //             Promoted = true;
    //             PromotedCategory = Category6;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin

    //                 if Status <> Status::Release then Error(MSG005, Rec.FieldCaption(Status), Status::Release);
    //                 if Rec.Amount = Rec."Receipt Amount" then Error(MSG007);

    //                 OpenPayDocument;
    //             end;
    //         }
    //         group(Process)
    //         {
    //             Caption = 'Process';
    //             action(ReOpen)
    //             {
    //                 Caption = 'ReOpen';
    //                 Enabled = Rec.Status <> Status::Open;
    //                 Image = ReOpen;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to change the document of cemetery services to the open Status.';

    //                 trigger OnAction()
    //                 var
    //                     _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    //                 begin

    //                     _CemServicesPost.SetOpen(Rec);
    //                 end;
    //             }
    //             action(Release)
    //             {
    //                 Caption = 'Release';
    //                 Enabled = Rec.Status <> Status::Release;
    //                 Image = ReleaseDoc;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to release the document of cemetery services.';

    //                 trigger OnAction()
    //                 var
    //                     _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    //                 begin

    //                     _CemServicesPost.SetRelease(Rec);
    //                 end;
    //             }
    //             action("Post Field Work")
    //             {
    //                 Caption = 'Post Field Work';
    //                 Enabled = Rec.Status <> Status::Post;
    //                 Image = PostDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to transfer the document of cemetery services to the park management office.';

    //                 trigger OnAction()
    //                 var
    //                     _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    //                 begin

    //                     if _CemServicesPost.Post(Rec) then begin
    //                         Message(MSG001, Rec.FieldCaption(Status), Status::Post);
    //                     end;
    //                 end;
    //             }
    //             action(Complete)
    //             {
    //                 Caption = 'Complete';
    //                 Enabled = Rec.Status = Rec.Status::Release;
    //                 Image = Completed;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to complete the document of cemetery services.';

    //                 trigger OnAction()
    //                 var
    //                     _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    //                 begin

    //                     if _CemServicesPost.SetComplete(Rec) then
    //                         Message(MSG001, Rec.FieldCaption(Status), Status::Complete);
    //                 end;
    //             }
    //         }
    //         group(Action56)
    //         {
    //             action("Customer Copy")
    //             {
    //                 Caption = 'Customer Copy';
    //                 Image = Copy;
    //                 Promoted = true;
    //                 PromotedCategory = Category4;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to copy contract information to applicant information.';

    //                 trigger OnAction()
    //                 var
    //                     _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    //                 begin

    //                     if not Confirm(MSG002, false, Rec.FieldCaption("Appl. Name"), Rec.FieldCaption("Main Customer Name")) then exit;

    //                     _CemServicesPost.AppllicantInset(Rec);
    //                 end;
    //             }
    //         }
    //     }
    // }

    // trigger OnAfterGetRecord()
    // begin
    //     PaymentDocActionView;
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // var
    //     _Employee: Record DK_Employee;
    // begin

    //     Rec."Receipt Date" := WorkDate;
    //     Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    // end;

    // var
    //     MSG001: Label 'The %1 has been Rec. Modify to a %2.';
    //     MSG002: Label 'Do you want to put the %2 on the %1?';
    //     MSG003: Label 'Only Action if %1 is %2.';
    //     MSG004: Label '%1 exists. %1:%2';
    //     MSG005: Label '%1 is not %2.';
    //     MSG006: Label 'Generated deposit document exists. Do you want to open the deposit document?';
    //     MSG007: Label 'This document has been deposited.';
    //     PaymentDocView: Boolean;

    // local procedure OpenPayDocument()
    // var
    //     _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    //     _PaymentReceiptDocumentPage: Page "DK_Payment Receipt Document";
    //                                      _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    // begin

    //     _PaymentReceiptDocument.Reset;
    //     _PaymentReceiptDocument.CalcFields("Line Cem. Services No.");
    //     _PaymentReceiptDocument.SetRange("Line Cem. Services No.", Rec."No.");
    //     _PaymentReceiptDocument.SetRange(Posted, false);
    //     _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
    //     if _PaymentReceiptDocument.FindSet then begin
    //         if not Confirm(MSG006, false) then exit;

    //         Clear(_PaymentReceiptDocumentPage);
    //         _PaymentReceiptDocumentPage.LookupMode(true);
    //         _PaymentReceiptDocumentPage.SetTableView(_PaymentReceiptDocument);
    //         _PaymentReceiptDocumentPage.SetRecord(_PaymentReceiptDocument);
    //         _PaymentReceiptDocumentPage.RunModal;
    //     end else begin
    //         _PaymentReceiptDocument.Init;
    //         _PaymentReceiptDocument."Document No." := '';
    //         _PaymentReceiptDocument.Validate(Amount, (Rec.Amount - Rec."Receipt Amount"));
    //         _PaymentReceiptDocument.Validate("Contract No.", Rec."Contract No.");
    //         _PaymentReceiptDocument.Depositor := Rec."Appl. Name";
    //         _PaymentReceiptDocument.Validate("Appl. Mobile No.", Rec."Appl. Mobile No.");
    //         _PaymentReceiptDocument.Insert(true);

    //         _PaymentReceiptDocLine.Init;
    //         _PaymentReceiptDocLine."Document No." := _PaymentReceiptDocument."Document No.";
    //         _PaymentReceiptDocLine."Line No." := 10000;
    //         _PaymentReceiptDocLine."Payment Target" := _PaymentReceiptDocLine."Payment Target"::Service;
    //         _PaymentReceiptDocLine."Cem. Services No." := Rec."No.";
    //         _PaymentReceiptDocLine.Amount := _PaymentReceiptDocument.Amount;
    //         _PaymentReceiptDocLine.Insert;

    //         Commit;

    //         Clear(_PaymentReceiptDocumentPage);
    //         _PaymentReceiptDocumentPage.LookupMode(true);
    //         _PaymentReceiptDocumentPage.SetTableView(_PaymentReceiptDocument);
    //         _PaymentReceiptDocumentPage.SetRecord(_PaymentReceiptDocument);
    //         _PaymentReceiptDocumentPage.RunModal;
    //     end;
    // end;

    // local procedure PaymentDocActionView()
    // var
    //     _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    //     _PostPayReceiptDocList: Page "DK_Post Pay. Receipt Doc. List";
    // begin

    //     PaymentDocView := false;

    //     _PaymentReceiptDocument.Reset;
    //     _PaymentReceiptDocument.CalcFields("Line Cem. Services No.");
    //     _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
    //     _PaymentReceiptDocument.SetRange("Line Cem. Services No.", Rec."No.");
    //     _PaymentReceiptDocument.SetRange(Posted, true);
    //     if _PaymentReceiptDocument.FindSet then begin
    //         PaymentDocView := true;
    //     end;
    // end;
}

