codeunit 50021 "DK_Batch SMS Sending"
{
    // 
    // DK34: 20201026
    //   - Modify Function: SetMessageType
    // 
    // DK22.09 : 2022.09.06
    //   Ticket 3916


    trigger OnRun()
    var
        _ExtDBProcess: Codeunit "DK_External DB Process";
    begin

        Clear(_ExtDBProcess);
        // _ExtDBProcess.UpdateSMSResult(0);////zzz
    end;

    var
        ExternalDBProcess: Codeunit "DK_External DB Process";
        MSG001: Label 'Please specify a To contact.';
        MSG002: Label 'Invalid contact. %1';
        MSG003: Label '[Yongin Park]';
        MSG004: Label 'To contact not specified.';
        MSG005: Label 'From contact not specified.';
        MSG006: Label 'SMS Message not specified.';
        MSG007: Label 'The Sended SMS History To Entry No. was not generated. Please contact your administrator.';
        MSG008: Label 'Customer';
        MSG009: Label 'Cemetry';
        MSG010: Label 'EndDate2';
        MSG011: Label 'EndDate2';
        MSG012: Label 'Complate';
        MSG013: Label '%1 : Remaining Amount %2';
        MSG014: Label '[Yongin Park]';
        MSG015: Label '%1 %2 %3:%4';


    procedure CheckValidate(pObjectID: Integer; pFromMobileNo: Text[20]; pMessage: Text)
    var
        _FunctionSetup: Record "DK_Function Setup";
        _ReportBuffer: Record "DK_Report Buffer";
    begin

        if pFromMobileNo = '' then Error(MSG005);
        if pMessage = '' then Error(MSG006);

        CheckMobileNo(pFromMobileNo);

        _ReportBuffer.Reset;
        _ReportBuffer.SetRange("USER ID", UserId);
        _ReportBuffer.SetRange("OBJECT ID", pObjectID);
        _ReportBuffer.SetFilter(CODE0, '<>%1', '');
        if _ReportBuffer.FindSet then begin
            repeat
                CheckMobileNo(_ReportBuffer.CODE0)
            until _ReportBuffer.Next = 0;
        end else
            Error(MSG001);

        //AddHistory()
    end;


    procedure SendingSMS_SelectContract(pObjectID: Integer; pFromMobileNo: Text[20]; pSubject: Text[100]; pMessage: Text; pFilePatch1: Text[100]; pFilePatch2: Text[100]; pFilePatch3: Text[100]; pBaseContractNo: Code[20]; pType: Option; pBizTalkTemplateNo: Text[30])
    var
        _FunctionSetup: Record "DK_Function Setup";
        _ReportBuffer: Record "DK_Report Buffer";
        _DocNo: Text[20];
        _Contract: Record DK_Contract;
        _ContractNo: Code[20];
        _NewMessage: Text;
        _FilePatch1: Text[100];
        _FilePatch2: Text[100];
        _FilePatch3: Text[100];
        _FileMgt: Codeunit "File Management";
    begin

        _FunctionSetup.Get;
        _FunctionSetup.TestField("SMS DB Con. Code");

        CheckValidate(pObjectID, pFromMobileNo, pMessage);

        //_ReportBuffer.CODE0 :: toMobileNo
        //_ReportBuffer.CODE1 :: ContractNo

        if pSubject = '' then
            pSubject := MSG014;


        _ReportBuffer.Reset;
        _ReportBuffer.SetRange("USER ID", UserId);
        _ReportBuffer.SetRange("OBJECT ID", pObjectID);
        _ReportBuffer.SetFilter(CODE0, '<>%1', '');
        if _ReportBuffer.FindSet then begin

            repeat

                if _ReportBuffer.CODE1 = '' then
                    _ContractNo := pBaseContractNo
                else
                    _ContractNo := _ReportBuffer.CODE1;

                _NewMessage := SetMessageType(pType, pMessage, _ContractNo);

                _DocNo := AddHistory(pFromMobileNo, _ReportBuffer.CODE0, pSubject, _NewMessage, pFilePatch1, pFilePatch2, pFilePatch3, false, 0, _ReportBuffer.CODE1, 0, pBizTalkTemplateNo, _ContractNo);

                if _DocNo = '' then
                    Error(MSG007);

                //Attch Files
                Clear(_FileMgt);
                if pFilePatch1 <> '' then
                    _FilePatch1 := _FileMgt.GetFileName(pFilePatch1);
                if pFilePatch2 <> '' then
                    _FilePatch2 := _FileMgt.GetFileName(pFilePatch2);
                if pFilePatch3 <> '' then
                    _FilePatch3 := _FileMgt.GetFileName(pFilePatch3);

            // ExternalDBProcess.SendSMS(_DocNo, pFromMobileNo, _ReportBuffer.CODE0, pSubject, _NewMessage, _FilePatch1, _FilePatch2, _FilePatch3, pBizTalkTemplateNo);////zzz

            until _ReportBuffer.Next = 0;
        end;
    end;


    procedure SingleSendingSMS(pFromMobileNo: Text[20]; pToMobileNo: Text[20]; pSubject: Text[100]; pMessage: Text; pFilePatch1: Text[100]; pFilePatch2: Text[100]; pFilePatch3: Text[100]; pAutoSending: Boolean; pSourceType: Option; pSourceNo: Code[20]; pSourceLineNo: Integer; pBizTalkTemplateNo: Text[30]; pContractNo: Code[20])
    var
        _FunctionSetup: Record "DK_Function Setup";
        _DocNo: Text[20];
        _FileMgt: Codeunit "File Management";
    begin

        if pFromMobileNo = '' then Error(MSG005);
        if pToMobileNo = '' then Error(MSG004);
        if pMessage = '' then Error(MSG006);
        CheckMobileNo(pFromMobileNo);

        _FunctionSetup.Get;
        _FunctionSetup.TestField("SMS DB Con. Code");

        if pSubject = '' then
            pSubject := MSG014;

        //Attch Files

        Clear(_FileMgt);
        if pFilePatch1 <> '' then
            pFilePatch1 := _FileMgt.GetFileName(pFilePatch1);
        if pFilePatch2 <> '' then
            pFilePatch2 := _FileMgt.GetFileName(pFilePatch2);
        if pFilePatch3 <> '' then
            pFilePatch3 := _FileMgt.GetFileName(pFilePatch3);

        _DocNo := AddHistory(pFromMobileNo, pToMobileNo, pSubject, pMessage, pFilePatch1, pFilePatch2, pFilePatch3, pAutoSending, pSourceType, pSourceNo, pSourceLineNo, pBizTalkTemplateNo, pContractNo);

        if _DocNo = '' then
            Error(MSG007);

        Clear(ExternalDBProcess);
        // ExternalDBProcess.SendSMS(_DocNo, pFromMobileNo, pToMobileNo, pSubject, pMessage, pFilePatch1, pFilePatch2, pFilePatch3, pBizTalkTemplateNo);////zzz

        //ExternalDBProcess.CloseConn;
    end;


    procedure CheckMobileNo(pMobileNo: Text[20]): Text
    var
        _Mobile: Decimal;
    begin


        pMobileNo := DelChr(pMobileNo, '=', ' ');
        pMobileNo := DelChr(pMobileNo, '=', '-');

        if pMobileNo <> '' then begin
            if Evaluate(_Mobile, pMobileNo) then
                exit(pMobileNo)
            else
                Error(MSG002, pMobileNo);
        end;
    end;


    procedure AddHistory(pFromMobileNo: Text[20]; pToMobileNo: Text[20]; pSubject: Text[100]; pMessage: Text; pFilePatch1: Text[100]; pFilePatch2: Text[100]; pFilePatch3: Text[100]; pAutoSending: Boolean; pSourceType: Option; pSourceNo: Code[20]; pSourceNoLineNo: Integer; pBizTalkTemplateNo: Text[30]; pContractNo: Code[20]): Text[20]
    var
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _TempBlob: Record TempBlob temporary;
        _TempBlob1: Record TempBlob temporary;
        _TempBlob2: Record TempBlob temporary;
        _TempBlob3: Record TempBlob temporary;
        _FileMgt: Codeunit "File Management";
    begin

        _SendedSMSHistory.LockTable;
        _SendedSMSHistory.Init;
        _SendedSMSHistory."Sending Date" := Today;
        _SendedSMSHistory."Sending Time" := Time;
        _SendedSMSHistory."From Phone No." := pFromMobileNo;
        _SendedSMSHistory."To Phone No." := pToMobileNo;
        _SendedSMSHistory.Subject := pSubject;

        _SendedSMSHistory."Short Message" := CopyStr(pMessage, 1, 2000);

        //>>BLOB Message
        //_TempBlob.Blob := _SendedSMSHistory."SMS Message";
        //_TempBlob.WriteAsText(pMessage,TEXTENCODING::Windows);
        //_SendedSMSHistory."SMS Message" := _TempBlob.Blob;

        if pFilePatch1 <> '' then begin
            if _FileMgt.ServerFileExists(pFilePatch1) then begin
                // _FileMgt.BLOBImportFromServerFile(_TempBlob1, pFilePatch1);////zzz
                _TempBlob1.CalcFields(Blob);
                _SendedSMSHistory.Image1 := _TempBlob1.Blob;
            end;
        end;

        if pFilePatch2 <> '' then begin
            if _FileMgt.ServerFileExists(pFilePatch2) then begin
                // _FileMgt.BLOBImportFromServerFile(_TempBlob2, pFilePatch2);////zzz
                _TempBlob2.CalcFields(Blob);
                _SendedSMSHistory.Image2 := _TempBlob2.Blob;
            end;
        end;

        if pFilePatch3 <> '' then begin
            if _FileMgt.ServerFileExists(pFilePatch1) then begin
                // _FileMgt.BLOBImportFromServerFile(_TempBlob3, pFilePatch3);////zzz
                _TempBlob3.CalcFields(Blob);
                _SendedSMSHistory.Image3 := _TempBlob3.Blob;
            end;
        end;

        _SendedSMSHistory."Auto Sending" := pAutoSending;
        _SendedSMSHistory."Source Type" := pSourceType;
        _SendedSMSHistory."Source No." := pSourceNo;
        _SendedSMSHistory."Source Line No." := pSourceNoLineNo;
        _SendedSMSHistory."Biz Talk Template No." := pBizTalkTemplateNo;
        _SendedSMSHistory."Contract No." := pContractNo;
        _SendedSMSHistory.Insert(true);

        exit(Format(_SendedSMSHistory."Entry No."));
    end;

    local procedure ExportBLOB()
    begin
    end;


    procedure MovetoServerBLOBFile(var pTempBLOB: Record TempBlob): Text
    var
        _InStream: InStream;
        _FileExtension: Text[30];
        _ComFun: Codeunit "DK_Common Function";
        _FileMgt: Codeunit "File Management";
        _ImageServerFileName: Text;
        _FunctionSetup: Record "DK_Function Setup";
    begin
        ////zzz++
        // _FunctionSetup.Get;
        // _FunctionSetup.TestField("SMS Image Server TempFolder");

        // pTempBLOB.Blob.CreateInStream(_InStream);

        // _FileExtension := _ComFun.GetBlobImageExtension(_InStream);

        // _ImageServerFileName := _FileMgt.ServerTempFileName(_FileExtension);
        // _ImageServerFileName := _FileMgt.GetFileName(_ImageServerFileName);
        // if CopyStr(_FunctionSetup."SMS Image Server TempFolder", StrLen(_FunctionSetup."SMS Image Server TempFolder"), 1) = '\' then
        //     _ImageServerFileName := _FunctionSetup."SMS Image Server TempFolder" + _ImageServerFileName
        // else
        //     _ImageServerFileName := _FunctionSetup."SMS Image Server TempFolder" + '/' + _ImageServerFileName;

        // if _FileMgt.ServerFileExists(_ImageServerFileName) then
        //     _FileMgt.DeleteServerFile(_ImageServerFileName);

        // _FileMgt.BLOBExportToServerFile(pTempBLOB, _ImageServerFileName);

        // if _FileMgt.ServerFileExists(_ImageServerFileName) then begin
        //     exit(_ImageServerFileName);
        // end;
        ////zzz--
    end;


    procedure SetMessageType(pType: Option General,PurchContract,RemAmount,Vehicle,FieldWork,CustRequest,Service,Receipt,PaymentExpectPG,PaymentExpectVA,ReagreeInfo; pMessage: Text; pCode: Code[20]): Text
    var
        _Contract: Record DK_Contract;
        _CemeteryServices: Record "DK_Cemetery Services";
        _PurchaseContract: Record "DK_Purchase Contract";
        _FieldWorkHeader: Record "DK_Field Work Header";
        _CustomerRequests: Record "DK_Customer Requests";
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
        _PayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
        _GeneralExpirationDate: Date;
        _LandExpirationDate: Date;
        _GenralAmount: Decimal;
        _LandAmount: Decimal;
        _FunSetup: Record "DK_Function Setup";
        _PaymentItem: Text[30];
        _PaymentContents: Text;
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
        _CR: Char;
        _VehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header";
        _Vehicle: Record DK_Vehicle;
        _GeneralStartDate: Date;
        _LandArcStartDate: Date;
        _NextGeneralExpirationDate: array[3] of Date;
        _NextLandArcExpirationDate: array[3] of Date;
        _NextGenNonPayment: array[3] of Decimal;
        _NextLandNonPayment: array[3] of Decimal;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _ContactName: Text[30];
        _PayExpGenStartDate: Text;
        _PayExpGenEndDate: Text;
        _PayExpLandStartDate: Text;
        _PayExpLandEndDate: Text;
    begin
        _CR := 13;  ///EnterValue

        case pType of
            pType::General:
                begin
                    //%1: ×„ œˆº, %2: ‰ª¬‰°˜ú, %3: Ÿ‰¦ ‘Ž‡ßŸ, %4: ‘†µ ‘Ž‡ßŸ, %5: Ÿ‰¦ ‰œ‚‚Ž¸,
                    //%6: ‘†µ ‰œ‚‚Ž¸, %7: „“ ‚»’Ñ, %8: Ÿ‰¦ “ÁŸ, %9: ‘†µ “ÁŸ, %10: Ð‘’‰°˜ú(‚Ý—õ),
                    //%11: Ð‘’‰°˜ú(€ËŽð), %12: Ÿ‰¦ 5‚Ë ‘Ž‡ßŸ, %13: Ÿ‰¦ 5‚Ë €¦Ž¸, %14: ‘†µ 5‚Ë ‘Ž‡ßŸ, %15: ‘†µ 5‚Ë €¦Ž¸,
                    //%16: Ÿ‰¦ 1‚Ë ‘Ž‡ßŸ, %17: Ÿ‰¦ 1‚Ë €¦Ž¸ , %18: ‘†µ 1‚Ë ‘Ž‡ßŸ, %19: ‘†µ 1‚Ë €¦Ž¸, %20: Ÿ‰¦ 2‚Ë ‘Ž‡ßŸ,
                    //%21: Ÿ‰¦ 2‚Ë €¦Ž¸, %22: ‘†µ 2‚Ë ‘Ž‡ßŸ, %23: ‘†µ 2‚Ë €¦Ž¸, %24:Ÿ‰¦+‘†µ (5‚Ë), %25:Ÿ‰¦+‘†µ (1‚Ë),
                    //%26:Ÿ‰¦+‘†µ (2‚Ë)

                    _Contract.Reset;
                    _Contract.SetRange("No.", pCode);
                    _Contract.SetRange("Date Filter", 0D, Today);
                    if _Contract.FindSet then begin

                        _Contract.CalcFields("Main Associate Name", "Sub Associate Name");
                        case _Contract."Contact Target" of
                            _Contract."Contact Target"::MainCustomer:
                                _ContactName := _Contract."Main Customer Name";
                            _Contract."Contact Target"::MainAssociate:
                                _ContactName := _Contract."Main Associate Name";
                            _Contract."Contact Target"::SubAssociate:
                                _ContactName := _Contract."Sub Associate Name";
                        end;

                        Clear(_AdminExpenseMgt);

                        if _Contract."General Expiration Date" <> 0D then begin
                            //Ÿ‰¦ýˆ«Š±
                            _GeneralStartDate := (_Contract."General Expiration Date" + 1);
                            _NextGeneralExpirationDate[1] := CalcDate('<+5Y>', _Contract."General Expiration Date");
                            _NextGeneralExpirationDate[2] := CalcDate('<+1Y>', _Contract."General Expiration Date");
                            _NextGeneralExpirationDate[3] := CalcDate('<+2Y>', _Contract."General Expiration Date");

                            if _GeneralStartDate >= Today then begin
                                _NextGenNonPayment[1] := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", 0, Today) * 5;  //ýˆ«Š± 5‚Ë”í
                                _NextGenNonPayment[2] := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", 0, Today) * 1;  //ýˆ«Š± 1‚Ë”í
                                _NextGenNonPayment[3] := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", 0, Today) * 2;  //ýˆ«Š± 2‚Ë”í
                            end else begin
                                _NextGenNonPayment[1] := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 0, _NextGeneralExpirationDate[1], 0D, false);
                                _NextGenNonPayment[2] := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 0, _NextGeneralExpirationDate[2], 0D, false);
                                _NextGenNonPayment[3] := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 0, _NextGeneralExpirationDate[3], 0D, false);
                            end;
                        end;
                        if _Contract."Land. Arc. Expiration Date" <> 0D then begin
                            //‘†µýˆ«Š±
                            _LandArcStartDate := (_Contract."Land. Arc. Expiration Date" + 1);
                            _NextLandArcExpirationDate[1] := CalcDate('<+5Y>', _Contract."Land. Arc. Expiration Date");
                            _NextLandArcExpirationDate[2] := CalcDate('<+1Y>', _Contract."Land. Arc. Expiration Date");
                            _NextLandArcExpirationDate[3] := CalcDate('<+2Y>', _Contract."Land. Arc. Expiration Date");

                            if _LandArcStartDate >= Today then begin
                                _NextLandNonPayment[1] := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", 1, Today) * 5;  //ýˆ«Š± 5‚Ë”í
                                _NextLandNonPayment[2] := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", 1, Today) * 1;  //ýˆ«Š± 1‚Ë”í
                                _NextLandNonPayment[3] := _AdminExpenseMgt.GetYearAdminExpense2(_Contract."Cemetery Code", 1, Today) * 2;  //ýˆ«Š± 2‚Ë”í
                            end else begin
                                _NextLandNonPayment[1] := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 1, _NextLandArcExpirationDate[1], 0D, false);
                                _NextLandNonPayment[2] := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 1, _NextLandArcExpirationDate[2], 0D, false);
                                _NextLandNonPayment[3] := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(_Contract."No.", 1, _NextLandArcExpirationDate[3], 0D, false);
                            end;
                        end;

                        _Contract.CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");
                        exit(StrSubstNo(pMessage, _ContactName,                                 //%1
                                                  _Contract."Cemetery No.",                     //%2
                                                  _Contract."General Expiration Date",          //%3
                                                  _Contract."Land. Arc. Expiration Date",       //%4
                                                  Round(_Contract."Non-Pay. General Amount", 100, '>'),          //%5  100 „Âº “ˆ
                                                  Round(_Contract."Non-Pay. Land. Arc. Amount", 100, '>'),       //%6  100 „Âº “ˆ
                                                  Format(Today, 0, '<Year4>-<Month,2>-<Day,2>'),//%7
                                                  _GeneralStartDate,//%8
                                                  _LandArcStartDate,//%9
                                                  GetReceiptBankInfor('BA001'),//%10 '‚Ý—õŠ—Ê 355-0000-3089-43 ‰€¦‘´:Ï„Â‰²ž Ôž°°'
                                                  GetReceiptBankInfor('BA002'),//%11 '€ËŽðŠ—Ê 239-028691-04-015 ‰€¦‘´:Ï„Â‰²ž Ôž°°'
                                                  _NextGeneralExpirationDate[1],        //%12
                                                  Round(_NextGenNonPayment[1], 100, '>'), //%13
                                                  _NextLandArcExpirationDate[1],        //%14
                                                  Round(_NextLandNonPayment[1], 100, '>'),//%15

                                                  _NextGeneralExpirationDate[2],        //%16
                                                  Round(_NextGenNonPayment[2], 100, '>'), //%17
                                                  _NextLandArcExpirationDate[2],        //%18
                                                  Round(_NextLandNonPayment[2], 100, '>'),//%19

                                                  _NextGeneralExpirationDate[3],        //%20
                                                  Round(_NextGenNonPayment[3], 100, '>'), //%21
                                                  _NextLandArcExpirationDate[3],        //%23
                                                  Round(_NextLandNonPayment[3], 100, '>'), //%24

                                                  Round(_NextGenNonPayment[1], 100, '>') + Round(_NextLandNonPayment[1], 100, '>'), //%25
                                                  Round(_NextGenNonPayment[2], 100, '>') + Round(_NextLandNonPayment[2], 100, '>'), //%26
                                                  Round(_NextGenNonPayment[3], 100, '>') + Round(_NextLandNonPayment[3], 100, '>')  //%27
                                                  ));


                    end else begin
                        exit(pMessage);
                    end;

                end;
            pType::PurchContract:
                begin
                    //%1: €ˆˆ•ÐŽÊŒ¡ ‘ªˆ±,%2: ÐŽÊ ˆˆ‡ßŸÀ,%3: ÐŽÊ €¦Ž¸, %4: „Ì„Ï–, %5: ÐŽÊ ‚‹Ô
                    _PurchaseContract.Reset;
                    _PurchaseContract.SetRange("No.", pCode);
                    if _PurchaseContract.FindSet then begin
                        _PurchaseContractLine.Reset;
                        _PurchaseContractLine.SetRange("Purchase Contract No.", _PurchaseContract."No.");
                        if _PurchaseContractLine.FindLast then begin
                            exit(StrSubstNo(pMessage, _PurchaseContract.Title,                     //%1
                                                     _PurchaseContractLine."Contract Date To",    //%2
                                                     _PurchaseContractLine."Contract Amount",     //%3
                                                     _PurchaseContractLine."Department Name",     //%4
                                                     _PurchaseContractLine.Contents));            //%5
                        end;
                    end;
                end;
            pType::Service:
                begin
                    //%1: •“‹À œˆº,%2: Œ¡Š±Š „ÔŠ¨‡õ,%3: Œ¡Š±Š Œ­Š¨‡õ,%4: “‚ˆ«ŸÀ,%5: “‚ˆ«‚‹Ô
                    _CemeteryServices.Reset;
                    _CemeteryServices.SetRange("No.", pCode);
                    if _CemeteryServices.FindSet then begin
                        exit(StrSubstNo(pMessage, _CemeteryServices."Appl. Name",               //%1
                                                 _CemeteryServices."Field Work Main Cat. Name", //%2
                                                 _CemeteryServices."Field Work Sub Cat. Name",  //%3
                                                 _CemeteryServices."Work Date",                 //%4
                                                 _CemeteryServices."Process Content"));         //%5
                    end;
                end;
            pType::RemAmount:
                begin
                    //%1: ¼†Þ‰Ã„’‹Ï†ð,%2: ‰ª¬‰°˜ú,%3: ÐŽÊ€¦,%4: Â€¦,%5: ‚ŠÂŽ¸,%6:Â€¦¯€¦ŽÊ‘ñŸ
                    _Contract.Reset;
                    _Contract.SetRange("No.", pCode);
                    _Contract.SetRange("Date Filter", 0D, Today);
                    if _Contract.FindSet then begin

                        _Contract.CalcFields("Main Associate Name", "Sub Associate Name");
                        case _Contract."Contact Target" of
                            _Contract."Contact Target"::MainCustomer:
                                _ContactName := _Contract."Main Customer Name";
                            _Contract."Contact Target"::MainAssociate:
                                _ContactName := _Contract."Main Associate Name";
                            _Contract."Contact Target"::SubAssociate:
                                _ContactName := _Contract."Sub Associate Name";
                        end;
                        exit(StrSubstNo(pMessage, _ContactName,                             //%1
                                                  _Contract."Cemetery No.",                 //%2
                                                  _Contract."Contract Amount",              //%3
                                                  _Contract."Remaining Amount",             //%4
                                                  _Contract."Pay. Remaining Amount",        //%5
                                                  _Contract."Remaining Due Date"));         //%6
                    end;
                end;
            pType::Vehicle:
                begin
                    //%1: ’ð‡«‰°˜ú,%2: ’ð‡«œˆº,%3: Œ÷ˆ«ŸÀ,%4: Œ÷ˆ«—ˆ± »—ý,%5: Œ÷•À
                    _VehicleLedEntryHeader.Reset;
                    _VehicleLedEntryHeader.SetRange("No.", pCode);
                    if _VehicleLedEntryHeader.FindSet then begin
                        _Vehicle.Reset;
                        _Vehicle.SetRange("No.", _VehicleLedEntryHeader."Vehicle Document No.");
                        if _Vehicle.FindSet then begin
                            exit(StrSubstNo(pMessage, _Vehicle."Vehicle No.",                   //%1
                                                      _Vehicle.Name,                            //%2
                                                      _VehicleLedEntryHeader."Repair Date",     //%3
                                                      _VehicleLedEntryHeader."Repair Item",     //%4
                                                      _VehicleLedEntryHeader."Recipient Name"));//%5
                        end;
                    end;
                end;
            pType::FieldWork:
                begin
                    //%1: •“‹À œˆº,%2: —÷ÎŽð‰½ „ÔŠ¨‡õ,%3: —÷ÎŽð‰½ Œ­Š¨‡õ,%4: “‚ˆ«‚‹Ô
                    _FieldWorkHeader.Reset;
                    _FieldWorkHeader.SetRange("No.", pCode);
                    if _FieldWorkHeader.FindSet then begin
                        exit(StrSubstNo(pMessage, _FieldWorkHeader."Appl. Name",                  //%1
                                                  _FieldWorkHeader."Field Work Main Cat. Name",   //%2
                                                  _FieldWorkHeader."Field Work Sub Cat. Name",    //%3
                                                  _FieldWorkHeader."Process Content"));           //%4
                    end;
                end;
            pType::CustRequest:
                begin
                    //%1: •“‹À œˆº,%2: ‘óŒ÷ »—ý,%3: ‘óŒ÷ŸÀ,%4: “‚ˆ« ŸÀ,%5: “‚ˆ«‚‹Ô
                    _CustomerRequests.Reset;
                    _CustomerRequests.SetRange("Contract No.", pCode);
                    _CustomerRequests.SetFilter(Status, '%1', _CustomerRequests.Status::Complete);
                    if _CustomerRequests.FindSet then begin
                        exit(StrSubstNo(pMessage, _CustomerRequests."Appl. Name",                 //%1
                                                  _CustomerRequests."Field Work Sub Cat. Name",   //%2
                                                  _CustomerRequests."Receipt Date",               //%3
                                                  _CustomerRequests."Process Date",               //%4
                                                  _CustomerRequests."Process Content"))           //%5
                    end;
                end;
            pType::Receipt:
                begin
                    //¯€¦ “‚ˆ«
                    //%1: ¯€¦À œˆº,%2: ß‘ª€¦Ž¸,%3: ‰ª¬‰°˜ú,%4: ß‘ª—¸ˆ±,%5: “‚ˆ«‚‹Ô
                    Clear(_PaymentItem);
                    Clear(_PaymentContents);
                    _PaymentReceiptDocument.Reset;
                    _PaymentReceiptDocument.SetRange("Document No.", pCode);
                    if _PaymentReceiptDocument.FindSet then begin

                        _Contract.Get(_PaymentReceiptDocument."Contract No.");

                        _PaymentReceiptDocLine.Reset;
                        _PaymentReceiptDocLine.SetRange("Document No.", _PaymentReceiptDocument."Document No.");
                        if _PaymentReceiptDocLine.FindSet then begin
                            repeat
                                // DK TOMMY MOD ST
                                _PaymentReceiptDocLine.CalcFields("Field Work Main Cat. Name", "Field Work Sub Cat. Name");


                                if _PaymentReceiptDocLine."Payment Target" = _PaymentReceiptDocLine."Payment Target"::Service then
                                    if _PaymentItem = '' then
                                        _PaymentItem := Format(_PaymentReceiptDocLine."Field Work Main Cat. Name")
                                    else
                                        _PaymentItem := _PaymentItem + ',' + Format(_PaymentReceiptDocLine."Field Work Main Cat. Name")
                                else
                                    if _PaymentItem = '' then
                                        _PaymentItem := Format(_PaymentReceiptDocLine."Payment Target")
                                    else
                                        _PaymentItem := _PaymentItem + ',' + Format(_PaymentReceiptDocLine."Payment Target");
                                // DK TOMMY MOD END
                                //       IF _PaymentItem = '' THEN
                                //        _PaymentItem := FORMAT(_PaymentReceiptDocLine."Payment Target")
                                //      ELSE
                                //        _PaymentItem := _PaymentItem + ','+FORMAT(_PaymentReceiptDocLine."Payment Target");



                                case _PaymentReceiptDocLine."Payment Target" of
                                    _PaymentReceiptDocLine."Payment Target"::Deposit,
                                    _PaymentReceiptDocLine."Payment Target"::Contract,
                                    _PaymentReceiptDocLine."Payment Target"::Service:
                                        begin
                                            _PaymentContents := _PaymentContents +
                                                                // DK TOMMY MOD ST
                                                                //      STRSUBSTNO('%1 : %2',FORMAT(_PaymentReceiptDocLine."Payment Target"),MSG012) +
                                                                StrSubstNo('%1 : %2', Format(_PaymentReceiptDocLine."Field Work Sub Cat. Name"), MSG012) +  // NEW
                                                                Format(_CR, 0, '<CHAR>');

                                            // DK TOMMY MOD END
                                        end;
                                    _PaymentReceiptDocLine."Payment Target"::Remaining:
                                        begin
                                            if _Contract."Pay. Remaining Amount" = 0 then
                                                _PaymentContents := _PaymentContents +
                                                                    StrSubstNo('%1 : %2', Format(_PaymentReceiptDocLine."Payment Target"), MSG012) +
                                                                    Format(_CR, 0, '<CHAR>')
                                            else
                                                _PaymentContents := _PaymentContents +
                                                                    StrSubstNo(MSG013, Format(_PaymentReceiptDocLine."Payment Target"), Format(_Contract."Pay. Remaining Amount")) +
                                                                    Format(_CR, 0, '<CHAR>');
                                        end;
                                    _PaymentReceiptDocLine."Payment Target"::General,
                                    _PaymentReceiptDocLine."Payment Target"::Landscape:
                                        begin
                                            _PaymentContents := _PaymentContents + StrSubstNo('%1 : %2 ~ %3', Format(_PaymentReceiptDocLine."Payment Target"),
                                                                                                              Format(_PaymentReceiptDocLine."Start Date"),
                                                                                                              Format(_PaymentReceiptDocLine."Expiration Date")) + Format(_CR, 0, '<CHAR>');
                                        end;
                                end;
                            until _PaymentReceiptDocLine.Next = 0;

                            exit(StrSubstNo(pMessage, _PaymentReceiptDocument.Depositor,           //%1
                                                      _PaymentReceiptDocument.Amount,             //%2
                                                      _PaymentReceiptDocument."Cemetery No.",     //%3
                                                      _PaymentItem,                               //%4
                                                      _PaymentContents));                          //%5
                        end;
                    end;
                end;
            pType::PaymentExpectPG:
                begin //ß‘ª ‰‹Ý PG SMS ‰«€ˆ
                      //%1: •“‹À œˆº,%2: ‰ª¬‰°˜ú,%3: ß‘ª‰‘ñ€¦Ž¸,%4: »˜€Ëú,%5: ˆ…•‘´Œ­
                      //%6: Ÿ‰¦ ýˆ«Š± “ÁŸ,%7: Ÿ‰¦ ýˆ«Š± ‘Ž‡ßŸ,%8: ‘†µ ýˆ«Š± “ÁŸ,%9: ‘†µ ýˆ«Š± ‘Ž‡ßŸ
                    _FunSetup.Get;
                    _FunSetup.TestField("PG URL");

                    _PayExpectDocHeader.Reset;
                    _PayExpectDocHeader.SetRange("Document No.", pCode);
                    if _PayExpectDocHeader.FindSet then begin
                        _PayExpectDocHeader.CalcFields("Total Amount");
                        _PayExpectDocLine.Reset;
                        _PayExpectDocLine.SetRange("Document No.", _PayExpectDocHeader."Document No.");
                        _PayExpectDocLine.SetFilter("Payment Target", '%1|%2', _PayExpectDocLine."Payment Target"::General, _PayExpectDocLine."Payment Target"::Landscape);
                        if _PayExpectDocLine.FindSet then begin
                            repeat
                                if _PayExpectDocLine."Payment Target" = _PayExpectDocLine."Payment Target"::General then begin
                                    _PayExpGenStartDate := Format(_PayExpectDocLine."Start Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                    _PayExpGenEndDate := Format(_PayExpectDocLine."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                end else begin
                                    _PayExpLandStartDate := Format(_PayExpectDocLine."Start Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                    _PayExpLandEndDate := Format(_PayExpectDocLine."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                end;
                            until _PayExpectDocLine.Next = 0;
                        end;
                        exit(StrSubstNo(pMessage, _PayExpectDocHeader."Appl. Name",            //%1
                                                  _PayExpectDocHeader."Cemetery No.",         //%2
                                                  _PayExpectDocHeader."Total Amount",         //%3
                                                  _PayExpectDocHeader."Expiration Date",      //%4
                                                  StrSubstNo(_FunSetup."PG URL", _PayExpectDocHeader."Document No."),//%5
                                                  _PayExpGenStartDate,                        //%6
                                                  _PayExpGenEndDate,                          //%7
                                                  _PayExpLandStartDate,                       //%8
                                                  _PayExpLandEndDate));                       //%9
                    end;
                end;
            pType::PaymentExpectVA:
                begin //ß‘ª ‰‹Ý PG SMS ‰«€ˆ
                      //%1: •“‹À œˆº,%2: ‰ª¬‰°˜ú,%3: í‹ÝÐ‘’‰°˜ú,%4: Š—Êœˆº,%5: ‰€¦‘´,%6: ß‘ª‰‘ñ€¦Ž¸,%7: »˜€Ëú
                      //%8: Ÿ‰¦ ýˆ«Š± “ÁŸ,%9: Ÿ‰¦ ýˆ«Š± ‘Ž‡ßŸ,%10: ‘†µ ýˆ«Š± “ÁŸ,%11: ‘†µ ýˆ«Š± ‘Ž‡ßŸ
                    _PayExpectDocHeader.Reset;
                    _PayExpectDocHeader.SetRange("Document No.", pCode);
                    if _PayExpectDocHeader.FindSet then begin
                        _PayExpectDocHeader.CalcFields("Total Amount", "Bank Name", "Account Holder");
                        _PayExpectDocLine.Reset;
                        _PayExpectDocLine.SetRange("Document No.", _PayExpectDocHeader."Document No.");
                        _PayExpectDocLine.SetFilter("Payment Target", '%1|%2', _PayExpectDocLine."Payment Target"::General, _PayExpectDocLine."Payment Target"::Landscape);
                        if _PayExpectDocLine.FindSet then begin
                            repeat
                                if _PayExpectDocLine."Payment Target" = _PayExpectDocLine."Payment Target"::General then begin
                                    _PayExpGenStartDate := Format(_PayExpectDocLine."Start Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                    _PayExpGenEndDate := Format(_PayExpectDocLine."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                end else begin
                                    _PayExpLandStartDate := Format(_PayExpectDocLine."Start Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                    _PayExpLandEndDate := Format(_PayExpectDocLine."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                end;
                            until _PayExpectDocLine.Next = 0;
                        end;
                        exit(StrSubstNo(pMessage, _PayExpectDocHeader."Appl. Name",           //%1
                                                  _PayExpectDocHeader."Cemetery No.",        //%2
                                                  _PayExpectDocHeader."Virtual Account No.", //%3
                                                  _PayExpectDocHeader."Bank Name",           //%4
                                                  _PayExpectDocHeader."Account Holder",      //%5
                                                  _PayExpectDocHeader."Total Amount",        //%6
                                                  _PayExpectDocHeader."Expiration Date",     //%7
                                                  _PayExpGenStartDate,                       //%8
                                                  _PayExpGenEndDate,                         //%9
                                                  _PayExpLandStartDate,                      //%10
                                                  _PayExpLandEndDate));                      //%11

                    end;
                end;
            pType::ReagreeInfo:
                begin  // ‚ž‘ñŠˆ˜Ô…— ‰«€ˆ
                       //%1: ×„ œˆº, %2: »—ý, %3: „“ ‚»’Ñ, %4: ‚ž‘ñŠˆ ˜Ô …— ŸÀ, %5: ˜Ã„Ô–õ ‰°˜ú
                    _ReagreeToProvideInfo.Reset;
                    _ReagreeToProvideInfo.SetRange("No.", pCode);
                    if _ReagreeToProvideInfo.FindSet then begin
                        exit(StrSubstNo(pMessage, _ReagreeToProvideInfo.Name,                                                                //%1
                                                 Format(_ReagreeToProvideInfo.Type),                                                        //%2
                                                 Format(Today, 0, '<Year4>-<Month,2>-<Day,2>'),                                               //%3
                                                 Format(_ReagreeToProvideInfo."Personal Data Concu. Date", 0, '<Year4>-<Month,2>-<Day,2>'),   //%4
                                                 _ReagreeToProvideInfo."Mobile No."));
                    end;
                end;

        end;
    end;

    local procedure GetReceiptBankInfor(pReceiptBankCode: Code[20]): Text[100]
    var
        _ReceiptBankAccnt: Record "DK_Receipt Bank Account";
    begin

        if _ReceiptBankAccnt.Get(pReceiptBankCode) then begin

            //€ËŽðŠ—Ê 239-028691-04-015 ‰€¦‘´:Ï„Â‰²ž Ôž°°
            exit(StrSubstNo(MSG015, _ReceiptBankAccnt."Bank Name",
                                   _ReceiptBankAccnt."Bank Account No.",
                                   _ReceiptBankAccnt.FieldCaption("Account Holder"),
                                   _ReceiptBankAccnt."Account Holder"
                                   ));
        end;

        exit('');
    end;
}

