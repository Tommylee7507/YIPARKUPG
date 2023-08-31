codeunit 50008 "DK_Customer Request - Post"
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The document is sent to the %1.\Do you want to continue?';
        MSG002: Label 'It is a document transferred to the %1.';
        MSG003: Label 'It is not a field work.. Please check the %1.';
        MSG004: Label 'The %3 of %1(%2) is Modify to %4.\Do you want to continue?';
        MSG005: Label 'An SMS will be sent to the %3 customer for %2 when the Status is changed to %1. Do you want to continue?';
        MSG006: Label 'It''s already %1.';
        MSG007: Label '%1 document is in %2. Please contact the %3.';
        MSG008: Label 'It''s already %1.';


    procedure CheckValue(pCustomerReq: Record "DK_Customer Requests"): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        pCustomerReq.TestField("Field Work Main Cat. Code");
        pCustomerReq.TestField("Field Work Main Cat. Name");
        pCustomerReq.TestField("Field Work Sub Cat. Code");
        pCustomerReq.TestField("Field Work Sub Cat. Name");
        pCustomerReq.TestField("Receipt Date");
        pCustomerReq.TestField("Employee No.");
        pCustomerReq.TestField("Appl. Name");
        pCustomerReq.TestField("Appl. Mobile No.");
        //pCustomerReq.TESTFIELD("Appl. Phone No.");
        pCustomerReq.TestField("Receipt Contents");
        pCustomerReq.TestField("Work Cemetery Code");

        exit(true);
    end;


    procedure Post(pCustomerReq: Record "DK_Customer Requests"): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _FieldWorkPost: Codeunit "DK_Field Work - Post";
    begin

        if not CheckValue(pCustomerReq) then exit;

        if pCustomerReq."Field Work Header No." <> '' then begin
            _FieldWorkHeader.Reset;
            _FieldWorkHeader.SetRange("No.", pCustomerReq."Field Work Header No.");
            if _FieldWorkHeader.FindSet then
                Error(MSG002, _FieldWorkHeader.TableCaption);

            _FieldWorkHeader.SetRange("No.");
        end;

        _FieldWorkSubCategory.Reset;
        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", pCustomerReq."Field Work Main Cat. Code");
        _FieldWorkSubCategory.SetRange(Code, pCustomerReq."Field Work Sub Cat. Code");
        _FieldWorkSubCategory.SetRange("Work Blocked", true);
        if _FieldWorkSubCategory.FindSet then begin
            Error(MSG003, _FieldWorkSubCategory.TableCaption);
        end;

        if not Confirm(MSG001, false, _FieldWorkHeader.TableCaption) then exit;

        _FieldWorkHeader.LockTable;
        _FieldWorkHeader.Init;
        _FieldWorkHeader."No." := '';
        _FieldWorkHeader.Status := _FieldWorkHeader.Status::Open;
        _FieldWorkHeader.Date := pCustomerReq."Receipt Date";
        _FieldWorkHeader."Field Work Main Cat. Code" := pCustomerReq."Field Work Main Cat. Code";
        _FieldWorkHeader."Field Work Main Cat. Name" := pCustomerReq."Field Work Main Cat. Name";
        _FieldWorkHeader."Field Work Sub Cat. Code" := pCustomerReq."Field Work Sub Cat. Code";
        _FieldWorkHeader."Field Work Sub Cat. Name" := pCustomerReq."Field Work Sub Cat. Name";
        _FieldWorkHeader.Type := _FieldWorkHeader.Type::Cemetery;
        _FieldWorkHeader."Work Division" := pCustomerReq."Work Division";
        _FieldWorkHeader."Customer Rec. Contents" := pCustomerReq."Receipt Contents";
        _FieldWorkHeader."Customer Rec. Date" := pCustomerReq."Receipt Date";
        _FieldWorkHeader."Appl. Name" := pCustomerReq."Appl. Name";
        _FieldWorkHeader."Appl. Mobile No." := pCustomerReq."Appl. Mobile No.";
        _FieldWorkHeader."Appl. Phone No." := pCustomerReq."Appl. Phone No.";
        _FieldWorkHeader."Contract No." := pCustomerReq."Contract No.";
        _FieldWorkHeader."Source No." := pCustomerReq."No.";
        _FieldWorkHeader."Source Type" := _FieldWorkHeader."Source Type"::Request;
        _FieldWorkHeader.Insert(true);

        _FieldWorkPost.InsertItemLine(_FieldWorkHeader);

        _FieldWorkLineCemetery.LockTable;
        _FieldWorkLineCemetery.Init;
        _FieldWorkLineCemetery."Document No." := _FieldWorkHeader."No.";
        _FieldWorkLineCemetery."Line No." := 10000;
        _FieldWorkLineCemetery.Type := _FieldWorkHeader.Type;
        _FieldWorkLineCemetery.Validate("Use Area Code", pCustomerReq."Work Cemetery Code");
        _FieldWorkLineCemetery.Insert(true);

        pCustomerReq."Field Work Header No." := _FieldWorkHeader."No.";
        pCustomerReq.Status := pCustomerReq.Status::Post;
        pCustomerReq.Modify;

        if pCustomerReq."Relationship With Cust." <> '' then
            Insert_Relationship(pCustomerReq);

        exit(true);
    end;


    procedure Cancel(pCustomerReq: Record "DK_Customer Requests"): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        //Impossible Modify
        CheckValue(pCustomerReq);

        if pCustomerReq.Status = pCustomerReq.Status::Complete then
            Error(MSG006, Format(pCustomerReq.Status::Complete));

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("No.", pCustomerReq."Field Work Header No.");
        _FieldWorkHeader.SetRange("Field Work Main Cat. Code", pCustomerReq."Field Work Main Cat. Code");
        _FieldWorkHeader.SetRange("Field Work Sub Cat. Code", pCustomerReq."Field Work Sub Cat. Code");
        if _FieldWorkHeader.FindSet then begin
            if not Confirm(MSG004, false, _FieldWorkHeader.TableCaption, _FieldWorkHeader."No.", _FieldWorkHeader.FieldCaption(Status), _FieldWorkHeader.Status::Impossible) then exit;

            _FieldWorkHeader.Status := _FieldWorkHeader.Status::Impossible;
            _FieldWorkHeader.Modify;
        end;

        pCustomerReq.Status := pCustomerReq.Status::Impossible;
        pCustomerReq.Modify;

        exit(true);
    end;


    procedure Set_Hold(pCustomerReq: Record "DK_Customer Requests"): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        //Impossible Modify


        if pCustomerReq.Status <> pCustomerReq.Status::Open then
            Error(MSG008, Format(pCustomerReq.Status));

        pCustomerReq.Status := pCustomerReq.Status::Hold;
        pCustomerReq.Modify;

        exit(true);
    end;


    procedure SetComplete(var pCustomerReq: Record "DK_Customer Requests")
    begin
        CheckValue(pCustomerReq);
        with pCustomerReq do begin
            TestField("Process Date");
            TestField("Process Content");

            if "Customer Status" = "Customer Status"::Customer then
                TestField("Contract No.");

            if not Confirm(MSG005, false, Status::Complete, FieldCaption("Process Content"), "Appl. Name") then exit;

            Status := Status::Complete;
            Modify;
            Commit;

            if pCustomerReq."Appl. Mobile No." <> '' then
                SMSSend_CustRequest(pCustomerReq);

            if "Relationship With Cust." <> '' then
                Insert_Relationship(pCustomerReq);
        end;
    end;


    procedure SMSSend_CustRequest(pCustRequests: Record "DK_Customer Requests")
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
        with pCustRequests do begin
            _SMS.Reset;
            _SMS.SetRange(Type, _SMS.Type::CustRequest);
            if _SMS.FindSet then begin
                _SMSMessage := _SMSSending.SetMessageType(_SMS.Type::CustRequest, _SMS."Short Message", pCustRequests."No.");

                _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", "Appl. Mobile No.", _CompanyInformation.Name,
                _SMSMessage, '', '', '', true, _SendedSMSHistory."Source Type"::Vehicle, "No.", 0, _SMS."Biz Talk Tamplate No.", pCustRequests."Contract No.");
            end;
        end;

    end;

    local procedure Insert_Relationship(pCustomerRequests: Record "DK_Customer Requests")
    var
        _RelationshipFamily: Record "DK_Relationship Family";
        _FINDRelationshipFamily: Record "DK_Relationship Family";
        _Contract: Record DK_Contract;
    begin

        with _RelationshipFamily do begin
            Reset;
            Init;
            "Contract No." := pCustomerRequests."Contract No.";

            _FINDRelationshipFamily.Reset;
            _FINDRelationshipFamily.SetRange("Contract No.", pCustomerRequests."Contract No.");
            if _FINDRelationshipFamily.FindLast then
                "Line No." := _FINDRelationshipFamily."Line No." + 1
            else
                "Line No." := 1;

            if _Contract.Get(pCustomerRequests."Contract No.") then begin
                "Supervise No." := _Contract."Supervise No.";
                "Cemetery Code" := _Contract."Cemetery Code";
            end;

            Name := pCustomerRequests."Appl. Name";
            Relationship := pCustomerRequests."Relationship With Cust.";
            "Mobile No." := pCustomerRequests."Appl. Mobile No.";
            "Phone No." := pCustomerRequests."Appl. Phone No.";
            "E-mail" := pCustomerRequests."Appl. E-mail";
            Insert(true);
        end;
    end;


    procedure SetReceiptCancel(var pCustomerRequests: Record "DK_Customer Requests")
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        if pCustomerRequests.Status = pCustomerRequests.Status::Complete then
            Error(MSG006, pCustomerRequests.Status::Complete);

        if not CheckValue(pCustomerRequests) then exit;

        if pCustomerRequests.Status = pCustomerRequests.Status::Post then begin
            _FieldWorkHeader.Reset;
            _FieldWorkHeader.SetRange("Source No.", pCustomerRequests."No.");
            _FieldWorkHeader.SetFilter(Status, '<>%1', _FieldWorkHeader.Status::Open);
            if _FieldWorkHeader.FindSet then
                Error(MSG007, _FieldWorkHeader.TableCaption, _FieldWorkHeader.Status, _FieldWorkHeader.FieldCaption("Work Manager Name"));

            _FieldWorkHeader.SetRange(Status, _FieldWorkHeader.Status::Open);
            if _FieldWorkHeader.FindSet then
                _FieldWorkHeader.Delete;
        end;

        pCustomerRequests.Status := pCustomerRequests.Status::Cancel;
    end;
}

