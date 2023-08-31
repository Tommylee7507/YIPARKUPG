page 50089 "DK_Today Funeral Card"////zzz
{
    // 
    // DK34: 20201130
    //   - Add Field: "Move The Grave Type"

    Caption = 'Today Funeral Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Today Funeral";

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             field("No."; Rec."No.")
    //             {
    //                 Editable = false;
    //                 Importance = Additional;

    //                 trigger OnAssistEdit()
    //                 begin
    //                     Rec.AssistEdit(Rec);
    //                 end;
    //             }
    //             field(Date; Rec.Date)
    //             {
    //             }
    //             field("Field Work Main Cat. Code"; Rec."Field Work Main Cat. Code")
    //             {
    //                 Importance = Additional;

    //                 trigger OnValidate()
    //                 begin
    //                     Contract_Onvalidate;
    //                 end;
    //             }
    //             field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
    //             {
    //             }
    //             field("Contract No."; Rec."Contract No.")
    //             {

    //                 trigger OnValidate()
    //                 begin
    //                     Contract_Onvalidate;
    //                 end;
    //             }
    //             field("Cemetery No."; Rec."Cemetery No.")
    //             {
    //             }
    //             field("Cemetery Digits"; Rec."Cemetery Digits")
    //             {
    //             }
    //             field(Size; Rec.Size)
    //             {
    //             }
    //             field("Arrival Time"; Rec."Arrival Time")
    //             {
    //             }
    //             field("Opening Time"; Rec."Opening Time")
    //             {
    //             }
    //             field(Applicant; Rec.Applicant)
    //             {
    //             }
    //             field(Address; Rec.Address)
    //             {

    //                 trigger OnAssistEdit()
    //                 begin
    //                     Rec.AddressLookup;
    //                 end;
    //             }
    //             field("Address 2"; Rec."Address 2")
    //             {
    //             }
    //             field("Post Code"; Rec."Post Code")
    //             {
    //             }
    //             field(Remark; Rec.Remark)
    //             {
    //             }
    //             field("Phone No."; Rec."Phone No.")
    //             {
    //             }
    //             field("Mobile No."; Rec."Mobile No.")
    //             {
    //             }
    //             field("Working Group Code"; Rec."Working Group Code")
    //             {
    //                 Importance = Additional;
    //             }
    //             field("Working Group Name"; Rec."Working Group Name")
    //             {
    //             }
    //             field("Move The Grave Type"; Rec."Move The Grave Type")
    //             {
    //             }
    //             field(Status; Rec.Status)
    //             {
    //             }
    //         }
    //         group("Reception Documents")
    //         {
    //             Caption = 'Reception Documents';
    //             group("Group 1")
    //             {
    //                 Caption = 'Group 1';
    //                 field("Document 1"; Rec."Document 1")
    //                 {
    //                 }
    //                 field("Document 2"; Rec."Document 2")
    //                 {
    //                 }
    //                 field("Document 3"; Rec."Document 3")
    //                 {
    //                 }
    //                 field("Document 4"; Rec."Document 4")
    //                 {
    //                 }
    //             }
    //             group("Group 2")
    //             {
    //                 Caption = 'Group 2';
    //                 field("Document 5"; Rec."Document 5")
    //                 {
    //                 }
    //                 field("Document 6"; Rec."Document 6")
    //                 {
    //                 }
    //                 field("Document 7"; Rec."Document 7")
    //                 {
    //                 }
    //             }
    //             group("Group 3")
    //             {
    //                 Caption = 'Group 3';
    //                 field("Document 8"; Rec."Document 8")
    //                 {
    //                 }
    //                 field("Document 9"; Rec."Document 9")
    //                 {
    //                 }
    //             }
    //         }
    //         part(TodayFuneralLine; Rec."DK_Today Funeral Subform")
    //         {
    //             Caption = 'Line';
    //             SubPageLink = "Document No."=FIELD("No.");
    //             ToolTip = 'You can enter multiple corpse for today''s funeral.';
    //             UpdatePropagation = Both;
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
    //         part(Control14;Rec."DK_Contract Detail Factbox")
    //         {
    //             SubPageLink = "No."=FIELD("Contract No.");
    //         }
    //         systempart(Control22;Notes)
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
    //             Enabled = Rec.Status <> Status::Open;
    //             Image = ReOpen;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             ToolTip = 'It is a function to change the document of today funeral to the open Status.';

    //             trigger OnAction()
    //             var
    //                 _DK_TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
    //             begin
    //                 _DK_TodayFuneralPost.SetOpen(Rec);
    //             end;
    //         }
    //         action(Release)
    //         {
    //             Caption = 'Release';
    //             Enabled = Rec.Status <> Status::Release;
    //             Image = ReleaseDoc;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             ToolTip = 'It is a function to release the document of today Funeral.';

    //             trigger OnAction()
    //             var
    //                 _DK_TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
    //             begin
    //                 _DK_TodayFuneralPost.SetRelease(Rec);
    //             end;
    //         }
    //         action("Post Field Work")
    //         {
    //             Caption = 'Post Field Work';
    //             Enabled = Rec.Status <> Status::Post;
    //             Image = PostDocument;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             ToolTip = 'It is a function to transfer the document of today funeral to the park management office.';

    //             trigger OnAction()
    //             var
    //                 _ToadyFuneralPost: Codeunit "DK_Today Funeral - Post";
    //             begin

    //                 if _ToadyFuneralPost.Post(Rec) then
    //                   Message(MSG001,FieldCaption(Status),Status::Post);
    //             end;
    //         }
    //         action("Field Work Delete")
    //         {
    //             Caption = 'Field Work Delete';
    //             Enabled = Rec.Status = Rec.Status::Post;
    //             Image = PostDocument;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             ToolTip = 'It is a function to transfer the document of today funeral to the park management office.';

    //             trigger OnAction()
    //             var
    //                 _ToadyFuneralPost: Codeunit "DK_Today Funeral - Post";
    //             begin

    //                 //IF _ToadyFuneralPost.Post(Rec) THEN
    //                 //  MESSAGE(MSG001,FIELDCAPTION(Status),Status::Post);

    //                 if _ToadyFuneralPost.Delete_FieldWork("No.") then begin

    //                   Status := Rec.Status::Release;

    //                   Message(MSG002);
    //                 end;
    //             end;
    //         }
    //     }
    // }

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     //Date := WORKDATE;

    //     //EVALUATE("Arrival Time",FORMAT(TIME,0,'<Hours24>.<Minutes,2>.<Seconds,2>'));
    //     //EVALUATE("Opening Time",FORMAT(TIME,0,'<Hours24>.<Minutes,2>.<Seconds,2>'));
    //     //"Opening Time" := DT2TIME(CURRENTDATETIME);
    // end;

    // var
    //     MSG001: Label '%1 has been Rec. Modify to %2.';
    //     MSG002: Label 'Œ÷‘ñ…—Ž·„Ÿ„¾.';

    // local procedure AddressLookup()
    // var
    //     _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
    //     _TmpCode: Code[20];
    //     _TmpText: Text[50];
    // begin

    //     Clear(_DK_KoreanRoadAddrMgt);

    //     _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Address,"Address 2","Post Code",_TmpText,_TmpCode);
    // end;

    // local procedure Contract_Onvalidate()
    // begin

    //     CurrPage.TodayFuneralLine.PAGE.GetTodayHeader("Contract No.","Field Work Main Cat. Code");
    //     CurrPage.Update;
    // end;
}

