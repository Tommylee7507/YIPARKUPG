codeunit 50000 "DK_Common Function"
{
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2935 - 2021-12-17
    //   - Modify Function: CheckDigitSSNo


    trigger OnRun()
    begin
    end;

    var
        ChangeLogMgt: Codeunit "Change Log Management";
        MSG001: Label '%1 Year General Fee';
        MSG002: Label '%1 Year Landscape Fee';
        MSG003: Label 'An undefined image extension. Available image extensions (*.jpg, *.gif, *.bmp, *.png)';
        MSG005: Label 'Your PC cannot connect to the NAS server or the folder related to this contract cannot be found on the NAS server. Please contact your administrator.';
        MSG006: Label '%1\%2\';
        MSG007: Label 'The following folder could not be found. %1';


    procedure GetCompareRecordValue(pOrgRecRef: RecordRef; pRevRecRef: RecordRef): Boolean
    var
        _FldRef: FieldRef;
        _FldRef2: FieldRef;
        _i: Integer;
    begin
        for _i := 1 to pOrgRecRef.FieldCount do begin
            //Rev Exists
            if GetRevFieldExists(pRevRecRef, _i) then begin
                _FldRef := pOrgRecRef.Field(_i);
                //Org Exists
                if GetOrgFieldExists(pOrgRecRef, _i) then begin
                    //Rev Field Validate & Get Value
                    if ChangeLogMgt.EvaluateTextToFieldRef(Format(_FldRef.Value), _FldRef) then begin
                        //Org Field Validate & Get Value
                        if GetOrgFieldValues(pRevRecRef, _i, _FldRef2) then begin
                            //Compare Rev & Org
                            if _FldRef.Value <> _FldRef2.Value then
                                exit(true);
                        end;
                    end;
                end;
            end;
        end;
    end;

    local procedure GetOrgFieldValues(pOrgRecRef: RecordRef; pColumn: Integer; var pFldRef: FieldRef): Boolean
    begin
        pFldRef := pOrgRecRef.Field(pColumn);
        exit(ChangeLogMgt.EvaluateTextToFieldRef(Format(pFldRef.Value), pFldRef));
    end;

    local procedure GetRevFieldExists(pRevRecRef: RecordRef; pColumn: Integer): Boolean
    var
        _FldRef: FieldRef;
        _RecRef: RecordRef;
    begin
        if pRevRecRef.FieldExist(pColumn) then
            exit(true);
    end;

    local procedure GetOrgFieldExists(pOrgRecRef: RecordRef; pColumn: Integer): Boolean
    var
        _FldRef: FieldRef;
        _RecRef: RecordRef;
    begin
        if pOrgRecRef.FieldExist(pColumn) then
            exit(true);
    end;


    procedure GetKoreanCharLen(pTextData: Text): Integer
    var
    // Encoding: DotNet Encoding;////zzz
    begin

        // Clear(Encoding);////zzz

        // exit(Encoding.Default.GetByteCount(pTextData));////zzz
    end;


    procedure GetCaptionWithContract(pOption: Text[1]): Text
    var
        _FunctionSetup: Record "DK_Function Setup";
    begin

        _FunctionSetup.Get;

        if pOption = '1' then
            exit(StrSubstNo(MSG001, _FunctionSetup."Management Unit"))
        else
            exit(StrSubstNo(MSG002, _FunctionSetup."Management Unit"));
    end;


    procedure GetBlobImageExtension(pInStream: InStream): Text[10]
    var
        _MyChar: Char;
        _MyString: Text;
        _i: Integer;
    begin

        for _i := 1 to 10 do begin
            pInStream.Read(_MyChar, 1);
            _MyString += Format(_MyChar);
        end;

        if CopyStr(_MyString, 7, 4) = 'JFIF' then
            exit('jpg')
        else
            if CopyStr(_MyString, 2, 3) = 'PNG' then
                exit('png')
            else
                if CopyStr(_MyString, 1, 3) = 'GIF' then
                    exit('gif')
                else
                    if CopyStr(_MyString, 1, 2) = 'BM' then
                        exit('bmp')
                    else
                        Error(MSG003);
    end;


    procedure CheckDigitSSNo(pSSNo: Text): Boolean
    var
        _SSNo: Text[20];
        _ArrChar: array[13] of Text[1];
        _ArrInt: array[13] of Integer;
        _Loop: Integer;
        _Total: Integer;
        _IntResult: Integer;
        _Day: Integer;
        _Month: Integer;
        _Year: Integer;
        _IntCheck1: Integer;
        _IntCheck2: Integer;
        txt58000: Label 'Resident Registration No. is invalid.';
        _Result: Text[1];
        _Gender: Integer;
        _AlDay: Integer;
        _YearMonth: Integer;
    begin
        //Social Security No. / ‘´‰ž…Ø‡Ÿ‰°˜ú ›‘ã
        //Social Security No. / ‘´‰ž…Ø‡Ÿ‰°˜ú ›‘ã
        _SSNo := DelChr(pSSNo, '=', '-');
        _SSNo := DelChr(_SSNo, '=', ' ');

        if (StrLen(_SSNo) = 0) then exit(false);
        if (StrLen(_SSNo) <> 13) then exit(false);

        _Loop := 1;
        repeat

            _ArrChar[_Loop] := CopyStr(_SSNo, _Loop, 1);

            case _ArrChar[_Loop] of
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-':
                    begin
                        Evaluate(_ArrInt[_Loop], _ArrChar[_Loop]);
                    end;
                else begin
                    exit(false);
                end;
            end;
            _Loop := _Loop + 1;
        until _Loop = 14;


        Evaluate(_Year, CopyStr(_SSNo, 1, 2));
        Evaluate(_Month, CopyStr(_SSNo, 3, 2));
        Evaluate(_Day, CopyStr(_SSNo, 5, 2));

        Evaluate(_Gender, CopyStr(_SSNo, 7, 1));
        case _Gender of
            1, 2, 5, 6:
                _Year += 1900;
            3, 4, 7, 8:
                _Year += 2000;
            9, 0:
                _Year += 1800;
        end;

        //>>Date Validation Check
        if (_Year < 1800) or (_Year > 3000) then exit(false);
        if (_Month < 1) or (_Month > 12) then exit(false);

        _AlDay := Date2DMY(CalcDate('<+CM>', (DMY2Date(1, _Month, _Year))), 1);
        if _AlDay < _Day then exit(false);
        //<<Date Validation Check

        _Total := ((_ArrInt[1] * 2) +
                    (_ArrInt[2] * 3) +
                    (_ArrInt[3] * 4) +
                    (_ArrInt[4] * 5) +
                    (_ArrInt[5] * 6) +
                    (_ArrInt[6] * 7) +
                    (_ArrInt[7] * 8) +
                    (_ArrInt[8] * 9) +
                    (_ArrInt[9] * 2) +
                    (_ArrInt[10] * 3) +
                    (_ArrInt[11] * 4) +
                    (_ArrInt[12] * 5));


        //_Total := _Total MOD 11;
        //_Result := COPYSTR(FORMAT(11 - _Total), STRLEN(FORMAT(11 - _Total)),1);

        case _Gender of
            5, 6, 7, 8:
                begin//Â€‰ž
                    _Total := _Total mod 11;
                    _Result := CopyStr(Format(13 - _Total), StrLen(Format(13 - _Total)), 2);
                end;
            else begin//‚‹€‰ž
                _Total := _Total mod 11;
                _Result := CopyStr(Format(11 - _Total), StrLen(Format(11 - _Total)), 1);
            end;
        end;

        //IF _IntResult > 9 THEN
        //  _IntResult := (_IntResult MOD 10);

        if _Result = _ArrChar[13] then
            exit(true);

        // >> #2935 : ‘´‰ž…Ø‡Ÿ‰°˜ú ‚–×Ž˜ “Èí (2020‚Ë 10õ œ˜” ‘´‰ž…Ø‡Ÿ‰°˜ú ‰È€ÃÀ„’ ›‘ã‰°˜úí ‘ˆÏ—Ÿ‘÷ Žš×, ŒŠŠ‰°˜úÂ ‚¬ˆ®‘÷ ‰°˜ú„’ ‰½Áº‰°˜ú‡ž ‹²ŒŠ…š.)
        Evaluate(_YearMonth, CopyStr(_SSNo, 1, 4));
        if (_YearMonth >= 2010) then
            exit(true);
        // << #2935
    end;


    procedure CheckValidMobileNo(var pMobileNo: Text): Boolean
    var
        _Char: Text[1];
        _StrLen: Integer;
        _Loop: Integer;
        _NumLoop: Integer;
        _ArrNum: array[5] of Text;
    begin
        //Œ²À'-'¬ˆˆ “Œ• ‰¸ Àˆ„Œ÷
        if pMobileNo = '' then exit(true);

        pMobileNo := DelChr(pMobileNo, '=', ' ');

        case CopyStr(pMobileNo, 1, 3) of
            '010', '011', '016', '017', '018', '019':
                begin
                    //Pass
                end;
            else
                exit(false); //
        end;

        _StrLen := StrLen(pMobileNo);

        _Loop := 1;
        _NumLoop := 1;
        repeat

            _Char := CopyStr(pMobileNo, _Loop, 1);
            case _Char of
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
                    begin
                        //Pass
                        _ArrNum[_NumLoop] := _ArrNum[_NumLoop] + _Char;
                    end;
                '-':
                    begin
                        _NumLoop += 1;
                    end;
                '+':
                    begin
                    end;
                else begin
                    exit(false);
                end
            end;
            _Loop += 1;
        until _Loop = _StrLen + 1;

        if _NumLoop <> 3 then
            exit(false);

        _Loop := 1;
        repeat

            case _Loop of
                1:
                    begin
                        if StrLen(_ArrNum[_Loop]) <> 3 then
                            exit(false);
                    end;
                2:
                    begin
                        if (StrLen(_ArrNum[_Loop]) <> 3) and (StrLen(_ArrNum[_Loop]) <> 4) then
                            exit(false);
                    end;
                3:
                    begin
                        if StrLen(_ArrNum[_Loop]) <> 4 then
                            exit(false);
                    end
                else begin
                    exit(false);
                end;
            end;

            _Loop += 1;
        until _Loop = _NumLoop + 1;


        exit(true);
    end;


    procedure CheckValidPhoneNo(var pPhoneNo: Text): Boolean
    var
        _Char: Text[1];
        _StrLen: Integer;
        _Loop: Integer;
        _NumLoop: Integer;
        _ArrNum: array[5] of Text;
    begin
        //Œ²À'-'¬ˆˆ “Œ•
        if pPhoneNo = '' then exit(true);

        pPhoneNo := DelChr(pPhoneNo, '=', ' ');

        _StrLen := StrLen(pPhoneNo);

        _Loop := 1;
        _NumLoop := 1;
        repeat

            _Char := CopyStr(pPhoneNo, _Loop, 1);
            case _Char of
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
                    begin
                        //Pass
                        _ArrNum[_NumLoop] := _ArrNum[_NumLoop] + _Char;
                    end;
                '-':
                    begin
                        _NumLoop += 1;
                    end;
                else begin
                    exit(false);
                end
            end;
            _Loop += 1;
        until _Loop = _StrLen + 1;

        exit(true);
    end;

    ////zzz++
    // procedure OpenFolderClient(pFolder: Text; pAddFolder: Text)
    // var
    //     _FileMgt: Codeunit "File Management";
    //     _ClientFolder: Text;
    // begin

    //     if pAddFolder = '' then
    //         _ClientFolder := pFolder
    //     else
    //         ;
    //     _ClientFolder := StrSubstNo(MSG006, pFolder, pAddFolder);

    //     if _FileMgt.ClientDirectoryExists(pFolder) then begin

    //         if not _FileMgt.ClientDirectoryExists(_ClientFolder) then begin
    //             _FileMgt.CreateClientDirectory(_ClientFolder);
    //         end;

    //         if _FileMgt.ClientDirectoryExists(_ClientFolder) then
    //             HyperLink(_ClientFolder);

    //     end else
    //         Error(MSG007, _ClientFolder);
    // end;
    ////zzz--

    procedure UpdateJobQueueHistoty(pRunType: Option; pMessage: Text[250])
    var
        _ScheduleRunHistory: Record "DK_Schedule Run History";
    begin

        _ScheduleRunHistory.Reset;
        _ScheduleRunHistory.SetRange("Run Type", pRunType);
        _ScheduleRunHistory.SetRange("Run Date", Today);
        if _ScheduleRunHistory.FindFirst then begin
            _ScheduleRunHistory."Run Type" := pRunType;
            _ScheduleRunHistory.Message := pMessage;
            _ScheduleRunHistory."Run Date/Time" := CurrentDateTime;
            _ScheduleRunHistory."No. of Run" += 1;
            _ScheduleRunHistory.Modify;
        end else begin
            _ScheduleRunHistory.Init;
            _ScheduleRunHistory."Run Type" := pRunType;
            _ScheduleRunHistory."Run Date" := Today;
            _ScheduleRunHistory.Message := pMessage;
            _ScheduleRunHistory."Run Date/Time" := CurrentDateTime;
            _ScheduleRunHistory."No. of Run" := 1;
            _ScheduleRunHistory.Insert;
        end;
    end;


    procedure GetCemeteryNoSplit(pCemeteryNo: Text[30]; var pGroup: Text[30]; var pSeq: Text[30])
    var
        _MaxLen: Integer;
        _i: Integer;
        _Chr: Text[1];
        _First: Integer;
        _Cnt: Integer;
    begin

        _MaxLen := StrLen(pCemeteryNo);

        for _i := 1 to _MaxLen do begin

            _Chr := CopyStr(pCemeteryNo, _i, 1);


            if CheckInteger(_Chr) then begin

                if _First = 0 then
                    _First := _i;

                _Cnt += 1;
                if _Cnt = 4 then begin
                    pGroup := CopyStr(pCemeteryNo, 1, _First - 2);
                    pSeq := CopyStr(pCemeteryNo, _First, StrLen(pCemeteryNo));
                    exit;
                end;
            end else begin
                _First := 0;
                _Cnt := 0;
            end;
        end;
    end;

    local procedure CheckInteger(pStr: Text[1]): Boolean
    begin

        case pStr of
            '0':
                exit(true);
            '1':
                exit(true);
            '2':
                exit(true);
            '3':
                exit(true);
            '4':
                exit(true);
            '5':
                exit(true);
            '6':
                exit(true);
            '7':
                exit(true);
            '8':
                exit(true);
            '9':
                exit(true);
        end;

        exit(false);
    end;

    ////zzz++
    // procedure ResizeImage(var pTempBlob: Record TempBlob temporary; pUpsizeIfSmaller: Boolean; pMaintainAspectRatio: Boolean; pNewWidth: Integer; pNewHeight: Integer)
    // var
    //     _Bitmap: DotNet Bitmap;
    //     _ImageFormat: DotNet ImageFormat;
    //     _Instr: InStream;
    //     _Outstr: OutStream;
    //     _AspectRatio: Decimal;
    //     _ResultWidth: Decimal;
    //     _ResultHeight: Decimal;
    // begin

    //     //_NewWidth := 300;
    //     //_NewWidth := 300;

    //     if (pNewWidth = 0) or (pNewHeight = 0) then
    //         exit;

    //     pTempBlob.Blob.CreateInStream(_Instr);

    //     _Bitmap := _Bitmap.Bitmap(_Instr);


    //     //IF NOT pUpsizeIfSmaller THEN
    //     if (pNewWidth >= _Bitmap.Width) or (pNewHeight >= _Bitmap.Height) then
    //         exit;

    //     _ResultWidth := Round(_Bitmap.Width / pNewWidth, 1);
    //     _ResultHeight := Round(_Bitmap.Height / pNewHeight, 1);

    //     if _ResultWidth < _ResultHeight then
    //         _AspectRatio := _ResultWidth
    //     else
    //         _AspectRatio := _ResultHeight;

    //     if pMaintainAspectRatio then begin
    //         pNewHeight := Round(_Bitmap.Height / _AspectRatio, 1);
    //         pNewWidth := Round(_Bitmap.Width / _AspectRatio, 1);
    //     end;

    //     Clear(pTempBlob.Blob);
    //     pTempBlob.Blob.CreateOutStream(_Outstr);
    //     _Bitmap := _Bitmap.Bitmap(_Bitmap, pNewWidth, pNewHeight);

    //     _Bitmap.Save(_Outstr, _ImageFormat.Jpeg);
    // end;
    ////zzz--

    procedure ConvertDate(pStrDate: Text[8]): Date
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
    begin

        pStrDate := DelChr(pStrDate, '=', ' ');

        if pStrDate = '' then exit(0D);

        Evaluate(_Year, CopyStr(pStrDate, 1, 4));
        Evaluate(_Month, CopyStr(pStrDate, 5, 2));
        Evaluate(_Day, CopyStr(pStrDate, 7, 2));

        exit(DMY2Date(_Day, _Month, _Year));
    end;
}

