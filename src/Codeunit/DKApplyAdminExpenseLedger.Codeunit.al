codeunit 50015 "DK_Apply Admin. Expense Ledger"
{
    // //ýˆ«Š± Apply €Ë„™ ‘ˆÏ
    // 
    // DK34: 20201123
    //   - Modify Function: FindFirstReceiptLedger


    trigger OnRun()
    begin

        FindReceiptLedger('CD0019899', 0, Today);
    end;

    var
        ToLedger: Record "DK_Admin. Expense Ledger";
        DetailLedger: Record "DK_Detail Admin. Exp. Ledger";


    procedure FindReceiptLedger(pContractNo: Code[20]; pAdminExpenseType: Option; pToday: Date)
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin

        if pToday = 0D then exit;

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", "Admin. Expense Type", "Ledger Type", Date, Open);
        _AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
        _AdminExpenseLedger.SetFilter(Amount, '>0');  //0Šˆ„¾ €¦Ž¸œ •½ °Î
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Receipt);
        //_AdminExpenseLedger.SETFILTER("Remaining Amount",'<>%1', 0);
        _AdminExpenseLedger.SetRange(Open, true);
        if _AdminExpenseLedger.FindSet then begin
            repeat
                ApplyTargetDailyLedger(_AdminExpenseLedger, pToday);

            //_AdminExpenseLedger.Open := FALSE;
            //_AdminExpenseLedger.MODIFY;
            until _AdminExpenseLedger.Next = 0;
        end;
    end;


    procedure ApplyTargetDailyLedger(var pFromLedger: Record "DK_Admin. Expense Ledger"; pToday: Date)
    var
        _ReceiptAmount: Decimal;
        _ApplyAmount: Decimal;
        _ToNewSeq: Integer;
    begin

        ToLedger.Reset;
        ToLedger.SetCurrentKey("Contract No.", Date, "Line No.");
        ToLedger.SetRange("Contract No.", pFromLedger."Contract No.");
        ToLedger.SetRange("Admin. Expense Type", pFromLedger."Admin. Expense Type");
        ToLedger.SetRange("Ledger Type", pFromLedger."Ledger Type"::Daily);
        //ToLedger.SETFILTER(Amount, '<0');  //0Šˆ„¾ €¦Ž¸œ ÁŠ °Î
        ToLedger.SetFilter(Date, '<=%1', pToday);
        //ToLedger.SETFILTER("Remaining Amount",'<%1', 0);
        ToLedger.SetRange(Open, true);
        if ToLedger.FindSet then begin

            pFromLedger.CalcFields("Remaining Amount");
            _ReceiptAmount := pFromLedger."Remaining Amount";

            repeat


                //Seq.
                ToLedger.CalcFields("Detail Max Seq.", "Remaining Amount");
                _ToNewSeq := ToLedger."Detail Max Seq.";

                //Line Amount(+)
                if _ReceiptAmount < -ToLedger."Remaining Amount" then
                    _ApplyAmount := _ReceiptAmount
                else
                    _ApplyAmount := -ToLedger."Remaining Amount";

                //Receipt
                //_NewSeq := DetailLedger.GetNewSequence(ToLedger."Contract No.", ToLedger.Date, ToLedger."Line No.");
                _ToNewSeq += 1;
                DetailLedger.Init;
                DetailLedger."Contract No." := ToLedger."Contract No.";
                DetailLedger.Date := ToLedger.Date;
                DetailLedger."Line No." := ToLedger."Line No.";
                DetailLedger.Sequence := _ToNewSeq;
                DetailLedger."Admin. Expense Type" := ToLedger."Admin. Expense Type";
                DetailLedger."Ledger Type" := pFromLedger."Ledger Type";
                DetailLedger."Source No." := pFromLedger."Source No.";
                DetailLedger."Source Line No." := pFromLedger."Source Line No.";
                DetailLedger.Amount := -_ApplyAmount;
                DetailLedger."Apply Date" := pFromLedger.Date;
                DetailLedger."Apply Line No." := pFromLedger."Line No.";
                DetailLedger.Applied := true;
                DetailLedger.Insert(true);

                //Daily
                _ToNewSeq += 1;
                DetailLedger.Init;
                DetailLedger."Contract No." := ToLedger."Contract No.";
                DetailLedger.Date := ToLedger.Date;
                DetailLedger."Line No." := ToLedger."Line No.";
                //DetailLedger.Date := pFromLedger.Date;
                //DetailLedger."Line No." := pFromLedger."Line No.";
                DetailLedger.Sequence := _ToNewSeq;
                DetailLedger."Admin. Expense Type" := ToLedger."Admin. Expense Type";
                DetailLedger."Ledger Type" := ToLedger."Ledger Type";
                //DetailLedger."Original Amount" := pFromLedger.Amount;
                DetailLedger.Amount := _ApplyAmount;
                DetailLedger."Source No." := pFromLedger."Source No.";
                DetailLedger."Source Line No." := pFromLedger."Source Line No.";
                DetailLedger."Apply Date" := ToLedger.Date;
                DetailLedger."Apply Line No." := ToLedger."Line No.";
                DetailLedger.Applied := true;
                DetailLedger.Insert(true);

                //Update
                if _ApplyAmount = -ToLedger."Remaining Amount" then begin
                    ToLedger.Open := false;
                    ToLedger.Modify;
                end;
                //Sum Apply Balance (-)
                _ReceiptAmount -= _ApplyAmount;

                if _ReceiptAmount = 0 then begin
                    pFromLedger.Open := false;
                    pFromLedger.Modify;
                    exit;
                end;
            until ToLedger.Next = 0;

            if _ReceiptAmount = 0 then
                pFromLedger.Open := false
            else
                pFromLedger.Open := true;

            pFromLedger.Modify
        end;
    end;


    procedure ApplyTargetDailyLedger2_Opening(var pFromLedger: Record "DK_Admin. Expense Ledger"; pToday: Date)
    var
        _ReceiptAmount: Decimal;
        _ApplyAmount: Decimal;
        _ToNewSeq: Integer;
    begin

        ToLedger.Reset;
        ToLedger.SetCurrentKey("Contract No.", Date, "Line No.");
        ToLedger.SetRange("Contract No.", pFromLedger."Contract No.");
        ToLedger.SetRange("Admin. Expense Type", pFromLedger."Admin. Expense Type");
        ToLedger.SetRange("Ledger Type", pFromLedger."Ledger Type"::Daily);
        ToLedger.SetFilter(Date, '<=%1', pToday);
        ToLedger.SetRange("Source No.", pFromLedger."Source No.");

        ToLedger.SetRange(Open, true);
        if ToLedger.FindSet then begin

            pFromLedger.CalcFields("Remaining Amount");
            _ReceiptAmount := pFromLedger."Remaining Amount";

            repeat

                if _ReceiptAmount = 0 then begin
                    pFromLedger.Open := false;
                    pFromLedger.Modify;
                    exit;
                end;

                //Seq.
                ToLedger.CalcFields("Detail Max Seq.", "Remaining Amount");
                _ToNewSeq := ToLedger."Detail Max Seq.";

                //Line Amount(+)
                _ApplyAmount := -ToLedger."Remaining Amount";

                //Receipt
                //_NewSeq := DetailLedger.GetNewSequence(ToLedger."Contract No.", ToLedger.Date, ToLedger."Line No.");
                _ToNewSeq += 1;
                DetailLedger.Init;
                DetailLedger."Contract No." := ToLedger."Contract No.";
                DetailLedger.Date := ToLedger.Date;
                DetailLedger."Line No." := ToLedger."Line No.";
                DetailLedger.Sequence := _ToNewSeq;
                DetailLedger."Admin. Expense Type" := ToLedger."Admin. Expense Type";
                DetailLedger."Ledger Type" := pFromLedger."Ledger Type";
                DetailLedger."Source No." := pFromLedger."Source No.";
                DetailLedger."Source Line No." := pFromLedger."Source Line No.";
                DetailLedger.Amount := -_ApplyAmount;
                DetailLedger."Apply Date" := pFromLedger.Date;
                DetailLedger."Apply Line No." := pFromLedger."Line No.";
                DetailLedger.Applied := true;
                DetailLedger.Insert(true);

                //Daily
                _ToNewSeq += 1;
                DetailLedger.Init;
                DetailLedger."Contract No." := ToLedger."Contract No.";
                DetailLedger.Date := ToLedger.Date;
                DetailLedger."Line No." := ToLedger."Line No.";
                DetailLedger.Sequence := _ToNewSeq;
                DetailLedger."Admin. Expense Type" := ToLedger."Admin. Expense Type";
                DetailLedger."Ledger Type" := ToLedger."Ledger Type";
                //DetailLedger."Original Amount" := pFromLedger.Amount;
                DetailLedger.Amount := _ApplyAmount;
                DetailLedger."Source No." := pFromLedger."Source No.";
                DetailLedger."Source Line No." := pFromLedger."Source Line No.";
                DetailLedger."Apply Date" := ToLedger.Date;
                DetailLedger."Apply Line No." := ToLedger."Line No.";
                DetailLedger.Applied := true;
                DetailLedger.Insert(true);

                //Update
                ToLedger.Open := false;
                ToLedger.Modify;

                //Sum Apply Balance (-)
                _ReceiptAmount -= _ApplyAmount;

            until ToLedger.Next = 0;

            if _ReceiptAmount = 0 then
                pFromLedger.Open := false
            else
                pFromLedger.Open := true;

            pFromLedger.Modify
        end;
    end;


    procedure FindFirstReceiptLedger(pContractNo: Code[20]; pAdminExpType: Option; pSourceNo: Code[20]): Boolean
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _FirstAdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin
        // DK34 ¯€¦…˜ ýˆ«Š± €¦Ž¸œ “´“š ýˆ«Š± ¯€¦ž‘÷ Š±€‚
        // ý€Ë—Ÿ„’ ‰«Œ¡— ß‘ª ŸÀí íÎ “´“šŸ µÕ •€¯ ýˆ«Š±

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Receipt);
        _AdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpType);
        _AdminExpenseLedger.SetRange("Source No.", pSourceNo);
        if _AdminExpenseLedger.FindSet then begin
            _FirstAdminExpenseLedger.Reset;
            _FirstAdminExpenseLedger.SetRange("Contract No.", pContractNo);
            _FirstAdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Receipt);
            _FirstAdminExpenseLedger.SetRange("Admin. Expense Type", pAdminExpType);
            _FirstAdminExpenseLedger.SetRange(Cancel, false);
            _FirstAdminExpenseLedger.SetCurrentKey("Contract No.", Date, "Line No.");
            if _FirstAdminExpenseLedger.FindFirst then begin
                if _FirstAdminExpenseLedger."Source No." = _AdminExpenseLedger."Source No." then
                    exit(true);
            end;
        end;

        exit(false);
    end;
}

