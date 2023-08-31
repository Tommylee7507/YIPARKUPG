codeunit 50005 "DK_Field Work - Post"
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'There is no %1 information.';
        MSG002: Label 'An SMS will be sent to the %2 when the Status is changed to %1. Do you want to continue?';
        MSG003: Label 'If Canceled, the %1 will be deleted. Do you want to continue?';
        MSG004: Label 'The %3 of %1(%2) is Modify to %4.\Do you want to continue?';
        MSG005: Label '%2 has not been set in the %1.';
        MSG006: Label 'Do you want to change to the %1 Status?';
        MSG007: Label 'If you change the %1, the %2 will be initialized. Do you want to continue?';
        MSG008: Label 'SMS statement settings are not set.';
        MSG009: Label '%1 %2 will be changed. Would you like to go on?';
        DK_FieldWorkHeader: Record "DK_Field Work Header";
        MSG010: Label 'SMS will not be sent to the customer by checking %1. Would you like to go on?';
        MSG011: Label 'There is a %1 document being created. %2: %3';

    procedure SetRelease(var pDK_FieldWorkHeader: Record "DK_Field Work Header")
    var
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _MSG001: Label 'No %1 is entered.';
    begin
        DK_FieldWorkHeader.Copy(pDK_FieldWorkHeader);
        with DK_FieldWorkHeader do begin
            TestField("No.");
            TestField(Date);
            TestField("Field Work Main Cat. Code");
            TestField("Field Work Sub Cat. Code");

            _FieldWorkLineCemetery.Reset;
            _FieldWorkLineCemetery.SetCurrentKey("Line No.");
            _FieldWorkLineCemetery.SetRange("Document No.", "No.");
            if not _FieldWorkLineCemetery.FindSet then
                Error(_MSG001, _FieldWorkLineCemetery.TableCaption);

            Status := Status::Release;
            Modify;
        end;
        pDK_FieldWorkHeader := DK_FieldWorkHeader;
    end;


    procedure CheckValues(pFieldWorkHeader: Record "DK_Field Work Header"): Boolean
    var
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
    begin

        pFieldWorkHeader.TestField("No.");
        pFieldWorkHeader.TestField(Date);
        //pFieldWorkHeader.TESTFIELD("Time From");
        //pFieldWorkHeader.TESTFIELD("Time to");
        pFieldWorkHeader.TestField("Work Time Spent");
        pFieldWorkHeader.TestField("Field Work Main Cat. Code");
        //pFieldWorkHeader.TESTFIELD("Field Work Sub Cat. Code");
        pFieldWorkHeader.TestField("Work Manager Code");
        //pFieldWorkHeader.TESTFIELD("Work Before Picture");
        //pFieldWorkHeader.TESTFIELD("Work after Picture");
        pFieldWorkHeader.TestField("Process Content");

        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Document No.", pFieldWorkHeader."No.");
        _FieldWorkLineItem.SetRange(Type, _FieldWorkLineItem.Type::WorkGroup);
        if not _FieldWorkLineItem.FindFirst then
            Error(MSG005, _FieldWorkLineItem.TableCaption, _FieldWorkLineItem.Type::WorkGroup);

        _FieldWorkLineCemetery.Reset;
        _FieldWorkLineCemetery.SetCurrentKey("Line No.");
        _FieldWorkLineCemetery.SetRange("Document No.", pFieldWorkHeader."No.");
        if not _FieldWorkLineCemetery.FindFirst then
            Error(MSG001, _FieldWorkLineCemetery.TableCaption);

        exit(true);
    end;


    procedure Check_Status(pTodayFuneralLine: Record "DK_Today Funeral Line")
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _TodayFuneral: Record "DK_Today Funeral";
        _DK_TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
    begin
        /*
        _TodayFuneralLine.RESET;
        _TodayFuneralLine.SETCURRENTKEY("Line No.");
        _TodayFuneralLine.SETRANGE("Document No.",pTodayFuneralLine."Document No.");
        _TodayFuneralLine.SETFILTER(Status,'<>%1',_TodayFuneralLine.Status::Complete);
        IF _TodayFuneralLine.FINDFIRST THEN
          EXIT;
        */ // †Ýžœ ‡»‚…… —Ÿ‚¬ ‹²ŒŠˆ‡ž Š»µ

        _TodayFuneral.Reset;
        _TodayFuneral.SetRange("No.", pTodayFuneralLine."Document No.");
        if _TodayFuneral.FindSet then begin
            _DK_TodayFuneralPost.SetComplete(_TodayFuneral, 1);
            //_TodayFuneral.Status := _TodayFuneral.Status::Complete;
            //_TodayFuneral.MODIFY;
            // _TodayFuneral.Check_Status_BK;
        end;

    end;


    procedure Post(var pFieldWorkHeader: Record "DK_Field Work Header"): Boolean
    var
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _SumAmount: Decimal;
        _CalcAmount: Decimal;
        _FunctionSetup: Record "DK_Function Setup";
        _SMS: Record DK_SMS;
        _WorkGroupCode: Code[20];
        _WorkGroupName: Text;
        _WorkPersonnel: Decimal;
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
    begin
        _FunctionSetup.Get;
        if _FunctionSetup."SMS Phone No." = '' then
            Error(MSG005, _FunctionSetup.TableCaption, _FunctionSetup.FieldCaption("SMS Phone No."));

        if pFieldWorkHeader.FindSet then begin
            repeat
                if not CheckValues(pFieldWorkHeader) then exit;
            until pFieldWorkHeader.Next = 0;
        end;

        if pFieldWorkHeader."Source Type" <> pFieldWorkHeader."Source Type"::Today then begin
            if pFieldWorkHeader."SMS Not Sent" then begin
                if not Confirm(MSG010, false, pFieldWorkHeader.FieldCaption("SMS Not Sent")) then exit(false);
            end;
        end;

        if pFieldWorkHeader.FindSet then begin
            repeat
                Connect_Complete(pFieldWorkHeader);

                _FieldWorkLineItem.Reset;
                _FieldWorkLineItem.SetRange("Document No.", pFieldWorkHeader."No.");
                _FieldWorkLineItem.SetRange(Type, _FieldWorkLineItem.Type::WorkGroup);
                if _FieldWorkLineItem.FindFirst then begin
                    _WorkGroupCode := _FieldWorkLineItem."Used Assets Code";
                    _WorkGroupName := _FieldWorkLineItem."Used Assets";
                    _WorkPersonnel := _FieldWorkLineItem.Quantity;
                end;

                _FieldWorkLineCemetery.Reset;
                _FieldWorkLineCemetery.SetRange("Document No.", pFieldWorkHeader."No.");
                if _FieldWorkLineCemetery.FindSet then begin
                    _CalcAmount := Round(pFieldWorkHeader.TotalAmount / _FieldWorkLineCemetery.Count, 1);
                    repeat
                        _SumAmount += _CalcAmount;
                        with _FieldWorkLedgerEntry do begin
                            LockTable;
                            Init;
                            "Entry No." := 0;
                            Validate("Entry Type", _FieldWorkLineCemetery.Type);
                            Validate(Date, pFieldWorkHeader.Date);
                            Validate("Document No.", pFieldWorkHeader."No.");
                            Validate("Document Line No.", _FieldWorkLineCemetery."Line No.");
                            Validate("Estate Code", _FieldWorkLineCemetery."Use Area Code");
                            Validate("Estate Name", _FieldWorkLineCemetery."Use Area");
                            if pFieldWorkHeader.Type = pFieldWorkHeader.Type::Cemetery then begin
                                Validate("Cemetery Code", _FieldWorkLineCemetery."Use Area Code");
                                Validate("Cemetery No.", _FieldWorkLineCemetery."Use Area");
                                Validate("Estate Code", _FieldWorkLineCemetery."Cemetery Estate Code");
                                Validate("Estate Name", _FieldWorkLineCemetery."Cemetery Estate Name");
                            end;
                            //VALIDATE("Time From",pFieldWorkHeader."Time From");
                            //VALIDATE("Time To",pFieldWorkHeader."Time to");
                            //VALIDATE("Time Spent",pFieldWorkHeader."Time Spent");
                            Validate("Work Tiem Spent", pFieldWorkHeader."Work Time Spent");
                            Validate(Amount, _CalcAmount);
                            Validate("Work Main Cat. Code", pFieldWorkHeader."Field Work Main Cat. Code");
                            Validate("Work Main Cat. Name", pFieldWorkHeader."Field Work Main Cat. Name");
                            Validate("Work Sub Cat. Code", pFieldWorkHeader."Field Work Sub Cat. Code");
                            Validate("Work Sub Cat. Name", pFieldWorkHeader."Field Work Sub Cat. Name");
                            Validate("Work Group Code", _WorkGroupCode);
                            Validate("Work Group", _WorkGroupName);
                            Validate("Work Manager Code", pFieldWorkHeader."Work Manager Code");
                            Validate("Work Manager", pFieldWorkHeader."Work Manager Name");
                            Validate("Work Personnel", _WorkPersonnel);
                            Insert(true);
                        end;
                    until _FieldWorkLineCemetery.Next = 0;
                    _FieldWorkLedgerEntry.Amount += (pFieldWorkHeader.TotalAmount - _SumAmount);
                    _FieldWorkLedgerEntry.Modify;

                    pFieldWorkHeader.Status := pFieldWorkHeader.Status::Post;
                    pFieldWorkHeader.Modify;
                    Commit;

                    if pFieldWorkHeader."Source Type" <> pFieldWorkHeader."Source Type"::Today then begin
                        if not pFieldWorkHeader."SMS Not Sent" then begin
                            SMSSend_FieldWork(pFieldWorkHeader);
                        end;
                    end;
                end;
            until pFieldWorkHeader.Next = 0;
            exit(true);
        end;
        exit(false);
    end;


    procedure CanCel(var pFieldWorkHeader: Record "DK_Field Work Header"): Boolean
    var
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
    begin

        if not Confirm(MSG003, false, _FieldWorkLedgerEntry.TableCaption) then exit;

        if pFieldWorkHeader.FindSet then begin
            repeat
                Connect_Cancel(pFieldWorkHeader);

                _FieldWorkLedgerEntry.Reset;
                _FieldWorkLedgerEntry.SetRange("Document No.", pFieldWorkHeader."No.");
                if _FieldWorkLedgerEntry.FindSet then begin
                    _FieldWorkLedgerEntry.DeleteAll;
                end;

                pFieldWorkHeader.Status := pFieldWorkHeader.Status::Release;
                pFieldWorkHeader.Modify;
            until pFieldWorkHeader.Next = 0;
            exit(true);
        end;
        exit(false);
    end;


    procedure Connect_Complete(pFieldWorkHeader: Record "DK_Field Work Header")
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _TodayFuneral: Record "DK_Today Funeral";
        _CemeteryServices: Record "DK_Cemetery Services";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
    begin
        if pFieldWorkHeader."Source Type" = pFieldWorkHeader."Source Type"::Blank then exit;
        case pFieldWorkHeader."Source Type" of
            pFieldWorkHeader."Source Type"::Request:
                begin
                    _CustomerRequests.Reset;
                    _CustomerRequests.SetRange("No.", pFieldWorkHeader."Source No.");
                    if _CustomerRequests.FindSet then begin
                        _CustomerRequests.Status := _CustomerRequests.Status::Complete;
                        _CustomerRequests."Process Content" := pFieldWorkHeader."Process Content";
                        _CustomerRequests."Process Date" := pFieldWorkHeader.Date;
                        _CustomerRequests."Work Time Spent" := pFieldWorkHeader."Work Time Spent";
                        _CustomerRequests."Work Manager Code" := pFieldWorkHeader."Work Manager Code";
                        _CustomerRequests."Work Manager" := pFieldWorkHeader."Work Manager Name";

                        _FieldWorkLineItem.Reset;
                        _FieldWorkLineItem.SetRange("Document No.", pFieldWorkHeader."No.");
                        _FieldWorkLineItem.SetRange(Type, _FieldWorkLineItem.Type::WorkGroup);
                        if _FieldWorkLineItem.FindFirst then begin
                            _CustomerRequests."Work Group Code" := _FieldWorkLineItem."Used Assets Code";
                            _CustomerRequests."Work Group" := _FieldWorkLineItem."Used Assets";
                            _CustomerRequests."Work Personnel" := _FieldWorkLineItem.Quantity;
                        end;

                        _CustomerRequests."Feedback Date" := WorkDate;
                        _CustomerRequests.Modify;
                    end;
                end;
            pFieldWorkHeader."Source Type"::Today:
                begin
                    /*
                    _TodayFuneral.RESET;
                    _TodayFuneral.SETRANGE("No.",pFieldWorkHeader."Source No.");
                    IF _TodayFuneral.FINDSET THEN BEGIN
                      _FieldWorkLineItem.RESET;
                      _FieldWorkLineItem.SETRANGE("Document No.",pFieldWorkHeader."No.");
                      _FieldWorkLineItem.SETRANGE(Type,_FieldWorkLineItem.Type::WorkGroup);
                      IF _FieldWorkLineItem.FINDSET THEN BEGIN
                        _TodayFuneral."Working Group Code" := _FieldWorkLineItem."Used Assets Code";
                        _TodayFuneral."Working Group Name" := _FieldWorkLineItem."Used Assets";
                        _TodayFuneral.MODIFY;
                      END;
                    END;
                    */ // ‘ð‘ó Š»µ—©„¾—¯

                    _TodayFuneralLine.Reset;
                    _TodayFuneralLine.SetRange("Document No.", pFieldWorkHeader."Source No.");
                    _TodayFuneralLine.SetRange("Line No.", pFieldWorkHeader."Source Line No.");
                    if _TodayFuneralLine.FindSet then begin
                        _TodayFuneralLine."Field Work Sub Cat. Code" := pFieldWorkHeader."Field Work Sub Cat. Code";
                        _TodayFuneralLine."Field Work Sub Cat. Name" := pFieldWorkHeader."Field Work Sub Cat. Name";
                        if _TodayFuneralLine."Document Type" = _TodayFuneralLine."Document Type"::Funeral then
                            _TodayFuneralLine."Laying Date" := pFieldWorkHeader.Date
                        else
                            _TodayFuneralLine."Move The Grave Date" := pFieldWorkHeader.Date;

                        if _TodayFuneralLine."Temporary Grave Place Code" <> '' then
                            _TodayFuneralLine."Temporary Grave Date" := pFieldWorkHeader.Date;

                        _TodayFuneralLine.Validate(Status, _TodayFuneralLine.Status::Complete);
                        _TodayFuneralLine.Modify;
                        Check_Status(_TodayFuneralLine);
                    end;
                end;
            pFieldWorkHeader."Source Type"::Service:
                begin
                    _CemeteryServices.Reset;
                    _CemeteryServices.SetRange("No.", pFieldWorkHeader."Source No.");
                    if _CemeteryServices.FindSet then begin
                        _CemeteryServices."Work Date" := pFieldWorkHeader.Date;
                        _CemeteryServices."Process Content" := pFieldWorkHeader."Process Content";
                        _CemeteryServices."Work Time Spent" := pFieldWorkHeader."Work Time Spent";
                        _CemeteryServices.Status := _CemeteryServices.Status::Complete;
                        _CemeteryServices.Modify;
                    end;
                end;
        end;

    end;


    procedure CustomerReqImpossible(pFieldWorkHeader: Record "DK_Field Work Header"): Boolean
    var
        _CustomerRequests: Record "DK_Customer Requests";
    begin

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Field Work Header No.", pFieldWorkHeader."No.");
        _CustomerRequests.SetRange("Field Work Main Cat. Code", pFieldWorkHeader."Field Work Main Cat. Code");
        _CustomerRequests.SetRange("Field Work Sub Cat. Code", pFieldWorkHeader."Field Work Sub Cat. Code");
        if _CustomerRequests.FindSet then begin
            if not Confirm(MSG004, false, _CustomerRequests.TableCaption, _CustomerRequests."No.", _CustomerRequests.FieldCaption(Status), _CustomerRequests.Status::Impossible) then exit;

            _CustomerRequests.Status := _CustomerRequests.Status::Impossible;
            _CustomerRequests.Modify;
        end;

        pFieldWorkHeader.Status := pFieldWorkHeader.Status::Impossible;
        pFieldWorkHeader.Modify;
    end;


    procedure Connect_Cancel(pFieldWorkHeader: Record "DK_Field Work Header")
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _TodayFuneral: Record "DK_Today Funeral";
        _CemeteryServices: Record "DK_Cemetery Services";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin

        case pFieldWorkHeader."Source Type" of
            pFieldWorkHeader."Source Type"::Request:
                begin
                    _CustomerRequests.Reset;
                    _CustomerRequests.SetRange("No.", pFieldWorkHeader."Source No.");
                    if _CustomerRequests.FindSet then begin
                        _CustomerRequests.Status := _CustomerRequests.Status::Post;
                        _CustomerRequests."Process Content" := '';
                        _CustomerRequests."Process Date" := 0D;
                        _CustomerRequests."Work Time Spent" := 0;
                        _CustomerRequests."Work Manager Code" := '';
                        _CustomerRequests."Work Manager" := '';
                        _CustomerRequests."Work Group Code" := '';
                        _CustomerRequests."Work Group" := '';
                        _CustomerRequests."Work Personnel" := 0;
                        _CustomerRequests.Modify;
                    end;
                end;
            pFieldWorkHeader."Source Type"::Today:
                begin
                    _TodayFuneral.Reset;
                    _TodayFuneral.SetRange("No.", pFieldWorkHeader."Source No.");
                    if _TodayFuneral.FindSet then begin
                        _TodayFuneral."Working Group Code" := '';
                        _TodayFuneral."Working Group Name" := '';
                        _TodayFuneral.Modify;
                    end;
                    _TodayFuneralLine.Reset;
                    _TodayFuneralLine.SetRange("Document No.", pFieldWorkHeader."Source No.");
                    _TodayFuneralLine.SetRange("Line No.", pFieldWorkHeader."Source Line No.");
                    if _TodayFuneralLine.FindSet then begin
                        _TodayFuneralLine."Field Work Sub Cat. Code" := '';
                        _TodayFuneralLine."Field Work Sub Cat. Name" := '';
                        _TodayFuneralLine."Laying Date" := 0D;
                        _TodayFuneralLine."Move The Grave Date" := 0D;
                        _TodayFuneralLine.Validate(Status, _TodayFuneralLine.Status::Complete);
                        _TodayFuneralLine.Modify;
                    end;
                end;
            pFieldWorkHeader."Source Type"::Service:
                begin
                    _CemeteryServices.Reset;
                    _CemeteryServices.SetRange("No.", pFieldWorkHeader."Source No.");
                    if _CemeteryServices.FindSet then begin
                        _CemeteryServices."Work Date" := 0D;
                        _CemeteryServices."Process Content" := '';
                        _CemeteryServices."Work Time Spent" := 0;
                        _CemeteryServices.Status := _CemeteryServices.Status::Post;
                        _CemeteryServices.Modify;
                    end;
                end;
        end;
    end;


    procedure SMSSend_FieldWork(pFieldWorkHeader: Record "DK_Field Work Header")
    var
        _SMSSending: Codeunit "DK_Batch SMS Sending";
        _FunctionSetup: Record "DK_Function Setup";
        _TempBlob: Record TempBlob temporary;
        _ImageServerFileName1: Text;
        _ImageServerFileName2: Text;
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _SMSMessage: Text;
        _SMS: Record DK_SMS;
    begin
        if not pFieldWorkHeader."Picture Send" then begin
            if pFieldWorkHeader."Work Before Picture".HasValue then begin
                _TempBlob.Init;
                pFieldWorkHeader.CalcFields("Work Before Picture");
                _TempBlob.Blob := pFieldWorkHeader."Work Before Picture";
                _TempBlob.Insert;
                _ImageServerFileName1 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
                _TempBlob.Delete;
            end;

            if pFieldWorkHeader."Work after Picture".HasValue then begin
                _TempBlob.Init;
                pFieldWorkHeader.CalcFields("Work after Picture");
                _TempBlob.Blob := pFieldWorkHeader."Work after Picture";
                _TempBlob.Insert;
                _ImageServerFileName2 := _SMSSending.MovetoServerBLOBFile(_TempBlob);
                _TempBlob.Delete;
            end;
        end;

        //MESSAGE('1 %1',_ImageServerFileName1);
        //MESSAGE('1 %1',_ImageServerFileName2);

        _FunctionSetup.Get;
        if _FunctionSetup."Use SMS" then begin
            _SMS.Reset;
            _SMS.SetRange(Type, _SMS.Type::FieldWork);
            if _SMS.FindFirst then begin
                _SMSMessage := _SMSSending.SetMessageType(_SMS.Type::FieldWork, _SMS."Short Message", pFieldWorkHeader."No.");

                if pFieldWorkHeader."Source Type" = pFieldWorkHeader."Source Type"::Request then begin
                    _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.",
                                            pFieldWorkHeader."Appl. Mobile No.",
                                            pFieldWorkHeader."Field Work Main Cat. Name",
                                            _SMSMessage,
                                            _ImageServerFileName1,
                                            _ImageServerFileName2,
                                            '',
                                            true,
                                            _SendedSMSHistory."Source Type"::FieldWork,
                                            pFieldWorkHeader."Source No.",
                                            0,
                                            _SMS."Biz Talk Tamplate No.",
                                            pFieldWorkHeader."Contract No.");
                end;

                if pFieldWorkHeader."Source Type" = pFieldWorkHeader."Source Type"::Service then begin
                    _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.",
                                                pFieldWorkHeader."Appl. Mobile No.",
                                                pFieldWorkHeader."Field Work Main Cat. Name",
                                                _SMSMessage,
                                                _ImageServerFileName1,
                                                _ImageServerFileName2,
                                                '',
                                                true,
                                                _SendedSMSHistory."Source Type"::FieldWork,
                                                pFieldWorkHeader."Source No.",
                                                0,
                                                _SMS."Biz Talk Tamplate No.",
                                                pFieldWorkHeader."Contract No.");
                end;
            end;
        end;
    end;


    procedure ShowSourceNoDocmunt(pCustReq: Record "DK_Customer Requests")
    begin
    end;


    procedure InsertItemLine(pFieldWorkHeader: Record "DK_Field Work Header")
    var
        _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
        _LineNo: Integer;
    begin


        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Document No.", pFieldWorkHeader."No.");
        if _FieldWorkLineItem.FindSet then begin
            if not Confirm(MSG007, false, pFieldWorkHeader.FieldCaption("Field Work Sub Cat. Name"), _FieldWorkLineItem.TableCaption) then exit;

            _FieldWorkLineItem.DeleteAll;
        end;

        _FieldWorkSubCatDetail.Reset;
        _FieldWorkSubCatDetail.SetCurrentKey("Field Work Sub Cat. Code", Blocked);
        _FieldWorkSubCatDetail.SetRange("Field Work Sub Cat. Code", pFieldWorkHeader."Field Work Sub Cat. Code");
        _FieldWorkSubCatDetail.SetFilter(Blocked, '<>%1', true);
        if _FieldWorkSubCatDetail.FindSet then begin
            repeat
                _LineNo += 10000;
                _FieldWorkLineItem.Reset;
                _FieldWorkLineItem.Init;
                _FieldWorkLineItem."Document No." := pFieldWorkHeader."No.";
                _FieldWorkLineItem."Line No." := _LineNo;
                _FieldWorkLineItem.Type := _FieldWorkSubCatDetail.Type;
                _FieldWorkLineItem.Quantity := _FieldWorkSubCatDetail.Quantity;
                _FieldWorkLineItem.Validate("Used Assets Code", _FieldWorkSubCatDetail."Used Assets No.");
                _FieldWorkLineItem."Field Work Sub Cat. Code" := pFieldWorkHeader."Field Work Sub Cat. Code";
                _FieldWorkLineItem."Field Work Sub Cat. Name" := pFieldWorkHeader."Field Work Sub Cat. Name";
                _FieldWorkLineItem.Insert;
            until _FieldWorkSubCatDetail.Next = 0;
        end;
    end;


    procedure SetWorkCostAmount(pFieldWorkHeader: Record "DK_Field Work Header")
    var
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
        _WorkGroup: Record "DK_Work Group";
        _TimeResult: Decimal;
    begin

        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Document No.", pFieldWorkHeader."No.");
        _FieldWorkLineItem.SetRange(Type, _FieldWorkLineItem.Type::WorkGroup);
        _FieldWorkLineItem.SetFilter("Cost Amount", '<>%1', 0);
        if _FieldWorkLineItem.FindSet then begin
            if not Confirm(MSG009, false, _FieldWorkLineItem.Type::WorkGroup, _FieldWorkLineItem.FieldCaption("Cost Amount")) then exit;

            _TimeResult := pFieldWorkHeader."Work Time Spent" / 7;
            repeat
                _WorkGroup.Reset;
                _WorkGroup.SetRange(Code, _FieldWorkLineItem."Used Assets Code");
                _WorkGroup.SetFilter("Cost Amount", '<>%1', 0);
                if _WorkGroup.FindSet then begin
                    _FieldWorkLineItem.Validate("Cost Amount", (_WorkGroup."Cost Amount" * _TimeResult));
                    _FieldWorkLineItem.Modify;
                end;
            until _FieldWorkLineItem.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnBeforeValidateEvent', 'Funeral Type', false, false)]
    local procedure Tab50072_FuneralType(var Rec: Record "DK_Field Work Main Category"; var xRec: Record "DK_Field Work Main Category"; CurrFieldNo: Integer)
    var
        _DK_TodayFuneral: Record "DK_Today Funeral";
    begin

        if Rec."Funeral Type" <> xRec."Funeral Type" then begin
            _DK_TodayFuneral.Reset;
            _DK_TodayFuneral.SetRange("Field Work Main Cat. Code", Rec.Code);
            _DK_TodayFuneral.SetRange(Status, _DK_TodayFuneral.Status::Open);
            if _DK_TodayFuneral.FindSet then
                Error(MSG011, _DK_TodayFuneral.TableCaption, _DK_TodayFuneral.FieldCaption("No."), _DK_TodayFuneral."No.");
        end;
    end;
}

