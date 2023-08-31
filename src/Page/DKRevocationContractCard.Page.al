page 50144 "DK_Revocation Contract Card"
{
    // *DK33 : 20200730
    //   - Add Field : "Estate Type"
    // 
    // #2517 : 20210402
    //   - Rec. Modify Function: Complate
    //   - Add Text Constant: MSG008

    Caption = 'Revocation Contract Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Revocation Contract";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Contract No." <> Rec."Contract No." then
                            WorkContents := '';
                    end;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Importance = Additional;
                    Lookup = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Estate Type"; Rec."Estate Type")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Revocation Date"; Rec."Revocation Date")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Giving Up"; Rec."Giving Up")
                {
                }
                field("First Laying Date"; Rec."First Laying Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Revocation Employee No."; Rec."Revocation Employee No.")
                {
                    Importance = Additional;
                }
                field("Revocation Employee Name"; Rec."Revocation Employee Name")
                {
                }
                field("Run Refund Calculation"; Rec."Run Refund Calculation")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
                group("Revocation Contents")
                {
                    Caption = 'Revocation Contents';
                    field(WorkContents; WorkContents)
                    {
                        MultiLine = true;
                        ShowMandatory = false;

                        trigger OnValidate()
                        begin
                            if not (Rec.Status in [Rec.Status::Open, Rec.Status::Released]) then
                                Error(MSG005, Rec.FieldCaption(Status), Rec.Status::Open, Rec.Status::Released);

                            Rec.SetWorkContents(WorkContents);
                        end;
                    }
                }
            }
            group(Revocation)
            {
                Caption = 'Revocation';
                group("System Refund")
                {
                    Caption = 'System Refund';
                    field("Refund Rate"; Rec."Refund Rate")
                    {
                        Editable = false;
                    }
                    field("Sales Rev. Amount"; Rec."Sales Rev. Amount")
                    {
                        Editable = false;
                    }
                    field("Sys. Refund Cemetery Amount"; Rec."Sys. Refund Cemetery Amount")
                    {
                        Caption = 'Cemetery Amount';
                    }
                    field("Sys. Refund Bury Amount"; Rec."Sys. Refund Bury Amount")
                    {
                        Caption = 'Bury Amount';
                    }
                    field("Sys. Refund General Amount"; Rec."Sys. Refund General Amount")
                    {
                        Caption = 'General Amount';
                    }
                    field("Sys. Refund Land. Arc. Amount"; Rec."Sys. Refund Land. Arc. Amount")
                    {
                        Caption = 'Landscape Architecture Amount';
                    }
                    field("System Refund Amount"; Rec."System Refund Amount")
                    {
                        Caption = 'Total Refund Amount';
                    }
                }
                group("Apply Refund")
                {
                    Caption = 'Apply Refund';
                    field("Refund Cemetery Amount"; Rec."Refund Cemetery Amount")
                    {
                        Caption = 'Cemetery Amount';
                    }
                    field("Refund Bury Amount"; Rec."Refund Bury Amount")
                    {
                        Caption = 'Bury Amount';
                    }
                    field("Refund General Amount"; Rec."Refund General Amount")
                    {
                        Caption = 'General Amount';
                    }
                    field("Refund Land. Arc. Amount"; Rec."Refund Land. Arc. Amount")
                    {
                        Caption = 'Landscape Architecture Amount';
                    }
                    field("Apply Refund Amount"; Rec."Apply Refund Amount")
                    {
                        AssistEdit = false;
                        Caption = 'Total Refund Amount';
                        DrillDown = false;
                        Lookup = false;
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                    field(Reason; Rec.Reason)
                    {
                    }
                    field("Refund Starting Date"; Rec."Refund Starting Date")
                    {
                        Importance = Additional;
                    }
                }
                group("Refund Card")
                {
                    Caption = 'Refund Card';
                    field("Payment Card Infor."; Rec."Payment Card Infor.")
                    {
                        MultiLine = true;
                    }
                    field("Cancel Pay. Card Amount"; Rec."Cancel Pay. Card Amount")
                    {
                    }
                }
                group("Refund Bank")
                {
                    Caption = 'Refund Bank';
                    field("Bank Code"; Rec."Bank Code")
                    {
                        Importance = Additional;
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                    }
                    field("Bank Account No."; Rec."Bank Account No.")
                    {
                    }
                    field("Account Holder"; Rec."Account Holder")
                    {
                    }
                    field("Bank Request Amount"; Rec."Bank Request Amount")
                    {
                    }
                }
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                field("Contract Status"; Rec."Contract Status")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control46; "DK_Request Doc. Rec. Factbox")
            {
                SubPageLink = "Table ID" = CONST(50089),
                              "Source No." = FIELD("Document No.");
            }
            part(Control15; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculation Refund Amount")
            {
                Caption = 'Calculation Refund Amount';
                Image = CalculateRegenerativePlan;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _RevContractMgt: Codeunit "DK_Revocation Contract Mgt.";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    Clear(_RevContractMgt);

                    _RevContractMgt.CalcRefundAmount(Rec);

                    Rec."Run Refund Calculation" := true;

                    Message(MSG001, Rec.FieldCaption("System Refund Amount"));
                end;
            }
            action("Contract refund Reference Table List")
            {
                Caption = 'Contract refund Reference Table List';
                Image = SuggestTables;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Cont. Ref. Ref. Table List";

                trigger OnAction()
                var
                    _ContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail";
                begin
                end;
            }
            action("Contract Amount Ledger")
            {
                Caption = 'Contract Amount Ledger';
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Contract Amount Ledger";
                // RunPageLink = "Contract No." = FIELD("Contract No.");////zzz
            }
            action("Admin. Expense Ledger")
            {
                Caption = 'Admin. Expense Ledger';
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Admin. Expense Ledger";
                // RunPageLink = "Contract No." = FIELD("Contract No.");;////zzz
            }
            group(Action27)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        if rec."Revocation Employee Name" = '' then
                            Error(MSG006, rec.FieldCaption("Revocation Employee Name"));

                        if not rec."Run Refund Calculation" then
                            Error(MSG007);

                        rec.SetReleased;
                    end;
                }
                action(Complate)
                {
                    Caption = 'Complate';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _UserSetup: Record "User Setup";
                    begin
                        if (Rec."Apply Refund Amount" <> 0) and (Rec."Payment Completion Date" = 0D) then
                            Error(MSG002);

                        if Rec."Revocation Employee Name" = '' then
                            Error(MSG006, Rec.FieldCaption("Revocation Employee Name"));

                        if not Rec."Run Refund Calculation" then
                            Error(MSG007);

                        // >> #2517
                        _UserSetup.Reset;
                        _UserSetup.SetRange("User ID", UserId);
                        _UserSetup.SetRange("DK_Cancel Pay. Rece. Admin.", false);
                        if _UserSetup.FindSet then
                            Error(MSG008);
                        // <<

                        Rec.SetComplete;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.SetReOpen;
                    end;
                }
                action(Request)
                {
                    Caption = 'Request';
                    Image = PaymentJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Rec."Revocation Employee Name" = '' then
                            Error(MSG006, Rec.FieldCaption("Revocation Employee Name"));

                        if not Rec."Run Refund Calculation" then
                            Error(MSG007);

                        if Rec."Payment Completion Date" <> 0D then
                            Error(MSG003, Rec.FieldCaption("Payment Completion Date"), Rec."Payment Completion Date");

                        if (Rec."Apply Refund Amount" = 0) then begin
                            // IF CONFIRM(MSG004, TRUE,FIELDCAPTION("Apply Refund Amount")) THEN
                            //    SetComplete;
                            // DK21.4 #2561
                            Message(MSG009);
                            exit;
                        end;

                        if Rec."Bank Request Amount" <> 0 then begin
                            if Rec."Bank Code" = '' then Error(MSG006, Rec.FieldCaption("Bank Code"));
                            if Rec."Bank Name" = '' then Error(MSG006, Rec.FieldCaption("Bank Name"));
                            if Rec."Bank Account No." = '' then Error(MSG006, Rec.FieldCaption("Bank Account No."));
                            if Rec."Account Holder" = '' then Error(MSG006, Rec.FieldCaption("Account Holder"));
                        end;

                        if Rec."Cancel Pay. Card Amount" <> 0 then begin
                            if Rec."Payment Card Infor." = '' then Error(MSG006, Rec.FieldCaption("Payment Card Infor."));
                        end;

                        Rec.SetRequest;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WorkContents := Rec.GetWorkContents;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Date" := WorkDate;
    end;

    var
        WorkContents: Text;
        MSG001: Label 'Calculation is complete.';
        MSG002: Label 'There is a refund. You need to proceed with the request.';
        MSG003: Label '%1 exists. %1:%2';
        MSG004: Label 'The %1 is (0). Do you want to Complate?';
        MSG005: Label 'You can only Rec. Modify if the %1 is %2 or %3.';
        MSG006: Label 'Please specify %1';
        MSG007: Label 'Run a refund calculation to see the refund amount.';
        MSG008: Label 'You are not authorized. Please contact your administrator.';
        MSG009: Label 'If the remittance amount is 0 won, the remittance request cannot be made.';
}

