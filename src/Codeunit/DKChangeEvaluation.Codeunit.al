codeunit 50035 "DK_Change Evaluation"
{
    // 
    // DK34: 20201130
    //   - Add Function: Insert_ChangeEvaluationDepartment


    trigger OnRun()
    begin
    end;


    procedure Insert_ChangeEvaluation(pBeforeEvaluation: Option; pAfterEvaluation: Option; pReceiptAmont: Decimal; pSourceNo: Code[20]; pContract: Record DK_Contract)
    var
        _ChangeEvaluationHistory: Record "DK_Change Evaluation History";
        _Employee: Record DK_Employee;
        _Customer: Record DK_Customer;
    begin

        if pBeforeEvaluation <> pAfterEvaluation then begin
            _ChangeEvaluationHistory.Init;
            _ChangeEvaluationHistory."Entry No." := 0;
            _ChangeEvaluationHistory."Before Evaluation" := pBeforeEvaluation;
            _ChangeEvaluationHistory."After Evaluation" := pAfterEvaluation;
            _ChangeEvaluationHistory."Receipt Amount" := pReceiptAmont;

            _Employee.Reset;
            _Employee.SetRange("ERP User ID", UserId);
            if _Employee.FindFirst then begin
                _ChangeEvaluationHistory."Employee No." := _Employee."No.";
                _ChangeEvaluationHistory."Employee Name" := _Employee.Name;
            end;

            _ChangeEvaluationHistory."Last Date Modified" := CurrentDateTime;
            _ChangeEvaluationHistory."Source No." := pSourceNo;
            _ChangeEvaluationHistory."Contract No." := pContract."No.";

            _ChangeEvaluationHistory."Main Customer No." := pContract."Main Customer No.";
            _ChangeEvaluationHistory."Cemetery No." := pContract."Cemetery No.";
            _ChangeEvaluationHistory."Cemetery Code" := pContract."Cemetery Code";

            _ChangeEvaluationHistory.Insert(true);

        end;
    end;


    procedure Insert_ChangeEvaluationDepartment(pBeforeEvaluation: Option; pAfterEvaluation: Option; pBeforeDepartmentCode: Code[20]; pAfterDepartmentCode: Code[20]; pReceiptAmont: Decimal; pSourceNo: Code[20]; pContract: Record DK_Contract)
    var
        _ChangeEvaluationHistory: Record "DK_Change Evaluation History";
        _Employee: Record DK_Employee;
        _Customer: Record DK_Customer;
        _Department: Record DK_Department;
    begin

        _ChangeEvaluationHistory.Init;
        _ChangeEvaluationHistory."Entry No." := 0;
        _ChangeEvaluationHistory."Before Evaluation" := pBeforeEvaluation;
        _ChangeEvaluationHistory."After Evaluation" := pAfterEvaluation;
        _Department.Reset;
        if _Department.Get(pBeforeDepartmentCode) then begin
            _ChangeEvaluationHistory."Before Department Code" := _Department.Code;
            _ChangeEvaluationHistory."Before Department Name" := _Department.Name;
        end;
        if _Department.Get(pAfterDepartmentCode) then begin
            _ChangeEvaluationHistory."After Department Code" := _Department.Code;
            _ChangeEvaluationHistory."After Department Name" := _Department.Name;
        end;

        _ChangeEvaluationHistory."Receipt Amount" := pReceiptAmont;

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindFirst then begin
            _ChangeEvaluationHistory."Employee No." := _Employee."No.";
            _ChangeEvaluationHistory."Employee Name" := _Employee.Name;
        end;

        _ChangeEvaluationHistory."Last Date Modified" := CurrentDateTime;
        _ChangeEvaluationHistory."Source No." := pSourceNo;
        _ChangeEvaluationHistory."Contract No." := pContract."No.";

        _ChangeEvaluationHistory."Main Customer No." := pContract."Main Customer No.";
        _ChangeEvaluationHistory."Cemetery No." := pContract."Cemetery No.";
        _ChangeEvaluationHistory."Cemetery Code" := pContract."Cemetery Code";

        _ChangeEvaluationHistory.Insert(true);
    end;
}

