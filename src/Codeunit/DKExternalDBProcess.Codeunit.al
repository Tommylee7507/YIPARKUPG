codeunit 50001 "DK_External DB Process"
{

    trigger OnRun()
    begin
    end;
    ////zzz++
    // var
    //     SQLConnection: DotNet SqlConnection;
    //     SQLCommand: DotNet SqlCommand;
    //     SQLReader: DotNet SqlDataReader;
    //     Comma: Label ',';
    //     SingleQuote: Label '''';
    //     MSG001: Label 'Mobile No.(To) not specified.';
    //     MSG002: Label 'SMS Subject does not exist.';
    //     MSG003: Label '%1 DB connection is not supported.';
    //     MSG004: Label 'SMS Message does not exist.';
    //     MSG005: Label 'Mobile No.(From) not specified.';
    //     MSG006: Label '[YongIn Park]';
    //     Windows: Dialog;
    //     MSG007: Label 'Updating Result';
    //     MSG008: Label 'Virtual account information not found. %1:%2';
    //     MSG009: Label 'Virtual account function is not available. Please check %2 with %1.';
    //     MSG010: Label 'No error log exists regarding virtual account transactions.';


    // procedure OpenConn(pExtDBConInfor_Code: Code[20]) Rtn: Boolean
    // var
    //     _ExtDBConInfor: Record "DK_External DB Con. Infor.";
    //     _ConnectionString: Text;
    // begin
    //     Clear(SQLReader);
    //     Clear(SQLCommand);
    //     Clear(SQLConnection);

    //     if _ExtDBConInfor.Get(pExtDBConInfor_Code) then begin

    //         _ExtDBConInfor.TestField("Server Name");
    //         _ExtDBConInfor.TestField("DB Name");
    //         _ExtDBConInfor.TestField("DB User ID");

    //         case _ExtDBConInfor."DB Type" of
    //             _ExtDBConInfor."DB Type"::"MS-SQL":
    //                 begin

    //                     _ConnectionString := 'Data Source=' + _ExtDBConInfor."Server Name" + ';'
    //                                         + 'Initial Catalog=' + _ExtDBConInfor."DB Name" + ';'
    //                                         + 'Uid=' + _ExtDBConInfor."DB User ID" + ';'
    //                                         + 'Pwd=' + _ExtDBConInfor."DB User PW" + ';';

    //                 end;
    //             else begin
    //                 Error(MSG003, _ExtDBConInfor."DB Type");
    //             end;
    //         end;

    //         SQLConnection := SQLConnection.SqlConnection(_ConnectionString);

    //         SQLConnection.Open;
    //         SQLCommand := SQLConnection.CreateCommand();

    //         exit(true);
    //     end;
    // end;


    // procedure CloseConn()
    // begin
    //     SQLConnection.Close;
    //     Clear(SQLReader);
    //     Clear(SQLCommand);
    //     Clear(SQLConnection);
    // end;


    // procedure TestConnecting(pExtDBConInfor_Code: Code[20]): Boolean
    // begin
    //     if OpenConn(pExtDBConInfor_Code) then begin
    //         CloseConn;
    //         exit(true);
    //     end;
    // end;


    // procedure SendSMS(pMsgKey: Text[20]; pFromMobileNo: Text[20]; pToMobileNo: Text[20]; pSubject: Text[100]; pMessage: Text; pFilePatch1: Text[100]; pFilePatch2: Text[100]; pFilePatch3: Text[100]; pBizTalkTemplateNo: Text[30])
    // var
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _AttchFileNames: Text;
    //     _ComFun: Codeunit "DK_Common Function";
    //     _MSGLength: Integer;
    //     _SMSType: Code[10];
    // begin

    //     _FunctionSetup.Get;

    //     if _FunctionSetup."Use SMS" = false then
    //         exit;


    //     if pBizTalkTemplateNo <> '' then
    //         _FunctionSetup.TestField("Biz Talk ID");

    //     _FunctionSetup.TestField("SMS DB Con. Code");
    //     _FunctionSetup.TestField("SMS Phone No.");


    //     if pFromMobileNo = '' then Error(MSG001);
    //     if pToMobileNo = '' then Error(MSG005);
    //     if pMessage = '' then Error(MSG004);

    //     //Convert
    //     pFromMobileNo := DelChr(DelChr(pFromMobileNo, '=', '-'), '=', ' ');
    //     pToMobileNo := DelChr(DelChr(pToMobileNo, '=', '-'), '=', ' ');

    //     if (UserId = 'ADMIN') and (Today < 20191001D) then
    //         pToMobileNo := '01027107780';

    //     Clear(_ComFun);
    //     _MSGLength := _ComFun.GetKoreanCharLen(pMessage);

    //     if _MSGLength > 90 then ///90Byte
    //         _SMSType := 'MMS'
    //     else
    //         _SMSType := 'SMS';


    //     if OpenConn(_FunctionSetup."SMS DB Con. Code") then begin

    //         if (pFilePatch1 = '') and (pFilePatch2 = '') and (pFilePatch3 = '') then begin


    //             if pBizTalkTemplateNo = '' then begin
    //                 if _SMSType = 'MMS' then begin
    //                     //LMS ˆÃŒŒ‘÷ 90 Byte œ‹Ý
    //                     //INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY)
    //                     //VALUES (5, '201XXXXXXXXX', GETDATE(), GETDATE(), '01012341234', '0212341234',í«LMS ‘ªˆ±', 'Š‹ ˆÃ“‘÷„’ LMS •¸Š–« ˆÃ“‘÷ ¯„Ÿ„¾.')

    //                     _SQL := ' INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY)';
    //                     _SQL += ' VALUES (5';                       //MSG_TYPE
    //                     _SQL += ConvertText(pMsgKey, '', true);       //CMID
    //                     _SQL += ' ,GETDATE()';                      //REQUEST_TIME
    //                     _SQL += ' ,GETDATE()';                      //SEND_TIME
    //                     _SQL += ConvertText(pToMobileNo, '', true);   //DEST_PHONE
    //                     _SQL += ConvertText(pFromMobileNo, '', true); //SEND_PHONE
    //                     _SQL += ConvertText(pSubject, '', true);      //SUBJECT
    //                     _SQL += ConvertText(pMessage, '', true);      //MSG_BODY
    //                     _SQL += ' )';
    //                 end else begin
    //                     //SMS 90 Byte œ—Ÿ
    //                     //INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, MSG_BODY)
    //                     //VALUES (0, '201XXXXXXXXX', NOW(), NOW(), '01012341234', '0212341234','Š‹ ˆÃ“‘÷„’ SMS •¸Š–« ˆÃ“‘÷ ¯„Ÿ„¾.')
    //                     _SQL := ' INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, MSG_BODY)';
    //                     _SQL += ' VALUES (0';                       //MSG_TYPE
    //                     _SQL += ConvertText(pMsgKey, '', true);       //CMID
    //                     _SQL += ' ,GETDATE()';                      //REQUEST_TIME
    //                     _SQL += ' ,GETDATE()';                      //SEND_TIME
    //                     _SQL += ConvertText(pToMobileNo, '', true);   //DEST_PHONE
    //                     _SQL += ConvertText(pFromMobileNo, '', true); //SEND_PHONE
    //                     _SQL += ConvertText(pMessage, '', true);      //MSG_BODY
    //                     _SQL += ' )';
    //                 end;
    //             end else begin

    //                 //AT ‰ÈŒÁ
    //                 //INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY, TEMPLATE_CODE, SENDER_KEY, NATION_CODE, RE_TYPE, RE_BODY)
    //                 //VALUES (6, '201XXXXXXXXX', NOW(), NOW(), '01012341234', '0212341234','˜½€µ… ×„„¯ „¾Õ€ËŒ· Š±‘ØˆÃ“‘÷ —‘‡žˆÚŒ—í „Ï“‡ …—Ž·„Ÿ„¾.', {•Á—“ˆ„”À…Î}, {‰È•—‘‡ž—š•}, '82')

    //                 _SQL := ' INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY, TEMPLATE_CODE, SENDER_KEY, NATION_CODE, RE_TYPE, RE_BODY)';
    //                 _SQL += ' VALUES (6';                                       //MSG_TYPE
    //                 _SQL += ConvertText(pMsgKey, '', true);                       //CMID
    //                 _SQL += ' ,GETDATE()';                                      //REQUEST_TIME
    //                 _SQL += ' ,GETDATE()';                                      //SEND_TIME
    //                 _SQL += ConvertText(pToMobileNo, '', true);                   //DEST_PHONE
    //                 _SQL += ConvertText(pFromMobileNo, '', true);                 //SEND_PHONE
    //                 _SQL += ConvertText(pSubject, '', true);                      //SUBJECT
    //                 _SQL += ConvertText(pMessage, '', true);                      //MSG_BODY
    //                 _SQL += ConvertText(pBizTalkTemplateNo, '', true);            //TEMPLATE_CODE
    //                 _SQL += ConvertText(_FunctionSetup."Biz Talk ID", '', true);  //SENDER_KEY
    //                 _SQL += ConvertText('82', '', true);                          //NATION_CODE
    //                 _SQL += ConvertText(_SMSType, '', true);                      //RE_TYPE ˆÃŒŒ‘÷ €µœ SMS < 90 < MMS
    //                 _SQL += ConvertText('', '', true);                            //RE_BODY
    //                 _SQL += ' )';
    //             end;

    //         end else begin
    //             //MMS ˆÃŒŒ‘÷
    //             //INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE,SUBJECT, MSG_BODY, ATTACHED_FILE)
    //             //VALUES (5, '201XXXXXXXXX', GETDATE(), GETDATE(), '01012341234', '0212341234','MMS ‘ªˆ±', 'Š‹ ˆÃ“‘÷„’ MMS •¸Š–« ˆÃ“‘÷ ¯„Ÿ„¾.', {“‡Šž–”Ÿˆ×1.jpg|“‡Šž–”Ÿˆ×2.jpg})

    //             //Attch Files
    //             if pFilePatch1 <> '' then
    //                 _AttchFileNames := pFilePatch1;

    //             if pFilePatch2 <> '' then begin
    //                 if _AttchFileNames = '' then
    //                     _AttchFileNames := pFilePatch2
    //                 else
    //                     _AttchFileNames := StrSubstNo('%1|%2', _AttchFileNames, pFilePatch2);
    //             end;

    //             if pFilePatch3 <> '' then begin
    //                 if _AttchFileNames = '' then
    //                     _AttchFileNames := pFilePatch3
    //                 else
    //                     _AttchFileNames := StrSubstNo('%1|%2', _AttchFileNames, pFilePatch3);
    //             end;

    //             _SQL := ' INSERT INTO biz_msg ( MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY, ATTACHED_FILE)';
    //             _SQL += ' VALUES (5';                         //MSG_TYPE
    //             _SQL += ConvertText(pMsgKey, '', true);         //CMID
    //             _SQL += ' ,GETDATE()';                        //REQUEST_TIME
    //             _SQL += ' ,GETDATE()';                        //SEND_TIME
    //             _SQL += ConvertText(pToMobileNo, '', true);     //DEST_PHONE
    //             _SQL += ConvertText(pFromMobileNo, '', true);   //SEND_PHONE
    //             _SQL += ConvertText(pSubject, '', true);        //SUBJECT
    //             _SQL += ConvertText(pMessage, '', true);        //MSG_BODY
    //             _SQL += ConvertText(_AttchFileNames, '', true); //ATTACHED_FILE
    //             _SQL += ' )';

    //         end;


    //         SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //         SQLCommand.CommandTimeout(4);
    //         //        SQLCommand.CommandType := 4; // for a Query

    //         SQLReader := SQLCommand.ExecuteReader();

    //         CloseConn;
    //     end;
    // end;


    // procedure UpdateSMSResult(pEntryNo: Integer): Boolean
    // var
    //     _SendedSMSHistory: Record "DK_Sended SMS History";
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _StateCode: Text[5];
    //     _LoopCount: Integer;
    //     _MaxCount: Integer;
    //     _CounselHistory: Record "DK_Counsel History";
    //     _Contract: Record DK_Contract;
    //     _Employee: Record DK_Employee;
    //     _NewLineNo: Integer;
    // begin

    //     _FunctionSetup.Get;

    //     if _FunctionSetup."Use SMS" = false then
    //         exit(false);

    //     _FunctionSetup.TestField("SMS DB Con. Code");


    //     _SendedSMSHistory.Reset;
    //     _SendedSMSHistory.SetFilter(Status, '<>%1', _SendedSMSHistory.Status::Complete);
    //     //_SendedSMSHistory.SETRANGE("Result Status Code", '')
    //     if pEntryNo <> 0 then
    //         _SendedSMSHistory.SetRange("Entry No.", pEntryNo);
    //     if _SendedSMSHistory.FindSet then begin
    //         if not OpenConn(_FunctionSetup."SMS DB Con. Code") then
    //             exit(false);

    //         if GuiAllowed then
    //             Windows.Open(StrSubstNo('%1 : @1@@@@@@@@@@@@@@@@@@@', MSG007));

    //         _MaxCount := _SendedSMSHistory.Count;
    //         repeat

    //             _LoopCount += 1;

    //             if GuiAllowed then
    //                 Windows.Update(1, Round(_LoopCount / _MaxCount * 10000, 1));

    //             //ˆÃŒŒ‘÷ •¸œŠ×
    //             _SQL := ' SELECT TOP 1 ISNULL([CMID],' + ConvertText('', '', false) + ') AS [CMID]';
    //             _SQL += ' ,ISNULL([STATUS],0) AS [STATUS]';
    //             _SQL += ' ,ISNULL([CALL_STATUS],' + ConvertText('', '', false) + ') AS [CALL_STATUS]';
    //             _SQL += ' ,ISNULL([REQUEST_TIME],' + ConvertText('', '1753-01-01', false) + ') AS [REQUEST_TIME]';
    //             _SQL += ' ,' + ConvertText('', '', false) + ' AS [CHA_CALL_STATUS]';
    //             _SQL += ' FROM [dbo].[BIZ_MSG] (NOLOCK)';
    //             _SQL += ' WHERE [CMID] = ' + ConvertText(Format(_SendedSMSHistory."Entry No."), '', false);

    //             //‡ž€¸•¸œŠ×
    //             _SQL += ' UNION ALL ';
    //             _SQL += ' SELECT TOP 1 ISNULL(a.[CMID],' + ConvertText('', '', false) + ') AS [CMID]';
    //             _SQL += ' ,ISNULL(a.[STATUS],0) AS [STATUS]';
    //             _SQL += ' ,ISNULL(a.[CALL_STATUS],' + ConvertText('', '', false) + ') AS [CALL_STATUS]';
    //             _SQL += ' ,ISNULL(a.[REQUEST_TIME],' + ConvertText('', '1753-01-01', false) + ') AS [REQUEST_TIME]';
    //             _SQL += ' ,ISNULL((SELECT b.[CALL_STATUS] FROM [dbo].[BIZ_LOG] b WHERE b.[CMID] = a.[UMID]),' + ConvertText('', '', false) + ')  AS [CHA_CALL_STATUS]';
    //             _SQL += ' FROM [dbo].[BIZ_LOG] a (NOLOCK)';
    //             _SQL += ' WHERE a.[CMID] = ' + ConvertText(Format(_SendedSMSHistory."Entry No."), '', false);

    //             SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //             SQLCommand.CommandTimeout(4);
    //             Clear(SQLReader);
    //             SQLReader := SQLCommand.ExecuteReader();

    //             while SQLReader.Read() do begin

    //                 case _SendedSMSHistory.Status of
    //                     _SendedSMSHistory.Status::Waiting:
    //                         _StateCode := '0';
    //                     _SendedSMSHistory.Status::Send:
    //                         _StateCode := '7';
    //                     _SendedSMSHistory.Status::WaitingCompletion:
    //                         _StateCode := '1';
    //                     _SendedSMSHistory.Status::Complete:
    //                         _StateCode := '2';
    //                     _SendedSMSHistory.Status::ExchangeSending:
    //                         _StateCode := '11';
    //                 end;

    //                 if (_StateCode <> Format(SQLReader.Item('STATUS'))) or
    //                    (_SendedSMSHistory."Result Status Code" <> Format(SQLReader.Item('CALL_STATUS'))) then begin
    //                     //Update
    //                     if Format(SQLReader.Item('REQUEST_TIME')) <> '1753-01-01' then
    //                         _SendedSMSHistory."Report Date" := SQLReader.Item('REQUEST_TIME');

    //                     case Format(SQLReader.Item('STATUS')) of
    //                         '0':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::Waiting;
    //                         '7':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::Send;
    //                         '1':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::WaitingCompletion;
    //                         '2':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::Complete;
    //                         '11':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::ExchangeSending;
    //                     end;

    //                     if Format(SQLReader.Item('CHA_CALL_STATUS')) = '' then begin
    //                         _SendedSMSHistory."Result Status Code" := Format(SQLReader.Item('CALL_STATUS'))
    //                     end else begin
    //                         _SendedSMSHistory."Result Status Code" := Format(SQLReader.Item('CHA_CALL_STATUS'));
    //                         _SendedSMSHistory."Change Send" := _SendedSMSHistory."Change Send"::ChangeSend;
    //                     end;
    //                     _SendedSMSHistory.Modify;

    //                     //ŒÁ‰½ ‹Ý„Ì€Ë‡Ÿ
    //                     if (_SendedSMSHistory."Result Status Code" in ['6600', '3200', '4100', '7000']) and
    //                        (_SendedSMSHistory."Auto Sending" = false) and
    //                        (_SendedSMSHistory."Contract No." <> '') then begin


    //                         _CounselHistory.Reset;
    //                         _CounselHistory.SetCurrentKey("Contract No.", Type, "Dev. Target Doc. No.", "Dev. Target Doc. Line No.", "Line No.");
    //                         _CounselHistory.SetRange("Contract No.", _SendedSMSHistory."Contract No.");
    //                         _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
    //                         _CounselHistory.SetRange("Dev. Target Doc. No.", '');
    //                         _CounselHistory.SetRange("Dev. Target Doc. Line No.", 0);
    //                         if _CounselHistory.FindLast then
    //                             _NewLineNo := _CounselHistory."Line No.";

    //                         _NewLineNo += 1;

    //                         _CounselHistory.Init;
    //                         _CounselHistory."Contract No." := _SendedSMSHistory."Contract No.";
    //                         _CounselHistory.Type := _CounselHistory.Type::Litigation;
    //                         _CounselHistory."Line No." := _NewLineNo;
    //                         _CounselHistory.Date := _SendedSMSHistory."Sending Date";
    //                         _CounselHistory."Counsel Time" := _SendedSMSHistory."Sending Time";
    //                         if _Contract.Get(_CounselHistory."Contract No.") then begin
    //                             _CounselHistory."Cemetery Code" := _Contract."Cemetery Code";
    //                             _CounselHistory."Cemetery No." := _Contract."Cemetery No.";
    //                         end;

    //                         _Employee.Reset;
    //                         _Employee.SetRange("ERP User ID", _SendedSMSHistory."Creation Person");
    //                         if _Employee.FindFirst then begin
    //                             _CounselHistory."Employee No." := _Employee."No.";
    //                             _CounselHistory."Employee Name" := _Employee.Name;
    //                         end;
    //                         _CounselHistory."Counsel Content" := CopyStr(_SendedSMSHistory."Short Message", 1, 250);
    //                         _CounselHistory."Litigation Type" := _CounselHistory."Litigation Type"::SMS;
    //                         _CounselHistory."Contact Method" := _CounselHistory."Contact Method"::Mobile;
    //                         _CounselHistory."Counsel Target" := _CounselHistory."Counsel Target"::Etc;
    //                         _CounselHistory."Process Content" := Format(_SendedSMSHistory."Entry No.");
    //                         _CounselHistory.Insert(true);

    //                     end;


    //                 end;
    //             end;
    //         until _SendedSMSHistory.Next = 0;
    //         CloseConn;

    //         if GuiAllowed then
    //             Windows.Close;

    //         exit(true);
    //     end;
    // end;


    // procedure ConvertText(pText: Text; pRemove: Text; pIsComma: Boolean) rst: Text
    // var
    //     _Comma: Text;
    // begin

    //     if pIsComma then
    //         _Comma := Format(Comma);

    //     //pText := DELCHR(pText,'=','!#$%''');
    //     pText := DelChr(pText, '=', '#$%''');

    //     rst := _Comma + Format(SingleQuote) + DelChr(pText, '=', pRemove) + Format(SingleQuote);

    //     exit(rst);
    // end;


    // procedure ConvertDecimal(pDecimal: Decimal; pRemove: Text; pIsComma: Boolean) rst: Text
    // var
    //     _Comma: Text;
    //     _Integer: Integer;
    // begin

    //     if pIsComma then
    //         _Comma := Format(Comma);

    //     _Integer := Round(pDecimal, 1);

    //     rst := _Comma + DelChr(Format(_Integer), '=', pRemove);

    //     exit(rst);
    // end;


    // procedure ConvertDate(pDate: Date; pIsComma: Boolean; pFormat: Option YYYYMMDD,MMDD) rst: Text
    // var
    //     _Comma: Text;
    //     _DateFormat: Text;
    // begin

    //     if pIsComma then
    //         _Comma := Format(Comma);

    //     if pFormat = pFormat::YYYYMMDD then
    //         _DateFormat := '<Year4><Month,2><Day,2>'
    //     else
    //         if pFormat = pFormat::MMDD then
    //             _DateFormat := '<Month,2><Day,2>';

    //     rst := _Comma + Format(SingleQuote) + Format(pDate, 0, _DateFormat) + Format(SingleQuote);

    //     exit(rst);
    // end;


    // procedure AssginVirtualAccount(pRec: Record "DK_Pay. Expect Doc. Header")
    // var
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _VirtualAccount: Record "DK_Virtual Account";
    //     _VANo: Text[30];
    //     _FromDate: Text[8];
    //     _ToDate: Text[8];
    //     _AccountHolder: Text[10];
    // begin

    //     _FunctionSetup.Get;
    //     if not _FunctionSetup."Use Virtual Account" then
    //         Error(MSG009, _FunctionSetup.TableCaption,
    //                   _FunctionSetup.FieldCaption("Use Virtual Account"));

    //     _FunctionSetup.TestField("Virtual Account ID");
    //     _FunctionSetup.TestField("Virtual Accnt. DB Con. Code");

    //     if not _VirtualAccount.Get(pRec."Virtual Account No.") then
    //         Error(MSG008, pRec.FieldCaption("Virtual Account No."),
    //                       pRec."Virtual Account No.");


    //     _VirtualAccount.TestField("Bank Code");
    //     _VirtualAccount.TestField("Virtual Account No.");
    //     _VirtualAccount.TestField("Account Holder");
    //     pRec.CalcFields("Total Amount");

    //     _VANo := DelChr(DelChr(_VirtualAccount."Virtual Account No.", '=', '-'), '=', ' ');

    //     _FromDate := Format(Today, 0, '<Year4><Month,2><Day,2>');
    //     _ToDate := Format(pRec."Expiration Date", 0, '<Year4><Month,2><Day,2>');

    //     //Ôž°°_×„ˆ×
    //     if pRec."Appl. Name" = '' then
    //         _AccountHolder := CopyStr(_VirtualAccount."Account Holder", 1, 10)
    //     else
    //         _AccountHolder := CopyStr(StrSubstNo('%1_%2', _VirtualAccount."Account Holder", pRec."Appl. Name"), 1, 10);

    //     if OpenConn(_FunctionSetup."Virtual Accnt. DB Con. Code") then begin
    //         _SQL := ' IF NOT EXISTS(SELECT * FROM [dbo].[vacs_vact] (NOLOCK) WHERE [bank_cd]=' + ConvertText(_VirtualAccount."Bank Code", '', false) + ' AND [acct_no]=' + ConvertText(_VANo, '', false) + ') BEGIN ';

    //         _SQL += ' INSERT INTO [dbo].[vacs_vact] ';
    //         _SQL += ' ([org_cd] ';
    //         _SQL += '  ,[bank_cd] ';
    //         _SQL += '  ,[acct_no] ';
    //         _SQL += '  ,[cmf_nm] ';
    //         _SQL += '  ,[acct_st] ';

    //         _SQL += '  ,[reg_il] ';
    //         _SQL += '  ,[open_il] ';
    //         _SQL += '  ,[close_il] ';
    //         _SQL += '  ,[fst_il] ';
    //         _SQL += '  ,[lst_il] ';

    //         _SQL += '  ,[tr_amt] ';
    //         _SQL += '  ,[tramt_cond] ';
    //         _SQL += '  ,[trmc_cond] ';
    //         _SQL += '  ,[trbegin_il] ';
    //         _SQL += '  ,[trend_il] ';

    //         _SQL += '  ,[trbegin_si] ';
    //         _SQL += '  ,[trend_si] ';
    //         _SQL += '  ,[seq_no] ';
    //         _SQL += '  ,[cms_cd]) ';
    //         _SQL += '  VALUES(' + ConvertText(_FunctionSetup."Virtual Account ID", '', false);  //€Ëý”À…Î (×‘ñ)
    //         _SQL += '  ,' + ConvertText(_VirtualAccount."Bank Code", '', false);       //Š—Ê”À…Î:‚Ý—õ‘ÈŽ®
    //         _SQL += '  ,' + ConvertText(_VANo, '', false);  //í‹ÝÐ‘’
    //         _SQL += '  ,' + ConvertText(_AccountHolder, '', false);        //‰€¦‘´(€ËŠ‹¬)
    //         _SQL += '  ,' + ConvertText('1', '', false);            //0: —­„Ïý, 1:—­„Ï, 9:—¹‘÷

    //         _SQL += '  ,CONVERT(NVARCHAR(8),GETDATE(),112) ';//…Ø‡ŸŸÀ
    //         _SQL += '  ,CONVERT(NVARCHAR(8),GETDATE(),112) ';//—­„ÏŸÀ
    //         _SQL += '  ,NULL ';//—¹‘÷ŸÀ
    //         _SQL += '  ,NULL ';//“´“š•‡íŸÀ
    //         _SQL += '  ,NULL ';//“´‘Ž•‡íŸÀ

    //         _SQL += '  ,' + ConvertDecimal(pRec."Total Amount", '', false);      //“©•‡í€¦Ž¸
    //         _SQL += '  ,' + ConvertText('1', '', false);            //0 ‘†—Ž°, 1 €¦Ž¸=—€¦Ž¸, 2 €¦Ž¸>—¯€¦Ž¸, 3 €¦Ž¸<=—¯€¦Ž¸  ‰½‘†— 1‡ž ‹ÏÔ—­‰‘ñ
    //         _SQL += '  ,' + ConvertText('0', '', false);            //0: 1Ð‘’1Œ÷‚‚,  1: 1Ð‘’ ‡»‰°Œ÷‚‚
    //         _SQL += '  ,' + ConvertText(_FromDate, '', false);       //¯€¦“ÁŸÀ
    //         _SQL += '  ,' + ConvertText(_ToDate, '', false);//¯€¦í„™ˆˆ‡ßŸÀ

    //         _SQL += '  ,' + ConvertText('000000', '', false);       //¯€¦“Á“ó
    //         _SQL += '  ,' + ConvertText('233000', '', false);       //¯€¦í„™ˆˆ‡ß“ó (23:30)
    //         _SQL += '  ,0 ';//€Ëú‚‹Œ÷‚‚˜Œ÷ (×‘ñ / ¯€¦“1‡žŠ»—¯)
    //         _SQL += '  ,' + ConvertText(pRec."Document No.", '', false);//CMS”À…Î (ß‘ª ‰‘ñ ‰«Œ¡‰°˜ú)
    //         _SQL += '  ) ';

    //         _SQL += ' END ELSE BEGIN ';

    //         _SQL += ' UPDATE [dbo].[vacs_vact] ';
    //         _SQL += ' SET [org_cd]= ' + ConvertText(_FunctionSetup."Virtual Account ID", '', false);
    //         _SQL += '   ,[cmf_nm]  = ' + ConvertText(_AccountHolder, '', false);//‰€¦‘´ Œ‚‘ñ
    //         _SQL += '   ,[acct_st]= ' + ConvertText('1', '', false);//‹Ý•’¬ —­„Ïˆ‡ž Š»µ
    //         _SQL += '   ,[open_il]= CONVERT(NVARCHAR(8),GETDATE(),112)';//—­„Ï ŸÀ
    //         _SQL += '   ,[tr_amt]  = ' + ConvertDecimal(pRec."Total Amount", '', false);//€¦Ž¸ Œ‚‘ñ
    //         _SQL += '   ,[tramt_cond]= ' + ConvertText('1', '', false);//0 ‘†—Ž°, 1 €¦Ž¸=—€¦Ž¸, 2 €¦Ž¸>—¯€¦Ž¸, 3 €¦Ž¸<=—¯€¦Ž¸  ‰½‘†— 1‡ž ‹ÏÔ—­‰‘ñ
    //         _SQL += '   ,[trmc_cond]= ' + ConvertText('0', '', false);//0: 1Ð‘’1Œ÷‚‚,  1: 1Ð‘’ ‡»‰°Œ÷‚‚
    //         _SQL += '   ,[trbegin_il]= ' + ConvertText(_FromDate, '', false);//¯€¦í„™ “ÁŸ
    //         _SQL += '   ,[trend_il]= ' + ConvertText(_ToDate, '', false);//¯€¦í„™ ‘Ž‡ßŸ
    //         _SQL += '   ,[trbegin_si]= ' + ConvertText('000000', '', false);//¯€¦í„™ “ÁŸ “ó
    //         _SQL += '   ,[trend_si]= ' + ConvertText('233000', '', false);//¯€¦í„™ ‘Ž‡ßŸ “ó (23:30)
    //         _SQL += '   ,[seq_no]  = 0 ';//0ˆ‡ž “š€Ë˜¡ (¯€¦“1‡ž Š»µ…š)
    //         _SQL += '   ,[cms_cd]     = ' + ConvertText(pRec."Document No.", '', false);//CMS”À…Î (ß‘ª ‰‘ñ ‰«Œ¡‰°˜ú)
    //         _SQL += '   WHEREbank_cd=' + ConvertText(_VirtualAccount."Bank Code", '', false);//í‹ÝÐ‘’ Š—Ê
    //         _SQL += '   Andacct_no =' + ConvertText(_VANo, '', false);//Ð‘’‰°˜ú

    //         _SQL += ' END;';


    //         SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //         SQLCommand.CommandTimeout(4);
    //         //        SQLCommand.CommandType := 4; // for a Query

    //         SQLReader := SQLCommand.ExecuteReader();

    //         CloseConn;
    //     end;
    // end;


    // procedure UnAssginVirtualAccount(pRec: Record "DK_Pay. Expect Doc. Header")
    // var
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _VirtualAccount: Record "DK_Virtual Account";
    //     _VANo: Text[30];
    // begin

    //     _FunctionSetup.Get;
    //     if not _FunctionSetup."Use Virtual Account" then
    //         Error(MSG009, _FunctionSetup.TableCaption,
    //                   _FunctionSetup.FieldCaption("Use Virtual Account"));

    //     _FunctionSetup.TestField("Virtual Account ID");
    //     _FunctionSetup.TestField("Virtual Accnt. DB Con. Code");

    //     if not _VirtualAccount.Get(pRec."Virtual Account No.") then
    //         Error(MSG008, pRec.FieldCaption("Virtual Account No."),
    //                       pRec."Virtual Account No.");

    //     _VANo := DelChr(DelChr(pRec."Virtual Account No.", '=', '-'), '=', ' ');

    //     if OpenConn(_FunctionSetup."Virtual Accnt. DB Con. Code") then begin

    //         _SQL := ' IF EXISTS(SELECT * FROM [dbo].[vacs_vact] (NOLOCK) WHERE [bank_cd]=' + ConvertText(_VirtualAccount."Bank Code", '', false) + ' AND [acct_no]=' + ConvertText(_VANo, '', false) + ') BEGIN ';
    //         _SQL += '   UPDATE vacs_vact';
    //         _SQL += '   SET [Org_Cd]= ' + ConvertText(_FunctionSetup."Virtual Account ID", '', false);//€Ëý”À…Î ×‘ñ
    //         _SQL += '   ,[cmf_nm]  = ' + ConvertText(_VirtualAccount."Account Holder", '', false);
    //         ;//‰€¦‘´ Œ‚‘ñ
    //         _SQL += '   ,[acct_st]= ' + ConvertText('0', '', false);//‹Ý•’¬ —­„Ïˆ‡ž Š»µ
    //         _SQL += '   ,[open_il]= NULL';//—­„Ï ŸÀ
    //         _SQL += '   ,[tr_amt]  = NULL';//€¦Ž¸ Œ‚‘ñ
    //         _SQL += '   ,[trbegin_il]= NULL';//¯€¦í„™ “ÁŸ
    //         _SQL += '   ,[trend_il]= NULL';//¯€¦í„™ ‘Ž‡ßŸ
    //         _SQL += '   ,[trbegin_si]= NULL';//¯€¦í„™ “ÁŸ “ó
    //         _SQL += '   ,[trend_si]= NULL';//¯€¦í„™ ‘Ž‡ßŸ “ó
    //         _SQL += '   ,[seq_no]  = 0';   //0ˆ‡ž “š€Ë˜¡ (¯€¦“1‡ž Š»µ…š)
    //         _SQL += '   ,[cms_cd]     = NULL';//CMS”À…Î (ß‘ª ‰‘ñ ‰«Œ¡‰°˜ú)
    //         _SQL += '   WHEREbank_cd=' + ConvertText(_VirtualAccount."Bank Code", '', false);//í‹ÝÐ‘’ Š—Ê
    //         _SQL += '   Andacct_no=' + ConvertText(_VANo, '', false);//Ð‘’‰°˜ú
    //         _SQL += ' END;';

    //         //MESSAGE('SQL- %1',_SQL);

    //         SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //         SQLCommand.CommandTimeout(4);
    //         //        SQLCommand.CommandType := 4; // for a Query

    //         SQLReader := SQLCommand.ExecuteReader();

    //         CloseConn;
    //     end;
    // end;


    // procedure UpdateVirtualAccountResult(var pPayExpectDocHdr: Record "DK_Pay. Expect Doc. Header"): Boolean
    // var
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _VirtualAccount: Record "DK_Virtual Account";
    //     _VANo: Text[30];
    //     _CommFun: Codeunit "DK_Common Function";
    // begin

    //     _FunctionSetup.Get;

    //     if _FunctionSetup."Use Virtual Account" = false then
    //         exit(false);

    //     _FunctionSetup.TestField("Virtual Accnt. DB Con. Code");

    //     if not OpenConn(_FunctionSetup."Virtual Accnt. DB Con. Code") then
    //         exit(false);


    //     //í‹ÝÐ‘’‰°˜ú
    //     _VANo := DelChr(DelChr(pPayExpectDocHdr."Virtual Account No.", '=', '-'), '=', ' ');

    //     _SQL := ' SELECT TOP 2 ISNULL(org_cd,' + ConvertText('', '', false) + ') AS org_cd';//€Ëý”À…Î
    //     _SQL += '  ,ISNULL(tr_il,' + ConvertText('', '', false) + ') AS tr_il';//•‡íŸÀ
    //     _SQL += '  ,ISNULL(tr_si,' + ConvertText('', '', false) + ') AS tr_si';//•‡í“ú
    //     _SQL += '  ,ISNULL(tr_cd,' + ConvertText('', '', false) + ') AS tr_cd';//•‡í‘Ž‡õ
    //     _SQL += '  ,ISNULL(bank_cd,' + ConvertText('', '', false) + ') AS bank_cd';//Š—Ê”À…Î
    //     _SQL += '  ,ISNULL(iacct_no,' + ConvertText('', '', false) + ') AS iacct_no';//í‹ÝÐ‘’
    //     _SQL += '  ,ISNULL(iacct_nm,' + ConvertText('', '', false) + ') AS iacct_nm';//¯€¦—‡Àž
    //     _SQL += '  ,ISNULL(tr_amt,0) AS tr_amt';//•‡í€¦Ž¸
    //     _SQL += '  ,ISNULL(mita_amt,0) AS mita_amt';//‰œ•ˆ‘í€¦Ž¸
    //     _SQL += '  ,ISNULL(tr_no,' + ConvertText('', '', false) + ') AS tr_no';//•‡í×»‰°˜ú
    //     _SQL += '  ,ISNULL(inp_st,' + ConvertText('', '', false) + ') AS inp_st';//“‚ˆ«‹Ý•’(1:¯€¦,2:“ÔŒ­,3:‘ñ‹Ó)
    //     _SQL += '  ,ISNULL(inp_si,' + ConvertText('', '', false) + ') AS inp_si';//„Í“ú
    //     _SQL += '  ,ISNULL(caninp_si,' + ConvertText('', '', false) + ') AS caninp_si';//“ÔŒ­“‚ˆ«“ú
    //     _SQL += '  ,ISNULL(iorg_cd,' + ConvertText('', '', false) + ') AS iorg_cd';//¯€¦Š—Ê”À…Î
    //     _SQL += '  ,ISNULL(cms_cd,' + ConvertText('', '', false) + ') AS cms_cd';//CMS”À…Î (ß‘ª ‰‘ñ ‰«Œ¡‰°˜ú)
    //     _SQL += '  ,ISNULL(media_gb,' + ConvertText('', '', false) + ') AS media_gb';//ˆ•“Œ€ˆŠ¨
    //     _SQL += ' FROM [dbo].[vacs_ahst] (NOLOCK) ';
    //     _SQL += ' WHERE org_cd = ' + ConvertText(_FunctionSetup."Virtual Account ID", '', false);//€Ëý”À…Î ×‘ñ
    //     _SQL += ' AND iacct_no = ' + ConvertText(_VANo, '', false);//Ð‘’‰°˜ú
    //     _SQL += ' AND cms_cd = ' + ConvertText(pPayExpectDocHdr."Document No.", '', false);//CMS”À…Î (ß‘ª ‰‘ñ ‰«Œ¡‰°˜ú)
    //     _SQL += ' ORDER BY [tr_il], [tr_si] DESC ';

    //     SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //     SQLCommand.CommandTimeout(4);

    //     Clear(SQLReader);
    //     SQLReader := SQLCommand.ExecuteReader();

    //     while SQLReader.Read() do begin

    //         case Format(SQLReader.Item('inp_st')) of
    //             '1':
    //                 begin
    //                     if pPayExpectDocHdr."VA Process Status" = pPayExpectDocHdr."VA Process Status"::None then begin
    //                         pPayExpectDocHdr."VA Process Status" := pPayExpectDocHdr."VA Process Status"::Receipt;      //¯€¦
    //                         pPayExpectDocHdr."Payment Date" := _CommFun.ConvertDate(SQLReader.Item('tr_il'));           //•‡íŸÀ
    //                         pPayExpectDocHdr.Status := pPayExpectDocHdr.Status::CustomerPayment;
    //                         pPayExpectDocHdr.Validate("UnAssgin Date", Today);

    //                     end;
    //                 end;
    //             '2':
    //                 pPayExpectDocHdr."VA Process Status" := pPayExpectDocHdr."VA Process Status"::Cancel;    //“ÔŒ­
    //             '3':
    //                 begin
    //                     if pPayExpectDocHdr."VA Process Status" = pPayExpectDocHdr."VA Process Status"::Receipt then begin
    //                         pPayExpectDocHdr."VA Process Status" := pPayExpectDocHdr."VA Process Status"::Settlement;   //‘ñ‹Ó
    //                         if pPayExpectDocHdr."Payment Date" = 0D then
    //                             pPayExpectDocHdr."Payment Date" := _CommFun.ConvertDate(SQLReader.Item('tr_il'));         //•‡íŸÀ
    //                     end;
    //                 end;
    //         end;

    //         pPayExpectDocHdr.Modify;
    //     end;

    //     CloseConn;
    //     exit(true);
    // end;


    // procedure VirtualAccountErrorLog(var pTempRec: Record "DK_Report Buffer"; PVirtualAccountNo: Code[20]; pAssignDate: Date): Boolean
    // var
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _VirtualAccount: Record "DK_Virtual Account";
    //     _VANo: Text[30];
    //     _CommFun: Codeunit "DK_Common Function";
    //     _EntryNo: Integer;
    //     _Bank: Record DK_Bank;
    //     _VAStatus: Record "DK_Result Status";
    //     _AssignDate: Text[8];
    // begin

    //     _FunctionSetup.Get;

    //     if _FunctionSetup."Use Virtual Account" = false then
    //         exit(false);

    //     _FunctionSetup.TestField("Virtual Accnt. DB Con. Code");


    //     if not OpenConn(_FunctionSetup."Virtual Accnt. DB Con. Code") then
    //         exit(false);


    //     //í‹ÝÐ‘’‰°˜ú
    //     _VANo := DelChr(DelChr(PVirtualAccountNo, '=', '-'), '=', ' ');
    //     _AssignDate := Format(pAssignDate, 0, '<Year4><Month,2><Day,2>');

    //     _SQL := ' SELECT TOP 10 ISNULL([org_cd],' + ConvertText('', '', false) + ') AS [org_cd]';//€Ëý”À…Î
    //     _SQL += '        ,ISNULL([tr_il],' + ConvertText('', '', false) + ') AS [tr_il]';//•‡íŸÀ
    //     _SQL += '        ,ISNULL([tr_no],' + ConvertText('', '', false) + ') AS [tr_no]';//•‡í‰°˜ú
    //     _SQL += '        ,ISNULL([tr_si],' + ConvertText('', '', false) + ') AS [tr_si]';//•‡í“ú
    //     _SQL += '        ,ISNULL([bank_cd],' + ConvertText('', '', false) + ') AS [bank_cd]';//Š—Ê”À…Î
    //     _SQL += '        ,ISNULL([acnt_no],' + ConvertText('', '', false) + ') AS [acnt_no]';//Ð‘’‰°˜ú
    //     _SQL += '        ,ISNULL([tr_amt],0) AS [tr_amt]';//€¦Ž¸
    //     _SQL += '        ,ISNULL([err_cd],' + ConvertText('', '', false) + ') AS [err_cd]';//í‡»”À…Î
    //     _SQL += ' FROM [dbo].[vacs_errlog] (NOLOCK)';
    //     _SQL += ' WHERE org_cd = ' + ConvertText(_FunctionSetup."Virtual Account ID", '', false);//€Ëý”À…Î ×‘ñ
    //     _SQL += ' AND [acnt_no] = ' + ConvertText(_VANo, '', false);//Ð‘’‰°˜ú
    //     _SQL += ' AND [tr_il] >= ' + ConvertText(_AssignDate, '', false);//•‡íŸÀ >= —­„ÏŸÀ
    //     _SQL += ' ORDER BY [tr_il], [tr_si] DESC ';

    //     SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //     SQLCommand.CommandTimeout(4);

    //     Clear(SQLReader);
    //     SQLReader := SQLCommand.ExecuteReader();

    //     while SQLReader.Read() do begin
    //         _EntryNo += 1;

    //         pTempRec.Init;
    //         pTempRec."USER ID" := UserId;
    //         pTempRec."OBJECT ID" := PAGE::"DK_Virtual Account Error Log";
    //         pTempRec."Entry No." := _EntryNo;
    //         pTempRec.CODE0 := Format(SQLReader.Item('org_cd'));//€Ëý”À…Î
    //         pTempRec.DATE0 := _CommFun.ConvertDate(Format(SQLReader.Item('tr_il')));//•‡íŸÀ

    //         pTempRec.CODE5 := Format(SQLReader.Item('tr_si'));//•‡í“ú

    //         pTempRec.CODE3 := PVirtualAccountNo;//í‹ÝÐ‘’‰°˜ú
    //         pTempRec.CODE1 := Format(SQLReader.Item('tr_no'));//•‡í×»‰°˜ú
    //         pTempRec.CODE4 := Format(SQLReader.Item('err_cd'));//í‡»”À…Î

    //         //í‡» ˆÃŒŒ‘÷
    //         _VAStatus.SetRange(Type, _VAStatus.Type::VA);
    //         _VAStatus.SetRange(Code, pTempRec.CODE4);
    //         if _VAStatus.FindSet then
    //             pTempRec.TEXT1 := _VAStatus.Name;//í‡»

    //         pTempRec.DECIMAL0 := SQLReader.Item('tr_amt');//€¦Ž¸
    //         pTempRec.CODE2 := Format(SQLReader.Item('bank_cd'));//Š—Ê”À…Î

    //         if _Bank.Get(pTempRec.CODE2) then
    //             pTempRec.TEXT0 := _Bank.Name;//Š—Êœˆº

    //         pTempRec.Insert;
    //     end;
    //     CloseConn;

    //     if _EntryNo = 0 then
    //         Error(MSG010);

    //     exit(true);
    // end;


    // procedure UpdateStatus(pEntryNo: Integer): Boolean
    // var
    //     _SendedSMSHistory: Record "DK_Sended SMS History";
    //     _FunctionSetup: Record "DK_Function Setup";
    //     _SQL: Text;
    //     _StateCode: Text[5];
    //     _LoopCount: Integer;
    //     _MaxCount: Integer;
    // begin

    //     _FunctionSetup.Get;
    //     _FunctionSetup.TestField("SMS DB Con. Code");

    //     _SendedSMSHistory.Reset;
    //     _SendedSMSHistory.SetFilter(Status, '<>%1', _SendedSMSHistory.Status::Complete);
    //     _SendedSMSHistory.SetRange("Result Status Code", '');
    //     if pEntryNo <> 0 then
    //         _SendedSMSHistory.SetRange("Entry No.", pEntryNo);

    //     if _SendedSMSHistory.FindSet then begin
    //         if not OpenConn(_FunctionSetup."SMS DB Con. Code") then
    //             exit(false);

    //         if GuiAllowed then
    //             Windows.Open(StrSubstNo('%1 : @1@@@@@@@@@@@@@@@@@@@', MSG007));

    //         _MaxCount := _SendedSMSHistory.Count;
    //         repeat

    //             _LoopCount += 1;

    //             if GuiAllowed then
    //                 Windows.Update(1, Round(_LoopCount / _MaxCount * 10000, 1));

    //             //ˆÃŒŒ‘÷ •¸œŠ×
    //             _SQL := ' SELECT TOP 1 ISNULL([CMID],' + ConvertText('', '', false) + ') AS [CMID]';
    //             _SQL += ' ,ISNULL([STATUS],0) AS [STATUS]';
    //             _SQL += ' ,ISNULL([CALL_STATUS],' + ConvertText('', '', false) + ') AS [CALL_STATUS]';
    //             _SQL += ' ,ISNULL([REQUEST_TIME],' + ConvertText('', '1753-01-01', false) + ') AS [REQUEST_TIME]';
    //             _SQL += ' FROM [dbo].[BIZ_MSG]';
    //             _SQL += ' WHERE [CMID] = ' + ConvertText(Format(_SendedSMSHistory."Entry No."), '', false);
    //             /*
    //             //‡ž€¸•¸œŠ×
    //             _SQL := ' UNION ALL ';
    //             _SQL := ' SELECT TOP 1 ISNULL([CMID],0) AS [CMID]';
    //             _SQL += ' ,ISNULL([STATUS],0) AS [STATUS]';
    //             _SQL += ' ,ISNULL([CALL_STATUS],'') AS [CALL_STATUS]';
    //             _SQL += ' ,ISNULL([REQUEST_TIME],'1753-01-01') AS [REQUEST_TIME]';
    //             _SQL += ' FROM [dbo].[BIZ_LOG]';
    //             _SQL += ' WHERE [CMID] = '+ConvertText(FORMAT(_SendedSMSHistory."Entry No."),'',FALSE);
    //             */

    //             SQLCommand := SQLCommand.SqlCommand(_SQL, SQLConnection);
    //             SQLCommand.CommandTimeout(4);
    //             Clear(SQLReader);
    //             SQLReader := SQLCommand.ExecuteReader();

    //             while SQLReader.Read() do begin

    //                 case _SendedSMSHistory.Status of
    //                     _SendedSMSHistory.Status::Waiting:
    //                         _StateCode := '0';
    //                     _SendedSMSHistory.Status::Send:
    //                         _StateCode := '7';
    //                     _SendedSMSHistory.Status::WaitingCompletion:
    //                         _StateCode := '1';
    //                     _SendedSMSHistory.Status::Complete:
    //                         _StateCode := '2';
    //                     _SendedSMSHistory.Status::ExchangeSending:
    //                         _StateCode := '11';
    //                 end;

    //                 if (_StateCode <> Format(SQLReader.Item('STATUS'))) or
    //                    (_SendedSMSHistory."Result Status Code" <> Format(SQLReader.Item('CALL_STATUS'))) then begin
    //                     //Update
    //                     if Format(SQLReader.Item('REQUEST_TIME')) <> '1753-01-01' then
    //                         _SendedSMSHistory."Report Date" := SQLReader.Item('REQUEST_TIME');

    //                     case Format(SQLReader.Item('STATUS')) of
    //                         '0':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::Waiting;
    //                         '7':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::Send;
    //                         '1':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::WaitingCompletion;
    //                         '2':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::Complete;
    //                         '11':
    //                             _SendedSMSHistory.Status := _SendedSMSHistory.Status::ExchangeSending;
    //                     end;

    //                     _SendedSMSHistory."Result Status Code" := Format(SQLReader.Item('CALL_STATUS'));
    //                     _SendedSMSHistory.Modify;
    //                 end;
    //             end;
    //         until _SendedSMSHistory.Next = 0;
    //         CloseConn;

    //         if GuiAllowed then
    //             Windows.Close;

    //         exit(true);
    //     end;

    // end;


    // procedure SQLValueText(pText: Text; pRemove: Text; pIsComma: Boolean) rst: Text
    // var
    //     _Comma: Text;
    // begin

    //     if pIsComma then
    //         _Comma := Format(Comma);

    //     //pText := DELCHR(pText,'=','!|#|$|%|''');

    //     rst := _Comma + Format(SingleQuote) + DelChr(pText, '=', pRemove) + Format(SingleQuote);

    //     exit(rst);
    // end;

    // trigger SQLCommand::StatementCompleted(sender: Variant; e: DotNet StatementCompletedEventArgs)
    // begin
    // end;

    // trigger SQLCommand::Disposed(sender: Variant; e: DotNet EventArgs)
    // begin
    // end;

    // trigger SQLConnection::InfoMessage(sender: Variant; e: DotNet SqlInfoMessageEventArgs)
    // begin
    // end;

    // trigger SQLConnection::StateChange(sender: Variant; e: DotNet StateChangeEventArgs)
    // begin
    // end;

    // trigger SQLConnection::Disposed(sender: Variant; e: DotNet EventArgs)
    // begin
    // end;
    ////zzz--
}

