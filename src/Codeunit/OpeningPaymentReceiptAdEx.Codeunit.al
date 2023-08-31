codeunit 60005 "Opening Payment Receipt Ad. Ex"
{
    // ýˆ«Š± õ—³ÐÔˆ‡ž ˆˆ…Ï ”À…Î»„´ ‹ÏÔŽ˜—¯


    trigger OnRun()
    begin


        CreateMonthlyAdminExpenseSum;

        Message('Complate');
    end;

    var
        MSG001: Label 'Processing Genral Contract  @1@@@@@@@@@@\';
        Window: Dialog;

    local procedure CreateMonthlyAdminExpenseSum()
    var
        _Contract: Record DK_Contract;
        _LoopDate: Record Date;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin
        _Contract.Reset;
        //_Contract.SETFILTER("Land. Arc. Expiration Date", '>=%1', 190101D);
        _Contract.SetFilter("General Expiration Date", '>=%1', 20190101D);
        if _Contract.FindSet then begin

            if GuiAllowed then
                Window.Open(MSG001);
            _MaxLoop := _Contract.Count;
            repeat
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
                        _AdminExpenseLedger2.Date := 20181231D;
                        //_AdminExpenseLedger2."Line No." := 11;
                        _AdminExpenseLedger2."Line No." := 12;
                        _AdminExpenseLedger2."Admin. Expense Type" := _AdminExpenseLedger."Admin. Expense Type";
                        _AdminExpenseLedger2."Ledger Type" := _AdminExpenseLedger2."Ledger Type"::Receipt;
                        _AdminExpenseLedger2."Source No." := 'OPENING';
                        _AdminExpenseLedger2.Amount := Abs(_AdminExpenseLedger.Amount);
                        _AdminExpenseLedger2.Insert(true);
                    end;
                end;

            until _Contract.Next = 0;
            if GuiAllowed then
                Window.Close;
        end;
    end;

    local procedure DeleteMonthlyAdminExpense()
    var
        _Contract: Record DK_Contract;
        _LoopDate: Record Date;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin

        _AdminExpenseLedger.Reset;
        //_AdminExpenseLedger.SETRANGE("Contract No.", _Contract."No.");
        _AdminExpenseLedger.SetRange(Date, 20190101D, 20190630D);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::General);
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
        _AdminExpenseLedger.SetFilter("Line No.", '%1', 11);
        if _AdminExpenseLedger.FindSet then begin
            _AdminExpenseLedger.DeleteAll(true);
        end;


        _AdminExpenseLedger.Reset;
        //_AdminExpenseLedger.SETRANGE("Contract No.", _Contract."No.");
        _AdminExpenseLedger.SetRange(Date, 20190101D, 20190630D);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::Landscape);
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
        _AdminExpenseLedger.SetFilter("Line No.", '%1', 10);
        if _AdminExpenseLedger.FindSet then begin
            _AdminExpenseLedger.DeleteAll(true);
        end;

    end;

    local procedure DeleteMonthlyAdminExpense2()
    var
        _Contract: Record DK_Contract;
        _LoopDate: Record Date;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _Loop: Integer;
        _MaxLoop: Integer;
    begin
        _Contract.Reset;
        _Contract.SetRange("No.", 'CD0000334');
        if _Contract.FindSet then begin

            if GuiAllowed then
                Window.Open(MSG001);
            _MaxLoop := _Contract.Count;
            repeat
                _Loop += 1;
                Window.Update(1, Round(_Loop * 10000 / _MaxLoop, 1));

                _AdminExpenseLedger.Reset;
                _AdminExpenseLedger.SetRange("Contract No.", _Contract."No.");
                _AdminExpenseLedger.SetRange("Admin. Expense Type", _AdminExpenseLedger."Admin. Expense Type"::Landscape);
                _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
                if _AdminExpenseLedger.FindSet then begin
                    _AdminExpenseLedger.DeleteAll(true);
                end;

                _Contract."Land. Arc. Expiration Date" := 0D;
            until _Contract.Next = 0;


            if GuiAllowed then
                Window.Close;

        end;
    end;
}

