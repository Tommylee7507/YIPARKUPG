codeunit 50007 "DK_Payment Receipt - Post"
{
    // 
    // //ýˆ«Š± Apply €Ë„™ ‘ˆÏ
    // //CRM ¼…
    // 
    // *DK32 : 20200715
    //   - Modify Function : Check
    //                       Post
    //                       UpdateContract
    // 
    // #2224 : 20201023
    //   - Modify Function : Postcancel
    // 
    // DK34: 20201123
    //   - Modify Function : Post, PostCancel
    // 
    // #2294: 20201215
    //   - Modify Function : Post
    // 
    // #2363: 20210118
    //   - Modify Function : RefundPost2
    // 
    // #2451: 20210219
    //   - Modify Function : PostCancel
    // 
    // #2517: 20210803
    //   - Modify Function : Post


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The posting Data does not exist.';
        MSG002: Label 'The value of the %2 in the %1 is (0). can''t Posting.';
        MSG003: Label 'There is a balance in the amount available. Available Amount:%2';
        MSG004: Label 'No %1 is specified. Do you want to Posting the Document with an unconfirmed %1?';
        MSG005: Label 'Do you want to posting?';
        ContAmountLedger: Record "DK_Contract Amount Ledger";
        AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        MSG006: Label 'There is a %1 in this contract. %1:%2';
        MSG007: Label 'You can not put %2 in %1 document.';
        MSG008: Label 'No amount exists in posting target %1. %1:%2';
        MSG009: Label 'Do you want to posting?';
        MSG010: Label 'Do you want to posting?';
        MSG011: Label '%1 is not specified.';
        MSG012: Label 'For %1, the reason must be entered in %2.';
        MSG013: Label 'Combines landscaping and general administrative expenses. Do you want to continue?';
        MSG014: Label 'The Contract No. change operation has been canceled.';
        MSG015: Label 'The contract No. of this posted Payment Receipt Document has been changed from %1 to %2.';
        MSG016: Label 'Posting Stoped!';
        MSG017: Label 'Do you want to posting?';
        MSG018: Label 'Stop Processing.';
        MSG019: Label 'Do you want to continue changing the contract number?';
        CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
        MSG020: Label 'The text that is automatically sent is not set. %1: %2 (%3)';
        MSG021: Label 'The date is not correct. Delete the line and enter it again.';
        MSG022: Label 'The date is not correct. Delete the line and enter it again.';
        MSG023: Label 'The sum of the contracted amounts cannot exceed %1 %2.';
        MSG024: Label '%1 %2 specified in this document is not the same as %3 %4 in the agreement.';
        MSG025: Label 'Please specify %1';
        MSG026: Label 'This %1 %2 has already been refunded. %3: %4';
        MSG027: Label 'This Posted Payment Receipt Document cannot be canceled. After this, there is a Posted Payment Receipt Document  with additional processing Posting. The Posted Payment Receipt Document  %1 must be canceled first.';
        MSG028: Label 'This Posted Payment Receipt Document cannot be Refund. After this, there is a Posted Payment Receipt Document  with additional processing Posting. The Posted Payment Receipt Document  %1 must be Refund first.';
        MSG029: Label 'This document has already been refunded. Refund Document No.: %1';
        MSG030: Label '%3 does not exist in %1 %2.';


    procedure Check(pRec: Record "DK_Payment Receipt Document"): Boolean
    var
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Contract: Record DK_Contract;
        _ValidatePostingDateMgt: Codeunit "DK_ValidatePostingDate Mgt.";
        _SMS: Record DK_SMS;
        _TotalContractAmount: Decimal;
    begin
        pRec.TestField("Posting Date");

        if pRec."Document Type" <> pRec."Document Type"::Refund then
            _ValidatePostingDateMgt.ValidatePostingDate(pRec."Posting Date");

        if pRec."Payment Type" = pRec."Payment Type"::None then
            Error(MSG011, pRec.FieldCaption("Payment Type"));

        if pRec."Payment Type" = pRec."Payment Type"::DebtRelief then
            if pRec.Description = '' then
                Error(MSG012, pRec."Payment Type", pRec.FieldCaption(Description));


        if pRec."Document Type" = pRec."Document Type"::Receipt then begin
            //RECEIPT
            if pRec."Final Amount" <= 0 then begin
                pRec.CalcFields("Litigation Bank Account");
                if pRec."Litigation Bank Account" then begin
                    Error(MSG008, pRec.FieldCaption("Final Amount"), pRec."Final Amount");
                end else begin
                    Error(MSG008, pRec.FieldCaption(Amount), pRec.Amount);
                end;
            end;

            case pRec."Payment Type" of
                pRec."Payment Type"::Bank:
                    begin
                        pRec.TestField("Bank Account Code");
                    end;
                pRec."Payment Type"::Card:
                    begin
                        pRec.TestField("Payment Method Code");
                    end;
            end;

            if not pRec."Missing Contract" then begin
                pRec.TestField("Contract No.");

                if pRec."Issued Cash Receipts" then begin
                    pRec.TestField("Issued Cash Rec. Date");
                    pRec.TestField("Issued Cash Rec. Mobile");
                    pRec.TestField("Cash Bill Approval No.");

                end;
                if pRec."Issued TAX Bill" then
                    pRec.TestField("Issued TAX Bill Date");

                pRec.CalcFields("Total Amount");
                if pRec."Final Amount" <> pRec."Total Amount" then
                    Error(MSG003, pRec.FieldCaption("Final Amount"), (pRec.Amount - pRec."Total Amount"));

                _Contract.Get(pRec."Contract No.");
                _Contract.CalcFields("Admin. Expense Method");//DK32

                if _Contract."Cemetery Code" <> pRec."Cemetery Code" then
                    Error(MSG024, _Contract.FieldCaption("Cemetery Code"),
                              _Contract."Cemetery Code",
                              pRec.FieldCaption("Cemetery Code"),
                              pRec."Cemetery Code");

                if _Contract."Cemetery No." <> pRec."Cemetery No." then
                    Error(MSG024, _Contract.FieldCaption("Cemetery No."),
                              _Contract."Cemetery No.",
                              pRec.FieldCaption("Cemetery No."),
                              pRec."Cemetery No.");

                _PayRecDocLine.Reset;
                _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
                if _PayRecDocLine.FindSet then begin
                    repeat
                        if _PayRecDocLine.Amount = 0 then
                            Error(MSG002, _PayRecDocLine."Payment Target", _PayRecDocLine.FieldCaption(Amount));

                        //Check New Contract

                        if _Contract."Pay. Remaining Amount" <> 0 then begin
                            if (_PayRecDocLine."Payment Target" in [_PayRecDocLine."Payment Target"::Service,
                                                                    _PayRecDocLine."Payment Target"::General,
                                                                    _PayRecDocLine."Payment Target"::Landscape]) then
                                Error(MSG006, _Contract.FieldCaption("Pay. Remaining Amount"),
                                              _Contract."Pay. Remaining Amount",
                                              _PayRecDocLine."Payment Target"::General,
                                              _PayRecDocLine."Payment Target"::Landscape,
                                              _PayRecDocLine."Payment Target"::Service,
                                              _PayRecDocLine.FieldCaption("Payment Target"));
                        end;

                        case _PayRecDocLine."Payment Target" of
                            _PayRecDocLine."Payment Target"::Service:
                                begin
                                    if _PayRecDocLine."Cem. Services No." = '' then
                                        Error(MSG025, _PayRecDocLine.FieldCaption("Cem. Services No."));
                                end;
                            _PayRecDocLine."Payment Target"::General,
                            _PayRecDocLine."Payment Target"::Landscape:
                                begin

                                    //>>DK32
                                    //Check Date
                                    if _PayRecDocLine."Start Date" = 0D then
                                        Error(MSG030, _PayRecDocLine.FieldCaption("Payment Target"), _PayRecDocLine."Payment Target", _PayRecDocLine.FieldCaption("Start Date"));

                                    if _PayRecDocLine."Expiration Date" = 0D then
                                        Error(MSG030, _PayRecDocLine.FieldCaption("Payment Target"), _PayRecDocLine."Payment Target", _PayRecDocLine.FieldCaption("Expiration Date"));

                                    if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then begin
                                        if (_Contract."General Expiration Date" + 1) <> _PayRecDocLine."Start Date" then
                                            Error(MSG021, _Contract.FieldCaption("General Expiration Date"), _Contract."General Expiration Date", (_Contract."General Expiration Date" + 1));

                                    end else begin
                                        if (_Contract."Land. Arc. Expiration Date" + 1) <> _PayRecDocLine."Start Date" then
                                            Error(MSG022, _Contract.FieldCaption("Land. Arc. Expiration Date"), _Contract."Land. Arc. Expiration Date", (_Contract."Land. Arc. Expiration Date" + 1));
                                    end;
                                    //>>DK32
                                end;
                            _PayRecDocLine."Payment Target"::Deposit,
                            _PayRecDocLine."Payment Target"::Contract,
                            _PayRecDocLine."Payment Target"::Remaining:
                                begin
                                    //ÐŽÊý‡“ €¦Ž¸ —³Ð
                                    _TotalContractAmount += _PayRecDocLine.Amount;
                                end;
                        end;
                    until _PayRecDocLine.Next = 0;
                    //‰Â“‚ˆ« DK TOMMY
                    if _PayRecDocLine."Document No." = 'PRD0149490' then begin
                    end else begin

                        //ÐŽÊ— ‚Š €¦Ž¸— —³Ðˆª ‘†·—Ÿ„’‘÷ ˜«ž
                        if _Contract."Pay. Remaining Amount" < _TotalContractAmount then
                            Error(MSG023, _Contract.FieldCaption("Pay. Remaining Amount"),
                                    _Contract."Pay. Remaining Amount",
                                    _TotalContractAmount);
                    end;
                end;
            end;
        end else begin
            //REFUND
            if pRec."Target Doc. No." = '' then
                Error(MSG011, pRec.FieldCaption("Target Doc. No."));

            pRec.CalcFields(Refund, "Refund Document No.");
            if (pRec."Refund Document No." <> pRec."Document No.") then begin

                if pRec.Refund then begin
                    Error(MSG026, pRec.FieldCaption("Target Doc. No."),
                                  pRec."Target Doc. No.",
                                  pRec.FieldCaption("Refund Document No."),
                                  pRec."Refund Document No.");
                    //œ %1 %2Š(„’) œ‰œ ˜»Š­ ý€Ë“‚ˆ«í Ÿ‡ß…—Ž·„Ÿ„¾. %3: %4

                end else begin

                    //      ERROR(MSG011, pRec.FIELDCAPTION("Target Doc. No."),
                    //                    pRec."Target Doc. No.",
                    //                    pRec.FIELDCAPTION("Refund Document No."),
                    //                    pRec."Refund Document No.");
                    //                    //œ %1 %2Š(„’) œ‰œ ˜»Š­ ý€Ë“‚ˆ«í Ÿ‡ß…—Ž·„Ÿ„¾. %3: %4

                end;
            end;


            //IF pRec.Amount < 0 THEN BEGIN
            //  ERROR(MSG008, pRec.FIELDCAPTION(Amount), pRec.Amount);
            //END;
        end;
        exit(true);
    end;


    procedure Post(var pRec: Record "DK_Payment Receipt Document"; pShowMsg: Boolean)
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _NewLineNo: Integer;
        _Type: Option;
        _ReceiptGeneral: Boolean;
        _ReceiptLandscape: Boolean;
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _CemeteryServices: Record "DK_Cemetery Services";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _Contract: Record DK_Contract;
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _ContractEvaluation: Codeunit "DK_Contract Evaluation";
        _ChangeEvaluation: Codeunit "DK_Change Evaluation";
        _SMSSending: Codeunit "DK_Batch SMS Sending";
        _FunctionSetup: Record "DK_Function Setup";
        _SMS: Record DK_SMS;
        _SMSMessage: Text;
        _CompanyInformation: Record "Company Information";
        _FindContract: Record DK_Contract;
    begin
        Clear(_ReceiptGeneral);
        Clear(_ReceiptLandscape);

        if not Check(pRec) then exit;

        if pRec."Missing Contract" then begin
            if GuiAllowed and pShowMsg then
                if not Confirm(MSG004, false, pRec.FieldCaption("Contract No."),
                                              pRec.FieldCaption("Missing Contract")) then
                    exit;
        end else begin

            pRec.CalcFields("Litigation Bank Account");
            if pRec."Litigation Bank Account" then begin

                if (pRec.Division = false) and
                    (pRec."Legal Amount" = 0) and
                    (pRec."Advance Payment Amount" = 0) and
                    (pRec."Delay Interest Amount" = 0) and
                    (pRec."MTG Amount" = 0) and
                    (pRec."Move The Grave" = false) and
                    (pRec."Reduction Amount" = 0) and
                    (pRec."Withdraw Mothed" = '') and
                    (pRec."Litigation Ramark" = '') then begin

                    if GuiAllowed and pShowMsg then
                        if not Confirm(MSG010, false) then exit;
                end else begin
                    if GuiAllowed and pShowMsg then
                        if not Confirm(MSG009, false) then exit;
                end;
            end else begin
                _PayRecDocLine.Reset;
                _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
                _PayRecDocLine.SetRange(Amount);
                _PayRecDocLine.SetFilter("Payment Target", '%1|%2', _PayRecDocLine."Payment Target"::General,
                                                                    _PayRecDocLine."Payment Target"::Landscape);

                _PayRecDocLine.SetFilter("Diff. Amount", '<0');
                if _PayRecDocLine.FindSet then begin
                    if GuiAllowed and pShowMsg then
                        if not Confirm(MSG017, false) then
                            Error(MSG016);
                end else begin
                    if GuiAllowed and pShowMsg then
                        if not Confirm(MSG005, false) then exit;
                end;
            end;
        end;

        //IF pRec."Contract No." = '20220830006' THEN
        //  MESSAGE('S2');

        if _Contract.Get(pRec."Contract No.") then begin

            //IF pRec."Contract No." = '20220830006' THEN
            //  MESSAGE('S3');

            //1.Contract Amount
            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
            _PayRecDocLine.SetFilter("Payment Target", '%1|%2|%3',
                                                  _PayRecDocLine."Payment Target"::Deposit,
                                                  _PayRecDocLine."Payment Target"::Contract,
                                                  _PayRecDocLine."Payment Target"::Remaining);
            if _PayRecDocLine.FindFirst then begin

                _NewLineNo := LastLineNo_ContAmountLedger(pRec);

                repeat
                    case _PayRecDocLine."Payment Target" of
                        _PayRecDocLine."Payment Target"::Deposit:
                            begin

                                _Type := ContAmountLedger.Type::Deposit;
                                //‰œŒ÷€¦ ‹²ŒŠŠ Ÿ„Â ‹²‡½
                                //InsertContractAmountLedger(pRec, _PayRecDocLine,_NewLineNo,_Type,ContAmountLedger."Ledger Type"::AR,-_PayRecDocLine.Amount,'');
                            end;
                        _PayRecDocLine."Payment Target"::Contract:
                            begin

                                _Type := ContAmountLedger.Type::Contract;
                                //‰œŒ÷€¦ ‹²ŒŠŠ Ÿ„Â ‹²‡½
                                //InsertContractAmountLedger(pRec, _PayRecDocLine,_NewLineNo,_Type,ContAmountLedger."Ledger Type"::AR,-_PayRecDocLine.Amount,'');
                            end;
                        _PayRecDocLine."Payment Target"::Remaining:
                            begin
                                _Type := ContAmountLedger.Type::Remaining;
                            end;
                    end;

                    //Ledger
                    InsertContractAmountLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, ContAmountLedger."Ledger Type"::Receipt, _PayRecDocLine.Amount, '');

                    //IF pRec."Contract No." = '20220830006' THEN
                    //  MESSAGE('Up1, %1,%2,%3',_PayRecDocLine,_Type,_Contract);
                    //Contract
                    UpdateContract(pRec, _PayRecDocLine, _Type, _Contract);


                //IF pRec."Contract No." = '20220830006' THEN
                //  MESSAGE('Up2');

                until _PayRecDocLine.Next = 0;

                _ReceiptGeneral := true;
                _Contract.CalcFields("Landscape Architecture");
                if _Contract."Landscape Architecture" then
                    _ReceiptLandscape := true;
            end;

            //2 Service
            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
            _PayRecDocLine.SetFilter("Payment Target", '%1',
                                                  _PayRecDocLine."Payment Target"::Service);
            if _PayRecDocLine.FindSet then begin

                _NewLineNo := LastLineNo_ContAmountLedger(pRec);
                _Type := ContAmountLedger.Type::Service;
                repeat
                    UpdateService(_PayRecDocLine, pRec, true);
                    //Ledger
                    InsertContractAmountLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, ContAmountLedger."Ledger Type"::Receipt, _PayRecDocLine.Amount, _PayRecDocLine."Cem. Services No.");
                until _PayRecDocLine.Next = 0;

                _Type := ContAmountLedger.Type::Service;
            end;

            Clear(_NewLineNo);

            //>>DK32
            _Contract.CalcFields("Admin. Expense Method");
            //<<DK32

            //3.Admin. Expense
            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
            _PayRecDocLine.SetFilter("Payment Target", '%1|%2',
                                                  _PayRecDocLine."Payment Target"::General,
                                                  _PayRecDocLine."Payment Target"::Landscape);
            if _PayRecDocLine.FindFirst then begin
                repeat
                    if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then begin
                        _Type := AdminExpenseLedger."Admin. Expense Type"::General;
                        _ReceiptGeneral := true;

                    end else begin
                        _Type := AdminExpenseLedger."Admin. Expense Type"::Landscape;
                        _ReceiptLandscape := true;
                    end;

                    //>>DK32
                    _Contract.CalcFields("First Corpse Exists");
                    if (_Contract."Admin. Expense Method" = _Contract."Admin. Expense Method"::Contract) or
                      ((_Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract) and
                        (_PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General) and
                        (_Contract."First Corpse Exists") and
                        (_Contract."Admin. Exp. Start Date" > Today)) or
                      ((_Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract) and
                        (_PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::Landscape) and
                        (_Contract."First Corpse Exists") and
                        (_Contract."Admin. Exp. Start Date" > Today)) then begin
                        //<<DK32

                        _DetailAdminExpLedger.Reset;
                        _DetailAdminExpLedger.SetCurrentKey("Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.");
                        _DetailAdminExpLedger.SetRange("Contract No.", pRec."Contract No.");
                        _DetailAdminExpLedger.SetRange("Admin. Expense Type", _Type);
                        _DetailAdminExpLedger.SetRange(Date, 0D, pRec."Payment Date");
                        _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
                        if _DetailAdminExpLedger.FindSet then begin
                            _DetailAdminExpLedger.CalcSums(Amount);
                            _PayRecDocLine."Bef. Non-Pay. Amount" := _DetailAdminExpLedger.Amount * -1;
                        end;

                        Clear(_AdminExpenseMgt);
                        if _PayRecDocLine."Diff. Amount" >= 0 then begin
                            InsertAdminExpensetLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, _PayRecDocLine.Amount, false, false);

                            _AdminExpenseMgt.AddAdminExpense(_Contract,
                                                            _Type,
                                                            _PayRecDocLine.Amount,
                                                            _PayRecDocLine."Document No.",
                                                            _PayRecDocLine."Line No.",
                                                            pRec."Payment Date",
                                                            0D,
                                                            false,
                                                            0D);
                        end else begin

                            InsertAdminExpensetLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, _PayRecDocLine.Amount, false, false);

                            _AdminExpenseMgt.AddAdminExpense(_Contract,
                                                            _Type,
                                                            _PayRecDocLine."Period Amount",
                                                            _PayRecDocLine."Document No.",
                                                            _PayRecDocLine."Line No.",
                                                            pRec."Payment Date",
                                                            0D,
                                                            false,
                                                            0D);

                            if _PayRecDocLine."Diff. Amount" <> 0 then begin
                                InsertAdminExpensetLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, Abs(_PayRecDocLine."Diff. Amount"), false, true);

                                _AdminExpenseMgt.AddAdminExpense(_Contract,
                                                                _Type,
                                                                Abs(_PayRecDocLine."Diff. Amount"),
                                                                _PayRecDocLine."Document No.",
                                                                _PayRecDocLine."Line No.",
                                                                pRec."Payment Date",
                                                                _PayRecDocLine."Expiration Date",
                                                                true,
                                                                0D);
                            end;
                        end;
                        //>>DK32
                    end else begin

                        Clear(_AdminExpenseMgt);
                        if _PayRecDocLine."Diff. Amount" >= 0 then begin
                            InsertAdminExpensetLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, _PayRecDocLine.Amount, false, false);

                        end else begin
                            InsertAdminExpensetLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, _PayRecDocLine.Amount, false, false);

                            if _PayRecDocLine."Diff. Amount" <> 0 then
                                InsertAdminExpensetLedger(pRec, _PayRecDocLine, _NewLineNo, _Type, Abs(_PayRecDocLine."Diff. Amount"), false, true);
                        end;
                    end;

                    if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then begin
                        _Contract.Validate("General Expiration Date", _PayRecDocLine."Expiration Date");
                    end else begin
                        _Contract.Validate("Land. Arc. Expiration Date", _PayRecDocLine."Expiration Date");
                    end;
                    //<<DK32


                    //IF pRec."Contract No." = '20220830006' THEN
                    //  MESSAGE('E1');

                    _Contract.Modify;


                    //IF pRec."Contract No." = '20220830006' THEN
                    //  MESSAGE('E2');
                    //CRM
                    Clear(CRMDataInterlink);
                    CRMDataInterlink.OutboundContract(_Contract);
                    //CRM

                    //¯€¦ý ŒÁ‰½ …Ø€Ã ·Î
                    _PayRecDocLine."Befor Liti. Eval." := _Contract."Litigation Evaluation";
                    _PayRecDocLine.Modify(false);
                until _PayRecDocLine.Next = 0;


            end;

            //Posted
            pRec.Posted := true;
            pRec.Modify;



            //---------------------------------------------------------------------------------------------
            //Apply Entry

            // >> DK34
            Commit;
            Clear(_ApplyAdminExLedger);
            if _ReceiptGeneral then begin
                _ApplyAdminExLedger.FindReceiptLedger(pRec."Contract No.", AdminExpenseLedger."Admin. Expense Type"::General, Today);

                _FindContract.Reset;
                _FindContract.CalcFields("Admin. Expense Method");
                _FindContract.SetRange("No.", pRec."Contract No.");
                _FindContract.SetRange("Admin. Expense Method", _FindContract."Admin. Expense Method"::"After Corpse 10");
                if _FindContract.FindSet then
                    pRec."New Admin. Expense" := _ApplyAdminExLedger.FindFirstReceiptLedger(pRec."Contract No.", AdminExpenseLedger."Admin. Expense Type"::General, pRec."Document No.");
            end;

            if _ReceiptLandscape then begin
                _ApplyAdminExLedger.FindReceiptLedger(pRec."Contract No.", AdminExpenseLedger."Admin. Expense Type"::Landscape, Today);

                _FindContract.Reset;
                _FindContract.CalcFields("Admin. Expense Method");
                _FindContract.SetRange("No.", pRec."Contract No.");
                _FindContract.SetRange("Admin. Expense Method", _FindContract."Admin. Expense Method"::"After Corpse 10");
                if _FindContract.FindSet then
                    pRec."New Admin. Expense" := _ApplyAdminExLedger.FindFirstReceiptLedger(pRec."Contract No.", AdminExpenseLedger."Admin. Expense Type"::Landscape, pRec."Document No.");
            end;
            pRec.Modify;
            // <<

            //---------------------------------------------------------------------------------------------

            Commit;

            //==========================================================================================
            //ŒÁ‰½ …Ø€Ã Žð…Ñœ–« (1’ð)
            pRec."Befor Liti. Eval." := _Contract."Litigation Evaluation";
            //Update Evaluation
            Clear(_ContractEvaluation);
            // >> #2517
            // Update Evaluation -> Update Evaluation2
            _ContractEvaluation.UpdateEvaluation2(_Contract, Today);
            // <<

            //ŒÁ‰½ …Ø€Ã Žð…Ñœ–« (2’ð)
            pRec."After Liti. Eval." := _Contract."Litigation Evaluation";
            pRec.Modify;


            //…Ø€Ã Š»µ €Ë‡Ÿ
            //>>#2294
            //_ChangeEvaluation.Insert_ChangeEvaluation(pRec."Befor Liti. Eval.",pRec."After Liti. Eval.",_PayRecDocLine.Amount,pRec."Document No.",_Contract);
            _ChangeEvaluation.Insert_ChangeEvaluationDepartment(pRec."Befor Liti. Eval.", pRec."After Liti. Eval.", pRec."Department Code", pRec."Department Code",
                                                              _PayRecDocLine.Amount, pRec."Document No.", _Contract);
            //<<
            //==========================================================================================

            Commit;

            _FunctionSetup.Get;
            if _FunctionSetup."Use SMS" then begin
                _CompanyInformation.Get;
                if (pRec."Appl. Mobile No." <> '') and
                   (pRec.Amount <> 0) then begin
                    _SMS.Reset;
                    _SMS.SetRange(Type, _SMS.Type::Receipt);
                    if _SMS.FindSet then begin
                        _SMSMessage := _SMSSending.SetMessageType(_SMS.Type, _SMS."Short Message", pRec."Document No.");
                        _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", pRec."Appl. Mobile No.", _CompanyInformation.Name, _SMSMessage, '', '', '', true,
                        _SMS.Type, pRec."Document No.", 0, _SMS."Biz Talk Tamplate No.", pRec."Contract No.");
                    end;
                end;
            end;

            //---------------------------------------------------------------------------------------------
        end else begin

            //Posted
            pRec.Posted := true;
            pRec.Modify;
        end;
    end;


    procedure RefundPost2(pRec: Record "DK_Payment Receipt Document")
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _ContractAmtLedger: Record "DK_Contract Amount Ledger";
        _ContractAmtLedger2: Record "DK_Contract Amount Ledger";
        _ArrBefExpirationDate: array[2] of Date;
        _Contract: Record DK_Contract;
        _ValidatePostingDateMgt: Codeunit "DK_ValidatePostingDate Mgt.";
        _ChangeEvaluation: Codeunit "DK_Change Evaluation";
        _ToNewSeq: Integer;
        _NewLineNo: Integer;
        _PayReceiptDocNo: Code[20];
        _ReqRemLed: Record "DK_Request Remittance Ledger";
    begin



        _PayRecDoc.Reset;
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange("Document No.", pRec."Target Doc. No.");
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange(Refund, false);
        if _PayRecDoc.FindSet then begin

            //-------------------------------------------------------------------
            //œ˜” ýˆ«Š± ¯€¦‰«Œ¡ ‘ˆÏ Šž ˜«ž
            _PayReceiptDocNo := CheckNextPayReceiptRecordExists(_PayRecDoc);
            if _PayReceiptDocNo <> '' then
                Error(MSG028, _PayReceiptDocNo);
            //-------------------------------------------------------------------

            if not Check(pRec) then exit;

            //Admin Expense
            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
            _PayRecDocLine.SetFilter("Payment Target", '%1|%2', _PayRecDocLine."Payment Target"::General,
                                                                _PayRecDocLine."Payment Target"::Landscape);
            if _PayRecDocLine.FindSet then begin
                Clear(_ArrBefExpirationDate);

                repeat
                    if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then
                        _ArrBefExpirationDate[1] := _PayRecDocLine."Start Date"
                    else
                        _ArrBefExpirationDate[2] := _PayRecDocLine."Start Date";

                    _PayRecDocLine.Refund := true;
                    _PayRecDocLine.Modify;
                until _PayRecDocLine.Next = 0;


                //‹ÝŒŒ ýˆ«Š±— Ÿýˆ«Š± ‹Ð‘ª
                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                _DetailAdminExpLedger.SetRange("Source No.", _PayRecDoc."Document No.");
                _DetailAdminExpLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
                if _DetailAdminExpLedger.FindSet then
                    _DetailAdminExpLedger.DeleteAll(false);

                //‹ÝŒŒ ýˆ«Š±— øÔ…˜— ‹Ð‘ª
                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                _DetailAdminExpLedger.SetRange("Source No.", _PayRecDoc."Document No.");
                _DetailAdminExpLedger.SetRange(Applied, true);
                if _DetailAdminExpLedger.FindSet then
                    _DetailAdminExpLedger.DeleteAll(false);

                //Ÿ ýˆ«Š± ‹Ð‘ª
                _AdminExpenseLedger.Reset;
                _AdminExpenseLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                _AdminExpenseLedger.SetRange("Source No.", _PayRecDoc."Document No.");
                _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Daily);
                if _AdminExpenseLedger.FindSet then begin
                    _AdminExpenseLedger.DeleteAll(false);
                end;

                //From
                _AdminExpenseLedger.Reset;
                _AdminExpenseLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                _AdminExpenseLedger.SetRange("Source No.", _PayRecDoc."Document No.");
                _AdminExpenseLedger.SetRange("Ledger Type", _AdminExpenseLedger."Ledger Type"::Receipt);
                if _AdminExpenseLedger.FindSet then begin
                    repeat
                        //To
                        _AdminExpenseLedger2.Init;
                        _AdminExpenseLedger2.TransferFields(_AdminExpenseLedger);
                        _AdminExpenseLedger2.Date := pRec."Request Refund Date";
                        _AdminExpenseLedger2."Line No." := _AdminExpenseLedger2.GetNewLineNo(_AdminExpenseLedger2."Contract No.", pRec."Request Refund Date");
                        _AdminExpenseLedger2."Ledger Type" := _AdminExpenseLedger2."Ledger Type"::Refund;
                        _AdminExpenseLedger2.Amount := -_AdminExpenseLedger.Amount;
                        _AdminExpenseLedger2.Cancel := true;
                        _AdminExpenseLedger2."Source No." := pRec."Document No.";
                        _AdminExpenseLedger2."Source Line No." := 0;
                        _AdminExpenseLedger2.Insert(true);

                        //Update
                        _AdminExpenseLedger2.Open := false;
                        _AdminExpenseLedger2.Modify;

                        _AdminExpenseLedger.CalcFields("Detail Max Seq.", "Remaining Amount");
                        _ToNewSeq := _AdminExpenseLedger."Detail Max Seq.";

                        //Apply (from)
                        _ToNewSeq += 1;
                        _DetailAdminExpLedger.Init;
                        _DetailAdminExpLedger."Contract No." := _AdminExpenseLedger2."Contract No.";
                        _DetailAdminExpLedger.Date := _AdminExpenseLedger2.Date;
                        _DetailAdminExpLedger."Line No." := _AdminExpenseLedger2."Line No.";
                        _DetailAdminExpLedger.Sequence := _ToNewSeq;
                        _DetailAdminExpLedger."Admin. Expense Type" := _AdminExpenseLedger2."Admin. Expense Type";
                        _DetailAdminExpLedger."Ledger Type" := _AdminExpenseLedger."Ledger Type";
                        _DetailAdminExpLedger."Source No." := _AdminExpenseLedger."Source No.";
                        _DetailAdminExpLedger."Source Line No." := _AdminExpenseLedger."Source Line No.";
                        _DetailAdminExpLedger.Amount := -_AdminExpenseLedger.Amount;
                        _DetailAdminExpLedger."Apply Date" := _AdminExpenseLedger.Date;
                        _DetailAdminExpLedger."Apply Line No." := _AdminExpenseLedger."Line No.";
                        _DetailAdminExpLedger.Applied := true;
                        _DetailAdminExpLedger.Insert(true);

                        //Daily (To)
                        _ToNewSeq += 1;
                        _DetailAdminExpLedger.Init;
                        _DetailAdminExpLedger."Contract No." := _AdminExpenseLedger2."Contract No.";
                        _DetailAdminExpLedger.Date := _AdminExpenseLedger2.Date;
                        _DetailAdminExpLedger."Line No." := _AdminExpenseLedger2."Line No.";
                        _DetailAdminExpLedger.Sequence := _ToNewSeq;
                        _DetailAdminExpLedger."Admin. Expense Type" := _AdminExpenseLedger2."Admin. Expense Type";
                        _DetailAdminExpLedger."Ledger Type" := _AdminExpenseLedger2."Ledger Type";
                        _DetailAdminExpLedger.Amount := -_AdminExpenseLedger2.Amount;
                        _DetailAdminExpLedger."Source No." := _AdminExpenseLedger."Source No.";
                        _DetailAdminExpLedger."Source Line No." := _AdminExpenseLedger."Source Line No.";
                        _DetailAdminExpLedger."Apply Date" := _AdminExpenseLedger2.Date;
                        _DetailAdminExpLedger."Apply Line No." := _AdminExpenseLedger2."Line No.";
                        _DetailAdminExpLedger.Applied := true;
                        _DetailAdminExpLedger.Insert(true);

                        //Modify
                        _AdminExpenseLedger.Cancel := true;
                        _AdminExpenseLedger.Open := false;
                        _AdminExpenseLedger.Modify;
                    until _AdminExpenseLedger.Next = 0;
                end;

                ////Update
                _Contract.Reset;
                _Contract.SetRange("No.", _PayRecDoc."Contract No.");
                if _Contract.FindSet then begin

                    _Contract.CalcFields("Landscape Architecture");
                    if _ArrBefExpirationDate[1] <> 0D then
                        _Contract.Validate("General Expiration Date", _ArrBefExpirationDate[1] - 1);

                    if _Contract."Landscape Architecture" then
                        if _ArrBefExpirationDate[2] <> 0D then
                            _Contract.Validate("Land. Arc. Expiration Date", _ArrBefExpirationDate[2] - 1);

                    //ŒÁ‰½ …Ø€Ã‹ œý …Ø€Ãˆ‡ž Žð…Ñœ–«
                    _Contract."Litigation Evaluation" := _PayRecDoc."Befor Liti. Eval.";

                    _Contract.Modify(true);

                    //…Ø€Ã Š»µ €Ë‡Ÿ
                    _ChangeEvaluation.Insert_ChangeEvaluation(_PayRecDoc."After Liti. Eval.", _PayRecDoc."Befor Liti. Eval.", _PayRecDocLine.Amount, pRec."Document No.", _Contract);

                    //CRM
                    Clear(CRMDataInterlink);
                    CRMDataInterlink.OutboundContract(_Contract);
                    //CRM
                end;
            end;

            //Contract Amount
            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
            _PayRecDocLine.SetFilter("Payment Target", '%1|%2|%3', _PayRecDocLine."Payment Target"::Deposit,
                                                                _PayRecDocLine."Payment Target"::Contract,
                                                                _PayRecDocLine."Payment Target"::Remaining);
            if _PayRecDocLine.FindSet then begin
                //DELETE!!!!!!
                _DetailAdminExpLedger.Reset;
                _DetailAdminExpLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                if _DetailAdminExpLedger.FindSet then
                    _DetailAdminExpLedger.DeleteAll(false);

                _AdminExpenseLedger.Reset;
                _AdminExpenseLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                if _AdminExpenseLedger.FindSet then begin
                    _AdminExpenseLedger.DeleteAll(false);
                end;

                _ContractAmtLedger.Reset;
                _ContractAmtLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                _ContractAmtLedger.SetRange("Source No.", _PayRecDoc."Document No.");
                _ContractAmtLedger.SetFilter(Type, '%1|%2|%3', _ContractAmtLedger.Type::Deposit,
                                                              _ContractAmtLedger.Type::Contract,
                                                              _ContractAmtLedger.Type::Remaining);
                if _ContractAmtLedger.FindSet then begin
                    _NewLineNo := LastLineNo_ContAmountLedger(pRec);
                    repeat
                        _NewLineNo += 10000;

                        _ContractAmtLedger2.Init;
                        _ContractAmtLedger2.TransferFields(_ContractAmtLedger);
                        _ContractAmtLedger2.Date := pRec."Request Refund Date";
                        _ContractAmtLedger2."Line No." := _NewLineNo;
                        _ContractAmtLedger2."Ledger Type" := _ContractAmtLedger2."Ledger Type"::Refund;
                        _ContractAmtLedger2.Amount := -_ContractAmtLedger.Amount;
                        _ContractAmtLedger2."Source No." := pRec."Document No.";
                        _ContractAmtLedger2."Source Line No." := 0;
                        _ContractAmtLedger2."Creation Date" := CreateDateTime(0D, 0T);
                        _ContractAmtLedger2.Cancel := true;
                        _ContractAmtLedger2.Insert(true);

                        //Update
                        _ContractAmtLedger.Cancel := true;
                        _ContractAmtLedger.Modify;
                    until _ContractAmtLedger.Next = 0;
                end;

                _Contract.Get(_PayRecDoc."Contract No.");

                repeat

                    //ÐŽÊ €¦Ž¸ …—…‰ˆ
                    case _PayRecDocLine."Payment Target" of
                        _PayRecDocLine."Payment Target"::Deposit:
                            begin
                                _Contract.Validate("Deposit Amount", 0);
                                _Contract."Deposit Receipt Date" := 0D;
                                _Contract.Status := _Contract.Status::Open;

                            end;
                        _PayRecDocLine."Payment Target"::Contract:
                            begin
                                if (_Contract."Contract Amount" - _PayRecDocLine.Amount) < 0 then
                                    _Contract.Validate("Contract Amount", 0)
                                else
                                    _Contract.Validate("Contract Amount", _Contract."Contract Amount" - _PayRecDocLine.Amount);

                                if _Contract."Rece. Remaining Amount" = 0 then
                                    _Contract."Pay. Contract Rece. Date" := 0D;
                                _Contract."Contract Publish" := _Contract."Contract Publish"::Unpublished;

                                if _Contract."Deposit Amount" = 0 then
                                    _Contract.Status := _Contract.Status::Open
                                else
                                    _Contract.Status := _Contract.Status::Reservation;
                            end;
                        _PayRecDocLine."Payment Target"::Remaining:
                            begin
                                if (_Contract."Rece. Remaining Amount" - _PayRecDocLine.Amount) < 0 then
                                    _Contract.Validate("Rece. Remaining Amount", 0)
                                else
                                    _Contract.Validate("Rece. Remaining Amount", _Contract."Rece. Remaining Amount" - _PayRecDocLine.Amount);

                                if _Contract."Rece. Remaining Amount" = 0 then
                                    _Contract."Remaining Receipt Date" := 0D;

                                _Contract."Contract Publish" := _Contract."Contract Publish"::Unpublished;
                                _Contract.Status := _Contract.Status::Contract;

                            end;
                    end;
                until _PayRecDocLine.Next = 0;
                //ÐŽÊ …Ñœ• …—…‰ˆ«€Ë
                _Contract.CalcFields("Landscape Architecture");
                _Contract.Validate("General Expiration Date", 0D);
                _Contract."First General Expiration Date" := 0D;
                _Contract.Validate("Land. Arc. Expiration Date", 0D);
                _Contract."First Land. Arc. Exp. Date" := 0D;
                _Contract."Rem. Amount Posting Date" := 0D;
                _Contract.Modify(true);

                //‰ª‘÷Œ¡Š±Š ‹Ð‘ª
                if _Contract."Bury Amount" <> 0 then
                    DeleteCemeteryService(_PayRecDoc);

                //CRM
                Clear(CRMDataInterlink);
                CRMDataInterlink.OutboundContract(_Contract);
                //CRM
            end;

            //Service
            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
            _PayRecDocLine.SetFilter("Payment Target", '%1',
                                                  _PayRecDocLine."Payment Target"::Service);
            if _PayRecDocLine.FindSet then begin
                repeat
                    UpdateService(_PayRecDocLine, _PayRecDoc, false);

                until _PayRecDocLine.Next = 0;
                //ÐŽÊ Žð…Ñœ–«
                _ContractAmtLedger.Reset;
                _ContractAmtLedger.SetRange("Contract No.", _PayRecDoc."Contract No.");
                _ContractAmtLedger.SetRange("Source No.", _PayRecDoc."Document No.");
                _ContractAmtLedger.SetRange(Type, _ContractAmtLedger.Type::Service);
                if _ContractAmtLedger.FindSet then begin
                    _NewLineNo := LastLineNo_ContAmountLedger(pRec);
                    repeat
                        _NewLineNo += 10000;

                        _ContractAmtLedger2.Init;
                        _ContractAmtLedger2.TransferFields(_ContractAmtLedger);
                        _ContractAmtLedger2.Date := pRec."Request Refund Date";
                        _ContractAmtLedger2."Line No." := _NewLineNo;
                        _ContractAmtLedger2."Ledger Type" := _ContractAmtLedger2."Ledger Type"::Refund;
                        _ContractAmtLedger2.Amount := -_ContractAmtLedger.Amount;
                        _ContractAmtLedger2."Source No." := pRec."Document No.";
                        _ContractAmtLedger2."Source Line No." := 0;
                        _ContractAmtLedger2."Creation Date" := CreateDateTime(0D, 0T);
                        _ContractAmtLedger2.Cancel := true;
                        _ContractAmtLedger2.Insert(true);

                        //Update
                        _ContractAmtLedger.Cancel := true;
                        _ContractAmtLedger.Modify;
                    until _ContractAmtLedger.Next = 0;
                end;
            end;

            //Update
            //>> #2363
            // >> DK34
            //_PayRecDoc."New Admin. Expense" := FALSE;
            //_PayRecDoc.MODIFY(TRUE);
            // <<

            pRec.Validate("Refund Status", pRec."Refund Status"::Complate);
            pRec.Correction := _PayRecDoc.Correction;
            pRec.Posted := true;
            pRec."Payment Completion Date" := Today;

            /*
            _ReqRemLed.RESET;
            _ReqRemLed.SETRANGE("Source No.", pRec."Document No.");
            IF _ReqRemLed.FINDSET THEN
              pRec.VALIDATE("Payment Completion Date", _ReqRemLed."Complate Date");
            */

            pRec.Modify;


        end;

    end;


    procedure PostCancel(pRec: Record "DK_Payment Receipt Document")
    var
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _ContractAmtLedger: Record "DK_Contract Amount Ledger";
        _ArrBefExpirationDate: array[2] of Date;
        _Contract: Record DK_Contract;
        _ValidatePostingDateMgt: Codeunit "DK_ValidatePostingDate Mgt.";
        _ChangeEvaluation: Codeunit "DK_Change Evaluation";
        _PayReceiptDocNo: Code[20];
        _Corpse: Record DK_Corpse;
        _PayRecDoc: Record "DK_Payment Receipt Document";
    begin
        pRec.CalcFields("Refund Document No.");

        if pRec."Refund Document No." <> '' then
            Error(MSG029, pRec."Refund Document No.");

        //-------------------------------------------------------------------
        //œ˜” ýˆ«Š± ¯€¦‰«Œ¡ ‘ˆÏ Šž ˜«ž
        _PayReceiptDocNo := CheckNextPayReceiptRecordExists(pRec);
        if _PayReceiptDocNo <> '' then
            Error(MSG027, _PayReceiptDocNo);
        //
        //-------------------------------------------------------------------

        _ValidatePostingDateMgt.ValidatePostingDate(pRec."Posting Date");

        //Admin Expense
        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
        _PayRecDocLine.SetFilter("Payment Target", '%1|%2', _PayRecDocLine."Payment Target"::General,
                                                            _PayRecDocLine."Payment Target"::Landscape);
        if _PayRecDocLine.FindSet then begin
            Clear(_ArrBefExpirationDate);
            // >> #2224
            repeat
                // >> #2451
                if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then
                    _ArrBefExpirationDate[1] := _PayRecDocLine."Start Date"
                else
                    _ArrBefExpirationDate[2] := _PayRecDocLine."Start Date";


                _PayRecDoc.Reset;
                _PayRecDoc.SetRange(Refund, false);
                _PayRecDoc.SetFilter("Document No.", '<>%1', pRec."Document No.");
                _PayRecDoc.SetFilter("Line Admin. Expense", '<>%1', 0);
                if not _PayRecDoc.FindSet then begin
                    _Contract.Reset;
                    _Contract.CalcFields("Admin. Expense Method", "First Corpse Exists");
                    _Contract.SetRange("No.", pRec."Contract No.");
                    _Contract.SetRange("Admin. Expense Method", _Contract."Admin. Expense Method"::"After Corpse 10");
                    _Contract.SetRange("First Corpse Exists", true);
                    if _Contract.FindSet then begin
                        _Corpse.Reset;
                        _Corpse.SetRange("Contract No.", _Contract."No.");
                        _Corpse.SetRange("First Corpse", true);
                        if _Corpse.FindSet then begin
                            if _PayRecDocLine."Payment Target" = _PayRecDocLine."Payment Target"::General then
                                _ArrBefExpirationDate[1] := _Corpse."Laying Date"
                            else
                                _ArrBefExpirationDate[2] := _Corpse."Laying Date";
                        end;
                    end;
                end;
            // <<
            until _PayRecDocLine.Next = 0;
            // <<

            //DELETE!!!!!!
            _DetailAdminExpLedger.Reset;
            _DetailAdminExpLedger.SetRange("Contract No.", pRec."Contract No.");
            _DetailAdminExpLedger.SetRange("Source No.", pRec."Document No.");
            if _DetailAdminExpLedger.FindSet then
                _DetailAdminExpLedger.DeleteAll(false);

            _AdminExpenseLedger.Reset;
            _AdminExpenseLedger.SetRange("Contract No.", pRec."Contract No.");
            _AdminExpenseLedger.SetRange("Source No.", pRec."Document No.");
            if _AdminExpenseLedger.FindSet then begin
                _AdminExpenseLedger.DeleteAll(false);
            end;

            _AdminExpenseLedger.Reset;
            _AdminExpenseLedger.SetRange("Contract No.", pRec."Contract No.");
            _AdminExpenseLedger.SetFilter("Remaining Amount", '<>0');
            if _AdminExpenseLedger.FindSet then begin
                _AdminExpenseLedger.ModifyAll(Open, true);
            end;

            ////Update
            _Contract.Reset;
            _Contract.SetRange("No.", pRec."Contract No.");
            if _Contract.FindSet then begin

                _Contract.CalcFields("Landscape Architecture");
                if _ArrBefExpirationDate[1] <> 0D then
                    _Contract.Validate("General Expiration Date", _ArrBefExpirationDate[1] - 1);

                if _Contract."Landscape Architecture" then
                    if _ArrBefExpirationDate[2] <> 0D then
                        _Contract.Validate("Land. Arc. Expiration Date", _ArrBefExpirationDate[2] - 1);

                //ŒÁ‰½ …Ø€Ã‹ œý …Ø€Ãˆ‡ž Žð…Ñœ–«
                _Contract."Litigation Evaluation" := pRec."Befor Liti. Eval.";

                _Contract.Modify(true);

                //…Ø€Ã Š»µ €Ë‡Ÿ
                _ChangeEvaluation.Insert_ChangeEvaluation(pRec."After Liti. Eval.", pRec."Befor Liti. Eval.", _PayRecDocLine.Amount, pRec."Document No.", _Contract);

                //CRM
                Clear(CRMDataInterlink);
                CRMDataInterlink.OutboundContract(_Contract);
                //CRM
            end;
        end;

        //Contract Amount
        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
        _PayRecDocLine.SetFilter("Payment Target", '%1|%2|%3', _PayRecDocLine."Payment Target"::Deposit,
                                                            _PayRecDocLine."Payment Target"::Contract,
                                                            _PayRecDocLine."Payment Target"::Remaining);
        if _PayRecDocLine.FindSet then begin
            //DELETE!!!!!!
            _DetailAdminExpLedger.Reset;
            _DetailAdminExpLedger.SetRange("Contract No.", pRec."Contract No.");
            if _DetailAdminExpLedger.FindSet then
                _DetailAdminExpLedger.DeleteAll(false);

            _AdminExpenseLedger.Reset;
            _AdminExpenseLedger.SetRange("Contract No.", pRec."Contract No.");
            if _AdminExpenseLedger.FindSet then begin
                _AdminExpenseLedger.DeleteAll(false);
            end;

            //
            _ContractAmtLedger.Reset;
            _ContractAmtLedger.SetRange("Contract No.", pRec."Contract No.");
            _ContractAmtLedger.SetRange("Source No.", pRec."Document No.");
            _ContractAmtLedger.SetFilter(Type, '%1|%2|%3', _ContractAmtLedger.Type::Deposit,
                                                            _ContractAmtLedger.Type::Contract,
                                                            _ContractAmtLedger.Type::Remaining);
            if _ContractAmtLedger.FindSet then begin
                _ContractAmtLedger.DeleteAll(false);
            end;

            _Contract.Get(pRec."Contract No.");

            repeat

                //ÐŽÊ €¦Ž¸ …—…‰ˆ
                case _PayRecDocLine."Payment Target" of
                    _PayRecDocLine."Payment Target"::Deposit:
                        begin
                            _Contract.Validate("Deposit Amount", 0);
                            _Contract."Deposit Receipt Date" := 0D;
                            _Contract.Status := _Contract.Status::Open;

                        end;
                    _PayRecDocLine."Payment Target"::Contract:
                        begin
                            if (_Contract."Contract Amount" - _PayRecDocLine.Amount) < 0 then
                                _Contract.Validate("Contract Amount", 0)
                            else
                                _Contract.Validate("Contract Amount", _Contract."Contract Amount" - _PayRecDocLine.Amount);

                            if _Contract."Rece. Remaining Amount" = 0 then
                                _Contract."Pay. Contract Rece. Date" := 0D;
                            _Contract."Contract Publish" := _Contract."Contract Publish"::Unpublished;

                            if _Contract."Deposit Amount" = 0 then
                                _Contract.Status := _Contract.Status::Open
                            else
                                _Contract.Status := _Contract.Status::Reservation;
                        end;
                    _PayRecDocLine."Payment Target"::Remaining:
                        begin
                            if (_Contract."Rece. Remaining Amount" - _PayRecDocLine.Amount) < 0 then
                                _Contract.Validate("Rece. Remaining Amount", 0)
                            else
                                _Contract.Validate("Rece. Remaining Amount", _Contract."Rece. Remaining Amount" - _PayRecDocLine.Amount);

                            if _Contract."Rece. Remaining Amount" = 0 then
                                _Contract."Remaining Receipt Date" := 0D;

                            _Contract."Contract Publish" := _Contract."Contract Publish"::Unpublished;
                            _Contract.Status := _Contract.Status::Contract;

                        end;
                end;
            until _PayRecDocLine.Next = 0;
            //ÐŽÊ …Ñœ• …—…‰ˆ«€Ë
            _Contract.CalcFields("Landscape Architecture");
            _Contract.Validate("General Expiration Date", 0D);
            _Contract."First General Expiration Date" := 0D;
            _Contract.Validate("Land. Arc. Expiration Date", 0D);
            _Contract."First Land. Arc. Exp. Date" := 0D;
            _Contract."Rem. Amount Posting Date" := 0D;
            _Contract.Modify(true);

            //‰ª‘÷Œ¡Š±Š ‹Ð‘ª(Â€¦ Ÿ‚‚“ ‹²ŒŠ…˜ ‰ª‘÷Œ¡Š±Š ‘ª•)
            if _Contract."Bury Amount" <> 0 then
                DeleteCemeteryService(pRec);

            //CRM
            Clear(CRMDataInterlink);
            CRMDataInterlink.OutboundContract(_Contract);
            //CRM

        end;

        //Service
        _PayRecDocLine.Reset;
        _PayRecDocLine.SetRange("Document No.", pRec."Document No.");
        _PayRecDocLine.SetFilter("Payment Target", '%1',
                                              _PayRecDocLine."Payment Target"::Service);
        if _PayRecDocLine.FindSet then begin
            repeat
                UpdateService(_PayRecDocLine, pRec, false);

            until _PayRecDocLine.Next = 0;
            //Ledger
            _ContractAmtLedger.Reset;
            _ContractAmtLedger.SetRange("Contract No.", pRec."Contract No.");
            _ContractAmtLedger.SetRange("Source No.", pRec."Document No.");
            _ContractAmtLedger.SetRange(Type, _ContractAmtLedger.Type::Service);
            if _ContractAmtLedger.FindSet then begin
                _ContractAmtLedger.DeleteAll(false);
            end;
        end;

        // >> DK34
        pRec."New Admin. Expense" := false;
        // <<

        pRec.Posted := false;
        pRec.Modify;
    end;

    local procedure InsertContractAmountLedger(pPayRecDoc: Record "DK_Payment Receipt Document"; pPayRecDocLine: Record "DK_Payment Receipt Doc. Line"; var pNewLineNo: Integer; pType: Option; pLedgerType: Option; pAmount: Decimal; pServiceNo: Code[20])
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
    begin

        if pAmount = 0 then exit;

        pNewLineNo += 10000;

        _ContAmountLedger.Init;
        _ContAmountLedger.Validate("Contract No.", pPayRecDoc."Contract No.");
        _ContAmountLedger.Validate("Line No.", pNewLineNo);
        _ContAmountLedger.Validate(Type, pType);
        _ContAmountLedger.Validate("Ledger Type", pLedgerType);
        _ContAmountLedger.Validate(Date, pPayRecDoc."Payment Date");
        _ContAmountLedger.Validate("Payment Type", pPayRecDoc."Payment Type");
        _ContAmountLedger.Validate(Amount, pAmount);
        _ContAmountLedger.Validate("Source No.", pPayRecDoc."Document No.");
        _ContAmountLedger.Validate("Source Line No.", pPayRecDocLine."Line No.");
        _ContAmountLedger.Validate("Service No.", pServiceNo);
        _ContAmountLedger.Validate("Payment Type", pPayRecDoc."Payment Type");
        _ContAmountLedger.Insert(true);
    end;

    local procedure LastLineNo_ContAmountLedger(pRec: Record "DK_Payment Receipt Document"): Integer
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
    begin

        _ContAmountLedger.Reset;
        _ContAmountLedger.SetCurrentKey("Contract No.", "Line No.");
        _ContAmountLedger.SetRange("Contract No.", pRec."Contract No.");
        if _ContAmountLedger.FindLast then
            exit(_ContAmountLedger."Line No.");

        exit(0);
    end;


    procedure DelContractAmountLedger(pPayRecDoc: Record "DK_Payment Receipt Document")
    var
        _ContAmountLedger: Record "DK_Contract Amount Ledger";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Contract: Record DK_Contract;
    begin

        _Contract.Get(pPayRecDoc."Contract No.");

        _ContAmountLedger.Reset;
        _ContAmountLedger.SetRange("Ledger Type", _ContAmountLedger."Ledger Type"::Receipt);
        _ContAmountLedger.SetRange("Source No.", pPayRecDoc."Document No.");
        if _ContAmountLedger.FindFirst then begin

            _PayRecDocLine.Reset;
            _PayRecDocLine.SetRange("Document No.", _ContAmountLedger."Source No.");
            _PayRecDocLine.SetRange("Line No.", _ContAmountLedger."Source Line No.");
            if _PayRecDocLine.FindSet then
                UpdateContract(pPayRecDoc, _PayRecDocLine, _ContAmountLedger.Type, _Contract);

            _ContAmountLedger.Delete(true);
        end;
    end;


    procedure UpdateContract(pPayRecDoc: Record "DK_Payment Receipt Document"; pPayRecDocLine: Record "DK_Payment Receipt Doc. Line"; pType: Option; var pContract: Record DK_Contract)
    var
        _Contract: Record DK_Contract;
        _NewLineNo: Integer;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
        _EndingDate: Date;
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin

        if pContract."No." <> '' then begin //<<DK32

            // IF pContract."No." = '20220830006' THEN
            //   MESSAGE('%1',pContract);


            case pType of
                ContAmountLedger.Type::Deposit:
                    begin
                        pContract.Validate("Deposit Amount", pContract."Deposit Amount" + pPayRecDocLine.Amount);
                        pContract."Deposit Receipt Date" := pPayRecDoc."Payment Date";

                        //Change Status

                        if pPayRecDoc."Document Type" = pPayRecDoc."Document Type"::Receipt then
                            pContract.Validate(Status, pContract.Status::Reservation)
                        else
                            pContract.Validate(Status, pContract.Status::Open);

                    end;
                ContAmountLedger.Type::Contract:
                    begin
                        pContract.Validate("Contract Amount", pContract."Contract Amount" + pPayRecDocLine.Amount);
                        pContract."Pay. Contract Rece. Date" := pPayRecDoc."Payment Date";

                        if pPayRecDoc."Document Type" = pPayRecDoc."Document Type"::Receipt then
                            pContract.Validate(Status, pContract.Status::Contract);

                        //‘ãŠõ ‰È—Ê »—ý
                        if pPayRecDoc."Payment Type" in [pPayRecDoc."Payment Type"::Card, pPayRecDoc."Payment Type"::OnlineCard] then
                            if pContract."Contract Publish" = pContract."Contract Publish"::Cash then
                                pContract."Contract Publish" := pContract."Contract Publish"::CashandCard
                            else
                                pContract."Contract Publish" := pContract."Contract Publish"::Card;

                        if pPayRecDoc."Issued Cash Receipts" then
                            if pContract."Contract Publish" = pContract."Contract Publish"::Card then
                                pContract."Contract Publish" := pContract."Contract Publish"::CashandCard
                            else
                                pContract."Contract Publish" := pContract."Contract Publish"::Cash;

                        //Change Status
                        if pPayRecDoc."Document Type" = pPayRecDoc."Document Type"::Receipt then begin
                            if pContract.Status in [pContract.Status::Open, pContract.Status::Reservation] then
                                pContract.Validate(Status, pContract.Status::Contract)
                        end else begin
                            if pContract."Deposit Amount" = 0 then
                                pContract.Validate(Status, pContract.Status::Open)
                            else
                                pContract.Validate(Status, pContract.Status::Reservation);
                        end;

                    end;
                ContAmountLedger.Type::Remaining:
                    begin
                        pContract.Validate("Rece. Remaining Amount", pContract."Rece. Remaining Amount" + pPayRecDocLine.Amount);

                        if pPayRecDoc."Document Type" = pPayRecDoc."Document Type"::Receipt then
                            pContract.Validate(Status, pContract.Status::Contract);

                        //‘ãŠõ ‰È—Ê »—ý
                        if pPayRecDoc."Payment Type" in [pPayRecDoc."Payment Type"::Card, pPayRecDoc."Payment Type"::OnlineCard] then
                            if pContract."Remaining Publish" = pContract."Remaining Publish"::Cash then
                                pContract."Remaining Publish" := pContract."Remaining Publish"::CashandCard
                            else
                                pContract."Remaining Publish" := pContract."Remaining Publish"::Card;

                        if pPayRecDoc."Issued Cash Receipts" then
                            if pContract."Remaining Publish" = pContract."Remaining Publish"::Card then
                                pContract."Remaining Publish" := pContract."Remaining Publish"::CashandCard
                            else
                                pContract."Remaining Publish" := pContract."Remaining Publish"::Cash;
                    end;
            end;

            if pContract."Pay. Remaining Amount" = 0 then begin
                pContract."Remaining Receipt Date" := LastRemainingReceiptDate(pPayRecDoc."Contract No.");
            end else begin
                pContract."Remaining Receipt Date" := 0D;
            end;
            pContract.Modify(false);

            //ýˆ«Š± Žð…Ñœ–«
            if pContract."Pay. Remaining Amount" = 0 then begin
                pContract.Validate(Status, pContract.Status::FullPayment);

                pContract.CalcFields("Admin. Expense Method", "Landscape Architecture"); //DK32

                if pContract."General Amount" <> 0 then begin

                    InsertAdminExpensetLedger(pPayRecDoc, pPayRecDocLine, _NewLineNo, AdminExpenseLedger."Admin. Expense Type"::General, pContract."General Amount", true, false);

                    //Division
                    if (pContract."Admin. Expense Method" <> pContract."Admin. Expense Method"::Contract) and (pContract."Admin. Exp. Start Date" <> 0D) then begin//DK32
                        _EndingDate := pContract."Admin. Exp. Start Date" - 1;//DK32
                        _EndingDate := CalcDate('<5Y>', _EndingDate);//DK32 5‚Ë “Èí
                    end else begin//DK32
                        Clear(_AdminExpenseMgt);
                        _EndingDate := _AdminExpenseMgt.NewContract(pPayRecDoc."Contract No.", AdminExpenseLedger."Admin. Expense Type"::General, pContract."General Amount", pPayRecDocLine."Document No.", pPayRecDocLine."Line No.");
                    end;

                end else begin
                    if (pContract."Admin. Expense Method" <> pContract."Admin. Expense Method"::Contract) and (pContract."Admin. Exp. Start Date" <> 0D) then begin//DK32
                        _EndingDate := pContract."Admin. Exp. Start Date" - 1;//DK32
                    end;
                end;

                if _EndingDate <> 0D then begin

                    if pContract."General Expiration Date" = 0D then
                        UpdateAdminExpenseLedger(pPayRecDoc, _NewLineNo, AdminExpenseLedger."Admin. Expense Type"::General, pContract."Contract Date", _EndingDate)
                    else
                        UpdateAdminExpenseLedger(pPayRecDoc, _NewLineNo, AdminExpenseLedger."Admin. Expense Type"::General, pContract."General Expiration Date" + 1, _EndingDate);

                    pContract.Validate("General Expiration Date", _EndingDate);
                    pContract."First General Expiration Date" := pContract."General Expiration Date";
                end;

                Clear(_EndingDate);
                if pContract."Landscape Architecture" then begin

                    if pContract."Landscape Arc. Amount" <> 0 then begin

                        InsertAdminExpensetLedger(pPayRecDoc, pPayRecDocLine, _NewLineNo, AdminExpenseLedger."Admin. Expense Type"::Landscape, pContract."Landscape Arc. Amount", true, false);

                        //Division
                        if (pContract."Admin. Expense Method" <> pContract."Admin. Expense Method"::Contract) and (pContract."Admin. Exp. Start Date" <> 0D) then begin//DK32
                            _EndingDate := pContract."Admin. Exp. Start Date" - 1;//DK32
                            _EndingDate := CalcDate('<5Y>', _EndingDate);//DK32 5‚Ë “Èí

                        end else begin//DK32
                            Clear(_AdminExpenseMgt);
                            _EndingDate := _AdminExpenseMgt.NewContract(pPayRecDoc."Contract No.", AdminExpenseLedger."Admin. Expense Type"::Landscape, pContract."Landscape Arc. Amount", pPayRecDocLine."Document No.", pPayRecDocLine."Line No.");
                        end;
                    end else begin
                        if (pContract."Admin. Expense Method" <> pContract."Admin. Expense Method"::Contract) and (pContract."Admin. Exp. Start Date" <> 0D) then begin//DK32
                            _EndingDate := pContract."Admin. Exp. Start Date" - 1;//DK32
                        end;
                    end;

                    if _EndingDate <> 0D then begin
                        if pContract."Land. Arc. Expiration Date" = 0D then
                            UpdateAdminExpenseLedger(pPayRecDoc, _NewLineNo, AdminExpenseLedger."Admin. Expense Type"::Landscape, pContract."Contract Date", _EndingDate)
                        else
                            UpdateAdminExpenseLedger(pPayRecDoc, _NewLineNo, AdminExpenseLedger."Admin. Expense Type"::Landscape, pContract."Land. Arc. Expiration Date" + 1, _EndingDate);

                        pContract.Validate("Land. Arc. Expiration Date", _EndingDate);
                        pContract."First Land. Arc. Exp. Date" := pContract."Land. Arc. Expiration Date";
                    end;
                end;

                //Â€¦ ‘÷Š­ ˆ†‘÷ˆ‡ ŸÀ
                _PayReceiptDoc.Reset;
                _PayReceiptDoc.SetCurrentKey("Posting Date");
                _PayReceiptDoc.SetRange("Contract No.", pContract."No.");
                _PayReceiptDoc.SetFilter("Line Remaining Amount", '<>%1', 0);
                if _PayReceiptDoc.FindLast then begin

                    if pPayRecDoc."Posting Date" < _PayReceiptDoc."Posting Date" then
                        pContract."Rem. Amount Posting Date" := _PayReceiptDoc."Posting Date"
                    else
                        pContract."Rem. Amount Posting Date" := pPayRecDoc."Posting Date";
                end else begin
                    pContract."Rem. Amount Posting Date" := pPayRecDoc."Posting Date";
                end;

                pContract.Modify(false);


                //‰ª‘÷Œ¡Š±Š ‹²ŒŠ
                if pContract."Bury Amount" <> 0 then
                    InsertCemeteryService(pPayRecDoc, pContract);

                //IF pContract."No." = '20220830006' THEN
                //  MESSAGE('%1',pContract);


                //CRM
                Clear(CRMDataInterlink);
                CRMDataInterlink.OutboundContract(pContract);
                //CRM
                //=======================================================================
                //Apply Entry
                Commit;

                Clear(_ApplyAdminExLedger);
                _ApplyAdminExLedger.FindReceiptLedger(pContract."No.", AdminExpenseLedger."Admin. Expense Type"::General, Today);
                if pContract."Landscape Architecture" then
                    _ApplyAdminExLedger.FindReceiptLedger(pContract."No.", AdminExpenseLedger."Admin. Expense Type"::Landscape, Today);
                //=======================================================================

            end else begin

                //CRM
                Clear(CRMDataInterlink);
                CRMDataInterlink.OutboundContract(pContract);
                //CRM
            end;
        end;
    end;


    procedure InsertAdminExpensetLedger(pPayRecDoc: Record "DK_Payment Receipt Document"; pPayRecDocLine: Record "DK_Payment Receipt Doc. Line"; var pNewLineNo: Integer; pAdminExpenseType: Option; pAmount: Decimal; pFirstContract: Boolean; pAddPreiod: Boolean)
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
    begin

        if pPayRecDocLine.Amount = 0 then exit;

        if pNewLineNo = 0 then
            pNewLineNo := _AdminExpLedger.GetNewLineNo(pPayRecDoc."Contract No.", pPayRecDoc."Payment Date")
        else
            pNewLineNo += 1;

        _AdminExpLedger.Init;
        _AdminExpLedger.Validate("Contract No.", pPayRecDoc."Contract No.");
        _AdminExpLedger.Validate(Date, pPayRecDoc."Payment Date");
        _AdminExpLedger."Line No." := pNewLineNo;
        _AdminExpLedger.Validate("Admin. Expense Type", pAdminExpenseType);
        _AdminExpLedger.Validate("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
        _AdminExpLedger.Validate("Payment Type", pPayRecDoc."Payment Type");
        _AdminExpLedger.Validate(Amount, pAmount);
        _AdminExpLedger.Validate("Source No.", pPayRecDoc."Document No.");
        _AdminExpLedger.Validate("Source Line No.", pPayRecDocLine."Line No.");
        _AdminExpLedger.Validate("First Contract", pFirstContract);
        _AdminExpLedger.Validate("Payment Type", pPayRecDoc."Payment Type");
        _AdminExpLedger.Validate("Add. Period", pAddPreiod);

        _AdminExpLedger.Insert(true);
    end;

    local procedure UpdateAdminExpenseLedger(pPayRecDoc: Record "DK_Payment Receipt Document"; pNewLineNo: Integer; pAdminExpenseType: Option; pStartDate: Date; pEndDate: Date)
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
    begin

        _AdminExpLedger.Reset;
        _AdminExpLedger.SetRange("Contract No.", pPayRecDoc."Contract No.");
        _AdminExpLedger.SetRange(Date, pPayRecDoc."Payment Date");
        _AdminExpLedger.SetRange("Line No.", pNewLineNo);
        _AdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
        _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
        if _AdminExpLedger.FindSet then begin
            _AdminExpLedger."Starting Date" := pStartDate;
            _AdminExpLedger."Ending Date" := pEndDate;
            _AdminExpLedger.Modify;
        end;
    end;

    local procedure LastRemainingReceiptDate(pContractNo: Code[20]): Date
    var
        _ContractAmountLedger: Record "DK_Contract Amount Ledger";
    begin
        //ˆ†‘÷€¦ ¯€¦ …˜ ŸÀ:‰ŽÊ€¦,Èø,ÂŽ¸…Ò ˆÚ…ž –ð—¯
        _ContractAmountLedger.Reset;
        _ContractAmountLedger.SetCurrentKey("Contract No.", Date);
        _ContractAmountLedger.SetRange("Contract No.", pContractNo);
        _ContractAmountLedger.SetFilter(Type, '<>%1', _ContractAmountLedger.Type::Service);
        _ContractAmountLedger.SetRange("Ledger Type", _ContractAmountLedger."Ledger Type"::Receipt);
        if _ContractAmountLedger.FindLast then
            exit(_ContractAmountLedger.Date);
    end;


    procedure UpdateService(pPayRecDocLine: Record "DK_Payment Receipt Doc. Line"; pPayRecDoc: Record "DK_Payment Receipt Document"; pPost: Boolean)
    var
        _CemeteryServices: Record "DK_Cemetery Services";
    begin

        _CemeteryServices.Reset;
        _CemeteryServices.SetRange("No.", pPayRecDocLine."Cem. Services No.");
        if _CemeteryServices.FindSet then begin
            if pPost then begin
                if _CemeteryServices."Receipt Amount" >= _CemeteryServices.Amount then
                    Error(MSG007, _CemeteryServices."No.", pPayRecDoc.FieldCaption(Amount));

                _CemeteryServices."Receipt Amount" += pPayRecDocLine.Amount;
            end else begin
                _CemeteryServices."Receipt Amount" -= pPayRecDocLine.Amount;
            end;

            if pPost then begin
                if _CemeteryServices."Receipt Amount" = _CemeteryServices.Amount then begin
                    _CemeteryServices."Receipt Amount Date" := pPayRecDoc."Payment Date";
                    _CemeteryServices."Payment Type" := pPayRecDoc."Payment Type";
                end;
            end else begin
                _CemeteryServices."Receipt Amount Date" := 0D;
                _CemeteryServices."Payment Type" := _CemeteryServices."Payment Type"::None;
            end;
            _CemeteryServices.Modify;
        end;
    end;


    procedure CheckCencalPayReceAdmin(): Boolean
    var
        _UserSetup: Record "User Setup";
    begin

        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Cancel Pay. Rece. Admin.", true);
        if _UserSetup.FindSet then
            exit(true);

        exit(false);
    end;


    procedure ChangeContractNo(pPayReceiptDocNo: Code[20]; pNewContractNo: Code[20])
    var
        _PaymentReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayReceiptDocLine2: Record "DK_Payment Receipt Doc. Line";
        _OldContractNo: Code[20];
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseLedger2: Record "DK_Admin. Expense Ledger";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _Contract: Record DK_Contract;
        _EndingDate: Date;
        _NonPayAmount: Decimal;
        _NewEndingDate: Date;
        _ArrBefExpirationDate: array[2] of Date;
        _NewLineNo: Integer;
        _Type: Option;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _ApplyAdminExLedger: Codeunit "DK_Apply Admin. Expense Ledger";
    begin
        if pPayReceiptDocNo = '' then exit;
        if pNewContractNo = '' then exit;

        _PayReceiptDocLine.Reset;
        _PayReceiptDocLine.SetRange("Document No.", pPayReceiptDocNo);
        _PayReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PayReceiptDocLine."Payment Target"::General,
                                                               _PayReceiptDocLine."Payment Target"::Landscape);
        _PayReceiptDocLine.SetFilter("Diff. Amount", '<0');
        if _PayReceiptDocLine.FindSet then begin
            if not Confirm(MSG019, false) then
                Error(MSG018);

        end;

        _PaymentReceiptDoc.Reset;
        _PaymentReceiptDoc.SetRange("Document No.", pPayReceiptDocNo);
        if _PaymentReceiptDoc.FindSet then begin
            _OldContractNo := _PaymentReceiptDoc."Contract No.";

            _PaymentReceiptDoc."Contract No." := pNewContractNo;

            //œý ÐŽÊ— ýˆ«Š± ‘Ž‡ßŸÀ …—…‰ˆ«€Ë
            _PayReceiptDocLine.Reset;
            _PayReceiptDocLine.SetRange("Document No.", _OldContractNo);
            _PayReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PayReceiptDocLine."Payment Target"::General,
                                                                    _PayReceiptDocLine."Payment Target"::Landscape);
            if _PayReceiptDocLine.FindSet then begin
                Clear(_ArrBefExpirationDate);

                repeat
                    if _PayReceiptDocLine."Payment Target" = _PayReceiptDocLine."Payment Target"::General then
                        _ArrBefExpirationDate[1] := _PayReceiptDocLine."Start Date"
                    else
                        _ArrBefExpirationDate[2] := _PayReceiptDocLine."Start Date";
                until _PayReceiptDocLine.Next = 0;

                ////Update
                _Contract.Reset;
                _Contract.SetRange("No.", _OldContractNo);
                if _Contract.FindSet then begin

                    _Contract.CalcFields("Landscape Architecture");
                    if _ArrBefExpirationDate[1] <> 0D then
                        _Contract.Validate("General Expiration Date", _ArrBefExpirationDate[1] - 1);

                    if _Contract."Landscape Architecture" then
                        if _ArrBefExpirationDate[2] <> 0D then
                            _Contract.Validate("Land. Arc. Expiration Date", _ArrBefExpirationDate[2] - 1);

                    _Contract.Modify(true);
                end;
            end;


            _Contract.Reset;
            _Contract.SetRange("No.", pNewContractNo);
            _Contract.SetRange("Date Filter", 0D, _PaymentReceiptDoc."Payment Date");
            if _Contract.FindSet then begin
                _Contract.CalcFields("Landscape Architecture", "Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

                _PayReceiptDocLine.Reset;
                _PayReceiptDocLine.SetRange("Document No.", pPayReceiptDocNo);
                _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::Landscape);
                if _PayReceiptDocLine.FindSet then begin

                    if not _Contract."Landscape Architecture" then begin
                        if not Confirm(MSG013, false) then
                            Error(MSG014);

                        _PayReceiptDocLine2.Reset;
                        _PayReceiptDocLine2.SetRange("Document No.", pPayReceiptDocNo);
                        _PayReceiptDocLine2.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::General);
                        if _PayReceiptDocLine2.FindSet then begin
                            _PayReceiptDocLine2.Validate(Amount, _PayReceiptDocLine2.Amount + _PayReceiptDocLine.Amount);
                            _PayReceiptDocLine2.Modify;

                            _PayReceiptDocLine.Delete;
                        end else begin
                            _PayReceiptDocLine2.Reset;
                            _PayReceiptDocLine2.SetRange("Document No.", pPayReceiptDocNo);
                            _PayReceiptDocLine2.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::Landscape);
                            if _PayReceiptDocLine2.FindSet then begin
                                _PayReceiptDocLine2."Payment Target" := _PayReceiptDocLine."Payment Target"::General;
                                _PayReceiptDocLine2.Validate(Amount);
                                _PayReceiptDocLine2.Modify;
                            end;
                        end;
                    end;
                end;

                //•€¯ ÐŽÊí ýˆ«Š± Šž ˜«ž

                _PayReceiptDocLine2.SetRange("Document No.", pPayReceiptDocNo);
                _PayReceiptDocLine2.SetFilter("Payment Target", '%1|%2',
                                                      _PayReceiptDocLine2."Payment Target"::General,
                                                      _PayReceiptDocLine2."Payment Target"::Landscape);
                if _PayReceiptDocLine2.FindSet then begin


                    //‰È‹²…˜ Ÿ (Ÿ‰¦/ ‘†µ)ýˆ«Š± …Ñœ• ‹Ð‘ª

                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetRange("Contract No.", _OldContractNo);
                    _DetailAdminExpLedger.SetRange("Source No.", pPayReceiptDocNo);
                    if _DetailAdminExpLedger.FindSet then
                        _DetailAdminExpLedger.DeleteAll(false);

                    _AdminExpenseLedger.Reset;
                    _AdminExpenseLedger.SetRange("Contract No.", _OldContractNo);
                    _AdminExpenseLedger.SetRange("Source No.", pPayReceiptDocNo);
                    if _AdminExpenseLedger.FindSet then begin
                        _AdminExpenseLedger.DeleteAll(false);
                    end;
                    repeat

                        if _PayReceiptDocLine2."Payment Target" = _PayReceiptDocLine2."Payment Target"::General then begin
                            _EndingDate := _Contract."General Expiration Date";
                            _NonPayAmount := _Contract."Non-Pay. General Amount";
                            _Type := _AdminExpenseLedger."Admin. Expense Type"::General;
                        end else begin
                            _EndingDate := _Contract."Land. Arc. Expiration Date";
                            _NonPayAmount := _Contract."Non-Pay. Land. Arc. Amount";
                            _Type := _AdminExpenseLedger."Admin. Expense Type"::Landscape;
                        end;

                        //•€¯ ýˆ«Š± °Î ‹²ŒŠ
                        InsertAdminExpensetLedger(_PaymentReceiptDoc, _PayReceiptDocLine2, _NewLineNo, _Type, _PayReceiptDocLine2.Amount, false, false);

                        //ýˆ«Š± Š¨—­ ‘°—Ê
                        Clear(_AdminExpenseMgt);
                        _PayReceiptDocLine2."Expiration Date" := _AdminExpenseMgt.AddAdminExpense(_Contract,
                                                                                            _Type,
                                                                                            _PayReceiptDocLine2.Amount,
                                                                                            _PayReceiptDocLine2."Document No.",
                                                                                            _PayReceiptDocLine2."Line No.",
                                                                                            _PaymentReceiptDoc."Payment Date", 0D, false, 0D);


                        Clear(_ApplyAdminExLedger);
                        if _PayReceiptDocLine2."Payment Target" = _PayReceiptDocLine2."Payment Target"::General then begin
                            _Contract.Validate("General Expiration Date", _NewEndingDate);
                            //Ÿ‰¦ýˆ«Š± øÔ ‘°—Ê
                            _ApplyAdminExLedger.FindReceiptLedger(_PaymentReceiptDoc."Contract No.", _AdminExpenseLedger."Admin. Expense Type"::General, Today);
                        end else begin
                            _Contract.Validate("Land. Arc. Expiration Date", _NewEndingDate);
                            //‘†µýˆ«Š± øÔ ‘°—Ê
                            _ApplyAdminExLedger.FindReceiptLedger(_PaymentReceiptDoc."Contract No.", _AdminExpenseLedger."Admin. Expense Type"::Landscape, Today);
                        end;

                        //ýˆ«Š± ß· Žð…Ñœ–«
                        _PayReceiptDocLine2."Start Date" := _EndingDate + 1;
                        _PayReceiptDocLine2."Expiration Date" := _NewEndingDate;
                        _PayReceiptDocLine2."Bef. Non-Pay. Amount" := _NonPayAmount;
                        _PayReceiptDocLine2.Modify;
                    until _PayReceiptDocLine2.Next = 0;
                end;

                //ÐŽÊí Žð…Ñœ–«
                _Contract.Modify(true);
            end;


            _PaymentReceiptDoc.Modify(true);

            Message(MSG015, _OldContractNo, pNewContractNo);
        end;
    end;


    procedure RequestRemittance(pRec: Record "DK_Payment Receipt Document")
    var
        _RequestRemittanceLedger: Record "DK_Request Remittance Ledger";
        _Contract: Record DK_Contract;
    begin

        if not Check(pRec) then exit;

        _RequestRemittanceLedger.Init;
        _RequestRemittanceLedger."Account Type" := _RequestRemittanceLedger."Account Type"::Customer;

        if _Contract.Get(pRec."Contract No.") then begin
            _RequestRemittanceLedger."Account No." := _Contract."Main Customer No.";
            _RequestRemittanceLedger."Account Name" := _Contract."Main Customer Name";
        end;
        _RequestRemittanceLedger.Validate("Request Payment Date", pRec."Request Refund Date");
        _RequestRemittanceLedger."Bank Code" := pRec."Refund Bank Code";
        _RequestRemittanceLedger."Bank Name" := pRec."Refund Bank Name";
        _RequestRemittanceLedger."Bank Account No." := pRec."Refund Bank Account No.";
        _RequestRemittanceLedger."Bank Account Holder" := pRec."Refund Account Holder";
        _RequestRemittanceLedger."Source Type" := _RequestRemittanceLedger."Source Type"::RefundAdminExp;
        _RequestRemittanceLedger."Source No." := pRec."Document No.";
        _RequestRemittanceLedger.Amount := pRec.Amount;
        _RequestRemittanceLedger.Description := pRec."Refund Reason";
        _RequestRemittanceLedger."GroupWare Doc. No." := pRec."GroupWare Doc. No.";
        _RequestRemittanceLedger.Validate("Contract No.", pRec."Contract No.");
        _RequestRemittanceLedger."Supervise No." := pRec."Supervise No.";
        _RequestRemittanceLedger.Validate("Cemetery Code", pRec."Cemetery Code");

        _RequestRemittanceLedger.Insert(true);

        pRec.Validate("Payment Request Date", Today);
        pRec.Validate("Refund Status", pRec."Refund Status"::Request);
        pRec.Modify(true);
    end;

    local procedure InsertCemeteryService(pPayRecDoc: Record "DK_Payment Receipt Document"; pContract: Record DK_Contract)
    var
        _CemServices: Record "DK_Cemetery Services";
        _FieldWorkSubCate: Record "DK_Field Work Sub Category";
    begin

        pContract.CalcFields("Cust. Mobile No.", "Cust. Phone No.", "Cust. E-Mail");

        _CemServices.Init;
        _CemServices."No." := '';
        _CemServices."Receipt Date" := pContract."Contract Date";
        _CemServices."Work Date" := pPayRecDoc."Posting Date";
        _CemServices.Validate("Contract No.", pPayRecDoc."Contract No.");
        _CemServices.Validate("Field Work Main Cat. Code", '015');    //Fixed Value Ž˜”í
        //_CemServices.VALIDATE("Field Work Sub Cat. Code", '007');     //Fixed Value “´“šŽ˜”íŠ±
        _CemServices."Field Work Sub Cat. Code" := '007';
        if _FieldWorkSubCate.Get(_CemServices."Field Work Main Cat. Code", '007') then
            _CemServices."Field Work Sub Cat. Name" := _FieldWorkSubCate.Name;
        _CemServices."Cost Amount" := pContract."Bury Amount";
        _CemServices.Quantity := 1;
        _CemServices.Amount := pContract."Bury Amount";
        _CemServices."Receipt Amount" := pContract."Bury Amount";
        _CemServices."Receipt Amount Date" := pPayRecDoc."Payment Date";
        _CemServices."Source No." := pPayRecDoc."Document No.";
        _CemServices."Appl. Name" := pContract."Main Associate Name";
        _CemServices."Appl. Mobile No." := pContract."Cust. Mobile No.";
        _CemServices."Appl. Phone No." := pContract."Cust. Phone No.";
        _CemServices."Appl. E-mail" := pContract."Cust. E-Mail";

        if _CemServices."Appl. E-mail" = '' then
            _CemServices."Email Status" := true;

        _CemServices.Insert(true);
        _CemServices.Status := _CemServices.Status::Complete;
        _CemServices.Modify;
    end;

    local procedure DeleteCemeteryService(pPayRecDoc: Record "DK_Payment Receipt Document")
    var
        _CemServices: Record "DK_Cemetery Services";
    begin

        _CemServices.Reset;
        //_CemServices.SETRANGE("Source No.", pPayRecDoc."Document No.");
        _CemServices.SetRange("Contract No.", pPayRecDoc."Contract No.");
        _CemServices.SetRange(Status, _CemServices.Status::Complete);
        _CemServices.SetRange("Field Work Main Cat. Code", '015');  //Fixed Value Ž˜”í
        _CemServices.SetRange("Field Work Sub Cat. Code", '007');   //Fixed Value “´“šŽ˜”íŠ±
        if _CemServices.FindSet then
            _CemServices.DeleteAll;
    end;

    local procedure CheckNextPayReceiptRecordExists(pPayReceiptDoc: Record "DK_Payment Receipt Document"): Code[20]
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
    begin

        pPayReceiptDoc.CalcFields("Line General Start Date", "Line Land. Arc. Start Date",
                                  "Line Deposit Amount", "Line Contract Amount", "Line Remaining Amount");

        if (pPayReceiptDoc."Line General Start Date" <> 0D) then begin

            _PayRecDoc.Reset;
            _PayRecDoc.SetCurrentKey("Payment Date");
            _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
            _PayRecDoc.SetRange("Contract No.", pPayReceiptDoc."Contract No.");
            _PayRecDoc.SetRange(Refund, false);
            _PayRecDoc.SetRange(Posted, true);
            _PayRecDoc.SetFilter("Line General Start Date", '>=%1', pPayReceiptDoc."Line General Start Date");
            _PayRecDoc.SetFilter("Document No.", '<>%1', pPayReceiptDoc."Document No.");
            if _PayRecDoc.FindLast then
                exit(_PayRecDoc."Document No.");
        end;

        if (pPayReceiptDoc."Line Land. Arc. Start Date" <> 0D) then begin

            _PayRecDoc.Reset;
            _PayRecDoc.SetCurrentKey("Payment Date");
            _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
            _PayRecDoc.SetRange("Contract No.", pPayReceiptDoc."Contract No.");
            _PayRecDoc.SetRange(Refund, false);
            _PayRecDoc.SetRange(Posted, true);
            _PayRecDoc.SetFilter("Line Land. Arc. Start Date", '>=%1', pPayReceiptDoc."Line Land. Arc. Start Date");
            _PayRecDoc.SetFilter("Document No.", '<>%1', pPayReceiptDoc."Document No.");
            if _PayRecDoc.FindLast then
                exit(_PayRecDoc."Document No.");
        end;
    end;
}

