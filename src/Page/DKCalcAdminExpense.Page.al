page 50225 "DK_Calc. Admin. Expense"
{
    // *DK32 :20207015
    //   - Rec. Modify Function : CalcAdminExpense
    //                       OnAfterGetRecord
    //   - Add C/AL Globals(Text Contects) : MSG008
    //   - Add C/AL Globals(Variable) : GeneralExpirationDate,
    //                                  LandArcExpirationDate
    //   - Add Field : "Landscape Architecture"
    //                 "Admin. Expense Method"
    //                 "admin. Exp. Start Date"

    Caption = 'Calc. Admin. Expense';
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
                group(Control26)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                    }
                    field("Cemetery No."; Rec."Cemetery No.")
                    {
                    }
                    field(GeneralExpirationDate; GeneralExpirationDate)
                    {
                        Caption = 'General Expiration Date';
                        Editable = false;
                    }
                    field(LandArcExpirationDate; LandArcExpirationDate)
                    {
                        Caption = 'Land. Arc. Expiration Date';
                        Editable = false;
                    }
                }
                group(Control25)
                {
                    ShowCaption = false;
                    field(BaseDate; BaseDate)
                    {
                        Caption = 'Base Date';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                        Visible = ShowBaseDate;
                    }
                    field(AdminExpenseType; AdminExpenseType)
                    {
                        Caption = 'Admin. Expense Type';
                        OptionCaption = 'General,Landscape Architecture';

                        trigger OnValidate()
                        begin
                            Clear(ResultAmount);
                            Clear(ResultDate);
                            Clear(ResultApplyAmount);
                            Clear(ResultDiffAmount);

                            if AdminExpenseType = AdminExpenseType::Landscape then begin
                                Rec.CalcFields("Landscape Architecture");
                                if not Rec."Landscape Architecture" then
                                    Error(MSG003);
                            end;
                        end;
                    }
                    field(CalcType; CalcType)
                    {
                        Caption = 'Calculation Type';
                        OptionCaption = 'Date,Amount';

                        trigger OnValidate()
                        begin
                            Clear(InputAmount);
                            Clear(InputDate);
                            Clear(ResultAmount);
                            Clear(ResultDate);
                            Clear(ResultApplyAmount);
                            Clear(ResultDiffAmount);

                            CalcTypeGroup := CalcType = CalcType::Amount;
                        end;
                    }
                    group(Control17)
                    {
                        Enabled = NOT CalcTypeGroup;
                        ShowCaption = false;
                        Visible = NOT CalcTypeGroup;
                        field(InputDate; InputDate)
                        {
                            Caption = 'Input Date';

                            trigger OnValidate()
                            begin
                                if InputDate <> 0D then begin
                                    if AdminExpenseType = AdminExpenseType::General then begin
                                        if GeneralExpirationDate >= InputDate then
                                            Error(MSG004, Rec.FieldCaption("General Expiration Date"), Rec."General Expiration Date");
                                    end else begin
                                        if LandArcExpirationDate >= InputDate then
                                            Error(MSG004, Rec.FieldCaption("Land. Arc. Expiration Date"), Rec."Land. Arc. Expiration Date");
                                    end;

                                    CalcAdminExpense;
                                end else begin
                                    ResultAmount := 0;
                                end;
                            end;
                        }
                        field(ResultAmount; ResultAmount)
                        {
                            Caption = 'Result Amount';
                            Editable = false;
                        }
                    }
                    group(Control16)
                    {
                        Enabled = CalcTypeGroup;
                        ShowCaption = false;
                        Visible = CalcTypeGroup;
                        field(InputAmount; InputAmount)
                        {
                            Caption = 'Input Amount';
                            MinValue = 0;

                            trigger OnValidate()
                            begin
                                if InputAmount <> 0 then begin
                                    CalcAdminExpense;
                                end else begin
                                    ResultDate := 0D;
                                    ResultApplyAmount := 0;
                                    ResultDiffAmount := 0;
                                end;
                            end;
                        }
                        field(ResultDate; ResultDate)
                        {
                            Caption = 'Result Date';
                            Editable = false;
                        }
                        field(ResultApplyAmount; ResultApplyAmount)
                        {
                            AutoFormatType = 1;
                            Caption = 'Applied Amount';
                            Editable = false;
                        }
                        field(ResultDiffAmount; ResultDiffAmount)
                        {
                            AutoFormatType = 1;
                            Caption = 'Remaining Amount';
                            Editable = false;
                            Style = Attention;
                            StyleExpr = TRUE;
                        }
                    }
                }
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                Editable = false;
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Landscape Architecture"; Rec."Landscape Architecture")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Admin. Expense Method"; Rec."Admin. Expense Method")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
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
                    //Calc
                    CalcAdminExpense;
                    //MESSAGE(MSG002);
                end;
            }
            action("Detail Admin. Expense Print")
            {
                Caption = 'Detail Admin. Expense Print';
                Enabled = CalcType = CalcType::Date;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = CalcType = CalcType::Date;

                trigger OnAction()
                var
                    _CalcAdminExpeDetail: Report "DK_Calc. Admin. Expense Detail";
                    _PrintDate: Date;
                begin

                    if CalcType = CalcType::Date then begin
                        if InputDate = 0D then
                            Error(MSG005);

                        _PrintDate := InputDate;
                    end else begin
                        if ResultDate = 0D then
                            Error(MSG006);

                        _PrintDate := ResultDate;
                    end;

                    Clear(_CalcAdminExpeDetail);
                    _CalcAdminExpeDetail.SetParameter(Rec."No.", _PrintDate, AdminExpenseType);
                    //_CalcAdminExpeDetail.USEREQUESTPAGE(FALSE);
                    _CalcAdminExpeDetail.RunModal;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>>DK32
        if Rec."General Expiration Date" = 0D then begin
            if Rec."Admin. Exp. Start Date" <> 0D then
                GeneralExpirationDate := Rec."Admin. Exp. Start Date" - 1;
        end else
            GeneralExpirationDate := Rec."General Expiration Date";

        Rec.CalcFields("Landscape Architecture");
        if Rec."Landscape Architecture" then begin
            if Rec."Land. Arc. Expiration Date" = 0D then begin
                if Rec."Admin. Exp. Start Date" <> 0D then
                    LandArcExpirationDate := Rec."Admin. Exp. Start Date" - 1;
            end else
                LandArcExpirationDate := Rec."Land. Arc. Expiration Date";
        end;
        //<<DK32
    end;

    trigger OnInit()
    begin
        BaseDate := Today;
    end;

    var
        InputAmount: Decimal;
        InputDate: Date;
        ResultAmount: Decimal;
        ResultDate: Date;
        ResultApplyAmount: Decimal;
        ResultDiffAmount: Decimal;
        CalcType: Option Date,Amount;
        AdminExpenseType: Option General,Landscape;
        MSG001: Label 'No contract information found.';
        MSG002: Label 'Calculation is complete.';
        CalcTypeGroup: Boolean;
        MSG003: Label 'Can not be selected.';
        MSG004: Label 'You can not have a date that is less than or equal to the current %1. %1:%2';
        MSG005: Label 'Please specify a date.';
        MSG006: Label 'The Result Date does not exist.';
        MSG007: Label 'Do you really want to calculate?';
        BaseDate: Date;
        ShowBaseDate: Boolean;
        MSG008: Label 'Admin. Expense cannot be calculated!';
        GeneralExpirationDate: Date;
        LandArcExpirationDate: Date;

    local procedure CalcAdminExpense()
    var
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _StartDate: Date;
    begin
        Clear(ResultApplyAmount);
        Clear(ResultDiffAmount);
        Clear(ResultDate);
        Clear(ResultAmount);
        Clear(_StartDate);//DK32

        //>>DK32
        if (GeneralExpirationDate = 0D) and (LandArcExpirationDate = 0D) then
            Error(MSG008);

        if AdminExpenseType = AdminExpenseType::General then
            _StartDate := GeneralExpirationDate + 1
        else
            _StartDate := LandArcExpirationDate + 1;

        //<<DK32
        if CalcType = CalcType::Date then begin
            if InputDate <> 0D then
                if InputDate > CalcDate('<+30Y>', Today) then
                    if not Confirm(MSG007, false, InputDate) then
                        exit;

            //ResultAmount := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate("No.", AdminExpenseType, InputDate,BaseDate,FALSE);  //DK32
            ResultAmount := _AdminExpenseMgt.GetCalcAdminExpenseAmountForPeriod(Rec."No.", AdminExpenseType, _StartDate, InputDate);  //DK32
        end else begin

            if InputAmount <> 0 then
                ResultDate := _AdminExpenseMgt.GetCalcAdminExpenseEndingDateForAmount(Rec."No.", AdminExpenseType, InputAmount, ResultApplyAmount, ResultDiffAmount, BaseDate, false);

        end;

        CurrPage.Update;
    end;


    procedure SetParameter(pPaymentDate: Date)
    begin

        if pPaymentDate <> 0D then begin
            BaseDate := pPaymentDate;
            ShowBaseDate := true;
        end;
    end;
}

