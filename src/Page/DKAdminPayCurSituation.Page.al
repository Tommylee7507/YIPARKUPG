page 50231 "DK_Admin. Pay. Cur. Situation"
{
    Caption = 'Admin Payment Current Situation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group("Payment Date")
            {
                Caption = 'Payment Date';
                field(PaymentStartDate; PaymentStartDate)
                {
                    Caption = 'Payment Start Date';

                    trigger OnValidate()
                    begin
                        PaymentStartDate_Onvalidate;
                    end;
                }
                field(PaymentEndDate; PaymentEndDate)
                {
                    Caption = 'Payment End Date';

                    trigger OnValidate()
                    begin
                        PaymentEndDate_Onvalidate;
                    end;
                }
                group(Control23)
                {
                    ShowCaption = false;
                    field(DateOption; DateOption)
                    {
                        Caption = 'Admin Option';
                        OptionCaption = 'All,General,Landscape';
                    }
                    field(ReferenceYear; ReferenceYear)
                    {
                        Caption = 'Reference Year';
                        MaxValue = 2999;
                        MinValue = 1999;
                    }
                }
            }
            group("Posting Date")
            {
                Caption = 'Posting Date';
                field(PostingStartDate; PostingStartDate)
                {
                    Caption = 'Start Date';

                    trigger OnValidate()
                    begin
                        PostingStartDate_Onvalidate;
                    end;
                }
                field(PostingEndDate; PostingEndDate)
                {
                    Caption = 'End Date';

                    trigger OnValidate()
                    begin
                        PostingEndDate_Onvlidate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("SHORT TEXT3"; Rec."SHORT TEXT3")
                {
                    Caption = 'Type';
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Cemetery No.';
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Name';
                }
                field("SHORT TEXT2"; Rec."SHORT TEXT2")
                {
                    Caption = 'Corpse';
                }
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Contract Date';
                }
                field(DATE4; Rec.DATE4)
                {
                    Caption = 'Posting Date';
                }
                field(DATE1; Rec.DATE1)
                {
                    Caption = 'Payment Date';
                }
                field(DATE2; Rec.DATE2)
                {
                    Caption = 'General Start Date';
                }
                field(DATE3; Rec.DATE3)
                {
                    Caption = 'General Expairation Date';
                }
                field(INTEGER0; Rec.INTEGER0)
                {
                    Caption = 'General Term';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Size';
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    Caption = 'Payment Amount';
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Remarks';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Inquiry)
            {
                Caption = 'Inquiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SetFilterDelete;
                    DataInquiry;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetData;
    end;

    var
        PaymentStartDate: Date;
        PaymentEndDate: Date;
        ReferenceYear: Integer;
        DateOption: Option All,General,Landscape;
        Window: Dialog;
        MSG100: Label 'Processing ReceiptDocument   #1############\';
        MSG101: Label 'Processing  #2##########\';
        PostingStartDate: Date;
        PostingEndDate: Date;
        MSG001: Label '“ÁŸÀí ‘Ž‡ßŸÀŠˆ„¾ •¼ Œ÷ Ž°„Ÿ„¾.';

    local procedure SetData()
    begin
        Clear(PaymentStartDate);
        Clear(PaymentEndDate);
        Clear(ReferenceYear);
        Clear(DateOption);

        PaymentEndDate := WorkDate;
        PaymentStartDate := CalcDate('<-CM>', PaymentEndDate);
        PostingStartDate := 0D;
        PostingEndDate := 0D;
        ReferenceYear := Date2DMY(WorkDate, 3);
        DateOption := DateOption::All;
    end;


    procedure SetFilterDelete()
    begin
        Rec.Reset;
        Rec.DeleteAll;
    end;


    procedure DataInquiry()
    var
        _EntryNo: Integer;
        _Contract: Record DK_Contract;
        _Corpse: Record DK_Corpse;
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _MaxLoop: Integer;
        _MainLoop: Integer;
    begin
        SetFilterDelete;

        if GuiAllowed then
            Window.Open(
              MSG100 +
              MSG101);

        _PaymentReceiptDocLine.Reset;
        _PaymentReceiptDocLine.CalcFields("Posting Date");
        _PaymentReceiptDocLine.SetRange(Posted, true);
        _PaymentReceiptDocLine.SetRange("Document Type", _PaymentReceiptDocLine."Document Type"::Receipt);

        if (PaymentStartDate <> 0D) and
          (PaymentEndDate <> 0D) then
            _PaymentReceiptDocLine.SetRange("Payment Date", PaymentStartDate, PaymentEndDate);

        if (PostingStartDate <> 0D) and
          (PostingEndDate <> 0D) then
            _PaymentReceiptDocLine.SetRange("Posting Date", PostingStartDate, PostingEndDate);

        case DateOption of
            DateOption::All:
                _PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PaymentReceiptDocLine."Payment Target"::General,
                                                  _PaymentReceiptDocLine."Payment Target");
            DateOption::General:
                _PaymentReceiptDocLine.SetRange("Payment Target", _PaymentReceiptDocLine."Payment Target"::General);
            DateOption::Landscape:
                _PaymentReceiptDocLine.SetRange("Payment Target", _PaymentReceiptDocLine."Payment Target"::Landscape);
        end;

        if ReferenceYear <> 0 then
            _PaymentReceiptDocLine.SetFilter("Start Date", '>=%1', DMY2Date(1, 1, ReferenceYear));

        if _PaymentReceiptDocLine.FindSet then begin
            _MaxLoop := _PaymentReceiptDocLine.Count;

            repeat
                _PaymentReceiptDocLine.CalcFields("Document Type", "Payment Date", "Contract No.", "Posting Date");
                _MainLoop += 1;
                _EntryNo += 1;
                if GuiAllowed then begin
                    Window.Update(1, StrSubstNo('%1 / %2', _MainLoop, _MaxLoop));
                    Window.Update(2, _PaymentReceiptDocLine."Contract No.");
                end;
                Rec.Init;
                Rec."USER ID" := UserId;
                Rec."OBJECT ID" := PAGE::"DK_Admin. Pay. Cur. Situation";
                Rec."Entry No." := _EntryNo;

                if _Contract.Get(_PaymentReceiptDocLine."Contract No.") then begin
                    _Contract.CalcFields("Cemetery Size");
                    Rec."SHORT TEXT0" := _Contract."Cemetery No.";
                    Rec."SHORT TEXT1" := _Contract."Main Customer Name";
                    Rec.DATE0 := _Contract."Contract Date";
                    Rec.DECIMAL0 := _Contract."Cemetery Size";
                end;

                _Corpse.Reset;
                _Corpse.SetRange("Contract No.", _PaymentReceiptDocLine."Contract No.");
                _Corpse.SetRange("Move The Grave Type", false);
                if _Corpse.FindFirst then
                    Rec."SHORT TEXT2" := _Corpse.Name;

                Rec.DATE1 := _PaymentReceiptDocLine."Payment Date";
                Rec."SHORT TEXT3" := Format(_PaymentReceiptDocLine."Payment Target");
                Rec.DATE2 := _PaymentReceiptDocLine."Start Date";
                Rec.DATE3 := _PaymentReceiptDocLine."Expiration Date";
                Rec.DATE4 := _PaymentReceiptDocLine."Posting Date";
                Rec.INTEGER0 := _RevocationContractMgt.CalcContractPreiodMonth(_PaymentReceiptDocLine."Start Date", _PaymentReceiptDocLine."Expiration Date");
                Rec.DECIMAL2 := _PaymentReceiptDocLine.Amount;
                Rec.TEXT0 := _PaymentReceiptDocLine.Remark;
                Rec.Insert;
                ;
            until _PaymentReceiptDocLine.Next = 0;
        end;

        if GuiAllowed then
            Window.Close;

        if Rec."Entry No." <> 0 then begin
            Rec.SetCurrentKey(DATE1);
            Rec.Ascending(true);
            Rec.FindFirst;
        end;
    end;

    local procedure PostingStartDate_Onvalidate()
    begin
        if PostingEndDate <> 0D then begin
            if PostingEndDate < PostingStartDate then
                Error(MSG001);
        end;

        SetFilterDelete;
    end;

    local procedure PostingEndDate_Onvlidate()
    begin
        if PostingStartDate <> 0D then begin
            if PostingEndDate < PostingStartDate then
                Error(MSG001);
        end;

        SetFilterDelete;
    end;

    local procedure PaymentStartDate_Onvalidate()
    begin
        if PaymentEndDate <> 0D then begin
            if PaymentEndDate < PaymentStartDate then
                Error(MSG001);
        end;

        SetFilterDelete;
    end;

    local procedure PaymentEndDate_Onvalidate()
    begin
        if PaymentStartDate <> 0D then begin
            if PaymentEndDate < PaymentStartDate then
                Error(MSG001);
        end;

        SetFilterDelete;
    end;
}

