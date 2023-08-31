codeunit 50022 "DK_Report Mgt."
{
    // 
    // DK34: 20201207
    //   - Modify Function: Page50167_ToExcel, Page50167_SetMatrixInit


    trigger OnRun()
    begin
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ServerFileName: Text;
        SheetName: Text[250];
        TextDegree: Label ' Degree';
        LastColNo: Integer;
        TextRefu: Label '%1Year Count';
        TextRefuAmt: Label '%1Year Amount';
        FielName: Label '%1_Collection performance';
        Window: Dialog;
        MSG001: Label 'Date #1##########';


    procedure Page50167_ToExcel(pStartDate: Date; pEndDate: Date; pEmployeeCode: Code[20])
    var
        _Text001: Label 'Export to EXCEL File';
        _Text002: Label 'XLSX Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*';
        _DK_SelectedContract: Record "DK_Selected Contract";
        _TmpDK_CounselHistory: Record "DK_Counsel History" temporary;
        _MatrixColumnDegree: array[100] of Integer;
        _MatrixData: array[100] of Text[1024];
        _FileMgt: Codeunit "File Management";
        _RowNo: Integer;
        _ColNo: Integer;
        _TextCol01: Label 'Contract No.';
        _TextCol02: Label 'Cemetery Code';
        _TextCol03: Label 'Cemetery No.';
        _TextCol04: Label 'Main Customer Name';
        _TextCol05: Label 'Cemetery Size';
        _TextCol06: Label 'Litigation Employee Name';
        _FirstRowNo: Integer;
    begin
        Clear(ServerFileName);
        Clear(SheetName);
        _FirstRowNo := 1;

        // ServerFileName := _FileMgt.ServerTempFileName('xlsx');////zzz
        SheetName := _TmpDK_CounselHistory.TableName;
        //History data
        Page50167_SetMatrixInit(_TmpDK_CounselHistory, pStartDate, pEndDate, pEmployeeCode);

        _TmpDK_CounselHistory.SetCurrentKey("Line No.");
        _TmpDK_CounselHistory.FindLast;
        //Last History data
        LastColNo := _TmpDK_CounselHistory."Line No.";

        _MatrixColumnDegree[1] := 1;
        _MatrixColumnDegree[10] := LastColNo;

        EnterCell(_FirstRowNo, 1, _TextCol01, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 2, _TextCol02, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 3, _TextCol03, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 4, _TextCol04, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 5, _TextCol05, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 6, _TextCol06, false, false, true, '', TempExcelBuffer."Cell Type"::Text);

        for _ColNo := 1 to LastColNo do begin
            EnterCell(1, _ColNo + 6, Format(_ColNo) + TextDegree, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        end;

        _RowNo := 1;

        with _DK_SelectedContract do begin
            Reset;
            SetRange("USER ID", UserId);
            if FindSet then begin
                repeat
                    CalcFields("Main Customer Name", "Cemetery Size", "Litigation Employee Name");
                    _RowNo += 1;
                    //array data
                    Clear(_MatrixData);
                    Page50167_SetMatrixRecord("Contract No.", _MatrixColumnDegree, _TmpDK_CounselHistory, _MatrixData);
                    //array data
                    EnterCell(_RowNo, 1, "Contract No.", false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(_RowNo, 2, "Cemetery Code", false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(_RowNo, 3, "Cemetery No.", false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(_RowNo, 4, "Main Customer Name", false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(_RowNo, 5, Format("Cemetery Size"), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(_RowNo, 6, "Litigation Employee Name", false, false, true, '', TempExcelBuffer."Cell Type"::Text);

                    for _ColNo := 1 to LastColNo do begin
                        EnterCell(_RowNo, _ColNo + 6, _MatrixData[_ColNo], false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    end;

                until Next = 0;
            end;
        end;

        CreateExcelAndClosed;
    end;


    procedure Page50167_SetMatrixInit(var pTmpDK_CounselHistory: Record "DK_Counsel History" temporary; pStartDate: Date; pEndDate: Date; pEmployeeCode: Code[20])
    var
        _DK_SelectedContract: Record "DK_Selected Contract";
        _DK_CounselHistory: Record "DK_Counsel History";
        _iLineNo: Integer;
    begin
        pTmpDK_CounselHistory.Reset;
        pTmpDK_CounselHistory.DeleteAll;

        with _DK_SelectedContract do begin
            Reset;
            SetRange("USER ID", UserId);
            if FindSet then begin
                repeat
                    _iLineNo := 0;
                    _DK_CounselHistory.Reset;
                    _DK_CounselHistory.SetRange("Contract No.", "Contract No.");
                    _DK_CounselHistory.SetRange(Type, _DK_CounselHistory.Type::Litigation);
                    _DK_CounselHistory.SetRange(Date, pStartDate, pEndDate);
                    _DK_CounselHistory.SetRange("Delete Row", false);
                    _DK_CounselHistory.SetRange("Request Del", false);
                    //>> DK34
                    if pEmployeeCode <> '' then
                        _DK_CounselHistory.SetFilter("Employee No.", pEmployeeCode);
                    //<<
                    if _DK_CounselHistory.FindSet then begin
                        repeat
                            _iLineNo += 1;
                            pTmpDK_CounselHistory.Init;
                            pTmpDK_CounselHistory.TransferFields(_DK_CounselHistory);
                            pTmpDK_CounselHistory."Line No." := _iLineNo;
                            pTmpDK_CounselHistory.Insert;
                        until _DK_CounselHistory.Next = 0;
                    end;
                until Next = 0;
            end;
        end;
    end;


    procedure Page50167_SetMatrixRecord(pContractNo: Code[20]; pMatrixColumnDegree: array[100] of Integer; var pTmpDK_CounselHistory: Record "DK_Counsel History" temporary; var pMatrixData: array[100] of Text[1024])
    var
        _i: Integer;
    begin
        _i := 0;
        with pTmpDK_CounselHistory do begin
            SetRange("Contract No.", pContractNo);
            SetRange("Line No.", pMatrixColumnDegree[1], pMatrixColumnDegree[10]);
            if FindSet then
                repeat
                    _i += 1;
                    pMatrixData[_i] := '[ ' + Format(Date) + ' ] [' + Format("Litigation Type") + ' ] [' + "Employee Name" + ' ]';
                until Next = 0;
        end;
    end;


    procedure Page50167_SetMatrixCaptioin(pParam: Integer; var pMatrixColumnCaptions: array[100] of Text[1024]; var pMatrixColumnDegree: array[100] of Integer)
    begin
        pMatrixColumnDegree[1] := 1 + pParam;
        pMatrixColumnDegree[2] := 2 + pParam;
        pMatrixColumnDegree[3] := 3 + pParam;
        pMatrixColumnDegree[4] := 4 + pParam;
        pMatrixColumnDegree[5] := 5 + pParam;
        pMatrixColumnDegree[6] := 6 + pParam;
        pMatrixColumnDegree[7] := 7 + pParam;
        pMatrixColumnDegree[8] := 8 + pParam;
        pMatrixColumnDegree[9] := 9 + pParam;
        pMatrixColumnDegree[10] := 10 + pParam;

        pMatrixColumnCaptions[1] := Format(pMatrixColumnDegree[1]) + TextDegree;
        pMatrixColumnCaptions[2] := Format(pMatrixColumnDegree[2]) + TextDegree;
        pMatrixColumnCaptions[3] := Format(pMatrixColumnDegree[3]) + TextDegree;
        pMatrixColumnCaptions[4] := Format(pMatrixColumnDegree[4]) + TextDegree;
        pMatrixColumnCaptions[5] := Format(pMatrixColumnDegree[5]) + TextDegree;
        pMatrixColumnCaptions[6] := Format(pMatrixColumnDegree[6]) + TextDegree;
        pMatrixColumnCaptions[7] := Format(pMatrixColumnDegree[7]) + TextDegree;
        pMatrixColumnCaptions[8] := Format(pMatrixColumnDegree[8]) + TextDegree;
        pMatrixColumnCaptions[9] := Format(pMatrixColumnDegree[9]) + TextDegree;
        pMatrixColumnCaptions[10] := Format(pMatrixColumnDegree[10]) + TextDegree;
    end;


    procedure Page50205_SetRecord(pStartDate: Date; pEndDate: Date; pPaymentType: Option "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount; ColumnRecord: array[20] of Record "DK_Field Work Main Category"; var pDK_ReportBuffer: Record "DK_Report Buffer" temporary)
    var
        _DK_Contract: Record DK_Contract;
        _DK_PayRcpttDoc: Record "DK_Payment Receipt Document";
        _Date: Record Date;
        _EntryNo: Integer;
        _ConAmtLedger: Record "DK_Contract Amount Ledger";
    begin
        with pDK_ReportBuffer do begin
            Reset;
            DeleteAll;

            if GuiAllowed then
                Window.Open(MSG001);

            _Date.SetRange("Period Type", _Date."Period Type"::Date);
            _Date.SetRange("Period Start", pStartDate, pEndDate);
            if _Date.FindSet then
                repeat

                    if GuiAllowed then
                        Window.Update(1, _Date."Period Start");

                    _EntryNo += 1;
                    Init;
                    "USER ID" := UserId;
                    "OBJECT ID" := 50205;
                    "Entry No." := _EntryNo;
                    DATE0 := _Date."Period Start";
                    //‰ŽÊ€¦
                    DECIMAL1 := Page50205_ContAmtLedgertAmt('', _ConAmtLedger.Type::Deposit, pPaymentType, _Date."Period Start");
                    //ÐŽÊ€¦
                    DECIMAL26 := Page50205_ContAmtLedgertAmt('', _ConAmtLedger.Type::Contract, pPaymentType, _Date."Period Start");
                    //Â€¦
                    DECIMAL27 := Page50205_ContAmtLedgertAmt('', _ConAmtLedger.Type::Remaining, pPaymentType, _Date."Period Start");
                    //˜»€ÃŽ¸(-)
                    DECIMAL28 := -Page50205_ContAmtLedgertAmt('', _ConAmtLedger.Type::Refund, pPaymentType, _Date."Period Start");
                    //Ÿ‰¦ýˆ«Š± - “‰ ÐŽÊ €Ëú
                    DECIMAL2 := Page50205_AdminExpLedger(0, pPaymentType, true, _Date."Period Start");
                    //‘†µýˆ«Š± - “‰ ÐŽÊ €Ëú
                    DECIMAL3 := Page50205_AdminExpLedger(1, pPaymentType, true, _Date."Period Start");
                    //Ÿ‰¦2’ðýˆ«Š±
                    DECIMAL4 := Page50205_AdminExpLedger(0, pPaymentType, false, _Date."Period Start");
                    //‘†µ2’ðýˆ«Š±
                    DECIMAL5 := Page50205_AdminExpLedger(1, pPaymentType, false, _Date."Period Start");
                    //‰ª‘÷Œ¡Š±Š
                    DECIMAL6 := Page50205_ContAmtLedgertAmt(ColumnRecord[1].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL7 := Page50205_ContAmtLedgertAmt(ColumnRecord[2].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL8 := Page50205_ContAmtLedgertAmt(ColumnRecord[3].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL9 := Page50205_ContAmtLedgertAmt(ColumnRecord[4].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL10 := Page50205_ContAmtLedgertAmt(ColumnRecord[5].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL11 := Page50205_ContAmtLedgertAmt(ColumnRecord[6].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL12 := Page50205_ContAmtLedgertAmt(ColumnRecord[7].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL13 := Page50205_ContAmtLedgertAmt(ColumnRecord[8].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL14 := Page50205_ContAmtLedgertAmt(ColumnRecord[9].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL15 := Page50205_ContAmtLedgertAmt(ColumnRecord[10].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL16 := Page50205_ContAmtLedgertAmt(ColumnRecord[11].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL17 := Page50205_ContAmtLedgertAmt(ColumnRecord[12].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL18 := Page50205_ContAmtLedgertAmt(ColumnRecord[13].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL19 := Page50205_ContAmtLedgertAmt(ColumnRecord[14].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL20 := Page50205_ContAmtLedgertAmt(ColumnRecord[15].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL21 := Page50205_ContAmtLedgertAmt(ColumnRecord[16].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL22 := Page50205_ContAmtLedgertAmt(ColumnRecord[17].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL23 := Page50205_ContAmtLedgertAmt(ColumnRecord[18].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL24 := Page50205_ContAmtLedgertAmt(ColumnRecord[19].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL25 := Page50205_ContAmtLedgertAmt(ColumnRecord[20].Code, _ConAmtLedger.Type::Service, pPaymentType, _Date."Period Start");
                    DECIMAL0 := DECIMAL1 + DECIMAL2 + DECIMAL3 + DECIMAL4 + DECIMAL5 +
                                DECIMAL6 + DECIMAL7 + DECIMAL8 + DECIMAL9 + DECIMAL10 +
                                DECIMAL11 + DECIMAL12 + DECIMAL13 + DECIMAL14 + DECIMAL15 +
                                DECIMAL16 + DECIMAL17 + DECIMAL18 + DECIMAL19 + DECIMAL20 +
                                DECIMAL21 + DECIMAL22 + DECIMAL23 + DECIMAL24 + DECIMAL25 +
                                DECIMAL26 + DECIMAL27 + DECIMAL28;
                    Insert;
                    ;
                until _Date.Next = 0;
        end;


        if GuiAllowed then
            Window.Close;
    end;

    local procedure Page50205_ContAmtLedgertAmt(pCode: Code[20]; pType: Option; pPaymentType: Option "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount; pDate: Date): Decimal
    var
        _DK_ContractAmountLedger: Record "DK_Contract Amount Ledger";
    begin
        //ÐŽÊ€¦°Î


        with _DK_ContractAmountLedger do begin
            if (pCode = '') and (pType = _DK_ContractAmountLedger.Type::Service) then
                exit(0);

            Reset;
            //SETCURRENTKEY(Date,"Ledger Type",Type,"Field Work Main Cat. Code","Payment Type");
            SetRange(Date, pDate);
            SetRange("Ledger Type", "Ledger Type"::Receipt);
            SetRange(Type, pType);
            SetRange(Cancel, false);
            if pCode <> '' then
                SetRange("Field Work Main Cat. Code", pCode);
            if pPaymentType <> 0 then
                SetRange("Payment Type", pPaymentType);
            if FindSet then begin
                CalcSums(Amount);
                exit(Amount);
            end;
        end;
    end;

    local procedure Page50205_AdminExpLedger(pAdminExpType: Integer; pPaymentType: Option "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount; pFirst: Boolean; pDate: Date): Decimal
    var
        _DK_AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin
        //ýˆ«°Î
        //pType := 0 Ÿ‰¦ýˆ«Š±
        //pType := 1 ‘†µýˆ«Š±
        with _DK_AdminExpenseLedger do begin
            Reset;
            SetCurrentKey(Date, "Admin. Expense Type", "Ledger Type", "First Contract", "Payment Type");
            SetRange(Date, pDate);
            SetRange("Admin. Expense Type", pAdminExpType);
            SetRange("Ledger Type", "Ledger Type"::Receipt);
            SetRange("First Contract", pFirst);
            SetRange(Cancel, false);
            if pPaymentType <> 0 then
                SetRange("Payment Type", pPaymentType);
            if FindSet then begin
                CalcSums(Amount);
                exit(Amount);
            end;
        end;
    end;


    procedure Page50207_SetRecord(pDatePeriod: array[10] of Date; var pDK_ReportBuffer: Record "DK_Report Buffer" temporary)
    var
        _DK_Contract: Record DK_Contract;
        _DK_RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _EntryNo: Integer;
        _CapGeneral: Label 'General';
        _CapLandscape: Label 'Landscape';
    begin
        with pDK_ReportBuffer do begin
            Reset;
            DeleteAll;

            _DK_Contract.Reset;
            _DK_Contract.SetRange("General Expiration Date", pDatePeriod[9], pDatePeriod[10]);
            if _DK_Contract.FindSet then
                repeat
                    _DK_Contract.CalcFields("Cemetery Size", "Cust. Mobile No.", "Cust. Phone No.");

                    _EntryNo += 1;
                    Init;
                    "USER ID" := UserId;
                    "OBJECT ID" := 50207;
                    "Entry No." := _EntryNo;
                    CODE0 := _DK_Contract."No.";
                    DATE0 := _DK_Contract."General Expiration Date" + 1;
                    TEXT0 := _DK_Contract."Main Customer Name";
                    TEXT1 := _DK_Contract."Cust. Mobile No." + ' , ' + _DK_Contract."Cust. Phone No.";
                    TEXT2 := _DK_RevocationContractMgt.CalcContractPreiod(DATE0, Today);
                    DECIMAL0 := _DK_Contract."Cemetery Size";
                    TEXT3 := _CapGeneral;
                    DECIMAL2 := Page50207_AdminExpLedger(pDatePeriod[1], pDatePeriod[2], 0, CODE0);
                    DECIMAL3 := Page50207_AdminExpLedger(pDatePeriod[3], pDatePeriod[4], 0, CODE0);
                    DECIMAL4 := Page50207_AdminExpLedger(pDatePeriod[5], pDatePeriod[6], 0, CODE0);
                    DECIMAL5 := Page50207_AdminExpLedger(pDatePeriod[7], pDatePeriod[8], 0, CODE0);
                    DECIMAL6 := Page50207_AdminExpLedger(pDatePeriod[9], pDatePeriod[10], 0, CODE0);
                    DECIMAL1 := DECIMAL2 + DECIMAL3 + DECIMAL4 + DECIMAL5 + DECIMAL6;
                    Insert;
                    ;
                until _DK_Contract.Next = 0;

            _DK_Contract.SetRange("General Expiration Date");
            _DK_Contract.SetRange("Land. Arc. Expiration Date", pDatePeriod[9], pDatePeriod[10]);
            if _DK_Contract.FindSet then
                repeat
                    _DK_Contract.CalcFields("Cemetery Size", "Cust. Mobile No.", "Cust. Phone No.");

                    _EntryNo += 1;
                    Init;
                    "USER ID" := UserId;
                    "OBJECT ID" := 50207;
                    "Entry No." := _EntryNo;
                    CODE0 := _DK_Contract."No.";
                    DATE0 := _DK_Contract."General Expiration Date" + 1;
                    TEXT0 := _DK_Contract."Main Customer Name";
                    TEXT1 := _DK_Contract."Cust. Mobile No." + ' , ' + _DK_Contract."Cust. Phone No.";
                    TEXT2 := _DK_RevocationContractMgt.CalcContractPreiod(DATE0, Today);
                    DECIMAL0 := _DK_Contract."Cemetery Size";
                    TEXT3 := _CapLandscape;
                    DECIMAL2 := Page50207_AdminExpLedger(pDatePeriod[1], pDatePeriod[2], 1, CODE0);
                    DECIMAL3 := Page50207_AdminExpLedger(pDatePeriod[3], pDatePeriod[4], 1, CODE0);
                    DECIMAL4 := Page50207_AdminExpLedger(pDatePeriod[5], pDatePeriod[6], 1, CODE0);
                    DECIMAL5 := Page50207_AdminExpLedger(pDatePeriod[7], pDatePeriod[8], 1, CODE0);
                    DECIMAL6 := Page50207_AdminExpLedger(pDatePeriod[9], pDatePeriod[10], 1, CODE0);
                    DECIMAL1 := DECIMAL2 + DECIMAL3 + DECIMAL4 + DECIMAL5 + DECIMAL6;
                    Insert;
                    ;
                until _DK_Contract.Next = 0;

            if _EntryNo > 0 then begin
                SetCurrentKey(CODE0, TEXT3);
                FindSet;
            end;

        end;
    end;


    procedure Page50207_AdminExpLedger(pStartDate: Date; pEndDate: Date; pAdminExpType: Integer; pContractNo: Code[20]): Decimal
    var
        _DK_Contract: Record DK_Contract;
    begin
        with _DK_Contract do begin
            Reset;
            SetRange("No.", pContractNo);
            SetRange("Date Filter", pStartDate, pEndDate);
            if FindSet then begin
                CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");
                //Ÿ‰¦ ýˆ«Š±
                if pAdminExpType = 0 then
                    exit("Non-Pay. General Amount")
                //‘†µýˆ«Š±
                else
                    exit("Non-Pay. Land. Arc. Amount");
            end;
        end;
    end;


    procedure Page50208_SetRecord(pStartDate: Date; pEndDate: Date; var pTotalAmount: Decimal; var pDK_ReportBuffer: Record "DK_Report Buffer" temporary)
    var
        _DK_PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _EntryNo: Integer;
    begin
        with pDK_ReportBuffer do begin
            Clear(pTotalAmount);
            Reset;
            DeleteAll;

            _DK_PaymentReceiptDocument.Reset;
            _DK_PaymentReceiptDocument.SetRange(Posted, true);
            _DK_PaymentReceiptDocument.SetRange("Document Type", _DK_PaymentReceiptDocument."Document Type"::Receipt);
            _DK_PaymentReceiptDocument.SetRange("Missing Contract", true);
            _DK_PaymentReceiptDocument.SetRange("Payment Date", pStartDate, pEndDate);
            _DK_PaymentReceiptDocument.SetRange(Refund, false);
            if _DK_PaymentReceiptDocument.FindSet then
                repeat
                    _EntryNo += 1;
                    Init;
                    "USER ID" := UserId;
                    "OBJECT ID" := 50208;
                    "Entry No." := _EntryNo;
                    DATE0 := _DK_PaymentReceiptDocument."Payment Date";
                    CODE0 := _DK_PaymentReceiptDocument."Bank Account Code";
                    TEXT0 := _DK_PaymentReceiptDocument."Bank Account Name";
                    TEXT1 := _DK_PaymentReceiptDocument.Description;
                    DECIMAL0 := _DK_PaymentReceiptDocument.Amount;
                    Insert;
                    ;
                    pTotalAmount += DECIMAL0;
                until _DK_PaymentReceiptDocument.Next = 0;

            if _EntryNo > 0 then begin
                FindFirst;
            end;

        end;
    end;


    procedure Page50216_SetMatrixCaption(var pMatColCnt: array[12] of Text[1024]; var pMatColAmt: array[12] of Text[1024])
    begin

        pMatColCnt[1] := StrSubstNo(TextRefu, 1);
        pMatColCnt[2] := StrSubstNo(TextRefu, 2);
        pMatColCnt[3] := StrSubstNo(TextRefu, 3);
        pMatColCnt[4] := StrSubstNo(TextRefu, 4);
        pMatColCnt[5] := StrSubstNo(TextRefu, 5);
        pMatColCnt[6] := StrSubstNo(TextRefu, 6);
        pMatColCnt[7] := StrSubstNo(TextRefu, 7);
        pMatColCnt[8] := StrSubstNo(TextRefu, 8);
        pMatColCnt[9] := StrSubstNo(TextRefu, 9);
        pMatColCnt[10] := StrSubstNo(TextRefu, 10);
        pMatColCnt[11] := StrSubstNo(TextRefu, 11);
        pMatColCnt[12] := StrSubstNo(TextRefu, 12);

        pMatColAmt[1] := StrSubstNo(TextRefuAmt, 1);
        pMatColAmt[2] := StrSubstNo(TextRefuAmt, 2);
        pMatColAmt[3] := StrSubstNo(TextRefuAmt, 3);
        pMatColAmt[4] := StrSubstNo(TextRefuAmt, 4);
        pMatColAmt[5] := StrSubstNo(TextRefuAmt, 5);
        pMatColAmt[6] := StrSubstNo(TextRefuAmt, 6);
        pMatColAmt[7] := StrSubstNo(TextRefuAmt, 7);
        pMatColAmt[8] := StrSubstNo(TextRefuAmt, 8);
        pMatColAmt[9] := StrSubstNo(TextRefuAmt, 9);
        pMatColAmt[10] := StrSubstNo(TextRefuAmt, 10);
        pMatColAmt[11] := StrSubstNo(TextRefuAmt, 11);
        pMatColAmt[12] := StrSubstNo(TextRefuAmt, 12);
    end;


    procedure Page50216_SetMatrixRecord(var pReportBuffer: Record "DK_Report Buffer"; pParmYear: Integer; pParamStartMonth: Integer; pParamEndMonth: Integer)
    var
        _StartDate: Date;
        _EndDate: Date;
        _Vehicle: Record DK_Vehicle;
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
        _EnteryNo: Integer;
        _MonthCount: Integer;
    begin
        _EnteryNo := 1;
        _Vehicle.Reset;
        _Vehicle.SetRange(Status, _Vehicle.Status::Confirmation);
        if _Vehicle.FindSet then begin
            repeat
                _MonthCount := pParamStartMonth;

                pReportBuffer.Init;
                pReportBuffer."USER ID" := UserId;
                pReportBuffer."OBJECT ID" := PAGE::"DK_Monthly Refueling Statistic";
                pReportBuffer."Entry No." := _EnteryNo;
                pReportBuffer."SHORT TEXT0" := _Vehicle."Vehicle No.";
                pReportBuffer."SHORT TEXT1" := _Vehicle.Model;
                _StartDate := DMY2Date(1, pParamStartMonth, pParmYear);
                _EndDate := CalcDate('<+CM>', DMY2Date(1, pParamEndMonth, pParmYear));

                pReportBuffer.TEXT0 := Page50216_SetOperatingDistance(_StartDate, _EndDate, _Vehicle."No.");
                pReportBuffer.TEXT1 := Page50216_SetAverageFuel(_StartDate, _EndDate, _Vehicle."No.");
                pReportBuffer.DECIMAL13 := Page50216_SetKmCumulative(_EndDate, _Vehicle."No.");

                if (_MonthCount = 1) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 1, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER0 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL0 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 2) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 2, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER1 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL1 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 3) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 3, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER2 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL2 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 4) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 4, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER3 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL3 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.INTEGER12 += pReportBuffer.INTEGER3;
                    pReportBuffer.DECIMAL12 += pReportBuffer.DECIMAL3;
                    _MonthCount += 1;
                end;

                if (_MonthCount = 5) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 5, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER4 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL4 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 6) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 6, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER5 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL5 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 7) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 7, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER6 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL6 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 8) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 8, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER7 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL7 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 9) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 9, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER8 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL8 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 10) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 10, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER9 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL9 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 11) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 11, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER10 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL10 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                    _MonthCount += 1;
                end;

                if (_MonthCount = 12) and (_MonthCount <= pParamEndMonth) then begin
                    _StartDate := DMY2Date(1, 12, pParmYear);
                    _EndDate := CalcDate('<+CM>', _StartDate);
                    pReportBuffer.INTEGER11 := Page50216_ReportBufferCount(_StartDate, _EndDate, _Vehicle."No.");
                    pReportBuffer.DECIMAL11 := Page50216_ReportBufferAmount(_StartDate, _EndDate, _Vehicle."No.");
                end;
                pReportBuffer.INTEGER12 := pReportBuffer.INTEGER0 + pReportBuffer.INTEGER1 + pReportBuffer.INTEGER2 + pReportBuffer.INTEGER3 + pReportBuffer.INTEGER4
                                      + pReportBuffer.INTEGER5 + pReportBuffer.INTEGER6 + pReportBuffer.INTEGER7 + pReportBuffer.INTEGER8 + pReportBuffer.INTEGER9
                                      + pReportBuffer.INTEGER10 + pReportBuffer.INTEGER11 + pReportBuffer.INTEGER12;
                pReportBuffer.DECIMAL12 += pReportBuffer.DECIMAL0 + pReportBuffer.DECIMAL1 + pReportBuffer.DECIMAL2 + pReportBuffer.DECIMAL3 + pReportBuffer.DECIMAL4
                                      + pReportBuffer.DECIMAL5 + pReportBuffer.DECIMAL6 + pReportBuffer.DECIMAL7 + pReportBuffer.DECIMAL8 + pReportBuffer.DECIMAL9
                                      + pReportBuffer.DECIMAL10 + pReportBuffer.DECIMAL11 + pReportBuffer.DECIMAL12;

                pReportBuffer.Insert;
                _EnteryNo += 1;
            until _Vehicle.Next = 0;
        end;
    end;

    local procedure Page50216_SetKmCumulative(pEndDate: Date; pVehicleNo: Code[20]): Decimal
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
    begin

        _VehicleRefueLedEntry.Reset;
        _VehicleRefueLedEntry.SetRange("Vehicle Document No.", pVehicleNo);
        _VehicleRefueLedEntry.SetRange("Oiling Date", 0D, pEndDate);
        if _VehicleRefueLedEntry.FindLast then begin
            exit(_VehicleRefueLedEntry."Km Cumulative");
        end else
            exit(0);
    end;

    local procedure Page50216_SetOperatingDistance(pStartDate: Date; pEndDate: Date; pVehicleNo: Code[20]): Text
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
        _OperCount: Integer;
        _FirstDistance: Decimal;
        _LastDistance: Decimal;
    begin

        _VehicleRefueLedEntry.Reset;
        _VehicleRefueLedEntry.SetRange("Vehicle Document No.", pVehicleNo);
        if not _VehicleRefueLedEntry.FindSet then exit(Format(0));

        if _VehicleRefueLedEntry.FindSet then begin
            if _VehicleRefueLedEntry.Count = 1 then exit('-');       //—Ÿ‚¬ˆˆ ´‹ µÕ Ð‹Ó Š­í—Ÿ - Return
        end;

        _VehicleRefueLedEntry.SetRange("Oiling Date", pStartDate, pEndDate);
        if _VehicleRefueLedEntry.FindFirst then begin
            _FirstDistance := _VehicleRefueLedEntry."Km Cumulative";
        end;

        if _VehicleRefueLedEntry.FindLast then begin
            _LastDistance := _VehicleRefueLedEntry."Km Cumulative";
        end;

        exit(Format(_LastDistance - _FirstDistance));
    end;

    local procedure Page50216_SetAverageFuel(pStartDate: Date; pEndDate: Date; pVehicleNo: Code[20]): Text
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
    begin

        _VehicleRefueLedEntry.Reset;
        _VehicleRefueLedEntry.SetRange("Vehicle Document No.", pVehicleNo);
        _VehicleRefueLedEntry.SetFilter(Mileage, '<>%1', 0);
        _VehicleRefueLedEntry.SetRange("Oiling Date", pStartDate, pEndDate);
        if not _VehicleRefueLedEntry.FindSet then exit(Format('-'));

        if _VehicleRefueLedEntry.FindSet then begin
            _VehicleRefueLedEntry.CalcSums(Mileage);

            exit(Format(Round((_VehicleRefueLedEntry.Mileage / _VehicleRefueLedEntry.Count), 0.1, '=')));
        end;
    end;

    local procedure Page50216_ReportBufferCount(pStartDate: Date; pEndDate: Date; pVehicleNo: Code[20]): Integer
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
    begin
        _VehicleRefueLedEntry.Reset;
        _VehicleRefueLedEntry.SetRange("Oiling Date", pStartDate, pEndDate);
        _VehicleRefueLedEntry.SetRange("Vehicle Document No.", pVehicleNo);
        if _VehicleRefueLedEntry.FindSet then
            exit(_VehicleRefueLedEntry.Count);

    end;

    local procedure Page50216_ReportBufferAmount(pStartDate: Date; pEndDate: Date; pVehicleNo: Code[20]): Decimal
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
    begin
        _VehicleRefueLedEntry.Reset;
        _VehicleRefueLedEntry.SetRange("Oiling Date", pStartDate, pEndDate);
        _VehicleRefueLedEntry.SetRange("Vehicle Document No.", pVehicleNo);
        if _VehicleRefueLedEntry.FindSet then begin
            _VehicleRefueLedEntry.CalcSums(Amount);
            exit(_VehicleRefueLedEntry.Amount);
        end;
    end;


    procedure Page50219_SetMatrixCaption(var pMatrixCaption: array[100] of Text[1024]; var pTmpContrat: array[100] of Record DK_Contract temporary; pConforType: Option Conformation,Digits; pReferenceDate: Date; pDateType: Option Week,Month,Current,Previous)
    var
        _CemeteryConformation: Record "DK_Cemetery Conformation";
        _CemeteryDigits: Record "DK_Cemetery Digits";
        _i: Integer;
        _Contrat: Record DK_Contract;
        _StartDate: Date;
        _EndDate: Date;
    begin
        _i := 1;
        /*
        pTmpContract.RESET;
        pTmpContract.DELETEALL;
        
        CASE pDateType OF
          pDateType::Week:BEGIN
            _StartDate := pReferenceDate;
            _EndDate := CALCDATE('<+CW>',_StartDate);
          END;
          pDateType::Month:BEGIN
            _StartDate := CALCDATE('<-CM>',pReferenceDate);
            _EndDate := CALCDATE('<+CM>',pReferenceDate);
          END;
          pDateType::Current:BEGIN
            _StartDate := CALCDATE('<-CY>',pReferenceDate);
            _EndDate := CALCDATE('<+CY>',_StartDate);
          END;
          pDateType::Previous:BEGIN
            _StartDate := CALCDATE('<-CY-Y>',pReferenceDate);
            _EndDate := CALCDATE('<+CY>',_StartDate);
          END;
        END;
        */
        /*
        CASE pConforType OF
          pConforType::Conformation:BEGIN
            _CemeteryConformation.RESET;
            _CemeteryConformation.SETCURRENTKEY(Code);
            IF _CemeteryConformation.FINDSET THEN BEGIN
              REPEAT
                _Contrat.RESET;
                _Contrat.SETRANGE("Contract Date",_StartDate,_EndDate);
                _Contrat.SETRANGE("Cemetery Conf. Code",_CemeteryConformation.Code);
                IF _Contrat.FINDSET THEN
                  pTmpContrat[_i] := _Contrat;
        
                pMatrixCaption[_i] := _CemeteryConformation.Name;
                _i+=1;
              UNTIL _CemeteryConformation.NEXT = 0;
            END;
          END;
          pConforType::Digits:BEGIN
            _CemeteryDigits.RESET;
            _CemeteryDigits.SETCURRENTKEY(Code);
            IF _CemeteryDigits.FINDSET THEN BEGIN
              REPEAT
                _Contrat.RESET;
                _Contrat.SETRANGE("Contract Date",_StartDate,_EndDate);
                _Contrat.SETRANGE("Cemetery Dig. Code",_CemeteryDigits.Code);
                IF _Contrat.FINDSET THEN
                  pTmpContrat[_i] := _Contrat;
        
                pMatrixCaption[_i] := _CemeteryDigits.Name;
                _i+=1;
              UNTIL _CemeteryDigits.NEXT = 0;
            END;
          END;
        END;
        */

    end;


    procedure Page50219_SetMatrixRecord(var pMatrixData: array[100] of Integer; pTmpContract: array[100] of Record DK_Contract temporary; pConforType: Option Conformation,Digits)
    var
        _i: Integer;
        _CemeteryConformation: Record "DK_Cemetery Conformation";
        _CemeteryDigits: Record "DK_Cemetery Digits";
    begin
        //_i := 1;
    end;


    procedure Page50224_ToExcel(var pDK_ReportBuffer: Record "DK_Report Buffer" temporary)
    var
        _FileMgt: Codeunit "File Management";
        _SheetName: Label 'Litigation Payment';
        _TextCol01: Label 'Entry No.';
        _TextCol02: Label 'Payment Date';
        _TextCol03: Label 'Cemetry No.';
        _TextCol04: Label 'Main Customer Name';
        _TextCol05: Label 'Admin Type';
        _TextCol06: Label 'Payment Type';
        _TextCol07: Label 'Payment Method';
        _TextCol08: Label 'General Start Date';
        _TextCol09: Label 'General Expiration Date';
        _TextCol10: Label 'Landscape Arc. Start Date';
        _TextCol11: Label 'Landscape Arc. Expiration';
        _TextCol12: Label 'General Term';
        _TextCol13: Label 'Landscape Term';
        _TextCol14: Label 'General Amount';
        _TextCol15: Label 'Landscape Amount';
        _TextCol16: Label 'Employee';
        _TextCol17: Label 'Reduction Amount';
        _TextCol18: Label 'Other Amount';
        _TextCol19: Label 'Withdraw Method';
        _TextCol20: Label 'Remark';
        _RowNo: Integer;
        _FirstRowNo: Integer;
    begin
        Clear(ServerFileName);
        Clear(SheetName);
        _FirstRowNo := 1;
        _RowNo := 1;
        // ServerFileName := _FileMgt.ServerTempFileName('xlsx');////zzz
        SheetName := _SheetName;
        //Title
        //EnterCell(1,1 ,_TextCol01,FALSE,FALSE,TRUE,'',TempExcelBuffer."Cell Type"::Text);

        //header
        EnterCell(_FirstRowNo, 1, _TextCol01, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 2, _TextCol02, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 3, _TextCol03, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 4, _TextCol04, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 5, _TextCol05, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 6, _TextCol06, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 7, _TextCol07, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 8, _TextCol08, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 9, _TextCol09, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 10, _TextCol10, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 11, _TextCol11, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 12, _TextCol12, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 13, _TextCol13, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 14, _TextCol14, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 15, _TextCol15, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 16, _TextCol16, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 17, _TextCol17, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 18, _TextCol18, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 19, _TextCol19, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(_FirstRowNo, 20, _TextCol20, false, false, true, '', TempExcelBuffer."Cell Type"::Text);

        //Lines
        with pDK_ReportBuffer do begin
            FindFirst;
            repeat
                _RowNo += 1;
                EnterCell(_RowNo, 1, Format("Entry No."), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 2, Format(DATE0, 0, '<Year4>-<Month,2>-<Day,2>'), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 3, TEXT0, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 4, TEXT1, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 5, TEXT2, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 6, TEXT3, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 7, TEXT4, false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 8, Format(DATE1, 0, '<Year4>-<Month,2>-<Day,2>'), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 9, Format(DATE2, 0, '<Year4>-<Month,2>-<Day,2>'), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 10, Format(DATE3, 0, '<Year4>-<Month,2>-<Day,2>'), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 11, Format(DATE4, 0, '<Year4>-<Month,2>-<Day,2>'), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 12, Format(INTEGER0), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 13, Format(INTEGER1), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 14, Format(DECIMAL0), false, false, true, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(_RowNo, 15, Format(DECIMAL1), false, false, true, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(_RowNo, 16, Format(TEXT7), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 17, Format(DECIMAL2), false, false, true, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(_RowNo, 18, Format(DECIMAL3), false, false, true, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(_RowNo, 19, Format(TEXT8), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(_RowNo, 20, Format(TEXT9), false, false, true, '', TempExcelBuffer."Cell Type"::Text);
            until Next = 0;
        end;
        CreateExcelAndClosedAndDownload;
    end;


    procedure Page50227_SetRecord(pStartDate: Date; pEndDate: Date; var pDK_ReportBuffer: Record "DK_Report Buffer" temporary)
    var
        _DK_Contract: Record DK_Contract;
        _EntryNo: Integer;
        _DK_RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    begin
        with pDK_ReportBuffer do begin
            Reset;
            DeleteAll;

            _DK_Contract.Reset;
            _DK_Contract.CalcFields("Non-Pay. General Amount");
            _DK_Contract.SetRange("General Expiration Date", pStartDate, pEndDate);
            _DK_Contract.SetFilter("Non-Pay. General Amount", '<>%1', 0);
            if _DK_Contract.FindSet then
                repeat
                    _DK_Contract.CalcFields("Cemetery Size");
                    _EntryNo += 1;
                    Init;
                    "USER ID" := UserId;
                    "OBJECT ID" := PAGE::"DK_Long-term Not Payer";
                    "Entry No." := _EntryNo;
                    CODE0 := _DK_Contract."No.";
                    CODE1 := _DK_Contract."Cemetery Code";
                    TEXT0 := _DK_Contract."Cemetery No.";
                    DATE1 := _DK_Contract."Contract Date";
                    DECIMAL0 := _DK_Contract."Cemetery Size";
                    DECIMAL2 := Page50227_AdminExpLedger(0D, Today, 0, CODE0);
                    DECIMAL3 := 0;
                    Page50227_LastReceipt(CODE0, DECIMAL4, DATE0);
                    TEXT1 := _DK_RevocationContractMgt.CalcContractYearPreiod(_DK_Contract."General Expiration Date", Today);
                    DECIMAL1 := DECIMAL2 + DECIMAL3;
                    Insert;
                    ;
                until _DK_Contract.Next = 0;

            _DK_Contract.Reset;
            _DK_Contract.CalcFields("Non-Pay. Land. Arc. Amount");
            _DK_Contract.SetFilter("Non-Pay. Land. Arc. Amount", '<>%1', 0);
            _DK_Contract.SetRange("Land. Arc. Expiration Date", pStartDate, pEndDate);
            if _DK_Contract.FindSet then
                repeat
                    _DK_Contract.CalcFields("Cemetery Size");

                    SetRange(CODE0, _DK_Contract."No.");
                    if FindSet then begin
                        DECIMAL3 := Page50227_AdminExpLedger(0D, pEndDate, 1, CODE0);
                        TEXT2 := _DK_RevocationContractMgt.CalcContractYearPreiod(_DK_Contract."Land. Arc. Expiration Date", Today);
                        DECIMAL1 := DECIMAL2 + DECIMAL3;
                        Modify;
                    end else begin
                        _EntryNo += 1;
                        Init;
                        "USER ID" := UserId;
                        "OBJECT ID" := PAGE::"DK_Long-term Not Payer";
                        "Entry No." := _EntryNo;
                        CODE0 := _DK_Contract."No.";
                        CODE1 := _DK_Contract."Cemetery Code";
                        TEXT0 := _DK_Contract."Cemetery No.";
                        DATE1 := _DK_Contract."Contract Date";
                        DECIMAL0 := _DK_Contract."Cemetery Size";
                        DECIMAL2 := 0;
                        DECIMAL3 := Page50227_AdminExpLedger(0D, Today, 1, CODE0);
                        Page50227_LastReceipt(CODE0, DECIMAL4, DATE0);
                        TEXT2 := _DK_RevocationContractMgt.CalcContractYearPreiod(_DK_Contract."Land. Arc. Expiration Date", Today);
                        DECIMAL1 := DECIMAL2 + DECIMAL3;
                        Insert;
                        ;
                    end;
                    SetRange(CODE0);
                until _DK_Contract.Next = 0;

            if _EntryNo > 0 then begin
                //SETFILTER(DECIMAL1,'0');
                // IF FINDSET THEN
                // DeleteAll;
                //RESET;
                FindFirst;
            end;

        end;
    end;


    procedure Page50227_AdminExpLedger(pStartDate: Date; pEndDate: Date; pAdminExpType: Integer; pContractNo: Code[20]): Decimal
    var
        _DK_Contract: Record DK_Contract;
    begin
        with _DK_Contract do begin
            Reset;
            SetRange("No.", pContractNo);
            SetRange("Date Filter", pStartDate, pEndDate);
            if FindSet then begin
                CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");
                //Ÿ‰¦ ýˆ«Š±
                if pAdminExpType = 0 then
                    exit("Non-Pay. General Amount")
                //‘†µýˆ«Š±
                else
                    exit("Non-Pay. Land. Arc. Amount");
            end;
        end;
    end;

    local procedure Page50227_LastReceipt(pContractNo: Code[20]; var pAmount: Decimal; var pDate: Date)
    var
        _DK_PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    begin
        with _DK_PaymentReceiptDocument do begin
            Reset;
            SetCurrentKey("Payment Date");
            SetRange("Contract No.", pContractNo);
            if FindLast then begin
                pDate := _DK_PaymentReceiptDocument."Payment Date";
                pAmount := _DK_PaymentReceiptDocument.Amount;
            end;
        end;
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        with TempExcelBuffer do begin
            Init;
            Validate("Row No.", RowNo);
            Validate("Column No.", ColumnNo);
            "Cell Value as Text" := CellValue;
            Formula := '';
            Bold := Bold;
            Italic := Italic;
            Underline := Underline;
            NumberFormat := Format;
            "Cell Type" := CellType;
            Insert;
            ;
        end;
    end;

    local procedure CreateExcelAndClosed()
    var
        _Text001: Label 'Export to EXCEL File';
        _Text002: Label 'XLSX Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*';
    begin
        ////zzz++
        // with TempExcelBuffer do begin
        //     CreateBook(ServerFileName, SheetName);
        //     WriteSheet(SheetName, CompanyName, UserId);
        //     CloseBook;
        //     OpenExcelWithName(ServerFileName);
        // end;
        ////zzz--
    end;

    local procedure CreateExcelAndClosedAndDownload()
    var
        _Text001: Label 'Export to EXCEL File';
        _Text002: Label 'XLSX Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*';
        FileManagement: Codeunit "File Management";
    begin
        ////zzz++
        // with TempExcelBuffer do begin
        //     CreateBook(ServerFileName, SheetName);
        //     WriteSheet(SheetName, CompanyName, UserId);
        //     CloseBook;
        //     FileManagement.DownloadHandler(ServerFileName, '', '', '', 'abc.xlsx');
        // end;
        ////zzz--
    end;
}

