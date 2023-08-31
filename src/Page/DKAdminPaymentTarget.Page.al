page 50251 "DK_Admin. Payment Target"
{
    Caption = 'Admin Payment Target';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,MultiSelect';
    SourceTable = "DK_Report Buffer";

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(ReferenceDate; ReferenceDate)
                {
                    Caption = 'Reference Date';

                    trigger OnValidate()
                    begin
                        ReferenceDate_Validate;
                    end;
                }
                field(PaymentType; PaymentType)
                {
                    Caption = 'Payment Type';
                    OptionCaption = 'General,Landscape';

                    trigger OnValidate()
                    begin
                        PaymentType_Validate;
                    end;
                }
                field(RatingFilter; RatingFilter)
                {
                    Caption = 'Rating';
                    OptionCaption = 'A,B,C,D,E,F';
                }
                field(PrepaymentNo; PrepaymentNo)
                {
                    Caption = 'PrepaymentNo';
                }
            }
            group("Expiration Date")
            {
                Caption = 'Expiration Date';
                field(ExpirationStartDate; ExpirationStartDate)
                {
                    Caption = 'Expiration Start Date';

                    trigger OnValidate()
                    begin
                        ExpirationStartDate_Validate;
                    end;
                }
                field(ExpirationEndDate; ExpirationEndDate)
                {
                    Caption = 'Expiration End Date';

                    trigger OnValidate()
                    begin
                        ExpirationEndDate_Validate;
                    end;
                }
            }
            repeater(Group)
            {
                field(BOOLEAN0; Rec.BOOLEAN0)
                {
                    Caption = 'Admin Payment target';
                }
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(CODE1; Rec.CODE1)
                {
                    Caption = 'Cemetery Code';
                    Visible = false;
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Cemetery No.';
                    Editable = false;
                }
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Contract Date';
                    Editable = false;
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Main Customer Name';
                    Editable = false;
                }
                field("SHORT TEXT4"; Rec."SHORT TEXT4")
                {
                    Caption = 'Evaluation';
                }
                field(CODE2; Rec.CODE2)
                {
                    Caption = 'Employee Code';
                    Visible = false;
                }
                field(TEXT4; Rec.TEXT4)
                {
                    Caption = 'Employee';
                }
                field("SHORT TEXT2"; Rec."SHORT TEXT2")
                {
                    Caption = 'Customer Post Code';
                    Editable = false;
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Customer Address';
                    Editable = false;
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Address 2';
                    Editable = false;
                }
                field(TEXT2; Rec.TEXT2)
                {
                    Caption = 'Phone No.';
                    Editable = false;
                }
                field(TEXT3; Rec.TEXT3)
                {
                    Caption = 'Mobile No.';
                    Editable = false;
                }
                field("SHORT TEXT3"; Rec."SHORT TEXT3")
                {
                    Caption = 'Corpse Name';
                    Editable = false;
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Cemetery Size';
                    Editable = false;
                }
                field(DATE1; Rec.DATE1)
                {
                    Caption = 'Expiration Date';
                    Editable = false;
                }
                field(DATE2; Rec.DATE2)
                {
                    Caption = 'Litigation Start Date';
                    Editable = false;
                }
                field(DATE3; Rec.DATE3)
                {
                    Caption = 'Litigation End Date';
                    Editable = false;
                }
                field(INTEGER0; Rec.INTEGER0)
                {
                    Caption = 'Litigation Period';
                    Editable = false;
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'Litigation Amount';
                    Editable = false;
                }
                field(DATE4; Rec.DATE4)
                {
                    Caption = 'Advance Start Date';
                    Editable = false;
                }
                field(DATE5; Rec.DATE5)
                {
                    Caption = 'Advance End Date';
                    Editable = false;
                }
                field(INTEGER1; Rec.INTEGER1)
                {
                    Caption = 'Advance Period';
                    Editable = false;
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    Caption = 'Advance Amount';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Contract")
            {
                Caption = 'View Contract';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                    _ContractCard: Page "DK_Contract Card";
                begin

                    _Contract.Reset;
                    _Contract.SetRange("No.", Rec.CODE0);

                    Clear(_ContractCard);
                    _ContractCard.LookupMode(true);
                    _ContractCard.SetTableView(_Contract);
                    _ContractCard.SetRecord(_Contract);
                    _ContractCard.RunModal;
                end;
            }
            action(Inqury)
            {
                Caption = 'Inqury';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SetDelete;
                    DataInquiry;
                end;
            }
            separator(Action34)
            {
            }
            action(Selection)
            {
                Caption = 'Selection';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                begin

                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet then begin
                        Rec.ModifyAll(BOOLEAN0, true);

                        Rec.Reset;
                        Rec.SetCurrentKey(CODE0);
                        Rec.SetRange("OBJECT ID", PAGE::"DK_Admin. Payment Target");
                        Rec.SetRange("USER ID", UserId);
                        Rec.Ascending(true);
                    end;
                end;
            }
            action(Unselect)
            {
                Caption = 'Unselect';
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                begin

                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet then begin
                        Rec.ModifyAll(BOOLEAN0, false);

                        Rec.Reset;
                        Rec.SetCurrentKey(CODE0);
                        Rec.SetRange("OBJECT ID", PAGE::"DK_Admin. Payment Target");
                        Rec.SetRange("USER ID", UserId);
                        Rec.Ascending(true);
                    end;
                end;
            }
            separator(Action35)
            {
            }
            action("Cooperation Payment")
            {
                Caption = 'Cooperation Payment';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "DK_Admin. Cooperation Payment";

                trigger OnAction()
                var
                    _AdminCooperationPayment: Report "DK_Admin. Cooperation Payment";
                begin
                end;
            }
            action("Admin Ecouragement Payment")
            {
                Caption = 'Admin Ecouragement Payment';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "DK_Admin. Enco. Payment";
            }
        }
    }

    trigger OnOpenPage()
    begin

        SetData;
        //DataInquiry;
    end;

    var
        ReferenceDate: Date;
        PaymentType: Option General,LandScape;
        MSG001: Label 'You cannot enter a date larger than today.';
        MSG002: Label 'Reference date cannot be empty';
        MSG003: Label 'The start date cannot be greater than the end date.';
        MSG004: Label 'ýˆ« ‘Ž‡ßŸ‹ Š±÷‚ã‹ Œ÷ Ž°„Ÿ„¾.';
        MSG100: Label 'Processing ReceiptDocument   #1############\';
        MSG101: Label 'Processing  #2##########\';
        Window: Dialog;
        EntryNo: Integer;
        ExpirationStartDate: Date;
        ExpirationEndDate: Date;
        RatingFilter: Option A,B,C,D,E,F;
        PrepaymentNo: Integer;


    procedure SetData()
    var
        _FunctionSetup: Record "DK_Function Setup";
    begin

        SetDelete;

        Clear(ReferenceDate);
        Clear(PaymentType);

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Management Unit");

        ReferenceDate := WorkDate;
        PaymentType := PaymentType::General;
        RatingFilter := RatingFilter::A;
        PrepaymentNo := _FunctionSetup."Management Unit";
        ExpirationStartDate := CalcDate('<-CM>', WorkDate);
        ExpirationEndDate := WorkDate;
    end;


    procedure SetDelete()
    begin
        Rec.SetRange("OBJECT ID", PAGE::"DK_Admin. Payment Target");
        Rec.SetRange("USER ID", UserId);
        Rec.DeleteAll;
    end;


    procedure DataInquiry()
    var
        _Contract: Record DK_Contract;
        _Corpse: Record DK_Corpse;
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _Customer: Record DK_Customer;
        _MaxLoop: Integer;
        _MainLoop: Integer;
        _FunctionSetup: Record "DK_Function Setup";
        _ReferenceYear: Integer;
        _ReferenceMonth: Integer;
    begin
        SetDelete;

        _ReferenceYear := Date2DMY(ReferenceDate, 3);
        _ReferenceMonth := Date2DMY(ReferenceDate, 2);

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Management Unit");

        if GuiAllowed then
            Window.Open(
              MSG100 +
              MSG101);

        _Contract.Reset;
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("Date Filter", 0D, WorkDate);
        case PaymentType of
            PaymentType::General:
                begin
                    _Contract.SetRange("General Expiration Date", ExpirationStartDate, ExpirationEndDate);
                    _Contract.SetCurrentKey(Status, "General Expiration Date");
                end;
            PaymentType::LandScape:
                begin
                    _Contract.SetRange("Land. Arc. Expiration Date", ExpirationStartDate, ExpirationEndDate);
                    _Contract.SetCurrentKey(Status, "Land. Arc. Expiration Date");
                end;
        end;

        _Contract.SetRange("Litigation Evaluation", RatingFilter);

        if _Contract.FindSet then begin
            _MaxLoop := _Contract.Count;

            repeat
                _Contract.CalcFields("Cemetery Size", "Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount", "Cust. Post Code", "Cust. Address");
                _Contract.CalcFields("Cust. Address 2", "Cust. Mobile No.", "Cust. Phone No.");
                _MainLoop += 1;
                EntryNo += 1;

                if GuiAllowed then begin
                    Window.Update(1, StrSubstNo('%1 / %2', _MainLoop, _MaxLoop));
                    Window.Update(2, _Contract."No.");
                end;

                Rec.Init;
                Rec."OBJECT ID" := PAGE::"DK_Admin. Payment Target";
                Rec."USER ID" := UserId;
                Rec."Entry No." := EntryNo;
                Rec.CODE0 := _Contract."No.";
                Rec.DATE0 := _Contract."Contract Date";
                Rec.CODE1 := _Contract."Cemetery Code";
                Rec."SHORT TEXT0" := _Contract."Cemetery No.";
                Rec."SHORT TEXT1" := _Contract."Main Customer Name";
                Rec."SHORT TEXT2" := _Contract."Cust. Post Code";
                Rec."SHORT TEXT4" := Format(_Contract."Litigation Evaluation");
                Rec.TEXT0 := _Contract."Cust. Address";
                Rec.TEXT1 := _Contract."Cust. Address 2";
                Rec.TEXT2 := _Contract."Cust. Phone No.";
                Rec.TEXT3 := _Contract."Cust. Mobile No.";
                Rec.TEXT4 := _Contract."Litigation Employee Name";
                Rec.CODE2 := _Contract."Litigation Employee No.";

                _Corpse.Reset;
                _Corpse.SetRange("Contract No.", _Contract."No.");
                _Corpse.SetRange("Move The Grave Type", false);
                if _Corpse.FindFirst then
                    Rec."SHORT TEXT3" := _Corpse.Name;
                Rec.DECIMAL0 := _Contract."Cemetery Size";

                case PaymentType of
                    PaymentType::General:
                        begin
                            Rec.DATE1 := _Contract."General Expiration Date";
                            Rec.DATE2 := CalcDate('+1D', _Contract."General Expiration Date");
                            Rec.DATE3 := DMY2Date(Date2DMY(_Contract."General Expiration Date", 1), _ReferenceMonth, _ReferenceYear);
                            Rec.DECIMAL1 := Round(_AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 0, Rec.DATE3, 0D, false), 100, '='); // ‰œ‚‚€¦Ž¸ Ð‹Ó
                                                                                                                                                                // 100°Àˆ«(‰¦“ˆ)
                        end;
                    PaymentType::LandScape:
                        begin
                            Rec.DATE1 := _Contract."Land. Arc. Expiration Date";
                            Rec.DATE2 := CalcDate('+1D', _Contract."Land. Arc. Expiration Date");
                            Rec.DATE3 := DMY2Date(Date2DMY(_Contract."Land. Arc. Expiration Date", 1), _ReferenceMonth, _ReferenceYear);
                            Rec.DECIMAL1 := Round(_AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 1, Rec.DATE3, 0D, false), 100, '='); // ‰œ‚‚ €¦Ž¸ Ð‹Ó
                                                                                                                                                                // 100°Àˆ«(‰¦“ˆ)
                        end;
                end;

                Rec.INTEGER0 := _RevocationContractMgt.CalcContractPreiodMonth(Rec.DATE2, Rec.DATE3);

                Rec.DATE4 := Rec.DATE3 + 1;
                Rec.DATE5 := CalcDate(StrSubstNo('<+%1Y>', PrepaymentNo), Rec.DATE4) - 1;

                Rec.INTEGER1 := _RevocationContractMgt.CalcContractPreiodMonth(Rec.DATE4, Rec.DATE5);

                if PaymentType = PaymentType::General then
                    Rec.DECIMAL2 := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::General, Rec.DATE4) * PrepaymentNo
                else
                    Rec.DECIMAL2 := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::Landscape, Rec.DATE4) * PrepaymentNo;


                _AdminExpenseMgt.GetCalcFuturePreiodExpAmt(_Contract, PaymentType, Rec.DATE4, Rec.DATE5);

                /*
                IF PaymentType = PaymentType::General THEN
                  Rec.DECIMAL2 := _AdminExpenseMgt.GetCalcAdminExpenseAmountForPeriod(_Contract."No.",_AdminExpenseLedger."Admin. Expense Type"::General,"Temp Advance Start Date","Temp Advance End Date")
                ELSE
                  Rec.DECIMAL2 := _AdminExpenseMgt.GetCalcAdminExpenseAmountForPeriod(_Contract."No.",_AdminExpenseLedger."Admin. Expense Type"::Landscape,"Temp Advance Start Date","Temp Advance End Date");
                */
                Rec.Insert;
                ;
            until _Contract.Next = 0;
        end;

        if GuiAllowed then
            Window.Close;

        if Rec.CODE0 <> '' then begin
            Rec.SetCurrentKey(CODE0);
            Rec.Ascending(true);
            Rec.FindFirst;
        end;

    end;


    procedure ReferenceDate_Validate()
    begin
        //IF ReferenceDate > WORKDATE THEN
        //  ERROR(MSG001);

        if ReferenceDate = 0D then
            Error(MSG002);

        SetDelete;
    end;


    procedure PaymentType_Validate()
    begin
        SetDelete;
    end;

    local procedure ExpirationStartDate_Validate()
    begin

        if ExpirationStartDate = 0D then
            Error(MSG004);

        if ExpirationStartDate > ExpirationEndDate then
            Error(MSG003);
    end;

    local procedure ExpirationEndDate_Validate()
    begin

        if ExpirationEndDate = 0D then
            Error(MSG004);

        if ExpirationStartDate > ExpirationEndDate then
            Error(MSG003);
    end;
}

