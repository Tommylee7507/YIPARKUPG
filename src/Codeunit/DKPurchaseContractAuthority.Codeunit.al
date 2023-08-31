codeunit 50030 "DK_Purchase Contract Authority"
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'You are not authorized. Please contact the administrator.';
        MSG002: Label 'No %2 is set for %1.';


    procedure Check_Authority(pPurchaseContract: Record "DK_Purchase Contract")
    var
        _PurchaseContractAuthority: Record "DK_Purchase Contract Authority";
        _Employee: Record DK_Employee;
        _DepartmentBoard: Record "DK_Department Board";
    begin
        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if not _Employee.FindSet then
            Error(MSG002, _Employee.TableCaption, _Employee.FieldCaption("ERP User ID"));

        _Employee.TestField("Department Code");

        _PurchaseContractAuthority.Reset;
        _PurchaseContractAuthority.SetCurrentKey("Line No.");
        _PurchaseContractAuthority.SetRange("Document No.", pPurchaseContract."No.");
        _PurchaseContractAuthority.SetRange("Department Code", _Employee."Department Code");
        if not _PurchaseContractAuthority.FindSet then
            Error(MSG001);
    end;


    procedure Insert_Authority(pPurchaseContract: Record "DK_Purchase Contract")
    var
        _PurchaseContractAuthority: Record "DK_Purchase Contract Authority";
        _Employee: Record DK_Employee;
        _DepartmentBoard: Record "DK_Department Board";
    begin
        _DepartmentBoard.Check_EmployeeUserID(UserId);

        with _PurchaseContractAuthority do begin
            Reset;
            Init;
            "Document No." := pPurchaseContract."No.";
            "Line No." := 10000;

            _Employee.Reset;
            _Employee.SetRange("ERP User ID", UserId);
            if _Employee.FindSet then
                _PurchaseContractAuthority.Validate("Department Code", _Employee."Department Code");

            "First Creater" := true;
            Insert;
            ;
        end;
    end;
}

