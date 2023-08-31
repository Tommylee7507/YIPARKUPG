page 50302 "DK_Calc. Delay Int. Amount"
{
    // 
    // DK34: 20201116
    //   - Create

    Caption = 'Calc. Delay Interest Amount';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Contract;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control3)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                    }
                    field("Cemetery No."; Rec."Cemetery No.")
                    {
                    }
                    field("General Expiration Date"; Rec."General Expiration Date")
                    {
                        Editable = false;
                    }
                    field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
                    {
                        Editable = false;
                    }
                }
                group(Control8)
                {
                    ShowCaption = false;
                    field(cAdminExpenseType; AdminExpenseType)
                    {
                        Caption = 'Admin Expense Tyep';
                        OptionCaption = 'General,Landscape';

                        trigger OnValidate()
                        begin
                            Clear(ResultAmount);

                            if AdminExpenseType = AdminExpenseType::Landscape then begin
                                Rec.CalcFields("Landscape Architecture");
                                if not Rec."Landscape Architecture" then
                                    Error(MSG002);
                            end;
                        end;
                    }
                    field(cInputDate; InputDate)
                    {
                        Caption = 'Input Date';

                        trigger OnValidate()
                        begin
                            if InputDate <> 0D then begin
                                if InputDate > Today then
                                    Error(MSG001);

                                CalcDelayIntAmount;
                            end else begin
                                ResultAmount := 0;
                            end;
                        end;
                    }
                    field(cResultAmount; ResultAmount)
                    {
                        Caption = 'Result Amount';
                        Editable = false;
                    }
                }
            }
            group(Control11)
            {
                Editable = false;
                ShowCaption = false;
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                }
                field("Landscape Architecture"; Rec."Landscape Architecture")
                {
                }
                field("Admin. Expense Method"; Rec."Admin. Expense Method")
                {
                }
                field("Admin. Exp. Start Date"; Rec."Admin. Exp. Start Date")
                {
                }
                field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
                {
                }
                field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Calculation)
            {
                Caption = 'Calculation';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    CalcDelayIntAmount;
                end;
            }
            action("Detail Delay Int. Amount Print")
            {
                Caption = 'Detail Delay Int. Amount Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _CalcDelayIntDetail: Report "DK_Calc. Delay Int. Detail";
                begin

                    if InputDate = 0D then
                        Error(MSG004);

                    Clear(_CalcDelayIntDetail);
                    _CalcDelayIntDetail.SetParameter(Rec."No.", InputDate, AdminExpenseType);
                    _CalcDelayIntDetail.RunModal;
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        SetPayDocDelayAmout;
    end;

    var
        InputDate: Date;
        ResultAmount: Decimal;
        PayDocNo: Code[20];
        MSG001: Label 'You cannot enter a date larger than today.';
        AdminExpenseType: Option General,Landscape;
        MSG002: Label 'Can not be selected.';
        MSG003: Label 'Admin. Expense cannot be calculated!';
        MSG004: Label 'Please specify a date.';


    procedure SetParameter(pPaymentDate: Date; pPayDocNo: Code[20])
    begin

        if pPaymentDate <> 0D then
            InputDate := pPaymentDate
        else
            InputDate := Today;

        PayDocNo := pPayDocNo;
    end;

    local procedure CalcDelayIntAmount()
    var
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _DelayInterestAmt: Decimal;
    begin
        Clear(ResultAmount);

        if (Rec."General Expiration Date" = 0D) and (Rec."Land. Arc. Expiration Date" = 0D) then
            Error(MSG003);

        if InputDate <> 0D then
            case AdminExpenseType of
                // Ÿ‰¦ ýˆ«Š±
                AdminExpenseType::General:
                    begin
                        if (Rec."General Expiration Date" < InputDate) and
                          (Rec."General Expiration Date" <> 0D) then
                            _DelayInterestAmt := _AdminExpenseMgt.CalcDelayInterestAmount(Rec, InputDate, 0);
                    end;
                // ‘†µ ýˆ«Š±
                AdminExpenseType::Landscape:
                    begin
                        if (Rec."Land. Arc. Expiration Date" < InputDate) and
                          (Rec."Land. Arc. Expiration Date" <> 0D) then
                            _DelayInterestAmt := _AdminExpenseMgt.CalcDelayInterestAmount(Rec, InputDate, 1);
                    end;
            end
        else
            _DelayInterestAmt := 0;

        ResultAmount := _DelayInterestAmt;

        CurrPage.Update;
    end;

    local procedure SetPayDocDelayAmout()
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    begin

        if (PayDocNo <> '') and (ResultAmount <> 0) then begin
            _PaymentReceiptDocument.Reset;
            _PaymentReceiptDocument.SetRange("Document No.", PayDocNo);
            if _PaymentReceiptDocument.FindSet then begin
                _PaymentReceiptDocument.Validate("Delay Interest Amount", ResultAmount);
                _PaymentReceiptDocument.Modify(true);
            end;
        end;
    end;
}

