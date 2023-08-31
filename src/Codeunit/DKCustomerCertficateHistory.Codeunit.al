codeunit 50032 "DK_Customer Certficate History"
{
    // 
    // *DK34 : 20201020
    //   - Add Function: CheckCertificateHistory, InsertCertificateHistory
    // 
    // 
    //   - Modify Function: InsertCertificateHistory


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label '%1 is still present. %2';
        MSG002: Label 'The selected contract does not exist.';
        MSG003: Label 'Do you want to allow membership card Print? Contrants : %1';
        MSG004: Label 'This contract has already been requested. %1 : %2';
        MSG005: Label 'It''s a contract that hasn''t been fully paid for the %1.';
        MSG006: Label 'Canceling approval will delete the request. Would you like to go on?';
        MSG007: Label 'It''s a contract, not a stone. %1: %2';
        MSG008: Label 'Output is not possible in the current state. %1: %2';


    procedure Check_ContractStatus(pContract: Record DK_Contract): Boolean
    var
        _CustomerCertficateHistory: Record "DK_Customer Certficate History";
    begin

        if pContract.Status <> pContract.Status::FullPayment then begin
            Error(MSG001, pContract.FieldCaption("Pay. Remaining Amount"), pContract.FieldCaption("Cemetery No."), pContract."Cemetery No.");
        end;

        _CustomerCertficateHistory.Reset;
        _CustomerCertficateHistory.SetRange("Contract No.", pContract."No.");
        if _CustomerCertficateHistory.FindFirst then begin
            Error(MSG004, _CustomerCertficateHistory.FieldCaption("Contract No."), _CustomerCertficateHistory."Contract No.");
        end;

        exit(true);
    end;


    procedure Request(pContract: Record DK_Contract)
    var
        _CustomerCertficateHistory: Record "DK_Customer Certficate History";
        _Employee: Record DK_Employee;
        _ReqEmployeeNo: Code[20];
        _ReqEmployeeName: Text;
        _FINDCustomerCertificate: Record "DK_Customer Certficate History";
        _Cemetery: Record DK_Cemetery;
    begin

        if not Check_ContractStatus(pContract) then exit;

        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery Code", pContract."Cemetery Code");
        _Cemetery.SetRange(Stone, true);
        if _Cemetery.FindSet then begin
            if pContract."Allow Ston" = false then
                Error(MSG005, pContract.FieldCaption("Allow Ston"), pContract.FieldCaption("No."), pContract."No.");
        end;

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then begin
            _ReqEmployeeNo := _Employee."No.";
            _ReqEmployeeName := _Employee.Name;
        end;

        with _CustomerCertficateHistory do begin
            Init;
            _FINDCustomerCertificate.SetCurrentKey("Entry No.");
            if _FINDCustomerCertificate.FindLast then
                "Entry No." := _FINDCustomerCertificate."Entry No." + 1
            else
                "Entry No." := 1;
            "Req. Employee No." := _ReqEmployeeNo;
            "Req. Employee Name" := _ReqEmployeeName;
            "Member. Request Date" := WorkDate;
            Validate("Contract No.", pContract."No.");
            Validate("Main Customer No.", pContract."Main Customer No.");
            Validate("Cemetery Code", pContract."Cemetery Code");
            "Contract Date" := pContract."Contract Date";
            //"Contract Status" := pContract.Status;
            //"Supervise No." := pContract."Supervise No.";
            Insert;
            ;
        end;
    end;


    procedure Approval(pCustomerCertficateHistory: Record "DK_Customer Certficate History")
    var
        _Employee: Record DK_Employee;
    begin

        with pCustomerCertficateHistory do begin
            "Document No." := '';
            Apprval := true;
            _Employee.Reset;
            _Employee.SetRange("ERP User ID", UserId);
            if _Employee.FindSet then begin
                "Allow Employee No." := _Employee."No.";
                "Allow Employee Name" := _Employee.Name;
            end;
            "Allow Mem. Printing DateTime" := CurrentDateTime;
            Modify(true);
        end;
    end;


    procedure ApprovalCancel(pCustomerCertficateHistory: Record "DK_Customer Certficate History")
    begin

        if not Confirm(MSG006) then exit;

        pCustomerCertficateHistory.Delete;
    end;


    procedure CheckCertificateHistory(pContract: Record DK_Contract)
    var
        _Cemetery: Record DK_Cemetery;
    begin
        // DK34

        if (pContract.Status <> pContract.Status::FullPayment) and
          (pContract.Status <> pContract.Status::Contract) then
            Error(MSG008, pContract.FieldCaption(Status), pContract.Status);

        /*
        _Cemetery.RESET;
        _Cemetery.SETRANGE("Cemetery Code",pContract."Cemetery Code");
        _Cemetery.SETRANGE(Stone,TRUE);
        IF NOT _Cemetery.FINDSET THEN
          ERROR(MSG007,pContract.FIELDCAPTION("No."),pContract."No.")
        ELSE
          IF NOT pContract."Allow Ston" THEN
            ERROR(MSG005,pContract.FIELDCAPTION("Allow Ston"),pContract.FIELDCAPTION("No."),pContract."No.");
        */

    end;


    procedure InsertCertificateHistory(pContract: Record DK_Contract)
    var
        _CustomerCertficateHistory: Record "DK_Customer Certficate History";
        _FINDCustomerCertificate: Record "DK_Customer Certficate History";
        _Employee: Record DK_Employee;
    begin
        // DK34

        CheckCertificateHistory(pContract);

        with _CustomerCertficateHistory do begin
            SetRange("Contract No.", pContract."No.");
            if not FindSet then begin
                Reset;
                Init;
                "Document No." := '';
                _FINDCustomerCertificate.SetCurrentKey("Entry No.");
                if _FINDCustomerCertificate.FindLast then
                    "Entry No." := _FINDCustomerCertificate."Entry No." + 1
                else
                    "Entry No." := 1;

                _Employee.Reset;
                _Employee.SetRange("ERP User ID", UserId);
                if _Employee.FindSet then begin
                    "Req. Employee No." := _Employee."No.";
                    "Req. Employee Name" := _Employee.Name;

                    "Allow Employee No." := _Employee."No.";
                    "Allow Employee Name" := _Employee.Name;
                end;

                "Member. Request Date" := WorkDate;
                "Allow Mem. Printing DateTime" := CurrentDateTime;
                Apprval := true;
                Validate("Contract No.", pContract."No.");
                Validate("Main Customer No.", pContract."Main Customer No.");
                Validate("Cemetery Code", pContract."Cemetery Code");
                "Contract Date" := pContract."Contract Date";
                Insert(true);

                "Document No." := '';
                Modify(true);
            end;
        end;
    end;
}

