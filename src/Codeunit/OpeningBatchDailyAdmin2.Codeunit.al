codeunit 50108 "Opening Batch Daily Admin2"
{
    // //ýˆ«Š± Apply €Ë„™ ‘ˆÏ


    trigger OnRun()
    var
        _Contract: Record DK_Contract;
    begin

        ChangeContractExpirationDate('20190228002', 20240228D, 1);

        //—‘„¸ Ÿ‰¦ýˆ«Š± ŒŒ–«
        //€Ë‘ˆ ýˆ«Š± €ËÎ,ýˆ«Š± ‹ÝŒŒ €ËÎ ‹Ð‘ª —šÍ
        //FindRemainingContract_Gen('CD0008829');
        //FindPaymentReceiptApply('CD0008829',TODAY);

        //—‘„¸ ‘†µýˆ«Š± ŒŒ–«
        //€Ë‘ˆ ýˆ«Š± €ËÎ,ýˆ«Š± ‹ÝŒŒ €ËÎ ‹Ð‘ª —šÍ
        //FindRemainingContract_Lan('20161117002');
        //FindPaymentReceiptApply('20161117002',TODAY);

        /*
        FindRemainingContract_Lan('20170926004');
        
        FindPaymentReceiptApply('20170926004',TODAY);
        */
        /*
        FindRemainingContract_Gen('20170926009');
        FindRemainingContract_Gen('20180528005');
        FindRemainingContract_Gen('20180615003');
        FindRemainingContract_Gen('20181018003');
        FindRemainingContract_Gen('20181018004');
        */
        /*
        FindPaymentReceiptApply('20170926009',TODAY);
        FindPaymentReceiptApply('20180528005',TODAY);
        FindPaymentReceiptApply('20180615003',TODAY);
        FindPaymentReceiptApply('20181018003',TODAY);
        FindPaymentReceiptApply('20181018004',TODAY);
        */

        /*
        FindRemainingContract_Gen('20170926009');
        FindRemainingContract_Gen('20180528005');
        FindRemainingContract_Gen('20180615003');
        FindRemainingContract_Gen('20181018003');
        
        */






        //FindPaymentReceiptApply('20190926002',200327D);
        /*
        FindPaymentReceiptApply('20190816001',200327D);
        FindPaymentReceiptApply('20190420003',200327D);
        FindPaymentReceiptApply('20190122001',200327D);
        FindPaymentReceiptApply('20181019002',200327D);
        FindPaymentReceiptApply('20181018004',200327D);
        FindPaymentReceiptApply('20181018003',200327D);
        FindPaymentReceiptApply('20181017002',200327D);
        FindPaymentReceiptApply('20180830001',200327D);
        FindPaymentReceiptApply('20180615003',200327D);
        FindPaymentReceiptApply('20180528005',200327D);
        FindPaymentReceiptApply('20180426003',200327D);
        FindPaymentReceiptApply('20180308004',200327D);
        FindPaymentReceiptApply('20171202001',200327D);
        FindPaymentReceiptApply('20171113003',200327D);
        FindPaymentReceiptApply('20170926009',200327D);
        FindPaymentReceiptApply('20170926007',200327D);
        FindPaymentReceiptApply('20170926004',200327D);
        */

        //1.–»œ ”™œŠ —¹ŽÊ—(Ÿ‡ß)
        /*
        _Contract.RESET;
        _Contract.SETRANGE("Cemetery No.", 'í5-0320');
        IF _Contract.FINDSET THEN
           BatchContract3(_Contract, 121103D,1);
        */

        //–»œ ”™œŠ —¹ŽÊ—!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        //2. ‰œ‚‚— “‚ˆ«(Ÿ‡ß)
        //2019-01 01œ˜” “ñŠž •‘¿“‚ˆ« —…… œ –ð—¯
        //FindContract(TODAY,'CD0031818');


        //3.0° ¯€¦— ýˆ«Š± °Î ¯€¦ …Ñœ• ‹²ŒŠ
        //FindPaymentReceiptZero('');

        //4.0° ¯€¦— ýˆ«Š± °Îí „Ô—© øÔ €ËÎ
        //FindPaymentReceiptZeroApply('');

        //5. ß‘ªŸ œý ýˆ«Š± “ÁŸÀ(‰œ‚‚—)
        //FindPaymentReceiptNonPayment('');

        //6. ß‘ªŸ œ˜” ýˆ«“ “ÁŸ—(Œ€‚‚—)
        //FindPaymentReceiptPayment('');

        //7. 2019-01-01œý ¯€¦ †—„’ Œ€‚‚€¦í „Ô—© ýˆ«Š± ‹²ŒŠ(Ÿ‰¦ýˆ«Š±)--…Á‘È
        //FindRemainingContract_Gen('');

        //FindRemainingContract_Gen('20190925005');

        /*
        FindRemainingContract_Gen('20161227002');
        FindRemainingContract_Gen('20180420003');
        FindRemainingContract_Gen('20160622002');
        FindRemainingContract_Gen('20160622001');
        FindRemainingContract_Gen('20171106001');
        FindRemainingContract_Gen('20180814004');
        FindRemainingContract_Gen('20180307001');
        FindRemainingContract_Gen('20190528004');
        FindRemainingContract_Gen('20180522001');
        FindRemainingContract_Gen('20170902001');
        FindRemainingContract_Gen('20170902002');
        FindRemainingContract_Gen('20180829001');
        FindRemainingContract_Gen('CD0030614');
        FindRemainingContract_Gen('20160229003');
        FindRemainingContract_Gen('20161226003');
        FindRemainingContract_Gen('20180325001');
        FindRemainingContract_Gen('20170617004');
        */

        //8. 2019-01-01œý ¯€¦ †—„’ Œ€‚‚€¦í „Ô—© ýˆ«Š± ‹²ŒŠ(‘†µýˆ«Š±)------------------…ÁŸ‡ß
        //FindRemainingContract_Lan('20140107003');

        //9. ýˆ«Š± øÔ
        //FindPaymentReceiptApply('',191001D);

        //FindPaymentReceiptApply('20190925005',191122D);
        /*
        FindPaymentReceiptApply('20180420003',191022D);
        FindPaymentReceiptApply('20160622002',191022D);
        FindPaymentReceiptApply('20160622001',191022D);
        FindPaymentReceiptApply('20171106001',191022D);
        FindPaymentReceiptApply('20180814004',191022D);
        FindPaymentReceiptApply('20180307001',191022D);
        FindPaymentReceiptApply('20190528004',191022D);
        FindPaymentReceiptApply('20180522001',191022D);
        FindPaymentReceiptApply('20170902001',191022D);
        FindPaymentReceiptApply('20170902002',191022D);
        FindPaymentReceiptApply('20180829001',191022D);
        FindPaymentReceiptApply('CD0030614',191022D);
        FindPaymentReceiptApply('20160229003',191022D);
        FindPaymentReceiptApply('20161226003',191022D);
        FindPaymentReceiptApply('20180325001',191022D);
        FindPaymentReceiptApply('20170617004',191022D);
        */


        Message('Complate');

        //¯€¦— “‚ˆ«!
        //FindPaymentReceipt

    end;

    var
        Window: Dialog;
        MSG001: Label 'Processing Genral Contract  @1@@@@@@@@@@\';
        MSG002: Label 'Processing Group Contract  @2@@@@@@@@@@\';
        MSG003: Label 'Processing Group Sub Contract  @3@@@@@@@@@@\';
        MSG004: Label 'Contract No. #2##########\';
        MSG005: Label 'Date #2##########';
        AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        sTODAY: Date;


    procedure FindContract(pToday: Date; pContractNo: Code[20])
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
            BatchContract(_Contract, pToday, 1)
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
            BatchContract(_Contract, pToday, 2)
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
            BatchContract(_Contract, pToday, 3)
        else begin
            if GuiAllowed then
                Window.Update(3, Round(1 * 10000 / 1, 1));
        end;

        if GuiAllowed then
            Window.Close;
    end;

    local procedure BatchContract(var pContract: Record DK_Contract; pToday: Date; pDialogIdx: Integer)
    var
        _LoopDate: Record Date;
        _LoopStartingDate: Date;
        _Loop: Integer;
        _MaxLoop: Integer;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _Today2: Date;
    begin
        //ÐŽÊ

        pContract.SetFilter(Status, '%1|%2', pContract.Status::FullPayment, pContract.Status::Revocation);
        pContract.SetFilter("Contract Date", '<>%1&<=%2', 0D, pToday);
        //pContract.SETFILTER("Last Daily Batch Run Date", '<%1', pToday);
        pContract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);
        pContract.SetRange("Date Filter", 0D, pToday);

        if pContract.FindSet then begin
            _MaxLoop := pContract.Count;
            repeat
                _Loop += 1;
                pContract.CalcFields("Non-Pay. General Amount");

                if ((pContract."General Expiration Date" <> 0D) and (pContract."General Expiration Date" <= pToday)) or
                   ((pContract."Land. Arc. Expiration Date" <> 0D) and (pContract."Land. Arc. Expiration Date" <= pToday)) then begin

                    pContract.CalcFields("Last Daily Batch Run Date", "Landscape Architecture");

                    if pContract."Non-Pay. General Amount" = 0 then begin
                        if GuiAllowed then begin
                            Window.Update(pDialogIdx, Round(_Loop * 10000 / _MaxLoop, 1));
                            Window.Update(4, pContract."No.");
                        end;

                        if pContract."Last Daily Batch Run Date" <> 0D then begin
                            _LoopStartingDate := pContract."Last Daily Batch Run Date";
                        end else begin
                            _LoopStartingDate := pContract."General Expiration Date";

                            case pContract."Cemetery No." of
                                'í3-0266-1':
                                    begin
                                        _LoopStartingDate := 19830825D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í6-0027':
                                    begin
                                        _LoopStartingDate := 19830908D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '€‰˜¡-0012':
                                    begin
                                        _LoopStartingDate := 19880508D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '€‰˜¡-0013':
                                    begin
                                        _LoopStartingDate := 19880508D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»1-0052':
                                    begin
                                        _LoopStartingDate := 19920324D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»1-0027':
                                    begin
                                        _LoopStartingDate := 19961001D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»1-0028':
                                    begin
                                        _LoopStartingDate := 19961001D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í6-0178':
                                    begin
                                        _LoopStartingDate := 20060529D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '69-2-0156':
                                    begin
                                        _LoopStartingDate := 20090821D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í5-0320':
                                    begin
                                        _LoopStartingDate := 20120727D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í7-0205':
                                    begin
                                        _LoopStartingDate := 20121019D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '63-7-0571':
                                    begin
                                        _LoopStartingDate := 20141220D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»1-0331':
                                    begin
                                        _LoopStartingDate := 20150620D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»1-0445':
                                    begin
                                        _LoopStartingDate := 20150626D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'ˆ×„Ï-0603':
                                    begin
                                        _LoopStartingDate := 20160301D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '69-2-0276':
                                    begin
                                        _LoopStartingDate := 20160415D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '69-2-0277':
                                    begin
                                        _LoopStartingDate := 20160415D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í1-0020-1':
                                    begin
                                        _LoopStartingDate := 20160620D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í5-0821-1':
                                    begin
                                        _LoopStartingDate := 20161023D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í8-0865':
                                    begin
                                        _LoopStartingDate := 20170502D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»1-0216':
                                    begin
                                        _LoopStartingDate := 20170531D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í1-0443':
                                    begin
                                        _LoopStartingDate := 20171019D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '–»„¾-0003':
                                    begin
                                        _LoopStartingDate := 20181011D;
                                        _LoopStartingDate -= 1;
                                    end;
                                'í8-0825':
                                    begin
                                        _LoopStartingDate := 20190119D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '63-6-0983':
                                    begin
                                        _LoopStartingDate := 20190122D;
                                        _LoopStartingDate -= 1;
                                    end;
                                '66-0095':
                                    begin
                                        _LoopStartingDate := 20190416D;
                                        _LoopStartingDate -= 1;
                                    end;
                            end;
                        end;

                        _LoopStartingDate += 1;

                        if ((pContract."Revocation Date" <> 0D) and (pContract."Revocation Date" < pToday)) then
                            _Today2 := pContract."Revocation Date"
                        else
                            _Today2 := pToday;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _LoopStartingDate, _Today2);
                        if _LoopDate.FindSet then begin
                            repeat
                                if GuiAllowed then
                                    Window.Update(5, _LoopDate."Period Start");

                                //IF pContract."General Expiration Date" < _LoopDate."Period Start" THEN
                                if pContract."General Expiration Date" <> 0D then
                                    ContractDailyAdminExpense(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::General);
                            until _LoopDate.Next = 0;
                        end;

                    end;

                    //‘†µŠ± ‰œ‚‚Š¨
                    if (pContract."Landscape Architecture") and (pContract."Non-Pay. Land. Arc. Amount" = 0) then begin
                        if GuiAllowed then begin
                            Window.Update(pDialogIdx, Round(_Loop * 10000 / _MaxLoop, 1));
                            Window.Update(4, pContract."No.");
                        end;

                        if pContract."Last Daily Batch Run Date" <> 0D then begin
                            _LoopStartingDate := pContract."Last Daily Batch Run Date";
                        end else begin
                            if pContract."Landscape Architecture" then begin
                                if pContract."General Expiration Date" < pContract."Land. Arc. Expiration Date" then
                                    _LoopStartingDate := pContract."General Expiration Date"
                                else
                                    _LoopStartingDate := pContract."Land. Arc. Expiration Date";
                            end else begin
                                _LoopStartingDate := pContract."General Expiration Date";
                            end;
                        end;

                        _LoopStartingDate += 1;

                        if ((pContract."Revocation Date" <> 0D) and (pContract."Revocation Date" < pToday)) then
                            _Today2 := pContract."Revocation Date"
                        else
                            _Today2 := pToday;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _LoopStartingDate, _Today2);
                        if _LoopDate.FindSet then begin
                            repeat
                                if GuiAllowed then
                                    Window.Update(5, _LoopDate."Period Start");

                                if pContract."Land. Arc. Expiration Date" <> 0D then
                                    ContractDailyAdminExpense(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::Landscape);
                            until _LoopDate.Next = 0;
                        end;
                    end;
                end;
            until pContract.Next = 0;
        end;
    end;

    local procedure BatchContract3(var pContract: Record DK_Contract; pToday: Date; pDialogIdx: Integer)
    var
        _LoopDate: Record Date;
        _LoopStartingDate: Date;
        _Loop: Integer;
        _MaxLoop: Integer;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
    begin
        //ÐŽÊ
        //‰ª¬‰°˜ú –»œ”™œŠ—!!!!!!!!!!!!!!!!!
        //í5-0320
        //—¹ŽÊ—ž…Ñ 2019-01-01œ˜” ýˆ«Š± ‘ñ‹Ó ‘°—Ê 20120727 ~ 20121103
        if pContract.FindSet then begin
            _MaxLoop := pContract.Count;
            repeat
                _Loop += 1;


                pContract.CalcFields("Last Daily Batch Run Date", "Landscape Architecture");

                if pContract."Last Daily Batch Run Date" <> 0D then begin
                    _LoopStartingDate := pContract."Last Daily Batch Run Date";
                end else begin
                    if pContract."Landscape Architecture" then begin
                        if pContract."General Expiration Date" < pContract."Land. Arc. Expiration Date" then
                            _LoopStartingDate := pContract."General Expiration Date"
                        else
                            _LoopStartingDate := pContract."Land. Arc. Expiration Date";
                    end else begin
                        //'í5-0320':
                        _LoopStartingDate := 20120727D;
                        _LoopStartingDate -= 1;

                    end;
                end;

                _LoopStartingDate += 1;

                _LoopDate.Reset;
                _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                _LoopDate.SetRange("Period Start", _LoopStartingDate, pToday);
                if _LoopDate.FindSet then begin
                    repeat

                        //IF pContract."General Expiration Date" < _LoopDate."Period Start" THEN
                        //IF pContract."General Expiration Date" <> 0D THEN
                        ContractDailyAdminExpense(pContract, _LoopDate."Period Start", pContract."Admin. Exp. Type Filter"::General);

                    until _LoopDate.Next = 0;
                end;
            until pContract.Next = 0;
        end;
    end;

    local procedure ContractDailyAdminExpense(var pContract: Record DK_Contract; pToday: Date; pAdminExpenseType: Option): Decimal
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
        _TotalAmount: Decimal;
    begin
        //ýˆ«Š±
        Clear(_AdminExpenseMgt);

        //ýˆ«Š± ˆÒ‘ª €Ëú Šž
        if (pContract."Man. Fee Exemption Date" = 0D) or (pContract."Man. Fee Exemption Date" < pToday) then begin

            //ýˆ«Š± ž‹Ý »‰ €Ëú Šž
            //IF (pContract."Man. Fee hike Exemption Date" = 0D) OR (pContract."Man. Fee hike Exemption Date" < pToday) THEN BEGIN
            //—÷Ï „Âí
            _YearAdminExpensePrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pContract."Cemetery Code", pAdminExpenseType, pToday);

            //END ELSE BEGIN
            //ÐŽÊ ŸÀ €Ë‘¹ „Âí
            //    _YearAdminExpensePrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pContract."Cemetery Code",pAdminExpenseType, pContract."Contract Date");
            //    _HikeExemptionDate := pContract."Man. Fee hike Exemption Date";
            //END;

            //Sizeí ÷—¹‘° €¦Ž¸
            _YearAdminExpense := _AdminExpenseMgt.GetYearAdminExpense(pContract."Cemetery Code", _YearAdminExpensePrice);

            //¼ ÐŽÊ€Ëú Ð‹Ó
            _AdminExpenseMgt.GetYearContractPeriod(pContract, pToday, _StartingDate, _EndingDate);

            //Ÿ„Âí
            _AdminExpenseMgt.GetDailyAdminExpense(_StartingDate, _EndingDate, _YearAdminExpense, _DailyAmount, _DiffAmount);

            _CalcAmount := (_DailyAmount * -1);

            //’ðŽ¸“‚ˆ« ŸÀ Šž(ÐŽÊˆ‹Ÿ)
            if _EndingDate = pToday then
                _CalcAmount += (_DiffAmount * -1);

            _CalcAmount := _CalcAmount - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType);
            //IF _CalcAmount <> 0 THEN BEGIN
            InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, false, _HikeExemptionDate);
            //END;

            exit(_CalcAmount);
        end else begin
            //ýˆ«Š± ˆÒ‘ª €Ëúí —¹„Ï—Ÿ‰—‡ž €¦Ž¸ (0)ˆ‡ž “‚ˆ«
            _CalcAmount := 0 - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType);
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
        AdminExpenseLedger.Insert(true);
    end;

    local procedure GetAdminExpenseAmount(pContractNo: Code[20]; pDate: Date; pAdminExpType: Option): Decimal
    begin

        AdminExpenseLedger.Reset;
        AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        AdminExpenseLedger.SetRange(Date, pDate);
        AdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpType);
        AdminExpenseLedger.SetRange("Ledger Type", AdminExpenseLedger."Ledger Type"::Daily);
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
        if _Contract.FindSet then begin
            //‰œ‚‚—“‚ˆ«
            if ((_Contract."General Expiration Date" <> 0D) and (_Contract."General Expiration Date" <= sTODAY)) or
               ((_Contract."Land. Arc. Expiration Date" <> 0D) and (_Contract."Land. Arc. Expiration Date" <= sTODAY)) then
                BatchContract2(_Contract, pToday, 1)
        end else begin
            if GuiAllowed then
                Window.Update(1, Round(1 * 10000 / 1, 1));
        end;

        //€¸‡ÕÐŽÊ ‘È €¸‡Õ “‹€ˆ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Group);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then begin
            //‰œ‚‚—“‚ˆ«
            if ((_Contract."General Expiration Date" <> 0D) and (_Contract."General Expiration Date" <= sTODAY)) or
               ((_Contract."Land. Arc. Expiration Date" <> 0D) and (_Contract."Land. Arc. Expiration Date" <= sTODAY)) then
                BatchContract2(_Contract, pToday, 2)
        end else begin
            if GuiAllowed then
                Window.Update(2, Round(1 * 10000 / 1, 1));
        end;

        //€¸‡Õ —ŸŠž ÐŽÊ ‘È Ÿ‰¦ “‹€ˆ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Sub);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then begin
            //‰œ‚‚—“‚ˆ«
            if ((_Contract."General Expiration Date" <> 0D) and (_Contract."General Expiration Date" <= sTODAY)) or
               ((_Contract."Land. Arc. Expiration Date" <> 0D) and (_Contract."Land. Arc. Expiration Date" <= sTODAY)) then
                BatchContract2(_Contract, pToday, 3)
        end else begin
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
        if pContract.FindSet then begin
            _MaxLoop := pContract.Count;
            //  REPEAT
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
            /*
            COMMIT;

            CLEAR(_ApplyAdminExLedger);
            _ApplyAdminExLedger.FindReceiptLedger(pContract."No.",pContract."Admin. Exp. Type Filter"::General,pToday);
            IF pContract."Landscape Architecture" THEN
                _ApplyAdminExLedger.FindReceiptLedger(pContract."No.",pContract."Admin. Exp. Type Filter"::Landscape,pToday);
                */
            //==========================================================================================
            pContract."Last Daily Batch Run Date" := 20190701D;
            pContract.Modify;
            //  UNTIL pContract.NEXT = 0;
        end;

    end;

    local procedure ContractDailyAdminExpense2(var pContract: Record DK_Contract; pToday: Date; pAdminExpenseType: Option; pStringDate: Date): Decimal
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

        //ýˆ«Š± ˆÒ‘ª €Ëú Šž
        if (pContract."Man. Fee Exemption Date" = 0D) or (pContract."Man. Fee Exemption Date" < pToday) then begin

            //ýˆ«Š± ž‹Ý »‰ €Ëú Šž
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

            //’ðŽ¸“‚ˆ« ŸÀ Šž(ÐŽÊˆ‹Ÿ)
            if _EndingDate = pToday then
                _CalcAmount += (_DiffAmount * -1);

            _CalcAmount := _CalcAmount - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType);
            if _CalcAmount <> 0 then
                InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, false, _HikeExemptionDate);
            exit(_CalcAmount);
        end else begin
            //ýˆ«Š± ˆÒ‘ª €Ëúí —¹„Ï—Ÿ‰—‡ž €¦Ž¸ (0)ˆ‡ž “‚ˆ«
            _CalcAmount := 0 - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType);
            InsertAdminExpenseLedger(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, true, 0D);
        end;
    end;

    local procedure FindPaymentReceipt()
    var
        PayRecDoc: Record "DK_Payment Receipt Document";
    begin

        PayRecDoc.Reset;
        PayRecDoc.SetFilter("Payment Date", '>=%1', 20190101D);
        PayRecDoc.SetRange(Correction, false);
        PayRecDoc.SetFilter(Amount, '<>%1', 0);
        PayRecDoc.FilterGroup(-1);
        PayRecDoc.SetFilter("Line General Amount", '<>%1', 0);
        PayRecDoc.SetFilter("Line Land. Arc. Amount", '<>%1', 0);
        if PayRecDoc.FindSet then begin
            repeat
                PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                if (PayRecDoc."Line General Amount" <> 0) or (PayRecDoc."Line Land. Arc. Amount" <> 0) then begin

                end;
            until PayRecDoc.Next = 0;
        end;
    end;

    local procedure FindPaymentReceiptZero(pContractNo: Code[20])
    var
        PayRecDoc: Record "DK_Payment Receipt Document";
    begin

        PayRecDoc.Reset;
        PayRecDoc.SetFilter("Payment Date", '>=%1', 20190101D);
        PayRecDoc.SetRange(Correction, false);
        PayRecDoc.SetRange(Amount, 0);
        PayRecDoc.SetRange("Final Amount", 0);
        PayRecDoc.SetRange(Litigation, true);
        if pContractNo <> '' then
            PayRecDoc.SetRange("Contract No.", pContractNo);
        if PayRecDoc.FindSet then begin
            repeat
                PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");
                PayRecDoc.CalcFields("Line General Start Date", "Line General Expiration Date");
                PayRecDoc.CalcFields("Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date");

                if PayRecDoc."Line General Start Date" <> 0D then begin
                    InsertLedgerZero(PayRecDoc, 0, PayRecDoc."Line General Start Date", PayRecDoc."Line General Expiration Date");
                end;

                if PayRecDoc."Line Land. Arc. Start Date" <> 0D then begin
                    InsertLedgerZero(PayRecDoc, 0, PayRecDoc."Line Land. Arc. Start Date", PayRecDoc."Line Land. Arc. Exp. Date");
                end;
            until PayRecDoc.Next = 0;
        end;
    end;

    local procedure InsertLedgerZero(var pRec: Record "DK_Payment Receipt Document"; pAdminExpenseType: Option; pStartDate: Date; pEndDate: Date)
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _NewLineNo: Integer;
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Amount: Decimal;
        _AdminExpLedger2: Record "DK_Admin. Expense Ledger";
    begin

        if _NewLineNo = 0 then
            _NewLineNo := _AdminExpLedger.GetNewLineNo(pRec."Contract No.", pRec."Payment Date")
        else
            _NewLineNo += 1;

        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
        if _PayRecDocLine.FindSet then begin

            _AdminExpLedger2.Reset;
            _AdminExpLedger2.SetRange("Contract No.", pRec."Contract No.");
            _AdminExpLedger2.SetRange(Date, pStartDate, pEndDate);
            _AdminExpLedger2.SetRange("Admin. Expense Type", pAdminExpenseType);
            _AdminExpLedger2.SetRange("Ledger Type", _AdminExpLedger2."Ledger Type"::Daily);
            if _AdminExpLedger2.FindSet then begin
                _AdminExpLedger2.CalcSums(Amount);
                _Amount := _AdminExpLedger2.Amount * -1;

                _AdminExpLedger2.ModifyAll("Source No.", _PayRecDocLine."Document No.", false);
                _AdminExpLedger2.ModifyAll("Source Line No.", _PayRecDocLine."Line No.", false);


                _AdminExpLedger.Init;
                _AdminExpLedger.Validate("Contract No.", pRec."Contract No.");
                _AdminExpLedger.Validate(Date, pRec."Payment Date");
                _AdminExpLedger."Line No." := _NewLineNo;
                _AdminExpLedger.Validate("Admin. Expense Type", pAdminExpenseType);
                _AdminExpLedger.Validate("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
                _AdminExpLedger.Validate("Payment Type", pRec."Payment Type");
                _AdminExpLedger.Validate(Amount, _Amount);
                _AdminExpLedger.Validate("Source No.", pRec."Document No.");
                _AdminExpLedger.Validate("Source Line No.", _PayRecDocLine."Line No.");
                _AdminExpLedger.Validate("First Contract", false);
                _AdminExpLedger.Validate("Add. Period", false);

                _AdminExpLedger.Insert(true);

                _PayRecDocLine.Amount := _Amount;
                _PayRecDocLine.Modify;

                pRec."Debt Relief Amount" := _Amount;
                pRec."Final Amount" := _Amount;
                pRec.Modify;
            end;
        end;
    end;

    local procedure FindPaymentReceiptZeroApply(pContractNo: Code[20])
    var
        PayRecDoc: Record "DK_Payment Receipt Document";
        _Contract: Record DK_Contract;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin

        Window.Open('Processing  #1##############');

        PayRecDoc.Reset;
        PayRecDoc.SetFilter("Payment Date", '>=%1', 20190101D);
        PayRecDoc.SetRange(Correction, false);
        PayRecDoc.SetRange(Amount, 0);
        PayRecDoc.SetRange(Litigation, true);
        if pContractNo <> '' then
            PayRecDoc.SetRange("Contract No.", pContractNo);
        if PayRecDoc.FindSet then begin
            _MaxLoop := PayRecDoc.Count;
            repeat

                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                if _Contract.Get(PayRecDoc."Contract No.") then
                    _ApplyAdminExLedger.FindReceiptLedger(_Contract."No.", _Contract."Admin. Exp. Type Filter"::General, sTODAY);
            until PayRecDoc.Next = 0;
        end;

        Window.Close;
    end;

    local procedure FindPaymentReceiptNonPayment(pContractNo: Code[20])
    var
        PayRecDoc: Record "DK_Payment Receipt Document";
        _Contract: Record DK_Contract;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
        _LoopDate: Record Date;
        _TotAmount1: Decimal;
        _TotAmount2: Decimal;
        _SourceNo: Code[20];
        _SourceLineNo: Integer;
        _PaymentDate: Date;
        _EndDate: Date;
    begin
        //2019-01-01œ˜” ¯€¦ —
        //ß‘ªŸÀ œý ýˆ«Š±“ÁŸ— : ‰œ‚‚—í „Ô—© ¯€¦í —¹„Ï ( ‰œ‚‚Š „ÏŸ ýˆ«Š± „Âí‡ž “‚ˆ«…—ŽØŽÈ—¯)
        Window.Open('Processing  #1##############');

        PayRecDoc.Reset;
        PayRecDoc.SetFilter("Payment Date", '>=%1', 20190101D);
        PayRecDoc.SetRange(Correction, false);
        PayRecDoc.SetFilter(Amount, '<>%1', 0);
        PayRecDoc.SetRange(Litigation, false);
        //PayRecDoc.SETFILTER("Cemetery No.", '<>%1&<>%2','–»1-0207','–»1-0208');
        if pContractNo <> '' then
            PayRecDoc.SetRange("Contract No.", pContractNo);
        //PRD0100635a
        if PayRecDoc.FindSet then begin
            _MaxLoop := PayRecDoc.Count;
            repeat
                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                Clear(_TotAmount1);
                Clear(_TotAmount2);

                _SourceNo := PayRecDoc."Document No.";
                _SourceLineNo := 1;

                PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");
                PayRecDoc.CalcFields("Line General Start Date", "Line General Expiration Date");
                PayRecDoc.CalcFields("Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date");

                if _Contract.Get(PayRecDoc."Contract No.") then begin
                    if PayRecDoc."Line General Start Date" <> 0D then begin
                        if PayRecDoc."Line General Start Date" < PayRecDoc."Payment Date" then begin

                            if _Contract."Revocation Date" <> 0D then
                                _EndDate := _Contract."Revocation Date"
                            else
                                _EndDate := PayRecDoc."Line General Expiration Date";

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", PayRecDoc."Line General Start Date", _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat

                                    if _LoopDate."Period Start" < PayRecDoc."Payment Date" then
                                        _PaymentDate := _LoopDate."Period Start"
                                    else
                                        _PaymentDate := PayRecDoc."Payment Date";

                                    _TotAmount1 += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, _PaymentDate,
                                                    _SourceNo, _SourceLineNo);
                                until _LoopDate.Next = 0;
                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount1 * -1), false, _Contract."No.", PayRecDoc."Payment Date");//Ÿ‰¦ýˆ«Š±
                            end;

                        end;
                    end;

                    if PayRecDoc."Line Land. Arc. Start Date" <> 0D then begin
                        if PayRecDoc."Line Land. Arc. Start Date" < PayRecDoc."Payment Date" then begin

                            if _Contract."Revocation Date" <> 0D then
                                _EndDate := _Contract."Revocation Date"
                            else
                                _EndDate := PayRecDoc."Line Land. Arc. Exp. Date";

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", PayRecDoc."Line Land. Arc. Start Date", _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat

                                    if _LoopDate."Period Start" < PayRecDoc."Payment Date" then
                                        _PaymentDate := _LoopDate."Period Start"
                                    else
                                        _PaymentDate := PayRecDoc."Payment Date";

                                    _TotAmount2 += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, _PaymentDate,
                                                    _SourceNo, _SourceLineNo);
                                until _LoopDate.Next = 0;

                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount2 * -1), false, _Contract."No.", PayRecDoc."Payment Date");//‘†µ
                            end;
                        end;
                    end;
                end;
            until PayRecDoc.Next = 0;
        end;

        Window.Close;
    end;

    local procedure InsertLedgerPayment(var pRec: Record "DK_Payment Receipt Document"; pAdminExpenseType: Option; pTotalAmount: Decimal; pStartDate: Date; pEndDate: Date)
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _NewLineNo: Integer;
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Amount: Decimal;
        _AdminExpLedger2: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
    begin

        if _NewLineNo = 0 then
            _NewLineNo := _AdminExpLedger.GetNewLineNo(pRec."Contract No.", pRec."Payment Date")
        else
            _NewLineNo += 1;

        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
        if _PayRecDocLine.FindSet then begin

            _AdminExpLedger2.Reset;
            _AdminExpLedger2.SetRange("Contract No.", pRec."Contract No.");
            _AdminExpLedger2.SetRange(Date, pStartDate, pEndDate);
            _AdminExpLedger2.SetRange("Admin. Expense Type", pAdminExpenseType);
            _AdminExpLedger2.SetRange("Ledger Type", _AdminExpLedger2."Ledger Type"::Daily);
            if _AdminExpLedger2.FindSet then begin

                if pRec."Payment Date" <= pStartDate then begin
                    _AdminExpLedger2.ModifyAll("Source No.", _PayRecDocLine."Document No.", false);
                    _AdminExpLedger2.ModifyAll("Source Line No.", _PayRecDocLine."Line No.", false);
                end;

                _AdminExpLedger.Init;
                _AdminExpLedger.Validate("Contract No.", pRec."Contract No.");
                _AdminExpLedger.Validate(Date, pRec."Payment Date");
                _AdminExpLedger."Line No." := _NewLineNo;
                _AdminExpLedger.Validate("Admin. Expense Type", pAdminExpenseType);
                _AdminExpLedger.Validate("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
                _AdminExpLedger.Validate("Payment Type", pRec."Payment Type");
                _AdminExpLedger.Validate(Amount, pTotalAmount);
                _AdminExpLedger.Validate("Source No.", pRec."Document No.");
                _AdminExpLedger.Validate("Source Line No.", _PayRecDocLine."Line No.");
                _AdminExpLedger.Validate("First Contract", false);
                _AdminExpLedger.Validate("Add. Period", false);

                _AdminExpLedger.Insert(true);

            end;

            if pRec."Payment Date" <= pStartDate then begin
                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetRange("Contract No.", pRec."Contract No.");
                _DetailAdminExpLedger.SetRange(Date, pStartDate, pEndDate);
                _DetailAdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
                _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                if _DetailAdminExpLedger.FindSet then begin

                    _DetailAdminExpLedger.ModifyAll("Source No.", _PayRecDocLine."Document No.", false);
                    _DetailAdminExpLedger.ModifyAll("Source Line No.", _PayRecDocLine."Line No.", false);
                end;
            end;
        end;
    end;

    local procedure FindPaymentReceiptPayment(pContractNo: Code[20])
    var
        PayRecDoc: Record "DK_Payment Receipt Document";
        _Contract: Record DK_Contract;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
        _LoopDate: Record Date;
        _TotAmount1: Decimal;
        _TotAmount2: Decimal;
        _SourceNo: Code[20];
        _SourceLineNo: Integer;
        _EndDate: Date;
    begin
        //2019-01-01œ˜” ¯€¦ —
        //ß‘ªŸÀ œ˜” ýˆ«Š±“ÁŸ— : Œ€‚‚—í —¹„Ï (ß‘ªŸÀ— ýˆ«Š± „Âí‡ž €Ëú‚‹ €¦Ž¸œ Ð‹Ó…—ŽØŽÈ—¯!)
        Window.Open('Processing  #1##############');

        PayRecDoc.Reset;
        PayRecDoc.SetFilter("Payment Date", '>=%1', 20190101D);
        PayRecDoc.SetRange(Correction, false);
        PayRecDoc.SetFilter(Amount, '<>%1', 0);
        PayRecDoc.SetRange(Litigation, false);
        if pContractNo <> '' then
            PayRecDoc.SetRange("Contract No.", pContractNo);
        if PayRecDoc.FindSet then begin
            _MaxLoop := PayRecDoc.Count;
            repeat

                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                Clear(_TotAmount1);
                Clear(_TotAmount2);

                PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");
                PayRecDoc.CalcFields("Line General Start Date", "Line General Expiration Date");
                PayRecDoc.CalcFields("Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date");

                _SourceNo := PayRecDoc."Document No.";
                _SourceLineNo := 1;

                Clear(_EndDate);
                if _Contract.Get(PayRecDoc."Contract No.") then begin
                    if PayRecDoc."Line General Start Date" <> 0D then begin
                        if PayRecDoc."Line General Start Date" >= PayRecDoc."Payment Date" then begin

                            if _Contract."Revocation Date" <> 0D then
                                _EndDate := _Contract."Revocation Date"
                            else
                                _EndDate := PayRecDoc."Line General Expiration Date";

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", PayRecDoc."Line General Start Date", _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat
                                    _TotAmount1 += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, PayRecDoc."Payment Date",
                                                    _SourceNo, _SourceLineNo);
                                until _LoopDate.Next = 0;

                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount1 * -1), false, _Contract."No.", PayRecDoc."Payment Date");//Ÿ‰¦ýˆ«Š±
                            end;

                        end;
                    end;

                    if PayRecDoc."Line Land. Arc. Start Date" <> 0D then begin
                        if PayRecDoc."Line Land. Arc. Start Date" >= PayRecDoc."Payment Date" then begin

                            if _Contract."Revocation Date" <> 0D then
                                _EndDate := _Contract."Revocation Date"
                            else
                                _EndDate := PayRecDoc."Line Land. Arc. Exp. Date";

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", PayRecDoc."Line Land. Arc. Start Date", _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat
                                    _TotAmount2 += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, PayRecDoc."Payment Date",
                                                    _SourceNo, _SourceLineNo);
                                until _LoopDate.Next = 0;

                                //InsertAdminExpenseLedger(_Contract, 1,(_TotAmount2*-1), PayRecDoc."Line Land. Arc. Start Date", PayRecDoc."Line Land. Arc. Exp. Date");
                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount2 * -1), false, _Contract."No.", PayRecDoc."Payment Date");//‘†µýˆ«Š±
                            end;
                        end;
                    end;
                end;
            until PayRecDoc.Next = 0;
        end;

        Window.Close;
    end;

    local procedure FindRemainingContract_Gen(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _StartDate: Date;
        _SetStartDate: Date;
        _EndDate: Date;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PaymentDate: Date;
        _LoopDate: Record Date;
        _TotAmount: Decimal;
        _SourceNo: Code[20];
        _SourceLineNo: Integer;
        _ConAmountLedger: Record "DK_Contract Amount Ledger";
        _FirstContract: Boolean;
        _ReplacePayDate: Date;
        _LoopCnt: Integer;
        _Loop: Integer;
        _MaxLoop: Integer;
        _FirstGeneralStartDate: Date;
        _FirstPaymentDate: Date;
        _contract2: Record DK_Contract;
    begin
        //Ÿ‰¦ýˆ«Š±

        _SetStartDate := 20190101D;

        Window.Open('Processing  #1##############');

        _Contract.Reset;
        _Contract.SetCurrentKey("No.");
        //_Contract.SETFILTER("General Expiration Date",'>=%1', 190101D);
        //------------------------------------------------------------------------
        //_Contract.SETFILTER("Cemetery No.", '<>%1&<>%2&<>%3&<>%4&<>%5', '63-1-0908','‘ñ„Ì°3‚‚-0193','˜ˆ8-0103-1','‘ñ‚2‚‚-0102','63-1-0003');
        //_Contract.SETFILTER("Cemetery No.", '%1|%2', '˜ˆ8-0103-1','‘ñ‚2‚‚-0102','63-1-0003');
        //_Contract.SETRANGE("Cemetery No.", '˜ˆ8-0103-1');
        //_Contract.SETRANGE("Cemetery No.", '‘ñ‚2‚‚-0102');
        //_Contract.SETRANGE("Cemetery No.", '63-1-0003');
        //_Contract.SETFILTER("No.",'CD0029181|CD0017521|CD0015828|CD0029222|CD0005900|CD0014506|CD0032081|CD0021460|CD0008555|CD0013707');
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo)
        else begin
            _Contract.SetFilter("No.", '<>%1&<>%2&<>%3&<>%4&<>%5', '20140302001', 'CD0013719', 'CD0013676', 'CD0018174', 'CD0018361');
            _Contract.SetRange("Gen Opening", false);
        end;
        //------------------------------------------------------------------------
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        _Contract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);
        if _Contract.FindSet then begin
            _MaxLoop := _Contract.Count;
            repeat
                Clear(_SourceNo);
                Clear(_SourceLineNo);
                Clear(_FirstContract);
                Clear(_TotAmount);


                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                Clear(_FirstGeneralStartDate);

                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Payment Date");
                _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                _PayReceiptDoc.SetFilter("Line General Amount", '<>%1', 0);                   //Ÿ‰¦ýˆ«Š±
                                                                                              //_PayReceiptDoc.SETFILTER("Line General Expiration Date", '>=%1', 190101D);                   //Ÿ‰¦ýˆ«Š±
                _PayReceiptDoc.SetFilter("Posting Date", '>=%1', 20190101D);
                //_PayReceiptDoc.SETFILTER("Posting Date", '>=%1',190101D);
                _PayReceiptDoc.SetRange(Posted, true);
                _PayReceiptDoc.SetRange(Correction, false);                                   //‘ñ‘ñ‘ª•
                if _PayReceiptDoc.FindSet then begin
                    //‚‚Šž…˜ ýˆ«Š±
                    repeat
                        _PayReceiptDoc.CalcFields("Line General Start Date", "Line General Expiration Date"); //Ÿ‰¦ýˆ«Š±

                        if _FirstGeneralStartDate = 0D then begin
                            _FirstGeneralStartDate := _PayReceiptDoc."Line General Start Date";
                        end;

                        //IF _PayReceiptDoc."Line General Expiration Date" >= 190101D THEN BEGIN                //Ÿ‰¦ýˆ«Š±

                        //IF _PayReceiptDoc."Line General Start Date" <= _SetStartDate THEN                   //Ÿ‰¦ýˆ«Š±
                        //  _StartDate := _SetStartDate
                        //ELSE
                        _StartDate := _PayReceiptDoc."Line General Start Date";                          //Ÿ‰¦ýˆ«Š±

                        if (_Contract."Revocation Date" = 0D) or
                           (_PayReceiptDoc."Line General Expiration Date" < _Contract."Revocation Date") then
                            _EndDate := _PayReceiptDoc."Line General Expiration Date"                         //Ÿ‰¦ýˆ«Š±
                        else
                            _EndDate := _Contract."Revocation Date";

                        _PaymentDate := _PayReceiptDoc."Payment Date";

                        Clear(_TotAmount);
                        //Ÿýˆ«Š±
                        //IF _StartDate <= 190101D THEN BEGIN

                        _SourceNo := _PayReceiptDoc."Document No.";
                        _SourceLineNo := 1;

                        _LoopCnt += 1;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                        if _LoopDate.FindSet then begin
                            repeat

                                if _LoopDate."Period Start" <= _PayReceiptDoc."Payment Date" then
                                    _PaymentDate := _LoopDate."Period Start"
                                else
                                    _PaymentDate := _PayReceiptDoc."Payment Date";

                                _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, _PaymentDate,
                                                                          _SourceNo, _SourceLineNo);     //Ÿ‰¦ýˆ«Š±
                            until _LoopDate.Next = 0;

                            if _PaymentDate < 20190101D then
                                _ReplacePayDate := 20181231D
                            else
                                _ReplacePayDate := _PaymentDate;

                            InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//Ÿ‰¦ýˆ«Š±

                        end;
                    //END;
                    //END;
                    until _PayReceiptDoc.Next = 0;

                    //“´“š ÐŽÊ …Ñœ•
                    if _FirstGeneralStartDate > 20190101D then begin
                        _PaymentDate := 20181124D;//_Contract."Contract Date";
                        _StartDate := 20190101D;
                        _EndDate := _FirstGeneralStartDate - 1;
                        _SourceNo := '';
                        _SourceLineNo := 0;

                        if _Contract."Revocation Date" <> 0D then
                            if _EndDate > _Contract."Revocation Date" then
                                _EndDate := _Contract."Revocation Date";

                        Clear(_TotAmount);
                        //Ÿýˆ«Š±
                        if _StartDate >= 20190101D then begin

                            _ConAmountLedger.Reset;
                            _ConAmountLedger.SetCurrentKey(Date);
                            _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                            _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                            _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                            if _ConAmountLedger.FindLast then begin
                                _SourceNo := _ConAmountLedger."Source No.";
                                _SourceLineNo := _ConAmountLedger."Source Line No.";

                            end;
                            _FirstContract := true;

                            _LoopCnt += 1;

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat

                                    _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, _PaymentDate,
                                                                              _SourceNo, _SourceLineNo);     //Ÿ‰¦ýˆ«Š±
                                until _LoopDate.Next = 0;

                                if _PaymentDate < 20190101D then
                                    _ReplacePayDate := 20181231D
                                else
                                    _ReplacePayDate := _PaymentDate;

                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//Ÿ‰¦ýˆ«Š±

                            end;
                        end;
                    end;

                end else begin
                    //“´“š ÐŽÊýˆ«Š±

                    //ýˆ«Š± “ÁŸÀ
                    if _SetStartDate < _Contract."Contract Date" then
                        _StartDate := _Contract."Contract Date"
                    else
                        _StartDate := _SetStartDate;

                    _EndDate := _Contract."General Expiration Date";                        //Ÿ‰¦ýˆ«Š±

                    //Œ÷‘ñ—© ŠžŠ¨
                    //ýˆ«Š± ‘Ž‡ßŸÀ
                    _AdminExpLedger.Reset;
                    _AdminExpLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date);
                    _AdminExpLedger.SetRange("Contract No.", _Contract."No.");
                    _AdminExpLedger.SetRange("Admin. Expense Type", _AdminExpLedger."Admin. Expense Type"::General);
                    _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
                    _AdminExpLedger.SetFilter(Date, '>=%1', 20190101D);
                    if _AdminExpLedger.FindFirst then
                        _EndDate := _AdminExpLedger.Date - 1;

                    //ýˆ«Š± ‘Ž‡ßŸÀ

                    if (_Contract."Revocation Date" <> 0D) and (_Contract."Revocation Date" < _EndDate) then
                        _EndDate := _Contract."Revocation Date";

                    _PaymentDate := _Contract."Contract Date";

                    _ConAmountLedger.Reset;
                    _ConAmountLedger.SetCurrentKey(Date);
                    _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                    _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                    _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                    if _ConAmountLedger.FindLast then begin
                        _SourceNo := _ConAmountLedger."Source No.";
                        _SourceLineNo := _ConAmountLedger."Source Line No.";
                        _FirstContract := true;
                    end;

                    Clear(_TotAmount);

                    //Ÿýˆ«Š±
                    if _StartDate >= 20190101D then begin
                        _LoopCnt += 1;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                        if _LoopDate.FindSet then begin
                            repeat
                                //_TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start",_Contract."Admin. Exp. Type Filter"::General, _Contract."Contract Date",
                                _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, _StartDate,
                                                                            _SourceNo, _SourceLineNo);//Ÿ‰¦ýˆ«Š±
                            until _LoopDate.Next = 0;

                            if _PaymentDate < 20190101D then
                                _ReplacePayDate := 20181230D
                            else
                                _ReplacePayDate := _PaymentDate;

                            InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//Ÿ‰¦ýˆ«Š±
                        end;
                    end;
                end;
                if _contract2.Get(_Contract."No.") then begin
                    _contract2."Gen Opening" := true;
                    _contract2.Modify;
                    Commit;
                end;
            until _Contract.Next = 0;
        end;
        Window.Close;

        //MESSAGE('COUNT : %1',_LoopCnt);
    end;

    local procedure FindRemainingContract_Lan(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _StartDate: Date;
        _SetStartDate: Date;
        _EndDate: Date;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PaymentDate: Date;
        _LoopDate: Record Date;
        _TotAmount: Decimal;
        _SourceNo: Code[20];
        _SourceLineNo: Integer;
        _ConAmountLedger: Record "DK_Contract Amount Ledger";
        _FirstContract: Boolean;
        _ReplacePayDate: Date;
        _LoopCnt: Integer;
        _Loop: Integer;
        _MaxLoop: Integer;
        _FirstLandStartDate: Date;
    begin
        //‘†µýˆ«Š±

        _SetStartDate := 20190101D;

        Window.Open('Processing  #1##############');

        _Contract.Reset;
        _Contract.SetCurrentKey("No.");
        _Contract.SetFilter("Land. Arc. Expiration Date", '>=%1', 20190101D); //‘†µýˆ«Š±
        //------------------------------------------------------------------------
        //_Contract.SETFILTER("Cemetery No.",'<>%1&<>%2','20140430008','20190414006');
        if pContractNo <> '' then
            _Contract.SetRange("No.", pContractNo)
        else begin
            _Contract.SetFilter("No.", '<>%1&<>%2', '20140430008', '20190414006');
            _Contract.SetRange("Lan Opening", false);
        end;
        //------------------------------------------------------------------------
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        _Contract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);

        if _Contract.FindSet then begin
            _MaxLoop := _Contract.Count;
            repeat
                Clear(_SourceNo);
                Clear(_SourceLineNo);
                Clear(_FirstContract);
                Clear(_TotAmount);


                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Payment Date");
                _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                /*
                _PayReceiptDoc.SETFILTER("Line Land. Arc. Exp. Date", '<>%1&>=%2', 0D, 190101D);                     //‘†µýˆ«Š±
                _PayReceiptDoc.SETFILTER("Posting Date", '>=%1',190101D);
                */
                _PayReceiptDoc.SetFilter("Line Land. Arc. Exp. Date", '<>%1', 0D);                   //‘†µýˆ«Š±
                _PayReceiptDoc.SetFilter("Line Land. Arc. Amount", '<>%1', 0);                   //‘†µýˆ«Š±
                _PayReceiptDoc.SetFilter("Posting Date", '>=%1', 20190101D);
                _PayReceiptDoc.SetRange(Posted, true);
                if _PayReceiptDoc.FindSet then begin
                    //‚‚Šž…˜ ýˆ«Š±
                    repeat
                        _PayReceiptDoc.CalcFields("Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date"); //‘†µýˆ«Š±

                        if _FirstLandStartDate = 0D then
                            _FirstLandStartDate := _PayReceiptDoc."Line Land. Arc. Start Date";

                        if _PayReceiptDoc."Line Land. Arc. Exp. Date" >= 20190101D then begin                //‘†µýˆ«Š±

                            if _PayReceiptDoc."Line Land. Arc. Start Date" <= _SetStartDate then                   //‘†µýˆ«Š±
                                _StartDate := _PayReceiptDoc."Line Land. Arc. Start Date"                           //‘†µýˆ«Š±
                            else
                                _StartDate := _SetStartDate;


                            if (_Contract."Revocation Date" = 0D) or
                               (_PayReceiptDoc."Line Land. Arc. Exp. Date" < _Contract."Revocation Date") then
                                _EndDate := _PayReceiptDoc."Line Land. Arc. Exp. Date"                         //‘†µýˆ«Š±
                            else
                                _EndDate := _Contract."Revocation Date";

                            _PaymentDate := _PayReceiptDoc."Payment Date";

                            Clear(_TotAmount);
                            //Ÿýˆ«Š±
                            if _StartDate >= 20190101D then begin


                                _SourceNo := _PayReceiptDoc."Document No.";
                                _SourceLineNo := 1;

                                _LoopCnt += 1;

                                _LoopDate.Reset;
                                _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                                _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                                if _LoopDate.FindSet then begin
                                    repeat


                                        if _LoopDate."Period Start" <= _PayReceiptDoc."Payment Date" then
                                            _PaymentDate := _LoopDate."Period Start"
                                        else
                                            _PaymentDate := _PayReceiptDoc."Payment Date";

                                        _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, _PaymentDate,
                                                                                  _SourceNo, _SourceLineNo);     //‘†µýˆ«Š±
                                    until _LoopDate.Next = 0;

                                    if _PaymentDate < 20190101D then
                                        _ReplacePayDate := 20181230D
                                    else
                                        _ReplacePayDate := _PaymentDate;

                                    InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//‘†µýˆ«Š±

                                end;
                            end;
                        end;
                    until _PayReceiptDoc.Next = 0;

                    //“´“š ÐŽÊ …Ñœ•
                    if _FirstLandStartDate > 20190101D then begin
                        _PaymentDate := _Contract."Contract Date";
                        _StartDate := 20190101D;
                        _EndDate := _FirstLandStartDate - 1;

                        _SourceNo := '';
                        _SourceLineNo := 0;


                        if _Contract."Revocation Date" <> 0D then
                            if _EndDate > _Contract."Revocation Date" then
                                _EndDate := _Contract."Revocation Date";

                        _FirstContract := true;

                        Clear(_TotAmount);
                        //Ÿýˆ«Š±
                        if _StartDate >= 20190101D then begin


                            _ConAmountLedger.Reset;
                            _ConAmountLedger.SetCurrentKey(Date);
                            _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                            _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                            _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                            if _ConAmountLedger.FindLast then begin
                                _SourceNo := _ConAmountLedger."Source No.";
                                _SourceLineNo := _ConAmountLedger."Source Line No.";

                            end;
                            _FirstContract := true;

                            _LoopCnt += 1;

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat
                                    _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, _PaymentDate,
                                                                              _SourceNo, _SourceLineNo);     //‘†µýˆ«Š±
                                until _LoopDate.Next = 0;

                                if _PaymentDate < 20190101D then
                                    _ReplacePayDate := 20181231D
                                else
                                    _ReplacePayDate := _PaymentDate;

                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//‘†µýˆ«Š±

                            end;
                        end;
                    end;
                end else begin
                    //“´“š ÐŽÊýˆ«Š±

                    //ýˆ«Š± “ÁŸÀ
                    if _SetStartDate < _Contract."Contract Date" then
                        _StartDate := _Contract."Contract Date"
                    else
                        _StartDate := _SetStartDate;

                    _EndDate := _Contract."Land. Arc. Expiration Date";

                    //Œ÷‘ñ—© ŠžŠ¨
                    //ýˆ«Š± ‘Ž‡ßŸÀ
                    _AdminExpLedger.Reset;
                    _AdminExpLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date);
                    _AdminExpLedger.SetRange("Contract No.", _Contract."No.");
                    _AdminExpLedger.SetRange("Admin. Expense Type", _AdminExpLedger."Admin. Expense Type"::Landscape);
                    _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
                    _AdminExpLedger.SetFilter(Date, '>=%1', 20190101D);
                    if _AdminExpLedger.FindFirst then
                        _EndDate := _AdminExpLedger.Date - 1;

                    if (_Contract."Revocation Date" <> 0D) and (_Contract."Revocation Date" < _EndDate) then
                        _EndDate := _Contract."Revocation Date";

                    _PaymentDate := _Contract."Contract Date";

                    _ConAmountLedger.Reset;
                    _ConAmountLedger.SetCurrentKey(Date);
                    _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                    _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                    _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                    if _ConAmountLedger.FindLast then begin
                        _SourceNo := _ConAmountLedger."Source No.";
                        _SourceLineNo := _ConAmountLedger."Source Line No.";

                    end;

                    _FirstContract := true;

                    Clear(_TotAmount);

                    //Ÿýˆ«Š±
                    if _StartDate >= 20190101D then begin
                        _LoopCnt += 1;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                        if _LoopDate.FindSet then begin
                            repeat
                                _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, _Contract."Contract Date",
                                                                          _SourceNo, _SourceLineNo);//‘†µýˆ«Š±
                            until _LoopDate.Next = 0;

                            if _PaymentDate < 20190101D then
                                _ReplacePayDate := 20181231D
                            else
                                _ReplacePayDate := _PaymentDate;

                            InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//‘†µýˆ«Š±

                        end;
                    end;
                end;
                _Contract."Lan Opening" := true;
                _Contract.Modify;
                Commit;
            until _Contract.Next = 0;
        end;
        Window.Close;

        //MESSAGE('COUNT : %1',_LoopCnt);

    end;

    local procedure InsertLedgerPrePayment(pSourceNo: Code[20]; pSourceLineNo: Integer; pAdminExpenseType: Option; pTotalAmount: Decimal; pFirstContract: Boolean; pContractNo: Code[20]; pReplacePayDate: Date)
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _NewLineNo: Integer;
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Amount: Decimal;
        _AdminExpLedger2: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
    begin
        //Œ€‚‚€¦ Ð‹Ó

        if pTotalAmount <> 0 then begin
            if _NewLineNo = 0 then
                _NewLineNo := _AdminExpLedger.GetNewLineNo(pContractNo, pReplacePayDate)
            else
                _NewLineNo += 1;

            _AdminExpLedger.Init;
            _AdminExpLedger.Validate("Contract No.", pContractNo);
            _AdminExpLedger.Validate(Date, pReplacePayDate);
            _AdminExpLedger."Line No." := _NewLineNo;
            _AdminExpLedger.Validate("Admin. Expense Type", pAdminExpenseType);
            _AdminExpLedger.Validate("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
            _AdminExpLedger.Validate("Payment Type", _AdminExpLedger."Payment Type"::Bank);
            _AdminExpLedger.Validate(Amount, pTotalAmount);
            _AdminExpLedger.Validate("Source No.", pSourceNo);
            _AdminExpLedger.Validate("Source Line No.", pSourceLineNo);
            _AdminExpLedger.Validate("First Contract", pFirstContract);
            _AdminExpLedger.Validate("Add. Period", false);
            _AdminExpLedger.Insert(true);
        end;
    end;

    local procedure ContractDailyAdminExpense3(var pContract: Record DK_Contract; pToday: Date; pAdminExpenseType: Option; pStringDate: Date; pSourceNo: Code[10]; pSourceLineNo: Integer): Decimal
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
        _FirstContract: Boolean;
    begin
        //ýˆ«Š±
        Clear(_AdminExpenseMgt);

        //ýˆ«Š± ˆÒ‘ª €Ëú Šž
        if (pContract."Man. Fee Exemption Date" = 0D) or (pContract."Man. Fee Exemption Date" < pToday) then begin

            //ýˆ«Š± ž‹Ý »‰ €Ëú Šž
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

            //’ðŽ¸“‚ˆ« ŸÀ Šž(ÐŽÊˆ‹Ÿ)
            if _EndingDate = pToday then
                _CalcAmount += (_DiffAmount * -1);

            if pContract."Contract Date" = pStringDate then
                _FirstContract := true
            else
                _FirstContract := false;

            _CalcAmount := _CalcAmount - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType);
            if _CalcAmount <> 0 then
                InsertAdminExpenseLedger2(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, false, _HikeExemptionDate, pSourceNo, pSourceLineNo, _FirstContract);
            exit(_CalcAmount);
        end else begin

            if pContract."Contract Date" = pStringDate then
                _FirstContract := true
            else
                _FirstContract := false;

            //ýˆ«Š± ˆÒ‘ª €Ëúí —¹„Ï—Ÿ‰—‡ž €¦Ž¸ (0)ˆ‡ž “‚ˆ«
            _CalcAmount := 0 - GetAdminExpenseAmount(pContract."No.", pToday, pAdminExpenseType);
            InsertAdminExpenseLedger2(pContract."No.", pToday, pAdminExpenseType, _CalcAmount, true, 0D, pSourceNo, pSourceLineNo, _FirstContract);
        end;
    end;

    local procedure InsertAdminExpenseLedger2(pContractNo: Code[20]; pDate: Date; pAdminExpType: Option; pAmount: Decimal; pExemptTarget: Boolean; pHikeExemptionDate: Date; pSourceNo: Code[10]; pSourceLineNo: Integer; pFirstContract: Boolean)
    begin

        if pAmount <> 0 then begin

            AdminExpenseLedger.Init;
            AdminExpenseLedger."Contract No." := pContractNo;
            AdminExpenseLedger.Date := pDate;
            AdminExpenseLedger."Line No." := AdminExpenseLedger.GetNewLineNo(pContractNo, pDate);
            AdminExpenseLedger."Admin. Expense Type" := pAdminExpType;
            AdminExpenseLedger."Ledger Type" := AdminExpenseLedger."Ledger Type"::Daily;
            AdminExpenseLedger.Amount := pAmount;
            AdminExpenseLedger."Source No." := pSourceNo;
            AdminExpenseLedger."Source Line No." := pSourceLineNo;
            AdminExpenseLedger."First Contract" := pFirstContract;
            AdminExpenseLedger.Validate("Exempt Target", pExemptTarget);
            AdminExpenseLedger.Validate("Man. Fee hike Exemption Date", pHikeExemptionDate);
            AdminExpenseLedger.Insert(true);
        end;
    end;

    local procedure FindRemainingContract_Gen2(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _StartDate: Date;
        _SetStartDate: Date;
        _EndDate: Date;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PaymentDate: Date;
        _LoopDate: Record Date;
        _TotAmount: Decimal;
        _SourceNo: Code[20];
        _SourceLineNo: Integer;
        _ConAmountLedger: Record "DK_Contract Amount Ledger";
        _FirstContract: Boolean;
        _ReplacePayDate: Date;
        _LoopCnt: Integer;
        _Loop: Integer;
        _MaxLoop: Integer;
        _FirstGeneralStartDate: Date;
        _FirstPaymentDate: Date;
    begin
        //Ÿ‰¦ýˆ«Š±

        _SetStartDate := 20190101D;

        Window.Open('Processing  #1##############');

        _Contract.Reset;
        _Contract.SetCurrentKey("No.");
        _Contract.SetFilter("General Expiration Date", '>=%1', 20190101D);
        _Contract.SetRange("No.", pContractNo);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        _Contract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);
        if _Contract.FindSet then begin
            _MaxLoop := _Contract.Count;
            repeat
                Clear(_SourceNo);
                Clear(_SourceLineNo);
                Clear(_FirstContract);
                Clear(_TotAmount);


                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                Clear(_FirstGeneralStartDate);

                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Payment Date");
                _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                _PayReceiptDoc.SetFilter("Line General Expiration Date", '<>%1', 0D);                     //Ÿ‰¦ýˆ«Š±
                if _PayReceiptDoc.FindSet then begin
                    //‚‚Šž…˜ ýˆ«Š±

                    repeat
                        _PayReceiptDoc.CalcFields("Line General Start Date", "Line General Expiration Date"); //Ÿ‰¦ýˆ«Š±

                        if _FirstGeneralStartDate = 0D then begin
                            _FirstGeneralStartDate := _PayReceiptDoc."Line General Start Date";
                        end;

                    until _PayReceiptDoc.Next = 0;

                    //“´“š ÐŽÊ …Ñœ•
                    if _FirstGeneralStartDate > 20190101D then begin
                        _PaymentDate := _Contract."Contract Date";
                        _StartDate := 20190101D;
                        _EndDate := _FirstGeneralStartDate - 1;
                        _SourceNo := '';
                        _SourceLineNo := 0;

                        if _Contract."Revocation Date" <> 0D then
                            if _EndDate > _Contract."Revocation Date" then
                                _EndDate := _Contract."Revocation Date";

                        Clear(_TotAmount);
                        //Ÿýˆ«Š±
                        if _StartDate >= 20190101D then begin

                            _ConAmountLedger.Reset;
                            _ConAmountLedger.SetCurrentKey(Date);
                            _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                            _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                            _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                            if _ConAmountLedger.FindLast then begin
                                _SourceNo := _ConAmountLedger."Source No.";
                                _SourceLineNo := _ConAmountLedger."Source Line No.";

                            end;
                            _FirstContract := true;


                            _LoopCnt += 1;

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat

                                    _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, _PaymentDate,
                                                                              _SourceNo, _SourceLineNo);     //Ÿ‰¦ýˆ«Š±
                                until _LoopDate.Next = 0;

                                if _PaymentDate < 20190101D then
                                    _ReplacePayDate := 20181231D
                                else
                                    _ReplacePayDate := _PaymentDate;

                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//Ÿ‰¦ýˆ«Š±

                            end;
                        end;
                    end;

                end else begin
                    //“´“š ÐŽÊýˆ«Š±

                    //ýˆ«Š± “ÁŸÀ
                    if _SetStartDate < _Contract."Contract Date" then
                        _StartDate := _Contract."Contract Date"
                    else
                        _StartDate := _SetStartDate;

                    //ýˆ«Š± ‘Ž‡ßŸÀ
                    if (_Contract."Revocation Date" = 0D) or
                       (_PayReceiptDoc."Line General Expiration Date" < _Contract."Revocation Date") then
                        _EndDate := _Contract."General Expiration Date" //Ÿ‰¦ýˆ«Š±
                    else
                        _EndDate := _Contract."Revocation Date";


                    _PaymentDate := _Contract."Contract Date";

                    _ConAmountLedger.Reset;
                    _ConAmountLedger.SetCurrentKey(Date);
                    _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                    _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                    _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                    if _ConAmountLedger.FindLast then begin
                        _SourceNo := _ConAmountLedger."Source No.";
                        _SourceLineNo := _ConAmountLedger."Source Line No.";
                        _FirstContract := true;
                    end;

                    Clear(_TotAmount);

                    //Ÿýˆ«Š±
                    if _StartDate >= 20190101D then begin
                        _LoopCnt += 1;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                        if _LoopDate.FindSet then begin
                            repeat
                                _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::General, _Contract."Contract Date",
                                                                          _SourceNo, _SourceLineNo);//Ÿ‰¦ýˆ«Š±
                            until _LoopDate.Next = 0;

                            if _PaymentDate < 20190101D then
                                _ReplacePayDate := 20181230D
                            else
                                _ReplacePayDate := _PaymentDate;

                            InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 0, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//Ÿ‰¦ýˆ«Š±

                        end;
                    end;
                end;

            until _Contract.Next = 0;
        end;
        Window.Close;

        //MESSAGE('COUNT : %1',_LoopCnt);
    end;

    local procedure FindRemainingContract_Lan2(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _StartDate: Date;
        _SetStartDate: Date;
        _EndDate: Date;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PaymentDate: Date;
        _LoopDate: Record Date;
        _TotAmount: Decimal;
        _SourceNo: Code[20];
        _SourceLineNo: Integer;
        _ConAmountLedger: Record "DK_Contract Amount Ledger";
        _FirstContract: Boolean;
        _ReplacePayDate: Date;
        _LoopCnt: Integer;
        _Loop: Integer;
        _MaxLoop: Integer;
        _FirstLandStartDate: Date;
    begin
        //‘†µýˆ«Š±

        _SetStartDate := 20190101D;

        Window.Open('Processing  #1##############');

        _Contract.Reset;
        _Contract.SetCurrentKey("No.");
        _Contract.SetFilter("Land. Arc. Expiration Date", '>=%1', 20190101D); //‘†µýˆ«Š±
        //------------------------------------------------------------------------
        //_Contract.SETFILTER("Cemetery No.",'<>%1','ˆ×í¼1-0054');
        //_Contract.SETRANGE("Cemetery No.", 'ˆ×í¼1-0054');
        //------------------------------------------------------------------------
        _Contract.SetRange("No.", pContractNo);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        _Contract.SetFilter("Revocation Date", '=%1|>=%2', 0D, 20190101D);
        if _Contract.FindSet then begin
            _MaxLoop := _Contract.Count;
            repeat
                Clear(_SourceNo);
                Clear(_SourceLineNo);
                Clear(_FirstContract);
                Clear(_TotAmount);


                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Payment Date");
                _PayReceiptDoc.SetRange("Contract No.", _Contract."No.");
                _PayReceiptDoc.SetFilter("Line Land. Arc. Exp. Date", '<>%1', 0D);                     //‘†µýˆ«Š±
                if _PayReceiptDoc.FindSet then begin
                    //‚‚Šž…˜ ýˆ«Š±

                    _PayReceiptDoc.CalcFields("Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date"); //‘†µýˆ«Š±

                    if _FirstLandStartDate = 0D then
                        _FirstLandStartDate := _PayReceiptDoc."Line Land. Arc. Start Date";


                    //“´“š ÐŽÊ …Ñœ•
                    if _FirstLandStartDate > 20190101D then begin
                        _PaymentDate := _Contract."Contract Date";
                        _StartDate := 20190101D;
                        _EndDate := _FirstLandStartDate - 1;

                        _SourceNo := '';
                        _SourceLineNo := 0;


                        if _Contract."Revocation Date" <> 0D then
                            if _EndDate > _Contract."Revocation Date" then
                                _EndDate := _Contract."Revocation Date";

                        _FirstContract := true;

                        Clear(_TotAmount);
                        //Ÿýˆ«Š±
                        if _StartDate >= 20190101D then begin


                            _ConAmountLedger.Reset;
                            _ConAmountLedger.SetCurrentKey(Date);
                            _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                            _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                            _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                            if _ConAmountLedger.FindLast then begin
                                _SourceNo := _ConAmountLedger."Source No.";
                                _SourceLineNo := _ConAmountLedger."Source Line No.";

                            end;
                            _FirstContract := true;

                            _LoopCnt += 1;

                            _LoopDate.Reset;
                            _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                            _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                            if _LoopDate.FindSet then begin
                                repeat
                                    _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, _PaymentDate,
                                                                              _SourceNo, _SourceLineNo);     //‘†µýˆ«Š±
                                until _LoopDate.Next = 0;

                                if _PaymentDate < 20190101D then
                                    _ReplacePayDate := 20181231D
                                else
                                    _ReplacePayDate := _PaymentDate;

                                InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//‘†µýˆ«Š±

                            end;
                        end;
                    end;
                end else begin
                    //“´“š ÐŽÊýˆ«Š±

                    //ýˆ«Š± “ÁŸÀ
                    if _SetStartDate < _Contract."Contract Date" then
                        _StartDate := _Contract."Contract Date"
                    else
                        _StartDate := _SetStartDate;

                    //ýˆ«Š± ‘Ž‡ßŸÀ
                    if (_Contract."Revocation Date" = 0D) or
                        (_PayReceiptDoc."Line Land. Arc. Exp. Date" < _Contract."Revocation Date") then
                        _EndDate := _Contract."Land. Arc. Expiration Date" //‘†µýˆ«Š±
                    else
                        _EndDate := _Contract."Revocation Date";

                    _PaymentDate := _Contract."Contract Date";

                    _ConAmountLedger.Reset;
                    _ConAmountLedger.SetCurrentKey(Date);
                    _ConAmountLedger.SetRange("Contract No.", _Contract."No.");
                    _ConAmountLedger.SetFilter(Type, '%1|%2', _ConAmountLedger.Type::Contract, _ConAmountLedger.Type::Remaining);
                    _ConAmountLedger.SetRange("Ledger Type", _ConAmountLedger."Ledger Type"::Receipt);
                    if _ConAmountLedger.FindLast then begin
                        _SourceNo := _ConAmountLedger."Source No.";
                        _SourceLineNo := _ConAmountLedger."Source Line No.";

                    end;

                    _FirstContract := true;

                    Clear(_TotAmount);

                    //Ÿýˆ«Š±
                    if _StartDate >= 20190101D then begin
                        _LoopCnt += 1;

                        _LoopDate.Reset;
                        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
                        _LoopDate.SetRange("Period Start", _StartDate, _EndDate);
                        if _LoopDate.FindSet then begin
                            repeat
                                _TotAmount += ContractDailyAdminExpense3(_Contract, _LoopDate."Period Start", _Contract."Admin. Exp. Type Filter"::Landscape, _Contract."Contract Date",
                                                                          _SourceNo, _SourceLineNo);//‘†µýˆ«Š±
                            until _LoopDate.Next = 0;

                            if _PaymentDate < 20190101D then
                                _ReplacePayDate := 20181231D
                            else
                                _ReplacePayDate := _PaymentDate;

                            InsertLedgerPrePayment(_SourceNo, _SourceLineNo, 1, (_TotAmount * -1), _FirstContract, _Contract."No.", _ReplacePayDate);//‘†µýˆ«Š±

                        end;
                    end;
                end;

            until _Contract.Next = 0;
        end;
        Window.Close;

        //MESSAGE('COUNT : %1',_LoopCnt);
    end;

    local procedure FindPaymentReceiptApply(pContractNo: Code[20]; pTodate: Date)
    var
        PayRecDoc: Record "DK_Payment Receipt Document";
        _Contract: Record DK_Contract;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin

        Window.Open('Processing  #1##############');

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date, Open);
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Receipt);
        _AdminExpenseLedger.SetRange(Open, true);
        if pContractNo <> '' then
            _AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        if _AdminExpenseLedger.FindSet then begin
            _MaxLoop := _AdminExpenseLedger.Count;
            repeat

                _Loop += 1;
                Window.Update(1, StrSubstNo('%1/%2', _Loop, _MaxLoop));

                _ApplyAdminExLedger.ApplyTargetDailyLedger(_AdminExpenseLedger, pTodate);
                Commit;
            until _AdminExpenseLedger.Next = 0;
        end;

        Window.Close;
    end;

    local procedure CreateMonthlyAdminExpenseSum(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _LoopDate: Record Date;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin
        _Contract.Reset;
        _Contract.SetRange("No.", pContractNo);
        _Contract.SetFilter("General Expiration Date", '>=%1', 20190101D);
        if _Contract.FindSet then begin

            if GuiAllowed then
                Window.Open(MSG001);
            _MaxLoop := _Contract.Count;
            //REPEAT
            _Loop += 1;
            Window.Update(1, Round(_Loop * 10000 / _MaxLoop, 1));

            _AdminExpenseLedger.Reset;
            _AdminExpenseLedger.SetRange("Contract No.", _Contract."No.");
            //_AdminExpenseLedger.SETRANGE("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::Landscape);
            _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::General);
            _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
            if _AdminExpenseLedger.FindSet then begin
                _AdminExpenseLedger.CalcSums(Amount);
                if _AdminExpenseLedger.Amount < 0 then begin
                    _AdminExpenseLedger2.Init;
                    _AdminExpenseLedger2."Contract No." := _Contract."No.";

                    if _AdminExpenseLedger.Date < 20190101D then
                        _AdminExpenseLedger2.Date := 20181231D
                    else
                        _AdminExpenseLedger2.Date := _AdminExpenseLedger.Date;

                    _AdminExpenseLedger2."Line No." := 11;
                    //_AdminExpenseLedger2."Line No." := 12;
                    _AdminExpenseLedger2."Admin. Expense Type" := _AdminExpenseLedger."Admin. Expense Type";
                    _AdminExpenseLedger2."Ledger Type" := _AdminExpenseLedger2."Ledger Type"::Receipt;
                    _AdminExpenseLedger2."Source No." := 'OPENING';
                    _AdminExpenseLedger2.Amount := Abs(_AdminExpenseLedger.Amount);
                    _AdminExpenseLedger2.Insert(true);
                end;
            end;

            //UNTIL _Contract.NEXT = 0;
            if GuiAllowed then
                Window.Close;
        end;
    end;

    local procedure "---> —‘„¸ ýˆ«Š± ‘Ž‡ßŸ Š»µ"()
    begin
    end;

    local procedure ChangeContractExpirationDate(pContractNo: Code[20]; pDate: Date; pExpenseType: Integer)
    var
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _Contract: Record DK_Contract;
    begin

        _DetailAdminExpLedger.Reset;
        _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
        _DetailAdminExpLedger.SetRange("Admin. Expense Type", _DetailAdminExpLedger."Admin. Expense Type"::Landscape);
        if _DetailAdminExpLedger.FindSet then begin
            _DetailAdminExpLedger.DeleteAll;
        end;


        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::Landscape);
        if _AdminExpenseLedger.FindSet then begin
            _AdminExpenseLedger.DeleteAll;
        end;

        if pExpenseType = 0 then begin
            _Contract.Reset;
            _Contract.SetRange("No.", pContractNo);
            if _Contract.FindSet then begin
                _Contract."General Expiration Date" := pDate;
                _Contract.Modify;
            end;

            FindRemainingContract_Gen(pContractNo);
            FindPaymentReceiptApply(pContractNo, Today);
        end else
            if pExpenseType = 1 then begin
                _Contract.Reset;
                _Contract.SetRange("No.", pContractNo);
                if _Contract.FindSet then begin
                    _Contract."Land. Arc. Expiration Date" := pDate;
                    _Contract.Modify;
                end;

                FindRemainingContract_Lan(pContractNo);
                FindPaymentReceiptApply(pContractNo, Today);
            end;
    end;
}

