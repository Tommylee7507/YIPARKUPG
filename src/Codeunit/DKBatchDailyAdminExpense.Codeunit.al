codeunit 50014 "DK_Batch Daily Admin. Expense"
{
    // //ýˆ«Š± Apply €Ë„™ ‘ˆÏ
    // *DK32 : 20200715
    //   - Modify Function : OnRun
    //                       BatchContract
    //   - Add Function : BatchCreateAdminExpenseLedgerforReceipt
    //                    CreateAdminExpenseLedger


    trigger OnRun()
    begin

        BatchCreateAdminExpenseLedgerforReceipt(Today, '');//DK32
        FindContract(Today, '');
    end;

    var
        Window: Dialog;
        MSG001: Label 'Processing Genral Contract  @1@@@@@@@@@@\';
        MSG002: Label 'Processing Group Contract  @2@@@@@@@@@@\';
        MSG003: Label 'Processing Group Sub Contract  @3@@@@@@@@@@\';
        MSG004: Label 'Contract No. #2##########\';
        MSG005: Label 'Date #2##########';
        AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        MSG006: Label 'Today''s Daily Admin. Expense Scheduler was Run.';


    procedure FindContract(pToday: Date; pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _CommFun: Codeunit "DK_Common Function";
    begin

        if pToday = 0D then exit;
        /*
        IF GUIALLOWED THEN
          Window.OPEN(
            MSG001 +
            MSG002 +
            MSG003 +
            MSG004 +
            MSG005);
        */
        //Ÿ‰¦ÐŽÊ
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::General);
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then
            BatchContract(_Contract, pToday, 1)
        else begin
            //  IF GUIALLOWED THEN
            //    Window.UPDATE(1,ROUND(1 * 10000 / 1,1));
        end;

        //€¸‡ÕÐŽÊ ‘È €¸‡Õ “‹€ˆ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Group);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then
            BatchContract(_Contract, pToday, 2)
        else begin
            // IF GUIALLOWED THEN
            //   Window.UPDATE(2,ROUND(1 * 10000 / 1,1));
        end;

        //€¸‡Õ —ŸŠž ÐŽÊ ‘È Ÿ‰¦ “‹€ˆ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Sub);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then
            BatchContract(_Contract, pToday, 3)
        else begin
            // IF GUIALLOWED THEN
            //  Window.UPDATE(3,ROUND(1 * 10000 / 1,1));
        end;

        //IF GUIALLOWED THEN
        //  Window.CLOSE;

        if pContractNo = '' then begin
            Clear(_CommFun);
            _CommFun.UpdateJobQueueHistoty(0, MSG006);
        end;

    end;

    local procedure BatchContract(var pContract: Record DK_Contract; pToday: Date; pDialogIdx: Integer)
    var
        _LoopDate: Record Date;
        _LoopStartingDate: Date;
        _Loop: Integer;
        _MaxLoop: Integer;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _LastDailyBatchRunDate: Date;
        _SkipBatchRun: Boolean;
    begin
        //ÐŽÊ

        pContract.SetFilter(Status, '%1|%2', pContract.Status::FullPayment, pContract.Status::Revocation);
        pContract.SetFilter("Contract Date", '<>%1&<=%2', 0D, pToday);
        //pContract.SETFILTER("Last Daily Batch Run Date", '<%1', pToday);
        pContract.SetFilter("Revocation Date", '=%1|>=%2', 0D, pToday);
        if pContract.FindSet then begin
            _MaxLoop := pContract.Count;
            repeat
                _Loop += 1;
                _SkipBatchRun := false; //DK32

                //IF GUIALLOWED THEN BEGIN
                //  Window.UPDATE(pDialogIdx,ROUND(_Loop * 10000 / _MaxLoop,1));
                //  Window.UPDATE(4,pContract."No.");
                //END;

                //>>DK32
                pContract.CalcFields("Admin. Expense Method", "First Corpse Exists");
                case pContract."Admin. Expense Method" of
                    pContract."Admin. Expense Method"::"After Corpse 10":
                        begin
                            if (not pContract."First Corpse Exists") then
                                if pContract."Admin. Exp. Start Date" > pToday then
                                    _SkipBatchRun := true;
                        end;
                end;

                //<<DK32
                if not _SkipBatchRun then begin //DK32
                    pContract.CalcFields("Last Daily Batch Run Date", "Last Daily Batch Run Date 2", "Landscape Architecture");

                    if pContract."Last Daily Batch Run Date" <> 0D then begin
                        _LastDailyBatchRunDate := pContract."Last Daily Batch Run Date";

                        if (pContract."General Expiration Date" = pContract."Last Daily Batch Run Date") then
                            _LastDailyBatchRunDate := pContract."General Expiration Date" + 1;
                    end;

                    if pContract."Landscape Architecture" then
                        if (pContract."Last Daily Batch Run Date 2" <> 0D) and (pContract."Last Daily Batch Run Date 2" < _LastDailyBatchRunDate) then begin
                            _LastDailyBatchRunDate := pContract."Last Daily Batch Run Date 2";

                            if (pContract."Land. Arc. Expiration Date" = pContract."Last Daily Batch Run Date 2") then
                                _LastDailyBatchRunDate := pContract."Land. Arc. Expiration Date" + 1;
                        end;

                    if _LastDailyBatchRunDate = 0D then begin
                        if pContract."Contract Date" <= 20181231D then //System Openning Date
                            _LoopStartingDate := 20190101D
                        else
                            _LoopStartingDate := pContract."Contract Date";
                    end else
                        _LoopStartingDate := _LastDailyBatchRunDate;


                    if _LoopStartingDate <= pToday then begin
                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _LoopStartingDate, pToday);
                        if _LoopDate.FindSet then begin
                            repeat
                                //IF GUIALLOWED THEN
                                //  Window.UPDATE(5, _LoopDate."Period Start");

                                if pContract."Last Daily Batch Run Date" <= _LoopDate."Period Start" then
                                    ContractDailyAdminExpense(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::General);

                                if pContract."Landscape Architecture" then begin
                                    if pContract."Last Daily Batch Run Date 2" <= _LoopDate."Period Start" then
                                        ContractDailyAdminExpense(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::Landscape);
                                end;
                            until _LoopDate.Next = 0;

                            Commit;
                        end;
                    end;
                    //==========================================================================================
                    //®“ ‘´Œ«“‚ˆ«!
                    //Apply Entry
                    Clear(_ApplyAdminExLedger);
                    _ApplyAdminExLedger.FindReceiptLedger(pContract."No.", pContract."Admin. Exp. Type Filter"::General, pToday);
                    if pContract."Landscape Architecture" then
                        _ApplyAdminExLedger.FindReceiptLedger(pContract."No.", pContract."Admin. Exp. Type Filter"::Landscape, pToday);
                    //==========================================================================================
                end;//DK32
            until pContract.Next = 0;
        end;
    end;

    local procedure ContractDailyAdminExpense(var pContract: Record DK_Contract; pToday: Date; pAdminExpenseType: Option)
    var
        _DailyAmount: Decimal;
        _DiffAmount: Decimal;
        _StartingDate: Date;
        _EndingDate: Date;
        _CalcAmount: Decimal;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _YearAdminExpensePrice: Decimal;
        _YearAdminExpense: Decimal;
        _HikeExemptionDate: Date;
    begin
        //ýˆ«Š±
        Clear(_AdminExpenseMgt);

        //ýˆ«Š± ˆÒ‘ª €Ëú Šž
        if (pContract."Man. Fee Exemption Date" = 0D) or (pContract."Man. Fee Exemption Date" < pToday) then begin

            //ýˆ«Š± ž‹Ý »‰ €Ëú Šž
            if (pContract."Man. Fee hike Exemption Date" = 0D) or (pContract."Man. Fee hike Exemption Date" < pToday) then begin
                //—÷Ï „Âí
                _YearAdminExpensePrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pToday);
            end else begin
                //ÐŽÊ ŸÀ €Ë‘¹ „Âí
                _YearAdminExpensePrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pContract."Contract Date");
                _HikeExemptionDate := pContract."Man. Fee hike Exemption Date";
            end;

            //Sizeí ÷—¹‘° €¦Ž¸
            _YearAdminExpense := _AdminExpenseMgt.GetYearAdminExpense(pContract."Cemetery Code", _YearAdminExpensePrice);


            //¼ ÐŽÊ€Ëú Ð‹Ó
            _AdminExpenseMgt.GetYearContractPeriod(pContract, pToday, _StartingDate, _EndingDate);

            //Ÿ„Âí
            _AdminExpenseMgt.GetDailyAdminExpense(_StartingDate, _EndingDate, _YearAdminExpense, _DailyAmount, _DiffAmount);

            _CalcAmount := (_DailyAmount * -1);

            //’ðŽ¸“‚ˆ« ŸÀ Šž(ÐŽÊˆ‹Ÿ)
            if _EndingDate = pToday then
                _CalcAmount += (_DiffAmount * -1);

            _CalcAmount := _CalcAmount - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType, true);
            if _CalcAmount <> 0 then
                InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, false, _HikeExemptionDate);
        end else begin
            //ýˆ«Š± ˆÒ‘ª €Ëúí —¹„Ï—Ÿ‰—‡ž €¦Ž¸ (0)ˆ‡ž “‚ˆ«
            _CalcAmount := 0 - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType, true);
            InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, true, 0D);
        end;
    end;

    local procedure InsertAdminExpenseLedger(pContractNo: Code[20]; pDate: Date; pAdminExpType: Option; pAmount: Decimal; pExemptTarget: Boolean; pHikeExemptionDate: Date)
    begin

        AdminExpenseLedger.Init;
        AdminExpenseLedger."Contract No." := pContractNo;
        AdminExpenseLedger.Date := pDate;
        AdminExpenseLedger."Line No." := AdminExpenseLedger.GetNewLineNo(pContractNo, pDate);
        AdminExpenseLedger."Admin. Expense Type" := pAdminExpType;
        AdminExpenseLedger."Ledger Type" := AdminExpenseLedger."Ledger Type"::Daily;
        AdminExpenseLedger.Amount := pAmount;

        AdminExpenseLedger.Validate("Exempt Target", pExemptTarget);
        AdminExpenseLedger.Validate("Man. Fee hike Exemption Date", pHikeExemptionDate);
        AdminExpenseLedger.Open := true;
        AdminExpenseLedger.Insert(true);
    end;


    procedure GetAdminExpenseAmount(pContractNo: Code[20]; pDate: Date; pAdminExpType: Option; pReceiptPosting: Boolean): Decimal
    begin

        AdminExpenseLedger.Reset;
        AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        AdminExpenseLedger.SetRange(Date, pDate);
        AdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpType);
        AdminExpenseLedger.SetRange("Ledger Type", AdminExpenseLedger."Ledger Type"::Daily);
        if not pReceiptPosting then
            AdminExpenseLedger.SetFilter("Source No.", '<>%1', '');
        if AdminExpenseLedger.FindSet then begin
            AdminExpenseLedger.CalcSums(Amount);
            exit(AdminExpenseLedger.Amount);
        end;
    end;


    procedure FindContract2(pToday: Date; pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
    begin

        if pToday = 0D then exit;

        if GuiAllowed then
            Window.Open(
              MSG001 +
              MSG002 +
              MSG003 +
              MSG004 +
              MSG005);

        //Ÿ‰¦ÐŽÊ
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::General);
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then
            BatchContract2(_Contract, pToday, 1)
        else begin
            if GuiAllowed then
                Window.Update(1, Round(1 * 10000 / 1, 1));
        end;

        //€¸‡ÕÐŽÊ ‘È €¸‡Õ “‹€ˆ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Group);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then
            BatchContract2(_Contract, pToday, 2)
        else begin
            if GuiAllowed then
                Window.Update(2, Round(1 * 10000 / 1, 1));
        end;

        //€¸‡Õ —ŸŠž ÐŽÊ ‘È Ÿ‰¦ “‹€ˆ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Sub);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then
            BatchContract2(_Contract, pToday, 3)
        else begin
            if GuiAllowed then
                Window.Update(3, Round(1 * 10000 / 1, 1));
        end;

        if GuiAllowed then
            Window.Close;
    end;

    local procedure BatchContract2(var pContract: Record DK_Contract; pToday: Date; pDialogIdx: Integer)
    var
        _LoopDate: Record Date;
        _LoopStartingDate: Date;
        _Loop: Integer;
        _MaxLoop: Integer;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _startingDate: Date;
        _Temp_Money: Record Temp_Money;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _FilterDate: Date;
    begin
        //ÐŽÊ

        pContract.SetFilter(Status, '%1|%2', pContract.Status::FullPayment, pContract.Status::Revocation);
        pContract.SetFilter("Contract Date", '<>%1&<=%2', 0D, pToday);
        pContract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);
        pContract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);
        if pContract.FindSet then begin
            _MaxLoop := pContract.Count;
            repeat
                _Loop += 1;

                if GuiAllowed then begin
                    Window.Update(pDialogIdx, Round(_Loop * 10000 / _MaxLoop, 1));
                    Window.Update(4, pContract."No.");
                end;

                pContract.CalcFields("Last Daily Batch Run Date");

                //IF pContract."Last Daily Batch Run Date" = 0D THEN BEGIN
                if pContract."Contract Date" <= 20181231D then //System Openning Date
                    _LoopStartingDate := 20190101D
                else
                    _LoopStartingDate := pContract."Contract Date";
                //END ELSE
                //  _LoopStartingDate := pContract."Last Daily Batch Run Date"+1;

                Clear(_startingDate);

                _AdminExpenseLedger.Reset;
                _AdminExpenseLedger.SetCurrentKey("Contract No.", Date, "Line No.");
                _AdminExpenseLedger.SetRange("Contract No.", pContract."No.");
                _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::General);
                _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
                if _AdminExpenseLedger.FindFirst then
                    _FilterDate := _AdminExpenseLedger.Date
                else
                    _FilterDate := pContract."General Expiration Date";

                _LoopDate.Reset;
                _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                _LoopDate.SetRange("Period Start", _LoopStartingDate, _FilterDate);
                if _LoopDate.FindSet then begin
                    repeat
                        if GuiAllowed then
                            Window.Update(5, _LoopDate."Period Start");

                        _PayReceiptDocLine.Reset;
                        _PayReceiptDocLine.SetRange(contractNo, pContract."No.");
                        _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::General);
                        _PayReceiptDocLine.SetFilter("Start Date", '<=%1', _LoopDate."Period Start");
                        _PayReceiptDocLine.SetFilter("Expiration Date", '>=%1', _LoopDate."Period Start");
                        if _PayReceiptDocLine.FindSet then
                            _startingDate := _PayReceiptDocLine.PaymentDate;

                        if _startingDate = 0D then begin
                            if _LoopDate."Period Start" > pContract."General Start Date" then
                                _startingDate := pContract."General Start Date"
                            else
                                _startingDate := CalcDate('<-5Y>', pContract."General Start Date");
                        end;
                        //ERROR('%1 %2', _LoopDate."Period Start", _startingDate);
                        ContractDailyAdminExpense2(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::General, _startingDate);

                    until _LoopDate.Next = 0;
                end;
                //==========================================================================================

                _AdminExpenseLedger.Reset;
                _AdminExpenseLedger.SetCurrentKey("Contract No.", Date, "Line No.");
                _AdminExpenseLedger.SetRange("Contract No.", pContract."No.");
                _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::Landscape);
                _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
                if _AdminExpenseLedger.FindFirst then
                    _FilterDate := _AdminExpenseLedger.Date
                else
                    _FilterDate := pContract."Land. Arc. Expiration Date";

                _LoopDate.Reset;
                _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                _LoopDate.SetRange("Period Start", _LoopStartingDate, pContract."Land. Arc. Expiration Date");
                if _LoopDate.FindSet then begin
                    repeat
                        if GuiAllowed then
                            Window.Update(5, _LoopDate."Period Start");


                        _PayReceiptDocLine.Reset;
                        _PayReceiptDocLine.SetRange(contractNo, pContract."No.");
                        _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::Landscape);
                        _PayReceiptDocLine.SetFilter("Start Date", '<=%1', _LoopDate."Period Start");
                        _PayReceiptDocLine.SetFilter("Expiration Date", '>=%1', _LoopDate."Period Start");
                        if _PayReceiptDocLine.FindSet then
                            _startingDate := _PayReceiptDocLine.PaymentDate;


                        if _startingDate = 0D then begin
                            if _LoopDate."Period Start" > pContract."Land. Arc. Start Date" then
                                _startingDate := pContract."Land. Arc. Start Date"
                            else
                                _startingDate := CalcDate('<-5Y>', pContract."Land. Arc. Start Date");
                        end;

                        ContractDailyAdminExpense2(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::Landscape, _startingDate);

                    until _LoopDate.Next = 0;
                end;
                //==========================================================================================
                //Apply Entry

                Commit;

                Clear(_ApplyAdminExLedger);
                _ApplyAdminExLedger.FindReceiptLedger(pContract."No.", pContract."Admin. Exp. Type Filter"::General, pToday);
                if pContract."Landscape Architecture" then
                    _ApplyAdminExLedger.FindReceiptLedger(pContract."No.", pContract."Admin. Exp. Type Filter"::Landscape, pToday);

                //==========================================================================================
                pContract."Last Daily Batch Run Date" := 20190701D;
                pContract.Modify;
            until pContract.Next = 0;
        end;
    end;

    local procedure ContractDailyAdminExpense2(var pContract: Record DK_Contract; pToday: Date; pAdminExpenseType: Option; pStringDate: Date)
    var
        _DailyAmount: Decimal;
        _DiffAmount: Decimal;
        _StartingDate: Date;
        _EndingDate: Date;
        _CalcAmount: Decimal;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _YearAdminExpensePrice: Decimal;
        _YearAdminExpense: Decimal;
        _HikeExemptionDate: Date;
    begin
        //ýˆ«Š±
        Clear(_AdminExpenseMgt);

        //ýˆ«Š± ˆÒ‘ª €Ëú Šž
        if (pContract."Man. Fee Exemption Date" = 0D) or (pContract."Man. Fee Exemption Date" < pToday) then begin

            //ýˆ«Š± ž‹Ý »‰ €Ëú Šž
            if (pContract."Man. Fee hike Exemption Date" = 0D) or (pContract."Man. Fee hike Exemption Date" < pToday) then begin
                //—÷Ï „Âí
                _YearAdminExpensePrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pStringDate);
            end else begin
                //ÐŽÊ ŸÀ €Ë‘¹ „Âí
                _YearAdminExpensePrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pContract."Contract Date");
                _HikeExemptionDate := pContract."Man. Fee hike Exemption Date";
            end;

            //Sizeí ÷—¹‘° €¦Ž¸
            _YearAdminExpense := _AdminExpenseMgt.GetYearAdminExpense(pContract."Cemetery Code", _YearAdminExpensePrice);

            //¼ ÐŽÊ€Ëú Ð‹Ó

            _AdminExpenseMgt.GetYearContractPeriod(pContract, pToday, _StartingDate, _EndingDate);

            //Ÿ„Âí
            _AdminExpenseMgt.GetDailyAdminExpense(_StartingDate, _EndingDate, _YearAdminExpense, _DailyAmount, _DiffAmount);

            _CalcAmount := (_DailyAmount * -1);

            //’ðŽ¸“‚ˆ« ŸÀ Šž(ÐŽÊˆ‹Ÿ)
            if _EndingDate = pToday then
                _CalcAmount += (_DiffAmount * -1);

            _CalcAmount := _CalcAmount - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType, true);
            if _CalcAmount <> 0 then
                InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, false, _HikeExemptionDate);
        end else begin
            //ýˆ«Š± ˆÒ‘ª €Ëúí —¹„Ï—Ÿ‰—‡ž €¦Ž¸ (0)ˆ‡ž “‚ˆ«
            _CalcAmount := 0 - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType, true);
            InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, true, 0D);
        end;
    end;


    procedure DelAdminExpenseLedger(pContract: Record DK_Contract)
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
    begin
        //DK32
        //‹ÝŒŒ ýˆ«Š± €ËÎ

        _DetailAdminExpLedger.Reset;
        _DetailAdminExpLedger.SetCurrentKey("Contract No.", "Ledger Type");
        _DetailAdminExpLedger.SetRange("Contract No.", pContract."No.");
        _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
        if _DetailAdminExpLedger.FindSet then
            _DetailAdminExpLedger.DeleteAll(false);

        //‹ÝŒŒ øÔ…˜ ‰«Œ¡
        _DetailAdminExpLedger.Reset;
        _DetailAdminExpLedger.SetCurrentKey("Contract No.", "Ledger Type");
        _DetailAdminExpLedger.SetRange("Contract No.", pContract."No.");
        _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Receipt);
        _DetailAdminExpLedger.SetRange(Applied, true);
        if _DetailAdminExpLedger.FindSet then
            _DetailAdminExpLedger.DeleteAll(false);


        //ýˆ«Š± €ËÎ
        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", "Ledger Type");
        _AdminExpenseLedger.SetRange("Contract No.", pContract."No.");
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
        if _AdminExpenseLedger.FindSet then
            _AdminExpenseLedger.DeleteAll(false);
    end;


    procedure BatchCreateAdminExpenseLedgerforReceipt(pToday: Date; pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        //>>DK32
        if pToday = 0D then exit;

        //“´“šŠŽ˜Àí ‰È‹²—© ÐŽÊ(ýˆ«Š± ¯€¦ À‡ß ‘ˆÏ);
        _Contract.Reset;
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        _Contract.SetFilter("Admin. Expense Method", '<>%1', _Contract."Admin. Expense Method"::Contract);
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("First Corpse Exists", true);
        _Contract.SetRange("Daily Admin. Exp. Ledger Exis.", false);
        _Contract.SetRange("Receipt Admin. Exp. Led. Exis.", true);
        if _Contract.FindSet then begin
            repeat
                //¯€¦ …Ñœ• Ÿ Š¨—­
                CreateAdminExpenseLedger(_Contract);
                //ýˆ«Š± ‘Ž‡ßŸÀ CRM Žð…Ñœ–«
                _CRMDataInterlink.OutboundContract(_Contract);
            until _Contract.Next = 0;
        end;

        //“´“šŠŽ˜À Ž°œ ýˆ«Š± ‰È‹² “ÁŸœ ……‡í—© ÐŽÊ(ýˆ«Š± ¯€¦ À‡ß ‘ˆÏ);
        _Contract.Reset;
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        _Contract.SetRange("Admin. Exp. Start Date", 20190101D, pToday);//×‘ñ¬ 190101D
        _Contract.SetFilter("Admin. Expense Method", '<>%1', _Contract."Admin. Expense Method"::Contract);
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("First Corpse Exists", false);
        _Contract.SetRange("Daily Admin. Exp. Ledger Exis.", false);
        _Contract.SetRange("Receipt Admin. Exp. Led. Exis.", true);
        if _Contract.FindSet then begin
            repeat
                //¯€¦ …Ñœ• Ÿ Š¨—­
                CreateAdminExpenseLedger(_Contract);
                //ýˆ«Š± ‘Ž‡ßŸÀ CRM Žð…Ñœ–«
                _CRMDataInterlink.OutboundContract(_Contract);
            until _Contract.Next = 0;
        end;

        Commit;
        //<<DK32
    end;

    local procedure CreateAdminExpenseLedger(var pContract: Record DK_Contract)
    var
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin
        //>>DK32
        pContract."General Expiration Date" := _AdminExpenseMgt.CreatePaymentReceiptOnDailyAdminExpenseLedger(pContract, 0D, _AdminExpenseLedger."Admin. Expense Type"::General);

        if pContract."Landscape Architecture" then
            pContract."Land. Arc. Expiration Date" := _AdminExpenseMgt.CreatePaymentReceiptOnDailyAdminExpenseLedger(pContract, 0D, _AdminExpenseLedger."Admin. Expense Type"::Landscape)
        else
            pContract."Land. Arc. Expiration Date" := 0D;

        pContract.Modify;
        //<<DK32
    end;
}

