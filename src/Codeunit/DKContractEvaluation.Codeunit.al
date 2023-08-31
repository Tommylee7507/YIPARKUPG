codeunit 50016 "DK_Contract Evaluation"
{
    // 
    // #2718: 2021-08-02
    //   - Create function: UpdateEvaluation2


    trigger OnRun()
    begin
    end;


    procedure UpdateEvaluation(var pContract: Record DK_Contract; pToday: Date)
    var
        _Contract: Record DK_Contract;
        _ArrPreYearNonPay: array[2] of Decimal;
        _ArrCurYearNonPay: array[2] of Decimal;
    begin

        //ý‚Ë…… ‰œ‚‚Šž
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", 0D, CalcDate('<-CY>', pToday) - 1);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

            _ArrPreYearNonPay[1] := _Contract."Non-Pay. General Amount";
            _ArrPreYearNonPay[2] := _Contract."Non-Pay. Land. Arc. Amount";
        end;

        //—÷Ï ‰œ‚‚Šž
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", 0D, pToday);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

            _ArrCurYearNonPay[1] := _Contract."Non-Pay. General Amount";
            _ArrCurYearNonPay[2] := _Contract."Non-Pay. Land. Arc. Amount";
        end;

        //ŒÁ‰½ …Ø€Ãœ B Cí —¹„Ï—Ÿ„’ µÕíˆˆ Š»µœ í„™
        if pContract."Litigation Evaluation" in [pContract."Litigation Evaluation"::B,
                                                  pContract."Litigation Evaluation"::C] then begin

            if (_ArrCurYearNonPay[1] = 0) and (_ArrCurYearNonPay[2] = 0) then begin
                //„Ï—¹‚Ë€Ø‘÷ ‰œ‚‚€¦œ Ž°„’ µÕ
                pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
            end else begin
                if (_ArrPreYearNonPay[1] = 0) or (_ArrPreYearNonPay[2] = 0) then begin
                    //ý‚Ë……€Ø‘÷ ‰œ‚‚€¦œ Ž°„’ µÕ
                    pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                    //      END ELSE BEGIN
                    //‰œ‚‚€¦œ ´„’ µÕ
                    //pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                end;
            end;

            pContract.Modify;
        end;
    end;


    procedure UpdateEvaluation2(var pContract: Record DK_Contract; pToday: Date)
    var
        _Contract: Record DK_Contract;
        _PreDate: Date;
        _CurrDate: Date;
        _GenNonPayS: Decimal;
        _GenNonPayA: Decimal;
        _GenNonPayB: Decimal;
        _GenNonPayC: Decimal;
        _GenNonPayE: Decimal;
        _GenNonPayD: Decimal;
    begin
        // ŒÁ‰½ …Ø€Ã Žð…Ñœ–«

        //ŒÁ‰½ …Ø€Ãœ A/Dž µÕ ‘ªÂ
        //IF pContract."Litigation Evaluation" IN [pContract."Litigation Evaluation"::A,
        //                                         pContract."Litigation Evaluation"::D] THEN BEGIN
        // 20220328 Œ÷‘ñ
        if pContract."Litigation Evaluation" in [pContract."Litigation Evaluation"::A]
                                                 then begin
            exit;
        end;


        // —÷Ï ‚»’Ñ: 2021-08-02
        // A…Ø€Ã - „Ï—¹‚Ë…… ‰œ‚‚ (0 ~ —÷Ï)
        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", 0D, pToday);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount");

            _GenNonPayS := _Contract."Non-Pay. General Amount"
        end;

        // A…Ø€Ã - „Ï—¹‚Ë…… ‰œ‚‚ (2021-01-01 ~ —÷Ï)
        _PreDate := CalcDate('<-CY>', pToday);
        _CurrDate := pToday;

        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", _PreDate, _CurrDate);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount");

            _GenNonPayA := _Contract."Non-Pay. General Amount"
        end;

        // B…Ø€Ã - ý‚Ë…… ‰œ‚‚ (2020-01-01 ~ 2020-12-31)
        _PreDate := CalcDate('<-CY>', CalcDate('<-CY>', pToday) - 1);
        _CurrDate := CalcDate('<-CY>', pToday) - 1;

        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", _PreDate, _CurrDate);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount");

            _GenNonPayB := _Contract."Non-Pay. General Amount";
        end;

        // C…Ø€Ã - 3‚Ë ‰œ‚‚ (2018-01-01 ~ 2019-12-31)
        _PreDate := CalcDate('<-CY>', CalcDate('<-3Y>', pToday));
        _CurrDate := CalcDate('<CY>', CalcDate('<-2Y>', pToday));

        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", _PreDate, _CurrDate);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount");

            _GenNonPayC := _Contract."Non-Pay. General Amount";
        end;

        // D…Ø€Ã - 5‚Ë ‰œ‚‚ (2017.01.01.~2018.12.31.)
        _PreDate := CalcDate('<-CY>', CalcDate('<-5Y>', pToday));
        _CurrDate := CalcDate('<CY>', CalcDate('<-4Y>', pToday));

        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", _PreDate, _CurrDate);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount");

            _GenNonPayD := _Contract."Non-Pay. General Amount";
        end;

        // E…Ø€Ã - 5‚Ëœ‹Ý ‰œ‚‚ ( ~ 2017-12-31)
        _CurrDate := CalcDate('<CY>', CalcDate('<-5Y>', pToday));

        _Contract.Reset;
        _Contract.SetRange("No.", pContract."No.");
        _Contract.SetRange("Date Filter", 0D, _CurrDate);
        if _Contract.FindSet then begin
            _Contract.CalcFields("Non-Pay. General Amount");

            _GenNonPayE := _Contract."Non-Pay. General Amount";
        end;

        // ŒÁ‰½ …Ø€Ãœ B/C/E/Fí —¹„Ï—Ÿ„’ µÕíˆˆ Š»µœ í„™
        // …Ø€Ã— ‹Ý’ˆˆ —Ÿ€Ë †º‰«í, ó —÷Ï …Ø€ÃŠˆ„¾ ‚ÞŠ €Ë‘¹—Ñˆˆ Š±€‚—©„¾.
        // 2022 03 28 Š»µ ŒÁ‰½ …Ø€Ãœ B/C/D/E/Fí —¹„Ï—Ÿ„’ µÕíˆˆ Š»µœ í„™
        // …Ø€Ã— ‹Ý’ˆˆ —Ÿ€Ë †º‰«í, ó —÷Ï …Ø€ÃŠˆ„¾ ‚ÞŠ €Ë‘¹—Ñˆˆ Š±€‚—©„¾.

        case pContract."Litigation Evaluation" of
            pContract."Litigation Evaluation"::B:   // B…Ø€Ã
                begin
                    if _GenNonPayB <> 0 then begin
                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                        pContract.Validate("Department Code", 'T004');
                    end else
                        if (_GenNonPayS = 0) or (_GenNonPayA <> 0) then begin
                            pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                            pContract.Validate("Department Code", 'T006');
                        end;
                end;
            pContract."Litigation Evaluation"::C:   // C…Ø€Ã
                begin
                    if _GenNonPayC <> 0 then begin
                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                        pContract.Validate("Department Code", 'T004');
                    end else
                        if _GenNonPayB <> 0 then begin
                            pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                            pContract.Validate("Department Code", 'T004');
                        end else
                            if (_GenNonPayS = 0) or (_GenNonPayA <> 0) then begin
                                pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                                pContract.Validate("Department Code", 'T006');
                            end;
                end;
            pContract."Litigation Evaluation"::D:   // D…Ø€Ã
                begin
                    if _GenNonPayD <> 0 then begin
                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::D;
                        pContract.Validate("Department Code", 'T004');
                    end else
                        if _GenNonPayC <> 0 then begin
                            pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                            pContract.Validate("Department Code", 'T004');
                        end else
                            if _GenNonPayB <> 0 then begin
                                pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                                pContract.Validate("Department Code", 'T004');
                            end else
                                if (_GenNonPayS = 0) or (_GenNonPayA <> 0) then begin
                                    pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                                    pContract.Validate("Department Code", 'T006');
                                end;
                end;
            pContract."Litigation Evaluation"::E:   // E…Ø€Ã
                begin
                    if _GenNonPayE <> 0 then begin
                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::E;
                        pContract.Validate("Department Code", 'T004');
                    end else
                        if _GenNonPayD <> 0 then begin
                            pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::D;
                            pContract.Validate("Department Code", 'T004');
                        end else
                            if _GenNonPayC <> 0 then begin
                                pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                                pContract.Validate("Department Code", 'T004');
                            end else
                                if _GenNonPayB <> 0 then begin
                                    pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                                    pContract.Validate("Department Code", 'T004');
                                end else
                                    if (_GenNonPayS = 0) or (_GenNonPayA <> 0) then begin
                                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                                        pContract.Validate("Department Code", 'T006');
                                    end;
                end;
            pContract."Litigation Evaluation"::F:   // F…Ø€Ãí „Ô—© €Ë‘¹—Ñí Ž°€Ë †º‰«í E…Ø€Ã €Ë‘¹í ˆ’ˆˆÒ ‹Ý’
                begin
                    if _GenNonPayE <> 0 then begin
                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::E;
                        pContract.Validate("Department Code", 'T004');
                    end else
                        if _GenNonPayD <> 0 then begin
                            pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::D;
                            pContract.Validate("Department Code", 'T004');
                        end else
                            if _GenNonPayC <> 0 then begin
                                pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::C;
                                pContract.Validate("Department Code", 'T004');
                            end else
                                if _GenNonPayB <> 0 then begin
                                    pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::B;
                                    pContract.Validate("Department Code", 'T004');
                                end else
                                    if (_GenNonPayS = 0) or (_GenNonPayA <> 0) then begin
                                        pContract."Litigation Evaluation" := _Contract."Litigation Evaluation"::A;
                                        pContract.Validate("Department Code", 'T006');
                                    end;
                end;
        end;

        pContract.Modify;
    end;
}

