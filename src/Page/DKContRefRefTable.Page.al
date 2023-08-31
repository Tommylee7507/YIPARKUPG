page 50067 "DK_Cont. Ref. Ref. Table"////zzz
{
    // *DK33 : 20200730
    //   - Add Field : Type
    //   - Rec. Modify Parts(DK_Cont. Refund Ref. Detail).SubPageLink : Starting Date=FIELD(Starting Date) -> Starting Date=FIELD(Starting Date),Type=FIELD(Type)

    Caption = 'Contract refund Reference Table';
    PageType = Document;
    SourceTable = "DK_Cont. Refund Ref. Table";////zzz

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             field("Starting Date"; Rec."Starting Date")
    //             {
    //             }
    //             field("Estate Type"; Rec."Estate Type")
    //             {
    //             }
    //             field(Description; Rec.Description)
    //             {
    //             }
    //             field(Status; Rec.Status)
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
    //         part(Control12; Rec."DK_Cont. Refund Ref. Detail")
    //         {
    //             SubPageLink = "Starting Date"=FIELD("Starting Date"),
    //                           "Estate Type"=FIELD("Estate Type");
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         systempart(Control10;Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         group(Action16)
    //         {
    //             Caption = 'Release';
    //             Image = ReleaseDoc;
    //             action(Release)
    //             {
    //                 ApplicationArea = Suite;
    //                 Caption = 'Release';
    //                 Image = ReleaseDoc;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;
    //                 ShortCutKey = 'Ctrl+F9';

    //                 trigger OnAction()
    //                 var
    //                     ReleaseSalesDoc: Codeunit "Release Sales Document";
    //                 begin
    //                     SetReleased;
    //                 end;
    //             }
    //             action(Reopen)
    //             {
    //                 ApplicationArea = Basic,Suite;
    //                 Caption = 'Re&open';
    //                 Enabled = Rec.Status <> Status::Open;
    //                 Image = ReOpen;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedOnly = true;

    //                 trigger OnAction()
    //                 var
    //                     ReleaseSalesDoc: Codeunit "Release Sales Document";
    //                 begin
    //                     SetReOpen;
    //                 end;
    //             }
    //         }
    //     }
    // }

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     "Starting Date" := WorkDate;
    // end;
}

