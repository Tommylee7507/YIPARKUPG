codeunit 50026 "DK_CRM Interface Mgt."
{
    // --TextCustCUUrls := http://ygroupapi.trueinfo.co.kr/YGroupService.svc/CreateUpdateCRMContact
    // --TextContCUUrls := http://ygroupapi.trueinfo.co.kr/YGroupService.svc/UpdateCRMContract
    // 
    // #2130 : 20200831
    //   - Modify Function: InterlinkConwithCRMLogRecord
    // 
    // *DK34 : 20201019
    //   - Modify Function: SendCRM_UpdateCRMContract
    // 
    // DK35: 20210120
    //   - Add Function: InterlinkFrwithCRMLogRecord, SendCRM_FriendsAndRelatives, SendCRM_CreateUpdateCRMFr


    trigger OnRun()
    begin

        //SendCRM_Contact;
    end;

    var
        UTF8FilePath: Text;
        Body: Text;
        MSG001: Label 'CRM Error Message : %1';
        FunSetup: Record "DK_Function Setup";


    procedure InterlinkCuswithCRMLogRecord(pCust: Record DK_Customer; pDel: Boolean)
    var
        _DK_InterlinkCuswithCRMLog: Record "DK_Interlink Cus. with CRM Log";
    begin
        with _DK_InterlinkCuswithCRMLog do begin
            Init;
            "Entry No." := 0;
            "Data Type" := "Data Type"::Outbound;
            "Data Date" := Today;
            "Customer No." := pCust."No.";
            Name := pCust.Name;
            "Post Code" := pCust."Post Code";
            Address := pCust.Address;
            "Address 2" := pCust."Address 2";
            "Phone No." := pCust."Phone No.";
            Type := pCust.Type;
            "E-mail" := pCust."E-mail";
            Birthday := pCust.Birthday;
            Gender := pCust.Gender;
            "Company Post Code" := pCust."Company Post Code";
            "Company Address" := pCust."Company Address";
            "Company Address 2" := pCust."Company Address 2";
            "Mobile No." := pCust."Mobile No.";
            Description := '';
            "VAT Registration No." := pCust."VAT Registration No.";
            Memo := pCust.Memo;

            "Personal Data" := pCust."Personal Data";
            "Marketing SMS" := pCust."Marketing SMS";
            "Marketing Phone" := pCust."Marketing Phone";
            "Marketing E-Mail" := pCust."Marketing E-Mail";
            "Personal Data Third Party" := pCust."Personal Data Third Party";
            "Personal Data Referral" := pCust."Personal Data Referral";
            "Personal Data Concu. Date" := pCust."Personal Data Concu. Date";

            pCust.CalcFields("SSN Encyption");
            "SSN Encyption" := pCust."SSN Encyption";
            "Record Del" := pDel;
            "Applied Date" := 0D;
            Insert(true);
        end;

        SendCRM_Customer;
    end;

    local procedure SendCRM_CreateUpdateCRMCustomer(pDK_InterlinkCuswithCRMLog: Record "DK_Interlink Cus. with CRM Log"): Boolean
    var
        _Cust: Record DK_Customer;
    begin
        //Json Structure


        FunSetup.Get;
        FunSetup.TestField("CRM Customer URL");


        with pDK_InterlinkCuswithCRMLog do begin
            Body := '';
            Body += '{ ';
            Body += ' "No" : ';
            Body += '"' + "Customer No." + '" ';
            Body += ' , "Name" : ';
            Body += '"' + Name + '" ';
            Body += ' , "Type" : ';
            if Type = Type::Corporation then
                Body += 'true '
            else
                Body += 'false ';
            Body += ' , "Mobile" : ';
            Body += '"' + "Mobile No." + '" ';
            Body += ' , "EMail" : ';
            Body += '"' + "E-mail" + '" ';
            Body += ' , "Address" : ';
            Body += '"' + Address + '" ';
            Body += ' , "AddressDetail" : ';
            Body += '"' + "Address 2" + '" ';
            Body += ' , "CompanyPostNo" : ';
            Body += '"' + "Company Post Code" + '" ';
            Body += ' , "CompanyAddress" : ';
            Body += '"' + "Company Address" + '" ';
            Body += ' , "CompanyAddressDetail" : ';
            Body += '"' + "Company Address 2" + '" ';
            Body += ' , "isDelete" : ';
            if "Record Del" then
                Body += 'true'
            else
                Body += 'false';
            if _Cust.Get("Customer No.") then begin
                Body += ' , "RRNo" : ';
                Body += '"' + _Cust.GetSSNSSNCalculated + '" ';
            end;
            Body += ' , "Tel" : ';
            Body += '"' + "Phone No." + '" ';
            Body += ' , "Gender" : ';
            if Gender = Gender::Female then
                Body += '2 '
            else
                Body += '1 ';

            //‚ž‘ñŠˆ ˜«Ô …—
            Body += ' , "PersonalDataYN" : ';
            if "Personal Data" then
                Body += 'true'
            else
                Body += 'false';
            //ˆ†”™–“‘ñŠˆ‘ª°…—(SMS)
            Body += ' , "MarketingSMSYN" : ';
            if "Marketing SMS" then
                Body += 'true'
            else
                Body += 'false';
            //ˆ†”™–“‘ñŠˆ‘ª°…—(ý˜¡)
            Body += ' , "MarketingPhoneYN" : ';
            if "Marketing Phone" then
                Body += 'true'
            else
                Body += 'false';
            //ˆ†”™–“‘ñŠˆ‘ª°…—(œˆÃŸ)
            Body += ' , "MarketingEMailYN" : ';
            if "Marketing E-Mail" then
                Body += 'true'
            else
                Body += 'false';
            //‚ž‘ñŠˆ‘ª3À‘ª°…—
            Body += ' , "PersonalDataThirdPartyYN" : ';
            if "Personal Data Third Party" then
                Body += 'true'
            else
                Body += 'false';
            //‚ž‘ñŠˆ“‚ˆ«º•‰…—
            Body += ' , "PersonalDataReferralYN" : ';
            if "Personal Data Referral" then
                Body += 'true'
            else
                Body += 'false';

            //‚ž‘ñŠˆ˜Ô…—ŸÀ
            Body += ' , "PersonalDataConcurrenceDate" : ';
            if "Personal Data Concu. Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("Personal Data Concu. Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';

            Body += ' }';
        end;

        //IF UPPERCASE(USERID) = 'DONGHYUN.KIM' THEN
        //  MESSAGE('1 - %1',Body);

        //Create File & Body
        CreateServerFileUTF8;

        //Send Request
        // if not SendWebRequest(FunSetup."CRM Customer URL") then////zzz
        //     exit(false);

        exit(true);
    end;


    procedure SendCRM_Customer()
    var
        _DK_InterlinkCuswithCRMLog: Record "DK_Interlink Cus. with CRM Log";
    begin
        //Check Use CRM Interface
        if not UseCRMInterface then
            exit;

        with _DK_InterlinkCuswithCRMLog do begin
            Reset;
            SetRange("Data Type", "Data Type"::Outbound);
            SetRange("Applied Date", 0D);
            if FindSet then
                repeat
                    if SendCRM_CreateUpdateCRMCustomer(_DK_InterlinkCuswithCRMLog) then begin
                        "Applied Date" := Today;
                        Modify;
                    end;
                until Next = 0;
        end;
    end;


    procedure InterlinkConwithCRMLogRecord(pContract: Record DK_Contract)
    var
        _DK_InterlinkConwithCRMLog: Record "DK_Interlink Con. with CRM Log";
    begin
        with _DK_InterlinkConwithCRMLog do begin
            Init;
            "Entry No." := 0;
            "Data Type" := "Data Type"::Outbound;
            "Data Date" := Today;
            "Contract No." := pContract."No.";
            "Main Customer No." := pContract."Main Customer No.";
            "Customer No. 2" := pContract."Customer No. 2";
            "Customer No. 3" := pContract."Customer No. 3";
            Status := pContract.Status;
            "Deposit Amount" := pContract."Deposit Amount";
            "Contract Amount" := pContract."Contract Amount";
            "Rece. Remaining Amount" := pContract."Rece. Remaining Amount";
            "Deposit Receipt Date" := pContract."Deposit Receipt Date";
            "Alarm Period 1" := CreateDateTime(pContract."Alarm Period 1", 0T);
            //"Send Alarm Date/Time 1" := pContract."Send Alarm Date/Time 1";
            "Alarm Period 2" := CreateDateTime(pContract."Alarm Period 2", 0T);
            //"Send Alarm Date/Time 2" := '';
            //>>#2130
            pContract.CalcFields("Revocation Register");
            //<<
            "Revocation Register" := pContract."Revocation Register";
            "Revocation Date" := pContract."Revocation Date";
            "General Expiration Date" := pContract."General Expiration Date";
            "Land. Arc. Expiration Date" := pContract."Land. Arc. Expiration Date";
            "Associate Name" := pContract."Associate Name";
            "Associate Mobile No." := pContract."Associate Mobile No.";
            "Associate Phone No." := pContract."Associate Phone No.";
            "Associate E-Mail" := pContract."Associate E-Mail";
            "Associate Post Code" := pContract."Associate Post Code";
            "Associate Address" := pContract."Associate Address";
            "Associate Address 2" := pContract."Associate Address 2";
            "Applied Date" := 0D;
            Insert(true);
        end;
        SendCRM_Contract;
    end;


    procedure SendCRM_Contract()
    var
        _DK_InterlinkConwithCRMLog: Record "DK_Interlink Con. with CRM Log";
    begin
        //Check Use CRM Interface
        if not UseCRMInterface then
            exit;

        //IF _DK_InterlinkConwithCRMLog."Contract No." = '20220830006' THEN
        //  MESSAGE('%1',_DK_InterlinkConwithCRMLog);

        with _DK_InterlinkConwithCRMLog do begin
            Reset;
            SetRange("Data Type", "Data Type"::Outbound);
            SetRange("Applied Date", 0D);
            if FindSet then
                repeat
                    if SendCRM_UpdateCRMContract(_DK_InterlinkConwithCRMLog) then begin
                        "Applied Date" := Today;
                        Modify;
                    end;
                until Next = 0;
        end;
    end;

    local procedure SendCRM_UpdateCRMContract(pDK_InterlinkConwithCRMLog: Record "DK_Interlink Con. with CRM Log"): Boolean
    var
        _Cust: Record DK_Customer;
        _CR: Char;
        _LR: Char;
    begin
        //Json Structure

        FunSetup.Get;
        FunSetup.TestField("CRM Contract URL");

        _CR := 13;
        _LR := 10;

        with pDK_InterlinkConwithCRMLog do begin
            Body := '';
            Body += '{ ';
            //ÐŽÊ‰°˜ú
            Body += ' "ContractNo" : ';
            Body += '"' + "Contract No." + '" ';

            //‘´ ÐŽÊÀ
            Body += ' , "MainCustomer" : ';
            Body += '"' + "Main Customer No." + '" ';

            //°…ˆ×—2
            Body += ' , "SubCustomer1" : ';
            Body += '"' + "Customer No. 2" + '" ';
            //°…ˆ×—3
            Body += ' , "SubCustomer2" : ';
            Body += '"' + "Customer No. 3" + '" ';
            //‹Ý•’
            Body += ' , "ERPStatus" : ';
            if Status = Status::Open then begin
                Body += '"100000000" ';
            end else
                if Status = Status::Reservation then begin
                    Body += '"100000001" ';
                end else
                    if Status = Status::TempContract then begin
                        Body += '"100000002" ';
                    end else
                        if Status = Status::Contract then begin
                            Body += '"100000003" ';
                        end else
                            if Status = Status::Revocation then begin
                                Body += '"100000004" ';
                            end;
            //‚‚Šž…˜ ‰ŽÊ€¦
            Body += ' , "SubScriptionPrice" : ';
            Body += ' ' + DelChr(Format("Deposit Amount"), '=', ',') + ' ';
            //‚‚Šž…˜ ÐŽÊ€¦
            Body += ' , "FirstAmount" : ';
            Body += ' ' + DelChr(Format("Contract Amount"), '=', ',') + ' ';
            //‚‚Šž…˜ ÐŽÊ€¦ —³Ð (‰ŽÊ€¦+ÐŽÊ€¦)
            Body += ' , "TotContractAmt" : ';
            Body += ' ' + DelChr(Format(+"Deposit Amount" + "Contract Amount"), '=', ',') + ' ';

            //‚‚Šž…˜ Â€¦
            Body += ' , "LastAmount" : ';
            Body += ' ' + DelChr(Format("Rece. Remaining Amount"), '=', ',') + ' ';
            //‰ŽÊ€¦ ¯€¦Ÿ
            Body += ' , "SubScriptionPriceInDate" : ';
            if "Deposit Receipt Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("Deposit Receipt Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';
            //ÐŽÊ€¦ ¯€¦Ÿ
            Body += ' , "FirstAmountInDate" : ';
            if "Pay. Contract Rece. Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("Pay. Contract Rece. Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';
            //Â€¦ ¯€¦Ÿ
            Body += ' , "LastAmountInDate" : ';
            if "Remaining Receipt Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("Remaining Receipt Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';
            //Â€¦ ‰œ‚‚ Ž›†ð €Ëú 1
            Body += ' , "AlarmPeriod1" : ';
            if "Alarm Period 1" = CreateDateTime(0D, 0T) then
                Body += ' "" '
            else
                Body += ' "' + Format("Alarm Period 1", 0, '<Year4>-<Month,2>-<Day,2>') + '"';
            //Â€¦ ‰œ‚‚ Ž›†ð €Ëú 2
            Body += ' , "AlarmPeriod2" : ';
            if "Alarm Period 2" = CreateDateTime(0D, 0T) then
                Body += ' "" '
            else
                Body += ' "' + Format("Alarm Period 2", 0, '<Year4>-<Month,2>-<Day,2>') + '"';
            //Â€¦ ‰œ‚‚ Ž›†ð ‰ÈŒÁ ŸÀ/“ú1
            Body += ' , "SendAlarmDateTime1" : ';
            if "Send Alarm Date/Time 1" = CreateDateTime(0D, 0T) then
                Body += ' "" '
            else
                Body += ' "' + Format("Send Alarm Date/Time 1", 0, '<Year4>-<Month,2>-<Day,2> <Hours24>:<Minutes,2>:<Seconds,2>') + '"';

            //Â€¦ ‰œ‚‚ Ž›†ð ‰ÈŒÁ ŸÀ/“ú2
            Body += ' , "SendAlarmDateTime2" : ';
            if "Send Alarm Date/Time 2" = CreateDateTime(0D, 0T) then
                Body += ' "" '
            else
                Body += ' "' + Format("Send Alarm Date/Time 2", 0, '<Year4>-<Month,2>-<Day,2> <Hours24>:<Minutes,2>:<Seconds,2>') + '"';
            //—¹ŽÊ …Ø‡Ÿ
            Body += ' , "RevocationRegister" : ';
            if "Revocation Register" then
                Body += 'true'
            else
                Body += 'false';
            //—¹ŽÊ ŸÀ
            Body += ' , "CancleDate" : ';
            if "Revocation Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("Revocation Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';

            //—¹ŽÊ €¦Ž¸
            Body += ' , "CancleAmount" : ';
            Body += ' ' + DelChr(Format("Revocation Amount"), '=', ',') + ' ';

            //—¹‘÷ €¦Ž¸
            Body += ' , "CloseAmount" : ';
            Body += ' ' + DelChr(Format("Close Amount"), '=', ',') + ' ';

            //Ÿ‰¦ ýˆ«Š± ‘Ž‡ßŸ
            Body += ' , "GeneralExpirationDate" : ';
            if "General Expiration Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("General Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';
            //‘†µ ýˆ«Š± ‘Ž‡ßŸ
            Body += ' , "LandArcExpirationDate" : ';
            if "Land. Arc. Expiration Date" = 0D then
                Body += ' "" '
            else
                Body += ' "' + Format("Land. Arc. Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>') + '"';

            // >> DK34

            //¼×À 1 ÐŽÊÀ ýÐ
            Body += ' , "Relation1Relative" : ';
            Body += '"' + "Main Kinsman Relationship" + '" ';
            //¼×À 1 œˆº
            Body += ' , "Relation1Name" : ';
            Body += '"' + "Main Kinsman Name" + '" ';
            //¼×À 1 —À…Î–õ‰°˜ú
            Body += ' , "Relation1Mobile" : ';
            Body += '"' + "Main Kinsman Mobile No." + '" ';
            //¼×À 1 ý˜¡‰°˜ú
            Body += ' , "Relation1Phone" : ';
            Body += '"' + "Main Kinsman Phone No." + '" ';
            //¼×À 1 œˆÃŸ
            Body += ' , "Relation1EMail" : ';
            Body += '"' + Format("Main Kinsman E-Mail") + '" ';
            //¼×À 1 Õ–×‰°˜ú
            Body += ' , "Relation1PostNum" : ';
            Body += '"' + "Main Kinsman Post Code" + '" ';
            //¼×À 1 ‘´Œ­
            Body += ' , "Relation1Address" : ';
            Body += '"' + "Main Kinsman Address" + '" ';
            //¼×À 1 ‘´Œ­ 2
            Body += ' , "Relation1AddressDetail" : ';
            Body += '"' + "Main Kinsman Address 2" + '" ';

            //¼×À 2 ÐŽÊÀ ýÐ
            Body += ' , "Relation2Relative" : ';
            Body += '"' + "Sub Kinsman Relationship" + '" ';
            //¼×À 2 œˆº
            Body += ' , "Relation2Name" : ';
            Body += '"' + "Sub Kinsman Name" + '" ';
            //¼×À 2 —À…Î–õ‰°˜ú
            Body += ' , "Relation2Mobile" : ';
            Body += '"' + "Sub Kinsman Mobile No." + '" ';
            //¼×À 2 ý˜¡‰°˜ú
            Body += ' , "Relation2Phone" : ';
            Body += '"' + "Sub Kinsman Phone No." + '" ';
            //¼×À 2 œˆÃŸ
            Body += ' , "Relation2EMail" : ';
            Body += '"' + Format("Sub Kinsman E-Mail") + '" ';
            //¼×À 2 Õ–×‰°˜ú
            Body += ' , "Relation2PostNum" : ';
            Body += '"' + "Sub Kinsman Post Code" + '" ';
            //¼×À 2 ‘´Œ­
            Body += ' , "Relation2Address" : ';
            Body += '"' + "Sub Kinsman Address" + '" ';
            //¼×À 2 ‘´Œ­ 2
            Body += ' , "Relation2AddressDetail" : ';
            Body += '"' + "Sub Kinsman Address 2" + '" ';

            // <<

            //ÐŽÊ€¦ ‰È—Ê‘ãŠõ
            Body += ' , "DepositPublish" : ';
            if "Contract Publish" = "Contract Publish"::Cash then begin
                Body += '"100000000" ';
            end else
                if "Contract Publish" = "Contract Publish"::Card then begin
                    Body += '"100000001" ';
                end else
                    if "Contract Publish" = "Contract Publish"::CashandCard then begin
                        Body += '"100000002" ';
                    end else
                        if "Contract Publish" = "Contract Publish"::Unpublished then begin
                            Body += '"100000003" ';
                        end;

            //Â€¦ ‰È—Ê‘ãŠõ
            Body += ' , "BalancePublish" : ';
            if "Remaining Publish" = "Remaining Publish"::Cash then begin
                Body += '"100000000" ';
            end else
                if "Remaining Publish" = "Remaining Publish"::Card then begin
                    Body += '"100000001" ';
                end else
                    if "Remaining Publish" = "Remaining Publish"::CashandCard then begin
                        Body += '"100000002" ';
                    end else
                        if "Remaining Publish" = "Remaining Publish"::Unpublished then begin
                            Body += '"100000003" ';
                        end;

            //€Ë‘ˆ ‰ª¬‰°˜ú
            Body += ' , "BeforeGraveyardNo" : ';
            Body += '"' + "Before Cemetery No." + '" ';

            //ˆÃˆÚ
            Body += ' , "Memo" : ';
            Body += '"' + ConvertStr(DelChr(DelChr(DelChr(Memo, '=', '\'), '=', '"'), '=', ''''), Format(_CR, 0, '<CHAR>') + Format(_LR, 0, '<CHAR>'), '\n') + '" ';

            Body += ' }';


        end;
        //TEST

        //IF USERID = 'TAEHOON.KIM' THEN
        //MESSAGE('%1', Body);
        //IF UPPERCASE(USERID) = 'DONGHYUN.KIM' THEN
        //  MESSAGE('1 - %1, %2',Body,STRLEN(Body));

        CreateServerFileUTF8;

        //Send Request
        // if not SendWebRequest(FunSetup."CRM Contract URL") then////zzz
        //     exit(false);

        exit(true);
    end;

    local procedure CreateServerFileUTF8()
    var
        _FileMgt: Codeunit "File Management";
        _FileName: Text;
        _File: File;
        _OutStream: OutStream;
    begin
        Clear(UTF8FilePath);
        ////zzz++
        // UTF8FilePath := CopyStr(_FileMgt.ServerTempFileName('txt'), 1, 250);
        // _File.Create(UTF8FilePath, TEXTENCODING::UTF8);
        // _File.CreateOutStream(_OutStream);
        // _OutStream.WriteText(Body);
        // _File.Close;
        ////zzz--
    end;

    ////zzz++
    // local procedure SendWebRequest(pTextCustCUUrls: Text): Boolean
    // var
    //     _TempBlob: Record TempBlob temporary;
    //     _HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
    //     _HttpStatusCode: DotNet HttpStatusCode;
    //     _ResponseHeaders: DotNet NameValueCollection;
    //     _JsonObject: DotNet JObject;
    //     _Instr: InStream;
    //     _OutStream: OutStream;
    //     _SuportInfo: Text;
    //     _Message: Text;
    // begin
    //     with _HttpWebRequestMgt do begin
    //         Initialize(pTextCustCUUrls);
    //         DisableUI;
    //         SetMethod('POST');
    //         SetContentType('application/json');
    //         SetReturnType('application/json');
    //         AddBody(UTF8FilePath);
    //         _TempBlob.Init;
    //         _TempBlob.Blob.CreateInStream(_Instr);
    //         if GetResponse(_Instr, _HttpStatusCode, _ResponseHeaders) then begin
    //             _Message := _TempBlob.ReadAsText('', TEXTENCODING::UTF8);
    //             _JsonObject := _JsonObject.Parse(_Message);
    //             if UpperCase(Format(_JsonObject.GetValue('ProcessingResult'))) = 'FALSE' then begin
    //                 Error(MSG001, Format(_JsonObject.GetValue('ErrorMessage')));
    //                 exit(false);
    //             end;
    //         end else begin
    //             // ProcessFaultResponse(_SuportInfo);////zzz
    //             exit(false);
    //         end;
    //     end;
    //     exit(true);
    // end;
    ////zzz--

    local procedure UseCRMInterface(): Boolean
    var
        _DK_FunctionSetup: Record "DK_Function Setup";
    begin
        _DK_FunctionSetup.Get();
        exit(_DK_FunctionSetup."Use CRM Interface");
    end;


    procedure InterlinkFrwithCRMLogRecord(pFr: Record "DK_Friends And Relatives"; pDel: Boolean)
    var
        _InterlinkFrwithCRMLog: Record "DK_Interlink Fr. with CRM Log";
    begin
        with _InterlinkFrwithCRMLog do begin
            Init;
            "Entry No." := 0;
            "Data Type" := "Data Type"::Outbound;
            "Data Date" := Today;
            "Contract No." := pFr."Contract No.";
            "Line No" := pFr."Line No.";
            "Relation No." := pFr."Relation No.";
            "Customer No." := pFr."Customer No.";
            Relation := pFr.Relationship;
            "Record Del" := pDel;
            "Applied Date" := 0D;
            Insert(true);
        end;

        SendCRM_FriendsAndRelatives;
    end;


    procedure SendCRM_FriendsAndRelatives()
    var
        _InterlinkFrwithCRMLog: Record "DK_Interlink Fr. with CRM Log";
        _FriendsAndRelatives: Record "DK_Friends And Relatives";
        _Result: Text;
    begin
        //Check Use CRM Interface
        if not UseCRMInterface then
            exit;

        with _InterlinkFrwithCRMLog do begin
            Reset;
            SetRange("Data Type", "Data Type"::Outbound);
            SetRange("Applied Date", 0D);
            if FindSet then
                repeat
                    _Result := '';
                    _Result := SendCRM_CreateUpdateCRMFr(_InterlinkFrwithCRMLog);
                    if _Result <> '' then begin
                        _FriendsAndRelatives.Reset;
                        _FriendsAndRelatives.SetRange("Contract No.", "Contract No.");
                        _FriendsAndRelatives.SetRange("Line No.", "Line No");
                        if _FriendsAndRelatives.FindSet then begin
                            _FriendsAndRelatives."Relation No." := _Result;
                            _FriendsAndRelatives.Modify;
                        end;

                        "Applied Date" := Today;
                        Modify;
                    end;
                until Next = 0;
        end;
    end;

    local procedure SendCRM_CreateUpdateCRMFr(pInterlinkFrwithCRMLog: Record "DK_Interlink Fr. with CRM Log"): Text
    var
        _FriendsAndRelatives: Record "DK_Friends And Relatives";
        _Result: Text;
    begin
        //Json Structure


        FunSetup.Get;
        FunSetup.TestField("CRM Fr. Rel. URL");


        with pInterlinkFrwithCRMLog do begin
            Body := '';
            Body += '{ ';
            Body += ' "RelationNo" : ';
            Body += '"' + "Relation No." + '" ';
            Body += ' , "ContractNo" : ';
            Body += '"' + "Contract No." + '" ';
            Body += ' , "Customer" : ';
            Body += '"' + "Customer No." + '" ';
            Body += ' , "Relation" : ';
            Body += '"' + Relation + '" ';
            Body += ' , "IsDelete" : ';
            if "Record Del" then
                Body += 'true'
            else
                Body += 'false';
            Body += ' }';
        end;

        //Create File & Body
        CreateServerFileUTF8;

        //Send Request
        // _Result := SendWebRequest_Relative(FunSetup."CRM Fr. Rel. URL");////zzz
        if _Result <> '' then
            exit(_Result);

        exit('');
    end;

    ////zzz++
    // local procedure SendWebRequest_Relative(pTextCustCUUrls: Text): Text
    // var
    //     _TempBlob: Record TempBlob temporary;
    //     _HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
    //     _HttpStatusCode: DotNet HttpStatusCode;
    //     _ResponseHeaders: DotNet NameValueCollection;
    //     _JsonObject: DotNet JObject;
    //     _Instr: InStream;
    //     _OutStream: OutStream;
    //     _SuportInfo: Text;
    //     _Message: Text;
    // begin
    //     with _HttpWebRequestMgt do begin
    //         Initialize(pTextCustCUUrls);
    //         DisableUI;
    //         SetMethod('POST');
    //         SetContentType('application/json');
    //         SetReturnType('application/json');
    //         AddBody(UTF8FilePath);
    //         _TempBlob.Init;
    //         _TempBlob.Blob.CreateInStream(_Instr);
    //         if GetResponse(_Instr, _HttpStatusCode, _ResponseHeaders) then begin
    //             _Message := _TempBlob.ReadAsText('', TEXTENCODING::UTF8);
    //             _JsonObject := _JsonObject.Parse(_Message);
    //             if UpperCase(Format(_JsonObject.GetValue('ProcessingResult'))) = 'FALSE' then begin
    //                 Error(MSG001, Format(_JsonObject.GetValue('ErrorMessage')));
    //                 exit('');
    //             end;
    //             if UpperCase(Format(_JsonObject.GetValue('ProcessingResult'))) = 'TRUE' then begin
    //                 exit(Format(_JsonObject.GetValue('RelationNo')));
    //             end;
    //         end else begin
    //             // ProcessFaultResponse(_SuportInfo);////zzz
    //             exit('');
    //         end;
    //     end;
    //     exit('');
    // end;
    ////zzz--
}

