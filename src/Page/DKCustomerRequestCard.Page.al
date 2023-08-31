page 50061 "DK_Customer Request Card"////zzz
{
    // Caption = 'Customer Request Card';
    // DelayedInsert = false;
    // PageType = Card;
    // RefreshOnActivate = true;
    // SourceTable = "DK_Customer Requests";

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             Editable = Rec.Status <> Rec.Status::Complete;
    //             field("No."; Rec."No.")
    //             {
    //                 Importance = Additional;

    //                 trigger OnAssistEdit()
    //                 begin
    //                     //>>Auto No.
    //                     if Rec.AssistEdit(xRec) then
    //                         CurrPage.Update;
    //                     //<<Auto No.
    //                 end;
    //             }
    //             field(Title; Rec.Title)
    //             {
    //             }
    //             field("Employee No."; Rec."Employee No.")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Employee name"; Rec."Employee name")
    //             {
    //             }
    //             field("Customer Status"; Rec."Customer Status")
    //             {

    //                 trigger OnValidate()
    //                 begin
    //                     CustomerStatCheck();
    //                 end;
    //             }
    //             field("Process Date"; Rec."Process Date")
    //             {
    //             }
    //             field("Process Content"; Rec."Process Content")
    //             {
    //             }
    //             field(Remarks; Rec.Remarks)
    //             {
    //             }
    //             field(Status; Rec.Status)
    //             {

    //                 trigger OnValidate()
    //                 begin
    //                     ProceesDivCheck();
    //                 end;
    //             }
    //         }
    //         group("Customer Information")
    //         {
    //             Caption = 'Customer Information';
    //             Visible = CustomerVisible;
    //             field("Contract No."; Rec."Contract No.")
    //             {
    //             }
    //             field("Main Customer No."; Rec."Main Customer No.")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Main Customer Name"; Rec."Main Customer Name")
    //             {
    //             }
    //             field("Cust. Mobile No."; Rec."Cust. Mobile No.")
    //             {
    //             }
    //             field("Cust. Phone No."; Rec."Cust. Phone No.")
    //             {
    //             }
    //             field("Cust. E-mail"; Rec."Cust. E-mail")
    //             {
    //             }
    //             field("Cemetery Code"; Rec."Cemetery Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Cemetery No."; Rec."Cemetery No.")
    //             {
    //             }
    //         }
    //         group("Receipt Information")
    //         {
    //             Caption = 'Receipt Information';
    //             field("Receipt Date"; Rec."Receipt Date")
    //             {
    //             }
    //             field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
    //             {
    //             }
    //             field("Receipt Contents"; Rec."Receipt Contents")
    //             {
    //             }
    //             field("Work Cemetery Code"; Rec."Work Cemetery Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Work Cemetery No."; Rec."Work Cemetery No.")
    //             {
    //             }
    //             field("Receipt Method"; Rec."Receipt Method")
    //             {
    //             }
    //             field("Receipt Division"; Rec."Receipt Division")
    //             {
    //             }
    //             field("Work Division"; Rec."Work Division")
    //             {
    //             }
    //         }
    //         group("Applicant Information")
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
    //         group("Field Work Information")
    //         {
    //             Caption = 'Field Work Information';
    //             Editable = false;
    //             field("Feedback Date"; Rec."Feedback Date")
    //             {
    //             }
    //             field("Work Time Spent"; Rec."Work Time Spent")
    //             {
    //             }
    //             field("Work Manager Code"; Rec."Work Manager Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Work Manager"; Rec."Work Manager")
    //             {
    //             }
    //             field("Work Group Code"; Rec."Work Group Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Work Group"; Rec."Work Group")
    //             {
    //             }
    //             field("Work Personnel"; Rec."Work Personnel")
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
    //         part(Control64; Rec."DK_Contract Detail Factbox")
    //         {
    //             SubPageLink = "No." = FIELD("Contract No.");
    //         }
    //         systempart(Control41; Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Customer Copy")
    //         {
    //             Caption = 'Customer Copy';
    //             Enabled = Rec.Status <> Status::Post;
    //             Image = Copy;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             PromotedIsBig = true;
    //             ToolTip = 'It is a function to copy Customer information to applicant information.';

    //             trigger OnAction()
    //             begin
    //                 if Status = Rec.Status::Complete then
    //                     Error(MSG003, Format(Status::Complete));

    //                 if not Confirm(MSG001, false) then exit;

    //                 AppllicantInset(true);
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
    //                 ToolTip = 'It is a function to change the document of customer requirements to the open Status.';

    //                 trigger OnAction()
    //                 begin
    //                     SetOpen;
    //                 end;
    //             }
    //             action("Šˆ‡õ")
    //             {
    //                 Caption = 'Šˆ‡õ';
    //                 Image = Pause;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
    //                 begin
    //                     _CustomerRequestPost.Set_Hold(Rec);
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
    //                 ToolTip = 'It is a function to release the document of customer request.';

    //                 trigger OnAction()
    //                 begin
    //                     SetRelease;
    //                 end;
    //             }
    //             action("Post Field Work")
    //             {
    //                 Caption = 'Post Field Work';
    //                 Enabled = Rec.Status = Rec.Status::Release;
    //                 Image = PostDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to transfer the document of customer requirements to the park management office.';

    //                 trigger OnAction()
    //                 var
    //                     _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
    //                 begin
    //                     Rec.TestField(Status, Status::Release);

    //                     if _CustomerRequestPost.Post(Rec) then
    //                         Message(MSG002, FieldCaption(Status), Status::Post);
    //                 end;
    //             }
    //             action(Imposible)
    //             {
    //                 Caption = 'Imposible';
    //                 Enabled = Rec.Status <> Status::Impossible;
    //                 Image = CloseDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
    //                 begin
    //                     WorkBlockedCheck(Rec);
    //                     if _CustomerRequestPost.Cancel(Rec) then
    //                         Message(MSG002, FieldCaption(Status), Status::Impossible);
    //                 end;
    //             }
    //             action(Cancel)
    //             {
    //                 Caption = 'Cancel';
    //                 Image = ReopenCancelled;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
    //                 begin

    //                     _CustomerRequestPost.SetReceiptCancel(Rec);
    //                 end;
    //             }
    //             action(Complete)
    //             {
    //                 Caption = 'Complete';
    //                 Enabled = Rec.Status <> Status::Complete;
    //                 Image = Completed;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ToolTip = 'It is a function to complete the document of customer requirements.';

    //                 trigger OnAction()
    //                 begin
    //                     SetComplete;
    //                     //MESSAGE(MSG002,FIELDCAPTION(Status),Status::Complete);
    //                 end;
    //             }
    //         }
    //     }
    // }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     ProceesDivCheck();
    //     CustomerStatCheck();
    // end;

    // trigger OnAfterGetRecord()
    // begin
    //     ProceesDivCheck();
    //     CustomerStatCheck();
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // var
    //     _Employee: Record DK_Employee;
    //     _ContractNo: Code[20];
    // begin

    //     "Receipt Date" := WorkDate;
    //     Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));

    //     if GetFilter("Contract No.") <> '' then begin
    //         _ContractNo := GetRangeMin("Contract No.");

    //         if _ContractNo <> '' then
    //             Rec.Validate("Contract No.", _ContractNo);
    //     end;
    // end;

    // trigger OnOpenPage()
    // begin
    //     ProceesDivCheck();
    // end;

    // var
    //     MSG001: Label 'Would you like to include customer information in applicant information?';
    //     CustomerVisible: Boolean;
    //     PostEnable: Boolean;
    //     ImposibleEnable: Boolean;
    //     MSG002: Label 'The %1 has been Rec. Modify to a %2.';
    //     MSG003: Label 'It''s already %1.';


    // procedure ProceesDivCheck()
    // begin
    //     //Status Check
    //     if Status <> Status::Complete then begin
    //         case Status of
    //             Status::Open:
    //                 begin
    //                     PostEnable := true;
    //                     ImposibleEnable := true;
    //                 end;
    //             Status::Post:
    //                 begin
    //                     PostEnable := false;
    //                     ImposibleEnable := true;
    //                 end;
    //             Status::Complete:
    //                 begin
    //                     ImposibleEnable := false;
    //                     PostEnable := false;
    //                 end;
    //             Status::Impossible:
    //                 begin
    //                     PostEnable := false;
    //                     ImposibleEnable := false;
    //                 end;
    //         end;
    //     end;
    // end;


    // procedure CustomerStatCheck()
    // begin
    //     if "Customer Status" = "Customer Status"::Customer then
    //         CustomerVisible := true
    //     else
    //         CustomerVisible := false;
    // end;
}

