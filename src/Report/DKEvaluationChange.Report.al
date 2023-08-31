report 50002 "DK_Evaluation Change"
{
    // DK34: 20201117
    //   - Delete Var: EmployeeNo, EmployeeName
    //   - Add Var: DepartmentCode, DepartmentName
    //   - Modify Trigger: Contract - OnAfterGetRecord()

    Caption = 'Evaluation Change';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Contract; DK_Contract)
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            var
                _ChangeEvaluation: Codeunit "DK_Change Evaluation";
            begin
                if (Evaluation <> Evaluation::Blank) and (DepartmentCode <> '') then        // …©„¾ Š»µ—© µÕ
                    _ChangeEvaluation.Insert_ChangeEvaluationDepartment(Contract."Litigation Evaluation", Evaluation, Contract."Department Code", DepartmentCode, 0, '', Contract)
                else
                    if (Evaluation <> Evaluation::Blank) and (DepartmentCode = '') then    // …Ø€Ãˆˆ Š»µ—© µÕ
                        _ChangeEvaluation.Insert_ChangeEvaluation(Contract."Litigation Evaluation", Evaluation, 0, '', Contract)
                    else
                        if (Evaluation = Evaluation::Blank) and (DepartmentCode <> '') then    // „Ì„ÏŠžŒ¡ˆˆ Š»µ—© µÕ
                            _ChangeEvaluation.Insert_ChangeEvaluationDepartment(Evaluation::Blank, Evaluation::Blank, Contract."Department Code", DepartmentCode, 0, '', Contract);

                if Evaluation <> Evaluation::Blank then
                    Contract.Validate("Litigation Evaluation", Evaluation);

                if DepartmentCode <> '' then
                    Contract.Validate("Department Code", DepartmentCode);

                Contract.Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message(MSG003);
            end;

            trigger OnPreDataItem()
            var
                _Contract: Record DK_Contract;
            begin
                if Contract.FindSet then begin
                    repeat
                        //IF Contract."Litigation Evaluation" = Evaluation THEN
                        //  ERROR(MSG002);

                        case Evaluation of
                            Evaluation::A:
                                begin
                                    //IF (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::F) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::E) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::D) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::C) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::B) THEN
                                    //  ERROR(MSG004);
                                    if DepartmentCode = '' then
                                        Error(MSG001, Evaluation);
                                end;
                            Evaluation::B:
                                begin
                                    //IF (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::F) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::E) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::D) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::C) THEN
                                    //  ERROR(MSG004);
                                    if DepartmentCode = '' then
                                        Error(MSG001, Evaluation);
                                end;
                            Evaluation::C:
                                begin
                                    //IF (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::F) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::E) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::D) THEN
                                    //  ERROR(MSG004);
                                    if DepartmentCode = '' then
                                        Error(MSG001, Evaluation);
                                end;
                            Evaluation::D:
                                begin
                                    //IF  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::F) OR
                                    //  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::E) THEN
                                    //  ERROR(MSG004);

                                    if DepartmentCode = '' then
                                        Error(MSG001, Evaluation);
                                end;
                            Evaluation::E:
                                begin
                                    //IF  (Contract."Litigation Evaluation" = Contract."Litigation Evaluation"::F) THEN
                                    //  ERROR(MSG004);
                                    if DepartmentCode = '' then
                                        Error(MSG001, Evaluation);
                                end;
                            Evaluation::F:
                                begin
                                    if DepartmentCode = '' then
                                        Error(MSG001, Evaluation);
                                end;
                        end;
                    until Contract.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Evaluation; Evaluation)
                {
                    Caption = 'Litigation Evaluation';
                    OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon,Blank';
                }
                field(DepartmentCode; DepartmentCode)
                {
                    Caption = 'Department Code';
                    TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));

                    trigger OnValidate()
                    var
                        _Department: Record DK_Department;
                    begin

                        _Department.Reset;
                        _Department.SetRange(Code, DepartmentCode);
                        if _Department.FindSet then
                            DepartmentName := _Department.Name;
                    end;
                }
                field(DepartmentName; DepartmentName)
                {
                    Caption = 'Department';
                    Editable = false;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            Evaluation := Evaluation::Blank;
        end;
    }

    labels
    {
    }

    var
        Evaluation: Option A,B,C,D,E,F,Blank;
        MSG001: Label 'The Employee is a required value when selecting a %1.';
        MSG002: Label 'You can not select the same evaluation.';
        MSG003: Label 'Change is complete.';
        MSG004: Label 'Direct rating increase is not possible.';
        DepartmentCode: Code[20];
        DepartmentName: Text;
}

