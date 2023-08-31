codeunit 60003 "Convert External DB Data"
{
    ////zzz++
    // trigger OnRun()
    // begin

    //     if OpenConn('') then begin

    //         InsertCustomer;

    //         InsertContract;

    //         CloseConn;
    //         Message('Complete!');
    //     end else begin
    //         Error('Fail Connect');
    //     end;
    // end;

    // var
    //     SQLConnection: DotNet SqlConnection;
    //     SQLCommand: DotNet SqlCommand;
    //     SQLReader: DotNet SqlDataReader;
    //     Comma: Label ',';
    //     SingleQuote: Label '''';
    //     MSG001: Label 'Recipient contact not specified.';
    //     MSG002: Label 'SMS Subject does not exist.';
    //     MSG003: Label '%1 DB connection is not supported.';
    //     MSG004: Label 'SMS Message does not exist.';
    //     SQL: Text;


    // procedure OpenConn(pExtDBConInfor_Code: Code[20]) Rtn: Boolean
    // var
    //     _ExtDBConInfor: Record "DK_External DB Con. Infor.";
    //     _ConnectionString: Text;
    //     _ServerName: Text[30];
    //     _DBName: Text[30];
    //     _DBUserID: Text[30];
    //     _DBUserPW: Text[30];
    // begin
    //     Clear(SQLReader);
    //     Clear(SQLCommand);
    //     Clear(SQLConnection);

    //     //IF _ExtDBConInfor.GET(pExtDBConInfor_Code) THEN BEGIN

    //     _ServerName := 'ypark-dev\BCDEMO';
    //     _DBName := 'Yongin_SYS';
    //     _DBUserID := 'ExternalUser';
    //     _DBUserPW := 'Deex12!@';

    //     case _ExtDBConInfor."DB Type" of
    //         _ExtDBConInfor."DB Type"::"MS-SQL":
    //             begin

    //                 _ConnectionString := 'Data Source=' + _ServerName + ';'
    //                                     + 'Initial Catalog=' + _DBName + ';'
    //                                     + 'Uid=' + _DBUserID + ';'
    //                                     + 'Pwd=' + _DBUserPW + ';';

    //             end;
    //         else begin
    //             Error(MSG003, _ExtDBConInfor."DB Type");
    //         end;
    //     end;

    //     SQLConnection := SQLConnection.SqlConnection(_ConnectionString);

    //     SQLConnection.Open;
    //     SQLCommand := SQLConnection.CreateCommand();

    //     exit(true);
    //     //END;
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


    // procedure ConvertText(pText: Text; pRemove: Text; pIsComma: Boolean) rst: Text
    // var
    //     _Comma: Text;
    // begin

    //     if pIsComma then
    //         _Comma := Format(Comma);

    //     pText := DelChr(pText, '=', '!|#|$|%|''');

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

    // local procedure InsertCustomer()
    // var
    //     _Customer: Record DK_Customer;
    // begin

    //     //TAXBILL Query
    //     SQL := 'SELECT RTRIM(ISSU_SEQNO) AS ISSU_SEQNO,';
    //     SQL += ' RTRIM(STAT_CODE) AS STAT_CODE,';
    //     SQL += ' RTRIM(ISSU_ID) AS ISSU_ID,';
    //     SQL += ' RTRIM(ERR_CD) AS ERR_CD,';
    //     SQL += ' RTRIM(ERR_MSG) AS ERR_MSG,';
    //     SQL += ' RTRIM(ISSU_DATE) AS ISSU_DATE';
    //     SQL += ' FROM [dbo].[ITIS_ISSU_MSTR]';
    //     //SQL += ' WHERE ISSU_SEQNO = '+ConvertText(pVATDocIssueNo,'',FALSE);

    //     SQLCommand := SQLCommand.SqlCommand(SQL, SQLConnection);
    //     SQLCommand.CommandTimeout(0);
    //     //        SQLCommand.CommandType := 4; // for a Query

    //     SQLReader := SQLCommand.ExecuteReader();

    //     while SQLReader.Read() do begin

    //         /*
    //         IF FORMAT(SQLReader.Item('ISSU_DATE')) = '' THEN BEGIN
    //             _ConDate := 0D;
    //         END ELSE BEGIN

    //             EVALUATE(_ConYear, COPYSTR(SQLReader.Item('ISSU_DATE'), 1, 4));
    //             EVALUATE(_ConMonth, COPYSTR(SQLReader.Item('ISSU_DATE'), 6, 2));
    //             EVALUATE(_ConDay, COPYSTR(SQLReader.Item('ISSU_DATE'), 9, 2));
    //             _ConDate := DMY2DATE(_ConDay,_ConMonth,_ConYear);
    //         END;


    //         IF (_VATDocIssueEntry."E-TAX Status Code" <> FORMAT(SQLReader.Item('STAT_CODE'))) OR
    //             (_VATDocIssueEntry."E-TAX Issue ID" <> FORMAT(SQLReader.Item('ISSU_ID'))) OR
    //             (_VATDocIssueEntry."E-TAX Error Code" <> FORMAT(SQLReader.Item('ERR_CD'))) OR
    //             (_VATDocIssueEntry."E-TAX Error Message" <> FORMAT(SQLReader.Item('ERR_MSG'))) THEN BEGIN

    //               _VATDocIssueEntry."E-TAX Status Code" := SQLReader.Item('STAT_CODE');
    //               _VATDocIssueEntry."E-TAX Issue ID" := SQLReader.Item('ISSU_ID');
    //               _VATDocIssueEntry."E-TAX Error Code" := SQLReader.Item('ERR_CD');
    //               _VATDocIssueEntry."E-TAX Error Message" := SQLReader.Item('ERR_MSG');
    //               _VATDocIssueEntry."E-TAX Issue Date" := _ConDate;

    //               _VATDocIssueEntry.MODIFY(FALSE);
    //          END;
    //          */
    //     end;

    // end;

    // local procedure InsertContract()
    // var
    //     _Contract: Record DK_Contract;
    // begin
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

