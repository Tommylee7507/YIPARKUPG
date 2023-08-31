page 50134 "DK_Payment Rec. Doc. Line"
{
    // 
    // #2220 : 20201021
    //   - Rec. Modify Trigger: OnModifyRecord() : Boolean

    AutoSplitKey = true;
    Caption = 'Payment Rec. Doc. Line';
    DelayedInsert = true;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "DK_Payment Receipt Doc. Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Target"; Rec."Payment Target")
                {

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field("Cem. Services No."; Rec."Cem. Services No.")
                {

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    MinValue = 0;

                    trigger OnValidate()
                    begin
                        if xRec.Amount <> Rec.Amount then begin
                            CheckCreateAuto;

                            if Rec."Payment Target" in [Rec."Payment Target"::General, Rec."Payment Target"::Landscape] then begin
                                if xRec.Amount <> 0 then
                                    Message(MSG005, Format(Rec."Payment Target"));
                            end;
                            UpdateAmount;
                        end;
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Expiration Date" <> Rec."Expiration Date" then begin
                            if Rec.Posted then
                                Error(MSG001);

                            if Rec."Expiration Date" <> 0D then begin
                                Rec.CalcFields("Contract No.");
                                if not (Rec."Payment Target" in [Rec."Payment Target"::General, Rec."Payment Target"::Landscape]) then
                                    Error(MSG002, Rec.FieldCaption("Payment Target"), Rec.FieldCaption("Expiration Date"));

                                if Rec."Start Date" = 0D then
                                    Error(MSG003, Format(Rec."Payment Target"), (Rec."Contract No."));

                                if Rec."Start Date" > Rec."Expiration Date" then
                                    Error(MSG004, Format(Rec."Payment Target"));

                                if (Rec."Befor Expiration Date" > Rec."Expiration Date") and (Rec."Befor Expiration Date" <> 0D) then
                                    Error(MSG006, Rec."Befor Expiration Date");
                            end;

                            SetDiffAmountColor;
                        end;
                    end;
                }
                field("Period Amount"; Rec."Period Amount")
                {
                    BlankZero = true;
                    Style = StandardAccent;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field("Diff. Amount"; Rec."Diff. Amount")
                {
                    BlankZero = true;
                    StyleExpr = DiffAmount_ColorStyle;

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
                field(Remark; Rec.Remark)
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CheckCreateAuto;
                    end;
                }
            }
            group(Control10)
            {
                ShowCaption = false;
                fixed(Control9)
                {
                    ShowCaption = false;
                    group("Payment Amount")
                    {
                        Caption = 'Payment Amount';
                        field(PaymentAmt; PaymentAmt)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                CheckCreateAuto;
                            end;
                        }
                    }
                    group("Total Line Amount")
                    {
                        Caption = 'Total Line Amount';
                        field("TotalLineAmt + Amount - xRec.Amount"; TotalLineAmt + Rec.Amount - xRec.Amount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                CheckCreateAuto;
                            end;
                        }
                    }
                    group("Available Amount")
                    {
                        Caption = 'Available Amount';
                        field("PaymentAmt - (TotalLineAmt + Amount - xRec.Amount)"; PaymentAmt - (TotalLineAmt + Rec.Amount - xRec.Amount))
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                CheckCreateAuto;
                            end;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateAmount;
        SetDiffAmountColor;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CheckCreateAuto;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CheckHeader;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.CheckHeader;
    end;

    var
        PaymentAmt: Decimal;
        TotalLineAmt: Decimal;
        PayReceDoc: Record "DK_Payment Receipt Document";
        MSG001: Label 'You cannot change the value.';
        MSG002: Label 'You cannot change the value.';
        MSG003: Label '%1 Start Date  does not exist. Please check the contract information. Contract No:%2';
        MSG004: Label '%1 End date cannot be earlier than Start date.';
        MSG005: Label 'The %1 end date has been recalculated.';
        DiffAmount_ColorStyle: Text[15];
        MSG006: Label 'You cannot change the date before %1.';
        MSG007: Label 'This Document is related to a Payment Expect, so it cannot be Rec. Modify or delete. %1:%2';

    local procedure UpdateAmount()
    var
        _PayReceDoc: Record "DK_Payment Receipt Document";
    begin
        _PayReceDoc.Reset;
        _PayReceDoc.SetRange("Document Type", _PayReceDoc."Document Type"::Receipt);
        _PayReceDoc.SetRange("Document No.", Rec."Document No.");
        if _PayReceDoc.FindSet then
            PaymentAmt := _PayReceDoc."Final Amount"
        else
            PaymentAmt := 0;

        Rec.CalcTotalAmount(Rec, xRec, TotalLineAmt);
    end;

    local procedure SetDiffAmountColor()
    begin
        if Rec."Diff. Amount" < 0 then
            DiffAmount_ColorStyle := 'Attention'
        else
            DiffAmount_ColorStyle := '';
    end;

    local procedure CheckCreateAuto()
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _UserSetup: Record "User Setup";
    begin
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Cancel Pay. Rece. Admin.", false); //ýˆ«Àí Ž–„©‹Ï†ðŠ ‘ª—©
        if _UserSetup.FindSet then begin
            _PaymentReceiptDocument.Reset;
            _PaymentReceiptDocument.SetRange("Document No.", Rec."Document No.");
            if _PaymentReceiptDocument.FindSet then
                if _PaymentReceiptDocument."Created Auto." then
                    Error(MSG007, _PaymentReceiptDocument.FieldCaption("Pay. Expect Doc. No."), _PaymentReceiptDocument."Pay. Expect Doc. No.");
        end;
    end;
}

