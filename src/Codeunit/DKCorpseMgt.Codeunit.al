codeunit 50041 "DK_Corpse Mgt."
{
    // *DK32 : 20200715
    //   - Create


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label '%1 cannot be changed to an empty value.';
        MSG002: Label '%1 has been changed to %2.';
        MSG003: Label '%1 has been changed to %2.';
        MSG004: Label '%3 cannot be changed only if the Status of the contract is %1. Current contract Status: %2';
        MSG005: Label '%2 cannot be changed because a Revocation Contract Document exists. Revocation Contract No. : %1';
        MSG006: Label '%3 cannot be less than %1. %1:%2, %3:%4';


    procedure ChangeLayingDateLookup(pRec: Record DK_Corpse): Date
    var
        _Corpse: Record DK_Corpse;
        _ChangeLayingDate: Page "DK_Change Laying Date";
        _ChangeLayingDateValue: Date;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _Contract: Record DK_Contract;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _BatchDailyAdminExpense: Codeunit "DK_Batch Daily Admin. Expense";
        _RevContract: Record "DK_Revocation Contract";
    begin

        _Corpse.Reset;
        _Corpse.SetRange("Contract No.", pRec."Contract No.");
        _Corpse.SetRange("Line No.", pRec."Line No.");
        if _Corpse.FindSet then begin

            if not _Contract.Get(_Corpse."Contract No.") then
                exit;

            if _Contract.Status <> _Contract.Status::FullPayment then
                Error(MSG004, _Contract.Status::FullPayment, _Contract.Status, pRec.FieldCaption("Laying Date"));

            _RevContract.Reset;
            _RevContract.SetRange("Document Type", _RevContract."Document Type"::Revocation);
            _RevContract.SetRange("Contract No.", _Corpse."Contract No.");
            _RevContract.SetRange(Status, _RevContract.Status::Open);
            if _RevContract.FindSet then
                Error(MSG005, _RevContract."Document No.", pRec.FieldCaption("Laying Date"));

            _ChangeLayingDate.SetRecord(_Corpse);
            _ChangeLayingDate.LookupMode(true);
            if _ChangeLayingDate.RunModal = ACTION::LookupOK then begin

                // _ChangeLayingDateValue := _ChangeLayingDate.GetChangeLayingDate;////zzz

                if _Contract."Contract Date" > _ChangeLayingDateValue then
                    Error(MSG006, _Contract.FieldCaption("Contract Date"), _Contract."Contract Date",
                            _Corpse.FieldCaption("Laying Date"), _Corpse."Laying Date");

                if _ChangeLayingDateValue = _Corpse."Laying Date" then
                    exit;
                if _ChangeLayingDateValue = 0D then
                    Error(MSG001, pRec.FieldCaption("Laying Date"));


                if (_Corpse."First Corpse") then begin
                    //“´“š ŠŽ˜À žµÕˆˆ …Á
                    _Contract.CalcFields("Admin. Expense Method", "Landscape Architecture");
                    if (_Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract) then begin

                        //ýˆ«Š± ¯€¦À‡ß ‹Ð‘ª.!
                        _BatchDailyAdminExpense.DelAdminExpenseLedger(_Contract);

                        if _Contract."Admin. Expense Option" = _Contract."Admin. Expense Option"::"Per Group" then begin
                            //€¸‡ÕÐŽÊíˆˆ ýˆ«Š±í ‰È‹²—¯.!
                            _Contract."General Expiration Date" := 0D;
                            _Contract."Land. Arc. Expiration Date" := 0D;
                        end else begin
                            _Contract."General Expiration Date" := _ChangeLayingDateValue - 1;

                            if (_Contract."Landscape Architecture") then
                                _Contract."Land. Arc. Expiration Date" := _ChangeLayingDateValue - 1
                            else
                                _Contract."Land. Arc. Expiration Date" := 0D;
                        end;

                        _Contract.Modify;
                    end;
                end;

                _Corpse."Laying Date" := _ChangeLayingDateValue;
                _Corpse.Modify;

                if _Corpse."First Corpse" then
                    Message(MSG002, pRec.FieldCaption("Laying Date"), _ChangeLayingDateValue)
                else
                    Message(MSG003, pRec.FieldCaption("Laying Date"), _ChangeLayingDateValue);

            end
        end;
    end;


    procedure DelFirstCorpse(pRec: Record DK_Corpse)
    var
        _Contract: Record DK_Contract;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _BatchDailyAdminExpense: Codeunit "DK_Batch Daily Admin. Expense";
    begin

        if not pRec."First Corpse" then
            exit;

        if not _Contract.Get(pRec."Contract No.") then
            exit;

        //ýˆ«Š± ¯€¦À‡ß ‹Ð‘ª.!
        _BatchDailyAdminExpense.DelAdminExpenseLedger(_Contract);

        _Contract.CalcFields("Landscape Architecture");

        _Contract."General Expiration Date" := 0D;
        _Contract."Land. Arc. Expiration Date" := 0D;

        //¯€¦ŸÀˆª ˜«ž—Ÿ ýˆ«Š± ‘Ž‡ßŸÀ Žð…Ñœ–«
        _Contract."General Expiration Date" := _AdminExpenseMgt.GetMaxExpirationDate(_Contract, _AdminExpenseLedger."Admin. Expense Type"::General);

        //ýˆ«Š± “´“š ‰È‹²ŸÀ Žð…Ñœ–«
        if _Contract."General Expiration Date" = 0D then
            if _Contract."Admin. Exp. Start Date" <> 0D then
                _Contract."General Expiration Date" := _Contract."Admin. Exp. Start Date" - 1;

        if _Contract."Landscape Architecture" then begin
            _Contract."Land. Arc. Expiration Date" := _AdminExpenseMgt.GetMaxExpirationDate(_Contract, _AdminExpenseLedger."Admin. Expense Type"::Landscape);
            //ýˆ«Š± “´“š ‰È‹²ŸÀ Žð…Ñœ–«
            if _Contract."Land. Arc. Expiration Date" = 0D then
                if _Contract."Admin. Exp. Start Date" <> 0D then
                    _Contract."Land. Arc. Expiration Date" := _Contract."Admin. Exp. Start Date" - 1;
        end;

        _Contract.Modify;
    end;
}

