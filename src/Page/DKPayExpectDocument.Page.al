page 50172 "DK_Pay. Expect Document"
{
    // *DK32 : 20200715
    //   - Rec. Modify Field : "Payment Date".Edtiable : True -> False
    //                    "UnAssgin Date".Edtiable : True -> False

    Caption = 'Payment Expect Document';
    PageType = Document;
    SourceTable = "DK_Pay. Expect Doc. Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        _PayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
                    begin
                        _PayExpectDocLine.Reset;
                        _PayExpectDocLine.SetRange("Document No.", Rec."Document No.");
                        if _PayExpectDocLine.FindSet then begin
                            if not Confirm(MSG010, false) then begin
                                Rec."Contract No." := xRec."Contract No.";
                                exit;
                            end;

                            _PayExpectDocLine.DeleteAll;
                            CurrPage.Update;
                        end;
                    end;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    Editable = false;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    Enabled = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        if xRec."Payment Type" <> Rec."Payment Type" then begin
                            if Rec."Payment Type" = Rec."Payment Type"::DirectPG then
                                Error(MSG002, Rec."Payment Type"::DirectPG);
                        end;
                    end;
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ShowMandatory = true;
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ShowMandatory = true;
                }
                group(Control10)
                {
                    Enabled = Rec."Payment Type" = Rec."Payment Type"::VA;
                    ShowCaption = false;
                    Visible = Rec."Payment Type" = Rec."Payment Type"::VA;
                    field("VA Process Status"; Rec."VA Process Status")
                    {
                        Editable = false;
                    }
                    field("Virtual Account No."; Rec."Virtual Account No.")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Editable = false;
                        Lookup = false;
                    }
                    field("Bank Code"; Rec."Bank Code")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Importance = Additional;
                        Lookup = false;
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Account Holder"; Rec."Account Holder")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                }
                group(Control29)
                {
                    Enabled = Rec."Payment Type" = Rec."Payment Type"::PG;
                    ShowCaption = false;
                    Visible = Rec."Payment Type" = Rec."Payment Type"::PG;
                    field("PG URL"; Rec."PG URL")
                    {
                        MultiLine = true;
                    }
                }
                group(Control45)
                {
                    ShowCaption = false;
                    field("Expiration Date"; Rec."Expiration Date")
                    {
                        Editable = Rec.Status = Rec.Status::Open;
                        Enabled = Rec.Status = Rec.Status::Open;
                        ShowMandatory = true;
                    }
                    field("Assgin Date"; Rec."Assgin Date")
                    {
                    }
                    field("Last SMS Sent Date"; Rec."Last SMS Sent Date")
                    {
                    }
                    field("UnAssgin Date"; Rec."UnAssgin Date")
                    {
                        Editable = false;
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                        Editable = false;
                    }
                    field("Employee No."; Rec."Employee No.")
                    {
                        Importance = Additional;
                        ShowMandatory = true;
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                        ShowMandatory = true;
                    }
                    field(Status; Rec.Status)
                    {
                    }
                    field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                    {
                    }
                    group(Control58)
                    {
                        Enabled = Rec."Payment Type" = Rec."Payment Type"::VA;
                        ShowCaption = false;
                        Visible = false;
                        field("Issued Cash Receipts"; Rec."Issued Cash Receipts")
                        {
                        }
                        field("Issued Cash Rec. Mobile"; Rec."Issued Cash Rec. Mobile")
                        {
                            Editable = Rec."Issued Cash Receipts";
                            Enabled = Rec."Issued Cash Receipts";
                        }
                        field("Cash Bill Approval No."; Rec."Cash Bill Approval No.")
                        {
                            Editable = Rec."Issued Cash Receipts";
                            Enabled = Rec."Issued Cash Receipts";
                        }
                    }
                }
            }
            part(Line; "DK_Pay. Expect Doc. Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("Document No.");
            }
            group("Payment Receipt")
            {
                Caption = 'Payment Receipt';
                Editable = false;
                field("Pay. Receipt Doc. No."; Rec."Pay. Receipt Doc. No.")
                {
                    Editable = false;
                }
                field("Pay. Receipt Doc. Posted"; Rec."Pay. Receipt Doc. Posted")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("PG Approval No."; Rec."PG Approval No.")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Importance = Additional;
                }
                field("Payment Method Name"; Rec."Payment Method Name")
                {
                }
                field("Payment Remark"; Rec."Payment Remark")
                {
                }
            }
            group(Source)
            {
                Caption = 'Source';
                Editable = false;
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    Editable = false;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
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
            part(Control52; "DK_Pay. Expect Pro. His. Factb")
            {
                SubPageLink = "Pay. Expect Doc. No." = FIELD("Document No.");
            }
            part(Control49; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            part(Control48; "DK_Cem. Services Factbox")
            {
                Provider = Line;
                SubPageLink = "No." = FIELD("Cem. Services No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Assigin Virtual Account")
            {
                Caption = 'Assigin Virtual Account';
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _PaymentExpect: Codeunit "DK_Payment Expect";////zzz
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    if Rec."Payment Type" = Rec."Payment Type"::VA then begin
                        //í‹ÝÐ‘’ —­„Ï
                        if Rec."Virtual Account No." <> '' then
                            Error(MSG009, Rec.FieldCaption("Virtual Account No."), Rec."Virtual Account No.",
                                          Rec.FieldCaption("Expiration Date"), Rec."Expiration Date");

                        //í‹ÝÐ‘’ —­„Ï ‘°—Ê!!!!!!!!!
                        Clear(_PaymentExpect);
                        Rec.Validate("Virtual Account No.", _PaymentExpect.FindAvailableVirtualAccnt);

                        if Rec."Virtual Account No." = '' then
                            Error(MSG006);

                        _PaymentExpect.AssginVirtualAccnt(Rec);

                    end else begin
                        //PG
                        Clear(_PaymentExpect);
                        _PaymentExpect.AssginPG(Rec);
                    end;

                    CurrPage.Update;
                end;
            }
            action(UnAssgin)
            {
                Caption = 'UnAssgin';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _PaymentExpect: Codeunit "DK_Payment Expect"; ////zzz
                begin
                    //—­„Ï —¹‘ª
                    //TESTFIELD(Status,Status::Assgin);
                    if Rec."Assgin Date" = 0D then
                        Error(MSG012);

                    if (Rec."UnAssgin Date" = 0D) and (Rec."Payment Date" = 0D) then begin
                        //TESTFIELD("Virtual Account No.");

                        if not Confirm(MSG005, false) then
                            exit;

                        if Rec."Payment Type" = Rec."Payment Type"::VA then begin
                            Clear(_PaymentExpect);
                            if _PaymentExpect.UnAssginVirtualAccnt(Rec) then
                                Message(MSG001, Rec.FieldCaption("Virtual Account No."));
                        end else begin
                            Rec.Status := Rec.Status::UnAssgin;
                            Rec."UnAssgin Date" := Today;
                            Message(MSG001, Rec.FieldCaption("PG URL"));
                        end;
                    end else
                        Error(MSG004, Rec.FieldCaption("Payment Date"), Rec."Payment Date",
                                      Rec.FieldCaption("UnAssgin Date"), Rec."UnAssgin Date");

                    CurrPage.Update;
                end;
            }
            separator(Action64)
            {
            }
            action("Calculation of Admin. Expense")
            {
                Caption = 'Calculation of Admin. Expense';
                Image = CalculateBalanceAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _CalcAdminExpense: Page "DK_Calc. Admin. Expense"; ////zzz
                    _Contract: Record DK_Contract;
                begin

                    if Rec."Contract No." = '' then
                        Error(MSG003);

                    _Contract.Reset;
                    _Contract.SetRange("No.", Rec."Contract No.");
                    if _Contract.FindSet then begin
                        Clear(_CalcAdminExpense);
                        _CalcAdminExpense.LookupMode(true);
                        _CalcAdminExpense.SetTableView(_Contract);
                        _CalcAdminExpense.SetRecord(_Contract);
                        _CalcAdminExpense.RunModal;
                    end else begin
                        Error(MSG004);
                    end;
                end;
            }
            separator(Action27)
            {
            }
            action("Send SMS")
            {
                Caption = 'Send SMS';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Rec."Payment Type" = Rec."Payment Type"::DirectPG then
                        Error(MSG011, Rec.FieldCaption("Payment Type"), Rec."Payment Type");
                    //SMS ‰ÈŒÁ
                    if not (Rec.Status in [Rec.Status::Assgin, Rec.Status::SendSMS]) then
                        Error(MSG003, Rec.FieldCaption(Status), Rec.Status::Assgin, Rec.Status::SendSMS);

                    PaymentExpect.SMSSending(Rec);
                end;
            }
            action("Sended SMS History")
            {
                Caption = 'Sended SMS History';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                // RunObject = Page "DK_Sended SMS History";////zzz
                //                 RunPageLink = Rec."Source Type"=FILTER(PaymentExpectPG|PaymentExpectVA),
                //               "Source No."=FIELD("Document No.");
            }
            separator(Action44)
            {
            }
            action("Virtual Account Error Log")
            {
                Caption = 'Virtual Account Error Log';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    _VAErrorLog: Page "DK_Virtual Account Error Log"; ////zzz
                begin
                    //í‹ÝÐ‘’ í‡» ‡ž€¸
                    if Rec."Payment Type" <> Rec."Payment Type"::VA then
                        Error(MSG013, Rec."Payment Type", Rec."Payment Type"::VA);

                    if Rec."Virtual Account No." = '' then
                        Error(MSG014, Rec.FieldCaption("Virtual Account No."));

                    if Rec."Assgin Date" = 0D then
                        Error(MSG015, Rec.FieldCaption("Assgin Date"));

                    Clear(_VAErrorLog);
                    // _VAErrorLog.SetParameter(Rec."Assgin Date", Rec."Virtual Account No.");////zzz
                    _VAErrorLog.RunModal;
                end;
            }
            separator(Action56)
            {
            }
            action("PG Payment History")
            {
                Caption = 'PG Payment History';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";
                // RunObject = Page "DK_Receipted PG Document"; ////zzz
                //                 RunPageLink = Rec."Payment Type"=FILTER(PG|DirectPG),
                //               "Pay. Expect Doc No."=FIELD("Document No.");
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
        _ContractNo: Code[20];
        _FunSetup: Record "DK_Function Setup";
    begin
        Rec."Document Date" := Today;
        Rec."Payment Type" := Rec."Payment Type"::PG;

        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));

        _FunSetup.Get;
        Rec."Expiration Date" := CalcDate(_FunSetup."Payment Expect Due Period", Rec."Document Date");

        if Rec.GetFilter("Contract No.") <> '' then begin
            _ContractNo := Rec.GetRangeMin("Contract No.");

            if _ContractNo <> '' then
                Rec.Validate("Contract No.", _ContractNo);
        end;
    end;

    var
        MSG010: Label 'Initialize the line. Do you want to continue?';
        FunSetup: Record "DK_Function Setup";
        MSG001: Label 'The %1 has been deallocated.';
        MSG002: Label '%1 is a non-selectable value.';
        MSG003: Label 'SMS sending is only possible if the %1 is %2 or %3.';
        MSG004: Label 'This document is already excluded from the target. %1:%2,%3:%4';
        MSG005: Label 'Are you sure you don''t want to pay?';
        MSG006: Label 'There is no free virtual account no. available for allocation.';
        MSG008: Label '%1 does not correspond to %2. Current %1:%3';
        MSG009: Label '%1 already exists. %1:%2,%3:%4.';
        PaymentExpect: Codeunit "DK_Payment Expect"; ////zzz
        MSG011: Label 'If %1 is %2, SMS cannot be sent.';
        MSG012: Label 'This Payment Expect document has not yet been assigned.';
        MSG013: Label 'This function is available when %1 is %2.';
        MSG014: Label '%1 does not exist.';
        MSG015: Label 'This Payment Expect Document has not been Assignment a virtual account.';

    local procedure CheckValue()
    begin

        Rec.TestField("Document No.");
        Rec.TestField("Contract No.");
    end;
}

