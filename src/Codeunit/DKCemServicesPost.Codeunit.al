codeunit 50011 "DK_Cem. Services - Post"
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The document is delivered to the %1.\Do you want to continue?';
        MSG002: Label 'The %2 has not been set in %1.';
        MSG003: Label 'Please change to %1.';
        MSG004: Label 'It is a document transferred to the %1.';
        MSG005: Label 'Can not transfer because of insufficient %1.';
        MSG006: Label 'It is a document transferred to the %1. %2';
        MSG007: Label 'The %2 has been set in %1.';
        MSG008: Label 'This is a deposited document.. %1 : %2';
        MSG009: Label '%1 is set to %2. Please check %3';
        MSG010: Label 'You cannot enter a %2 prior to Today.';
        MSG011: Label '%1 exists. %1:%2';
        MSG012: Label 'The document cannot be re-opened by refund. %1 : %2';


    procedure CheckValue(pCemServices: Record "DK_Cemetery Services"): Boolean
    var
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
    begin
        if _FieldWorkMainCategory.Get(pCemServices."Field Work Main Cat. Code") then begin
            if _FieldWorkMainCategory.Unassigned = false then
                pCemServices.TestField("Contract No.");
        end;
        pCemServices.TestField("Receipt Date");
        pCemServices.TestField("Employee No.");
        pCemServices.TestField("Cemetery Code");
        pCemServices.TestField("Field Work Main Cat. Code");
        //pCemServices.TESTFIELD("Field Work Sub Cat. Code");
        //pCemServices.TESTFIELD("Cost Amount");
        //pCemServices.TESTFIELD(Quantity);
        //pCemServices.TESTFIELD("Appl. Name");
        //pCemServices.TESTFIELD("Appl. Mobile No.");
        pCemServices.TestField(Amount);


        if not pCemServices."Email Status" then
            pCemServices.TestField("Appl. E-mail");

        exit(true);
    end;


    procedure Post(pCemServices: Record "DK_Cemetery Services"): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
        _FieldWorkPost: Codeunit "DK_Field Work - Post";
    begin

        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetRange(Code, pCemServices."Field Work Main Cat. Code");
        _FieldWorkMainCategory.SetFilter("Connect Work", '<>%1', true);
        if _FieldWorkMainCategory.FindSet then
            Error(MSG002, _FieldWorkMainCategory.TableCaption, _FieldWorkMainCategory.FieldCaption("Connect Work"));

        if not CheckValue(pCemServices) then exit;

        if pCemServices.Status <> pCemServices.Status::Release then
            Error(MSG003, pCemServices.Status::Release);

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Source No.", pCemServices."No.");
        _FieldWorkHeader.SetRange("Source Type", _FieldWorkHeader."Source Type"::Service);
        if _FieldWorkHeader.FindSet then
            Error(MSG004, _FieldWorkHeader.TableCaption);

        if pCemServices.Amount > pCemServices."Receipt Amount" then
            Error(MSG005, pCemServices.FieldCaption("Receipt Amount"));

        if not Confirm(MSG001, false, _FieldWorkHeader.TableCaption) then exit;

        with _FieldWorkHeader do begin
            LockTable;
            Reset;
            Init;
            "No." := '';
            Status := Status::Open;
            Date := pCemServices."Desired Date";
            "Work Division" := pCemServices."Work Division";
            Type := _FieldWorkHeader.Type::Cemetery;
            "Field Work Main Cat. Code" := pCemServices."Field Work Main Cat. Code";
            "Field Work Main Cat. Name" := pCemServices."Field Work Main Cat. Name";
            "Field Work Sub Cat. Code" := pCemServices."Field Work Sub Cat. Code";
            "Field Work Sub Cat. Name" := pCemServices."Field Work Sub Cat. Name";
            "Appl. Name" := pCemServices."Appl. Name";
            "Appl. Mobile No." := pCemServices."Appl. Mobile No.";
            "Appl. Phone No." := pCemServices."Appl. Phone No.";
            "Contract No." := pCemServices."Contract No.";
            "Source No." := pCemServices."No.";
            "Source Type" := "Source Type"::Service;
            Insert(true);
        end;

        _FieldWorkPost.InsertItemLine(_FieldWorkHeader);

        _FieldWorkLineCemetery.Init;
        _FieldWorkLineCemetery."Document No." := _FieldWorkHeader."No.";
        _FieldWorkLineCemetery."Line No." := 10000;
        _FieldWorkLineCemetery.Type := _FieldWorkLineCemetery.Type::Cemetery;
        _FieldWorkLineCemetery.Validate("Use Area Code", pCemServices."Cemetery Code");
        _FieldWorkLineCemetery.Insert(true);

        pCemServices.Status := pCemServices.Status::Post;
        pCemServices.Modify;

        if pCemServices."Relationship With Cust." <> '' then
            Insert_Relationship(pCemServices);

        exit(true);
    end;


    procedure SetOpen(var pCemServices: Record "DK_Cemetery Services")
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    begin

        if pCemServices."Pay. Expect Doc. No." <> '' then
            Error(MSG011, pCemServices.FieldCaption("Pay. Expect Doc. No."), pCemServices."Pay. Expect Doc. No.");

        if pCemServices."Payment Rec. Doc. No." <> '' then
            Error(MSG011, pCemServices.FieldCaption("Payment Rec. Doc. No."), pCemServices."Payment Rec. Doc. No.");

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.CalcFields("Line Cem. Services No.", Refund);
        _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
        _PaymentReceiptDocument.SetRange(Refund, true);
        _PaymentReceiptDocument.SetRange("Line Cem. Services No.", pCemServices."No.");
        if _PaymentReceiptDocument.FindSet then begin
            _PaymentReceiptDocument.CalcFields("Refund Document No.");
            Error(MSG012, _PaymentReceiptDocument.FieldCaption("Refund Document No."), _PaymentReceiptDocument."Refund Document No.");
        end;

        Check_PostPayRecDoc(pCemServices);
        Check_FieldWork(pCemServices);

        pCemServices.Status := pCemServices.Status::Open;
    end;


    procedure SetRelease(var pCemServices: Record "DK_Cemetery Services")
    var
        _CemServicesPost: Codeunit "DK_Cem. Services - Post";
    begin

        if not CheckValue(pCemServices) then exit;
        Check_FieldWork(pCemServices);

        //IF pCemServices."Receipt Date" < WORKDATE THEN
        //  ERROR(MSG010,pCemServices.FIELDCAPTION("Receipt Date"));

        pCemServices.Status := pCemServices.Status::Release;
    end;


    procedure SetComplete(var pCemServices: Record "DK_Cemetery Services"): Boolean
    var
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
    begin
        Check_FieldWork(pCemServices);
        Check_ConnectWork(pCemServices);

        if not CheckValue(pCemServices) then exit;
        pCemServices.TestField("Work Date");

        if pCemServices.Amount > pCemServices."Receipt Amount" then
            Error(MSG005, pCemServices.FieldCaption("Receipt Amount"));

        pCemServices.Status := pCemServices.Status::Complete;

        Commit;

        if pCemServices."Relationship With Cust." <> '' then
            Insert_Relationship(pCemServices);

        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetRange(Code, pCemServices."Field Work Main Cat. Code");
        _FieldWorkMainCategory.SetRange("Connect Work", true);
        if _FieldWorkMainCategory.FindSet then
            if pCemServices."Appl. Mobile No." <> '' then
                SMSSend_CemeteryService(pCemServices);

        exit(true);
    end;


    procedure Check_FieldWork(pCemeteryServices: Record "DK_Cemetery Services")
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Source No.", pCemeteryServices."No.");
        _FieldWorkHeader.SetRange("Source Type", _FieldWorkHeader."Source Type"::Service);
        if _FieldWorkHeader.FindSet then
            Error(MSG006, _FieldWorkHeader.TableCaption, _FieldWorkHeader."No.");
    end;


    procedure Check_PostPayRecDoc(pCemeteryServices: Record "DK_Cemetery Services")
    var
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayRecDoc: Record "DK_Payment Receipt Document";
    begin
        if pCemeteryServices.Amount <= pCemeteryServices."Receipt Amount" then
            Error(MSG008, pCemeteryServices.FieldCaption("Receipt Amount"), pCemeteryServices."Receipt Amount");

        if pCemeteryServices."Source No." = '' then
            exit;

        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", pCemeteryServices."Source No.");
        _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::Service);
        //_PayRecDocLine.SETRANGE(CheckCemServices,TRUE);
        if _PayRecDocLine.FindSet then
            Error(MSG007, _PayRecDoc.TableCaption, _PayRecDoc."Document No.");
    end;


    procedure Check_ConnectWork(pCemeteryServices: Record "DK_Cemetery Services")
    var
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
    begin
        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetRange(Code, pCemeteryServices."Field Work Main Cat. Code");
        _FieldWorkMainCategory.SetFilter("Connect Work", '<>%1', false);
        if _FieldWorkMainCategory.FindSet then
            Error(MSG009, pCemeteryServices."Field Work Main Cat. Name", _FieldWorkMainCategory.FieldCaption("Connect Work"), _FieldWorkMainCategory.TableCaption);
    end;


    procedure AppllicantInset(var pCemeteryServices: Record "DK_Cemetery Services")
    var
        _Customer: Record DK_Customer;
    begin
        Check_FieldWork(pCemeteryServices);
        with pCemeteryServices do begin
            TestField(Status, Status::Open);
            TestField("Contract No.");

            CalcFields("Main Customer Name", "Cust. Mobile No.", "Cust. Phone No.", "Cust. E-mail");

            "Appl. Name" := "Main Customer Name";
            "Appl. Mobile No." := "Cust. Mobile No.";
            "Appl. Phone No." := "Cust. Phone No.";
            "Appl. E-mail" := "Cust. E-mail";
        end;
    end;

    local procedure Insert_Relationship(pCemeteryServices: Record "DK_Cemetery Services")
    var
        _RelationshipFamily: Record "DK_Relationship Family";
        _FINDRelationshipFamily: Record "DK_Relationship Family";
        _Contract: Record DK_Contract;
    begin

        with _RelationshipFamily do begin
            Reset;
            Init;
            "Contract No." := pCemeteryServices."Contract No.";

            _FINDRelationshipFamily.Reset;
            _FINDRelationshipFamily.SetRange("Contract No.", pCemeteryServices."Contract No.");
            if _FINDRelationshipFamily.FindLast then
                "Line No." := _FINDRelationshipFamily."Line No." + 1
            else
                "Line No." := 1;

            if _Contract.Get(pCemeteryServices."Contract No.") then begin
                "Supervise No." := _Contract."Supervise No.";
                "Cemetery Code" := _Contract."Cemetery Code";
            end;

            Name := pCemeteryServices."Appl. Name";
            Relationship := pCemeteryServices."Relationship With Cust.";
            "Mobile No." := pCemeteryServices."Appl. Mobile No.";
            "Phone No." := pCemeteryServices."Appl. Phone No.";
            "E-mail" := pCemeteryServices."Appl. E-mail";
            Insert(true);
        end;
    end;


    procedure SetConnectSize(var pCemeteryServices: Record "DK_Cemetery Services")
    var
        _Contract: Record DK_Contract;
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
    begin
        if (pCemeteryServices."Contract No." = '') or
          (pCemeteryServices."Field Work Main Cat. Code" = '') then begin
            pCemeteryServices.Validate(Quantity, 0);
            exit;
        end;

        _FieldWorkSubCategory.Reset;
        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", pCemeteryServices."Field Work Main Cat. Code");
        _FieldWorkSubCategory.SetRange(Code, pCemeteryServices."Field Work Sub Cat. Code");
        _FieldWorkSubCategory.SetRange("Connect Size", true);
        if _FieldWorkSubCategory.FindSet then begin
            if _Contract.Get(pCemeteryServices."Contract No.") then begin
                _Contract.CalcFields("Cemetery Size");
                pCemeteryServices.Validate(Quantity, _Contract."Cemetery Size");
                exit;
            end;
        end;

        _FieldWorkSubCategory.SetRange("Connect Size", false);
        if _FieldWorkSubCategory.FindSet then
            pCemeteryServices.Validate(Quantity, 1);
    end;


    procedure SMSSend_CemeteryService(pCemeteryServices: Record "DK_Cemetery Services")
    var
        _SMSSending: Codeunit "DK_Batch SMS Sending";
        _FunctionSetup: Record "DK_Function Setup";
        _TempBlob: Record TempBlob temporary;
        _ImageServerFileName1: Text;
        _ImageServerFileName2: Text;
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _SMS: Record DK_SMS;
        _SMSMessage: Text;
        _CompanyInformation: Record "Company Information";
    begin
        /*IF pCustRequests."Work Before Picture".HASVALUE THEN BEGIN
          _TempBlob.INIT;
          pCustRequests.CALCFIELDS("Work Before Picture");
          _TempBlob.Blob := pCustRequests."Work Before Picture";
          _TempBlob.INSERT;
          _ImageServerFileName1 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
          _TempBlob.DELETE;
        END;
        
        IF pCustRequests."Work after Picture".HASVALUE THEN BEGIN
          _TempBlob.INIT;
          pCustRequests.CALCFIELDS("Work after Picture");
          _TempBlob.Blob := pCustRequests."Work after Picture";
          _TempBlob.INSERT;
          _ImageServerFileName2 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
          _TempBlob.DELETE;
        END;
        */

        _FunctionSetup.Get;
        _CompanyInformation.Get;
        with pCemeteryServices do begin
            _SMS.Reset;
            _SMS.SetRange(Type, _SMS.Type::Service);
            if _SMS.FindSet then begin
                _SMSMessage := _SMSSending.SetMessageType(_SMS.Type::Service, _SMS."Short Message", pCemeteryServices."No.");

                _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", "Appl. Mobile No.", _CompanyInformation.Name,
                _SMSMessage, '', '', '', true, _SendedSMSHistory."Source Type"::Service, "No.", 0, _SMS."Biz Talk Tamplate No.",
                pCemeteryServices."Contract No.");
            end;
        end;

    end;
}

