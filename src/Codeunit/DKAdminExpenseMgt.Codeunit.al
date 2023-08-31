codeunit 50009 "DK_Admin. Expense Mgt."
{
    // *DK32 : 20200715
    //   - Modify Function : GetCalcAdminExpenseEndingDateForAmount
    //                       GetCalcAdminExpenseAmountForEndingDate
    //   - Add Function : GetMaxExpirationDate
    // 
    // #2089 : 20200811
    //   - Modify Function : GetCalcAdminExpenseAmountForEndingDate
    // 
    // DK34 : 20201116
    //   - Modify Function : CalcDelayInterestAmount


    trigger OnRun()
    var
        _Contract: Record DK_Contract;
        _AdminExpenseAmount: Decimal;
        _adminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _RunDate: Date;
        _RunAmount: Decimal;
        _ApplyAmount: Decimal;
        _DiffAmount: Decimal;
        _ArrGenAmt: array[10] of Decimal;
        _ArrLanAmt: array[10] of Decimal;
        _MainLoop: Integer;
        _MaxLoop: Integer;
        _StartDate: Date;
        _EndDate: Date;
    begin
        /*
        VarNameDataTypeSubtypeLength
        NopContractRecordDK_Contract
        NopPriceTypeOption
        NopStartingDateDate
        NopEndingDateDate
        NopDocumentNoCode20
        NopDocumentLineNoInteger
        NopNonPaymentBoolean
        */
        if _Contract.Get('CD0000050') then
            GetPeriodAdminExpense(_Contract, 0, 20190731D, 20240524D, 'PRD0097971', 10000, true);

    end;

    var
        MSG001: Label 'FromDate and ToDate are required.';
        MSG002: Label 'FromDate can not be earlier than ToDate. FromDate:%1, ToDate:%2';
        MSG003: Label 'The value of %1 in %2 is (0). The operation can not proceed.';
        MSG004: Label 'No Contract Date is specified for this contract. Check your Contract. %1:%2';
        MSG005: Label 'The %2 information could not be verified in the %1.';
        AdminExpenseBuffer: Record "DK_Admin. Expense Data";
        MSG: Text;
        MSG006: Label 'No contract information found.';
        MSG007: Label 'Can not process.';
        MSG009: Label 'The %1 is invalid.';
        MSG010: Label 'Today Delay Interest Amount\\- General Period : %1\\- Delay Interest Amount : %2\\- Lan. Period: %3\\- Delay Interest Amount : %4';
        Window: Dialog;
        MSG100: Label 'Processing ReceiptDocument   #1############\';
        MSG101: Label 'Processing  #2##########\';
        MSG102: Label 'Daily Creating  #1##########\';


    procedure NewContract(pContractNo: Code[20]; pAdminExpType: Option; pPaymentAmount: Decimal; pSourceNo: Code[20]; pSourceLineNo: Integer): Date
    var
        _Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _Years: Record Date;
        _Dailys: Record Date;
        _FunctionSetup: Record "DK_Function Setup";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _EndingDate: Date;
        _StartingDate: Date;
        _LoopEndingDate: Date;
        _LoopStartingDate: Date;
        _YearLoop: Integer;
        _YearUnitAdminExpense: Decimal;
        _DiffYearUnitAdminExpense: Decimal;
        _YearAdminExpensePrice: Decimal;
        _DaliyAmount: Decimal;
        _DiffAmount: Decimal;
    begin

        _FunctionSetup.Get;
        //_FunctionSetup.TESTFIELD("Management Unit");

        if pContractNo = '' then exit(0D);
        if pPaymentAmount = 0 then exit(0D);
        if not _Contract.Get(pContractNo) then exit(0D);
        _StartingDate := _Contract."Contract Date";
        if _StartingDate = 0D then exit(0D);

        _EndingDate := CalcDate(StrSubstNo('<+%1Y>', _Contract."Management Unit"), _StartingDate) - 1;

        //1‚Ëýˆ«Š± „Âí
        //_YearAdminExpensePrice := GetCurrAdminExpensePrice(_Contract."Cemetery Code",pAdminExpType, _StartingDate);
        //Sizeí „ã—¹‘° €¦Ž¸
        //_YearAdminExpense := GetYearAdminExpense(_Contract."Cemetery Code",_YearAdminExpensePrice);

        if _Contract."Management Unit" = 0 then
            _Contract."Management Unit" := _FunctionSetup."Management Unit";

        _YearUnitAdminExpense := Round(pPaymentAmount / _Contract."Management Unit", 1, '=');
        _DiffYearUnitAdminExpense := pPaymentAmount - (_YearUnitAdminExpense * _Contract."Management Unit");


        _Years.Reset;
        _Years.SetCurrentKey("Period Type", "Period Start");
        _Years.SetRange("Period Type", _Years."Period Type"::Year);
        _Years.SetRange("Period Start", _StartingDate, _EndingDate);
        if _Years.FindFirst then begin
            _LoopStartingDate := _StartingDate;
            _LoopEndingDate := CalcDate('<+1Y-1D>', _LoopStartingDate);
            repeat

                if Date2DMY(_Years."Period Start", 3) = Date2DMY(_EndingDate, 3) then begin
                    //’ðŽ¸ “‚ˆ«
                    GetDailyAdminExpense(_LoopStartingDate, _LoopEndingDate, (_YearUnitAdminExpense - _DiffYearUnitAdminExpense), _DaliyAmount, _DiffAmount);
                end else begin
                    GetDailyAdminExpense(_LoopStartingDate, _LoopEndingDate, _YearUnitAdminExpense, _DaliyAmount, _DiffAmount);
                end;

                _Dailys.Reset;
                _Dailys.SetCurrentKey("Period Type", "Period Start");
                _Dailys.SetRange("Period Type", _Dailys."Period Type"::Date);
                _Dailys.SetRange("Period Start", _LoopStartingDate, _LoopEndingDate);
                if _Dailys.FindFirst then begin
                    repeat
                        _AdminExpenseLedger.Init;
                        _AdminExpenseLedger."Contract No." := pContractNo;
                        _AdminExpenseLedger.Date := _Dailys."Period Start";

                        if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then
                            _AdminExpenseLedger."Line No." := 10
                        else
                            _AdminExpenseLedger."Line No." := 20;
                        //_AdminExpenseLedger."Line No." := _AdminExpenseLedger.GetNewLineNo(pContractNo, _Dailys."Period Start");
                        _AdminExpenseLedger."Admin. Expense Type" := pAdminExpType;
                        _AdminExpenseLedger."Ledger Type" := _AdminExpenseLedger."Ledger Type"::Daily;

                        if _Dailys."Period Start" = _LoopEndingDate then
                            _AdminExpenseLedger.Amount := -(_DaliyAmount + _DiffAmount)
                        else
                            _AdminExpenseLedger.Amount := -_DaliyAmount;

                        _AdminExpenseLedger."Source No." := pSourceNo;
                        _AdminExpenseLedger."Source Line No." := pSourceLineNo;
                        _AdminExpenseLedger."First Contract" := true;
                        _AdminExpenseLedger.Open := true;
                        _AdminExpenseLedger.Insert(true);

                    until _Dailys.Next = 0;
                end;

                _LoopStartingDate := CalcDate('<+1Y>', _LoopStartingDate);
                _LoopEndingDate := CalcDate('<+1Y>', _LoopEndingDate);
            until _Years.Next = 0;

            _LoopEndingDate := CalcDate('<-1Y>', _LoopEndingDate);
            exit(_LoopEndingDate);
        end;
    end;


    procedure AddAdminExpense(var pContract: Record DK_Contract; pAdminExpType: Option; pPaymentAmount: Decimal; pSourceNo: Code[20]; pSourceLineNo: Integer; pPaymentDate: Date; pAddExpirationDate: Date; pLowBalance: Boolean; pStartDate: Date): Date
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _LoopDate: Date;
        _LoopAmount: Decimal;
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _Today: Date;
        _EntryRemAmount: Decimal;
    begin

        //IF pContractNo = '' THEN EXIT(0D);
        if pPaymentAmount = 0 then exit(0D);
        //IF NOT _Contract.GET(pContractNo) THEN EXIT(0D);

        if pPaymentDate = 0D then
            _Today := Today
        else
            _Today := pPaymentDate;

        if pStartDate = 0D then begin
            if pAddExpirationDate = 0D then begin
                if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then
                    _LoopDate := pContract."General Expiration Date"
                else
                    _LoopDate := pContract."Land. Arc. Expiration Date";
            end else begin
                //ˆˆ€ËŸÀ ˜«ž
                _LoopDate := pAddExpirationDate - 1;
            end;
        end else begin
            _LoopDate := pStartDate;
        end;

        if _LoopDate = 0D then begin
            if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then
                Error(MSG009, pContract.FieldCaption("General Expiration Date"))
            else
                Error(MSG009, pContract.FieldCaption("Land. Arc. Expiration Date"));
        end;

        if GuiAllowed then
            Window.Open(MSG102);


        //‰œ‚‚ýˆ«Š±
        if _LoopDate <= pPaymentDate then begin
            _DetailAdminExpLedger.Reset;
            _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type");
            _DetailAdminExpLedger.SetRange("Contract No.", pContract."No.");
            _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpType);
            _DetailAdminExpLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
            _DetailAdminExpLedger.SetRange(Date, (_LoopDate + 1), _Today);
            if _DetailAdminExpLedger.FindLast then begin
                _DetailAdminExpLedger.CalcSums(Amount);
                pPaymentAmount += (_DetailAdminExpLedger.Amount);

                //‰œ‚‚ ‹²ŒŠ €Ëú ‹²‡½
                _LoopDate := _DetailAdminExpLedger.Date;
            end;
        end;


        //Œ€‚‚ýˆ«Š±
        while pPaymentAmount > 0 do begin

            _LoopDate += 1;

            if GuiAllowed then
                Window.Update(1, Format(_LoopDate));

            //Daily Batch í …ÁŽ˜…—Ž·‹ µÕ ‰Â“‚ˆ«
            if _LoopDate <= _Today then begin
                //‰œ‚‚
                _LoopAmount := GetContractDailyAdminExpense(pContract, _LoopDate, pAdminExpType, 0D, true, _EntryRemAmount);
            end else begin
                //Œ€‚‚
                _LoopAmount := GetContractDailyAdminExpense(pContract, _LoopDate, pAdminExpType, pPaymentDate, true, _EntryRemAmount);
            end;

            if (_LoopAmount - _EntryRemAmount) <> 0 then begin

                _AdminExpenseLedger.Init;
                _AdminExpenseLedger."Contract No." := pContract."No.";
                _AdminExpenseLedger.Date := _LoopDate;
                _AdminExpenseLedger.CalcFields("Max Line No.");
                //_AdminExpenseLedger."Line No." := _AdminExpenseLedger.GetNewLineNo(pContract."No.", _LoopDate);
                _AdminExpenseLedger."Line No." := _AdminExpenseLedger."Max Line No." + 1;
                _AdminExpenseLedger."Admin. Expense Type" := pAdminExpType;
                _AdminExpenseLedger."Ledger Type" := _AdminExpenseLedger."Ledger Type"::Daily;
                _AdminExpenseLedger."Source No." := pSourceNo;
                _AdminExpenseLedger."Source Line No." := pSourceLineNo;
                _AdminExpenseLedger.Open := true;
                _AdminExpenseLedger."Low Balance" := pLowBalance;

                if pAddExpirationDate <> 0D then
                    _AdminExpenseLedger."Add. Period" := true;

                if pPaymentAmount >= ((_LoopAmount - _EntryRemAmount) * -1) then begin

                    _AdminExpenseLedger.Amount := (_LoopAmount - _EntryRemAmount);
                    _AdminExpenseLedger.Insert(true);

                end else begin
                    _AdminExpenseLedger.Amount := -pPaymentAmount;
                    _AdminExpenseLedger.Insert(true);

                    if GuiAllowed then
                        Window.Close;
                    exit(_LoopDate - 1);
                end;
            end;

            pPaymentAmount += (_LoopAmount - _EntryRemAmount);

        end;

        if GuiAllowed then
            Window.Close;

        exit(_LoopDate);
    end;


    procedure AddAdminExpense2(pPayRecDoc: Record "DK_Payment Receipt Document"; pPayRecDocLine: Record "DK_Payment Receipt Doc. Line"; pAdminExpType: Option; pAddExpirationDate: Date; pPaymentAmount: Decimal): Date
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _Contract: Record DK_Contract;
        _LoopDate: Date;
        _LoopAmount: Decimal;
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _NonPayment: Boolean;
        _Today: Date;
        _EntryRemAmount: Decimal;
    begin

        if pPaymentAmount = 0 then exit(0D);
        if not _Contract.Get(pPayRecDoc."Contract No.") then exit(0D);

        if pPayRecDoc."Payment Date" = 0D then
            _Today := Today
        else
            _Today := pPayRecDoc."Payment Date";

        if pAddExpirationDate = 0D then begin
            if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then
                _LoopDate := _Contract."General Expiration Date"
            else
                _LoopDate := _Contract."Land. Arc. Expiration Date";
        end else begin
            //ˆˆ€ËŸÀ ˜«ž
            _LoopDate := pAddExpirationDate - 1;
        end;

        if _LoopDate = 0D then begin
            if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then
                Error(MSG009, _Contract.FieldCaption("General Expiration Date"))
            else
                Error(MSG009, _Contract.FieldCaption("Land. Arc. Expiration Date"));
        end;

        if GuiAllowed then
            Window.Open(MSG102);


        //‰œ‚‚ýˆ«Š±
        if _LoopDate <= _Today then begin
            _DetailAdminExpLedger.Reset;
            _DetailAdminExpLedger.SetRange("Contract No.", pPayRecDoc."Contract No.");
            _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpType);
            _DetailAdminExpLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
            _DetailAdminExpLedger.SetRange(Date, (_LoopDate + 1), _Today);
            if _DetailAdminExpLedger.FindLast then begin
                _DetailAdminExpLedger.CalcSums(Amount);
                pPaymentAmount += (_DetailAdminExpLedger.Amount);

                //‰œ‚‚ ‹²ŒŠ €Ëú ‹²‡½
                _LoopDate := _DetailAdminExpLedger.Date;
            end;
            _NonPayment := true;
        end;


        //Œ€‚‚ýˆ«Š±
        GetPeriodAdminExpense(_Contract,
                              pAdminExpType,
                              pPayRecDocLine."Start Date",
                              pPayRecDocLine."Expiration Date",
                              pPayRecDocLine."Document No.",
                              pPayRecDocLine."Line No.",
                              _NonPayment);


        AdminExpenseBuffer.Reset;
        AdminExpenseBuffer.SetCurrentKey("Line No.");
        if AdminExpenseBuffer.FindSet then begin
            repeat

            until AdminExpenseBuffer.Next = 0;
        end;

        while pPaymentAmount > 0 do begin

            _LoopDate += 1;

            if GuiAllowed then
                Window.Update(1, Format(_LoopDate));

            //Daily Batch í …ÁŽ˜…—Ž·‹ µÕ ‰Â“‚ˆ«
            if _LoopDate <= _Today then begin
                //‰œ‚‚
                _LoopAmount := GetContractDailyAdminExpense(_Contract, _LoopDate, pAdminExpType, 0D, true, _EntryRemAmount);
            end else begin
                //Œ€‚‚
                _LoopAmount := GetContractDailyAdminExpense(_Contract, _LoopDate, pAdminExpType, pPayRecDoc."Payment Date", true, _EntryRemAmount);
            end;

            if (_LoopAmount - _EntryRemAmount) <> 0 then begin

                _AdminExpenseLedger.Init;
                _AdminExpenseLedger."Contract No." := pPayRecDoc."Contract No.";
                _AdminExpenseLedger.Date := _LoopDate;
                _AdminExpenseLedger."Line No." := _AdminExpenseLedger.GetNewLineNo(pPayRecDoc."Contract No.", _LoopDate);
                _AdminExpenseLedger."Admin. Expense Type" := pAdminExpType;
                _AdminExpenseLedger."Ledger Type" := _AdminExpenseLedger."Ledger Type"::Daily;
                _AdminExpenseLedger."Source No." := pPayRecDocLine."Document No.";
                _AdminExpenseLedger."Source Line No." := pPayRecDocLine."Line No.";
                _AdminExpenseLedger.Open := true;

                if pAddExpirationDate <> 0D then
                    _AdminExpenseLedger."Add. Period" := true;

                if pPaymentAmount >= (_LoopAmount * -1) then begin
                    _AdminExpenseLedger.Amount := (_LoopAmount - _EntryRemAmount);
                    _AdminExpenseLedger.Insert(true);

                end else begin
                    _AdminExpenseLedger.Amount := -pPaymentAmount;
                    _AdminExpenseLedger.Insert(true);

                    if GuiAllowed then
                        Window.Close;
                    exit(_LoopDate - 1);
                end;
            end;
            //‘²Ð
            pPaymentAmount += _LoopAmount;
        end;

        if GuiAllowed then
            Window.Close;

        exit(_LoopDate);
    end;


    procedure GetCurrAdminExpensePrice(pCemeteryCode: Code[20]; pPriceType: Option; pDate: Date): Decimal
    var
        _Cemetery: Record DK_Cemetery;
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
    begin

        if _Cemetery.Get(pCemeteryCode) then begin

            _AdminExpensePrice.Reset;
            _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
            _AdminExpensePrice.SetRange("Price Type", pPriceType);
            _AdminExpensePrice.SetRange("Unit Price Type Code", _Cemetery."Unit Price Type Code");
            _AdminExpensePrice.SetFilter("Starting Date", '<=%1', pDate);
            if _AdminExpensePrice.FindLast then
                exit(_AdminExpensePrice."Unit Price");
        end;

        exit(0);
    end;


    procedure GetYearAdminExpense(pCemeteryCode: Code[20]; pUnitPrice: Decimal): Decimal
    var
        _Cemetery: Record DK_Cemetery;
        _Size: Decimal;
    begin

        if _Cemetery.Get(pCemeteryCode) then
            _Size := _Cemetery.Size;

        if _Size = 0 then
            Error(MSG003, _Cemetery.FieldCaption(Size), _Cemetery.TableCaption);

        exit(Round(pUnitPrice * _Size, 1, '='));
    end;


    procedure GetContractAdminExpense(pCemeteryCode: Code[20]; pUnitPrice: Decimal; pManagementUnit: Integer): Decimal
    var
        _Cemetery: Record DK_Cemetery;
        _Size: Decimal;
        _FunctionSetup: Record "DK_Function Setup";
    begin

        //_FunctionSetup.GET;
        //_FunctionSetup.TESTFIELD("Management Unit");

        if _Cemetery.Get(pCemeteryCode) then
            _Size := _Cemetery.Size;

        if _Size = 0 then
            Error(MSG003, _Cemetery.FieldCaption(Size), _Cemetery.TableCaption);

        exit(Round(pUnitPrice * _Size, 1, '=') * pManagementUnit);
    end;


    procedure GetDailyAdminExpense(pFromDate: Date; pToDate: Date; pYearAdminExpense: Decimal; var pDailyAdminExpense: Decimal; var pDiffAmount: Decimal)
    var
        _DiffDays: Integer;
    begin

        if (pFromDate = 0D) or (pToDate = 0D) then Error(MSG001);
        if pFromDate > pToDate then Error(MSG002, pFromDate, pToDate);

        _DiffDays := (pToDate - pFromDate) + 1;

        //Rounding
        if _DiffDays <> 0 then begin
            pDailyAdminExpense := Round(pYearAdminExpense / _DiffDays, 1, '=');
            pDiffAmount := pYearAdminExpense - (pDailyAdminExpense * _DiffDays);
        end;

        //ERROR('1 %1 %2 %3',pYearAdminExpense, pDailyAdminExpense, pDiffAmount);
    end;


    procedure GetNextEndingDate(pContractNo: Code[20]; pPriceType: Option; pDate: Date; pPayAmount: Decimal): Date
    var
        _Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
        _AdminExpensePrice2: Record "DK_Admin. Expense Price";
        _RemAmount: Decimal;
        _CemeteryCode: Code[20];
        _ContractDate: Date;
        _LoopStartDate: Date;
        _LoopEndDate: Date;
        _RecDate: Record Date;
    begin

        if pDate = 0D then exit(0D);
        if not _Contract.Get(pContractNo) then exit(0D);
        if not _Cemetery.Get(_Contract."Cemetery Code") then exit(0D);

        _ContractDate := _Contract."Contract Date";

        /*
        _RecDate.RESET;
        _RecDate.SETRANGE("Period Type", _RecDate."Period Type"::Year);
        _RecDate.SETRANGE("Period Start", pDate, pDate);
        IF _RecDate.FINDFIRST THEN BEGIN
          REPEAT
        
          UNTIL _RecDate.NEXT = 0;
        END;
        */

        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
        _AdminExpensePrice.SetRange("Price Type", pPriceType);
        _AdminExpensePrice.SetRange("Unit Price Type Code", _Cemetery."Unit Price Type Code");
        _AdminExpensePrice.SetFilter("Starting Date", '<=%1', pDate);
        if _AdminExpensePrice.FindLast then begin

            _AdminExpensePrice2.Reset;
            _AdminExpensePrice2.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
            _AdminExpensePrice2.SetRange("Price Type", _AdminExpensePrice."Price Type");
            _AdminExpensePrice2.SetRange("Unit Price Type Code", _AdminExpensePrice."Unit Price Type Code");
            _AdminExpensePrice2.SetFilter("Starting Date", '>=%1', _AdminExpensePrice."Starting Date");
            if _AdminExpensePrice2.FindLast then begin

                _LoopStartDate := pDate;
                repeat
                    _LoopEndDate := _AdminExpensePrice2."Starting Date" - 1;

                    _LoopStartDate := _AdminExpensePrice2."Starting Date";
                until _AdminExpensePrice2.Next = 0;
                if _LoopEndDate < pDate then begin

                    _LoopEndDate := pDate;
                end;

            end;
        end;

    end;

    local procedure PaymentAdminExpense(pContractNo: Code[20]; pAdminExpType: Option; pPaymentAmount: Decimal; pSourceNo: Code[20]; pSourceLineNo: Integer): Date
    var
        _Contract: Record DK_Contract;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _StartingDate: Date;
        _Remaining: Decimal;
        _BeforPaymentRemaining: Decimal;
        _LastDate: Date;
    begin

        if pContractNo = '' then exit;
        if pPaymentAmount = 0 then exit;
        if not _Contract.Get(pContractNo) then exit;

        if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then
            _StartingDate := _Contract."General Expiration Date" + 1
        else
            _StartingDate := _Contract."Land. Arc. Expiration Date" + 1;

        if _StartingDate = 0D then
            _StartingDate := _Contract."Contract Date";

        _Remaining := pPaymentAmount;

        //GetCurrAdminExpensePrice(_Contract."Cemetery Code" : Code[20];pPriceType : Option;_StartingDate) : Decimal
        //GetYearAdminExpense(pCemeteryCode : Code[20];pUnitPrice : Decimal) : Decimal

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type");
        _AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        _AdminExpenseLedger.SetRange(Date, _StartingDate);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpType);
        if _AdminExpenseLedger.FindSet then begin
            _AdminExpenseLedger.CalcSums(Amount);
            _BeforPaymentRemaining := _AdminExpenseLedger.Amount;
        end;

        while _Remaining <> 0 do begin


            _AdminExpenseLedger.Init;
            _AdminExpenseLedger."Contract No." := pContractNo;
            //_AdminExpenseLedger.Date := _Dailys."Period Start";
            //_AdminExpenseLedger.VALIDATE("Line No." , 10000);
            _AdminExpenseLedger."Admin. Expense Type" := pAdminExpType;
            _AdminExpenseLedger."Ledger Type" := _AdminExpenseLedger."Ledger Type"::Daily;
            //_AdminExpenseLedger.Amount := -_DaliyAmount;

            //_AdminExpenseLedger."Remaining Amount" := -_DaliyAmount;
            _AdminExpenseLedger."Source No." := pSourceNo;
            _AdminExpenseLedger."Source Line No." := pSourceLineNo;
            _AdminExpenseLedger.Open := true;
            _AdminExpenseLedger.Insert(true);


            _Remaining -= 0;
        end;

        //Update to Expiration Date
        if pAdminExpType = _AdminExpenseLedger."Admin. Expense Type"::General then begin
            _Contract."General Expiration Date" := _LastDate;
            if (_AdminExpenseLedger."Low Balance") and (_LastDate <> 0D) then
                _Contract."General Expiration Date" := _Contract."General Expiration Date" - 1;
        end else begin
            _Contract."Land. Arc. Expiration Date" := _LastDate;
            if (_AdminExpenseLedger."Low Balance") and (_LastDate <> 0D) then
                _Contract."Land. Arc. Expiration Date" := _Contract."Land. Arc. Expiration Date" - 1;
        end;
        _Contract.Modify(true);
    end;


    procedure GetYearAdminExpense2(pCemeteryCode: Code[20]; pPriceType: Option; pDate: Date): Decimal
    var
        _Cemetery: Record DK_Cemetery;
        _Size: Decimal;
        _UnitPrice: Decimal;
    begin

        if _Cemetery.Get(pCemeteryCode) then
            _Size := _Cemetery.Size;

        if _Size = 0 then
            Error(MSG003, _Cemetery.FieldCaption(Size), _Cemetery.TableCaption);

        _UnitPrice := GetCurrAdminExpensePrice(pCemeteryCode, pPriceType, pDate);

        exit(Round(_UnitPrice * _Size, 1, '='));
    end;


    procedure GetPeriodAdminExpense(pContract: Record DK_Contract; pPriceType: Option; pStartingDate: Date; pEndingDate: Date; pDocumentNo: Code[20]; pDocumentLineNo: Integer; pNonPayment: Boolean): Decimal
    var
        _Cemetery: Record DK_Cemetery;
        _Size: Decimal;
        _StartingYear: Integer;
        _EndingYear: Integer;
        _LoopMax: Integer;
        _Loop: Integer;
        _AddYear: Integer;
        _LoopStartingDate: Date;
        _LoopEndingDate: Date;
        _FirstStartingDate: Date;
        _LastStartingDate: Date;
        _NewLineNo: Integer;
    begin
        //€Ëúí ýˆ«Š± €¦Ž¸ ‘²Ð

        _Cemetery.Get(pContract."Cemetery Code");

        _Size := _Cemetery.Size;

        if _Size = 0 then
            Error(MSG003, _Cemetery.FieldCaption(Size), _Cemetery.TableCaption);

        //DELETE DATA
        AdminExpenseBuffer.Reset;
        AdminExpenseBuffer.SetRange("Source No.", pDocumentNo);
        AdminExpenseBuffer.SetRange("Source Line No.", pDocumentLineNo);
        AdminExpenseBuffer.SetRange("Non-Payment", pNonPayment);
        if AdminExpenseBuffer.FindSet then
            AdminExpenseBuffer.DeleteAll(true);

        _StartingYear := Date2DMY(pStartingDate, 3);
        _EndingYear := Date2DMY(pEndingDate, 3);

        //Diff. Year
        _LoopMax := _EndingYear - _StartingYear;


        _FirstStartingDate := GetCurrContractDate(pContract, pStartingDate);
        _LastStartingDate := GetCurrContractDate(pContract, pEndingDate);

        if pStartingDate < _FirstStartingDate then begin
            _LoopMax += 1;
        end;

        if _LastStartingDate < pEndingDate then begin
            _LoopMax += 1;
        end;

        //MESSAGE('0 %1 %2 %3', pContract."Contract Date", pStartingDate, pEndingDate);
        //MESSAGE('Ending Date : %1 %2 %3', GetCurrContractDate(pContract,pEndingDate),pEndingDate, _After);

        while _Loop < _LoopMax do begin

            GetYearContractPeriod(pContract, CalcDate(StrSubstNo('<+%1Y>', _Loop), pStartingDate), _LoopStartingDate, _LoopEndingDate);

            if (_LoopStartingDate <= pStartingDate) and
               (_LoopEndingDate >= pStartingDate) then begin
                //MSG := MSG + STRSUBSTNO('1 %1 : %2 ~ %3, %4 ~ %5 \\ ',_Loop, _LoopStartingDate, _LoopEndingDate, pStartingDate, _LoopEndingDate);
                AdminExpensePricePeriod(_NewLineNo, pContract, _Cemetery, _LoopStartingDate, _LoopEndingDate, pStartingDate, _LoopEndingDate, pPriceType,
                                    pDocumentNo, pDocumentLineNo, pNonPayment);
            end else
                if (_LoopStartingDate <= pEndingDate) and
          (_LoopEndingDate >= pEndingDate) then begin
                    //MSG := MSG + STRSUBSTNO('3 %1 : %2 ~ %3, %4 ~ %5 \\ ',_Loop, _LoopStartingDate, _LoopEndingDate, _LoopStartingDate, pEndingDate);
                    AdminExpensePricePeriod(_NewLineNo, pContract, _Cemetery, _LoopStartingDate, _LoopEndingDate, _LoopStartingDate, pEndingDate, pPriceType,
                                         pDocumentNo, pDocumentLineNo, pNonPayment);
                end else begin
                    //MSG := MSG + STRSUBSTNO('2 %1 : %2 ~ %3, %4 ~ %5 \\ ',_Loop, _LoopStartingDate, _LoopEndingDate, _LoopStartingDate, _LoopEndingDate);
                    AdminExpensePricePeriod(_NewLineNo, pContract, _Cemetery, _LoopStartingDate, _LoopEndingDate, _LoopStartingDate, _LoopEndingDate, pPriceType,
                                          pDocumentNo, pDocumentLineNo, pNonPayment);
                end;

            _Loop += 1;
        end;

        AdminExpenseBuffer.Reset;
        AdminExpenseBuffer.SetCurrentKey("Source No.", "Source Line No.", "Non-Payment");
        AdminExpenseBuffer.SetRange("Source No.", pDocumentNo);
        AdminExpenseBuffer.SetRange("Source Line No.", pDocumentLineNo);
        AdminExpenseBuffer.SetRange("Non-Payment", pNonPayment);
        if AdminExpenseBuffer.FindSet then begin
            AdminExpenseBuffer.CalcSums("Pay. Admin. Expense Amt");
            exit(AdminExpenseBuffer."Pay. Admin. Expense Amt");
        end;
    end;


    procedure GetPeriodAdminExpense2(pContract: Record DK_Contract; pPriceType: Option; pStartingDate: Date; pEndingDate: Date; pDocumentNo: Code[20]; pDocumentLineNo: Integer; pNonPayment: Boolean): Decimal
    var
        _Cemetery: Record DK_Cemetery;
        _Size: Decimal;
        _StartingYear: Integer;
        _EndingYear: Integer;
        _LoopMax: Integer;
        _Loop: Integer;
        _AddYear: Integer;
        _CalcStartingDate: Date;
        _NewLineNo: Integer;
        _CalcEndDate: Date;
        _CalcAdminExpAmount: Decimal;
    begin
        //€Ëúí ýˆ«Š± €¦Ž¸ ‘²Ð

        _StartingYear := Date2DMY(pStartingDate, 3);
        _EndingYear := Date2DMY(pEndingDate, 3);

        //Diff. Year
        _LoopMax := _EndingYear - _StartingYear;

        _CalcEndDate := CalcDate(StrSubstNo('<+%1Y>', _LoopMax), pStartingDate) - 1;

        if (_CalcEndDate = pEndingDate) and
           (pStartingDate >= Today) then begin
            _CalcAdminExpAmount := GetYearAdminExpense2(pContract."Cemetery Code", pPriceType, pStartingDate) * _LoopMax;
        end else begin
            _CalcAdminExpAmount := GetPeriodAdminExpense(pContract, pPriceType, pStartingDate, pEndingDate, pDocumentNo, pDocumentLineNo, pNonPayment);
        end;

        exit(_CalcAdminExpAmount);
    end;

    local procedure GetAdminExpenseDate(pCemetery: Record DK_Cemetery; pPriceType: Option; pDate: Date): Date
    var
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
    begin

        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
        _AdminExpensePrice.SetRange("Price Type", pPriceType);
        _AdminExpensePrice.SetRange("Unit Price Type Code", pCemetery."Unit Price Type Code");
        _AdminExpensePrice.SetFilter("Starting Date", '<=%1', pDate);
        if _AdminExpensePrice.FindLast then
            exit(_AdminExpensePrice."Starting Date")
        else
            Error(MSG005, _AdminExpensePrice.TableCaption, _AdminExpensePrice.FieldCaption("Starting Date"));
    end;

    local procedure GetNextAdminExpenseDate(pCemetery: Record DK_Cemetery; pPriceType: Option; pDate: Date): Date
    var
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
    begin

        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
        _AdminExpensePrice.SetRange("Price Type", pPriceType);
        _AdminExpensePrice.SetRange("Unit Price Type Code", pCemetery."Unit Price Type Code");
        _AdminExpensePrice.SetFilter("Starting Date", '>%1', pDate);
        if _AdminExpensePrice.FindFirst then
            exit(_AdminExpensePrice."Starting Date")
    end;


    procedure GetYearContractPeriod(pContract: Record DK_Contract; pExpirationDate: Date; var pNextYearStartingDate: Date; var pNextYearEndingDate: Date)
    var
        _ContractDate: Date;
        _EndingDate: Date;
        _ContractYear: Integer;
        _ExpirationYear: Integer;
    begin


        if pContract."Contract Date" = 0D then
            Error(MSG004, pContract.FieldCaption("No."), pContract."No.");

        _ContractDate := pContract."Contract Date";
        _EndingDate := _ContractDate - 1;

        _ContractYear := Date2DMY(_EndingDate, 3);
        _ExpirationYear := Date2DMY(pExpirationDate, 3);

        if _ContractYear > _ExpirationYear then
            pNextYearStartingDate := _ContractDate

        else begin

            _EndingDate := CalcDate(StrSubstNo('<+%1Y>', _ExpirationYear - _ContractYear), _EndingDate);


            if (_EndingDate + 1) > pExpirationDate then begin
                pNextYearStartingDate := CalcDate('<-1Y>', _EndingDate) + 1;
                pNextYearEndingDate := _EndingDate;
            end else begin
                pNextYearStartingDate := _EndingDate + 1;
                pNextYearEndingDate := CalcDate('<+1Y>', _EndingDate);
            end;

        end;

        //pNextYearEndingDate := CALCDATE('<+1Y>', _EndingDate);
    end;

    local procedure GetCurrContractDate(pContract: Record DK_Contract; pDate: Date): Date
    var
        _ContractDate: Date;
        _EndingDate: Date;
        _ContractYear: Integer;
        _DateYear: Integer;
    begin

        if pContract."Contract Date" = 0D then
            Error(MSG004, pContract.FieldCaption("No."), pContract."No.");

        _ContractDate := pContract."Contract Date";
        _EndingDate := _ContractDate - 1;

        _ContractYear := Date2DMY(_EndingDate, 3);
        _DateYear := Date2DMY(pDate, 3);

        //Contrat Date
        if _ContractYear = _DateYear then
            exit(_ContractDate)
        else
            exit(CalcDate(StrSubstNo('<+%1Y>', _DateYear - _ContractYear), _EndingDate) + 1);
    end;

    local procedure AdminExpensePricePeriod(var pNewLineNo: Integer; pContract: Record DK_Contract; pCemetery: Record DK_Cemetery; pContractStartingDate: Date; pContractEndingDate: Date; pAdminExpenseStartingDate: Date; pAdminExpenseEndingDate: Date; pPriceType: Option; pDocumentNo: Code[20]; pDocumentLineNo: Integer; pNonPayment: Boolean): Decimal
    var
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
        _DailyAdmunt: Decimal;
        _DiffAmount: Decimal;
        _pStartingDate: Date;
        _LoopStartingDate: Date;
        _LoopEndingDate: Date;
        _Loop: Integer;
    begin

        _pStartingDate := GetAdminExpenseDate(pCemetery, pPriceType, pAdminExpenseStartingDate);

        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
        _AdminExpensePrice.SetRange("Price Type", pPriceType);
        _AdminExpensePrice.SetRange("Unit Price Type Code", pCemetery."Unit Price Type Code");
        _AdminExpensePrice.SetRange("Starting Date", _pStartingDate, pAdminExpenseEndingDate);
        if _AdminExpensePrice.FindSet then begin
            _LoopStartingDate := pAdminExpenseStartingDate;
            repeat

                //Starting Date
                if _AdminExpensePrice."Starting Date" > _LoopStartingDate then
                    _LoopStartingDate := _AdminExpensePrice."Starting Date";

                //Ending Date
                _LoopEndingDate := GetNextAdminExpenseDate(pCemetery, pPriceType, _LoopStartingDate);

                if _LoopEndingDate = 0D then
                    _LoopEndingDate := pAdminExpenseEndingDate
                else
                    _LoopEndingDate := _LoopEndingDate - 1;

                if (_LoopEndingDate > pAdminExpenseEndingDate) then
                    _LoopEndingDate := pAdminExpenseEndingDate;

                InsertBuffer(pContract, pNewLineNo, pContractStartingDate, pContractEndingDate, _LoopStartingDate, _LoopEndingDate, _AdminExpensePrice."Unit Price"
                              , pPriceType, pDocumentNo, pDocumentLineNo, pNonPayment);

                //MSG := MSG + STRSUBSTNO('1 %1 : %2 ~ %3, %4 ~ %5 \\ ',_Loop, pContractStartingDate, pContractEndingDate, _LoopStartingDate, _LoopEndingDate);
                _Loop += 1;
            until _AdminExpensePrice.Next = 0;
        end;
    end;

    local procedure InsertBuffer(pContract: Record DK_Contract; var pNewLineNo: Integer; pContractStartingDate: Date; pContractEndingDate: Date; pAdminExpenseStartingDate: Date; pAdminExpenseEndingDate: Date; pAdminExpensePrice: Decimal; pAdminExpenseType: Option; pDocumentNo: Code[20]; pDocumentLineNo: Integer; pNonPayment: Boolean)
    begin

        pContract.CalcFields("Cemetery Size");

        pNewLineNo += 1;

        AdminExpenseBuffer.Init;
        AdminExpenseBuffer."Source No." := pDocumentNo;
        AdminExpenseBuffer."Source Line No." := pDocumentLineNo;
        AdminExpenseBuffer."Admin. Expense Type" := pAdminExpenseType;
        AdminExpenseBuffer."Non-Payment" := pNonPayment;
        //pNonPayment
        AdminExpenseBuffer."Line No." := pNewLineNo;
        AdminExpenseBuffer.Validate("Year Contract Starting Date", pContractStartingDate);
        AdminExpenseBuffer.Validate("Year Contract Ending Date", pContractEndingDate);
        AdminExpenseBuffer.Validate("Admin. Expense Starting Date", pAdminExpenseStartingDate);
        AdminExpenseBuffer.Validate("Admin. Expense Ending Date", pAdminExpenseEndingDate);
        AdminExpenseBuffer."Contract Size" := pContract."Cemetery Size";
        AdminExpenseBuffer.Validate("Year Admin. Expense Price", pAdminExpensePrice);
        AdminExpenseBuffer."Contract Date" := pContract."Contract Date";
        AdminExpenseBuffer."Contract No." := pContract."No.";

        //Ð‹Ó ‰¦…
        AdminExpenseBuffer.CalcAdminExpenseAmount;
        AdminExpenseBuffer.Insert;
    end;


    procedure ResponseAdminExpenseData(var pAdminExpenseBuffer: Record "DK_Admin. Expense Data"; pContractNo: Code[20]; pPriceType: Option; pStartingDate: Date; pEndingDate: Date)
    var
        _Contract: Record DK_Contract;
    begin
        /*
        IF _Contract.GET(pContractNo) THEN
        BEGIN
        
          GetPeriodAdminExpense(_Contract, pPriceType,pStartingDate,pEndingDate);
        
          TempAdminExpenseBuffer.RESET;
          IF TempAdminExpenseBuffer.FINDSET THEN BEGIN
            REPEAT
              pAdminExpenseBuffer.INIT;
              pAdminExpenseBuffer.TRANSFERFIELDS(TempAdminExpenseBuffer);
              pAdminExpenseBuffer.INSERT;
            UNTIL TempAdminExpenseBuffer.NEXT = 0
          END;
        
        
        END;
        */

    end;


    procedure LookupAdminExpenseLowData(pPublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li"; pAdminExpenseType: Option; pNonPayment: Boolean)
    var
        _AdminExpenseData: Page "DK_Admin. Expense Data";
        _AdminExpenseBuffer: Record "DK_Admin. Expense Data";
    begin

        _AdminExpenseBuffer.Reset;
        _AdminExpenseBuffer.SetCurrentKey("Source No.", "Source Line No.", "Admin. Expense Type", "Non-Payment", "Line No.", "Year Contract Starting Date", "Year Contract Ending Date", "Admin. Expense Starting Date", "Admin. Expense Ending Date");
        _AdminExpenseBuffer.SetRange("Source No.", pPublishAdminExpDocLine."Document No.");
        _AdminExpenseBuffer.SetRange("Source Line No.", pPublishAdminExpDocLine."Line No.");
        _AdminExpenseBuffer.SetRange("Admin. Expense Type", pAdminExpenseType);
        _AdminExpenseBuffer.SetRange("Non-Payment", pNonPayment);

        Clear(_AdminExpenseData);
        _AdminExpenseData.LookupMode(true);
        _AdminExpenseData.SetTableView(_AdminExpenseBuffer);
        _AdminExpenseData.SetRecord(_AdminExpenseBuffer);
        //_AdminExpenseData.SetData(pPublishAdminExpDocLine,pPriceType,pStartingDate,pEndingDate);
        _AdminExpenseData.RunModal;
    end;


    procedure GetCalcAdminExpenseEndingDateForAmount(pContractNo: Code[20]; pAdminExpenseType: Option; pAmount: Decimal; var pApplyAmount: Decimal; var pDiffAmount: Decimal; pPaymentDate: Date; pMissingContract: Boolean): Date
    var
        _Contract: Record DK_Contract;
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _CurrNonPayAmount: Decimal;
        _CurrEndingDate: Date;
        _CalcAmount: Decimal;
        _LoopAmount: Decimal;
        _Loop: Integer;
        _LoopDate: Date;
        _Today: Date;
        _EntryRemAmount: Decimal;
    begin
        //ÐŽÊí ‘ˆÏ—Ÿ„’ ýˆ«Š± ‘Ž‡ßŸÀ‡ž “‚ˆ«!
        if pContractNo = '' then Error(MSG006);

        //-------------------------------------------------
        //ÐŽÊ ‰œ‚‚— ˜«ž
        if pPaymentDate <> 0D then
            _Today := pPaymentDate
        else
            _Today := Today;
        //-------------------------------------------------

        _Contract.Reset;
        _Contract.SetCurrentKey("No.");
        _Contract.SetRange("No.", pContractNo);
        _Contract.SetRange("Date Filter", 0D, _Today);
        if _Contract.FindSet then begin

            //‘†µŠž “Œ•
            _Contract.CalcFields("Landscape Architecture", "Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

            if pAdminExpenseType = _AdminExpLedger."Admin. Expense Type"::Landscape then begin
                if not _Contract."Landscape Architecture" then
                    Error(MSG007);

                //>>DK32
                //_CurrEndingDate := _Contract."Land. Arc. Expiration Date";

                if _Contract."Land. Arc. Expiration Date" = 0D then begin
                    if _Contract."Admin. Exp. Start Date" <> 0D then
                        _CurrEndingDate := _Contract."Admin. Exp. Start Date" - 1;
                end else
                    _CurrEndingDate := _Contract."Land. Arc. Expiration Date";
                //<<DK32

                if _Contract."Non-Pay. Land. Arc. Amount" > 0 then
                    _CurrNonPayAmount := _Contract."Non-Pay. Land. Arc. Amount";

            end else begin
                //>>DK32
                //_CurrEndingDate := _Contract."General Expiration Date";

                if _Contract."General Expiration Date" = 0D then begin
                    if _Contract."Admin. Exp. Start Date" <> 0D then
                        _CurrEndingDate := _Contract."Admin. Exp. Start Date" - 1;
                end else
                    _CurrEndingDate := _Contract."General Expiration Date";
                //<<DK32
                if _Contract."Non-Pay. General Amount" > 0 then
                    _CurrNonPayAmount := _Contract."Non-Pay. General Amount";
            end;

            _CalcAmount := pAmount;
            if _CalcAmount <= _CurrNonPayAmount then begin

                _AdminExpLedger.Reset;
                _AdminExpLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date);
                _AdminExpLedger.SetRange("Contract No.", pContractNo);
                _AdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                _AdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                _AdminExpLedger.SetRange(Date, 0D, _Today);
                _AdminExpLedger.SetFilter("Remaining Amount", '<>0');
                if _AdminExpLedger.FindSet then begin
                    repeat
                        _AdminExpLedger.CalcFields("Remaining Amount");
                        _LoopAmount := _AdminExpLedger."Remaining Amount" * -1;

                        if _CalcAmount >= _LoopAmount then begin
                            _CalcAmount -= _LoopAmount;
                            pApplyAmount += _LoopAmount;
                        end else begin
                            pApplyAmount := pAmount - _CalcAmount;
                            pDiffAmount := _CalcAmount;
                            exit(_AdminExpLedger.Date - 1);
                        end;

                    until _AdminExpLedger.Next = 0;

                    pDiffAmount := _CalcAmount;
                    exit(_AdminExpLedger.Date);
                end;

            end else begin
                _LoopDate := _CurrEndingDate;

                if _CurrEndingDate <= _Today then begin
                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                    _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                    _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                    _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                    _DetailAdminExpLedger.SetRange(Date, 0D, _Today);
                    if _DetailAdminExpLedger.FindLast then begin
                        _DetailAdminExpLedger.CalcSums(Amount);
                        _CalcAmount -= _DetailAdminExpLedger.Amount * -1;
                        _LoopDate := _DetailAdminExpLedger.Date;
                    end;
                end;

                Clear(_LoopAmount);

                //‰œ‡í ýˆ«Š± ˜«ž
                while _CalcAmount <> 0 do begin
                    _LoopDate := _LoopDate + 1;

                    if pPaymentDate <> 0D then
                        _LoopAmount := GetContractDailyAdminExpense(_Contract, _LoopDate, pAdminExpenseType, pPaymentDate, false, _EntryRemAmount) * -1
                    else
                        _LoopAmount := GetContractDailyAdminExpense(_Contract, _LoopDate, pAdminExpenseType, 0D, false, _EntryRemAmount) * -1;

                    if _CalcAmount >= _LoopAmount then begin
                        _CalcAmount -= _LoopAmount;
                    end else begin
                        pApplyAmount := pAmount - _CalcAmount;
                        pDiffAmount := _CalcAmount;
                        exit(_LoopDate - 1);
                    end;
                end;

                //>>DK32
                pApplyAmount := pAmount - _CalcAmount;
                pDiffAmount := _CalcAmount;
                //<<DK32
                exit(_LoopDate);
            end;

        end else begin
            Error(MSG006);
        end;
    end;


    procedure GetCalcAdminExpenseAmountForEndingDate(pContractNo: Code[20]; pAdminExpenseType: Option; pFutureEndingDate: Date; pPaymentDate: Date; pMissingContract: Boolean): Decimal
    var
        _Contract: Record DK_Contract;
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _CurrEndingDate: Date;
        _RemAmount: Decimal;
        _LoopDate: Record Date;
        _Today: Date;
        _EntryRemAmount: Decimal;
    begin
        if pContractNo = '' then Error(MSG006);

        if _Contract.Get(pContractNo) then begin

            //-------------------------------------------------
            //ÐŽÊ ‰œ‚‚— ˜«ž
            if pPaymentDate <> 0D then
                _Today := pPaymentDate
            else
                _Today := Today;
            //-------------------------------------------------

            //‘†µŠž “Œ•
            _Contract.CalcFields("Landscape Architecture");
            if pAdminExpenseType = _DetailAdminExpLedger."Admin. Expense Type"::Landscape then begin
                if not _Contract."Landscape Architecture" then
                    Error(MSG007);

                //>>DK32
                //_CurrEndingDate := _Contract."Land. Arc. Expiration Date";

                if _Contract."Land. Arc. Expiration Date" = 0D then begin
                    if _Contract."Admin. Exp. Start Date" <> 0D then
                        _CurrEndingDate := _Contract."Admin. Exp. Start Date" - 1;
                end else
                    _CurrEndingDate := _Contract."Land. Arc. Expiration Date";
                //<<DK32
            end else begin
                //>>DK32
                //_CurrEndingDate := _Contract."General Expiration Date";

                if _Contract."General Expiration Date" = 0D then begin
                    if _Contract."Admin. Exp. Start Date" <> 0D then
                        _CurrEndingDate := _Contract."Admin. Exp. Start Date" - 1;
                end else
                    _CurrEndingDate := _Contract."General Expiration Date";
                //<<DK32
            end;

            if pFutureEndingDate <= _Today then begin

                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                _DetailAdminExpLedger.SetRange(Date, 0D, pFutureEndingDate);
                if _DetailAdminExpLedger.FindSet then begin
                    _DetailAdminExpLedger.CalcSums(Amount);
                    exit(_DetailAdminExpLedger.Amount * -1);
                end;
            end else begin
                Clear(_RemAmount);

                if _CurrEndingDate < _Today then begin
                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                    _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                    _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                    _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                    _DetailAdminExpLedger.SetRange(Date, 0D, _Today);
                    if _DetailAdminExpLedger.FindSet then begin
                        _DetailAdminExpLedger.CalcSums(Amount);
                        _RemAmount := _DetailAdminExpLedger.Amount;
                    end;

                    //‰œ‡í ýˆ«Š± ˜«ž
                    _LoopDate.Reset;
                    _LoopDate.SetCurrentKey("Period Type", "Period Start");
                    _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                    _LoopDate.SetRange("Period Start", _Today + 1, pFutureEndingDate);
                    if _LoopDate.FindSet then begin
                        repeat
                            if pPaymentDate <> 0D then
                                _RemAmount += GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, pPaymentDate, false, _EntryRemAmount)
                            else
                                _RemAmount += GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
                        until _LoopDate.Next = 0;
                    end;

                end else begin

                    //‰œ‡í ýˆ«Š± ˜«ž
                    _LoopDate.Reset;
                    _LoopDate.SetCurrentKey("Period Type", "Period Start");
                    _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                    _LoopDate.SetRange("Period Start", _CurrEndingDate + 1, pFutureEndingDate);
                    if _LoopDate.FindSet then begin
                        repeat
                            if pPaymentDate <> 0D then
                                _RemAmount += GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, pPaymentDate, false, _EntryRemAmount)
                            else
                                _RemAmount += GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
                        until _LoopDate.Next = 0;
                    end;
                end;

                exit(_RemAmount * -1);
            end;
        end else begin
            Error(MSG006);
        end;
    end;


    procedure GetCalcAdminExpenseAmountForPeriod(pContractNo: Code[20]; pAdminExpenseType: Option; pStartDate: Date; pEndDate: Date): Decimal
    var
        _Contract: Record DK_Contract;
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _RemAmount: Decimal;
        _LoopDate: Record Date;
        _CalcTotalAmt: Decimal;
        _Days: Integer;
        "------------------------------": Integer;
        _EntryRemAmount: Decimal;
    begin
        if pContractNo = '' then Error(MSG006);

        if _Contract.Get(pContractNo) then begin

            //‘†µŠž “Œ•

            if pEndDate <= Today then begin

                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                _DetailAdminExpLedger.SetRange(Date, 0D, pEndDate);
                if _DetailAdminExpLedger.FindSet then begin
                    _DetailAdminExpLedger.CalcSums(Amount);
                    exit(_DetailAdminExpLedger.Amount * -1);
                end;
            end else begin
                Clear(_RemAmount);

                if pStartDate < Today then begin
                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                    _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                    _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                    _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                    _DetailAdminExpLedger.SetRange(Date, 0D, Today);
                    if _DetailAdminExpLedger.FindSet then begin
                        _DetailAdminExpLedger.CalcSums(Amount);
                        _RemAmount := _DetailAdminExpLedger.Amount;
                    end;

                    //‰œ‡í ýˆ«Š± ˜«ž
                    _LoopDate.Reset;
                    _LoopDate.SetCurrentKey("Period Type", "Period Start");
                    _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                    _LoopDate.SetRange("Period Start", Today + 1, pEndDate);
                    if _LoopDate.FindSet then begin
                        repeat
                            _Days += 1;
                            _CalcTotalAmt := GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
                            _RemAmount += _CalcTotalAmt;
                        until _LoopDate.Next = 0;
                    end;

                end else begin

                    //‰œ‡í ýˆ«Š± ˜«ž
                    _LoopDate.Reset;
                    _LoopDate.SetCurrentKey("Period Type", "Period Start");
                    _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                    _LoopDate.SetRange("Period Start", pStartDate, pEndDate);
                    if _LoopDate.FindSet then begin
                        repeat
                            _Days += 1;
                            _CalcTotalAmt := GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
                            _RemAmount += _CalcTotalAmt;

                        until _LoopDate.Next = 0;
                    end;
                end;

                exit(_RemAmount * -1);
            end;
        end else begin
            Error(MSG006);
        end;
    end;


    procedure GetCalcAdminExpenseAmountForPeriod2(pContractNo: Code[20]; pAdminExpenseType: Option; pStartDate: Date; pEndDate: Date): Decimal
    var
        _Contract: Record DK_Contract;
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _RemAmount: Decimal;
        _LoopDate: Record Date;
        _CalcTotalAmt: Decimal;
        _Days: Integer;
        "------------------------------": Integer;
        _EntryRemAmount: Decimal;
    begin
        if pContractNo = '' then Error(MSG006);

        if _Contract.Get(pContractNo) then begin

            //‘†µŠž “Œ•

            if pEndDate <= Today then begin

                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                _DetailAdminExpLedger.SetRange(Date, pStartDate, pEndDate);
                if _DetailAdminExpLedger.FindSet then begin
                    _DetailAdminExpLedger.CalcSums(Amount);
                    exit(_DetailAdminExpLedger.Amount * -1);
                end;
            end else begin
                Clear(_RemAmount);

                if pStartDate < Today then begin


                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                    _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
                    _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                    _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                    _DetailAdminExpLedger.SetRange(Date, pStartDate, Today);
                    if _DetailAdminExpLedger.FindSet then begin
                        _DetailAdminExpLedger.CalcSums(Amount);
                        _RemAmount := _DetailAdminExpLedger.Amount;
                    end;

                    pStartDate := Today + 1;

                    //‰œ‡í ýˆ«Š± ˜«ž
                    _LoopDate.Reset;
                    _LoopDate.SetCurrentKey("Period Type", "Period Start");
                    _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                    _LoopDate.SetRange("Period Start", pStartDate, pEndDate);
                    if _LoopDate.FindSet then begin
                        repeat
                            _Days += 1;
                            _CalcTotalAmt := GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
                            _RemAmount += _CalcTotalAmt;
                        until _LoopDate.Next = 0;
                    end;

                end else begin

                    //‰œ‡í ýˆ«Š± ˜«ž
                    _LoopDate.Reset;
                    _LoopDate.SetCurrentKey("Period Type", "Period Start");
                    _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                    _LoopDate.SetRange("Period Start", pStartDate, pEndDate);
                    if _LoopDate.FindSet then begin
                        repeat
                            _Days += 1;
                            _CalcTotalAmt := GetContractDailyAdminExpense(_Contract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
                            _RemAmount += _CalcTotalAmt;

                        until _LoopDate.Next = 0;
                    end;
                end;

                exit(_RemAmount * -1);
            end;
        end else begin
            Error(MSG006);
        end;
    end;


    procedure GetContractDailyAdminExpense(var pContract: Record DK_Contract; pToday: Date; pAdminExpenseType: Option; pPaymentDate: Date; pPosting: Boolean; var pEntryRemAmount: Decimal): Decimal
    var
        _DailyAmount: Decimal;
        _DiffAmount: Decimal;
        _StartingDate: Date;
        _EndingDate: Date;
        _CalcAmount: Decimal;
        _YearAdminExpensePrice: Decimal;
        _YearAdminExpense: Decimal;
        _HikeExemptionDate: Date;
        _BatchDailyAdminExpense: Codeunit "DK_Batch Daily Admin. Expense";
        _CalcEntryRemAmount: Decimal;
    begin
        //ýˆ«Š±

        //ýˆ«Š± ˆÒ‘ª €Ëú Šž
        if (pContract."Man. Fee Exemption Date" = 0D) or (pContract."Man. Fee Exemption Date" < pToday) then begin

            //ýˆ«Š± ž‹Ý »‰ €Ëú Šž
            if (pContract."Man. Fee hike Exemption Date" = 0D) or (pContract."Man. Fee hike Exemption Date" < pToday) then begin
                //—÷Ï „Âí
                if (pPaymentDate = 0D) then
                    _YearAdminExpensePrice := GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pToday)
                else
                    _YearAdminExpensePrice := GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pPaymentDate);
            end else begin
                //ÐŽÊ ŸÀ €Ë‘¹ „Âí
                _YearAdminExpensePrice := GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pContract."Contract Date");
                _HikeExemptionDate := pContract."Man. Fee hike Exemption Date";
            end;

            //Sizeí ÷—¹‘° €¦Ž¸
            _YearAdminExpense := GetYearAdminExpense(pContract."Cemetery Code", _YearAdminExpensePrice);

            //¼ ÐŽÊ€Ëú Ð‹Ó
            GetYearContractPeriod(pContract, pToday, _StartingDate, _EndingDate);

            //Ÿ„Âí
            GetDailyAdminExpense(_StartingDate, _EndingDate, _YearAdminExpense, _DailyAmount, _DiffAmount);

            _CalcAmount := (_DailyAmount * -1);

            //’ðŽ¸“‚ˆ« ŸÀ Šž(ÐŽÊˆ‹Ÿ)
            if _EndingDate = pToday then
                _CalcAmount += (_DiffAmount * -1);

            if pPosting then begin
                _CalcEntryRemAmount := _BatchDailyAdminExpense.GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType, pPosting);
            end else begin
                _CalcAmount -= _BatchDailyAdminExpense.GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType, pPosting);
            end;

            pEntryRemAmount := _CalcEntryRemAmount;

            exit(_CalcAmount);
        end else begin
            exit(0);
        end;
    end;


    procedure CalcDelayInterestAmount(pContract: Record DK_Contract; pPaymentDate: Date; pAdminExpType: Option) RtnAmount: Decimal
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _NonPayAmount: Decimal;
        _FunSetup: Record "DK_Function Setup";
        _Days: Integer;
        _LoopDate: Date;
        _LoopDailyAdminExpAmount: Decimal;
    begin

        //‘÷¼œÀ = (‰œ‚‚ýˆ«Š± í 2) X (‚Ëœ 5% í 365 X ‰œ‚‚ŸŒ÷ )
        //   („Â, 1° ‰œˆˆ— Œ÷ ŸµÕ ‰¦“ˆ —Ÿ ‹Ó‘ñ —©„¾)
        _FunSetup.Get;
        _FunSetup.TestField("Delay Interest Rate");


        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date);
        _AdminExpenseLedger.SetRange("Contract No.", pContract."No.");
        _AdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpType);
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
        _AdminExpenseLedger.SetFilter("Remaining Amount", '<>0');
        // >> DK34
        _AdminExpenseLedger.SetRange(Date, 0D, pPaymentDate);
        // <<
        if _AdminExpenseLedger.FindSet then begin

            _LoopDailyAdminExpAmount := _AdminExpenseLedger.Amount;
            repeat
                _AdminExpenseLedger.CalcFields("Remaining Amount");

                _NonPayAmount += (_AdminExpenseLedger."Remaining Amount" * -1);

                if _LoopDate <> _AdminExpenseLedger.Date then begin
                    _Days += 1;


                    if _Days = 366 then begin
                        RtnAmount += (_NonPayAmount / 2) * (((_FunSetup."Delay Interest Rate" / 100) / 365) * (_Days - 1));
                        _Days := 0;
                    end else begin
                        if _LoopDailyAdminExpAmount <> _AdminExpenseLedger.Amount then begin
                            RtnAmount += (_NonPayAmount / 2) * (((_FunSetup."Delay Interest Rate" / 100) / 365) * (_Days));
                            _Days := 0;
                        end;
                    end;


                end;
                _LoopDailyAdminExpAmount := _AdminExpenseLedger.Amount;
                _LoopDate := _AdminExpenseLedger.Date;

            until _AdminExpenseLedger.Next = 0;

            if _Days <> 0 then
                RtnAmount += (_NonPayAmount / 2) * (((_FunSetup."Delay Interest Rate" / 100) / 365) * _Days);
        end else begin
            exit(0);
        end;

        exit(Round(RtnAmount, 1, '='));
    end;


    procedure MessageDelayInterestAmount(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _DelayInterestAmount_Gen: Decimal;
        _DelayInterestAmount_Lan: Decimal;
        _DelayInterestAmount: Decimal;
        _Period_Gen: Integer;
        _Period_Lan: Integer;
    begin

        if _Contract.Get(pContractNo) then begin

            if (_Contract."General Expiration Date" <= Today) and
               (_Contract."General Expiration Date" <> 0D) then begin
                _DelayInterestAmount_Gen := CalcDelayInterestAmount(_Contract, Today, 0);

                _Period_Gen := Today - _Contract."General Expiration Date";
            end;
            _Contract.CalcFields("Landscape Architecture");
            if _Contract."Landscape Architecture" then
                if (_Contract."Land. Arc. Expiration Date" <= Today) and
                    (_Contract."Land. Arc. Expiration Date" <> 0D) then begin
                    _DelayInterestAmount_Lan := CalcDelayInterestAmount(_Contract, Today, 0);

                    _Period_Lan := Today - _Contract."General Expiration Date";
                end;


            Message(MSG010, _Period_Gen,
                            _DelayInterestAmount_Gen,
                            _Period_Lan,
                            _DelayInterestAmount_Lan);
        end;
    end;


    procedure GetCalcFuturePreiodExpAmt(pContract: Record DK_Contract; pAdminExpType: Option; pStartDate: Date; pEndDate: Date) RtnAmount: Decimal
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _ExpirationDate: Date;
        _YearStartDate: Date;
        _YearEndDate: Date;
        _LoopDate: Record Date;
        _LoopYear: Record Date;
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
        _PriceStartDate: Date;
        _Price: Decimal;
        _TempAdminExpenseData: Record "DK_Admin. Expense Data";
        _EntryNo: Integer;
    begin

        pContract.CalcFields("Landscape Architecture", "Unit Price Type Code", "Cemetery Size");

        if pAdminExpType = _AdminExpLedger."Admin. Expense Type"::Landscape then begin
            if not pContract."Landscape Architecture" then
                exit(0);

            _ExpirationDate := pContract."Land. Arc. Expiration Date";
        end else begin
            _ExpirationDate := pContract."General Expiration Date";
        end;

        if pStartDate <= _ExpirationDate then begin
            RtnAmount := GetSumAdminExpLedger(pContract."No.", pAdminExpType, pStartDate, _ExpirationDate);
            pStartDate := _ExpirationDate + 1;

        end else
            if pStartDate <= Today then begin
                RtnAmount := GetSumAdminExpLedger(pContract."No.", pAdminExpType, pStartDate, Today);
                pStartDate := Today + 1;
            end;

        RtnAmount += GetPeriodAdminExpense(pContract, pAdminExpType, pStartDate, pEndDate, '', 0, false);




        exit(RtnAmount);
    end;

    local procedure GetSumAdminExpLedger(pContractNo: Code[20]; pAdminExpType: Option; pStartDate: Date; pEndDate: Date): Decimal
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
    begin

        _AdminExpLedger.Reset;
        _AdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type");
        _AdminExpLedger.SetRange("Contract No.", pContractNo);
        _AdminExpLedger.SetRange(Date, pStartDate, pEndDate);
        _AdminExpLedger.SetRange("Admin. Expense Type", pAdminExpType);
        _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
        _AdminExpLedger.SetFilter("Remaining Amount", '<>0');
        if _AdminExpLedger.FindSet then begin
            _AdminExpLedger.CalcSums(Amount);
            exit(_AdminExpLedger.Amount * -1);
        end;

        exit(0);
    end;


    procedure GetMaxExpirationDate(pContract: Record DK_Contract; pAdminExpenseType: Option): Date
    var
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
    begin
        //>>DK32
        _PaymentReceiptDocLine.Reset;
        _PaymentReceiptDocLine.SetCurrentKey("Expiration Date");
        _PaymentReceiptDocLine.SetRange("Document Type", _PaymentReceiptDocLine."Document Type"::Receipt);
        _PaymentReceiptDocLine.SetRange("Contract No.", pContract."No.");
        _PaymentReceiptDocLine.SetRange(Refund, false);
        if pAdminExpenseType = _AdminExpLedger."Admin. Expense Type"::General then
            _PaymentReceiptDocLine.SetRange("Payment Target", _PaymentReceiptDocLine."Payment Target"::General)
        else
            _PaymentReceiptDocLine.SetRange("Payment Target", _PaymentReceiptDocLine."Payment Target"::Landscape);

        if _PaymentReceiptDocLine.FindLast then
            exit(_PaymentReceiptDocLine."Expiration Date");


        exit(0D);

        //<<DK32
    end;


    procedure CreatePaymentReceiptOnDailyAdminExpenseLedger(pContract: Record DK_Contract; pStartDate: Date; pAdminExpType: Option): Date
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin

        //>>DK32

        //ÐŽÊ€¦ Ÿ‚‚ˆ‡ž ýˆ«Š±°Îœ ‰È‹²—© µÕ
        _AdminExpLedger.Reset;
        _AdminExpLedger.SetCurrentKey(Date);
        _AdminExpLedger.SetRange("Contract No.", pContract."No.");
        _AdminExpLedger.SetRange("Admin. Expense Type", pAdminExpType);
        _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
        if _AdminExpLedger.FindSet then begin
            _PayReceiptDocLine.Reset;
            _PayReceiptDocLine.SetRange("Document Type", _PayReceiptDocLine."Document Type"::Receipt);
            _PayReceiptDocLine.SetRange("Document No.", _AdminExpLedger."Source No.");
            _PayReceiptDocLine.SetRange("Line No.", _AdminExpLedger."Source Line No.");
            _PayReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PayReceiptDocLine."Payment Target"::General,
                                                                _PayReceiptDocLine."Payment Target"::Landscape);
            if not _PayReceiptDocLine.FindSet then begin
                pStartDate := AddAdminExpense(pContract,
                                      pAdminExpType,
                                      _AdminExpLedger.Amount,
                                      _AdminExpLedger."Source No.",
                                      _AdminExpLedger."Source Line No.",
                                      _AdminExpLedger.Date,
                                      0D,
                                      _AdminExpLedger."Low Balance",
                                      pStartDate);
            end;
        end;

        //ýˆ«Š±°Îí „Ô—© ýˆ«Š± ¯€¦ ‰«Œ¡í ‘ˆÏ—Ÿ„’ µÕ

        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetCurrentKey("Payment Date", "Document No.");
        _PayReceiptDoc.SetRange("Document Type", _PayReceiptDoc."Document Type"::Receipt);
        _PayReceiptDoc.SetRange("Contract No.", pContract."No.");
        _PayReceiptDoc.SetRange(Refund, false);
        _PayReceiptDoc.SetRange(Posted, true);
        if pAdminExpType = _AdminExpLedger."Admin. Expense Type"::General then
            _PayReceiptDoc.SetFilter("Line General Amount", '<>0')
        else
            _PayReceiptDoc.SetFilter("Line Land. Arc. Amount", '<>0');
        if _PayReceiptDoc.FindSet then begin
            repeat

                _PayReceiptDocLine.Reset;
                _PayReceiptDocLine.SetRange("Document No.", _PayReceiptDoc."Document No.");
                if pAdminExpType = _AdminExpLedger."Admin. Expense Type"::General then
                    _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::General)
                else
                    _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::Landscape);
                if _PayReceiptDocLine.FindSet then begin
                    //================================================================
                    if _PayReceiptDocLine."Diff. Amount" >= 0 then begin
                        pStartDate := AddAdminExpense(pContract,
                                        pAdminExpType,
                                        _PayReceiptDocLine.Amount,
                                        _PayReceiptDocLine."Document No.",
                                        _PayReceiptDocLine."Line No.",
                                        _PayReceiptDoc."Payment Date",
                                        0D,
                                        false,
                                        pStartDate);
                    end else begin
                        pStartDate := AddAdminExpense(pContract,
                                        pAdminExpType,
                                        _PayReceiptDocLine."Period Amount",
                                        _PayReceiptDocLine."Document No.",
                                        _PayReceiptDocLine."Line No.",
                                        _PayReceiptDoc."Payment Date",
                                        0D,
                                        false,
                                        pStartDate);

                        if _PayReceiptDocLine."Diff. Amount" <> 0 then begin
                            pStartDate := AddAdminExpense(pContract,
                                            pAdminExpType,
                                            Abs(_PayReceiptDocLine."Diff. Amount"),
                                            _PayReceiptDocLine."Document No.",
                                            _PayReceiptDocLine."Line No.",
                                            _PayReceiptDoc."Payment Date",
                                            0D,
                                            true,
                                            pStartDate);
                        end;
                    end;

                    //================================================================
                end;
            until _PayReceiptDoc.Next = 0;

        end;

        exit(pStartDate);
        //<<DK32
    end;
}

