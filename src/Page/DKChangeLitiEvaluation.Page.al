page 50266 "DK_Change Liti. Evaluation"
{
    // 
    // #2026 - 2020-07-15
    //   - Create
    // 
    // DK34 : 20201117
    //   - Add Field: "Department Code", "Department Name"

    Caption = 'Change Litigation Evaluation';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Exception';
    SourceTable = DK_Contract;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group("Filter")
            {
                Caption = 'Filter';
                field(BaseDate; BaseDate)
                {
                    Caption = 'Base Date';

                    trigger OnValidate()
                    begin

                        BaseDate_Onvalidate;
                    end;
                }
            }
            repeater(Control4)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("First Laying Date"; Rec."First Laying Date")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Group Contract No."; Rec."Group Contract No.")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("General Expiration Date"; Rec."General Expiration Date")
                {
                }
                field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
                {
                }
                field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
                {
                }
                field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
                {
                }
                field("Litigation Employee No."; Rec."Litigation Employee No.")
                {
                    Editable = false;
                }
                field("Litigation Employee Name"; Rec."Litigation Employee Name")
                {
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Litigation Evaluation"; Rec."Litigation Evaluation")
                {
                    Caption = 'Before Litigation Evaluation';
                }
                field("Temp Litigation Evaluation"; Rec."Temp Litigation Evaluation")
                {
                    Caption = 'After Litigation Evaluation';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("In quiry")
            {
                Caption = 'In quiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    if not Rec.IsEmpty then
                        if not Confirm(MSG006) then
                            exit;

                    Rec.DeleteAll;
                    DataInquiry;
                end;
            }
            action(Change)
            {
                Caption = 'Change';
                Image = NewStatusChange;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SetContractLitigationEvaluation;
                end;
            }
            separator(Action28)
            {
            }
            action(Exception)
            {
                Caption = 'Exception';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                begin

                    CurrPage.SetSelectionFilter(_Contract);
                    if _Contract.FindSet then begin
                        repeat
                            Rec.SetRange("No.", _Contract."No.");
                            if Rec.FindSet then
                                Rec.Delete;
                            Rec.SetRange("No.");
                        until _Contract.Next = 0;
                    end;

                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        SetData;
    end;

    trigger OnOpenPage()
    begin

        CheckAdminUser;
        SetData;
    end;

    var
        Window: Dialog;
        BaseDate: Date;
        B_EvaluationStartDate: Date;
        B_EvaluationEndDate: Date;
        C_EvaluationStartDate: Date;
        C_EvaluationEndDate: Date;
        E_EvaluationEndDate: Date;
        MSG001: Label 'You cannot set a date later than today.';
        MSG002: Label 'You cannot set the date before this year.';
        MSG003: Label 'Base date cannot be empty.';
        MSG004: Label 'No data has been viewed.';
        MSG005: Label 'The rating cannot be reversed after the change. Do you want to continue?';
        MSG006: Label 'There is already data inquired. Do you want to look it up again?';
        MSG007: Label 'Your changes have been completed.';
        MSG008: Label 'Contract No. #2##########\';
        MSG009: Label 'Please contact your administrator.';

    local procedure SetData()
    begin

        BaseDate := WorkDate;

        SetEvaluationDate;
    end;

    local procedure SetContractLitigationEvaluation()
    var
        _Contract: Record DK_Contract;
        _ChangeEvaluation: Codeunit "DK_Change Evaluation";
    begin

        if not Rec.FindSet then
            Error(MSG004);

        if Rec.FindSet then begin
            if not Confirm(MSG005) then
                exit;

            if GuiAllowed then
                Window.Open(MSG008);

            repeat
                if GuiAllowed then
                    Window.Update(1, _Contract."No.");

                _Contract.Reset;
                _Contract.SetRange("No.", Rec."No.");
                if _Contract.FindSet then begin
                    _ChangeEvaluation.Insert_ChangeEvaluation(_Contract."Litigation Evaluation", Rec."Temp Litigation Evaluation", 0, '', _Contract);

                    _Contract.Validate("Litigation Evaluation", Rec."Temp Litigation Evaluation");
                    _Contract.Modify(true);
                end;
            until Rec.Next = 0;

            if GuiAllowed then
                Window.Close;

            Message(MSG007);
        end;

        Rec.DeleteAll;

        CurrPage.Update;
    end;

    local procedure SetEvaluationDate()
    begin

        if BaseDate = 0D then
            exit;

        B_EvaluationEndDate := CalcDate('<-CY>', BaseDate) - 1;
        B_EvaluationStartDate := CalcDate('<-CY>', B_EvaluationEndDate);

        C_EvaluationEndDate := CalcDate('<-1Y>', B_EvaluationEndDate);
        C_EvaluationStartDate := CalcDate('<-CY>', CalcDate('<-1Y>', C_EvaluationEndDate));

        E_EvaluationEndDate := CalcDate('<-2Y>', C_EvaluationEndDate);
    end;

    local procedure DataInquiry()
    var
        _Contract: Record DK_Contract;
    begin

        if GuiAllowed then
            Window.Open(MSG008);

        _Contract.Reset;
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.FilterGroup(-1);
        _Contract.SetFilter("General Expiration Date", '>%1&<=%2', 0D, BaseDate);
        _Contract.SetFilter("Land. Arc. Expiration Date", '>%1&<=%2', 0D, BaseDate);
        if _Contract.FindSet then begin
            repeat
                Rec.Init;
                Rec.Copy(_Contract);
                Rec."Temp Litigation Evaluation" := CheckLitigationEvaluation(_Contract);

                if (Rec."Litigation Evaluation" < Rec."Temp Litigation Evaluation") and     // …Ø€Ã —Ÿ†Þˆˆ Insert
                  (Rec."Litigation Evaluation" <> Rec."Litigation Evaluation"::D) and       // D…Ø€Ã: –ð€ËœÎ ‰¸ €Ë•ˆ “È™ Š­í —
                  (Rec."Litigation Evaluation" <> Rec."Litigation Evaluation"::E) then      // E…Ø€Ã: S.M•Ô‘ñŠˆ €Ë‘ˆ œý —
                  begin
                    if GuiAllowed then
                        Window.Update(1, _Contract."No.");

                    Rec.Insert;
                end;
            until _Contract.Next = 0;
        end;

        if GuiAllowed then
            Window.Close;

        if Rec.IsEmpty then
            Error(MSG004);
    end;

    local procedure CheckLitigationEvaluation(pContract: Record DK_Contract): Integer
    var
        _Contract: Record DK_Contract;
    begin

        // 3‚Ëœ‹Ý ‰œ‚‚
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.FilterGroup(-1);
        _Contract.SetFilter("General Expiration Date", '>%1&<%2', 0D, E_EvaluationEndDate);
        _Contract.SetFilter("Land. Arc. Expiration Date", '>%1&<%2', 0D, E_EvaluationEndDate);
        if _Contract.FindSet then
            exit(4);  // E…Ø€Ã

        // 1~3‚Ë ‰œ‚‚
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.FilterGroup(-1);
        _Contract.SetRange("General Expiration Date", C_EvaluationStartDate, C_EvaluationEndDate);
        _Contract.SetRange("Land. Arc. Expiration Date", C_EvaluationStartDate, C_EvaluationEndDate);
        if _Contract.FindSet then
            exit(2);  // C…Ø€Ã

        // ý‚Ë…… ‰œ‚‚Šž
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.FilterGroup(-1);
        _Contract.SetRange("General Expiration Date", B_EvaluationStartDate, B_EvaluationEndDate);
        _Contract.SetRange("Land. Arc. Expiration Date", B_EvaluationStartDate, B_EvaluationEndDate);
        if _Contract.FindSet then
            exit(1);  // B…Ø€Ã

        // —÷Ï ‰œ‚‚Šž
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.FilterGroup(-1);
        _Contract.SetRange("General Expiration Date", B_EvaluationEndDate + 1, BaseDate);
        _Contract.SetRange("Land. Arc. Expiration Date", B_EvaluationEndDate + 1, BaseDate);
        if _Contract.FindSet then
            exit(0);  // A…Ø€Ã
    end;

    local procedure CheckAdminUser()
    var
        UserSetup: Record "User Setup";
    begin

        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("DK_Litigation Counsel Admin.", true);
        if not UserSetup.FindSet then
            Error(MSG009);
    end;

    local procedure BaseDate_Onvalidate()
    begin

        if BaseDate = 0D then
            Error(MSG003);

        if BaseDate > WorkDate then
            Error(MSG001);

        if BaseDate < CalcDate('<-CY>', WorkDate) then
            Error(MSG002);

        SetEvaluationDate;

        Rec.DeleteAll(false);
    end;
}

