codeunit 50027 "DK_Batch Daily Liti. Evaul."
{
    // //…Ø€ÃŠ ‰œ‚‚
    //   *CreaeDate(pDate) : ‚»’Ñ –”†Ý‰œ•‡ž …Ñœ• ‹²ŒŠ
    //   *ˆ•Ÿ ˜” 7“í Batch ‹²ŒŠ
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2005 :2020-07-09
    //   - Modify function : InsertLitigaionEvaluationAmount
    // *DK32 : 20200720
    //   - Modify Function : ContractFind
    // *#2083 : 20200812
    //   - Modify Function : ContractFind
    // 
    // #2152 : 20200907
    //   - Modify Function : ContractFind


    trigger OnRun()
    var
        _CommFun: Codeunit "DK_Common Function";
    begin

        Page50223_CreateData(Today);
        Clear(_CommFun);
        _CommFun.UpdateJobQueueHistoty(2, MSG001);
    end;

    var
        MSG001: Label 'Normal run complete';
        Window: Dialog;
        MSG002: Label 'Contract   #1############\';
        MSG003: Label 'Processing  #3##########\';
        MSG004: Label 'Evaluation/Employee #1##########\';
        MSG005: Label 'Admin. Expense Type #4##########\';
        LitigaionEvalAmt: Record "DK_Litigaion Evaluation Amount";


    procedure Page50223_CreateData(pToday: Date)
    begin

        LitigaionEvalAmt.Reset;
        LitigaionEvalAmt.SetRange(Date, pToday);
        if LitigaionEvalAmt.FindSet then
            LitigaionEvalAmt.DeleteAll;

        if GuiAllowed then
            Window.Open(
              MSG005 +
              MSG004 +
              MSG002 +
              MSG003);

        //Ÿ‰¦ýˆ«Š±
        if GuiAllowed then
            Window.Update(4, StrSubstNo('%1', LitigaionEvalAmt."Admin. Expense Type"::General));

        ContractFind(pToday, LitigaionEvalAmt."Admin. Expense Type"::General);

        //‘†µýˆ«Š±
        if GuiAllowed then
            Window.Update(4, StrSubstNo('%1', LitigaionEvalAmt."Admin. Expense Type"::Landscape));

        ContractFind(pToday, LitigaionEvalAmt."Admin. Expense Type"::Landscape);

        //Ÿ‰¦ýˆ«Š± …Ø€ÃŠ ŠžŠ¨—³
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::A, LitigaionEvalAmt."Admin. Expense Type"::General);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::B, LitigaionEvalAmt."Admin. Expense Type"::General);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::C, LitigaionEvalAmt."Admin. Expense Type"::General);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::D, LitigaionEvalAmt."Admin. Expense Type"::General);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::E, LitigaionEvalAmt."Admin. Expense Type"::General);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::F, LitigaionEvalAmt."Admin. Expense Type"::General);

        //‘†µýˆ«Š± …Ø€ÃŠ ŠžŠ¨—³
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::A, LitigaionEvalAmt."Admin. Expense Type"::Landscape);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::B, LitigaionEvalAmt."Admin. Expense Type"::Landscape);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::C, LitigaionEvalAmt."Admin. Expense Type"::Landscape);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::D, LitigaionEvalAmt."Admin. Expense Type"::Landscape);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::E, LitigaionEvalAmt."Admin. Expense Type"::Landscape);
        SumLitigaionEvaluationAmount(pToday, LitigaionEvalAmt."Litigation Evaluation"::F, LitigaionEvalAmt."Admin. Expense Type"::Landscape);

        if GuiAllowed then
            Window.Close;
    end;

    local procedure ContractFind(pToday: Date; pAdminExpenseType: Option)
    var
        _Contract: Record DK_Contract;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _MainLoop: Integer;
        _MaxLoop: Integer;
        _NonPayAmt: Decimal;
        _PayAmt: Decimal;
        _ContractCnt: Decimal;
        _TotSize: Decimal;
        _StartDate: Date;
        _EndDate: Date;
        _EndDateFilter: Date;
        _FunSetup: Record "DK_Function Setup";
        _ContractLitiEvauByEmp: Query "DK_Contract Liti. Evau. By Emp";
        _BaseStartDate: Date;
        _BaseEndDate: Date;
        _SkipRun: Boolean;
        _ElapsedAmt: Decimal;
        _ElapsedSumAmt: Decimal;
    begin


        _BaseStartDate := pToday + 1;
        _BaseEndDate := CalcDate(StrSubstNo('<+%1Y>', _FunSetup."Management Unit"), pToday) - 1;

        _FunSetup.Get;
        _FunSetup.TestField("Management Unit");

        //ŒÁ‰½ „Ì„ÏÀŠ ŒÁ‰½ …Ø€Ã ‘†˜ˆ
        if pAdminExpenseType = LitigaionEvalAmt."Admin. Expense Type"::Landscape then
            _ContractLitiEvauByEmp.SetRange(Landscape_Architecture, true);
        _ContractLitiEvauByEmp.Open;
        while _ContractLitiEvauByEmp.Read do begin

            //“š€Ë˜¡
            Clear(_ContractCnt);
            Clear(_TotSize);
            Clear(_NonPayAmt);
            Clear(_PayAmt);
            Clear(_MainLoop);
            Clear(_ElapsedSumAmt);

            if GuiAllowed then
                Window.Update(1, StrSubstNo('%1/%2', _ContractLitiEvauByEmp.Litigation_Evaluation,
                                                     _ContractLitiEvauByEmp.Litigation_Employee_No));

            _Contract.Reset;
            _Contract.SetFilter("Cemetery Code", '<>%1', '');
            _Contract.SetFilter("Revocation Date", '=%1|>=%2', 0D, pToday);
            _Contract.SetFilter("Date Filter", '%1..%2', 0D, pToday);
            _Contract.SetRange("Litigation Employee No.", _ContractLitiEvauByEmp.Litigation_Employee_No);
            _Contract.SetRange("Litigation Evaluation", _ContractLitiEvauByEmp.Litigation_Evaluation);

            if pAdminExpenseType = LitigaionEvalAmt."Admin. Expense Type"::Landscape then begin
                _Contract.SetRange("Landscape Architecture", true);
                _Contract.SetFilter("Land. Arc. Expiration Date", '<>%1', 0D); //#2083
            end else begin
                _Contract.SetFilter("General Expiration Date", '<>%1', 0D);  //#2083
            end;

            if _Contract.FindSet then begin
                _MaxLoop := _Contract.Count;
                repeat
                    _MainLoop += 1;
                    if GuiAllowed then begin
                        Window.Update(2, StrSubstNo('%1 / %2', _MainLoop, _MaxLoop));
                        Window.Update(3, _Contract."No.");
                    end;
                    _SkipRun := false;
                    //>> #2152
                    Clear(_ElapsedAmt);
                    //<<

                    _Contract.CalcFields("Cemetery Size", "Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

                    //>>DK32
                    //“ÁŸÀˆª €Ë‘¹ˆ‡ž ýˆ«Š±ˆª Ð‹Ó—Ÿ„’ ‡ž‘ð “Èí —šÍ.....!!!!
                    _Contract.CalcFields("Admin. Expense Method");
                    case _Contract."Admin. Expense Method" of
                        _Contract."Admin. Expense Method"::"After Corpse 10":
                            begin
                                if (_Contract."General Expiration Date" = 0D) and (_Contract."Admin. Exp. Start Date" > _BaseEndDate) then begin
                                    _SkipRun := true;
                                end else begin
                                    if _Contract."General Expiration Date" <> 0D then
                                        _StartDate := _Contract."General Expiration Date" + 1
                                    else
                                        _StartDate := _Contract."Admin. Exp. Start Date"; //ýˆ«Š± ‰È‹² “ÁŸÀ

                                    if _BaseStartDate > _StartDate then
                                        _StartDate := _BaseStartDate;
                                end;
                            end else begin
                            //Normal!
                            _StartDate := _BaseStartDate;
                            _EndDate := _BaseEndDate;
                        end;
                    end;
                    //<<DK32

                    //--------------------------------------------------------
                    //‘Ž‡ßŸÀ “Œ•
                    _EndDateFilter := _EndDate;

                    if _Contract."Revocation Date" <> 0D then
                        if _Contract."Revocation Date" < _EndDate then
                            _EndDateFilter := _Contract."Revocation Date";
                    //--------------------------------------------------------

                    if not _SkipRun then begin

                        _ContractCnt += 1;                      //ÐŽÊ Œ÷
                        _TotSize += _Contract."Cemetery Size";  //‰ª¬ •€Ë

                        if pAdminExpenseType = LitigaionEvalAmt."Admin. Expense Type"::General then begin
                            //Ÿ‰¦ýˆ«Š±
                            _NonPayAmt += _Contract."Non-Pay. General Amount";    //‰œ‚‚
                                                                                  //>> #2152
                            _ElapsedAmt := _AdminExpenseMgt.GetCalcFuturePreiodExpAmt(_Contract, 0, _StartDate, _EndDateFilter);
                            _PayAmt += _ElapsedAmt; //Œ€‚‚
                            if _Contract."Non-Pay. General Amount" <> 0 then
                                _ElapsedSumAmt += _ElapsedAmt //‰œ‚‚œ ´„’ ÐŽÊ— Œ€‚‚
                                                              //<<
                        end else begin
                            //‘†µýˆ«Š±
                            _NonPayAmt += _Contract."Non-Pay. Land. Arc. Amount"; //‰œ‚‚
                                                                                  //>> #2152
                            _ElapsedAmt := _AdminExpenseMgt.GetCalcFuturePreiodExpAmt(_Contract, 1, _StartDate, _EndDateFilter);
                            _PayAmt += _ElapsedAmt; //Œ€‚‚
                            if _Contract."Non-Pay. Land. Arc. Amount" <> 0 then
                                _ElapsedSumAmt += _ElapsedAmt //‰œ‚‚œ ´„’ ÐŽÊ— Œ€‚‚
                                                              //<<
                        end;
                    end;
                until _Contract.Next = 0;
            end;

            //—³Ð
            InsertLitigaionEvaluationAmount(pToday,
                                          _ContractLitiEvauByEmp.Litigation_Evaluation,
                                          _ContractCnt,
                                          _TotSize,
                                          _NonPayAmt,
                                          _PayAmt,
                                          _ContractLitiEvauByEmp.Litigation_Employee_No,
                                          pAdminExpenseType,
                                          _ElapsedSumAmt);

        end;
        _ContractLitiEvauByEmp.Close;
    end;

    local procedure InsertLitigaionEvaluationAmount(pDate: Date; pLitEval: Option; pTotCnt: Decimal; pTotSize: Decimal; pNonPayAmt: Decimal; pPayAmt: Decimal; pEmpNo: Code[20]; pAdminExpenseType: Option; pElapsedAmt: Decimal)
    begin

        with LitigaionEvalAmt do begin
            Init;
            Date := pDate;                                        //ŸÀ
            "Admin. Expense Type" := pAdminExpenseType;           //ýˆ«Š± »—ý(Ÿ‰¦,‘†µ)
            Validate("Litigation Employee No.", pEmpNo);          //ŒÁ‰½ „Ì„ÏÀ
            "Litigation Evaluation" := pLitEval;                  //ŒÁ‰½ …Ø€Ã
                                                                  //>> #2005
            case pLitEval of                                      //“ñ€— …Ø€Ã
                0, 1, 2, 3:                                            //A~D : „Â€Ë(Short Term)
                    "Bond Type" := "Bond Type"::Shortterm;
                4, 5:                                                //E~F : Î€Ë(Long Term)
                    "Bond Type" := "Bond Type"::Longterm;
            end;
            //<<
            TotalCount := pTotCnt;                                //‰ª¬ Œ÷
            TotalSize := pTotSize;                                //“© ‰ª¬ ˆÒø
            "Non-Pay. Admin Exp. Amount" := pNonPayAmt;           //‰œ‚‚ ýˆ«Š±
            "Admin Exp. Amount" := pPayAmt;                       //Œ€‚‚ ýˆ«Š±
            "Elapsed Amount" := pElapsedAmt;                      //‰œ‚‚œ ´„’ Œ€‚‚ ýˆ«Š±
            Insert;
            ;
        end;
    end;

    local procedure SumLitigaionEvaluationAmount(pDate: Date; pLitEval: Option; pAdminExpenseType: Option)
    var
        _NonPayAmt: Decimal;
        _PayAmt: Decimal;
        _ContractCnt: Decimal;
        _TotSize: Decimal;
        _ElapsedAmt: Decimal;
    begin

        LitigaionEvalAmt.Reset;
        LitigaionEvalAmt.SetRange(Date, pDate);
        LitigaionEvalAmt.SetRange("Admin. Expense Type", pAdminExpenseType);
        LitigaionEvalAmt.SetRange("Litigation Evaluation", pLitEval);
        if LitigaionEvalAmt.FindSet then begin
            LitigaionEvalAmt.CalcSums(TotalCount, TotalSize, "Non-Pay. Admin Exp. Amount", "Admin Exp. Amount", "Elapsed Amount");
            _ContractCnt := LitigaionEvalAmt.TotalCount;
            _TotSize := LitigaionEvalAmt.TotalSize;
            _NonPayAmt := LitigaionEvalAmt."Non-Pay. Admin Exp. Amount";
            _PayAmt := LitigaionEvalAmt."Admin Exp. Amount";
            //>> #2152
            _ElapsedAmt := LitigaionEvalAmt."Elapsed Amount";
            //<<
        end;

        if _ContractCnt <> 0 then begin
            LitigaionEvalAmt.Reset;
            LitigaionEvalAmt.SetRange(Date, pDate);
            LitigaionEvalAmt.SetRange("Admin. Expense Type", pAdminExpenseType);
            LitigaionEvalAmt.SetRange("Litigation Evaluation", pLitEval);
            LitigaionEvalAmt.SetRange("Litigation Employee No.", '');
            if LitigaionEvalAmt.FindSet then begin
                LitigaionEvalAmt.TotalCount := _ContractCnt;
                LitigaionEvalAmt.TotalSize := _TotSize;
                LitigaionEvalAmt."Non-Pay. Admin Exp. Amount" := _NonPayAmt;
                LitigaionEvalAmt."Admin Exp. Amount" := _PayAmt;
                //>> #2152
                LitigaionEvalAmt."Elapsed Amount" := _ElapsedAmt;
                //<<
                LitigaionEvalAmt.Modify;
            end else begin
                //>> #2152
                InsertLitigaionEvaluationAmount(pDate,
                                            pLitEval,
                                            _ContractCnt,
                                            _TotSize,
                                            _NonPayAmt,
                                            _PayAmt,
                                            '',
                                            pAdminExpenseType,
                                            _ElapsedAmt);
                //<<
            end;
        end;
    end;
}

