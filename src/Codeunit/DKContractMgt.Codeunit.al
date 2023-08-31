codeunit 50006 "DK_Contract Mgt."
{
    // *DK32: 20200715
    //   - Add Function : UpdateContract
    //   - Modify Function : UpdateCorpsetoChangeCemeteryStatus
    // 
    // *DK34: 20201022
    //   - Add Function : ExchangeOfLand, ExchangeOfLandCancel
    // 
    // *DK#2588 210705


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'There are %1 or %2 Receipt processed. Total Receipt Amount : %3, can not continue.';
        MSG002: Label '%2 or %3 registered in %1 exists. %4:%5';
        MSG003: Label '%1 data exists.';
        MSG004: Label 'Contracts with %1 can not change the %2.';
        MSG005: Label 'Re-generate Admin Expense based on the new General Expiration Date(%2). Would you like to proceed?';
        MSG006: Label 'Complate! General Expiration Date: %1';
        MSG007: Label 'You are not authorized. Please contact your administrator.';
        MSG008: Label 'This contract does not allow the feature to be used.\\(%1: %2, %3: %4)';
        MSG009: Label 'Data %1 already exists. %2: %3';
        MSG010: Label 'This contract does not allow the feature to be used. (%1: %2)';
        MSG011: Label 'ý€Ë…˜ ¯€¦‰«Œ¡í ‘ˆÏ—³„Ÿ„¾. %1: %2';
        MSG012: Label 'Contract Complete. Status: %1';
        MSG013: Label 'Contract Cancel. Status: %1';
        MSG014: Label 'ŠŽ˜Àí ‘ˆÏ—³„Ÿ„¾. ‹Ð‘ª ˜” „¾“ “……—¹‘´ŒŒÍ.';


    procedure CheckContract(pContract: Record DK_Contract): Boolean
    begin
        pContract.TestField("Contract Date");

        exit(true);
    end;


    procedure SetContract(pContract: Record DK_Contract)
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
        _NewLineNo: Integer;
    begin

        _ContAmountLedger.Reset;
        _ContAmountLedger.SetCurrentKey("Contract No.", "Line No.");
        _ContAmountLedger.SetRange("Contract No.", pContract."No.");
        if _ContAmountLedger.FindLast then
            _NewLineNo := _ContAmountLedger."Line No.";

        //Contract
        //InsertContractAmountLedger(pContract, _NewLineNo, _ContAmountLedger.Type::Contract,
        //                            _ContAmountLedger."Ledger Type"::AR, pContract."Contract Amount");
        //Remaining
        InsertContractAmountLedger(pContract, _NewLineNo, _ContAmountLedger.Type::Remaining,
                                    _ContAmountLedger."Ledger Type"::AR, pContract."Remaining Amount");
    end;


    procedure CheckCancelContract(pContract: Record DK_Contract): Boolean
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayReceiptDocument: Record "DK_Payment Receipt Document";
    begin
        pContract.TestField("Contract Date");

        //Check 1
        _ContAmountLedger.Reset;
        _ContAmountLedger.SetCurrentKey("Contract No.", "Line No.");
        _ContAmountLedger.SetRange("Contract No.", pContract."No.");
        _ContAmountLedger.SetFilter(Type, '%1|%2', _ContAmountLedger.Type::Contract, _ContAmountLedger.Type::Remaining);
        _ContAmountLedger.SetRange("Ledger Type", _ContAmountLedger."Ledger Type"::Receipt);
        if _ContAmountLedger.FindLast then begin
            _ContAmountLedger.CalcSums(Amount);

            if _ContAmountLedger.Amount <> 0 then
                Error(MSG001, pContract.FieldCaption("Contract Amount"), pContract.FieldCaption("Remaining Amount"),
                            _ContAmountLedger.Amount);
        end;


        //Check 2
        _PayReceiptDocLine.Reset;
        _PayReceiptDocLine.SetRange("Contract No.", pContract."No.");
        _PayReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PayReceiptDocLine."Payment Target"::Contract,
                                                               _PayReceiptDocLine."Payment Target"::Remaining);
        if _PayReceiptDocLine.FindLast then begin
            Error(MSG002, _PayReceiptDocument.TableCaption,
                      pContract.FieldCaption("Contract Amount"), pContract.FieldCaption("Remaining Amount"),
                    _PayReceiptDocLine.FieldCaption("Document No."), _PayReceiptDocLine."Document No.");
        end;

        exit(true);
    end;


    procedure CancelContract(pContract: Record DK_Contract)
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
    begin

        _ContAmountLedger.Reset;
        _ContAmountLedger.SetRange("Contract No.", pContract."No.");
        _ContAmountLedger.SetFilter(Type, '%1', _ContAmountLedger.Type::Remaining);
        _ContAmountLedger.SetRange("Ledger Type", _ContAmountLedger."Ledger Type"::AR);
        if _ContAmountLedger.FindFirst then
            _ContAmountLedger.DeleteAll;
    end;

    local procedure InsertContractAmountLedger(pContract: Record DK_Contract; var pNewLineNo: Integer; pType: Option; pLedgerType: Option; pAmount: Decimal)
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
    begin

        if pAmount = 0 then exit;

        pNewLineNo += 10000;

        _ContAmountLedger.Init;
        _ContAmountLedger.Validate("Contract No.", pContract."No.");
        _ContAmountLedger.Validate("Line No.", pNewLineNo);
        _ContAmountLedger.Validate(Type, pType);
        _ContAmountLedger.Validate("Ledger Type", pLedgerType);
        _ContAmountLedger.Validate(Date, pContract."Contract Date");
        _ContAmountLedger.Validate(Amount, -pAmount);
        _ContAmountLedger.Insert(true);
    end;


    procedure ChangeStatus(pContractNo: Code[20]; pContractStatus: Option)
    var
        _Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _Corpse: Record DK_Corpse;
    begin
        //Option0,Option1,Option2,Option3,Option4
        //‰œ–—ˆ•,‰ŽÊ‘÷,ÐŽÊ‘÷,Œ‚‰ª‘÷,œÎ‘÷
        if _Contract.Get(pContractNo) then begin

            if _Cemetery.Get(_Contract."Cemetery Code") then begin
                case pContractStatus of
                    _Contract.Status::Open, _Contract.Status::Contract:
                        begin


                            // DK #2588 210705
                            _Corpse.Reset;
                            _Corpse.SetRange("Contract No.", pContractNo);
                            if _Corpse.FindSet then
                                _Cemetery.Validate(Status, _Cemetery.Status::Laying)
                            else
                                _Cemetery.Validate(Status, _Cemetery.Status::Reserved);
                            _Cemetery.Modify(true);
                            // DK #2588 210705

                        end;
                    _Contract.Status::Reservation:
                        begin
                            // DK #2588 210705
                            _Corpse.Reset;
                            _Corpse.SetRange("Contract No.", pContractNo);
                            if _Corpse.FindSet then
                                _Cemetery.Validate(Status, _Cemetery.Status::Laying)
                            else
                                _Cemetery.Validate(Status, _Cemetery.Status::Reserved);
                            _Cemetery.Modify(true);
                            // DK #2588 210705
                        end;
                    _Contract.Status::FullPayment:
                        begin
                            //_Contract.CALCFIELDS("Corpse Exists");
                            //IF _Contract."Corpse Exists" THEN
                            //  _Cemetery.VALIDATE(Status, _Cemetery.Status::Laying)
                            //ELSE
                            //  _Cemetery.VALIDATE(Status, _Cemetery.Status::Contracted);
                            //_Cemetery.MODIFY(TRUE);
                            // DK #2588 210705
                            _Corpse.Reset;
                            _Corpse.SetRange("Contract No.", pContractNo);
                            if _Corpse.FindSet then
                                _Cemetery.Validate(Status, _Cemetery.Status::Laying)
                            else
                                _Cemetery.Validate(Status, _Cemetery.Status::Contracted);
                            _Cemetery.Modify(true);
                            // DK #2588 210705
                        end;
                    _Contract.Status::Revocation:
                        begin
                            //ŠŽ˜Àí ´Ž·„¾ˆÒ œÎ Ž°Ž·„¾ˆÒ ‰œ–—ˆ•‘÷
                            _Corpse.Reset;
                            _Corpse.SetRange("Contract No.", pContractNo);
                            if _Corpse.FindSet then
                                _Cemetery.Validate(Status, _Cemetery.Status::BeenTransported)
                            else
                                _Cemetery.Validate(Status, _Cemetery.Status::Unsold);

                            _Cemetery.Modify(true);
                        end;
                end;
            end;
        end;
    end;


    procedure ChangeCemeteryCode(pContractNo: Code[20]; pContractStatus: Option; pOldCemeteryCode: Code[20]; pNewCemeteryCode: Code[20])
    var
        _Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _Corpse: Record DK_Corpse;
    begin
        //Option0,Option1,Option2,Option3,Option4
        //‰œ–—ˆ•,‰ŽÊ‘÷,ÐŽÊ‘÷,Œ‚‰ª‘÷,œÎ‘÷

        _Corpse.Reset;
        _Corpse.SetRange("Contract No.", pContractNo);
        _Corpse.SetRange("Cemetery Code", pOldCemeteryCode);
        if _Corpse.FindSet then
            Error(MSG003, _Corpse.TableCaption, _Corpse.FieldCaption("Cemetery Code"));

        if _Contract.Get(pContractNo) then begin
            if _Contract.Status = _Contract.Status::Revocation then
                Error(MSG004, _Contract.Status, _Contract.FieldCaption("Cemetery Code"));

            //x ‰ª¬‰°˜ú„’ ‰œ–—ˆ•‘÷‡ž ‹Ý•’ Š»µ
            if _Cemetery.Get(pOldCemeteryCode) then begin
                _Cemetery.Validate(Status, _Cemetery.Status::Unsold);
                _Cemetery.Modify(true);
            end;

            if _Cemetery.Get(pNewCemeteryCode) then begin
                case pContractStatus of
                    _Contract.Status::Open, _Contract.Status::Contract:
                        begin
                            _Cemetery.Validate(Status, _Cemetery.Status::Reserved);
                            _Cemetery.Modify(true);
                        end;
                    _Contract.Status::FullPayment:
                        begin
                            _Cemetery.Validate(Status, _Cemetery.Status::Contracted);
                            _Cemetery.Modify(true);
                        end;
                end;
            end;
        end else begin
            if _Cemetery.Get(pNewCemeteryCode) then begin
                _Cemetery.Validate(Status, _Cemetery.Status::Reserved);
                _Cemetery.Modify(true);
            end;
        end;
    end;


    procedure ChangeBeforeCemetery()
    begin
    end;


    procedure UpdateCorpsetoChangeCemeteryStatus(pCorpse: Record DK_Corpse; pDel: Boolean)
    var
        _Corpse: Record DK_Corpse;
        _CemeteryCode: Code[20];
        _Cemetery: Record DK_Cemetery;
    begin

        if _Cemetery.Get(pCorpse."Cemetery Code") then begin

            _Corpse.Reset;
            _Corpse.SetRange("Contract No.", pCorpse."Contract No.");
            //_Corpse.SETFILTER("Line No.", '<>%1', pCorpse."Line No.");
            if _Corpse.FindSet then begin
                _Cemetery.Validate(Status, _Cemetery.Status::Laying)
            end;

            _Corpse.Reset;
            _Corpse.SetRange("Contract No.", pCorpse."Contract No.");
            _Corpse.SetFilter("Line No.", '<>%1', pCorpse."Line No.");
            if not _Corpse.FindSet then begin
                if pDel then begin
                    _Cemetery.Validate(Status, _Cemetery.Status::Contracted)
                end else begin
                    _Cemetery.Validate(Status, _Cemetery.Status::Laying);
                end;
            end;
            _Cemetery.Modify(true);

        end;

        UpdateCorpseTemporayPlaceLaying(pCorpse, true);
    end;


    procedure UpdateCorpseTemporayPlaceLaying(var pCorpse: Record DK_Corpse; pLaying: Boolean)
    var
        _Cemetery: Record DK_Cemetery;
    begin

        if pLaying then begin
            if _Cemetery.Get(pCorpse."Temporary Grave Place Code") then begin
                _Cemetery.Validate(Status, _Cemetery.Status::Laying);
                _Cemetery.Modify(true);
            end;
        end else begin
            if _Cemetery.Get(pCorpse."Temporary Grave Place Code") then begin
                _Cemetery.Validate(Status, _Cemetery.Status::Unsold);
                _Cemetery.Modify(true);
            end;
            pCorpse.Validate("Temporary Grave Place Code", '');
            pCorpse."Temporary Grave Date" := 0D;
        end;
    end;


    procedure CheckCorpse(pCorpse: Record DK_Corpse; pContract: Record DK_Contract; pDel: Boolean): Date
    var
        _Corpse: Record DK_Corpse;
    begin
        //>>DK32

        //ŠŽ˜˜” ÐŽÊ …Ñœ• ˜«ž
        _Corpse.Reset;
        _Corpse.SetCurrentKey("Laying Date");
        _Corpse.SetRange("Contract No.", pCorpse."Contract No.");
        _Corpse.SetFilter("Line No.", '<>%1', pCorpse."Line No.");
        _Corpse.SetFilter("Laying Date", '<>%1', 0D);
        if _Corpse.FindSet then begin

            if pCorpse."Laying Date" = 0D then
                exit(_Corpse."Laying Date" - 1);

            if pDel then
                exit(_Corpse."Laying Date" - 1);

            if pCorpse."Laying Date" < _Corpse."Laying Date" then
                exit(pCorpse."Laying Date" - 1)
            else
                exit(_Corpse."Laying Date" - 1);

        end else begin
            if not pDel then
                if pCorpse."Laying Date" <> 0D then
                    exit(pCorpse."Laying Date" - 1);
        end;

        exit(0D);
        //<<DK32
    end;


    procedure ExchangeOfLand(var Rec: Record DK_Contract)
    var
        _EndDate: Date;
    begin
        // DK34

        Rec.CalcFields("Admin. Expense Method", "Estate Code", "Landscape Architecture");

        ExchangeOfLandCheck(Rec);

        if Rec.Status <> Rec.Status::Open then
            Error(MSG010, Rec.FieldCaption(Status), Rec.Status);

        if Rec."Admin. Expense Method" = Rec."Admin. Expense Method"::"After Corpse 10" then begin
            if Rec."Admin. Exp. Start Date" <> 0D then
                _EndDate := Rec."Admin. Exp. Start Date" - 1
            else
                _EndDate := CalcDate('<10Y>', Rec."Contract Date") - 1;
        end else begin
            _EndDate := Rec."Contract Date";
        end;

        Rec.Validate(Status, Rec.Status::FullPayment);

        if _EndDate <> 0D then begin
            Rec.Validate("General Expiration Date", _EndDate);
            Rec."First General Expiration Date" := Rec."General Expiration Date";

            if Rec."Landscape Architecture" then begin
                Rec.Validate("Land. Arc. Expiration Date", _EndDate);
                Rec."First Land. Arc. Exp. Date" := Rec."Land. Arc. Expiration Date";
            end;
        end;

        Rec.Modify(true);

        Message(MSG012, Rec.Status);
    end;


    procedure ExchangeOfLandCancel(var Rec: Record DK_Contract)
    begin
        // DK34

        Rec.CalcFields("Admin. Expense Method", "Estate Code", "Landscape Architecture");

        ExchangeOfLandCheck(Rec);

        if Rec.Status <> Rec.Status::FullPayment then
            Error(MSG010, Rec.FieldCaption(Status), Rec.Status);

        Rec.Validate(Status, Rec.Status::Open);

        Rec.Validate("General Expiration Date", 0D);
        Rec."First General Expiration Date" := 0D;

        if Rec."Landscape Architecture" then begin
            Rec.Validate("Land. Arc. Expiration Date", 0D);
            Rec."First Land. Arc. Exp. Date" := 0D;
        end;

        Rec.Modify(true);

        Message(MSG013, Rec.Status);
    end;

    local procedure ExchangeOfLandCheck(Rec: Record DK_Contract)
    var
        _UserSetup: Record "User Setup";
        _Estate: Record DK_Estate;
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _Corpse: Record DK_Corpse;
    begin
        // DK34

        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Exchange of Land Admin.", true);
        if not _UserSetup.FindSet then
            Error(MSG007);

        if Rec."Admin. Expense Method" <> Rec."Admin. Expense Method"::"After Corpse 10" then begin
            _Estate.Reset;
            _Estate.SetRange(Code, Rec."Estate Code");
            if _Estate.FindSet then
                if _Estate."Group Code" <> 'G0050' then
                    Error(MSG008, Rec.FieldCaption("Admin. Expense Method"), Rec."Admin. Expense Method", _Estate.TableCaption, _Estate."Group Name");
        end;

        if Rec."Pay. Remaining Amount" <> 0 then
            Error(MSG009, Rec.FieldCaption("Pay. Remaining Amount"), Rec.FieldCaption("Pay. Remaining Amount"), Rec."Pay. Remaining Amount");

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.SetRange(Posted, true);
        _PaymentReceiptDocument.SetRange("Contract No.", Rec."No.");
        if _PaymentReceiptDocument.FindSet then
            Error(MSG011, _PaymentReceiptDocument.FieldCaption("Document No."), _PaymentReceiptDocument."Document No.");

        _Corpse.Reset;
        _Corpse.SetRange("Contract No.", Rec."No.");
        if _Corpse.FindSet then
            Error(MSG014);
    end;
}

