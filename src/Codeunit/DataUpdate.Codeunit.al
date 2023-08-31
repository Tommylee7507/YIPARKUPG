codeunit 60001 "Data Update"
{

    trigger OnRun()
    var
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _CemeteryClassDis: Record "DK_Cemetery Class Discount";
        _AdminExpense: Record "DK_Admin. Expense Price";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _Name1: Text;
        _Name2: Text;
        _Name3: Text;
        _Customer: Record DK_Customer;
        _Contract: Record DK_Contract;
        _RevContract: Record "DK_Revocation Contract";
    begin




        DK_ContractAmountLedger.Reset;
        DK_ContractAmountLedger.SetRange("Contract No.", '20210807007');
        if DK_ContractAmountLedger.FindSet then begin
            DK_ContractAmountLedger.Delete;
        end;

        DK_Contract.Reset;
        DK_Contract.SetRange("No.", '20210807007');
        if DK_Contract.FindSet then begin

            DK_Contract.Validate("Rece. Remaining Amount", 0);
            DK_Contract.Modify;

        end;


        /*
        _Contract.RESET;
        _Contract.SETRANGE("No.", 'CD0010498');
        IF _Contract.FINDSET THEN BEGIN
          _Contract.Status := _Contract.Status::Contract;
        
          _Contract."Revocation Amount" := 0;
          _Contract."Close Amount" := 0;
          _Contract."Revocation Employee No." := '';
          _Contract."Revocation Employee Name" := '';
          _Contract."Revocation Date" := 0D;
          _Contract."Revocation Document No." := '';
          _Contract.MODIFY;
        
        END;
        */
        //SplitName('˜½,€µ,…,’»', _Name1, _Name2, _Name3);

        //ERROR('1 - %1 %2 %3', _Name1, _Name2, _Name3);
        /*
        _Contract.RESET;
        IF _Contract.FINDSET THEN
          _Contract.DELETEALL;
        
        _Customer.RESET;
        IF _Customer.FINDSET THEN
          _Customer.DELETEALL;
        */
        //DelTable;

        ///////UpdateCemetery_Master;                //0. ‰ª¬ ˆ†Š• Žð…Ñœ–« (‘°—ÊŽ˜—¯!)

        //UploadCustomer;                       //1. Ÿ‡ß —‘„¸ ‘°—Ê
        //UploadGroupContract('');                 //2. €¸‡ÕÐŽÊ ˆ³· —‘„¸ ‘°—Ê
        //CRM ÐŽÊ‰°˜ú Žð…Ñœ–« ‘°—Ê.
        //UploadContract('');                      //2. ÐŽÊ Ÿ‡ß
        //CRM KEYí ¼ß…—‘÷ ŽšŠ ÐŽÊ—— ‘´×„œ CRM ×„‰°˜ú‡ž Š»µ„Ô‹Ýž µÕ ‰°· Žð…Ñœ–« ‘°—Ê
        //‘´ ×„ IDí ‘ÈŠ‰…—„’ ÐŽÊ—í ‘´×„ ‰°˜ú Žð…Ñœ–« ŽÊ 4—
        //…Ÿ CRM ×„•í „¾ˆÑ ERP ×„ ‘ñŠˆí ¼ß…—ŽØ ´„’ ÐŽÊ— ˜«ž—Ÿ ‘´×„‰°˜ú Žð…Ñœ–« ‘°—Ê
        //CRM ÐŽÊ‰°˜ú Žð…Ñœ–« ‘°—Ê.
        //°…ˆ×— Žð…Ñœ–«

        //UploadCorpse;                         //3. Ÿ‡ß1 —‘„¸ ‘°—Ê
        //UploadContract_Relate;                //4. Ÿ‡ß1 —‘„¸ ‘°—Ê

        //UploadMoney;                          //6. ¯€¦ …Ñœ• —‘„¸ Ÿ‡ß
        //UpdateCustomerDate;                   //6.1 “´“š ýˆ«Š±‘ñŠˆ Žð…Ñœ–« —‘„¸ Ÿ‡ß

        //UploadContractAmount;                 //5. ÐŽÊ …Ñœ•‡ž ÐŽÊ €¦Ž¸ °Î//¯€¦ ‰«Œ¡ ‹²ŒŠ1—‘„¸ Ÿ‡ß
        //UploadPaymentReceiptMissingContract;  //7. ¯€¦‚‹¬ -ÐŽÊ ‰œ˜«ž— Ÿ‡ß1

        //‰œ‚‚ýˆ«Š±//‘ñ€¯Š¨ ýˆ«Š± ˆÚ…ž ‹²ŒŠ ˜” …Á!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //UpdateAdminExpenseSourceNo;           //8. ýˆ«Š±í ¯€¦‰«Œ¡ øÔ
        //UpdateAdminExpenseReceiptDoc;         //9. ýˆ«Š± °Îí ¯€¦ …Ñœ• ‹²ŒŠ
        //20181231 ýˆ«Š± —³Ð€¦Ž¸ Ð‹Ó
        //UpdateAdminExpenseApply('');          //ýˆ«Š± ¯€¦ øÔ
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        //UploadRequest1;                       //20. Ÿ‰¦ ‹Ý„Ì Ÿ‡ß1 —‘„¸ Ÿ‡ß
        //UploadUnpaidRequest;                  //21. ŒÁ‰½‹Ý„Ì Ÿ‡ß1 —‘„¸ Ÿ‡ß
        //UploadIndicate;                       //22. ‘÷ø‹Ï—¸ Ÿ‡ß(×„ Í“‹ ‹Ï—¸) —‘„¸ Ÿ‡ß
        //UploadVendor;                         //23. ˆ•¯“‚ Ÿ‡ß—‘„¸Ÿ‡ß
        //UploadItem;                           //24. À‹Ó —ˆ± Ÿ‡ß1—‘„¸Ÿ‡ß
        //UploadItemInbound;                    //24.1. À‹Ó ¯× Ÿ‡ß1—‘„¸Ÿ‡ß
        //UploadItemOutbound;                   //24.2. À‹Ó “Ë× Ÿ‡ß1 —‘„¸Ÿ‡ß
        //UpdateInvQRCode;                      //24.3. À‹Ó Ï× CRCODE ‹²ŒŠ1
        //UploadService;                        //25. ‰ª‘÷Œ¡Š±Š Ÿ‡ß —‘„¸ Ÿ‡ß
        //UploadPurchContract;                  //26. €ˆˆ• ÐŽÊ Ÿ‡ß1 —‘„¸ Ÿ‡ß
        //UploadPurchContractLine;              //27. €ˆˆ• ÐŽÊ†Ýž Ÿ‡ß1 —‘„¸ Ÿ‡ß
        //UpdatePurchaseContractAuthority;      //28. €ˆˆ• ÐŽÊ €——© ‘ñŠˆ Ÿ‡ß1 —‘„¸ Ÿ‡ß
        //UploadToday;                          //29. „“— Î‡š —‘„¸ Ÿ‡ß
        //UploadSendedSMSHistoryEntryNo;        //30. ‰ÈŒÁ…˜ SMS €Ë‡Ÿ Entrey No.‹²ŒŠ 100€Ø‘÷ —‘„¸ Ÿ‡ß
        //UploadMemberShipCard;                   //31. ˜ˆ°‘ã ‰È—Ê ‚‹¬
        //------------------------------------------------------------------------
        //UpdateContract_StartingDate;          //9. ÐŽÊí ýˆ«Š± “ÁŸÀ Žð…Ñœ–«1 —‘„¸ Ÿ‡ß
        //UpdateContract_ContractCustomers;      //9.1. °…ˆ×— …Ñœ• Žð…Ñœ–«1 —‘„¸ Ÿ‡ß
        //UpdateStatusCemetery;                 //0.1. ‰ª¬ ‹Ý•’ Žð…Ñœ–«1 —‘„¸ Ÿ‡ß
        //                                      //10.‰œ‚‚ýˆ«Š± Ð‹Ó
        //                                      //11.‘ñ€¯ýˆ«Š± Ð‹Ó
        //                                      //12.¯€¦ ¬‹Ó
        //UpdateContractCustomer;               //13 ÐŽ—À/ýÐÀ1/ýÐÀ2 Žð…Ñœ–«

        Message('Complate');

    end;

    var
        DK_ContractAmountLedger: Record "DK_Contract Amount Ledger";
        DK_Contract: Record DK_Contract;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label '%1\%2\%3';
        MSG002: Label '×„‘ñŠˆ ˜«žŠ­í';
        Window: Dialog;

    local procedure DelTable()
    var
        _FunctionSetup: Record "DK_Function Setup";
        _Contract: Record DK_Contract;
        _Customer: Record DK_Customer;
        _NoSeriesLine: Record "No. Series Line";
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    begin
        _FunctionSetup.Get;
        _FunctionSetup.TestField("Contract Nos.");
        /*
        _Contract.RESET;
        IF _Contract.FINDSET THEN
          _Contract.DELETEALL;
        
        _NoSeriesLine.RESET;
        _NoSeriesLine.SETRANGE("Series Code", _FunctionSetup."Contract Nos.");
        IF _NoSeriesLine.FINDSET THEN BEGIN
          _NoSeriesLine."Last No. Used" := '';
          _NoSeriesLine.MODIFY;
        END;
        
        
        _Customer.RESET;
        IF _Customer.FINDSET THEN
          _Customer.DELETEALL;
        
        _ChangedCustomerHistory.RESET;
        IF _ChangedCustomerHistory.FINDSET THEN
          _ChangedCustomerHistory.DELETEALL;
        
        _FunctionSetup.GET;
        _FunctionSetup.TESTFIELD("Customer Nos.");
        
        _NoSeriesLine.RESET;
        _NoSeriesLine.SETRANGE("Series Code", _FunctionSetup."Customer Nos.");
        IF _NoSeriesLine.FINDSET THEN BEGIN
          _NoSeriesLine."Last No. Used" := '';
          _NoSeriesLine.MODIFY;
        END;
        */

        _PayReceiptDocLine.Reset;
        _PayReceiptDocLine.SetFilter("Document No.", '>%1', 'PRD0013461');
        if _PayReceiptDocLine.FindSet then
            _PayReceiptDocLine.DeleteAll(false);

        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetFilter("Document No.", '>%1', 'PRD0013461');
        if _PayReceiptDoc.FindSet then
            _PayReceiptDoc.DeleteAll(false);

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Payment Receipt Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := 'PRD0013461';
            _NoSeriesLine.Modify;
        end;

    end;

    local procedure UpdateContract(ptid: Text[30])
    var
        _Temp_Contract: Record Temp_Contract;
        _Contract: Record DK_Contract;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Cemetery: Record DK_Cemetery;
        _Memo: Text;
        _Employee: Record DK_Employee;
        _Customer: Record DK_Customer;
        _MainIDX: Code[20];
        _SubCustomerNo: Code[20];
        _Contract1: Record DK_Contract;
        _LitigationStatus: Record "DK_Litigation Status";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin


        Window.Open('Processing  #1##############');

        _Temp_Contract.Reset;
        _Temp_Contract.SetCurrentKey(l_tid);
        if ptid <> '' then
            _Temp_Contract.SetRange(l_tid, ptid);
        //_Temp_Contract.SETRANGE(idx, 32188, 32343);
        if _Temp_Contract.FindSet then begin
            _MaxLoop := _Temp_Contract.Count;
            repeat
                Clear(_SubCustomerNo);
                Clear(_MainIDX);

                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));


                _Contract.Reset;
                _Contract.SetRange(IDX, _Temp_Contract.idx);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin

                    if _Temp_Contract.manage_no <> '0' then
                        _Contract."Supervise No." := _Temp_Contract.manage_no;

                    _Contract."Contract Date" := ConvertDate(_Temp_Contract.m_date);
                    _Contract."Management Unit" := 5;



                    _Contract."General Start Date" := ConvertDate(_Temp_Contract.m_first);
                    _Contract."General Expiration Date" := ConvertDate(_Temp_Contract.m_start);
                    if _Contract."Landscape Architecture" then
                        _Contract."Land. Arc. Expiration Date" := ConvertDate(_Temp_Contract.m_start_stone)
                    else
                        _Contract."Land. Arc. Expiration Date" := 0D;

                    case _Temp_Contract.m_levelcd of
                        '111':
                            _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                        '121':
                            _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                        '131':
                            _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                        '141':
                            _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::D;
                        '151':
                            _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::E;
                        '161':
                            _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::F;
                    end;

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
                    _Contract."Total Contract Amount" := _Temp_Contract.l_firstamtw;

                    _Contract."Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";
                    _Contract."Rece. Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";

                    _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount"));


                    //_Contract.VALIDATE("Contract Amount", _Temp_Contract.l_firstamtw);
                    _Contract.Validate("Pay. Contract Rece. Date", ConvertDate(_Temp_Contract.l_firstdate));

                    _Contract."Remaining Due Date" := ConvertDate(_Temp_Contract.l_lastdate);
                    if _Contract."Remaining Due Date" <> 0D then begin
                        _Contract."Alarm Period 1" := CalcDate(FunctionSetup."Alarm period 1", _Contract."Remaining Due Date");
                        _Contract."Alarm Period 2" := CalcDate(FunctionSetup."Alarm period 2", _Contract."Remaining Due Date");
                    end;

                    if _Temp_Contract.l_tid = '‘ñ‚3‚‚-0274' then
                        _Contract.Validate("Remaining Receipt Date", 20160130D)
                    else
                        _Contract.Validate("Remaining Receipt Date", ConvertDate(_Temp_Contract.l_lastindate));

                    _Contract.Validate("CRM Funeral Service Code", _Temp_Contract.l_helpcd);



                    //ŒÁ‰½ „Ì„ÏÀ
                    if _Temp_Contract.m_manage <> '' then begin
                        _Employee.Reset;
                        _Employee.SetRange(Name, _Temp_Contract.m_manage);
                        if _Employee.FindSet then begin
                            _Contract."Litigation Employee No." := _Employee."No.";
                            _Contract."Litigation Employee Name" := _Employee.Name;
                        end;
                    end;

                    //ŒÁ‰½‹Ý•’
                    if _Temp_Contract.m_state <> '' then begin
                        _LitigationStatus.Reset;
                        _LitigationStatus.SetRange(Type, _LitigationStatus.Type::LitigationStatus);
                        _LitigationStatus.SetRange(Name, _Temp_Contract.m_state);
                        if _LitigationStatus.FindSet then begin
                            _Contract."Litigation Status Code" := _LitigationStatus.Code;
                            _Contract."Litigation Status Name" := _LitigationStatus.Name;
                        end;
                    end;

                    //Œ­ŒÁ ‹Ý•’
                    if _Temp_Contract.m_law <> '' then begin

                        _LitigationStatus.Reset;
                        _LitigationStatus.SetRange(Type, _LitigationStatus.Type::LawStatus);
                        _LitigationStatus.SetRange(Name, _Temp_Contract.m_law);
                        if _LitigationStatus.FindSet then begin
                            _Contract."Law Status Code" := _LitigationStatus.Code;
                            _Contract."Law Status Name" := _LitigationStatus.Name;
                        end;
                    end;

                    //—¹ŽÊ
                    if _Temp_Contract.drop_yn = 'Y' then begin
                        _Contract.Status := _Contract.Status::Revocation;

                        _Contract."Revocation Date" := ConvertDate(_Temp_Contract.drop_date);

                        _Employee.Reset;
                        _Employee.SetRange("Bef. No.", _Temp_Contract.drop_damd);
                        if _Employee.FindSet then begin
                            _Contract."Revocation Employee No." := _Employee."No.";
                            _Contract."Revocation Employee Name" := _Employee.Name;
                        end;
                    end else begin
                        _Contract.Status := _Contract.Status::FullPayment;
                        _Contract."Allow Membership Printing" := true;
                    end;


                    _Contract.Modify;

                    //Memo
                    _Contract.SetWorkMemo(StrSubstNo(MSG001, _Temp_Contract.l_memo, _Temp_Contract.m_memo, _Temp_Contract.drop_memo));
                end;

            until _Temp_Contract.Next = 0;
        end;
        Window.Close;
    end;


    procedure UpdateContractCustomer()
    var
        _Temp_Contract: Record Temp_Contract;
        _Contract: Record DK_Contract;
    begin

        _Temp_Contract.Reset;
        if _Temp_Contract.FindSet then begin
            repeat
                if _Temp_Contract.idx <> 0 then begin
                    _Contract.Reset;
                    _Contract.SetRange(IDX, _Temp_Contract.idx);
                    if _Contract.FindSet then begin

                        _Contract."Contact Target" := _Contract."Contact Target"::MainCustomer;
                        _Contract."Main Associate No." := FindCustomer(_Temp_Contract.l_member1);
                        _Contract."Sub Associate No." := FindCustomer(_Temp_Contract.l_member2);

                        if _Temp_Contract.i_member_gb = '1' then begin
                            if _Contract."Main Associate No." <> '' then begin
                                if _Contract."Main Customer No." = _Contract."Main Associate No." then begin
                                    _Contract."Contact Target" := _Contract."Contact Target"::MainCustomer;
                                    _Contract."Main Associate No." := '';
                                end else
                                    _Contract."Contact Target" := _Contract."Contact Target"::MainAssociate;
                            end;
                        end else begin
                            if _Contract."Sub Associate No." <> '' then begin
                                if _Contract."Main Customer No." = _Contract."Sub Associate No." then begin
                                    _Contract."Contact Target" := _Contract."Contact Target"::MainCustomer;
                                    _Contract."Sub Associate No." := '';
                                end else
                                    _Contract."Contact Target" := _Contract."Contact Target"::SubAssociate;
                            end
                        end;

                        _Contract.Modify;

                    end;
                end;
            until _Temp_Contract.Next = 0;
        end;
    end;

    local procedure UpdateCemetery()
    var
        _Cemetery: Record DK_Cemetery;
    begin

        _Cemetery.Reset;
        if _Cemetery.FindSet then begin
            repeat
                _Cemetery.Validate("Estate Code");
                _Cemetery.Validate("Cemetery Conf. Code");
                _Cemetery.Validate("Cemetery Option Code");
                _Cemetery.Validate("Unit Price Type Code");
                _Cemetery.Validate("Cemetery Dig. Code");
                _Cemetery.Modify(true);
            until _Cemetery.Next = 0;
        end;
    end;


    procedure UploadCustomer()
    var
        _Customer: Record DK_Customer;
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Gender: Integer;
        _Noseries: Code[20];
        _NewNo: Code[20];
        _CommFun: Codeunit "DK_Common Function";
        _SSN: Text[20];
        _TempDate: Text;
        _AlDay: Integer;
        _Temp_Member: Record Temp_Member;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _NewName1: Text[30];
        _NewName2: Text[30];
        _NewName3: Text[30];
        _Customer2: Record DK_Customer;
        _Employee: Record DK_Employee;
        _LitigationStatus: Record "DK_Litigation Status";
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
    begin

        _Customer.Reset;
        if _Customer.FindSet then
            _Customer.DeleteAll;

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Customer Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Customer Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;

        Commit;

        _Temp_Member.Reset;
        if _Temp_Member.FindSet then begin
            repeat
                Clear(_NewName1);
                Clear(_NewName2);
                Clear(_NewName3);
                if StrPos(_Temp_Member.m_name, ',') <> 0 then begin
                    SplitName(_Temp_Member.m_name, _NewName1, _NewName2, _NewName3);
                end else begin
                    _NewName1 := DelChr(_Temp_Member.m_name, '=', ' ');
                end;

                Clear(_CommFun);

                _Customer.Init;
                _Customer."No." := '';
                _Customer.Name := _NewName1;
                _Customer."Post Code" := _Temp_Member.m_post;
                _Customer.Address := _Temp_Member.m_addr1;
                _Customer."Address 2" := _Temp_Member.m_address1;
                _Customer."Phone No." := _Temp_Member.m_tel1;
                _Customer."Mobile No." := _Temp_Member.m_phone1;
                _Customer."E-mail" := _Temp_Member.m_email1;
                _Customer.Idx := Format(_Temp_Member.IDX);

                if _Temp_Member.m_reg <> '' then begin

                    _Customer."Social Security No." := _Temp_Member.m_reg;

                    if _CommFun.CheckDigitSSNo(_Customer."Social Security No.") then begin
                        _SSN := DelChr(_Customer."Social Security No.", '=', '-');

                        Evaluate(_Year, CopyStr(_Customer."Social Security No.", 1, 2));
                        Evaluate(_Month, CopyStr(_Customer."Social Security No.", 3, 2));
                        Evaluate(_Day, CopyStr(_Customer."Social Security No.", 5, 2));

                        Evaluate(_Gender, CopyStr(_SSN, 7, 1));
                        case _Gender of
                            1, 2, 5, 6:
                                _Year += 1900;
                            3, 4, 7, 8:
                                _Year += 2000;
                            9, 0:
                                _Year += 1800;
                        end;

                        _AlDay := Date2DMY(CalcDate('<+CM>', (DMY2Date(1, _Month, _Year))), 1);

                        if _AlDay >= _Day then begin

                            _Customer.Birthday := DMY2Date(_Day, _Month, _Year);

                            case _Gender of
                                1, 3, 5, 7, 9:
                                    _Customer.Gender := _Customer.Gender::Male;
                                2, 4, 6, 8, 0:
                                    _Customer.Gender := _Customer.Gender::Female;
                            end;
                        end else begin
                            if _Customer.Memo = '' then
                                _Customer.Memo := _Customer."Social Security No."
                            else
                                _Customer.Memo := _Customer.Memo + ' ' + _Customer."Social Security No.";

                            _Customer."Social Security No." := '';

                        end;
                    end else begin
                        if _Customer.Memo = '' then
                            _Customer.Memo := _Customer."Social Security No."
                        else
                            _Customer.Memo := _Customer.Memo + ' ' + _Customer."Social Security No.";

                        _Customer."Social Security No." := '';
                    end;
                end;

                if _Customer."E-mail" <> '' then begin
                    if StrPos(_Customer."E-mail", '@') = 0 then begin
                        _Customer.Memo := _Customer.Memo + ' ' + _Customer."E-mail";
                        _Customer."E-mail" := '';
                    end;
                end;

                _Customer."Create Organizer" := _Customer."Create Organizer"::Openning;

                if _NewName2 <> '' then
                    _Customer."joint Tenancy" := true;

                _Customer.Insert(true);


                //------------------------------------------------------------------
                if _Customer."Social Security No." <> '' then begin
                    _Customer.SetSSN(_Customer."Social Security No.");
                    _Customer."Social Security No." := '';
                end;

                _Customer."Creation Date" := _Temp_Member.altdate;
                _Customer."Last Date Modified" := _Temp_Member.altdate;
                _Customer.Status := _Customer.Status::Released;
                _Customer.Modify;

                //Create Log
                _ChangedCustomerHistory.CheckChange(_Customer);

                if _NewName2 <> '' then begin
                    _Customer2.Init;
                    _Customer2.TransferFields(_Customer);
                    _Customer2."No." := '';
                    _Customer2.Name := _NewName2;
                    _Customer2."Social Security No." := '';
                    _Customer2."Mobile No." := '';
                    _Customer2."E-mail" := '';
                    _Customer2.Memo := '';
                    _Customer2.Birthday := 0D;
                    _Customer2.Insert(true);

                    _Customer2."Creation Date" := _Customer."Creation Date";
                    _Customer2."Last Date Modified" := _Customer."Last Date Modified";
                    _Customer2.Modify;

                    _ChangedCustomerHistory.CheckChange(_Customer2);
                end;

                if _NewName3 <> '' then begin
                    _Customer2.Init;
                    _Customer2.TransferFields(_Customer);
                    _Customer2."No." := '';
                    _Customer2.Name := _NewName3;
                    _Customer2."Social Security No." := '';
                    _Customer2."Mobile No." := '';
                    _Customer2."E-mail" := '';
                    _Customer2.Memo := '';
                    _Customer2.Birthday := 0D;
                    _Customer2.Insert(true);

                    _Customer2."Creation Date" := _Customer."Creation Date";
                    _Customer2."Last Date Modified" := _Customer."Last Date Modified";
                    _Customer2.Modify;

                    _ChangedCustomerHistory.CheckChange(_Customer2);
                end;
            until _Temp_Member.Next = 0;

        end;
    end;

    local procedure UploadGroupContract(pDrop: Code[10])
    var
        _Temp_Contract: Record Temp_Contract;
        _Contract: Record DK_Contract;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Cemetery: Record DK_Cemetery;
        _Memo: Text;
        _Employee: Record DK_Employee;
        _Customer: Record DK_Customer;
        _MainIDX: Code[20];
        _SubCustomerNo: Code[20];
        _Contract1: Record DK_Contract;
        _LitigationStatus: Record "DK_Litigation Status";
    begin

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Contract Nos.");


        _Contract.Reset;
        if _Contract.FindSet then
            _Contract.DeleteAll;

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Contract Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;

        Commit;


        _Temp_Contract.Reset;
        _Temp_Contract.SetCurrentKey(l_tid);
        _Temp_Contract.SetFilter(l_tid, '%1|%2|%3|%4|%5',
                                      'ˆ×í¼1-0000', 'ˆ×í¼2-0000', 'ˆ×í¼3-0000', 'ˆ×í¼4-0000', 'ˆ×í¼5-0000');

        if _Temp_Contract.FindSet then begin
            repeat
                Clear(_SubCustomerNo);
                Clear(_MainIDX);

                _Cemetery.Reset;
                _Cemetery.SetRange("Cemetery No.", _Temp_Contract.l_tid);
                if _Cemetery.FindSet then begin

                end else begin
                    //ERROR('NOT _Cemetery');
                end;
                _Contract.Init;
                _Contract."No." := '';

                if _Temp_Contract.manage_no <> '0' then
                    _Contract."Supervise No." := _Temp_Contract.manage_no;

                _Contract."Contract Date" := ConvertDate(_Temp_Contract.m_date);
                _Contract."Management Unit" := 5;

                if _Cemetery."Estate Name" in ['ˆ×í¼', 'ˆ×í¼2', 'ˆ×í¼3', 'ˆ×í¼4', 'ˆ×í¼4A', 'ˆ×í¼4B', 'ˆ×í¼5'] then begin
                    if _Temp_Contract.l_tid in ['ˆ×í¼1-0000', 'ˆ×í¼2-0000', 'ˆ×í¼3-0000', 'ˆ×í¼4-0000', 'ˆ×í¼5-0000'] then begin
                        _Contract."Contract Type" := _Contract."Contract Type"::Group;

                        case _Cemetery."Estate Name" of
                            'ˆ×í¼':
                                begin
                                    _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                end;
                            'ˆ×í¼2':
                                begin
                                    _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                end;
                            'ˆ×í¼3':
                                begin
                                    _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                end;
                            'ˆ×í¼4', 'ˆ×í¼4A', 'ˆ×í¼4B':
                                begin
                                    _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                end;
                            'ˆ×í¼5':
                                begin
                                    _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
                                    _Contract."Management Unit" := 1;
                                    _Contract.Validate("Man. Fee Exemption Date", 20220906D);      //ˆÒ‘ª‘Ž‡ßŸÀ
                                    _Contract.Validate("Man. Fee hike Exemption Date", 20230906D); //ýˆ«Š±ž‹Ý‘Ž‡ßŸÀ
                                end;
                        end;


                    end else begin
                        _Contract."Contract Type" := _Contract."Contract Type"::Sub;

                        case _Cemetery."Estate Name" of
                            'ˆ×í¼':
                                begin
                                    _Contract1.Reset;
                                    _Contract1.SetRange("Cemetery No.", 'ˆ×í¼1-0000');
                                    if _Contract1.FindSet then begin
                                        _Contract.Validate("Group Contract No.", _Contract1."No.");
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                end;
                            'ˆ×í¼2':
                                begin
                                    _Contract1.Reset;
                                    _Contract1.SetRange("Cemetery No.", 'ˆ×í¼2-0000');
                                    if _Contract1.FindSet then begin
                                        _Contract.Validate("Group Contract No.", _Contract1."No.");
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                end;
                            'ˆ×í¼3':
                                begin

                                    _Contract1.Reset;
                                    _Contract1.SetRange("Cemetery No.", 'ˆ×í¼3-0000');
                                    if _Contract1.FindSet then begin
                                        _Contract.Validate("Group Contract No.", _Contract1."No.");
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                end;
                            'ˆ×í¼4', 'ˆ×í¼4A', 'ˆ×í¼4B':
                                begin

                                    _Contract1.Reset;
                                    _Contract1.SetRange("Cemetery No.", 'ˆ×í¼4-0000');
                                    if _Contract1.FindSet then begin
                                        _Contract.Validate("Group Contract No.", _Contract1."No.");
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                end;
                            'ˆ×í¼5':
                                begin
                                    _Contract1.Reset;
                                    _Contract1.SetRange("Cemetery No.", 'ˆ×í¼5-0000');
                                    if _Contract1.FindSet then begin
                                        _Contract.Validate("Group Contract No.", _Contract1."No.");
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                end;
                        end;
                    end;
                end;


                if (_Temp_Contract.l_contracter = '0') and
                   (_Temp_Contract.l_member1 = '0') and
                   (_Temp_Contract.l_member2 = '0') then begin
                    //Create
                    _Customer.Init;
                    _Customer."No." := '';
                    _Customer.Name := MSG002;
                    _Customer.Insert(true);

                    _Contract.Validate("Main Customer No.", _Customer."No.");
                end else begin

                    if _Temp_Contract.l_contracter <> '0' then begin
                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_contracter));

                        case _Temp_Contract.i_member_gb of
                            '1':
                                begin
                                    if _Temp_Contract.l_member1 <> '0' then begin
                                        _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end else begin
                                        if _Temp_Contract.l_member2 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member2);
                                    end;
                                end;
                            '2':
                                begin

                                    if _Temp_Contract.l_member2 <> '0' then begin
                                        _SubCustomerNo := FindCustomer(_Temp_Contract.l_member2);
                                    end else begin
                                        if _Temp_Contract.l_member1 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end;
                                end;
                        end;

                    end else begin
                        case _Temp_Contract.i_member_gb of
                            '1':
                                begin
                                    if _Temp_Contract.l_member1 = '0' then begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member2));
                                        _MainIDX := _Temp_Contract.l_member2;
                                    end else begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member1));
                                        _MainIDX := _Temp_Contract.l_member1;

                                        if _Temp_Contract.l_member2 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end;
                                end;
                            '2':
                                begin
                                    if _Temp_Contract.l_member2 = '0' then begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member1));
                                        _MainIDX := _Temp_Contract.l_member1;
                                    end else begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member2));
                                        _MainIDX := _Temp_Contract.l_member2;
                                        if _Temp_Contract.l_member1 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end;
                                end;
                        end;
                    end;


                    //°…ˆ×— “‚ˆ«

                    _Customer.Reset;
                    _Customer.SetRange(Idx, _MainIDX);
                    _Customer.SetFilter("No.", '<>%1', _Contract."Main Customer No.");
                    if _Customer.FindSet then begin
                        repeat
                            if _Contract."Customer No. 2" = '' then
                                _Contract.Validate("Customer No. 2", _Customer."No.")
                            else
                                _Contract.Validate("Customer No. 3", _Customer."No.");
                        until _Customer.Next = 0;
                    end;

                end;

                //ýÐž
                if _SubCustomerNo <> '' then begin
                    if _Customer.Get(_SubCustomerNo) then begin
                        _Contract."Associate Name" := _Customer.Name;
                        _Contract."Associate Mobile No." := _Customer."Mobile No.";
                        _Contract."Associate Phone No." := _Customer."Phone No.";
                        _Contract."Associate E-Mail" := _Customer."E-mail";
                        _Contract."Associate Post Code" := _Customer."Post Code";
                        _Contract."Associate Address" := _Customer.Address;
                        _Contract."Associate Address 2" := _Customer."Address 2";
                    end;
                end;

                if _Cemetery."Cemetery Code" = '' then begin
                    _Contract."Cemetery Code" := '';
                    _Contract."Cemetery No." := _Temp_Contract.l_tid;
                end else begin
                    _Contract."Cemetery Code" := _Cemetery."Cemetery Code";
                    _Contract."Cemetery No." := _Cemetery."Cemetery No.";
                end;

                _Contract."General Start Date" := ConvertDate(_Temp_Contract.m_first);
                _Contract."General Expiration Date" := ConvertDate(_Temp_Contract.m_start);
                _Contract."Land. Arc. Expiration Date" := ConvertDate(_Temp_Contract.m_start_stone);

                case _Temp_Contract.m_levelcd of
                    '111':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                    '121':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                    '131':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                    '141':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::D;
                    '151':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::E;
                    '161':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::F;
                end;

                /*…Žð„Ì„ÏÀ —÷Ï„’ “‚ˆ«Ž˜—¯ CRM¼…˜” “‚ˆ«

                _Employee.RESET;
                _Employee.SETRANGE("Bef. No.", _Temp_Contract.l_damd);
                IF _Employee.FINDSET THEN BEGIN
                  _Contract."Litigation Employee No." := _Employee."No.";
                  _Contract."Litigation Employee Name" := _Employee.Name;
                END;
                */
                /*
                _Contract.VALIDATE("Cemetery Amount", _Temp_Contract.l_useamtw);
                _Contract.VALIDATE("General Amount", _Temp_Contract.l_yearamtw);
                //_Contract."Landscape Arc. Amount"
                _Contract.VALIDATE("Bury Amount", _Temp_Contract.l_jobamtw);
                */

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
                _Contract."Total Contract Amount" := _Temp_Contract.l_firstamtw;

                _Contract."Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";
                _Contract."Rece. Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";

                _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount"));


                //_Contract.VALIDATE("Contract Amount", _Temp_Contract.l_firstamtw);
                _Contract.Validate("Pay. Contract Rece. Date", ConvertDate(_Temp_Contract.l_firstdate));

                _Contract."Remaining Due Date" := ConvertDate(_Temp_Contract.l_lastdate);
                if _Contract."Remaining Due Date" <> 0D then begin
                    _Contract."Alarm Period 1" := CalcDate(FunctionSetup."Alarm period 1", _Contract."Remaining Due Date");
                    _Contract."Alarm Period 2" := CalcDate(FunctionSetup."Alarm period 2", _Contract."Remaining Due Date");
                end;

                if _Temp_Contract.l_tid = '‘ñ‚3‚‚-0274' then
                    _Contract.Validate("Remaining Receipt Date", 20160130D)
                else
                    _Contract.Validate("Remaining Receipt Date", ConvertDate(_Temp_Contract.l_lastindate));

                _Contract.Validate("CRM Funeral Service Code", _Temp_Contract.l_helpcd);


                _Contract."CRM Key" := _Temp_Contract.crm_key;

                //ŒÁ‰½ „Ì„ÏÀ
                if _Temp_Contract.m_manage <> '' then begin
                    _Employee.Reset;
                    _Employee.SetRange(Name, _Temp_Contract.m_manage);
                    if _Employee.FindSet then begin
                        _Contract."Litigation Employee No." := _Employee."No.";
                        _Contract."Litigation Employee Name" := _Employee.Name;
                    end;
                end;

                //ŒÁ‰½‹Ý•’
                if _Temp_Contract.m_state <> '' then begin
                    _LitigationStatus.Reset;
                    _LitigationStatus.SetRange(Type, _LitigationStatus.Type::LitigationStatus);
                    _LitigationStatus.SetRange(Name, _Temp_Contract.m_state);
                    if _LitigationStatus.FindSet then begin
                        _Contract."Litigation Status Code" := _LitigationStatus.Code;
                        _Contract."Litigation Status Name" := _LitigationStatus.Name;
                    end;
                end;

                //Œ­ŒÁ ‹Ý•’
                if _Temp_Contract.m_law <> '' then begin

                    _LitigationStatus.Reset;
                    _LitigationStatus.SetRange(Type, _LitigationStatus.Type::LawStatus);
                    _LitigationStatus.SetRange(Name, _Temp_Contract.m_law);
                    if _LitigationStatus.FindSet then begin
                        _Contract."Law Status Code" := _LitigationStatus.Code;
                        _Contract."Law Status Name" := _LitigationStatus.Name;
                    end;
                end;

                //—¹ŽÊ
                if _Temp_Contract.drop_yn = 'Y' then begin
                    _Contract.Status := _Contract.Status::Revocation;

                    _Contract."Revocation Date" := ConvertDate(_Temp_Contract.drop_date);

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_Contract.drop_damd);
                    if _Employee.FindSet then begin
                        _Contract."Revocation Employee No." := _Employee."No.";
                        _Contract."Revocation Employee Name" := _Employee.Name;
                    end;
                end else begin
                    _Contract.Status := _Contract.Status::FullPayment;
                    _Contract."Allow Membership Printing" := true;
                end;

                _Contract.IDX := _Temp_Contract.idx;
                _Contract.Insert(true);

                //Memo
                _Contract.SetWorkMemo(StrSubstNo(MSG001, _Temp_Contract.l_memo, _Temp_Contract.m_memo, _Temp_Contract.drop_memo));


            until _Temp_Contract.Next = 0;
        end;

    end;

    local procedure UploadContract(pDrop: Code[10])
    var
        _Temp_Contract: Record Temp_Contract;
        _Contract: Record DK_Contract;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Cemetery: Record DK_Cemetery;
        _Memo: Text;
        _Employee: Record DK_Employee;
        _Customer: Record DK_Customer;
        _MainIDX: Code[20];
        _SubCustomerNo: Code[20];
        _Contract1: Record DK_Contract;
        _LitigationStatus: Record "DK_Litigation Status";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Contract Nos.");
        /*
        //IF pDrop = 'N' THEN BEGIN
          _Contract.RESET;
          IF _Contract.FINDSET THEN
            _Contract.DELETEALL;
        
          _NoSeriesLine.RESET;
          _NoSeriesLine.SETRANGE("Series Code", _FunctionSetup."Contract Nos.");
          IF _NoSeriesLine.FINDSET THEN BEGIN
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.MODIFY;
          END;
        
          COMMIT;
        //END;
        */

        Window.Open('Processing  #1##############');

        _Temp_Contract.Reset;
        _Temp_Contract.SetCurrentKey(l_tid);
        _Temp_Contract.SetFilter(l_tid, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7',
                                      'test1', 'ˆ×í¼1-0000', 'ˆ×í¼2-0000', 'ˆ×í¼3-0000', 'ˆ×í¼4-0000', 'ˆ×í¼5-0000', '');
        //_Temp_Contract.SETRANGE(l_tid,'‘ñ‚-0948');

        if _Temp_Contract.FindSet then begin
            _MaxLoop := _Temp_Contract.Count;
            repeat
                Clear(_SubCustomerNo);
                Clear(_MainIDX);

                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                _Contract.Init;
                _Contract."No." := '';

                if _Temp_Contract.manage_no <> '0' then
                    _Contract."Supervise No." := _Temp_Contract.manage_no;

                _Contract."Contract Date" := ConvertDate(_Temp_Contract.m_date);
                _Contract."Management Unit" := 5;


                _Cemetery.Reset;
                _Cemetery.SetRange("Cemetery No.", _Temp_Contract.l_tid);
                if _Cemetery.FindSet then begin
                    if _Cemetery."Estate Name" in ['ˆ×í¼', 'ˆ×í¼2', 'ˆ×í¼3', 'ˆ×í¼4', 'ˆ×í¼4A', 'ˆ×í¼4B', 'ˆ×í¼5'] then begin
                        if _Temp_Contract.l_tid in ['ˆ×í¼1-0000', 'ˆ×í¼2-0000', 'ˆ×í¼3-0000', 'ˆ×í¼4-0000', 'ˆ×í¼5-0000'] then begin
                            _Contract."Contract Type" := _Contract."Contract Type"::Group;

                            case _Cemetery."Estate Name" of
                                'ˆ×í¼':
                                    begin
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                'ˆ×í¼2':
                                    begin
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                'ˆ×í¼3':
                                    begin
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                'ˆ×í¼4', 'ˆ×í¼4A', 'ˆ×í¼4B':
                                    begin
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                    end;
                                'ˆ×í¼5':
                                    begin
                                        _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
                                        _Contract."Management Unit" := 1;
                                        _Contract.Validate("Man. Fee Exemption Date", 20220906D);      //ˆÒ‘ª‘Ž‡ßŸÀ
                                        _Contract.Validate("Man. Fee hike Exemption Date", 20230906D); //ýˆ«Š±ž‹Ý‘Ž‡ßŸÀ
                                    end;
                            end;


                        end else begin
                            _Contract."Contract Type" := _Contract."Contract Type"::Sub;

                            case _Cemetery."Estate Name" of
                                'ˆ×í¼':
                                    begin
                                        _Contract1.Reset;
                                        _Contract1.SetRange("Cemetery No.", 'ˆ×í¼1-0000');
                                        if _Contract1.FindSet then begin
                                            _Contract.Validate("Group Contract No.", _Contract1."No.");
                                            _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                        end;
                                    end;
                                'ˆ×í¼2':
                                    begin
                                        _Contract1.Reset;
                                        _Contract1.SetRange("Cemetery No.", 'ˆ×í¼2-0000');
                                        if _Contract1.FindSet then begin
                                            _Contract.Validate("Group Contract No.", _Contract1."No.");
                                            _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                        end;
                                    end;
                                'ˆ×í¼3':
                                    begin

                                        _Contract1.Reset;
                                        _Contract1.SetRange("Cemetery No.", 'ˆ×í¼3-0000');
                                        if _Contract1.FindSet then begin
                                            _Contract.Validate("Group Contract No.", _Contract1."No.");
                                            _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                        end;
                                    end;
                                'ˆ×í¼4', 'ˆ×í¼4A', 'ˆ×í¼4B':
                                    begin

                                        _Contract1.Reset;
                                        _Contract1.SetRange("Cemetery No.", 'ˆ×í¼4-0000');
                                        if _Contract1.FindSet then begin
                                            _Contract.Validate("Group Contract No.", _Contract1."No.");
                                            _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                        end;
                                    end;
                                'ˆ×í¼5':
                                    begin
                                        _Contract1.Reset;
                                        _Contract1.SetRange("Cemetery No.", 'ˆ×í¼5-0000');
                                        if _Contract1.FindSet then begin
                                            _Contract.Validate("Group Contract No.", _Contract1."No.");
                                            _Contract.Validate("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
                                        end;
                                    end;
                            end;
                        end;
                    end;



                end;


                if (_Temp_Contract.l_contracter = '0') and
                   (_Temp_Contract.l_member1 = '0') and
                   (_Temp_Contract.l_member2 = '0') then begin
                    //Create
                    _Customer.Init;
                    _Customer."No." := '';
                    _Customer.Name := MSG002;
                    _Customer.Insert(true);

                    _Contract.Validate("Main Customer No.", _Customer."No.");
                end else begin

                    if _Temp_Contract.l_contracter <> '0' then begin
                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_contracter));
                        _MainIDX := _Temp_Contract.l_contracter;

                        case _Temp_Contract.i_member_gb of
                            '1':
                                begin
                                    if _Temp_Contract.l_member1 <> '0' then begin
                                        _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end else begin
                                        if _Temp_Contract.l_member2 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member2);
                                    end;
                                end;
                            '2':
                                begin

                                    if _Temp_Contract.l_member2 <> '0' then begin
                                        _SubCustomerNo := FindCustomer(_Temp_Contract.l_member2);
                                    end else begin
                                        if _Temp_Contract.l_member1 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end;
                                end;
                        end;

                    end else begin
                        case _Temp_Contract.i_member_gb of
                            '1':
                                begin
                                    if _Temp_Contract.l_member1 <> '0' then begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member1));
                                        _MainIDX := _Temp_Contract.l_member1;
                                        if _Contract."Main Customer Name" = '' then begin
                                            _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member2));
                                            _MainIDX := _Temp_Contract.l_member2;
                                        end;
                                    end else begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member2));
                                        _MainIDX := _Temp_Contract.l_member2;

                                        if _Temp_Contract.l_member2 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member2);
                                    end;
                                end;
                            '2':
                                begin
                                    if _Temp_Contract.l_member2 <> '0' then begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member2));
                                        _MainIDX := _Temp_Contract.l_member2;

                                        if _Contract."Main Customer Name" = '' then begin
                                            _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member1));
                                            _MainIDX := _Temp_Contract.l_member1;
                                        end;
                                    end else begin
                                        _Contract.Validate("Main Customer No.", FindCustomer(_Temp_Contract.l_member1));
                                        _MainIDX := _Temp_Contract.l_member1;

                                        if _Temp_Contract.l_member1 <> '0' then
                                            _SubCustomerNo := FindCustomer(_Temp_Contract.l_member1);
                                    end;
                                end;
                        end;
                    end;


                    //°…ˆ×— “‚ˆ«
                    if _MainIDX <> '0' then begin
                        _Customer.Reset;
                        _Customer.SetRange(Idx, _MainIDX);
                        _Customer.SetFilter("No.", '<>%1', _Contract."Main Customer No.");
                        if _Customer.FindSet then begin
                            repeat
                                if _Contract."Customer No. 2" = '' then
                                    _Contract.Validate("Customer No. 2", _Customer."No.")
                                else
                                    _Contract.Validate("Customer No. 3", _Customer."No.");
                            until _Customer.Next = 0;
                        end;
                    end;
                end;

                //ýÐž
                if _SubCustomerNo <> '' then begin
                    if _Customer.Get(_SubCustomerNo) then begin
                        _Contract."Associate Name" := _Customer.Name;
                        _Contract."Associate Mobile No." := _Customer."Mobile No.";
                        _Contract."Associate Phone No." := _Customer."Phone No.";
                        _Contract."Associate E-Mail" := _Customer."E-mail";
                        _Contract."Associate Post Code" := _Customer."Post Code";
                        _Contract."Associate Address" := _Customer.Address;
                        _Contract."Associate Address 2" := _Customer."Address 2";
                    end;
                end;

                _Cemetery.Reset;
                _Cemetery.SetRange("Cemetery No.", _Temp_Contract.l_tid);
                if not _Cemetery.FindSet then begin
                    _Contract."Cemetery Code" := '';
                    _Contract."Cemetery No." := _Temp_Contract.l_tid;
                end else begin
                    _Contract."Cemetery Code" := _Cemetery."Cemetery Code";
                    _Contract."Cemetery No." := _Cemetery."Cemetery No.";
                end;

                _Contract."General Start Date" := ConvertDate(_Temp_Contract.m_first);
                _Contract."General Expiration Date" := ConvertDate(_Temp_Contract.m_start);
                _Contract."Land. Arc. Expiration Date" := ConvertDate(_Temp_Contract.m_start_stone);

                case _Temp_Contract.m_levelcd of
                    '111':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                    '121':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                    '131':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                    '141':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::D;
                    '151':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::E;
                    '161':
                        _Contract."Litigation Evaluation" := _Contract."Litigation Evaluation"::F;
                end;

                /*…Žð„Ì„ÏÀ —÷Ï„’ “‚ˆ«Ž˜—¯ CRM¼…˜” “‚ˆ«
                _Employee.RESET;
                _Employee.SETRANGE("Bef. No.", _Temp_Contract.l_damd);
                IF _Employee.FINDSET THEN BEGIN
                  _Contract."Litigation Employee No." := _Employee."No.";
                  _Contract."Litigation Employee Name" := _Employee.Name;
                END;
                */
                /*
                _Contract.VALIDATE("Cemetery Amount", _Temp_Contract.l_useamtw);
                _Contract.VALIDATE("General Amount", _Temp_Contract.l_yearamtw);
                //_Contract."Landscape Arc. Amount"
                _Contract.VALIDATE("Bury Amount", _Temp_Contract.l_jobamtw);
                */

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
                _Contract."Total Contract Amount" := _Temp_Contract.l_firstamtw;

                _Contract."Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";
                _Contract."Rece. Remaining Amount" := _Contract."Payment Amount" - _Contract."Contract Amount";

                _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount"));


                //_Contract.VALIDATE("Contract Amount", _Temp_Contract.l_firstamtw);
                _Contract.Validate("Pay. Contract Rece. Date", ConvertDate(_Temp_Contract.l_firstdate));

                _Contract."Remaining Due Date" := ConvertDate(_Temp_Contract.l_lastdate);
                if _Contract."Remaining Due Date" <> 0D then begin
                    _Contract."Alarm Period 1" := CalcDate(FunctionSetup."Alarm period 1", _Contract."Remaining Due Date");
                    _Contract."Alarm Period 2" := CalcDate(FunctionSetup."Alarm period 2", _Contract."Remaining Due Date");
                end;

                if _Temp_Contract.l_tid = '‘ñ‚3‚‚-0274' then
                    _Contract.Validate("Remaining Receipt Date", 20160130D)
                else
                    _Contract.Validate("Remaining Receipt Date", ConvertDate(_Temp_Contract.l_lastindate));

                _Contract.Validate("CRM Funeral Service Code", _Temp_Contract.l_helpcd);


                _Contract."CRM Key" := _Temp_Contract.crm_key;

                //ŒÁ‰½ „Ì„ÏÀ
                if _Temp_Contract.m_manage <> '' then begin
                    _Employee.Reset;
                    _Employee.SetRange(Name, _Temp_Contract.m_manage);
                    if _Employee.FindSet then begin
                        _Contract."Litigation Employee No." := _Employee."No.";
                        _Contract."Litigation Employee Name" := _Employee.Name;
                    end;
                end;

                //ŒÁ‰½‹Ý•’
                if _Temp_Contract.m_state <> '' then begin
                    _LitigationStatus.Reset;
                    _LitigationStatus.SetRange(Type, _LitigationStatus.Type::LitigationStatus);
                    _LitigationStatus.SetRange(Name, _Temp_Contract.m_state);
                    if _LitigationStatus.FindSet then begin
                        _Contract."Litigation Status Code" := _LitigationStatus.Code;
                        _Contract."Litigation Status Name" := _LitigationStatus.Name;
                    end;
                end;

                //Œ­ŒÁ ‹Ý•’
                if _Temp_Contract.m_law <> '' then begin

                    _LitigationStatus.Reset;
                    _LitigationStatus.SetRange(Type, _LitigationStatus.Type::LawStatus);
                    _LitigationStatus.SetRange(Name, _Temp_Contract.m_law);
                    if _LitigationStatus.FindSet then begin
                        _Contract."Law Status Code" := _LitigationStatus.Code;
                        _Contract."Law Status Name" := _LitigationStatus.Name;
                    end;
                end;

                //—¹ŽÊ
                if _Temp_Contract.drop_yn = 'Y' then begin
                    _Contract.Status := _Contract.Status::Revocation;

                    _Contract."Revocation Date" := ConvertDate(_Temp_Contract.drop_date);

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_Contract.drop_damd);
                    if _Employee.FindSet then begin
                        _Contract."Revocation Employee No." := _Employee."No.";
                        _Contract."Revocation Employee Name" := _Employee.Name;
                    end;
                end else begin
                    _Contract.Status := _Contract.Status::FullPayment;
                    _Contract."Allow Membership Printing" := true;
                end;

                _Contract.IDX := _Temp_Contract.idx;
                _Contract.Insert(true);

                //Memo
                _Contract.SetWorkMemo(StrSubstNo(MSG001, _Temp_Contract.l_memo, _Temp_Contract.m_memo, _Temp_Contract.drop_memo));


            until _Temp_Contract.Next = 0;
        end;
        Window.Close;

    end;


    procedure UploadCorpse()
    var
        _Corpse: Record DK_Corpse;
        _Corpse2: Record DK_Corpse;
        _Temp_Corpse: Record Temp_Corpse;
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _SSN: Text[20];
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _Gender: Integer;
        _BeforCemNo: Text[20];
        _NewName1: Text[20];
        _NewName2: Text[20];
        _NewName3: Text[20];
        _Gender2: Option;
        _Gender3: Option;
        _ContractNo: Code[20];
    begin

        _Corpse.Reset;
        if _Corpse.FindSet then
            _Corpse.DeleteAll;


        _Temp_Corpse.Reset;
        _Temp_Corpse.SetCurrentKey(m_id, t_bdate1);
        //_Temp_Corpse.SETRANGE(m_id,'63-10-0160');
        if _Temp_Corpse.FindSet then begin
            repeat
                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_Corpse.m_id);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_Corpse.m_id);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;


                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin


                    if _BeforCemNo <> _Temp_Corpse.m_id then
                        _NewLineNo := 1
                    else
                        _NewLineNo += 1;

                    Clear(_Gender2);
                    Clear(_Gender3);

                    Clear(_NewName1);
                    Clear(_NewName2);
                    Clear(_NewName3);
                    if (StrPos(_Temp_Corpse.t_name1, ',') <> 0) then begin
                        if _Temp_Corpse.t_name1 = '—(€ñ‹Ó€ÐŽŽ,5„Ô‘†ˆÚ)' then
                            _NewName1 := _Temp_Corpse.t_name1
                        else
                            SplitName(_Temp_Corpse.t_name1, _NewName1, _NewName2, _NewName3);
                    end else begin
                        _NewName1 := _Temp_Corpse.t_name1;
                    end;

                    _Corpse.Init;
                    _Corpse."Contract No." := _Contract."No.";
                    _Corpse."Line No." := _NewLineNo;
                    _Corpse."Supervise No." := _Contract."Supervise No.";
                    _Corpse."Cemetery Code" := _Contract."Cemetery Code";
                    _Corpse."Cemetery No." := _Contract."Cemetery No.";
                    _Corpse.Name := _NewName1;


                    _SSN := DelChr(_Temp_Corpse.t_reg1, '=', ' ');
                    _SSN := DelChr(_SSN, '=', '-');

                    if (_SSN <> '') and (StrLen(_SSN) = 13) then begin
                        Clear(_CommFun);
                        _Corpse."Social Security No." := _Temp_Corpse.t_reg1;

                        if _CommFun.CheckDigitSSNo(_Corpse."Social Security No.") then begin

                            _Corpse."Social Security No." := ConvertStr(_Corpse."Social Security No.", ' ', '-');

                            Evaluate(_Year, CopyStr(_Corpse."Social Security No.", 1, 2));
                            Evaluate(_Month, CopyStr(_Corpse."Social Security No.", 3, 2));
                            Evaluate(_Day, CopyStr(_Corpse."Social Security No.", 5, 2));

                            Evaluate(_Gender, CopyStr(_SSN, 7, 1));
                            case _Gender of
                                1, 2, 5, 6:
                                    _Year += 1900;
                                3, 4, 7, 8:
                                    _Year += 2000;
                                9, 0:
                                    _Year += 1800;
                            end;

                            _AlDay := Date2DMY(CalcDate('<+CM>', (DMY2Date(1, _Month, _Year))), 1);

                            if _AlDay >= _Day then begin

                                _Corpse."Date Of Birth" := DMY2Date(_Day, _Month, _Year);

                                case _Gender of
                                    1, 3, 5, 7, 9:
                                        _Corpse.Gender := _Corpse.Gender::Male;
                                    2, 4, 6, 8, 0:
                                        _Corpse.Gender := _Corpse.Gender::Female;
                                end;
                            end else begin
                                if _Corpse."Social Security No." <> '' then begin
                                    if _Corpse."Invalid data" = '' then
                                        _Corpse."Invalid data" := '‘´‰ž…Ø‡Ÿ‰°˜ú ‡õ:' + _Corpse."Social Security No."
                                    else
                                        _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + '‘´‰ž…Ø‡Ÿ‰°˜ú ‡õ:' + _Corpse."Social Security No.";

                                    _Corpse."Social Security No." := '';
                                    GetGender(_Temp_Corpse, _Corpse.Gender, _Gender2, _Gender3);
                                end;
                            end;
                        end else begin
                            if _Temp_Corpse.t_reg1 <> '' then begin
                                if _Corpse."Invalid data" = '' then
                                    _Corpse."Invalid data" := '‘´‰ž…Ø‡Ÿ‰°˜ú ‡õ:' + _Temp_Corpse.t_reg1
                                else
                                    _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + '‘´‰ž…Ø‡Ÿ‰°˜ú ‡õ:' + _Temp_Corpse.t_reg1;

                                _Corpse."Social Security No." := '';
                                GetGender(_Temp_Corpse, _Corpse.Gender, _Gender2, _Gender3);
                            end;
                        end;
                    end else begin
                        if _Temp_Corpse.t_reg1 <> '' then begin

                            if _Corpse."Invalid data" = '' then
                                _Corpse."Invalid data" := '‘´‰ž…Ø‡Ÿ‰°˜ú ‡õ:' + _Temp_Corpse.t_reg1
                            else
                                _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + '‘´‰ž…Ø‡Ÿ‰°˜ú ‡õ:' + _Temp_Corpse.t_reg1;

                            _Corpse."Social Security No." := '';
                            GetGender(_Temp_Corpse, _Corpse.Gender, _Gender2, _Gender3);
                        end;
                    end;

                    _Corpse."Post Code" := _Temp_Corpse.t_post1;
                    _Corpse.Address := _Temp_Corpse.t_addr1;
                    _Corpse."Address 2" := _Temp_Corpse.t_address1;


                    _Temp_Corpse.t_ddate1 := DelChr(_Temp_Corpse.t_ddate1, '=', ' ');
                    if _Temp_Corpse.t_ddate1 <> '' then
                        if StrLen(_Temp_Corpse.t_ddate1) <> 8 then begin
                            if _Corpse."Invalid data" = '' then
                                _Corpse."Invalid data" := '‹Ïˆ‘Ÿ ‡õ:' + _Temp_Corpse.t_ddate1
                            else
                                _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + '‹Ïˆ‘Ÿ ‡õ:' + _Temp_Corpse.t_ddate1;
                        end else begin
                            if CheckDate(_Temp_Corpse.t_ddate1) then begin
                                _Corpse."Death Date" := ConvertDate(_Temp_Corpse.t_ddate1)
                            end else begin
                                if _Corpse."Invalid data" = '' then
                                    _Corpse."Invalid data" := '‹Ïˆ‘Ÿ ‡õ:' + _Temp_Corpse.t_ddate1
                                else
                                    _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + '‹Ïˆ‘Ÿ ‡õ:' + _Temp_Corpse.t_ddate1;
                            end;
                        end;

                    _Temp_Corpse.t_bdate1 := DelChr(_Temp_Corpse.t_bdate1, '=', ' ');
                    if _Temp_Corpse.t_bdate1 <> '' then
                        if StrLen(_Temp_Corpse.t_bdate1) <> 8 then begin
                            if _Corpse."Invalid data" = '' then
                                _Corpse."Invalid data" := 'Œ‚‰ªŸ ‡õ:' + _Temp_Corpse.t_bdate1
                            else
                                _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + 'Œ‚‰ªŸ ‡õ:' + _Temp_Corpse.t_bdate1;
                        end else begin
                            if CheckDate(_Temp_Corpse.t_bdate1) then begin
                                _Corpse."Laying Date" := ConvertDate(_Temp_Corpse.t_bdate1);
                            end else begin
                                if _Corpse."Invalid data" = '' then
                                    _Corpse."Invalid data" := 'Œ‚‰ªŸ ‡õ:' + _Temp_Corpse.t_bdate1
                                else
                                    _Corpse."Invalid data" := _Corpse."Invalid data" + ' ' + 'Œ‚‰ªŸ ‡õ:' + _Temp_Corpse.t_bdate1;
                            end;
                        end;

                    _Corpse."Death Cause" := _Temp_Corpse.t_dway1;
                    _Corpse."Death Place" := _Temp_Corpse.t_dwhere1;
                    _Corpse.Relationship := _Temp_Corpse.t_relate1;
                    _Corpse.Remark := _Temp_Corpse.t_memo;

                    _Corpse.Idx := _Temp_Corpse.idx;
                    if _Contract.Status = _Contract.Status::Revocation then begin
                        _Corpse."Move The Grave Type" := true;
                        _Corpse."Move The Grave Date" := _Contract."Revocation Date";
                    end;
                    _Corpse.Insert(false);


                    if _NewName2 <> '' then begin
                        _NewLineNo += 1;
                        _Corpse2.Init;
                        _Corpse2.TransferFields(_Corpse);
                        _Corpse2."Line No." := _NewLineNo;
                        _Corpse2.Name := _NewName2;
                        _Corpse2."Social Security No." := '';
                        _Corpse2.Gender := _Gender2;
                        if _Contract.Status = _Contract.Status::Revocation then begin
                            _Corpse2."Move The Grave Type" := true;
                            _Corpse2."Move The Grave Date" := _Contract."Revocation Date";
                        end;
                        _Corpse2.Insert(false);
                    end;

                    if _NewName3 <> '' then begin
                        _NewLineNo += 1;
                        _Corpse2.Init;
                        _Corpse2.TransferFields(_Corpse);
                        _Corpse2."Line No." := _NewLineNo;
                        _Corpse2.Name := _NewName3;
                        _Corpse2."Social Security No." := '';
                        _Corpse2.Gender := _Gender3;
                        if _Contract.Status = _Contract.Status::Revocation then begin
                            _Corpse2."Move The Grave Type" := true;
                            _Corpse2."Move The Grave Date" := _Contract."Revocation Date";
                        end;
                        _Corpse2.Insert(false);
                    end;

                    _BeforCemNo := _Temp_Corpse.m_id;

                end;

            until _Temp_Corpse.Next = 0;

        end;
    end;


    procedure UploadContract_Relate()
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _RelationshipFamily: Record "DK_Relationship Family";
        _Temp_ContractRelate: Record Temp_Contract_Relate;
        _BeforCemNo: Text[30];
        _Employee: Record DK_Employee;
        _ContractNo: Code[20];
    begin

        _RelationshipFamily.Reset;
        if _RelationshipFamily.FindSet then
            _RelationshipFamily.DeleteAll;

        _Temp_ContractRelate.Reset;
        _Temp_ContractRelate.SetCurrentKey(mr_id);
        if _Temp_ContractRelate.FindSet then begin
            repeat

                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_ContractRelate.mr_id);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_ContractRelate.mr_id);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;


                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin
                    if _BeforCemNo <> _Temp_ContractRelate.mr_id then
                        _NewLineNo := 1
                    else
                        _NewLineNo += 1;

                    _RelationshipFamily.Init;
                    _RelationshipFamily."Contract No." := _Contract."No.";
                    _RelationshipFamily."Line No." := _NewLineNo;
                    _RelationshipFamily."Supervise No." := _Contract."Supervise No.";
                    _RelationshipFamily."Cemetery Code" := _Contract."Cemetery Code";
                    _RelationshipFamily."Cemetery No." := _Contract."Cemetery No.";

                    _RelationshipFamily.Name := _Temp_ContractRelate.mr_name;
                    _RelationshipFamily.Relationship := _Temp_ContractRelate.mr_relate;
                    _RelationshipFamily."Post Code" := _Temp_ContractRelate.mr_post;
                    _RelationshipFamily.Address := CopyStr(_Temp_ContractRelate.mr_addr, 1, 50);
                    _RelationshipFamily."Address 2" := CopyStr(_Temp_ContractRelate.mr_address, 1, 50);
                    _RelationshipFamily."Phone No." := _Temp_ContractRelate.mr_tel;
                    _RelationshipFamily."Mobile No." := _Temp_ContractRelate.mr_phone;


                    Evaluate(_RelationshipFamily."Creation Date", _Temp_ContractRelate.altdate);
                    Evaluate(_RelationshipFamily."Last Date Modified", _Temp_ContractRelate.altdate);

                    _RelationshipFamily."Receipt Date" := DT2Date(_RelationshipFamily."Creation Date");
                    if _RelationshipFamily."Receipt Date" = 20000101D then
                        _RelationshipFamily."Receipt Date" := 0D;


                    if StrPos(_Temp_ContractRelate.mr_email, '@') = 0 then begin
                        if _RelationshipFamily.Remark = '' then
                            _RelationshipFamily.Remark := _Temp_ContractRelate.mr_email
                        else
                            _RelationshipFamily.Remark := _RelationshipFamily.Remark + ' ' + _Temp_ContractRelate.mr_email;
                    end else begin
                        _RelationshipFamily."E-mail" := _Temp_ContractRelate.mr_email;
                    end;

                    if _Temp_ContractRelate.mr_useyn = 'Y' then
                        _RelationshipFamily.Used := true
                    else
                        _RelationshipFamily.Used := false;

                    if _Temp_ContractRelate.mr_lastaccess <> '' then
                        Evaluate(_RelationshipFamily."Last Access Date", _Temp_ContractRelate.mr_lastaccess);

                    _RelationshipFamily.IDX := _Temp_ContractRelate.idx;
                    _RelationshipFamily.Insert;

                    _BeforCemNo := _Temp_ContractRelate.mr_id;
                end;
            until _Temp_ContractRelate.Next = 0;

        end;
    end;


    procedure UploadContractAmount()
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _BeforCemNo: Text[30];
        _Employee: Record DK_Employee;
        _Modifydate: Text[10];
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _ContractAmountLedger: Record "DK_Contract Amount Ledger";
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    begin
        /*
        _PayReceiptDoc.RESET;
        _PayReceiptDoc.SETRANGE("Missing Contract",FALSE);
        IF _PayReceiptDoc.FINDSET THEN BEGIN
          _PayReceiptDoc.DELETEALL(TRUE);
        END;
        
        _FunctionSetup.GET;
        _FunctionSetup.TESTFIELD("Payment Receipt Nos.");
        
        _NoSeriesLine.RESET;
        _NoSeriesLine.SETRANGE("Series Code", _FunctionSetup."Payment Receipt Nos.");
        IF _NoSeriesLine.FINDSET THEN BEGIN
          _NoSeriesLine."Last No. Used" := '';
          _NoSeriesLine.MODIFY;
        END;
        
        COMMIT;
        */

        _Contract.Reset;
        _Contract.SetFilter("Payment Amount", '<>%1', 0);
        if _Contract.FindSet then begin
            repeat

                if (_Contract."Contract Amount" <> 0) then begin

                    _PayReceiptDoc.Init;
                    _PayReceiptDoc."Document No." := '';
                    _PayReceiptDoc."Document Type" := _PayReceiptDoc."Document Type"::Receipt;
                    _PayReceiptDoc."Posting Date" := _Contract."Pay. Contract Rece. Date";
                    _PayReceiptDoc."Payment Date" := _Contract."Pay. Contract Rece. Date";
                    _PayReceiptDoc."Payment Type" := _PayReceiptDoc."Payment Type"::Bank;
                    _PayReceiptDoc.Amount := _Contract."Contract Amount";
                    _PayReceiptDoc.Description := '—‘„¸ …Ñœ• ÐŽÊý‡“';
                    _PayReceiptDoc."Contract No." := _Contract."No.";

                    _PayReceiptDoc."Supervise No." := _Contract."Supervise No.";
                    _PayReceiptDoc."Cemetery Code" := _Contract."Cemetery Code";
                    _PayReceiptDoc."Cemetery No." := _Contract."Cemetery No.";
                    _PayReceiptDoc."Main Customer Name" := _Contract."Main Customer Name";
                    _PayReceiptDoc.Posted := true;
                    _PayReceiptDoc.Insert(true);

                    _PayReceiptDoc."Posting Date" := _Contract."Pay. Contract Rece. Date";
                    _PayReceiptDoc.Modify;

                    _PayReceiptDocLine.Init;
                    _PayReceiptDocLine."Document No." := _PayReceiptDoc."Document No.";
                    _PayReceiptDocLine."Line No." := 1;
                    _PayReceiptDocLine."Payment Target" := _PayReceiptDocLine."Payment Target"::Contract;
                    _PayReceiptDocLine.Amount := _Contract."Contract Amount";
                    _PayReceiptDocLine.Remark := '—‘„¸ …Ñœ• ÐŽÊý‡“';
                    _PayReceiptDocLine.Insert(true);

                    _ContractAmountLedger.Init;
                    _ContractAmountLedger."Contract No." := _Contract."No.";
                    _ContractAmountLedger."Line No." := 1;
                    _ContractAmountLedger.Type := _ContractAmountLedger.Type::Contract;
                    _ContractAmountLedger."Ledger Type" := _ContractAmountLedger."Ledger Type"::Receipt;
                    _ContractAmountLedger.Date := _Contract."Pay. Contract Rece. Date";
                    _ContractAmountLedger.Amount := _Contract."Contract Amount";
                    _ContractAmountLedger."Source No." := _PayReceiptDoc."Document No.";
                    _ContractAmountLedger."Source Line No." := 1;
                    _ContractAmountLedger.Insert;
                end;

                if (_Contract."Rece. Remaining Amount" <> 0) then begin


                    _PayReceiptDoc.Init;
                    _PayReceiptDoc."Document No." := '';
                    _PayReceiptDoc."Document Type" := _PayReceiptDoc."Document Type"::Receipt;
                    _PayReceiptDoc."Posting Date" := _Contract."Remaining Receipt Date";
                    _PayReceiptDoc."Payment Date" := _Contract."Remaining Receipt Date";
                    _PayReceiptDoc."Payment Type" := _PayReceiptDoc."Payment Type"::Bank;
                    _PayReceiptDoc.Amount := _Contract."Rece. Remaining Amount";
                    _PayReceiptDoc.Description := '—‘„¸ …Ñœ• ÐŽÊý‡“';

                    _PayReceiptDoc."Contract No." := _Contract."No.";

                    _PayReceiptDoc."Supervise No." := _Contract."Supervise No.";
                    _PayReceiptDoc."Cemetery Code" := _Contract."Cemetery Code";
                    _PayReceiptDoc."Cemetery No." := _Contract."Cemetery No.";
                    _PayReceiptDoc."Main Customer Name" := _Contract."Main Customer Name";
                    _PayReceiptDoc.Posted := true;
                    _PayReceiptDoc.Insert(true);

                    _PayReceiptDoc."Posting Date" := _Contract."Pay. Contract Rece. Date";
                    _PayReceiptDoc.Modify;

                    _PayReceiptDocLine.Init;
                    _PayReceiptDocLine."Document No." := _PayReceiptDoc."Document No.";
                    _PayReceiptDocLine."Line No." := 2;
                    _PayReceiptDocLine."Payment Target" := _PayReceiptDocLine."Payment Target"::Remaining;
                    _PayReceiptDocLine.Amount := _Contract."Rece. Remaining Amount";
                    _PayReceiptDocLine.Remark := '—‘„¸ …Ñœ• ÐŽÊý‡“';
                    _PayReceiptDocLine.Insert(true);

                    _ContractAmountLedger.Init;
                    _ContractAmountLedger."Contract No." := _Contract."No.";
                    _ContractAmountLedger."Line No." := 2;
                    _ContractAmountLedger.Type := _ContractAmountLedger.Type::Remaining;
                    _ContractAmountLedger."Ledger Type" := _ContractAmountLedger."Ledger Type"::Receipt;
                    _ContractAmountLedger.Date := _Contract."Remaining Receipt Date";
                    _ContractAmountLedger.Amount := _Contract."Rece. Remaining Amount";
                    _ContractAmountLedger."Source No." := _PayReceiptDoc."Document No.";
                    _ContractAmountLedger."Source Line No." := 2;
                    _ContractAmountLedger.Insert;

                end;
            until _Contract.Next = 0;

        end;

    end;


    procedure UploadMoney()
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _BeforCemNo: Text[30];
        _Employee: Record DK_Employee;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _Temp_Money: Record Temp_Money;
        _Modifydate: Text[10];
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _ContractNo: Code[20];
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
    begin
        /*
        _PayReceiptDoc.RESET;
        _PayReceiptDoc.SETRANGE("Missing Contract",FALSE);
        IF _PayReceiptDoc.FINDSET THEN BEGIN
          _PayReceiptDoc.DELETEALL(TRUE);
        END;
        
        _FunctionSetup.GET;
        _FunctionSetup.TESTFIELD("Payment Receipt Nos.");
        
        _NoSeriesLine.RESET;
        _NoSeriesLine.SETRANGE("Series Code", _FunctionSetup."Payment Receipt Nos.");
        IF _NoSeriesLine.FINDSET THEN BEGIN
          _NoSeriesLine."Last No. Used" := '';
          _NoSeriesLine.MODIFY;
        END;
        
        COMMIT;
        */
        _Temp_Money.Reset;
        _Temp_Money.SetCurrentKey(m_id, a_indate);
        if _Temp_Money.FindSet then begin
            repeat


                //_Contract.RESET;
                //_Contract.SETRANGE("Cemetery No.", _Temp_Money.m_id);


                if _BeforCemNo <> _Temp_Money.m_id then
                    _NewLineNo := 1
                else
                    _NewLineNo += 1;

                _PayReceiptDoc.Init;
                _PayReceiptDoc."Document No." := '';

                case _Temp_Money.a_confirm of
                    '“ÔŒ­':
                        begin
                            _PayReceiptDoc."Document Type" := _PayReceiptDoc."Document Type"::Refund;
                        end;
                    else begin
                        _PayReceiptDoc."Document Type" := _PayReceiptDoc."Document Type"::Receipt;
                    end;
                end;

                if _Temp_Money.a_indate <> '' then begin
                    if DelChr(_Temp_Money.a_indate, '=', ' ') = '1997' then _Temp_Money.a_indate := '19970101';
                    if _Temp_Money.a_indate = '09920523' then _Temp_Money.a_indate := '19920523';

                    if CheckDate(_Temp_Money.a_indate) then begin
                        _PayReceiptDoc."Payment Date" := ConvertDate(_Temp_Money.a_indate);
                    end else
                        Error('¯€¦Ÿ ‡õ : %1', _Temp_Money.a_indate);
                end else begin
                    if _Temp_Money.a_sdate = '19851205' then begin
                        _PayReceiptDoc."Payment Date" := 19851205D;

                    end else
                        Error('¯€¦Ÿ ŠÝ¬');
                end;

                _PayReceiptDoc."Posting Date" := _PayReceiptDoc."Payment Date";

                _PayReceiptDoc.Depositor := _Temp_Money.a_ipkmnm;

                if _Temp_Money.a_cmoney = 0 then begin
                    //“ñ‰½•‘¿
                    _PayReceiptDoc."Payment Type" := _PayReceiptDoc."Payment Type"::DebtRelief;
                end else begin
                    case _Temp_Money.a_itype of
                        '', 'Š¨—­‚‚Šž', 'Œ¡Ù‹Ï‰½Œ­', '—÷€¦':
                            begin
                                _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::Cash);
                            end;
                        '’†Ýž”½…Î':
                            begin
                                _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::OnlineCard);

                                case DelChr(_Temp_Money.a_iway, '=', ' ') of
                                    'BC”½…Î', 'Š±ŽŽ', 'Š±ŽŽMASTER', 'Š±ŽŽVISA', 'Õˆ«(–Û˜¡)”½…Î':
                                        begin//BC”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A001');
                                        end;
                                    'NH', 'NHMASTER', 'NHVISA', 'NH”½…Î':
                                        begin//NH”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A009');
                                        end;
                                    'KB”½…Î', '€‰‰ž', '€‰‰žJCB', '€‰‰žMASTER', '€‰‰žVISA':
                                        begin//€‰‰ž”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A002');
                                        end;
                                    '‡¯…Ñ', '‡¯…ÑAMEX', '‡¯…ÑMASTER', '‡¯…ÑVISA', '‡¯…Ñ”½…Î':
                                        begin//‡¯…Ñ”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A006');
                                        end;
                                    '‹ÙŒŠ', '‹ÙŒŠAMEX', '‹ÙŒŠMASTER', '‹ÙŒŠVISA', '‹ÙŒŠ”½…Î':
                                        begin//‹ÙŒŠ”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A010');
                                        end;
                                    '•—©', '•—©AMEX', '•—©CUP', '•—©JCB', '•—©MASTER', '•—©VISA', '•—©”½…Î':
                                        begin//•—©”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A003');
                                        end;
                                    'ŽŽ–Œ(—©‰œ)”½…Î', 'ŽŽ–ŒMASTER', 'ŽŽ–ŒVISA', 'ŽŽ–Œ':
                                        begin//ŽŽ–Œ”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A005');
                                        end;
                                    'Â˜»', 'Â˜»AMEX', 'Â˜»MASTER', 'Â˜»VISA', 'Â˜»”½…Î':
                                        begin//Â˜»”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A004');
                                        end;
                                    '—Ÿ‚¬', '—Ÿ‚¬AMEX', '—Ÿ‚¬MASTER', '—Ÿ‚¬VISA', '—Ÿ‚¬”½…Î':
                                        begin//—Ÿ‚¬”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A011');
                                        end;
                                    '—÷„Ô', '—÷„ÔMASTER', '—÷„ÔVISA', '—÷„Ô”½…Î':
                                        begin//—÷„Ô”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A007');
                                        end;
                                    '€Ë•ˆ', 'ýŠŸ', '€ñ‘´VISA':
                                        begin//€Ë•ˆ
                                            _PayReceiptDoc.Validate("Payment Method Code", 'A999');
                                        end;
                                    else
                                        Error('€ˆŠ¨…—‘÷ ŽšŠ ’‡žž”½…Î ß‘ª Œ÷„Â : %1', _Temp_Money.a_iway);
                                end;

                            end;
                        '”½…Î':
                            begin
                                _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::Card);

                                case DelChr(_Temp_Money.a_iway, '=', ' ') of
                                    'BC”½…Î', 'Š±ŽŽ', '€ËŽðŠ—ÊŠ±ŽŽ', 'Š±ŽŽMASTER', 'Š±ŽŽVISA', '€ËŽðŠ—Ê':
                                        begin//BC”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B001');
                                        end;
                                    'NH', 'NHJCB', 'NHMASTER', 'NH”½…Î', '‚Ý—õ':
                                        begin//NH”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B009');
                                        end;
                                    'SC”½…Î':
                                        begin//SC”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B008');
                                        end;
                                    '€‰‰ž', '€‰‰žMASTER', '€‰‰žVISA', '€‰‰ž”½…Î':
                                        begin//€‰‰ž”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B002');
                                        end;
                                    '‡¯…Ñ', '‡¯…ÑMASTER', '‡¯…ÑVISA', '‡¯…Ñ”½…Î':
                                        begin//‡¯…Ñ”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B006');
                                        end;
                                    '‹ÙŒŠ', '‹ÙŒŠAMEX', '‹ÙŒŠMASTER', '‹ÙŒŠVISA', '‹ÙŒŠ”½…Î':
                                        begin//‹ÙŒŠ”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B010');
                                        end;
                                    '•—©', '•—©AMEX', '•—©CUP', '•—©JCB', '•—©MASTER', '•—©VISA', '•—©”½…Î':
                                        begin//•—©”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B003');
                                        end;
                                    'ŽŽ–ŒVISA', 'ŽŽ–Œ•ŒŒÐVISA', 'ŽŽ–Œ”½…Î', 'ŽŽ–Œ':
                                        begin//ŽŽ–Œ”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B005');
                                        end;
                                    'Â˜»', 'Â˜»AMEX', 'Â˜»MASTER', 'Â˜»VISA', 'Â˜»”½…Î':
                                        begin//Â˜»”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B004');
                                        end;
                                    '—Ÿ‚¬', '—Ÿ‚¬AMEX', '—Ÿ‚¬MASTER', '—Ÿ‚¬VISA', '—Ÿ‚¬”½…Î':
                                        begin//—Ÿ‚¬”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B011');
                                        end;
                                    '—÷„Ô', '—÷„ÔDINERS', '—÷„ÔMASTER', '—÷„ÔVISA', '—÷„Ô”½…Î':
                                        begin//—÷„Ô”½…Î
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B007');
                                        end;
                                    '‘÷‡ž':
                                        begin//‘÷‡ž”½…Î
                                            _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::Giro);
                                            _PayReceiptDoc.Validate("Payment Method Code", 'C002');
                                        end;
                                    '', '€Ë•ˆ', '‘ª‘´':
                                        begin//€Ë•ˆ
                                            _PayReceiptDoc.Validate("Payment Method Code", 'B999');
                                        end;
                                    else
                                        Error('€ˆŠ¨…—‘÷ ŽšŠ ”½…Î ß‘ª Œ÷„Â %1', _Temp_Money.a_iway);
                                end;
                            end;
                        'ŒÁ€¦':
                            begin
                                _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::Bank);

                                if _Temp_Money.a_iway = '€ËŽðŠ—Ê' then
                                    _PayReceiptDoc.Validate("Bank Account Code", 'BA002')
                                else
                                    _PayReceiptDoc.Validate("Bank Account Code", 'BA001');
                            end;
                        '‘÷‡ž”½…Î':
                            begin
                                _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::Giro);
                                _PayReceiptDoc.Validate("Payment Method Code", 'C002');
                            end;
                        '‘÷‡ž':
                            begin
                                _PayReceiptDoc."Payment Type" := _PayReceiptDoc."Payment Type"::Giro;

                                if _Temp_Money.a_iway = '‘÷‡ž”½…Î' then
                                    _PayReceiptDoc.Validate("Payment Method Code", 'C002')
                                else
                                    _PayReceiptDoc.Validate("Payment Method Code", 'C001');
                            end;
                        else
                            Error('€ˆŠ¨…—‘÷ Žš„’ ß‘ª »—ý %1', _Temp_Money.a_iway);
                    end;
                end;


                Clear(_ContractNo);

                if _Temp_Money.m_id = '‘ñˆ×-0141' then begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_Money.m_id);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetRange("Cemetery No.", _Temp_Money.m_id);
                    _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                    if _Contract.FindSet then begin
                        _ContractNo := _Contract."No.";
                    end else begin
                        _Contract.Reset;
                        _Contract.SetCurrentKey("Revocation Date");
                        _Contract.SetRange("Cemetery No.", _Temp_Money.m_id);
                        _Contract.SetRange(Status, _Contract.Status::Revocation);
                        if _Contract.FindLast then
                            _ContractNo := _Contract."No.";
                    end;
                end;

                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin
                    _PayReceiptDoc."Contract No." := _Contract."No.";

                    _PayReceiptDoc."Supervise No." := _Contract."Supervise No.";
                    _PayReceiptDoc."Cemetery Code" := _Contract."Cemetery Code";
                    _PayReceiptDoc."Cemetery No." := _Contract."Cemetery No.";

                    _PayReceiptDoc."Litigation Employee No." := _Contract."Litigation Employee No.";
                    _PayReceiptDoc."Litigation Employee Name" := _Contract."Litigation Employee Name";
                    _PayReceiptDoc."Litigation Evaluation" := _Contract."Litigation Evaluation";
                    _PayReceiptDoc."Main Customer Name" := _Contract."Main Customer Name";

                    _PayReceiptDocLine.contractNo := _Contract."No.";//Add Field 20190730
                end else begin
                    _PayReceiptDoc."Cemetery No." := _Temp_Money.m_id;
                end;


                if _Temp_Money.u_ck = 'Y' then
                    _PayReceiptDoc.Division := true
                else
                    _PayReceiptDoc.Division := false;


                if _Temp_Money.a_cmoney = 0 then begin
                    _ReceiptBankAccount.Reset;
                    _ReceiptBankAccount.SetRange(Litigation, true);
                    if _ReceiptBankAccount.FindSet then begin
                        _PayReceiptDoc.Validate("Bank Account Code", _ReceiptBankAccount.Code);
                        _PayReceiptDoc.Litigation := true;
                        _PayReceiptDoc."Payment Type" := _PayReceiptDoc."Payment Type"::DebtRelief;
                    end;
                end else begin
                    _PayReceiptDoc.Amount := _Temp_Money.a_cmoney;
                end;

                if _Temp_Money.u_low <> 0 then _PayReceiptDoc."Legal Amount" := _Temp_Money.u_low;
                if _Temp_Money.u_prepay <> 0 then _PayReceiptDoc."Advance Payment Amount" := _Temp_Money.u_prepay;
                if _Temp_Money.u_interest <> 0 then _PayReceiptDoc."Delay Interest Amount" := _Temp_Money.u_interest;
                if _Temp_Money.u_move <> 0 then _PayReceiptDoc."MTG Amount" := _Temp_Money.u_move;
                if _Temp_Money.u_reduce <> 0 then _PayReceiptDoc."Reduction Amount" := _Temp_Money.u_reduce;

                if _Temp_Money.u_move_ck = 'Y' then
                    _PayReceiptDoc."Move The Grave" := true
                else
                    _PayReceiptDoc."Move The Grave" := false;


                _PayReceiptDoc."Withdraw Mothed" := _Temp_Money.u_rtype;
                _PayReceiptDoc."Litigation Ramark" := CopyStr(_Temp_Money.u_bigo, 1, 250);

                _PayReceiptDoc."Final Amount" := _PayReceiptDoc.Amount;

                _PayReceiptDoc.Description := _Temp_Money.a_memo;
                _PayReceiptDoc.Posted := true;


                _Modifydate := DelChr(CopyStr(_Temp_Money.altdate, 1, 10), '=', '-');
                if _Modifydate <> '' then begin
                    if CheckDate(_Modifydate) then begin
                        _PayReceiptDoc."Creation Date" := CreateDateTime(ConvertDate(_Modifydate), 000000T);
                        _PayReceiptDoc."Last Date Modified" := _PayReceiptDoc."Creation Date";
                    end else
                        Error('Œ÷‘ñŸ ‡õ : %1', _Temp_Money.altdate);
                end;

                _Employee.Reset;
                _Employee.SetRange("Bef. No.", _Temp_Money.modifier);
                if _Employee.FindSet then begin
                    _PayReceiptDoc."Creation Person" := _Employee.Name;
                    _PayReceiptDoc."Last Modified Person" := _PayReceiptDoc."Creation Person";
                end;
                _PayReceiptDoc.IDX := _Temp_Money.idx;
                _PayReceiptDoc.Insert(true);


                _PayReceiptDocLine.Init;
                _PayReceiptDocLine."Document No." := _PayReceiptDoc."Document No.";
                _PayReceiptDocLine."Line No." := 1;
                case _Temp_Money.a_type of
                    'Š¨—­‚‚Šž', 'ýˆ«Š±', 'ýˆ«Š±“ÔŒ­', '':
                        begin
                            _PayReceiptDocLine."Payment Target" := _PayReceiptDocLine."Payment Target"::General;
                        end;
                    '‘†µýˆ«Š±':
                        begin
                            _PayReceiptDocLine."Payment Target" := _PayReceiptDocLine."Payment Target"::Landscape;
                        end;
                end;

                if _Temp_Money.a_sdate <> '' then begin
                    if _Temp_Money.a_sdate = '11971105' then _Temp_Money.a_sdate := '19971105';

                    if CheckDate(_Temp_Money.a_sdate) then
                        _PayReceiptDocLine."Start Date" := ConvertDate(_Temp_Money.a_sdate)
                    else
                        Error('ýˆ«Š±“ÁŸ ‡õ : %1', _Temp_Money.a_sdate);
                end;
                if _Temp_Money.a_edate <> '' then
                    if CheckDate(_Temp_Money.a_edate) then
                        _PayReceiptDocLine."Expiration Date" := ConvertDate(_Temp_Money.a_edate)
                    else
                        Error('ýˆ«Š±‘Ž‡ßŸ ‡õ : %1', _Temp_Money.a_edate);

                _PayReceiptDocLine.Amount := _PayReceiptDoc."Final Amount";

                _PayReceiptDocLine."Bef. Non-Pay. Amount" := _Temp_Money.Unpaid; //Add Field 20190730
                _PayReceiptDocLine.Idx := _Temp_Money.idx; //Add Field 20190730

                _PayReceiptDocLine.PaymentDate := _PayReceiptDoc."Payment Date";//Add Field 20190730
                _PayReceiptDocLine.Insert;

                _BeforCemNo := _Temp_Money.m_id;

            until _Temp_Money.Next = 0;

        end;

    end;


    procedure UploadRequest1()
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _CounselHistory: Record "DK_Counsel History";
        _Temp_Request1: Record Temp_Request1;
        _BeforCemNo: Text[30];
        _Employee: Record DK_Employee;
        _ContractNo: Code[20];
    begin
        //Ÿ‰¦ ‹Ý„Ì‚‹Ô

        _CounselHistory.Reset;
        _CounselHistory.SetRange(Type, _CounselHistory.Type::General);
        if _CounselHistory.FindSet then
            _CounselHistory.DeleteAll;


        _Temp_Request1.Reset;
        _Temp_Request1.SetCurrentKey(m_id);
        if _Temp_Request1.FindSet then begin
            repeat

                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_Request1.m_id);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_Request1.m_id);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;


                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin
                    if _BeforCemNo <> _Temp_Request1.m_id then
                        _NewLineNo := 1
                    else
                        _NewLineNo += 1;

                    _CounselHistory.Init;
                    _CounselHistory."Contract No." := _Contract."No.";
                    _CounselHistory.Type := _CounselHistory.Type::General;
                    _CounselHistory."Line No." := _NewLineNo;
                    _CounselHistory."Supervise No." := _Contract."Supervise No.";
                    _CounselHistory."Cemetery Code" := _Contract."Cemetery Code";
                    _CounselHistory."Cemetery No." := _Contract."Cemetery No.";

                    case _Temp_Request1.r_date of
                        '20110890':
                            _Temp_Request1.r_date := '20110830';
                    end;

                    if _Temp_Request1.r_date <> '' then
                        if CheckDate(_Temp_Request1.r_date) then
                            _CounselHistory.Date := ConvertDate(_Temp_Request1.r_date)
                        else
                            Error('‹Ý„ÌŸÀ ‡õ : %1', _Temp_Request1.r_date);

                    case _Temp_Request1.r_gb of
                        '':
                            _CounselHistory."Counsel Level 1" := _CounselHistory."Counsel Level 1"::Blank;
                        '1:1”™ŽØ':
                            _CounselHistory."Counsel Level 1" := _CounselHistory."Counsel Level 1"::Care;
                        'Y-€Ë•ˆ':
                            _CounselHistory."Counsel Level 1" := _CounselHistory."Counsel Level 1"::Etc;
                        '‰Èž/‹ÙÕ':
                            _CounselHistory."Counsel Level 1" := _CounselHistory."Counsel Level 1"::Funeral;
                        'Ÿ‰¦':
                            _CounselHistory."Counsel Level 1" := _CounselHistory."Counsel Level 1"::General;
                        'Î‡š“Ë…':
                            _CounselHistory."Counsel Level 1" := _CounselHistory."Counsel Level 1"::Dispatch;
                        else
                            Error('‹Ý„Ì‘Ž‡õ1 ‡õ');
                    end;

                    case _Temp_Request1.r_tag of
                        'ýˆ«…Ø€Ã':
                            _CounselHistory.Validate("Counsel Level Code 2", '121');
                        'ýˆ«Š±':
                            _CounselHistory.Validate("Counsel Level Code 2", '001');
                        '€Ë•ˆ':
                            _CounselHistory.Validate("Counsel Level Code 2", '999');
                        '„Ô•Í':
                            _CounselHistory.Validate("Counsel Level Code 2", '105');
                        'ˆ«ˆÚ…¿ˆ…':
                            _CounselHistory.Validate("Counsel Level Code 2", '106');
                        '‹Ï‘°º–¨':
                            _CounselHistory.Validate("Counsel Level Code 2", '113');
                        '‹Ï“š':
                            _CounselHistory.Validate("Counsel Level Code 2", '112');
                        '‹Ý‘†‹Ý„Ì':
                            _CounselHistory.Validate("Counsel Level Code 2", '103');
                        '‹Ý’ðˆ':
                            _CounselHistory.Validate("Counsel Level Code 2", '116');
                        'Œ«“Ê':
                            _CounselHistory.Validate("Counsel Level Code 2", '110');
                        'Œ‚‰ª':
                            _CounselHistory.Validate("Counsel Level Code 2", '002');
                        'Œ­‚(‰ª)':
                            _CounselHistory.Validate("Counsel Level Code 2", '104');
                        'Œ´‡žˆÝ':
                            _CounselHistory.Validate("Counsel Level Code 2", '900');
                        '”Ï':
                            _CounselHistory.Validate("Counsel Level Code 2", '111');
                        '•€¯‹Ý„Ì':
                            _CounselHistory.Validate("Counsel Level Code 2", '109');
                        '‰’œÎ':
                            _CounselHistory.Validate("Counsel Level Code 2", '200');
                        'Ô—':
                            _CounselHistory.Validate("Counsel Level Code 2", '117');
                        '»‘‡‹Ý„Ì':
                            _CounselHistory.Validate("Counsel Level Code 2", '119');
                        'œÎ':
                            _CounselHistory.Validate("Counsel Level Code 2", '108');
                        'Ÿ‰¦':
                            _CounselHistory.Validate("Counsel Level Code 2", '000');
                        'Î‡š':
                            _CounselHistory.Validate("Counsel Level Code 2", '107');
                        '‘†µýˆ«':
                            _CounselHistory.Validate("Counsel Level Code 2", '115');
                        '‘†µýˆ«Š±':
                            _CounselHistory.Validate("Counsel Level Code 2", '301');
                        '‘÷ø‹Ï—¸':
                            _CounselHistory.Validate("Counsel Level Code 2", '120');
                        '—Î˜¡':
                            _CounselHistory.Validate("Counsel Level Code 2", '114');
                        '˜ˆ°•‹Ý':
                            _CounselHistory.Validate("Counsel Level Code 2", '101');
                        '˜ˆ°‘ñŠˆ':
                            _CounselHistory.Validate("Counsel Level Code 2", '003');
                        '':
                            _CounselHistory.Validate("Counsel Level Code 2", '');
                        else
                            Error('‹Ý„Ì‘Ž‡õ2 ‡õ');
                    end;


                    _CounselHistory."Counsel Content" := _Temp_Request1.r_memo;

                    _CounselHistory."Process Content" := _Temp_Request1.r_respon;


                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_Request1.writer);
                    if _Employee.FindSet then begin
                        _CounselHistory."Employee No." := _Employee."No.";
                        _CounselHistory."Employee Name" := _Employee.Name;
                        _CounselHistory."Creation Person" := _Employee.Name;
                    end;

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_Request1.modifier);
                    if _Employee.FindSet then begin
                        _CounselHistory."Last Modified Person" := _Employee.Name;
                    end;


                    _CounselHistory."Creation Date" := _Temp_Request1.sysdate;
                    _CounselHistory."Last Date Modified" := _Temp_Request1.altdate;


                    if _Temp_Request1.r_ressueyn = 'Y' then
                        _CounselHistory."Issue of membership" := true
                    else
                        _CounselHistory."Issue of membership" := false;
                    _CounselHistory.idx := _Temp_Request1.IDX;

                    _CounselHistory.Insert;
                    if _Temp_Request1.r_resultyn = 'Y' then
                        _CounselHistory."Result Process" := _CounselHistory."Result Process"::Completed;
                    _CounselHistory.Modify;

                    _BeforCemNo := _Temp_Request1.m_id;
                end;


            until _Temp_Request1.Next = 0;

        end;
    end;


    procedure UploadUnpaidRequest()
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _CounselHistory: Record "DK_Counsel History";
        _Temp_unpaid_request: Record Temp_unpaid_request;
        _BeforCemNo: Text[30];
        _Employee: Record DK_Employee;
        _ContractNo: Code[20];
    begin
        //ŒÁ‰½ ‹Ý„Ì‚‹Ô

        _CounselHistory.Reset;
        _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
        if _CounselHistory.FindSet then
            _CounselHistory.DeleteAll;

        _Temp_unpaid_request.Reset;
        _Temp_unpaid_request.SetCurrentKey(r_mid);
        if _Temp_unpaid_request.FindSet then begin
            repeat

                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_unpaid_request.r_mid);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_unpaid_request.r_mid);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;


                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin
                    if _BeforCemNo <> _Temp_unpaid_request.r_mid then
                        _NewLineNo := 1
                    else
                        _NewLineNo += 1;

                    _CounselHistory.Reset;
                    _CounselHistory."Contract No." := _Contract."No.";
                    _CounselHistory.Type := _CounselHistory.Type::Litigation;
                    _CounselHistory."Line No." := _NewLineNo;
                    _CounselHistory."Supervise No." := _Contract."Supervise No.";
                    _CounselHistory."Cemetery Code" := _Contract."Cemetery Code";
                    _CounselHistory."Cemetery No." := _Contract."Cemetery No.";


                    case _Temp_unpaid_request.r_opt of
                        '001':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Reception;
                        '002':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Sending;
                        '003':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Talk;
                        '004':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::SMS;
                        '005':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Etc;
                        '006':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Mail;
                        '007':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Law;
                        '008':
                            _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::Visit;
                    end;

                    case _Temp_unpaid_request.r_comm of
                        '001':
                            _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::Mobile;
                        '002':
                            _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::Home;
                        '003':
                            _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::Work;
                        '004':
                            _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::Etc;
                        '005':
                            _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::CoC;
                    end;

                    case _Temp_unpaid_request.r_Customer of
                        '001':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Principal;
                        '002':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Spouse;
                        '003':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Children;
                        '004':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Mother;
                        '005':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Father;
                        '006':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Brother;
                        '007':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Relatives;
                        '008':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Friend;
                        '009':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Others;
                        '010':
                            _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Etc;
                    end;


                    _Employee.Reset;
                    _Employee.SetRange(Name, _Temp_unpaid_request.r_insert);
                    if _Employee.FindSet then begin
                        _CounselHistory."Employee No." := _Employee."No.";
                        _CounselHistory."Employee Name" := _Employee.Name;
                        _CounselHistory."Creation Person" := _Employee.Name;
                    end;

                    _Employee.Reset;
                    _Employee.SetRange(Name, _Temp_unpaid_request.r_deit);
                    if _Employee.FindSet then begin
                        _CounselHistory."Last Modified Person" := _Employee.Name;
                    end;

                    _CounselHistory."Deposit Plan Date" := DT2Date(_Temp_unpaid_request.r_indate);

                    _CounselHistory."Creation Date" := _Temp_unpaid_request.r_insertDate;
                    _CounselHistory."Last Date Modified" := _Temp_unpaid_request.r_editdate;

                    _CounselHistory.Date := DT2Date(_CounselHistory."Creation Date");
                    _CounselHistory.idx := _Temp_unpaid_request.idx;
                    _CounselHistory.Insert;


                    _CounselHistory."Result Process" := _CounselHistory."Result Process"::Completed;
                    _CounselHistory.SetWorkLitigationContent(_Temp_unpaid_request.r_txt + _Temp_unpaid_request.r_txt2 + _Temp_unpaid_request.r_txt3);
                    _CounselHistory.Modify;
                end;

                _BeforCemNo := _Temp_unpaid_request.r_mid;
            until _Temp_unpaid_request.Next = 0;

        end;
    end;

    local procedure UploadPaymentReceiptMissingContract()
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin
        //ÐŽÊ ‰œ˜«ž ¯€¦—


        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetRange("Missing Contract", true);
        if _PayReceiptDoc.FindSet then
            _PayReceiptDoc.DeleteAll;

        //2019-09-30 Ÿ ˆ†¿ À‡ß
        InsertPaymentReceiptDoc(20160408D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ýˆ«Š±Ÿ‚‚', 'BA001', 108000);
        InsertPaymentReceiptDoc(20170121D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‰žÏ', 'BA001', 162000);
        InsertPaymentReceiptDoc(20170124D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± øÂŒð', 'BA001', 288000);
        InsertPaymentReceiptDoc(20170711D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± €Ð¡—÷', 'BA001', 558000);
        InsertPaymentReceiptDoc(20171030D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± “´‘ñ€', 'BA001', 27100);
        InsertPaymentReceiptDoc(20180705D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‘ñµ˜±', 'BA001', 450000);
        InsertPaymentReceiptDoc(20180920D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± “´Š‰Œ°', 'BA001', 360000);
        InsertPaymentReceiptDoc(20190211D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± œ„÷Œ€', 'BA001', 146500);
        InsertPaymentReceiptDoc(20190311D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± Œ­ˆ‘À°,Œ­ˆ‘°žÐ', 'BA001', 180000);
        InsertPaymentReceiptDoc(20190410D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± œ€ñ”', 'BA001', 540000);
        InsertPaymentReceiptDoc(20190413D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‘ñŠµ', 'BA001', 63200);
        InsertPaymentReceiptDoc(20190416D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‰À‘÷Œð', 'BA001', 540000);
        InsertPaymentReceiptDoc(20190428D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± €Ð‘¹Œ«', 'BA001', 108000);
        InsertPaymentReceiptDoc(20190504D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± €Ð“ó¡', 'BA001', 186000);
        InsertPaymentReceiptDoc(20190507D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‘ñŒð‘ñ', 'BA001', 199400);
        InsertPaymentReceiptDoc(20190507D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± œˆ×Œ€', 'BA001', 600000);
        InsertPaymentReceiptDoc(20190513D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± CHANG HYE KYEONG', 'BA001', 216000);
        InsertPaymentReceiptDoc(20190517D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ’ð‘Ž˜»', 'BA001', 108000);
        InsertPaymentReceiptDoc(20190604D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± €ÐžÀ', 'BA001', 690300);
        InsertPaymentReceiptDoc(20190702D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‘ñ‰Ò˜–', 'BA001', 216670);
        InsertPaymentReceiptDoc(20190710D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‰À‚Ô†Ý', 'BA001', 418400);
        InsertPaymentReceiptDoc(20190725D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‰À…Œ°', 'BA001', 180000);
        InsertPaymentReceiptDoc(20190816D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± œŒ°˜±', 'BA001', 400000);
        InsertPaymentReceiptDoc(20190821D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± —š†Ý•¸Š', 'BA001', 57000);
        InsertPaymentReceiptDoc(20190827D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± €—ž‰Ð', 'BA001', 162000);
        InsertPaymentReceiptDoc(20190829D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ŒŠ…Ø', 'BA001', 600000);
        InsertPaymentReceiptDoc(20190830D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± »—¹…', 'BA001', 387400);
        InsertPaymentReceiptDoc(20190830D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± 63-7-4059', 'BA001', 400000);
        InsertPaymentReceiptDoc(20190831D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‡õ‘÷‚¬', 'BA001', 200000);
        InsertPaymentReceiptDoc(20190831D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‰À‘¹Œð', 'BA001', 20000);
        InsertPaymentReceiptDoc(20190902D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± 003-€—Õ•“', 'BA001', 200000);
        InsertPaymentReceiptDoc(20190905D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± —©ØŒ«', 'BA001', 51616);
        InsertPaymentReceiptDoc(20190910D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± œŒ°‘ñ', 'BA001', 500000);
        InsertPaymentReceiptDoc(20190910D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± ‰ÀŽ´µ', 'BA001', 120000);
        InsertPaymentReceiptDoc(20190911D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± —©‹Ý‘†ž‡š', 'BA001', 400000);
        InsertPaymentReceiptDoc(20190919D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± Î—÷Ô ‘°˜ÙŠÞ…õ', 'BA001', 382500);
        InsertPaymentReceiptDoc(20190925D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± €Ð—©‰ž', 'BA001', 150000);
        InsertPaymentReceiptDoc(20190930D, '‚Ý—õ#355 Œ€Œ÷ýˆ«Š± Œ¡…Õ', 'BA001', 400000);

        InsertPaymentReceiptDoc(20161223D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± Ôž‰ª', 'BA003', 100000);
        InsertPaymentReceiptDoc(20171106D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± œŒŠÕ', 'BA003', 100000);
        InsertPaymentReceiptDoc(20171210D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± œŒŠÕ', 'BA003', 100000);
        InsertPaymentReceiptDoc(20180122D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± Ž÷‰œŒð', 'BA003', 70000);
        InsertPaymentReceiptDoc(20180227D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± Ž÷‰œŒð', 'BA003', 70000);
        InsertPaymentReceiptDoc(20180115D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± ˜½…€‚', 'BA003', 50000);
        InsertPaymentReceiptDoc(20180418D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± €Ð˜½Œ÷', 'BA003', 100000);
        InsertPaymentReceiptDoc(20180628D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± œ…‘', 'BA003', 100000);
        InsertPaymentReceiptDoc(20180802D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± ……°˜ˆ', 'BA003', 470000);
        InsertPaymentReceiptDoc(20180828D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± €Ð—ýŒð', 'BA003', 300000);
        InsertPaymentReceiptDoc(20180925D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± •“ßÕ', 'BA003', 300000);
        InsertPaymentReceiptDoc(20180926D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± ‰ÒŒŒŒ÷', 'BA003', 200000);
        InsertPaymentReceiptDoc(20180930D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± “´µ‘´', 'BA003', 500000);
        InsertPaymentReceiptDoc(20180930D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± €Ð‘°Ÿ', 'BA003', 30000);
        InsertPaymentReceiptDoc(20180930D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± ý—÷“†', 'BA003', 100000);
        InsertPaymentReceiptDoc(20180930D, '€ËŽð-Œ´‡žˆÝ05-015 Œ€Œ÷ýˆ«Š± ý…Œ°', 'BA003', 935700);

        InsertPaymentReceiptDoc(20180405D, '‚Ý—õ 001129 ‹Ï“š œ‘€¯', 'BA004', 50000);
        InsertPaymentReceiptDoc(20190812D, '‚Ý—õ 001129 íÐŽÊ€¦ œ‘°µ', 'BA004', 1000000);
        InsertPaymentReceiptDoc(20190812D, '‚Ý—õ 001129 íÐŽÊ€¦ €Ð“ß”', 'BA004', 1000000);
        InsertPaymentReceiptDoc(20190903D, '‚Ý—õ 001129 íÐŽÊ€¦ ‘ñ—÷À', 'BA004', 1000000);
        InsertPaymentReceiptDoc(20190907D, '‚Ý—õ 001129 íÐŽÊ€¦ ‘†‰œ‡™', 'BA004', 500000);
        InsertPaymentReceiptDoc(20190918D, '‚Ý—õ 001129 íÐŽÊ€¦ ‚—÷Õ', 'BA004', 1000000);
        InsertPaymentReceiptDoc(20190919D, '‚Ý—õ 001129 íÐŽÊ€¦ €Ð‘÷˜½', 'BA004', 5000000);
        InsertPaymentReceiptDoc(20190924D, '‚Ý—õ 001129 íÐŽÊ€¦ ®‘ñ—ã', 'BA004', 300000);
        InsertPaymentReceiptDoc(20190925D, '‚Ý—õ 001129 íÐŽÊ€¦ ‘ñ‰ž€‚', 'BA004', 500000);
        InsertPaymentReceiptDoc(20190925D, '‚Ý—õ 001129 íÐŽÊ€¦ œ…Ï', 'BA004', 1000000);
        InsertPaymentReceiptDoc(20190926D, '‚Ý—õ 001129 íÐŽÊ€¦ “´‹ÝÔ', 'BA004', 1000000);
        InsertPaymentReceiptDoc(20190926D, '‚Ý—õ 001129 íÐŽÊ€¦ ýŒŠŠ¨', 'BA004', 2000000);
        InsertPaymentReceiptDoc(20190926D, '‚Ý—õ 001129 ·¯ Ï˜ú-·¯', 'BA004', 500000);
        InsertPaymentReceiptDoc(20190927D, '‚Ý—õ 001129 íÐŽÊ€¦ Œ³—²€', 'BA004', 200000);
        InsertPaymentReceiptDoc(20190928D, '‚Ý—õ 001129 íÐŽÊ€¦ €ŒŠ€‰', 'BA004', 300000);
        InsertPaymentReceiptDoc(20190930D, '‚Ý—õ 001129 Â€¦ Š»‹Ý˜–264', 'BA004', 9300000);
    end;


    procedure UploadIndicate()
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
        _NewLineNo: Integer;
        _AlDay: Integer;
        _CustomerRequests: Record "DK_Customer Requests";
        _Temp_Indicate: Record Temp_Indicate;
        _BeforCemNo: Text[30];
        _Employee: Record DK_Employee;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _ContractNo: Code[20];
    begin
        //‘÷ø‹Ï—¸

        _CustomerRequests.Reset;
        if _CustomerRequests.FindSet then
            _CustomerRequests.DeleteAll;

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Customer Requests Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Customer Requests Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;
        Commit;

        _Temp_Indicate.Reset;
        _Temp_Indicate.SetCurrentKey(ctid);
        if _Temp_Indicate.FindSet then begin
            repeat

                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_Indicate.ctid);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_Indicate.ctid);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;


                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin
                    if _BeforCemNo <> _Temp_Indicate.ctid then
                        _NewLineNo := 1
                    else
                        _NewLineNo += 1;

                    _CustomerRequests.Init;
                    _CustomerRequests."No." := '';

                    _CustomerRequests."Contract No." := _Contract."No.";



                    _CustomerRequests."Main Customer No." := _Contract."Main Customer No.";
                    _CustomerRequests.Validate("Cemetery Code", _Contract."Cemetery Code");
                    _CustomerRequests.Validate("Work Cemetery Code", _Contract."Cemetery Code");

                    _CustomerRequests."Receipt Date" := ConvertDate(_Temp_Indicate.cdate);
                    _CustomerRequests."Appl. Name" := _Temp_Indicate.cname;
                    _CustomerRequests."Appl. Mobile No." := _Temp_Indicate.cphone;
                    _CustomerRequests."Appl. Phone No." := _Temp_Indicate.ctel;

                    Evaluate(_CustomerRequests."Work Indicator", _Temp_Indicate.cintendant);
                    Evaluate(_CustomerRequests."Work Manager", _Temp_Indicate.cchair);

                    if StrPos(_Temp_Indicate.cemail, '@') <> 0 then
                        _CustomerRequests."Appl. E-mail" := _Temp_Indicate.cemail;

                    case _Temp_Indicate.cgb of
                        '€Ë•ˆ':
                            _CustomerRequests."Receipt Method" := _CustomerRequests."Receipt Method"::Other;
                        '°°':
                            _CustomerRequests."Receipt Method" := _CustomerRequests."Receipt Method"::Park;
                        '‰µ‰«':
                            _CustomerRequests."Receipt Method" := _CustomerRequests."Receipt Method"::Visit;
                        '˜¿–Íœ‘÷':
                            _CustomerRequests."Receipt Method" := _CustomerRequests."Receipt Method"::Homepage;
                        'ý˜¡':
                            _CustomerRequests."Receipt Method" := _CustomerRequests."Receipt Method"::Phone;
                        else
                            Error('‘óŒ÷‰µ‰² ‡õ %1', _Temp_Indicate.cgb);
                    end;

                    _CustomerRequests.Validate("Field Work Main Cat. Code", '005');

                    case _Temp_Indicate.ctype of
                        '€Ë•ˆ':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '999');
                        '˜¡Î—':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '009');
                        '‘†µ':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '004');
                        '‘´Š»ÁŽð':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '005');
                        '‰ªŒ­':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '001');
                        'Œ«‰':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '002');
                        '……‡ž':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '006');
                        '”„Ï':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '008');
                        '‘ð°':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '010');
                        'Â…Ú':
                            _CustomerRequests.Validate("Field Work Sub Cat. Code", '011');
                        else
                            Error('—÷ÎŽð‰½ Œ­Š¨‡õ ‡õ %1', _Temp_Indicate.ctype);
                    end;

                    case _Temp_Indicate.cpart of
                        '‘÷ø':
                            _CustomerRequests."Receipt Division" := _CustomerRequests."Receipt Division"::Demand;
                        else
                            _CustomerRequests."Receipt Division" := _CustomerRequests."Receipt Division"::Indicate;
                    end;

                    case _Temp_Indicate.ctag of
                        '€Í€Ã':
                            _CustomerRequests."Work Division" := _CustomerRequests."Work Division"::Urgency;
                        else
                            _CustomerRequests."Work Division" := _CustomerRequests."Work Division"::Normal;
                    end;

                    //‘óŒ÷‚‹Ô
                    if _Temp_Indicate.cmemo1 <> '' then
                        _CustomerRequests."Receipt Contents" := '‘óŒ÷‚‹Ô1:' + _Temp_Indicate.cmemo1;

                    if _Temp_Indicate.cmemo2 <> '' then
                        if _CustomerRequests."Receipt Contents" <> '' then
                            _CustomerRequests."Receipt Contents" := _CustomerRequests."Receipt Contents" + '\' + '‘óŒ÷‚‹Ô2:' + _Temp_Indicate.cmemo2
                        else
                            _CustomerRequests."Receipt Contents" := '‘óŒ÷‚‹Ô2:' + _Temp_Indicate.cmemo2;

                    if _Temp_Indicate.cmemo3 <> '' then
                        if _CustomerRequests."Receipt Contents" <> '' then
                            _CustomerRequests."Receipt Contents" := _CustomerRequests."Receipt Contents" + '\' + '‘óŒ÷‚‹Ô3:' + _Temp_Indicate.cmemo3
                        else
                            _CustomerRequests."Receipt Contents" := '‘óŒ÷‚‹Ô3:' + _Temp_Indicate.cmemo3;


                    //ß·
                    if _Temp_Indicate.cresult1 <> '' then
                        _CustomerRequests."Process Content" := '‘óŒ÷ß·1:' + _Temp_Indicate.cresult1;

                    if _Temp_Indicate.cresult2 <> '' then
                        if _CustomerRequests."Process Content" <> '' then
                            _CustomerRequests."Process Content" := _CustomerRequests."Receipt Contents" + '\' + '‘óŒ÷ß·2:' + _Temp_Indicate.cresult2
                        else
                            _CustomerRequests."Process Content" := '‘óŒ÷ß·2:' + _Temp_Indicate.cresult2;

                    if _Temp_Indicate.cresult3 <> '' then
                        if _CustomerRequests."Process Content" <> '' then
                            _CustomerRequests."Process Content" := _CustomerRequests."Receipt Contents" + '\' + '‘óŒ÷ß·3:' + _Temp_Indicate.cresult3
                        else
                            _CustomerRequests."Process Content" := '‘óŒ÷ß·3:' + _Temp_Indicate.cresult3;

                    _CustomerRequests."Work Personnel" := _Temp_Indicate.worker_cnt;
                    _CustomerRequests."Work Time Spent" := _Temp_Indicate.job_time;


                    _Temp_Indicate.cpdate := DelChr(_Temp_Indicate.cpdate, '=', ' ');
                    if (_Temp_Indicate.cpdate <> '') and (_Temp_Indicate.cpdate <> '00000000') then
                        if StrLen(_Temp_Indicate.cpdate) = 8 then
                            _CustomerRequests."Process Date" := ConvertDate(_Temp_Indicate.cpdate);

                    _CustomerRequests.crm_voc_guid := _Temp_Indicate.crm_voc_guid;

                    case _Temp_Indicate.cprocess of
                        '‰œß':
                            _CustomerRequests.Status := _CustomerRequests.Status::Release;
                        'Š­í':
                            _CustomerRequests.Status := _CustomerRequests.Status::Impossible;
                        'Šˆ‡õ':
                            _CustomerRequests.Status := _CustomerRequests.Status::Open;
                        'Ÿ‡ß':
                            _CustomerRequests.Status := _CustomerRequests.Status::Post;
                    end;
                    if _CustomerRequests."Receipt Date" < 20190701D then
                        _CustomerRequests.Status := _CustomerRequests.Status::Complete;


                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_Indicate.writer);
                    if _Employee.FindSet then begin
                        _CustomerRequests."Creation Person" := _Employee.Name;
                        _CustomerRequests."Employee No." := _Employee."No.";
                        _CustomerRequests."Employee name" := _Employee.Name;
                    end;

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_Indicate.modifier);
                    if _Employee.FindSet then begin
                        _CustomerRequests."Last Modified Person" := _Employee.Name;
                    end;

                    _CustomerRequests."Creation Date" := CreateDateTime(_CustomerRequests."Receipt Date", 0T);
                    _CustomerRequests."Last Date Modified" := _Temp_Indicate.altdate;


                    _CustomerRequests.idx := _Temp_Indicate.Idx;
                    _CustomerRequests.Insert(true);

                end;

                _BeforCemNo := _Temp_Indicate.ctid;
            until _Temp_Indicate.Next = 0;

        end;
    end;

    local procedure UploadItem()
    var
        _Temp_Item: Record Temp_Item;
        _Item: Record DK_Item;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Employee: Record DK_Employee;
        _ItemSubCategory: Record "DK_Item Sub Category";
    begin

        _Item.Reset;
        if _Item.FindSet then
            _Item.DeleteAll;

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Item Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Item Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;
        Commit;
        //==============================================
        _Temp_Item.Reset;
        if _Temp_Item.FindSet then begin
            repeat

                if _ItemSubCategory.Get(_Temp_Item.g_big, _Temp_Item.g_mid) then begin
                    _Item.Init;
                    _Item."No." := '';
                    _Item.Name := _Temp_Item.g_name;
                    _Item.Validate("Item Main Cat. Code", _Temp_Item.g_big);
                    _Item.Validate("Item Sub Cat. Code", _Temp_Item.g_mid);

                    if _Temp_Item.g_qrcode = 'Y' then
                        _Item."QR Code Use" := _Item."QR Code Use"::Yes
                    else
                        _Item."QR Code Use" := _Item."QR Code Use"::No;

                    if _Temp_Item.g_alamck = 'Y' then
                        _Item."Notice Use" := _Item."Notice Use"::Yes
                    else
                        _Item."Notice Use" := _Item."Notice Use"::No;

                    _Item."Notice Quantity" := _Temp_Item.g_alam;
                    _Item.Remark := _Temp_Item.g_bigo;

                    if _Temp_Item.g_member <> '' then begin
                        _Employee.Reset;
                        _Employee.SetRange(Name, _Temp_Item.g_member);
                        if _Employee.FindSet then begin
                            _Item."Employee No." := _Employee."No.";
                            _Item."Employee Name" := _Employee.Name;
                        end;
                    end;
                    _Item.idx := _Temp_Item.idx;
                    _Item.Insert(true);
                end else
                    Error('À‹Ó ”½•¸×ˆ« í‡»: %1, %2', _Temp_Item.g_big, _Temp_Item.g_mid);
            until _Temp_Item.Next = 0;
        end;
    end;

    local procedure UploadItemInbound()
    var
        _Temp_ItemInbound: Record Temp_ItemInbound;
        _PostedPurchReceipt: Record "DK_Posted Purchase Receipt";
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _Item: Record DK_Item;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Old_g_num: Text[20];
        _Location: Record DK_Location;
    begin

        _PostedPurchReceipt.Reset;
        if _PostedPurchReceipt.FindSet then
            _PostedPurchReceipt.DeleteAll;

        _ItemLedgerEntry.Reset;
        if _ItemLedgerEntry.FindSet then
            _ItemLedgerEntry.DeleteAll;


        _FunctionSetup.Get;
        _FunctionSetup.TestField("Rece. Ship. Header Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Rece. Ship. Header Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;
        Commit;
        //------------------------------------------------
        _Temp_ItemInbound.Reset;
        _Temp_ItemInbound.SetCurrentKey(g_num);
        //_Temp_ItemInbound.SETFILTER(g_goods ,'<>%1',413); //“‚ˆ« ‘ªÂ À‹Ó
        if _Temp_ItemInbound.FindSet then begin
            repeat
                _Item.Reset;

                _Item.SetRange(idx, _Temp_ItemInbound.g_goods);
                if _Item.FindSet then begin

                    if _Old_g_num <> _Temp_ItemInbound.g_num then begin

                        _PostedPurchReceipt.Init;
                        _PostedPurchReceipt."Document No." := _Temp_ItemInbound.g_num;
                        _PostedPurchReceipt."Line No." := 1;

                        Evaluate(_PostedPurchReceipt."Receipt Date", _Temp_ItemInbound.g_date);
                        Evaluate(_PostedPurchReceipt."Receipt Time", _Temp_ItemInbound.g_time);
                        _PostedPurchReceipt."Purchase Item" := _PostedPurchReceipt."Purchase Item"::No;

                        _PostedPurchReceipt."Item No." := _Item."No.";
                        _PostedPurchReceipt."Item Name" := _Item.Name;
                        _PostedPurchReceipt."Item Main Cat. Code" := _Item."Item Main Cat. Code";
                        _PostedPurchReceipt."Item Main Cat. Name" := _Item."Item Main Cat. Name";
                        _PostedPurchReceipt."Item Sub Cat. Code" := _Item."Item Sub Cat. Code";
                        _PostedPurchReceipt."Item Sub Cat. Name" := _Item."Item Sub Cat. Name";

                        if _Location.Get(_Temp_ItemInbound.gl_position) then begin
                            _PostedPurchReceipt."Location Code" := _Location.Code;
                            _PostedPurchReceipt."Location Name" := _Location.Name;
                        end;
                        _PostedPurchReceipt."Qty. to Receipt" := _Temp_ItemInbound.g_qty;

                        _PostedPurchReceipt.Insert(true);

                    end else begin
                        _PostedPurchReceipt."Qty. to Receipt" += _Temp_ItemInbound.g_qty;
                        _PostedPurchReceipt.Modify;
                    end;

                    _ItemLedgerEntry.Init;
                    _ItemLedgerEntry."Entry No." := 0;
                    _ItemLedgerEntry."Entry Type" := _ItemLedgerEntry."Entry Type"::Receipt;
                    _ItemLedgerEntry.Date := _PostedPurchReceipt."Receipt Date";
                    _ItemLedgerEntry."Document No." := _PostedPurchReceipt."Document No.";
                    _ItemLedgerEntry."Document Line No." := _PostedPurchReceipt."Line No.";
                    _ItemLedgerEntry."Item No." := _PostedPurchReceipt."Item No.";
                    _ItemLedgerEntry."Item Name" := _PostedPurchReceipt."Item Name";
                    _ItemLedgerEntry."Item Main Cat. Code" := _PostedPurchReceipt."Item Main Cat. Code";
                    _ItemLedgerEntry."Item Main Cat. Name" := _PostedPurchReceipt."Item Main Cat. Name";
                    _ItemLedgerEntry."Item Sub Cat. Code" := _PostedPurchReceipt."Item Sub Cat. Code";
                    _ItemLedgerEntry."Item Sub Cat. Name" := _PostedPurchReceipt."Item Sub Cat. Name";
                    _ItemLedgerEntry."Serial No." := _Temp_ItemInbound.g_code;
                    _ItemLedgerEntry."Location Code" := _PostedPurchReceipt."Location Code";
                    _ItemLedgerEntry."Location Name" := _PostedPurchReceipt."Location Name";
                    _ItemLedgerEntry.Quantity := _Temp_ItemInbound.g_qty;
                    _ItemLedgerEntry."Source No." := _PostedPurchReceipt."Document No.";
                    _ItemLedgerEntry."Source Line No." := _PostedPurchReceipt."Line No.";
                    _ItemLedgerEntry.IDX := _Temp_ItemInbound.Idx;
                    _ItemLedgerEntry.Insert(true);

                end;
                //ELSE
                //ERROR('À‹Ó ‡õ: %1 %2',_Temp_ItemInbound.g_goods, _Temp_ItemInbound.g_name);

                _Old_g_num := _Temp_ItemInbound.g_num;
            until _Temp_ItemInbound.Next = 0;
        end;
    end;

    local procedure UploadItemOutbound()
    var
        _Temp_ItemOutBound: Record Temp_ItemOutbound;
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _Item: Record DK_Item;
        _Location: Record DK_Location;
        _PostedPurchReceipt: Record "DK_Posted Purchase Receipt";
    begin

        _Temp_ItemOutBound.Reset;
        _Temp_ItemOutBound.SetCurrentKey(g_num);
        if _Temp_ItemOutBound.FindSet then begin
            repeat
                _Item.Reset;
                _Item.SetRange(idx, _Temp_ItemOutBound.g_goods);
                if _Item.FindSet then begin

                    if _PostedPurchReceipt.Get(_Temp_ItemOutBound.g_num, 1) then begin
                        _ItemLedgerEntry.Init;
                        _ItemLedgerEntry."Entry No." := 0;
                        _ItemLedgerEntry."Entry Type" := _ItemLedgerEntry."Entry Type"::Shipment;

                        Evaluate(_ItemLedgerEntry.Date, _Temp_ItemOutBound.g_date);

                        _ItemLedgerEntry."Source No." := _Temp_ItemOutBound.g_num;
                        _ItemLedgerEntry."Source Line No." := 1;
                        _ItemLedgerEntry."Item No." := _Item."No.";
                        _ItemLedgerEntry."Item Name" := _Item.Name;
                        _ItemLedgerEntry."Item Main Cat. Code" := _Item."Item Main Cat. Code";
                        _ItemLedgerEntry."Item Main Cat. Name" := _Item."Item Main Cat. Name";
                        _ItemLedgerEntry."Item Sub Cat. Code" := _Item."Item Sub Cat. Code";
                        _ItemLedgerEntry."Item Sub Cat. Name" := _Item."Item Sub Cat. Name";
                        _ItemLedgerEntry."Serial No." := _Temp_ItemOutBound.g_code;
                        _ItemLedgerEntry."Location Code" := _PostedPurchReceipt."Location Code";
                        _ItemLedgerEntry."Location Name" := _PostedPurchReceipt."Location Name";
                        _ItemLedgerEntry.Quantity := _Temp_ItemOutBound.g_qty * -1;
                        _ItemLedgerEntry."Cemetery No." := _Temp_ItemOutBound.g_out3;

                        case _Temp_ItemOutBound.g_out1 of
                            'µ…‘÷°–”–«':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '013');
                            '×„ŒŽ•':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '010');
                            '°°ýˆ«Œ­':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '009');
                            '€Ë•ˆ':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '999');
                            '‹Ï“š':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '004');
                            'Œ÷—¹':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '005');
                            '‰ŽÊ':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '002');
                            '—ý —Ê‹Ï':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '006');
                            'Î‡š':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '001');
                            'Ï‰½˜ˆÐ–':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '012');
                            'ý‹ÓTFT':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '014');
                            '‘÷ø':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '003');
                            '‘÷‘í ‰¦“Ë':
                                _ItemLedgerEntry.Validate("Shipment Type Code", '015');
                        end;

                        case _Temp_ItemOutBound.g_out2 of
                            '1‘†':
                                _ItemLedgerEntry.Validate("Working Group Code", '0001');
                            '2‘†':
                                _ItemLedgerEntry.Validate("Working Group Code", '0002');
                            '3‘†':
                                _ItemLedgerEntry.Validate("Working Group Code", '0003');
                            '€Ë•ˆ':
                                _ItemLedgerEntry.Validate("Working Group Code", '9999');
                            '‘ð…':
                                _ItemLedgerEntry.Validate("Working Group Code", '0000');
                        end;

                        _ItemLedgerEntry.Remarks := _Temp_ItemOutBound.g_bigo;
                        _ItemLedgerEntry.IDX := _Temp_ItemOutBound.idx;
                        _ItemLedgerEntry.Insert(true);

                        _ItemLedgerEntry."Creation Person" := _Temp_ItemOutBound.g_name;
                        _ItemLedgerEntry.Modify;
                    end else begin
                        Error('À‹Ó ¯×ˆª “ú‹ Œ÷ Ž°„Ÿ„¾. %1 ', _Temp_ItemOutBound.g_num);
                    end;
                end else
                    Error('À‹Ó ‡õ: %1 %2', _Temp_ItemOutBound.g_goods, _Temp_ItemOutBound.g_name);

            until _Temp_ItemOutBound.Next = 0;
        end;
    end;

    local procedure UpdateInvQRCode()
    var
        _Temp_ItemOutBound: Record Temp_ItemOutbound;
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _Item: Record DK_Item;
        _Location: Record DK_Location;
        _PostedPurchReceipt: Record "DK_Posted Purchase Receipt";
        _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
    begin

        /*
        _Item.RESET;
        _Item.SETRANGE("QR Code Use", _Item."QR Code Use"::Yes);
        _Item.SETFILTER(Inventory, '>0');
        IF _Item.FINDSET THEN BEGIN
          REPEAT
        */
        _ItemLedgerEntry.Reset;
        //_ItemLedgerEntry.SETRANGE("Item No.", _Item."No.");
        _ItemLedgerEntry.SetFilter(Inventory, '>0');
        _ItemLedgerEntry.SetFilter("Serial No.", '<>%1', '');
        if _ItemLedgerEntry.FindSet then begin
            repeat
                Clear(_PurchaseItemPost);
                _PurchaseItemPost.CalcQRCode(_ItemLedgerEntry);
                _ItemLedgerEntry.Modify;
            until _ItemLedgerEntry.Next = 0;
        end;
        /*
      UNTIL _Item.NEXT = 0;
    END;
    */

    end;

    local procedure UploadVendor()
    var
        _Temp_Vendor: Record Temp_Vendor;
        _Vendor: Record DK_Vendor;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
    begin

        _Vendor.Reset;
        if _Vendor.FindSet then
            _Vendor.DeleteAll;

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Vendor Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Vendor Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;

        _Temp_Vendor.Reset;
        if _Temp_Vendor.FindSet then begin
            //MESSAGE('COUNT : %1',_Temp_Vendor.COUNT);
            repeat
                _Vendor.Init;
                _Vendor."No." := '';
                _Vendor.Name := _Temp_Vendor.a_name;
                _Vendor."VAT Registration No." := _Temp_Vendor.a_num;
                _Vendor.Contact := _Temp_Vendor.a_hp;
                _Vendor."Phone No." := _Temp_Vendor.a_tel;
                _Vendor."Fax No." := _Temp_Vendor.a_fax;
                _Vendor."Post Code" := _Temp_Vendor.a_post;
                _Vendor.Address := _Temp_Vendor.a_add1;
                _Vendor."Address 2" := _Temp_Vendor.a_add2;
                _Vendor."E-mail" := _Temp_Vendor.a_email;

                case _Temp_Vendor.a_bank of
                    '€‰‰ž':
                        _Vendor.Validate("Bank Code", '004');
                    '‚Ý—õ':
                        _Vendor.Validate("Bank Code", '011');
                    '—Ÿ‚¬':
                        _Vendor.Validate("Bank Code", '081');
                end;
                _Vendor."Bank Account No." := _Temp_Vendor.a_account;
                _Vendor."Account Holder" := _Temp_Vendor.a_aname;
                _Vendor.Remarks := _Temp_Vendor.a_bigo;
                _Vendor.Idx := _Temp_Vendor.a_idx;
                _Vendor.Insert(true);
            until _Temp_Vendor.Next = 0;
        end;
    end;

    local procedure UploadToday()
    var
        _Temp_Today: Record Temp_Today;
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _TodayFuneral: Record "DK_Today Funeral";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _Contract: Record DK_Contract;
        _Employee: Record DK_Employee;
        _ContractNo: Code[20];
    begin
        //„“— Î‡š

        _TodayFuneralLine.Reset;
        if _TodayFuneralLine.FindSet then
            _TodayFuneralLine.DeleteAll;

        _TodayFuneral.Reset;
        if _TodayFuneral.FindSet then
            _TodayFuneral.DeleteAll;

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Today Funeral Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Today Funeral Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;

        _Temp_Today.Reset;
        _Temp_Today.SetCurrentKey(t_date);
        if _Temp_Today.FindSet then begin
            //MESSAGE('COUNT : %1',_Temp_Vendor.COUNT);
            repeat
                _TodayFuneral.Init;
                _TodayFuneral."No." := '';
                if _Temp_Today.t_gb = 'œÎ' then begin
                    _TodayFuneral."Funeral Type" := _TodayFuneral."Funeral Type"::Move;
                    _TodayFuneral.Validate("Field Work Main Cat. Code", '002');
                end else begin
                    _TodayFuneral."Funeral Type" := _TodayFuneral."Funeral Type"::Funeral;
                    _TodayFuneral.Validate("Field Work Main Cat. Code", '001');
                end;
                if _Temp_Today.t_date = '9' then
                    _TodayFuneral.Date := 20180226D
                else
                    _TodayFuneral.Date := ConvertDate(_Temp_Today.t_date);

                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_Today.t_id);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_Today.t_id);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;

                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin
                    _TodayFuneral."Contract No." := _Contract."No.";
                    _TodayFuneral."Cemetery Code" := _Contract."Cemetery Code";
                    _TodayFuneral."Cemetery No." := _Contract."Cemetery No.";
                end else begin
                    _TodayFuneral."Cemetery No." := _Temp_Today.t_id;
                end;

                case _Temp_Today.t_team of
                    '1‘†':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '0001');
                        end;
                    '2‘†':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '0002');
                        end;
                    '3‘†':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '0003');
                        end;
                    '4‘†':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '0004');
                        end;
                    'ÂŠž':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '9998');
                        end;
                    '‘ð…':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '0000');
                        end;
                    '€Ë•ˆ':
                        begin
                            _TodayFuneral.Validate("Working Group Code", '9999');
                        end;
                end;

                _TodayFuneral.Applicant := _Temp_Today.m_name;
                _TodayFuneral."Mobile No." := _Temp_Today.t_phone;
                _TodayFuneral."Phone No." := _Temp_Today.t_tel;

                _TodayFuneral.Address := CopyStr(_Temp_Today.t_addr, 1, 50);
                _TodayFuneral."Address 2" := CopyStr(_Temp_Today.t_addr, 51, 100);
                _TodayFuneral.Remark := _Temp_Today.memo;

                _TodayFuneral."Arrival Time" := ConvertTime(_Temp_Today.t_time); //……’°“ú(‰ª°‘÷€Ë - ……’°‰‘ñ“ú)
                _TodayFuneral."Opening Time" := ConvertTime(_Temp_Today.t_btime);//—Ÿý“ú(‰ª°‘÷€Ë - ……’°“ú)
                _TodayFuneral.Size := _Temp_Today.m_lentyard;
                _TodayFuneral.Status := _TodayFuneral.Status::Complete;
                _TodayFuneral.Idx := _Temp_Today.Idx;

                _Employee.Reset;
                _Employee.SetRange(Name, _Temp_Today.modifier);
                if _Employee.FindSet then begin
                    _TodayFuneral."Creation Person" := _Employee.Name;
                    _TodayFuneral."Last Modified Person" := _Employee.Name;
                end;

                //„“€Ø‘÷ —Š Complate “‚ˆ«—¯!
                if _TodayFuneral.Date <= Today then
                    _TodayFuneral.Status := _TodayFuneral.Status::Complete;

                _TodayFuneral.Insert(true);

                //Date
                _TodayFuneral."Creation Date" := _Temp_Today.insertDate;
                _TodayFuneral."Last Date Modified" := _Temp_Today.insertDate;
                _TodayFuneral.Modify;

                if _Temp_Today.t_name <> '' then begin
                    _TodayFuneralLine.Init;
                    _TodayFuneralLine."Document No." := _TodayFuneral."No.";
                    _TodayFuneralLine."Line No." := 10000;
                    _TodayFuneralLine."Contract No." := _TodayFuneral."Contract No.";
                    _TodayFuneralLine."Cemetery Code" := _TodayFuneral."Cemetery Code";
                    _TodayFuneralLine."Cemetery No." := _TodayFuneral."Cemetery No.";
                    _TodayFuneralLine.Name := _Temp_Today.t_name;
                    _TodayFuneralLine.Location := _Temp_Today.t_btype;
                    _TodayFuneralLine.Insert;
                end;

                if _Temp_Today.t_name2 <> '' then begin
                    _TodayFuneralLine.Init;
                    _TodayFuneralLine."Document No." := _TodayFuneral."No.";
                    _TodayFuneralLine."Line No." := 20000;
                    _TodayFuneralLine."Contract No." := _TodayFuneral."Contract No.";
                    _TodayFuneralLine."Cemetery Code" := _TodayFuneral."Cemetery Code";
                    _TodayFuneralLine."Cemetery No." := _TodayFuneral."Cemetery No.";
                    _TodayFuneralLine.Name := _Temp_Today.t_name2;
                    _TodayFuneralLine.Location := _Temp_Today.t_btype2;
                    _TodayFuneralLine.Insert;
                end;


            until _Temp_Today.Next = 0;
        end;
    end;

    local procedure UploadService()
    var
        _Temp_CemService: Record Temp_Ceme_Service;
        _CemeteryServices: Record "DK_Cemetery Services";
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Employee: Record DK_Employee;
        _Contract: Record DK_Contract;
        _ContractNo: Code[20];
    begin

        _CemeteryServices.Reset;
        if _CemeteryServices.FindSet then
            _CemeteryServices.DeleteAll;

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Cem. Services Nos.");

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetRange("Series Code", _FunctionSetup."Cem. Services Nos.");
        if _NoSeriesLine.FindSet then begin
            _NoSeriesLine."Last No. Used" := '';
            _NoSeriesLine.Modify;
        end;

        Commit;
        //=================================================================================
        _Temp_CemService.Reset;
        _Temp_CemService.SetFilter(tid, '<>%1', '');
        _Temp_CemService.SetFilter(tag, '<>%1&<>%2', '', '—Î˜¡„Ô—Ê');
        if _Temp_CemService.FindSet then begin
            repeat

                Clear(_ContractNo);

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_CemService.tid);
                _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
                if _Contract.FindSet then begin
                    _ContractNo := _Contract."No.";
                end else begin
                    _Contract.Reset;
                    _Contract.SetCurrentKey("Revocation Date");
                    _Contract.SetRange("Cemetery No.", _Temp_CemService.tid);
                    _Contract.SetRange(Status, _Contract.Status::Revocation);
                    if _Contract.FindLast then
                        _ContractNo := _Contract."No.";
                end;


                _Contract.Reset;
                _Contract.SetRange("No.", _ContractNo);
                if _Contract.FindSet then begin

                    _CemeteryServices.Init;
                    _CemeteryServices."No." := '';

                    _CemeteryServices."Contract No." := _Contract."No.";

                    _CemeteryServices."Supervise No." := _Contract."Supervise No.";
                    _CemeteryServices."Cemetery Code" := _Contract."Cemetery Code";
                    _CemeteryServices."Main Customer No." := _Contract."Main Customer No.";

                    _CemeteryServices."Receipt Date" := ConvertDate(_Temp_CemService.indate);
                    _CemeteryServices."Appl. Name" := _Temp_CemService.mname;


                    case _Temp_CemService.tag of

                        '‹Ï“š':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '006');
                        '”ÏŒ¡Š±Š':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '007');
                        'Œ«“ÊŒ¡Š±Š':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '008');
                        '‰ª•¸Œ¡Š±Š':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '009');
                        '‘†µ„Ô—Ê':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '010');
                        'ŠŽ˜—¯óž':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '011');
                        '‹Ý’ðˆ':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '012');
                        '‹Ï‘°º–Ý':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '013');
                        'ˆ•ÎŠ±':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '014');
                        'Ž˜”íŠ±':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '015');

                        '–ð€Ë':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '901');
                        '‰œ–ð€Ë':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '902');
                        '„Ô•Í':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '903');
                        'ˆ«ˆÚ…¿ˆ…':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '904');
                        '•€¯ýˆ«Š±':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '905');

                        '—Ê‹Ï':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '906');
                        'Ô—‘ª°':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '907');

                        '€Ë•ˆ':
                            _CemeteryServices.Validate("Field Work Main Cat. Code", '999');
                        else
                            Error('‰ª‘÷Œ¡Š±Š »—ýí‡» : %1', _Temp_CemService.tag);
                    end;

                    _CemeteryServices.Amount := _Temp_CemService.amtw;
                    _CemeteryServices."Receipt Amount" := _Temp_CemService.amtw;

                    _CemeteryServices.Remarks := _Temp_CemService.remark;

                    if _CemeteryServices.Remarks <> '' then
                        _CemeteryServices.Remarks := _CemeteryServices.Remarks + ' ' + _Temp_CemService.gb
                    else
                        _CemeteryServices.Remarks := _Temp_CemService.gb;


                    if DelChr(_Temp_CemService.wantdate, '=', ' ') <> '' then
                        _CemeteryServices."Desired Date" := ConvertDate(_Temp_CemService.wantdate);

                    if DelChr(_Temp_CemService.resultdate, '=', ' ') <> '' then
                        _CemeteryServices."Work Date" := ConvertDate(_Temp_CemService.resultdate);

                    _CemeteryServices."SMS Send Date" := _CemeteryServices."Work Date";

                    if StrPos(_Temp_CemService.email, '@') = 0 then begin
                        if _CemeteryServices.Remarks = '' then
                            _CemeteryServices.Remarks := _Temp_CemService.email
                        else
                            _CemeteryServices.Remarks := _CemeteryServices.Remarks + ' ' + _Temp_CemService.email;
                    end else begin
                        _CemeteryServices."Appl. E-mail" := _Temp_CemService.email;
                    end;

                    _CemeteryServices."Appl. Phone No." := _Temp_CemService.tel;

                    _CemeteryServices."Corpse Name" := _Temp_CemService.bname;

                    if DelChr(_Temp_CemService.bdate, '=', ' ') <> '' then
                        _CemeteryServices."Date Of Birth" := ConvertDate(_Temp_CemService.bdate);

                    if DelChr(_Temp_CemService.ddate, '=', ' ') <> '' then
                        _CemeteryServices."Death Date" := ConvertDate(_Temp_CemService.ddate);

                    _CemeteryServices."Process Content" := 'œý “Š•Á Ÿ‡“‰°˜ú : ' + _Temp_CemService.seq;

                    case _Temp_CemService.ipkmway of
                        '—÷€¦':
                            _CemeteryServices."Payment Type" := _CemeteryServices."Payment Type"::Card;
                        '”½…Î':
                            _CemeteryServices."Payment Type" := _CemeteryServices."Payment Type"::Bank;
                        'ŒÁ€¦':
                            _CemeteryServices."Payment Type" := _CemeteryServices."Payment Type"::None;
                    end;

                    _CemeteryServices.idx := _Temp_CemService.idx;
                    _CemeteryServices.Insert(true);

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_CemService.writer);
                    if _Employee.FindSet then begin
                        _CemeteryServices."Creation Person" := _Employee.Name;
                    end;

                    _CemeteryServices."Creation Date" := _Temp_CemService.altdate;

                    _CemeteryServices."Last Date Modified" := _Temp_CemService.altdate;

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_CemService.modifier);
                    if _Employee.FindSet then begin
                        _CemeteryServices."Last Modified Person" := _Employee.Name;
                    end;

                    if _CemeteryServices."Receipt Date" <= 20190501D then begin
                        _CemeteryServices.Status := _CemeteryServices.Status::Complete;
                    end else begin
                        case _Temp_CemService.resultgb of
                            '‘óŒ÷':
                                _CemeteryServices.Status := _CemeteryServices.Status::Release;
                            '‘°—Ê':
                                _CemeteryServices.Status := _CemeteryServices.Status::Post;
                            'Ÿ‡ß':
                                _CemeteryServices.Status := _CemeteryServices.Status::Complete;
                            else
                                Error('‰ª‘÷Œ¡Š±Š ‹Ý•’ ‡õ : %1', _Temp_CemService.resultgb);
                        end;
                    end;
                    _CemeteryServices.Modify;
                end;
            until _Temp_CemService.Next = 0;
        end;
    end;

    local procedure UploadPurchContract()
    var
        _Temp_PurchContrct: Record Temp_PurchContrct;
        _PurchaseContract: Record "DK_Purchase Contract";
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeriesLine: Record "No. Series Line";
        _Employee: Record DK_Employee;
        _Vendor: Record DK_Vendor;
        _PurchaseContractAuthority: Record "DK_Purchase Contract Authority";
    begin

        _PurchaseContract.Reset;
        if _PurchaseContract.FindSet then
            _PurchaseContract.DeleteAll;


        _PurchaseContractAuthority.Reset;
        if _PurchaseContractAuthority.FindSet then
            _PurchaseContractAuthority.DeleteAll;
        /*
        _FunctionSetup.GET;
        _FunctionSetup.TESTFIELD("Cem. Services Nos.");
        
        _NoSeriesLine.RESET;
        _NoSeriesLine.SETRANGE("Series Code", _FunctionSetup."Cem. Services Nos.");
        IF _NoSeriesLine.FINDSET THEN BEGIN
          _NoSeriesLine."Last No. Used" := '';
          _NoSeriesLine.MODIFY;
        END;
        */
        Commit;
        //=================================================================================
        _Temp_PurchContrct.Reset;
        if _Temp_PurchContrct.FindSet then begin
            repeat

                _PurchaseContract.Init;
                _PurchaseContract."No." := _Temp_PurchContrct.c_number;
                _PurchaseContract.Title := _Temp_PurchContrct.c_title;
                _PurchaseContract."Contract Date" := DT2Date(_Temp_PurchContrct.c_date);

                if _Temp_PurchContrct.c_one = '' then
                    _PurchaseContract.Relation := _PurchaseContract.Relation::A
                else
                    _PurchaseContract.Relation := _PurchaseContract.Relation::B;

                if _Temp_PurchContrct.c_agency <> 0 then begin
                    _Vendor.Reset;
                    _Vendor.SetRange(Idx, _Temp_PurchContrct.c_agency);
                    if _Vendor.FindSet then begin
                        _PurchaseContract."Vendor No." := _Vendor."No.";
                        _PurchaseContract."Vendor Name" := _Vendor.Name;
                    end;
                end;

                if _Temp_PurchContrct.c_sms = 'Y' then
                    _PurchaseContract.Notice := true
                else
                    _PurchaseContract.Notice := false;

                if _Temp_PurchContrct.c_auto = 'Y' then
                    _PurchaseContract."Automatic Extension" := true
                else
                    _PurchaseContract."Automatic Extension" := false;

                if DT2Date(_Temp_PurchContrct.c_insertDate) = 20000101D then
                    _PurchaseContract."Creation Date" := CreateDateTime(0D, 0T)
                else
                    _PurchaseContract."Creation Date" := _Temp_PurchContrct.c_insertDate;

                _PurchaseContract."Creation Person" := _Temp_PurchContrct.c_insert;

                if DT2Date(_Temp_PurchContrct.c_editDate) = 20000101D then
                    _PurchaseContract."Last Date Modified" := CreateDateTime(0D, 0T)
                else
                    _PurchaseContract."Last Date Modified" := _Temp_PurchContrct.c_editDate;

                _PurchaseContract."Last Modified Person" := _Temp_PurchContrct.c_edit;

                _PurchaseContract.idx := _Temp_PurchContrct.c_idx;

                case _Temp_PurchContrct.c_state of
                    'ÐŽÊ':
                        _PurchaseContract.Status := _PurchaseContract.Status::Contract;
                    'ˆˆ‡ß':
                        _PurchaseContract.Status := _PurchaseContract.Status::Expiration;
                    '“ÔŒ­':
                        _PurchaseContract.Status := _PurchaseContract.Status::Cancel;
                end;

                _PurchaseContract.Insert;

                _PurchaseContractAuthority.Init;
                _PurchaseContractAuthority."Document No." := _PurchaseContract."No.";
                _PurchaseContractAuthority."Line No." := 1;
                _PurchaseContractAuthority."Department Code" := 'T003';
                _PurchaseContractAuthority."Department Name" := 'µ…‘÷°–';
                _PurchaseContractAuthority."First Creater" := true;
                _PurchaseContractAuthority.Insert(true);

                _PurchaseContractAuthority.Init;
                _PurchaseContractAuthority."Document No." := _PurchaseContract."No.";
                _PurchaseContractAuthority."Line No." := 2;
                _PurchaseContractAuthority."Department Code" := 'T002';
                _PurchaseContractAuthority."Department Name" := 'Ï‰½˜ˆÐ–';
                _PurchaseContractAuthority.Insert(true);
            until _Temp_PurchContrct.Next = 0;
        end;

    end;

    local procedure UploadPurchContractLine()
    var
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
        _PurchaseContract: Record "DK_Purchase Contract";
        _Temp_PurchContractLine: Record Temp_PurchContractLine;
        _DocNo: Code[20];
        _NewLineNo: Integer;
    begin

        _PurchaseContractLine.Reset;
        if _PurchaseContractLine.FindSet then
            _PurchaseContractLine.DeleteAll;

        _Temp_PurchContractLine.Reset;
        if _Temp_PurchContractLine.FindSet then begin
            repeat

                if _DocNo <> _Temp_PurchContractLine.ci_number then
                    _NewLineNo := 0;


                _NewLineNo += 1;
                _PurchaseContractLine.Init;
                _PurchaseContractLine."Purchase Contract No." := _Temp_PurchContractLine.ci_number;
                _PurchaseContractLine."Line No." := _NewLineNo;
                _PurchaseContractLine."Contract Amount" := _Temp_PurchContractLine.ci_money;

                _PurchaseContractLine."Contract Date From" := DT2Date(_Temp_PurchContractLine.ci_sdate);
                _PurchaseContractLine."Contract Date To" := DT2Date(_Temp_PurchContractLine.ci_edate);
                _PurchaseContractLine.Remarks := _Temp_PurchContractLine.ci_bigo;

                case _Temp_PurchContractLine.ci_charge of
                    'ý‹Ó–”–«':
                        _PurchaseContractLine.Validate("Department Code", 'T001');
                    '—Œ‚Š‹Šž':
                        _PurchaseContractLine.Validate("Department Code", 'A005');
                    '…Žð–':
                        _PurchaseContractLine.Validate("Department Code", 'T005');
                    'µ…‘÷°–':
                        _PurchaseContractLine.Validate("Department Code", 'T003');
                    '°°ýˆ«Œ­':
                        _PurchaseContractLine.Validate("Department Code", 'T007');
                    else
                        Error('ŠžŒ¡ ‡õ : %1', _Temp_PurchContractLine.ci_charge);
                end;

                if DT2Date(_Temp_PurchContractLine.ci_insertDate) = 20000101D then
                    _PurchaseContractLine."Creation Date" := CreateDateTime(0D, 0T)
                else
                    _PurchaseContractLine."Creation Date" := _Temp_PurchContractLine.ci_insertDate;

                _PurchaseContractLine."Creation Person" := _Temp_PurchContractLine.ci_insert;

                _PurchaseContractLine.idx := _Temp_PurchContractLine.ci_idx;
                _PurchaseContractLine.Insert;

                _PurchaseContractLine.SetContents(_Temp_PurchContractLine.ci_text);

                _DocNo := _Temp_PurchContractLine.ci_number;
            until _Temp_PurchContractLine.Next = 0;
        end;
    end;

    local procedure UpdateContract_StartingDate()
    var
        _Contract: Record DK_Contract;
        _Temp_Money: Record Temp_Money;
    begin

        _Contract.Reset;
        if _Contract.FindSet then begin
            repeat
                _Contract."General Start Date" := 0D;
                _Contract."Land. Arc. Start Date" := 0D;

                _Contract.CalcFields("Landscape Architecture");

                _Temp_Money.Reset;
                _Temp_Money.SetRange(m_id, _Contract."Cemetery No.");
                _Temp_Money.SetFilter(a_type, '<>%1', '‘†µýˆ«Š±');
                _Temp_Money.SetRange(a_edate, Format(_Contract."General Expiration Date", 0, '<Year4><Month,2><Day,2>'));
                if _Temp_Money.FindSet then begin

                    if CheckDate(_Temp_Money.a_sdate) then
                        _Contract."General Start Date" := ConvertDate(_Temp_Money.a_sdate)
                    else
                        Error('%1 Ÿ‰¦ýˆ«Š± “ÁŸ ‡õ : %2', _Contract."No.", _Temp_Money.a_edate);

                    if _Contract."Landscape Architecture" then
                        _Contract."Land. Arc. Start Date" := _Contract."General Start Date";
                end;

                _Temp_Money.Reset;
                _Temp_Money.SetRange(m_id, _Contract."Cemetery No.");
                _Temp_Money.SetFilter(a_type, '=%1', '‘†µýˆ«Š±');
                _Temp_Money.SetRange(a_edate, Format(_Contract."Land. Arc. Expiration Date", 0, '<Year4><Month,2><Day,2>'));
                if _Temp_Money.FindSet then begin

                    if CheckDate(_Temp_Money.a_sdate) then
                        _Contract."Land. Arc. Start Date" := ConvertDate(_Temp_Money.a_sdate)
                    else
                        Error('%1 ‘†µýˆ«Š± “ÁŸ ‡õ : %2', _Contract."No.", _Temp_Money.a_edate);
                end;

                if _Contract."General Start Date" = 0D then
                    _Contract."General Start Date" := _Contract."Contract Date";

                if _Contract."Landscape Architecture" then
                    if _Contract."Land. Arc. Start Date" = 0D then
                        _Contract."Land. Arc. Start Date" := _Contract."Contract Date";

                if _Contract."General Start Date" > _Contract."General Expiration Date" then
                    _Contract."General Start Date" := _Contract."Contract Date";

                if _Contract."Land. Arc. Start Date" > _Contract."Land. Arc. Expiration Date" then
                    _Contract."Land. Arc. Start Date" := _Contract."Contract Date";

                _Contract.Modify;
            until _Contract.Next = 0;
        end;
    end;

    local procedure UpdateCemetery_Master()
    var
        _Cemetery: Record DK_Cemetery;
        _Temp_Myocd: Record Temp_Myocd;
        _CemeteryConf: Record "DK_Cemetery Conformation";
        _CemeteryOpti: Record "DK_Cemetery Option";
        _UnitPriceType: Record "DK_Unit Price Type";
        _CemeteryDigi: Record "DK_Cemetery Digits";
        _TreeType: Record "DK_Tree Type";
        _Estate: Record DK_Estate;
        _Picture: Record DK_Picture;
    begin
        _Temp_Myocd.Reset;
        if _Temp_Myocd.FindSet then begin
            repeat
                _Cemetery.Reset;
                _Cemetery.SetRange("Cemetery No.", _Temp_Myocd.m_id);
                if _Cemetery.FindSet then begin

                    if _Estate.Get(_Cemetery."Estate Code") then
                        _Cemetery."Estate Name" := _Estate.Name;

                    case _Temp_Myocd.m_type of
                        'ˆ•Î':
                            begin
                                _Cemetery."Cemetery Conf. Code" := '01';

                                case DelChr(_Temp_Myocd.m_opt2, '=', ' ') of
                                    '„ÂÎ':
                                        _Cemetery."Cemetery Dig. Code" := 'A001';
                                    '—³Î':
                                        _Cemetery."Cemetery Dig. Code" := 'A002';
                                    '´Š¨':
                                        _Cemetery."Cemetery Dig. Code" := 'A003';
                                    '„Â/—³/´':
                                        _Cemetery."Cemetery Dig. Code" := 'A004';
                                    '':
                                        _Cemetery."Cemetery Dig. Code" := '';
                                    else
                                        Error('ˆ•Î ºŒ÷ í‡» %1', _Temp_Myocd.m_opt2);
                                end;
                            end;
                        'ŠŽ˜':
                            begin
                                _Cemetery."Cemetery Conf. Code" := '02';

                                case DelChr(_Temp_Myocd.m_opt2, '=', ' ') of
                                    '1º':
                                        _Cemetery."Cemetery Dig. Code" := 'B001';
                                    '2º':
                                        _Cemetery."Cemetery Dig. Code" := 'B002';
                                    '4º':
                                        _Cemetery."Cemetery Dig. Code" := 'B003';
                                    '6º':
                                        _Cemetery."Cemetery Dig. Code" := 'B004';
                                    '8º':
                                        _Cemetery."Cemetery Dig. Code" := 'B005';
                                    '10º':
                                        _Cemetery."Cemetery Dig. Code" := 'B006';
                                    '12º':
                                        _Cemetery."Cemetery Dig. Code" := 'B007';
                                    '14º':
                                        _Cemetery."Cemetery Dig. Code" := 'B008';
                                    '16º':
                                        _Cemetery."Cemetery Dig. Code" := 'B009';
                                    '18º':
                                        _Cemetery."Cemetery Dig. Code" := 'B010';
                                    '24º':
                                        _Cemetery."Cemetery Dig. Code" := 'B011';
                                    '32º':
                                        _Cemetery."Cemetery Dig. Code" := 'B012';
                                    '—³Î+—³Î':
                                        begin
                                            _Cemetery."Cemetery Conf. Code" := '07';
                                            _Cemetery."Cemetery Dig. Code" := 'H205';
                                        end;
                                    '':
                                        _Cemetery."Cemetery Dig. Code" := '';
                                    else
                                        Error('ŠŽ˜ ºŒ÷ í‡» %1', _Temp_Myocd.m_opt2);
                                end;
                            end;
                        'Œ÷ˆ±':
                            begin
                                _Cemetery."Cemetery Conf. Code" := '03';

                                case DelChr(_Temp_Myocd.m_opt2, '=', ' ') of
                                    '1º':
                                        _Cemetery."Cemetery Dig. Code" := 'C001';
                                    '2º':
                                        _Cemetery."Cemetery Dig. Code" := 'C002';
                                    '4º':
                                        _Cemetery."Cemetery Dig. Code" := 'C003';
                                    '6º':
                                        _Cemetery."Cemetery Dig. Code" := 'C004';
                                    '8º':
                                        _Cemetery."Cemetery Dig. Code" := 'C005';
                                    '10º':
                                        _Cemetery."Cemetery Dig. Code" := 'C006';
                                    '12º':
                                        _Cemetery."Cemetery Dig. Code" := 'C007';
                                    '14º':
                                        _Cemetery."Cemetery Dig. Code" := 'C008';
                                    '16º':
                                        _Cemetery."Cemetery Dig. Code" := 'C009';
                                    '20º':
                                        _Cemetery."Cemetery Dig. Code" := 'C010';
                                    '':
                                        _Cemetery."Cemetery Dig. Code" := '';
                                    else
                                        Error('Œ÷ˆ± ºŒ÷ í‡» %1', _Temp_Myocd.m_opt2);
                                end;
                            end;
                        '–ÛÎ':
                            begin
                                _Cemetery."Cemetery Conf. Code" := '04';
                                case DelChr(_Temp_Myocd.m_opt2, '=', ' ') of
                                    '1º':
                                        _Cemetery."Cemetery Dig. Code" := 'D001';
                                    '2º':
                                        _Cemetery."Cemetery Dig. Code" := 'D002';
                                    '4º':
                                        _Cemetery."Cemetery Dig. Code" := 'D003';
                                    '5º':
                                        _Cemetery."Cemetery Dig. Code" := 'D004';
                                    '6º':
                                        _Cemetery."Cemetery Dig. Code" := 'D005';
                                    '8º':
                                        _Cemetery."Cemetery Dig. Code" := 'D006';
                                    '10º':
                                        _Cemetery."Cemetery Dig. Code" := 'D007';
                                    '12º':
                                        _Cemetery."Cemetery Dig. Code" := 'D008';
                                    '16º':
                                        _Cemetery."Cemetery Dig. Code" := 'D009';
                                    '24º':
                                        _Cemetery."Cemetery Dig. Code" := 'D010';
                                    '':
                                        _Cemetery."Cemetery Dig. Code" := '';
                                    else
                                        Error('–ÛÎ ºŒ÷ í‡» %1', _Temp_Myocd.m_opt2);
                                end;
                            end;
                        'Š‰—³':
                            begin
                                _Cemetery."Cemetery Conf. Code" := '07';

                                case DelChr(_Temp_Myocd.m_opt2, '=', ' ') of
                                    '2º+4º':
                                        _Cemetery."Cemetery Dig. Code" := 'G001';
                                    '6º+2º':
                                        _Cemetery."Cemetery Dig. Code" := 'G002';
                                    '12º+12º':
                                        _Cemetery."Cemetery Dig. Code" := 'G003';
                                    '16º+16º':
                                        _Cemetery."Cemetery Dig. Code" := 'G004';
                                    '18º+18º':
                                        _Cemetery."Cemetery Dig. Code" := 'G005';
                                    '24º+24º':
                                        _Cemetery."Cemetery Dig. Code" := 'G006';
                                    '„ÂÎ+32º':
                                        _Cemetery."Cemetery Dig. Code" := 'G101';
                                    '12º':
                                        _Cemetery."Cemetery Dig. Code" := 'G200';
                                    '—³Î+16º':
                                        _Cemetery."Cemetery Dig. Code" := 'G201';
                                    '—³Î+18º':
                                        _Cemetery."Cemetery Dig. Code" := 'G202';
                                    '—³Î+24º':
                                        _Cemetery."Cemetery Dig. Code" := 'G203';
                                    '—³Î+32º':
                                        _Cemetery."Cemetery Dig. Code" := 'G204';
                                    '—³Î+—³Î':
                                        _Cemetery."Cemetery Dig. Code" := 'G205';
                                    '':
                                        _Cemetery."Cemetery Dig. Code" := '';
                                    else
                                        Error('Š‰—³ ºŒ÷ í‡» %1', _Temp_Myocd.m_opt2);
                                end;
                            end;
                        else begin
                            _Cemetery."Cemetery Conf. Code" := '';
                            _Cemetery."Cemetery Dig. Code" := '';
                        end;
                    end;

                    if _CemeteryConf.Get(_Cemetery."Cemetery Conf. Code") then
                        _Cemetery."Cemetery Conf. Name" := _CemeteryConf.Name
                    else
                        _Cemetery."Cemetery Conf. Name" := '';

                    if _CemeteryDigi.Get(_Cemetery."Cemetery Conf. Code", _Cemetery."Cemetery Dig. Code") then
                        _Cemetery."Cemetery Dig. Name" := _CemeteryDigi.Name
                    else
                        _Cemetery."Cemetery Dig. Name" := '';


                    case _Temp_Myocd.m_opt1 of
                        'í…Ï—ý':
                            _Cemetery."Cemetery Option Code" := '1GD';
                        'Œ­‚¬‰½':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T001';
                            end;
                        '…³€¾Œ­‚¬‰½':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T002';
                            end;
                        '˜½„Â—‚':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T003';
                            end;
                        '“‹„Â—‚':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T004';
                            end;
                        '°Á„Â—‚':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T005';
                            end;
                        'Šó‚¬‰½':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T006';
                            end;
                        'Š—Ê‚¬‰½':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T007';
                            end;
                        '‘´ˆ±':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T008';
                            end;
                        '‰¦ŒÁ':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T009';
                            end;
                        '€ŒÁ':
                            begin
                                _Cemetery."Cemetery Option Code" := '1NM';
                                _Cemetery."Tree Type Code" := 'T010';
                            end;
                        else
                            _Cemetery."Cemetery Option Code" := '1NM';
                    end;

                    if _CemeteryOpti.Get(_Cemetery."Cemetery Option Code") then
                        _Cemetery."Cemetery Option Name" := _CemeteryOpti.Name
                    else
                        _Cemetery."Cemetery Option Name" := '';

                    if _TreeType.Get(_Cemetery."Tree Type Code") then
                        _Cemetery."Tree Type Name" := _TreeType.Name
                    else
                        _Cemetery."Tree Type Name" := '';

                    case _Temp_Myocd.m_state of
                        '‰ŽÊ‘÷':
                            _Cemetery.Status := _Cemetery.Status::Reserved;
                        'œÎ‘÷':
                            _Cemetery.Status := _Cemetery.Status::BeenTransported;
                        '‰œ–—ˆ•':
                            _Cemetery.Status := _Cemetery.Status::Unsold;
                        'Œ‚‰ª‘÷':
                            _Cemetery.Status := _Cemetery.Status::Laying;
                        'ÐŽÊ‘÷':
                            _Cemetery.Status := _Cemetery.Status::Contracted;
                    end;

                    case _Temp_Myocd.m_stone of
                        'Y':
                            _Cemetery.Stone := true;
                        else
                            _Cemetery.Stone := false;
                    end;

                    //_Cemetery.VALIDATE(Size, _Temp_Myocd.m_yard);

                    _Cemetery."Visual Cemetery No." := _Temp_Myocd.m_cad;
                    _Cemetery.Modify;
                end;
            until _Temp_Myocd.Next = 0;
        end;

        _Cemetery.Reset;
        if _Cemetery.FindSet then begin
            repeat
                ;
                _Picture.Reset;
                _Picture.SetRange("Table ID", DATABASE::DK_Cemetery);
                _Picture.SetRange("Source No.", _Cemetery."Cemetery Code");
                _Picture.SetRange("Source Line No.", 0);
                if not _Picture.FindSet then begin
                    _Picture.Init;
                    _Picture."Table ID" := DATABASE::DK_Cemetery;
                    _Picture."Source No." := _Cemetery."Cemetery Code";
                    _Picture."Source Line No." := 0;
                    _Picture.Insert(true);
                end;
            until _Cemetery.Next = 0;
        end;
    end;

    local procedure UpdateStatusCemetery()
    var
        _Cemetery: Record DK_Cemetery;
        _Temp_Myocd_Status: Record Temp_Myocd_Status;
    begin
        _Temp_Myocd_Status.Reset;
        if _Temp_Myocd_Status.FindSet then begin
            repeat
                _Cemetery.Reset;
                _Cemetery.SetRange("Cemetery No.", _Temp_Myocd_Status.t_id);
                if _Cemetery.FindSet then begin
                    case _Temp_Myocd_Status.myo_type of
                        'œÎ‘÷':
                            _Cemetery.Status := _Cemetery.Status::BeenTransported;
                        'Œ‚‰ª‘÷':
                            _Cemetery.Status := _Cemetery.Status::Laying;
                        '‰ŽÊ‘÷':
                            _Cemetery.Status := _Cemetery.Status::Reserved;
                        'ÐŽÊ‘÷':
                            _Cemetery.Status := _Cemetery.Status::Contracted;
                        '‰œ–—ˆ•':
                            _Cemetery.Status := _Cemetery.Status::Unsold;
                    end;
                    _Cemetery.Modify(false);
                end;
            until _Temp_Myocd_Status.Next = 0;
        end;
    end;

    local procedure UpdateAdminExpenseSourceNo()
    var
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _PayRecDoc: Record "DK_Payment Receipt Document";
    begin

        _PayRecDocLine.Reset;
        _PayRecDocLine.SetCurrentKey("Contract No.");
        _PayRecDocLine.SetFilter("Expiration Date", '>=%1', 20190101D);
        if _PayRecDocLine.FindSet then begin
            repeat
                _PayRecDoc.Reset;
                _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
                _PayRecDoc.SetRange("Document No.", _PayRecDocLine."Document No.");
                if _PayRecDoc.FindSet then begin
                    _AdminExpLedger.Reset;
                    _AdminExpLedger.SetRange("Contract No.", _PayRecDocLine."Contract No.");
                    _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
                    _AdminExpLedger.SetRange(Date, _PayRecDocLine."Start Date", _PayRecDocLine."Expiration Date");

                    if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then
                        _AdminExpLedger.SetRange("Admin. Expense Type", _AdminExpLedger."Admin. Expense Type"::General)
                    else
                        _AdminExpLedger.SetRange("Admin. Expense Type", _AdminExpLedger."Admin. Expense Type"::Landscape);

                    if _AdminExpLedger.FindSet then begin
                        _AdminExpLedger.ModifyAll("Source No.", _PayRecDocLine."Document No.");
                        _AdminExpLedger.ModifyAll("Source Line No.", _PayRecDocLine."Line No.");
                        _AdminExpLedger.ModifyAll("Payment Type", _PayRecDoc."Payment Type");
                    end;
                end;

            until _PayRecDocLine.Next = 0;
        end;
    end;

    local procedure UpdateAdminExpenseReceiptDoc()
    var
        _Contract: Record DK_Contract;
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpLedger2: Record "DK_Admin. Expense Ledger";
    begin

        _Contract.Reset;
        _Contract.SetFilter("General Expiration Date", '>=%1', 20190101D);
        _Contract.SetRange("No.", 'CD0000002');
        if _Contract.FindSet then begin
            repeat
                //General
                _AdminExpLedger.Reset;
                _AdminExpLedger.SetRange("Contract No.", _Contract."No.");
                _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
                _AdminExpLedger.SetRange("Admin. Expense Type", _AdminExpLedger."Admin. Expense Type"::General);
                _AdminExpLedger.SetRange(Date, 0D, _Contract."General Expiration Date");
                _AdminExpLedger.SetRange("Source No.", '');
                if _AdminExpLedger.FindSet then begin
                    _AdminExpLedger.CalcSums(Amount);

                    _AdminExpLedger2.Init;
                    _AdminExpLedger2."Contract No." := _Contract."No.";
                    _AdminExpLedger2.Date := 20181231D;
                    _AdminExpLedger2."Line No." := 1;
                    _AdminExpLedger2."Admin. Expense Type" := _AdminExpLedger2."Admin. Expense Type"::General;
                    _AdminExpLedger2."Ledger Type" := _AdminExpLedger2."Ledger Type"::Receipt;
                    _AdminExpLedger2.Amount := Abs(_AdminExpLedger.Amount);
                    _AdminExpLedger2.Insert;
                end;


            until _Contract.Next = 0;
        end;

        /*
        _Contract.RESET;
        _Contract.SETFILTER("Land. Arc. Expiration Date",'>=%1',190101D);
        IF _Contract.FINDSET THEN BEGIN
          REPEAT
            //General
            _AdminExpLedger.RESET;
            _AdminExpLedger.SETRANGE("Contract No.", _Contract."No.");
            _AdminExpLedger.SETRANGE("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
            _AdminExpLedger.SETRANGE("Admin. Expense Type", _AdminExpLedger."Admin. Expense Type"::Landscape);
            _AdminExpLedger.SETRANGE(Date, 0D, _Contract."Land. Arc. Expiration Date");
            _AdminExpLedger.SETRANGE("Source No.", '');
            IF _AdminExpLedger.FINDSET THEN BEGIN
                _AdminExpLedger.CALCSUMS(Amount);
        
                _AdminExpLedger2.INIT;
                _AdminExpLedger2."Contract No." := _Contract."No.";
                _AdminExpLedger2.Date := 181231D;
                _AdminExpLedger2."Line No." := 1;
                _AdminExpLedger2."Admin. Expense Type" := _AdminExpLedger2."Admin. Expense Type"::Landscape;
                _AdminExpLedger2."Ledger Type" := _AdminExpLedger2."Ledger Type"::Receipt;
                _AdminExpLedger2.Amount := ABS(_AdminExpLedger.Amount);
                _AdminExpLedger2.INSERT;
            END;
          UNTIL _Contract.NEXT = 0;
        END;
        */

    end;

    local procedure UpdatePurchaseContractAuthority()
    var
        _PurchaseContract: Record "DK_Purchase Contract";
        _PurchaseContractAuthority: Record "DK_Purchase Contract Authority";
        _AlarmReceiver: Record "DK_Alarm Receiver";
    begin
        _PurchaseContractAuthority.Reset;
        if _PurchaseContractAuthority.FindSet then
            _PurchaseContractAuthority.DeleteAll;

        _AlarmReceiver.Reset;
        if _AlarmReceiver.FindSet then
            _AlarmReceiver.DeleteAll;

        _PurchaseContract.Reset;
        if _PurchaseContract.FindSet then begin
            repeat
                _PurchaseContractAuthority.Init;
                _PurchaseContractAuthority."Document No." := _PurchaseContract."No.";
                _PurchaseContractAuthority."Line No." := 1;
                _PurchaseContractAuthority."Department Code" := 'T003';
                _PurchaseContractAuthority."Department Name" := 'µ…‘÷°–';
                _PurchaseContractAuthority."First Creater" := true;
                _PurchaseContractAuthority.Insert(true);

                _PurchaseContractAuthority.Init;
                _PurchaseContractAuthority."Document No." := _PurchaseContract."No.";
                _PurchaseContractAuthority."Line No." := 2;
                _PurchaseContractAuthority."Department Code" := 'T002';
                _PurchaseContractAuthority."Department Name" := 'Ï‰½˜ˆÐ–';
                _PurchaseContractAuthority.Insert(true);

                _AlarmReceiver.Init;
                _AlarmReceiver."Document No." := _PurchaseContract."No.";
                _AlarmReceiver."Line No." := 1;
                _AlarmReceiver.Type := _AlarmReceiver.Type::Department;
                _AlarmReceiver.Code := 'T003';
                _AlarmReceiver.Name := 'µ…‘÷°–';
                _AlarmReceiver.Insert;
            until _PurchaseContract.Next = 0;
        end;
    end;

    local procedure UpdateAdminExpenseApply(pNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
    begin

        if pNo <> '' then
            _Contract.SetRange("No.", pNo);
        _Contract.SetFilter(Status, '%1|%2', _Contract.Status::FullPayment, _Contract.Status::Revocation);
        _Contract.SetFilter("Contract Date", '<>%1&<=%2', 0D, Today);
        _Contract.SetFilter("Revocation Date", '=%1|>=%2', 0D, Today);
        if _Contract.FindSet then begin
            repeat
                _Contract.CalcFields("Landscape Architecture");

                //==========================================================================================
                //Apply Entry

                Clear(_ApplyAdminExLedger);
                _ApplyAdminExLedger.FindReceiptLedger(_Contract."No.", _Contract."Admin. Exp. Type Filter"::General, Today);
                if _Contract."Landscape Architecture" then
                    _ApplyAdminExLedger.FindReceiptLedger(_Contract."No.", _Contract."Admin. Exp. Type Filter"::Landscape, Today);
            //==========================================================================================

            until _Contract.Next = 0;
        end;
    end;

    local procedure UpdateContract_ContractCustomers()
    var
        _Contract: Record DK_Contract;
        _Temp_Money: Record Temp_Money;
    begin

        _Contract.Reset;
        if _Contract.FindSet then begin
            repeat
                _Contract.Validate("Main Customer No.");

                if _Contract."Main Customer No." <> '' then
                    _Contract."Contract Customers" := _Contract."Main Customer No.";


                if _Contract."Customer No. 2" <> '' then
                    if _Contract."Contract Customers" = '' then
                        _Contract."Contract Customers" := _Contract."Customer No. 2"
                    else
                        _Contract."Contract Customers" := _Contract."Contract Customers" + '|' + _Contract."Customer No. 2";

                if _Contract."Customer No. 3" <> '' then
                    if _Contract."Contract Customers" = '' then
                        _Contract."Contract Customers" := _Contract."Customer No. 3"
                    else
                        _Contract."Contract Customers" := _Contract."Contract Customers" + '|' + _Contract."Customer No. 3";
                _Contract.Modify;
            until _Contract.Next = 0;
        end;
    end;

    local procedure UpdateCustomerDate()
    var
        _Contract: Record DK_Contract;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin
        _Contract.Reset;
        if _Contract.FindSet then begin
            repeat

                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Payment Date");
                _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                _PayReceiptDoc.SetFilter(IDX, '<>%1', 0);
                _PayReceiptDoc.SetFilter("Line General Amount", '<>%1', 0);
                if _PayReceiptDoc.FindSet then begin
                    _PayReceiptDoc.CalcFields("Line General Start Date");
                    if _PayReceiptDoc."Line General Start Date" <> 0D then
                        _Contract."First General Expiration Date" := _PayReceiptDoc."Line General Start Date" - 1;
                end;

                _Contract.CalcFields("Landscape Architecture");
                if _Contract."Landscape Architecture" then begin
                    _PayReceiptDoc.Reset;
                    _PayReceiptDoc.SetCurrentKey("Payment Date");
                    _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                    _PayReceiptDoc.SetFilter(IDX, '<>%1', 0);
                    _PayReceiptDoc.SetFilter("Line Land. Arc. Amount", '<>%1', 0);
                    if _PayReceiptDoc.FindSet then begin
                        _PayReceiptDoc.CalcFields("Line General Start Date");
                        if _PayReceiptDoc."Line General Start Date" <> 0D then
                            _Contract."First Land. Arc. Exp. Date" := _PayReceiptDoc."Line General Start Date" - 1;
                    end;
                end;

                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Payment Date");
                _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                _PayReceiptDoc.SetRange(IDX, 0);
                if _PayReceiptDoc.FindLast then begin
                    _Contract."Rem. Amount Posting Date" := _PayReceiptDoc."Payment Date";
                end;

                _Contract.Modify;
            until _Contract.Next = 0
        end;
    end;

    local procedure UploadSendedSMSHistoryEntryNo()
    var
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _Number: Record "Integer";
    begin

        _Number.Reset;
        _Number.SetRange(Number, 1, 98);
        if _Number.FindSet then begin
            repeat
                _SendedSMSHistory.Init;
                _SendedSMSHistory."Entry No." := 0;
                _SendedSMSHistory."Sending Date" := Today;
                _SendedSMSHistory.Subject := Format(_Number.Number);
                _SendedSMSHistory.Insert(true);
            until _Number.Next = 0;
        end;
        /*
        _SendedSMSHistory.RESET;
        IF _SendedSMSHistory.FINDSET THEN
          _SendedSMSHistory.DELETEALL;
        */

    end;

    local procedure UploadMemberShipCard()
    var
        _Temp_MemberShipCard: Record Temp_MemberShipCard;
        _CustomerCertficateHistory: Record "DK_Customer Certficate History";
        _Employee: Record DK_Employee;
        _Contract: Record DK_Contract;
        _NewEntryNo: Integer;
    begin

        _CustomerCertficateHistory.Reset;
        if _CustomerCertficateHistory.FindSet then
            _CustomerCertficateHistory.DeleteAll;

        _Temp_MemberShipCard.Reset;
        if _Temp_MemberShipCard.FindSet then begin
            repeat

                _NewEntryNo += 1;

                _Contract.Reset;
                _Contract.SetRange("Cemetery No.", _Temp_MemberShipCard.m_id);
                if _Contract.FindSet then begin

                    _CustomerCertficateHistory.Init;
                    _CustomerCertficateHistory."Entry No." := _NewEntryNo;
                    _CustomerCertficateHistory."Document No." := _Temp_MemberShipCard.Card_No;
                    _CustomerCertficateHistory.Validate(Apprval, true);

                    _Employee.Reset;
                    _Employee.SetRange("Bef. No.", _Temp_MemberShipCard.Create_ID);
                    if _Employee.FindSet then begin
                        _CustomerCertficateHistory.Validate("Allow Employee No.", _Employee."No.");
                        _CustomerCertficateHistory.Validate("Allow Employee Name", _Employee.Name);
                        _CustomerCertficateHistory.Validate("Req. Employee No.", _Employee."No.");
                        _CustomerCertficateHistory.Validate("Req. Employee Name", _Employee.Name);
                    end;

                    _CustomerCertficateHistory."Allow Mem. Printing DateTime" := _Temp_MemberShipCard.Create_Dt;
                    _CustomerCertficateHistory."Member. Request Date" := Variant2Date(_Temp_MemberShipCard.Create_Dt);

                    _CustomerCertficateHistory.Validate("Contract No.", _Contract."No.");
                    _CustomerCertficateHistory.Validate("Cemetery Code", _Contract."Cemetery Code");
                    _CustomerCertficateHistory.Validate("Main Customer No.", _Contract."Main Customer No.");
                    _CustomerCertficateHistory.Insert;
                end;



            until _Temp_MemberShipCard.Next = 0;
        end;
    end;

    local procedure InsertPaymentReceiptDoc(pDate: Date; pRemark: Text[50]; pReceiptBank: Code[20]; pAmount: Decimal)
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin

        _PayReceiptDoc.Init;
        _PayReceiptDoc."Document No." := '';
        _PayReceiptDoc."Payment Date" := pDate;
        _PayReceiptDoc.Amount := pAmount;
        _PayReceiptDoc."Payment Type" := _PayReceiptDoc."Payment Type"::Bank;
        _PayReceiptDoc.Validate("Bank Account Code", pReceiptBank);
        _PayReceiptDoc."Posting Date" := _PayReceiptDoc."Payment Date";
        _PayReceiptDoc."Missing Contract" := true;
        _PayReceiptDoc.Description := pRemark;

        _PayReceiptDoc.Posted := true;
        _PayReceiptDoc.Insert(true);
    end;

    local procedure SplitName(pName: Text; var pRtnName1: Text; var pRtnName2: Text; var pRtnName3: Text)
    var
        _strPos: Integer;
        _strPos1: Integer;
        _NewName: Text;
    begin

        _strPos := StrPos(pName, ',');

        if _strPos <> 0 then begin
            pRtnName1 := DelChr(CopyStr(pName, 1, _strPos - 1), '=', ' ');
            _NewName := CopyStr(pName, _strPos + 1, StrLen(pName));
            _strPos := 0;
        end;


        _strPos := StrPos(_NewName, ',');

        if _strPos <> 0 then begin
            pRtnName2 := DelChr(CopyStr(_NewName, 1, _strPos - 1), '=', ' ');
            _NewName := CopyStr(_NewName, _strPos + 1, StrLen(_NewName));
            _strPos := 0;

        end else begin
            if _NewName <> '' then begin
                pRtnName2 := _NewName;
                _NewName := '';
            end;
        end;

        _strPos := StrPos(_NewName, ',');

        if _strPos <> 0 then begin
            pRtnName3 := DelChr(CopyStr(_NewName, 1, StrLen(_NewName)), '=', ' ');

        end;
    end;

    local procedure CheckDate(pStrDate: Text[8]): Boolean
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _AlDay: Integer;
    begin
        if pStrDate = '' then exit(false);

        if pStrDate in ['19850229', '19910229', '20070229', '20110229', '20150229', '20170229', '20190229', '20210229', '02210216',
          '02210216', '17000815', '17000815', '17400118', '17380204', '19930931', '19880631', '19949821', '19770230', '19770631', '09811004',
          '10861209'] then
            exit(false);

        Evaluate(_Year, CopyStr(pStrDate, 1, 4));
        Evaluate(_Month, CopyStr(pStrDate, 5, 2));
        Evaluate(_Day, CopyStr(pStrDate, 7, 2));

        if (_Year < 1900) or (_Year > 2100) then
            exit(false);

        if (_Month < 1) or (_Month > 12) then
            exit(false);

        _AlDay := Date2DMY(CalcDate('<+CM>', (DMY2Date(1, _Month, _Year))), 1);

        if _AlDay < _Day then
            exit(false);


        exit(true);
    end;


    procedure ConvertDate(pStrDate: Text[8]): Date
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
    begin

        //IF pStrDate = '' THEN EXIT(0D);
        pStrDate := DelChr(pStrDate, '=', ' ');
        if pStrDate in ['', '02210216', '17000815', '17000815', '17400118', '17380204', '19930931', '19880631', '19949821', '19770230', '19770631'
          ] then
            exit(0D);

        if pStrDate = '19850229' then
            pStrDate := '19850301';
        if pStrDate = '19910229' then
            pStrDate := '19910301';
        if pStrDate = '20070229' then
            pStrDate := '20070301';
        if pStrDate = '20110229' then
            pStrDate := '20110301';
        if pStrDate = '20150229' then
            pStrDate := '20150301';
        if pStrDate = '20170229' then
            pStrDate := '20170301';
        if pStrDate = '20190229' then
            pStrDate := '20190301';
        if pStrDate = '20210229' then
            pStrDate := '20210301';
        if pStrDate = '2000926' then
            pStrDate := '20000926';
        if pStrDate = '00160524' then
            pStrDate := '20160524';


        Evaluate(_Year, CopyStr(pStrDate, 1, 4));
        Evaluate(_Month, CopyStr(pStrDate, 5, 2));
        Evaluate(_Day, CopyStr(pStrDate, 7, 2));

        exit(DMY2Date(_Day, _Month, _Year));
    end;

    local procedure FindCustomer(pIDX: Text[20]): Code[20]
    var
        _Customer: Record DK_Customer;
    begin

        _Customer.Reset;
        _Customer.SetRange(Idx, pIDX);
        if _Customer.FindSet then
            exit(_Customer."No.");
    end;

    local procedure GetGender(pRec: Record Temp_Corpse; var pGender1: Option; var pGender2: Option; var pGender3: Option)
    var
        _Corpse: Record DK_Corpse;
    begin


        if pRec.t_reg1 <> '' then begin
            case pRec.t_reg1 of
                ////
                // '‚/‚Ê', '111111-1111111', '‚.', '111111111111', '111111-111111', '1111111-', '111111111111', '520105125225', '308041150614', '600101-135732', '‚/', '11111111111', '1111111111111',
                //   '11111', '1', '11', '‚', '111111', '1111111', '210503167318', '11111-111111', '1111111111', '480623-1', 'œÎ-1111111', '111111111',
                //   '260705-1', '4011201228', '120808-1', '590515-1', '640520-1', '110711118921', '240405102220', '220730101113', '320511052111'
                '‚/‚Ê', '111111-1111111', '‚.', '111111111111-T', '111111-111111', '1111111-', '111111111111', '520105125225', '308041150614', '600101-135732', '‚/', '11111111111', '1111111111111',
                  '11111', '1', '11', '‚', '111111', '1111111', '210503167318', '11111-111111', '1111111111', '480623-1', 'œÎ-1111111', '111111111',
                  '260705-1', '4011201228', '120808-1', '590515-1', '640520-1', '110711118921', '240405102220', '220730101113', '320511052111'
                  :
                    begin
                        pGender1 := _Corpse.Gender::Male;
                        pGender2 := _Corpse.Gender::Female;
                    end;
                // '‚Ê/‚', '/‚', '222222-2222222', '222222222222', '370214200519', '430211200613', '22222222222', '2222222222', '222222-222222'
                //   , '22222', '222222', '2', '2222222222222''190711206611', '', '222222222', '22222222', 'œÎ-2222222', '22222-222222',
                //   '260409056721', '221081823114', '170828200514', '22222-222222', '250701201118', '220428-2', '270205-2', '160923235021',
                //   '030610204817', '290209200617'
                ////
                '‚Ê/‚', '/‚', '222222-2222222', '222222222222', '370214200519', '430211200613', '22222222222', '2222222222', '222222-222222'
                , '22222', '222222', '2', '2222222222222''190711206611', '', '222222222', '22222222', 'œÎ-2222222', '22222-222222',
                '260409056721', '221081823114', '170828200514', '22222-222222-T', '250701201118', '220428-2', '270205-2', '160923235021',
                '030610204817', '290209200617'
                    :
                    begin
                        pGender1 := _Corpse.Gender::Female;
                        pGender2 := _Corpse.Gender::Male;
                    end;
                '‚,.‚', '‚,,‚':
                    begin
                        pGender1 := _Corpse.Gender::Male;
                        pGender2 := _Corpse.Gender::Female;
                        pGender3 := _Corpse.Gender::Male;
                    end;
                '‚/À':
                    begin
                        pGender1 := _Corpse.Gender::Male;
                    end;
                else begin
                    if StrLen(pRec.t_reg1) = 14 then begin
                        case CopyStr(pRec.t_reg1, 8, 1) of
                            '1', '3', '5', '7', '9':
                                pGender1 := _Corpse.Gender::Male;
                            '2', '4', '6', '8', '0':
                                pGender1 := _Corpse.Gender::Female;
                        end;
                    end else
                        if StrLen(pRec.t_reg1) = 13 then begin
                            case CopyStr(pRec.t_reg1, 7, 1) of
                                '1', '3', '5', '7', '9':
                                    pGender1 := _Corpse.Gender::Male;
                                '2', '4', '6', '8', '0':
                                    pGender1 := _Corpse.Gender::Female;
                            end;
                        end;
                end;
            end;
        end;
    end;

    local procedure ConvertTime(pTime: Text[4]): Time
    var
        _Time: Text[2];
        _Min: Text[2];
        _NewTime: Time;
    begin

        pTime := DelChr(pTime, '=', ' ');

        if pTime = '?' then pTime := '';
        if pTime = '0000' then pTime := '';
        if pTime = '07:0' then pTime := '0700';
        if pTime = '1' then pTime := '1300';
        if pTime = '1:30' then pTime := '1330';
        if pTime = '10' then pTime := '1000';
        if pTime = '10:0' then pTime := '1000';
        if pTime = '100' then pTime := '1000';
        if pTime = '10“' then pTime := '1000';
        if pTime = '11' then pTime := '1100';
        if pTime = '11:0' then pTime := '1100';
        if pTime = '11;0' then pTime := '1100';
        if pTime = '11“' then pTime := '1100';
        if pTime = '12' then pTime := '1200';
        if pTime = '12:0' then pTime := '1200';
        if pTime = '15' then pTime := '1500';
        if pTime = '16' then pTime := '1600';
        if pTime = '2:00' then pTime := '1400';
        if pTime = '2:30' then pTime := '1430';
        if pTime = '3:00' then pTime := '1500';
        if pTime = '8:50' then pTime := '0850';
        if pTime = '9:00' then pTime := '0900';
        if pTime = '9:30' then pTime := '0930';
        if pTime = '9:40' then pTime := '0940';
        if pTime = '9~10' then pTime := '1000';
        if pTime = '……’°“' then pTime := '';
        if pTime = '‰ÀŠ' then pTime := '';
        if pTime = 'ý' then pTime := '';
        if pTime = '˜”' then pTime := '';

        if pTime = '' then
            exit(0T);

        _Time := CopyStr(pTime, 1, 2);
        _Min := CopyStr(pTime, 3, 2);

        Evaluate(_NewTime, StrSubstNo('%1:%2', _Time, _Min));

        exit(_NewTime);
    end;
}

