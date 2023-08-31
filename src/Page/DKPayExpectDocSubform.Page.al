page 50173 "DK_Pay. Expect Doc. Subform"
{
    AutoSplitKey = true;
    Caption = 'Payment Expect Docment Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "DK_Pay. Expect Doc. Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Target"; Rec."Payment Target")
                {

                    trigger OnValidate()
                    var
                        _PayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
                    begin

                        if Rec."Payment Target" <> xRec."Payment Target" then begin
                            _PayExpectDocLine.Reset;
                            _PayExpectDocLine.SetRange("Document No.", Rec."Document No.");
                            if _PayExpectDocLine.FindSet then begin
                                repeat
                                    if _PayExpectDocLine."Payment Target" = Rec."Payment Target" then
                                        Error(MSG008, Rec.FieldCaption("Payment Target"));
                                until _PayExpectDocLine.Next = 0;
                            end;
                        end;
                    end;
                }
                field("Cem. Services No."; Rec."Cem. Services No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Expiration Date"; Rec."Expiration Date")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Expiration Date" <> Rec."Expiration Date" then begin
                            //  IF "Pay. THEN
                            //    ERROR(MSG007);

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
                }
                field("Diff. Amount"; Rec."Diff. Amount")
                {
                    BlankZero = true;
                    StyleExpr = DiffAmount_ColorStyle;
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
            }
            group(Control12)
            {
                ShowCaption = false;
                fixed(Control11)
                {
                    ShowCaption = false;
                    group("Total Line Amount")
                    {
                        Caption = 'Total Line Amount';
                        field("TotalLineAmt + Amount - xRec.Amount"; TotalLineAmt + Rec.Amount - xRec.Amount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                            Style = Standard;
                            StyleExpr = TRUE;
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
        Rec.CalcTotalAmount(Rec, xRec, TotalLineAmt);
        SetDiffAmountColor;
    end;

    var
        TotalLineAmt: Decimal;
        MSG001: Label 'This Line cannot be delete or Rec. Modify.';
        DiffAmount_ColorStyle: Text[15];
        MSG002: Label 'You cannot change the value.';
        MSG003: Label '%1 Start Date  does not exist. Please check the contract information. Contract No:%2';
        MSG004: Label '%1 End date cannot be earlier than Start date.';
        MSG005: Label 'The %1 end date has been recalculated.';
        MSG006: Label 'You cannot change the date before %1.';
        MSG007: Label 'You cannot change the value.';
        MSG008: Label '%1 already entered.';

    local procedure SetDiffAmountColor()
    begin
        if Rec."Diff. Amount" < 0 then
            DiffAmount_ColorStyle := 'Attention'
        else
            DiffAmount_ColorStyle := '';
    end;
}

