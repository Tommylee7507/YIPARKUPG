codeunit 50004 "DK_Request Expenses - Post"
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The %1 is empty %2.';
        MSG002: Label 'You can not put a %2 in the %1. %3 : %4.';


    procedure CheckValue(pReqExpHeader: Record "DK_Request Expenses Header"): Boolean
    var
        _ReqExpLine: Record "DK_Request Expenses Line";
        _ValidatePostingDateMgt: Codeunit "DK_ValidatePostingDate Mgt.";
    begin
        pReqExpHeader.TestField("No.");
        pReqExpHeader.TestField("Account No.");
        pReqExpHeader.TestField("Payment Request Date");
        pReqExpHeader.TestField("Posting Date");
        //pReqExpHeader.TESTFIELD("GroupWare Doc. No.");

        //Posting Date
        _ValidatePostingDateMgt.ValidatePostingDate(pReqExpHeader."Posting Date");

        if pReqExpHeader."Bank Code" = '' then
            Error(MSG001, pReqExpHeader.FieldCaption("Bank Code"), pReqExpHeader.FieldCaption("Account No."));

        _ReqExpLine.Reset;
        _ReqExpLine.SetRange("Document No.", pReqExpHeader."No.");
        if _ReqExpLine.FindSet then begin
            repeat
                _ReqExpLine.TestField("Line No.");
                //_ReqExpLine.TESTFIELD("Item No.");
                if _ReqExpLine.Quantity <= 0 then
                    Error(MSG002, _ReqExpLine.FieldCaption(Quantity), _ReqExpLine.Quantity, _ReqExpLine.FieldCaption("Line No."), _ReqExpLine."Line No.");
                if _ReqExpLine."Unit Price" <= 0 then
                    Error(MSG002, _ReqExpLine.FieldCaption("Unit Price"), _ReqExpLine."Unit Price", _ReqExpLine.FieldCaption("Line No."), _ReqExpLine."Line No.");
            until _ReqExpLine.Next = 0;
            exit(true);
        end;
    end;


    procedure Post(var pReqExpHeader: Record "DK_Request Expenses Header")
    var
        _ReqExpLine: Record "DK_Request Expenses Line";
        _Employee: Record DK_Employee;
    begin

        if not CheckValue(pReqExpHeader) then exit;

        //Post Request Expenses Header
        _Employee.Reset;
        _Employee.SetRange("ERP User ID", pReqExpHeader."Creation Person");
        if _Employee.FindSet then begin
            pReqExpHeader.Validate("Department Code", _Employee."Department Code");
        end;

        _ReqExpLine.Reset;
        _ReqExpLine.SetRange("Document No.", pReqExpHeader."No.");
        if _ReqExpLine.FindSet then begin
            Insert_ReqRemLedger(pReqExpHeader);

            pReqExpHeader.Validate(Status, pReqExpHeader.Status::Post);
            pReqExpHeader.Modify;
        end;
    end;


    procedure Insert_ReqRemLedger(pReqExpHeader: Record "DK_Request Expenses Header")
    var
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
    begin
        with _ReqRemLedger do begin
            LockTable;
            Init;
            "Entry No." := 0;
            if pReqExpHeader."Account Type" = pReqExpHeader."Account Type"::Employee then
                Validate("Account Type", _ReqRemLedger."Account Type"::Employee)
            else
                Validate("Account Type", _ReqRemLedger."Account Type"::Vendor);
            "Account No." := pReqExpHeader."Account No.";
            Validate("Account Name", pReqExpHeader."Account Name");
            Validate("Request Payment Date", pReqExpHeader."Payment Request Date");
            Validate("Bank Code", pReqExpHeader."Bank Code");
            Validate("Bank Name", pReqExpHeader."Bank Name");
            Validate("Bank Account No.", pReqExpHeader."Bank Account No.");
            Validate("Bank Account Holder", pReqExpHeader."Account Holder");
            Validate("Source Type", "Source Type"::Expenses);
            Validate("Source No.", pReqExpHeader."No.");
            Validate("GroupWare Doc. No.", pReqExpHeader."GroupWare Doc. No.");
            pReqExpHeader.CalcFields(TotalAmount);
            Amount := pReqExpHeader.TotalAmount;
            Insert(true);
        end;
    end;
}

