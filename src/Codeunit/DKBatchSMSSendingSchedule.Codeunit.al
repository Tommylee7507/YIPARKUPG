codeunit 50023 "DK_Batch SMS Sending Schedule"
{
    // Every Day AM 09:00
    // 
    // DK34: 20201104
    //   - Add Function: PurchaseContractExpiration


    trigger OnRun()
    var
        _FunctionSetup: Record "DK_Function Setup";
    begin
        _FunctionSetup.Get;
        if MobileNoValidate(_FunctionSetup."SMS Phone No.", FromMobileNo) then begin
            VehicleProcess;
            PurchaseContractProcess;
            ContractProcess;
        end;

        //>>DK34
        PurchaseContractExpiration;
        //<<
    end;

    var
        FromMobileNo: Text[20];
        SourceType: Option Contract,PurchaseContract,VehicleRepair,Request,Service;
        MSG001: Label 'Vehicle Alarm Run.';
        MSG002: Label 'Update Purchase Contract Run.';
        MSG003: Label 'Sales Contract balance alarm Run';
        SMS: Record DK_SMS;

    local procedure VehicleProcess()
    var
        _DK_Alarm: Record DK_Alarm;
        _DK_AlarmGroupBySN: Query "DK_Alarm Group By SN";
        _CommFun: Codeunit "DK_Common Function";
    begin
        //Vehicle
        SourceType := SourceType::VehicleRepair;
        SMS.Reset;
        SMS.SetRange(Type, SMS.Type::Vehicle);
        if SMS.FindSet then begin
            _DK_AlarmGroupBySN.SetRange(Source_Type_Filter, _DK_AlarmGroupBySN.Source_Type_Filter::Vehicle);
            _DK_AlarmGroupBySN.SetRange(Type_Filter, _DK_AlarmGroupBySN.Type_Filter::Alarm);
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter, Today);
            _DK_AlarmGroupBySN.Open;
            while _DK_AlarmGroupBySN.Read do begin
                with _DK_Alarm do begin
                    Reset;
                    SetRange("Source Type", _DK_AlarmGroupBySN.Source_Type);
                    SetRange(Type, _DK_AlarmGroupBySN.Type);
                    SetRange("Source No.", _DK_AlarmGroupBySN.Source_No);
                    if FindSet then
                        repeat
                            if not SMSHistoryExists("Source No.", "Source Line No.") then begin
                                MakeSMSData(_DK_Alarm, SMS);
                            end;
                        until Next = 0;
                end;
            end;
            _DK_AlarmGroupBySN.Close;
            Clear(_CommFun);
            _CommFun.UpdateJobQueueHistoty(4, MSG001);
        end;
    end;

    local procedure PurchaseContractProcess()
    var
        _DK_Alarm: Record DK_Alarm;
        _DK_AlarmGroupBySN: Query "DK_Alarm Group By SN";
        _CommFun: Codeunit "DK_Common Function";
    begin
        //PurchaseContract
        SourceType := SourceType::PurchaseContract;
        SMS.Reset;
        SMS.SetRange(Type, SMS.Type::PurchContract);
        if SMS.FindSet then begin
            _DK_AlarmGroupBySN.SetRange(Source_Type_Filter, _DK_AlarmGroupBySN.Source_Type_Filter::PurchaseContract);
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter, Today);
            _DK_AlarmGroupBySN.Open;
            while _DK_AlarmGroupBySN.Read do begin
                //Insert Extension Record
                if _DK_AlarmGroupBySN.Type = _DK_AlarmGroupBySN.Type::Extension then begin
                    PurchaseContractNewRecord(_DK_AlarmGroupBySN.Source_No, _DK_AlarmGroupBySN.Alarm_Date);
                end else begin
                    PurchaseContractProcessSMS;
                end
            end;
            _DK_AlarmGroupBySN.Close;

            Clear(_CommFun);
            _CommFun.UpdateJobQueueHistoty(3, MSG002);
        end;
    end;

    local procedure ContractProcess()
    var
        _DK_Contract: Record DK_Contract;
        _Subject: Label '[Subject]-[Yongin Park]-[Alram]';
        _Contents_7: Label 'ÐŽÊ—Ÿ• [‰ª¬‰°˜ú]-[%1]— Â€¦ [%2 °]í „Ô—© ¯€¦ŽÊ‘ñŸ[%3]œ 7Ÿ µ· …—ŽØ„Ÿ„¾. ý‡“—Ÿ Ž›‡‘…Îˆ‚„Ÿ„¾.';
        _Contents_14: Label 'ÐŽÊ—Ÿ• [‰ª¬‰°˜ú]-[%1]— Â€¦ [%2 °]í „Ô—© ¯€¦ŽÊ‘ñŸ[%3]œ 14Ÿ µ· …—ŽØ„Ÿ„¾. ý‡“—Ÿ Ž›‡‘…Îˆ‚„Ÿ„¾.';
        _CommFun: Codeunit "DK_Common Function";
        _SMS: Record DK_SMS;
        _SMSSending: Codeunit "DK_Batch SMS Sending";
        _SMSMessage: Text;
        _FunctionSetup: Record "DK_Function Setup";
        _CompanyInformation: Record "Company Information";
        _SendedSMSHistory: Record "DK_Sended SMS History";
    begin
        //Contract
        SourceType := SourceType::Contract;
        with _DK_Contract do begin
            Reset;
            SetFilter("Pay. Remaining Amount", '>0');
            SetFilter("Alarm Period 1", '<=%1', Today);
            SetRange("Sended Alarm 1", CreateDateTime(0D, 0T));
            if FindSet then
                CalcFields("Cust. Mobile No.");
            repeat
                if "No." <> '' then begin
                    if not SMSHistoryExists("No.", 1) then begin
                        _SMS.Reset;
                        _SMS.SetRange(Type, _SMS.Type::RemAmount);
                        if _SMS.FindSet then begin
                            _FunctionSetup.Get;
                            _CompanyInformation.Get;
                            _SMSMessage := _SMSSending.SetMessageType(_SMS.Type::RemAmount, _SMS."Short Message", "No.");
                            _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", "Cust. Mobile No.", _CompanyInformation.Name, _SMSMessage, '', '', '', true,
                                      _SendedSMSHistory."Source Type"::General, "No.", 0, _SMS."Biz Talk Tamplate No.", "No.");
                            //SendSMS("Cust. Mobile No.",_Subject,STRSUBSTNO(_Contents_7,"Cemetery No.","Pay. Remaining Amount","Pay. Contract Rece. Date"),"No.",1);
                        end;

                        //Update
                        "Sended Alarm 1" := CurrentDateTime;
                        Modify;
                    end;
                end;
            until Next = 0;
            SetRange("Alarm Period 1");
            SetRange("Sended Alarm 1");
            SetFilter("Alarm Period 2", '<=%1', Today);
            SetRange("Sended Alarm 2", CreateDateTime(0D, 0T));
            if FindSet then
                CalcFields("Cust. Mobile No.");
            repeat
                if "No." <> '' then begin
                    if not SMSHistoryExists("No.", 2) then begin
                        _SMS.Reset;
                        _SMS.SetRange(Type, _SMS.Type::RemAmount);
                        if _SMS.FindSet then begin
                            _FunctionSetup.Get;
                            _CompanyInformation.Get;
                            _SMSMessage := _SMSSending.SetMessageType(_SMS.Type::RemAmount, _SMS."Short Message", "No.");
                            _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", "Cust. Mobile No.", _CompanyInformation.Name, _SMSMessage, '', '', '', true,
                            _SendedSMSHistory."Source Type"::General, "No.", 0, _SMS."Biz Talk Tamplate No.", "No.");
                            //SendSMS("Cust. Mobile No.",_Subject,STRSUBSTNO(_Contents_7,"Cemetery No.","Pay. Remaining Amount","Pay. Contract Rece. Date"),"No.",1);
                        end;

                        //Update
                        "Sended Alarm 1" := CurrentDateTime;
                        Modify;
                    end;
                end;
            until Next = 0;

            Clear(_CommFun);
            _CommFun.UpdateJobQueueHistoty(1, MSG003);
        end;
    end;

    local procedure PurchaseContractNewRecord(pSourceNo: Code[20]; pDate: Date)
    var
        _DK_PurchaseContractLine: Record "DK_Purchase Contract Line";
        _DK_PurchaseContractLineInsert: Record "DK_Purchase Contract Line";
        _DK_Alarm: Record DK_Alarm;
        _iLineNo: Integer;
    begin
        with _DK_PurchaseContractLine do begin
            Reset;
            SetRange("Purchase Contract No.", pSourceNo);
            SetRange("Contract Date From", CalcDate('1D', pDate));
            if FindFirst then
                exit;

            Reset;
            SetRange("Purchase Contract No.", pSourceNo);
            if FindLast then
                _iLineNo := "Line No." + 10000
            else
                _iLineNo := 10000;

            Reset;
            SetRange("Purchase Contract No.", pSourceNo);
            SetRange("Contract Date To", pDate);
            if FindSet then begin
                _DK_PurchaseContractLineInsert.Init;
                _DK_PurchaseContractLineInsert."Purchase Contract No." := "Purchase Contract No.";
                _DK_PurchaseContractLineInsert."Line No." := _iLineNo;
                _DK_PurchaseContractLineInsert.Contents := Contents;
                _DK_PurchaseContractLineInsert."Contract Amount" := "Contract Amount";
                _DK_PurchaseContractLineInsert."Contract Date From" := CalcDate('1D', "Contract Date To");
                _DK_PurchaseContractLineInsert."Contract Date To" := CalcDate('-1D', CalcDate('1Y', _DK_PurchaseContractLineInsert."Contract Date From"));
                _DK_PurchaseContractLineInsert.Insert(true);
            end;
        end;

        with _DK_Alarm do begin
            Reset;
            SetRange("Source Type", "Source Type"::PurchaseContract);
            SetRange("Source No.", pSourceNo);
            if FindSet then
                ModifyAll("Alarm Date", _DK_PurchaseContractLineInsert."Contract Date To");
        end;
    end;

    local procedure MakeSMSData(var pDK_Alarm: Record DK_Alarm; pSMS: Record DK_SMS)
    var
        _DK_Employee: Record DK_Employee;
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _FunctionSetup: Record "DK_Function Setup";
        _CompanyInformation: Record "Company Information";
        _SMSSending: Codeunit "DK_Batch SMS Sending";
    begin
        _FunctionSetup.Get;
        _CompanyInformation.Get;
        with pDK_Alarm do begin
            if "Recipient Type" = "Recipient Type"::Employee then begin
                if _DK_Employee.Get("Recipient Code") then begin
                    _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", _DK_Employee."Mobile No.", _CompanyInformation.Name, Contents, '', '', '', true,
                             _SendedSMSHistory."Source Type"::General, "Source No.", "Source Line No.", pSMS."Biz Talk Tamplate No.", '');
                    //SendSMS(_DK_Employee."Mobile No.",Subject,Contents,"Source No.","Source Line No.");
                end;
            end;
            if "Recipient Type" = "Recipient Type"::Department then begin
                _DK_Employee.Reset;
                _DK_Employee.SetRange("Department Code", "Recipient Code");
                _DK_Employee.SetRange(Blocked, false);
                _DK_Employee.SetFilter("Mobile No.", '<>%1', '');
                if _DK_Employee.FindSet then
                    repeat
                        //MESSAGE('%1,%2',_DK_Employee."Mobile No.",_DK_Employee.Name);
                        _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", _DK_Employee."Mobile No.", _CompanyInformation.Name, Contents, '', '', '', true,
                        _SendedSMSHistory."Source Type"::General, "Source No.", "Source Line No.", pSMS."Biz Talk Tamplate No.", '');
                    //SendSMS("Cust. Mobile No.",_Subject,STRSUBSTNO(_Contents_7,"Cemetery No.","Pay. Remaining Amount","Pay. Contract Rece. Date"),"No.",1);
                    until _DK_Employee.Next = 0;
            end;
        end;
    end;

    local procedure SendSMS(pMobileNo: Text[20]; pSubject: Text[50]; pContents: Text[250]; pSourceNo: Code[20]; pSourceLineNo: Integer)
    var
        _DocNoText: Text[20];
        _ToMobileNo: Text[20];
        _DK_SMSSending: Codeunit "DK_Batch SMS Sending";
        _DK_ExternalDBProcess: Codeunit "DK_External DB Process";
    begin
        /*IF MobileNoValidate(pMobileNo,_ToMobileNo) THEN BEGIN
          //No Subject Out
          IF pSubject = '' THEN
            EXIT;
        
          //No Contents Out
          IF pContents = '' THEN
            EXIT;
        
          //Insert History
          _DocNoText := _DK_SMSSending.AddHistory(FromMobileNo,_ToMobileNo,pSubject,pContents,'','','',TRUE,SourceType,pSourceNo,pSourceLineNo);
          //False Out
          IF _DocNoText = '' THEN
            EXIT;
        
          //SendSMS
          _DK_ExternalDBProcess.SendSMS(_DocNoText,FromMobileNo,_ToMobileNo,pSubject,pContents,'','','');
        END;*/

    end;

    local procedure SMSHistoryExists(pSourceNo: Code[20]; pSourceLineNo: Integer): Boolean
    var
        _DK_SendedSMSHistory: Record "DK_Sended SMS History";
    begin
        with _DK_SendedSMSHistory do begin
            Reset;
            SetRange("Source No.", pSourceNo);
            SetRange("Source Line No.", pSourceLineNo);
            SetRange("Source Type", SourceType);
            SetRange("Sending Date", Today);
            exit(FindFirst);
        end;
    end;


    procedure MobileNoValidate(pMobileNo: Text[20]; var pReturnMobileNo: Text[20]): Boolean
    var
        _Mobile: Decimal;
    begin
        pMobileNo := DelChr(pMobileNo, '=', ' ');
        pMobileNo := DelChr(pMobileNo, '=', '-');

        if pMobileNo <> '' then begin
            if Evaluate(_Mobile, pMobileNo) then begin
                pReturnMobileNo := pMobileNo;
                exit(true);
            end else
                exit(false);
        end;
    end;

    local procedure PurchaseContractProcessSMS()
    var
        _DK_Alarm: Record DK_Alarm;
        _DK_AlarmGroupBySN: Query "DK_Alarm Group By SN";
        _CommFun: Codeunit "DK_Common Function";
    begin
        //PurchaseContract
        SourceType := SourceType::PurchaseContract;
        SMS.Reset;
        SMS.SetRange(Type, SMS.Type::PurchContract);
        if SMS.FindSet then begin
            //90Day
            _DK_AlarmGroupBySN.SetRange(Source_Type_Filter, _DK_AlarmGroupBySN.Source_Type_Filter::PurchaseContract);
            _DK_AlarmGroupBySN.SetRange(Type_Filter, _DK_AlarmGroupBySN.Type::Alarm);
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter, CalcDate('3M', Today));
            _DK_AlarmGroupBySN.Open;
            while _DK_AlarmGroupBySN.Read do begin
                with _DK_Alarm do begin
                    Reset;
                    SetRange("Source Type", _DK_AlarmGroupBySN.Source_Type);
                    SetRange(Type, _DK_AlarmGroupBySN.Type);
                    SetRange("Source No.", _DK_AlarmGroupBySN.Source_No);
                    if FindSet then
                        repeat
                            if not SMSHistoryExists("Source No.", "Source Line No.") then begin
                                MakeSMSData(_DK_Alarm, SMS);
                            end;
                        until Next = 0;
                end;
            end;
            //60Day
            _DK_AlarmGroupBySN.SetRange(Source_Type_Filter, _DK_AlarmGroupBySN.Source_Type_Filter::PurchaseContract);
            _DK_AlarmGroupBySN.SetRange(Type_Filter, _DK_AlarmGroupBySN.Type::Alarm);
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter, CalcDate('2M', Today));
            _DK_AlarmGroupBySN.Open;
            while _DK_AlarmGroupBySN.Read do begin
                with _DK_Alarm do begin
                    Reset;
                    SetRange("Source Type", _DK_AlarmGroupBySN.Source_Type);
                    SetRange(Type, _DK_AlarmGroupBySN.Type);
                    SetRange("Source No.", _DK_AlarmGroupBySN.Source_No);
                    if FindSet then
                        repeat
                            if not SMSHistoryExists("Source No.", "Source Line No.") then begin
                                MakeSMSData(_DK_Alarm, SMS);
                            end;
                        until Next = 0;
                end;
            end;
            //30Days
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter);
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter, CalcDate('1M', Today));
            _DK_AlarmGroupBySN.Open;
            while _DK_AlarmGroupBySN.Read do begin
                with _DK_Alarm do begin
                    Reset;
                    SetRange("Source Type", _DK_AlarmGroupBySN.Source_Type);
                    SetRange(Type, _DK_AlarmGroupBySN.Type);
                    SetRange("Source No.", _DK_AlarmGroupBySN.Source_No);
                    if FindSet then
                        repeat
                            if not SMSHistoryExists("Source No.", "Source Line No.") then begin
                                MakeSMSData(_DK_Alarm, SMS);
                            end;
                        until Next = 0;
                end;
            end;
            //15 Days
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter);
            _DK_AlarmGroupBySN.SetRange(Alarm_Date_Filter, CalcDate('15D', Today));
            _DK_AlarmGroupBySN.Open;
            while _DK_AlarmGroupBySN.Read do begin
                with _DK_Alarm do begin
                    Reset;
                    SetRange("Source Type", _DK_AlarmGroupBySN.Source_Type);
                    SetRange(Type, _DK_AlarmGroupBySN.Type);
                    SetRange("Source No.", _DK_AlarmGroupBySN.Source_No);
                    if FindSet then
                        repeat
                            if not SMSHistoryExists("Source No.", "Source Line No.") then begin
                                MakeSMSData(_DK_Alarm, SMS);
                            end;
                        until Next = 0;
                end;
            end;



            _DK_AlarmGroupBySN.Close;

            Clear(_CommFun);
            _CommFun.UpdateJobQueueHistoty(3, MSG002);
        end;
    end;

    local procedure PurchaseContractExpiration()
    var
        _PurchaseContract: Record "DK_Purchase Contract";
    begin
        // „“€Ø‘÷ À…¼Î Ž°œ ˆˆ‡ß…˜ ÐŽÊ
        // À… ˆˆ‡ß “‚ˆ«

        _PurchaseContract.Reset;
        _PurchaseContract.CalcFields("Max Contract Date To");
        _PurchaseContract.SetRange(Status, _PurchaseContract.Status::Contract);
        _PurchaseContract.SetRange("Automatic Extension", false);
        _PurchaseContract.SetFilter("Max Contract Date To", '<=%1', WorkDate);
        if _PurchaseContract.FindSet then
            _PurchaseContract.ModifyAll(Status, _PurchaseContract.Status::Expiration, true);
    end;


    procedure PurchaseContractTESTSMS()
    var
        _DK_Alarm: Record DK_Alarm;
        _DK_AlarmGroupBySN: Query "DK_Alarm Group By SN";
        _CommFun: Codeunit "DK_Common Function";
    begin
        //PurchaseContract
        SourceType := SourceType::PurchaseContract;
        SMS.Reset;
        SMS.SetRange(Type, SMS.Type::PurchContract);
        if SMS.FindSet then begin


            with _DK_Alarm do begin
                Reset;
                SetRange("Source No.", '2022-11-0004');
                if FindSet then
                    repeat
                        if not SMSHistoryExists("Source No.", "Source Line No.") then begin
                            MakeSMSData(_DK_Alarm, SMS);
                        end;
                    until Next = 0;
            end;






            //CLEAR(_CommFun);
            //_CommFun.UpdateJobQueueHistoty(3, MSG002);
        end;
    end;
}

