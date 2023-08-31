codeunit 60000 "Calc Data"
{

    trigger OnRun()
    var
        _Customer: Record DK_Customer;
        _Contract: Record DK_Contract;
        _MobileNo: Text[30];
        _Cemetery: Record DK_Cemetery;
        _Temp_Myocd: Record Temp_Myocd;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _CustomerRequests: Record "DK_Customer Requests";
        _Picture: Record DK_Picture;
        _ComFun: Codeunit "DK_Common Function";
        _Group: Text[10];
        _Seq: Text[10];
        _Employee: Record DK_Employee;
        _TempEmployee: Record TempEmployee;
        _Estate: Record DK_Estate;
        _tempDate: Date;
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _Temp_Item: Record Temp_Item;
        _Item: Record DK_Item;
        _TempCemeService: Record Temp_Ceme_Service;
        _CemServices: Record "DK_Cemetery Services";
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
        _CounselHistory: Record "DK_Counsel History";
        _Temp_Indicate: Record Temp_Indicate;
        _MSG: Text;
        _LF: Char;
        _CR: Char;
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _NewLineNo: Integer;
        _CustomerRequestPost: Codeunit "DK_Customer Request - Post";
        _TodayFuneral: Record "DK_Today Funeral";
    begin


        _Contract.Reset;
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetFilter("Remaining Receipt Date", '>=%1', 20191001D);
        _Contract.SetFilter("Bury Amount", '<>0');
        if _Contract.FindSet then begin
            repeat
                if _Contract."Bury Amount" <> 0 then begin

                    _Contract.CalcFields("Cust. Mobile No.", "Cust. Phone No.", "Cust. E-Mail");

                    _PayReceiptDoc.Reset;
                    _PayReceiptDoc.SetCurrentKey("Posting Date");
                    _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                    _PayReceiptDoc.SetRange("Document Type", _PayReceiptDoc."Document Type"::Receipt);
                    if _PayReceiptDoc.FindLast then begin

                        _CemServices.Init;
                        _CemServices."No." := '';
                        _CemServices."Receipt Date" := _Contract."Contract Date";
                        _CemServices."Work Date" := _PayReceiptDoc."Payment Date";
                        _CemServices.Validate("Contract No.", _PayReceiptDoc."Contract No.");
                        _CemServices.Validate("Field Work Main Cat. Code", '015');    //Fixed Value Ž˜”í
                        _CemServices.Validate("Field Work Sub Cat. Code", '007');     //Fixed Value “´“šŽ˜”íŠ±
                        _CemServices."Cost Amount" := _Contract."Bury Amount";
                        _CemServices.Quantity := 1;
                        _CemServices.Amount := _Contract."Bury Amount";
                        _CemServices."Receipt Amount" := _Contract."Bury Amount";
                        _CemServices."Receipt Amount Date" := _PayReceiptDoc."Payment Date";
                        _CemServices."Source No." := _PayReceiptDoc."Document No.";
                        _CemServices."Appl. Name" := _Contract."Main Associate Name";
                        _CemServices."Appl. Mobile No." := _Contract."Cust. Mobile No.";
                        _CemServices."Appl. Phone No." := _Contract."Cust. Phone No.";
                        _CemServices."Appl. E-mail" := _Contract."Cust. E-Mail";

                        if _CemServices."Appl. E-mail" = '' then
                            _CemServices."Email Status" := true;

                        _CemServices.Insert(true);
                        _CemServices.Status := _CemServices.Status::Complete;
                        _CemServices.Modify;
                    end;

                end;
            until _Contract.Next = 0;
        end;

        /*
        //ýŒÁß· ŒÁ‰½ ‹Ý„Ìí Žð…Ñœ–«
        _SendedSMSHistory.RESET;
        _SendedSMSHistory.SETRANGE("Auto Sending", FALSE);
        _SendedSMSHistory.SETFILTER("Contract No.",'<>%1', '');
        _SendedSMSHistory.SETFILTER("Result Status Code", '6600|3200|4100|7000');
        IF _SendedSMSHistory.FINDSET THEN BEGIN
          REPEAT
        
              _CounselHistory.RESET;
              _CounselHistory.SETCURRENTKEY("Contract No.",Type,"Dev. Target Doc. No.","Dev. Target Doc. Line No.","Line No.");
              _CounselHistory.SETRANGE("Contract No.", _SendedSMSHistory."Contract No.");
              _CounselHistory.SETRANGE(Type, _CounselHistory.Type::Litigation);
              _CounselHistory.SETRANGE("Dev. Target Doc. No.", '');
              _CounselHistory.SETRANGE("Dev. Target Doc. Line No.", 0);
              IF _CounselHistory.FINDLAST THEN
                _NewLineNo := _CounselHistory."Line No.";
        
              _NewLineNo += 1;
        
              _CounselHistory.INIT;
              _CounselHistory."Contract No." := _SendedSMSHistory."Contract No.";
              _CounselHistory.Type := _CounselHistory.Type::Litigation;
              _CounselHistory."Line No." := _NewLineNo;
              _CounselHistory."Dev. Target Doc. No." :=  '';
              _CounselHistory."Dev. Target Doc. Line No." := 0;
              _CounselHistory.Date := _SendedSMSHistory."Sending Date";
              IF _Contract.GET(_CounselHistory."Contract No.") THEN BEGIN
                _CounselHistory."Cemetery Code" := _Contract."Cemetery Code";
                _CounselHistory."Cemetery No." := _Contract."Cemetery No.";
              END;
        
              _Employee.RESET;
              _Employee.SETRANGE("ERP User ID", _SendedSMSHistory."Creation Person");
              IF _Employee.FINDFIRST THEN BEGIN
                _CounselHistory."Employee No." := _Employee."No.";
                _CounselHistory."Employee Name" := _Employee.Name;
              END;
              _CounselHistory."Counsel Content" := _SendedSMSHistory."Short Message";
              _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::SMS;
              _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::Mobile;
              _CounselHistory."Process Content" := FORMAT(_SendedSMSHistory."Entry No.");
              _CounselHistory.INSERT(TRUE);
        
          UNTIL _SendedSMSHistory.NEXT = 0;
        END;
        */
        Message('Ÿ‡ß-1111');
        /*
        _Temp_Indicate.RESET;
        //_Temp_Indicate.SETRANGE(Idx, 649);
        IF _Temp_Indicate.FINDSET THEN BEGIN
          REPEAT
            _CustomerRequests.RESET;
            _CustomerRequests.SETRANGE(idx, _Temp_Indicate.Idx);
            IF _CustomerRequests.FINDSET THEN BEGIN
                CASE _Temp_Indicate.cprocess OF
                  '‰œß': _CustomerRequests.Status := _CustomerRequests.Status::Release;
                  'Š­í': _CustomerRequests.Status := _CustomerRequests.Status::Impossible;
                  'Šˆ‡õ': _CustomerRequests.Status := _CustomerRequests.Status::Open;
                  'Ÿ‡ß': _CustomerRequests.Status := _CustomerRequests.Status::Complete;
                END;
                _CustomerRequests.MODIFY;
            END;
        
          UNTIL _Temp_Indicate.NEXT = 0;
        END;
        */
        /*
        _LF := 10;
        _CR := 13;
        
        _Contract.RESET;
        //_Contract.SETRANGE("No.",'20120223003');
        IF _Contract.FINDSET THEN BEGIN
          REPEAT
            _MSG := _Contract.GetWorkMemo;
            ////_MSG := DELCHR(_MSG,'=', FORMAT(_CR,0,'<CHAR>'));
            ////_MSG := DELCHR(_MSG,'=', FORMAT(_LF,0,'<CHAR>'));
        
            _MSG := DELCHR(_MSG,'=', '\');
            _Contract.SetWorkMemo(_MSG);
            _Contract.MODIFY;
          UNTIL _Contract.NEXT = 0;
        END;
        
        */
        /*
        
            _Contract.RESET;
            _Contract.SETRANGE(IDX, _Temp_Contract.idx);
            IF _Contract.FINDSET THEN BEGIN
              _LitigationStatus.RESET;
              _LitigationStatus.SETRANGE(Type, _LitigationStatus.Type::LitigationStatus);
              _LitigationStatus.SETRANGE(Name,_Temp_Contract.m_state);
              IF _LitigationStatus.FINDSET THEN BEGIN
                _Contract.VALIDATE("Litigation Status Code", _LitigationStatus.Code);
                _Contract.MODIFY;
              END;
            END;
        
        
        
            _Contract.RESET;
            _Contract.SETRANGE(IDX, _Temp_Contract.idx);
            IF _Contract.FINDSET THEN BEGIN
        
              _LitigationStatus.RESET;
              _LitigationStatus.SETRANGE(Type, _LitigationStatus.Type::LawStatus);
              _LitigationStatus.SETRANGE(Name, _Temp_Contract.m_law);
              IF _LitigationStatus.FINDSET THEN BEGIN
                _Contract."Law Status Code":= _LitigationStatus.Code;
                _Contract."Law Status Name":= _LitigationStatus.Name;
                _Contract.MODIFY;
              END;
            END;
            */

        /*
        //‰ª‘÷Œ¡Š±Š ‹Ý•’ Žð…Ñœ–«
        _TempCemeService.RESET;
        _TempCemeService.SETRANGE(execdate, '');
        //_TempCemeService.SETRANGE(idx, 15382);
        IF _TempCemeService.FINDSET THEN BEGIN
          REPEAT
            IF _TempCemeService.idx <> 13604 THEN BEGIN
                _CemeteryServices.RESET;
                _CemeteryServices.SETRANGE(idx, _TempCemeService.idx);
                IF _CemeteryServices.FINDSET THEN BEGIN
        
                    _FieldWorkMainCategory.RESET;
                    _FieldWorkMainCategory.SETRANGE(Code,_CemeteryServices."Field Work Main Cat. Code");
                    IF _FieldWorkMainCategory.FINDSET THEN BEGIN
        
                       IF _FieldWorkMainCategory."Connect Work" = FALSE THEN BEGIN
                         _CemeteryServices.Status := _CemeteryServices.Status::Complete;
                       END ELSE BEGIN
                            CASE _TempCemeService.resultgb OF
                              '‘óŒ÷': _CemeteryServices.Status := _CemeteryServices.Status::Release;
                              '‘°—Ê': _CemeteryServices.Status := _CemeteryServices.Status::Release;
                              'Ÿ‡ß': BEGIN
                                  IF _TempCemeService.execdate = '' THEN
                                    _CemeteryServices.Status := _CemeteryServices.Status::Post
                                  ELSE
                                    _CemeteryServices.Status := _CemeteryServices.Status::Complete;
                               END;
                            END;
                      END;
                        _CemeteryServices.MODIFY;
                    END;
                END;
            END;
          UNTIL _TempCemeService.NEXT = 0;
        END;
        */

    end;

    var
        currDate: Date;
        rstDate: Date;
        Window: Dialog;

    local procedure UpdateContractMainCustomerNo(pContractIDX: Integer; pCemeteryNo: Text[30]; pCustomerIDX: Integer; pAddCustomerIDX: Integer)
    var
        _Customer: Record DK_Customer;
        _Contract: Record DK_Contract;
    begin

        if (pContractIDX = 0) or (pCustomerIDX = 0) then
            exit;

        _Contract.Reset;
        _Contract.SetRange(IDX, pContractIDX);
        if _Contract.FindSet then begin

            if _Contract."Cemetery No." = pCemeteryNo then begin
                _Customer.Reset;
                _Customer.SetRange(Idx, Format(pCustomerIDX));
                if _Customer.FindSet then begin
                    _Contract.Validate("Main Customer No.", _Customer."No.");
                    _Contract.Modify;
                end else begin
                    Error('×„‘ñŠˆ  ˜«ž —šÍ %1, %2', pCustomerIDX, pCemeteryNo);
                end;

                if pAddCustomerIDX <> 0 then begin
                    _Customer.Reset;
                    _Customer.SetRange(Idx, Format(pAddCustomerIDX));
                    if _Customer.FindSet then begin
                        _Contract."Associate Name" := _Customer.Name;
                        _Contract."Associate Mobile No." := _Customer."Mobile No.";
                        _Contract."Associate Phone No." := _Customer."Phone No.";
                        _Contract."Associate E-Mail" := _Customer."E-mail";
                        _Contract."Associate Post Code" := _Customer."Post Code";
                        _Contract."Associate Address" := _Customer.Address;
                        _Contract."Associate Address 2" := _Customer."Address 2";
                        _Contract.Modify;
                    end else begin
                        Error('×„‘ñŠˆ  ˜«ž —šÍ %1, %2', pCustomerIDX, pCemeteryNo);
                    end;
                end;

            end else begin
                Error('ÐŽÊ— ‰ª¬‰°˜ú ˜«ž —šÍ %1, %2', pContractIDX, pCemeteryNo);
            end;
        end;
    end;

    local procedure Update_CalcPayment(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then begin
            _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount"));
            _Contract.Modify;
        end;
    end;

    local procedure CalcContractAmount()
    var
        _Cemetery: Record DK_Cemetery;
        _Temp_Contract: Record Temp_Contract;
        _Contract: Record DK_Contract;
        _TempDate: Date;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _MaxLoop: Integer;
        _Loop: Integer;
        _Employee: Record DK_Employee;
        _LitigationStatus: Record "DK_Litigation Status";
        _Temp_Cem: Record Temp_Money;
        _DataUpdate: Codeunit "Data Update";
    begin


        _Temp_Contract.Reset;
        if _Temp_Contract.FindSet then begin
            Window.Open('Processing  @1@@@@@@@@@@');

            _MaxLoop := _Temp_Contract.Count;
            repeat
                _Loop += 1;
                Window.Update(1, Round(_Loop * 10000 / _MaxLoop, 1));


                _Contract.Reset;
                _Contract.SetRange(IDX, _Temp_Contract.idx);
                if _Contract.FindSet then begin

                    _Contract."Cemetery Amount" := _Temp_Contract.l_useamtw;
                    _Contract."General Amount" := _Temp_Contract.l_yearamtw;
                    _Contract."Bury Amount" := _Temp_Contract.l_jobamtw;


                    if (_Temp_Contract.l_useamtw + _Temp_Contract.l_yearamtw + _Temp_Contract.l_jobamtw) <> (_Temp_Contract.l_firstamtw + _Temp_Contract.l_lastamtw) then begin
                        _Contract.CalcFields("Landscape Architecture");

                        if _Contract."Landscape Architecture" then begin
                            _Contract."Landscape Arc. Amount" := _Contract."General Amount";
                        end;
                        _Contract."Cemetery Discount" := (_Temp_Contract.l_useamtw + _Temp_Contract.l_yearamtw + _Contract."Landscape Arc. Amount" + _Temp_Contract.l_jobamtw) - (_Temp_Contract.l_firstamtw + _Temp_Contract.l_lastamtw);
                    end;

                    _Contract."Payment Amount" := _Contract."Cemetery Amount" - _Contract."Cemetery Discount" + _Contract."General Amount" + _Contract."Landscape Arc. Amount" + _Contract."Bury Amount";

                    _Contract."Contract Amount" := _Temp_Contract.l_firstamtw;


                    _Contract."Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";
                    _Contract."Rece. Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";

                    _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount"));

                    if _Temp_Contract.l_lastdate <> '' then
                        _Contract."Remaining Receipt Date" := _DataUpdate.ConvertDate(_Temp_Contract.l_lastdate);

                    _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount"));
                    _Contract.Modify;

                end;


            until _Temp_Contract.Next = 0;
            Window.Close;
        end;
    end;

    local procedure UpdateCustomerRequest(pDate: Date; pCemeteryNo: Text[30]; pRemark: Text[70])
    var
        _CustomerRequests: Record "DK_Customer Requests";
    begin

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Receipt Date", pDate);
        _CustomerRequests.SetRange("Cemetery No.", pCemeteryNo);
        if _CustomerRequests.FindSet then begin
            _CustomerRequests.Status := _CustomerRequests.Status::Complete;
            _CustomerRequests."Process Content" := pRemark;
            _CustomerRequests.Modify;
        end;
    end;
}

