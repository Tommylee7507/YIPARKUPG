codeunit 50013 "DK_Revocation Contract Mgt."
{
    // *DK33 : 20200730
    //   - Modify Function : GetRefundRate
    //                       CalcRefundAmount
    //                       GetPaymentReceiptAmount
    // DK34 : 20201130
    //   - Modify Function : GetRefundRate


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label '%1 has no data registered before the %4. Check the %1. %2:%3, %4:%5, %6:%7';
        _ContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail";
        MSG002: Label 'No refund criterion exists for %1 at %2. Check the %1 %2:%3';
        MSG003: Label 'There are no applicable refund criteria for %1. Check the %1. %2:%3, %4:%5';
        MSG004: Label '%1 does not exist. Check Contract. %2:%3';
        MSG005: Label 'Y';
        MSG006: Label 'M';
        MSG007: Label 'D';
        MSG008: Label 'There are required documents that have not yet been received. %2';
        MSG009: Label ' \\ ';
        MSG010: Label 'This contract is Non-Payment and currently %1 is %2. Please cancel the unpaid amount before proceeding to the Revocation.';

    local procedure Check(pRevContract: Record "DK_Revocation Contract"): Boolean
    begin
        with pRevContract do begin

            TestField("Contract No.");
            TestField("Cemetery Code");
            TestField("Customer No.");
            TestField("Revocation Date");
            if pRevContract."Contract Date" = 0D then
                Error(MSG004, pRevContract.FieldCaption("Contract Date"), pRevContract.FieldCaption("Contract No."), pRevContract."Contract No.");
        end;

        exit(true);
    end;


    procedure CheckRequestDoc(pRevContract: Record "DK_Revocation Contract")
    var
        _ReqDocRec: Record "DK_Request Document Rec.";
        _DocName: Text;
    begin

        _ReqDocRec.Reset;
        _ReqDocRec.SetRange("Table ID", DATABASE::"DK_Revocation Contract");
        _ReqDocRec.SetRange("Source No.", pRevContract."Document No.");
        _ReqDocRec.SetRange(Mandatory, true);
        _ReqDocRec.SetRange("Attached Name", '');
        if _ReqDocRec.FindSet then begin
            repeat
                _DocName := _DocName + MSG009 + _ReqDocRec."Document Name";
            until _ReqDocRec.Next = 0;
            Error(MSG008, _ReqDocRec.Count, _DocName);
        end;
    end;


    procedure CalcRefundAmount(var pRevContract: Record "DK_Revocation Contract")
    var
        _ContRefundRefTable: Record "DK_Cont. Refund Ref. Table";
        _ContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail";
        _TempContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail" temporary;
        _RefundRate: Decimal;
        _RefundAmount: Decimal;
        _BatchDailyAdminExpense: Codeunit "DK_Batch Daily Admin. Expense";
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _Contract: Record DK_Contract;
        _TempCemeAmount: Decimal;
        _TempBuryAmount: Decimal;
        _TempGenAmount: Decimal;
        _TempLandAmount: Decimal;
        _CalcAmount: Decimal;
    begin

        if not Check(pRevContract) then exit;

        ClearRefundAmount(pRevContract);

        //—¹ŽÊŸÀ€Ø‘÷— €¦Ž¸ Ÿ—­ Ð‹Ó.

        _Contract.Get(pRevContract."Contract No.");

        //¯€¦Ž¸
        _CalcAmount := _Contract."Deposit Amount" + _Contract."Contract Amount" + _Contract."Rece. Remaining Amount";

        //‰ª¬ ‹ÏÔ‡ß
        if _CalcAmount <> 0 then begin
            if _CalcAmount > (_Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount") then
                _TempCemeAmount := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount"
            else
                _TempCemeAmount := _CalcAmount;

            _CalcAmount -= _TempCemeAmount;
        end;
        //ˆ•Î/Ž˜”íŠ±
        if _CalcAmount <> 0 then begin
            if _CalcAmount > _Contract."Bury Amount" then
                _TempBuryAmount := _Contract."Bury Amount"
            else
                _TempBuryAmount := _CalcAmount;

            _CalcAmount -= _TempBuryAmount;
        end;
        //Ÿ‰¦ýˆ«Š±
        if _CalcAmount <> 0 then begin
            if _CalcAmount > _Contract."General Amount" then
                _TempGenAmount := _Contract."General Amount"
            else
                _TempGenAmount := _CalcAmount;

            _CalcAmount -= _TempGenAmount;
        end;
        //‘†µýˆ«Š±
        if _CalcAmount <> 0 then begin
            if _CalcAmount > _Contract."Landscape Arc. Amount" then
                _TempLandAmount := _Contract."Landscape Arc. Amount"
            else
                _TempLandAmount := _CalcAmount;

            _CalcAmount -= _TempLandAmount;
        end;

        //------------------------------------------------------------------------------------------------------
        //˜»Š­ ˜»€Ã
        _RefundRate := GetRefundRate(pRevContract);

        if (_Contract."Contract Date" <> 0D) and
           (_Contract."Contract Date" < pRevContract."Revocation Date") then begin
            //ÐŽÊ€Ëú ˜«ž.
            if _Contract.Status <> _Contract.Status::FullPayment then begin
                /*//ýˆ«Š± Ð‹ÓŠ Ÿ‚‚ž µÕíˆˆ “‚ˆ«…š
                 //’ð‰œ… ·Î ˜«ž‹Ï—¸

                //ýˆ«Š± ‰ÐŠ¨ ‘°—Ê
                pRevContract."Sys. Refund General Amount" := _TempGenAmount - (GetPeriodAdminExpenseAmount(_Contract, _AdminExpLedger."Admin. Expense Type"::General, pRevContract."Revocation Date")*-1);
                IF pRevContract."Sys. Refund General Amount" < 0 THEN pRevContract."Sys. Refund General Amount" := 0;

                pRevContract."Sys. Refund Land. Arc. Amount" := _TempLandAmount- (GetPeriodAdminExpenseAmount(_Contract, _AdminExpLedger."Admin. Expense Type"::Landscape, pRevContract."Revocation Date")*-1);
                IF pRevContract."Sys. Refund Land. Arc. Amount"  < 0 THEN pRevContract."Sys. Refund Land. Arc. Amount" := 0;
                */
            end else begin
                //_Contract.Status::FullPayment

                Clear(_BatchDailyAdminExpense);

                //>>DK33
                if pRevContract."Document No." in ['RCD0001915', 'RCD0001916', 'RCD0001945'] then begin

                    //Ÿ ýˆ«Š± ‹²ŒŠ ‰¸ øÔ ‘°—Ê!!!!!
                    _BatchDailyAdminExpense.BatchCreateAdminExpenseLedgerforReceipt(pRevContract."Revocation Date", pRevContract."Contract No.");
                    _BatchDailyAdminExpense.FindContract(pRevContract."Revocation Date", pRevContract."Contract No.");



                end else begin

                    //Ÿ ýˆ«Š± ‹²ŒŠ ‰¸ øÔ ‘°—Ê!!!!!
                    _BatchDailyAdminExpense.BatchCreateAdminExpenseLedgerforReceipt(Today, pRevContract."Contract No.");
                    _BatchDailyAdminExpense.FindContract(Today, pRevContract."Contract No.");

                end;

                Commit;

                _Contract.CalcFields("Admin. Expense Method", "Receipt Admin. Exp. Led. Exis.", "Daily Admin. Exp. Ledger Exis.", "Landscape Architecture", "First Corpse Exists");
                if _Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract then begin
                    if (_Contract."Receipt Admin. Exp. Led. Exis.") or (_Contract."Daily Admin. Exp. Ledger Exis.") then begin




                        if _Contract."Daily Admin. Exp. Ledger Exis." then begin //DK33
                            //Ÿ‰¦ ýˆ«Š± ˜»€ÃŽ¸
                            pRevContract."Sys. Refund General Amount" := GetPeriodAdminExpAmt(pRevContract."Contract No.",
                                                                                          _AdminExpLedger."Admin. Expense Type"::General,
                                                                                          pRevContract."Revocation Date",
                                                                                          _Contract."General Expiration Date");


                            //‘†µ ýˆ«Š± ˜»€ÃŽ¸
                            if _Contract."Landscape Architecture" then
                                pRevContract."Sys. Refund Land. Arc. Amount" := GetPeriodAdminExpAmt(pRevContract."Contract No.",
                                                                                            _AdminExpLedger."Admin. Expense Type"::Landscape,
                                                                                            pRevContract."Revocation Date",
                                                                                            _Contract."Land. Arc. Expiration Date");
                        end else begin

                            //Ÿ‰¦ ýˆ«Š± ˜»€ÃŽ¸(¯€¦Ž¸)
                            pRevContract."Sys. Refund General Amount" := GetPaymentReceiptAmount(pRevContract."Contract No.", _AdminExpLedger."Admin. Expense Type"::General);

                            //‘†µ ýˆ«Š± ˜»€ÃŽ¸(¯€¦Ž¸)
                            if _Contract."Landscape Architecture" then
                                pRevContract."Sys. Refund Land. Arc. Amount" := GetPaymentReceiptAmount(pRevContract."Contract No.", _AdminExpLedger."Admin. Expense Type"::Landscape);
                        end;

                    end;
                end else begin
                    //<<DK33
                    //Ÿ‰¦ ýˆ«Š± ˜»€ÃŽ¸
                    pRevContract."Sys. Refund General Amount" := GetPeriodAdminExpAmt(pRevContract."Contract No.",
                                                                                  _AdminExpLedger."Admin. Expense Type"::General,
                                                                                  pRevContract."Revocation Date",
                                                                                  _Contract."General Expiration Date");


                    //‘†µ ýˆ«Š± ˜»€ÃŽ¸
                    _Contract.CalcFields("Landscape Architecture");
                    if _Contract."Landscape Architecture" then
                        pRevContract."Sys. Refund Land. Arc. Amount" := GetPeriodAdminExpAmt(pRevContract."Contract No.",
                                                                                    _AdminExpLedger."Admin. Expense Type"::Landscape,
                                                                                    pRevContract."Revocation Date",
                                                                                    _Contract."Land. Arc. Expiration Date");
                end;
            end;
        end;

        //‰œ‚‚€¦Ž¸ ‘ˆÏŠž ˜«ž!!!

        //>>DK33
        //Ÿ ýˆ«Š±í ‹²ŒŠ…—ŽØ ýˆ«Š± ‘Ž‡ßŸœŠ»µ …—Ž·‹ Œ÷ ´ˆ‰—‡ž ÐŽÊ‹ „¾“ ‘†˜ˆ—³„Ÿ„¾.
        _Contract.Get(pRevContract."Contract No.");

        if _Contract.Status = _Contract.Status::FullPayment then begin
            if (_Contract."General Expiration Date" <> 0D) and
               (_Contract."General Expiration Date" < pRevContract."Revocation Date") then
                Error(MSG010, _Contract.FieldCaption("General Expiration Date"), _Contract."General Expiration Date");

            _Contract.CalcFields("Landscape Architecture");
            if _Contract."Landscape Architecture" then begin
                if (_Contract."Land. Arc. Expiration Date" <> 0D) and
                   (_Contract."Land. Arc. Expiration Date" < pRevContract."Revocation Date") then
                    Error(MSG010, _Contract.FieldCaption("Land. Arc. Expiration Date"), _Contract."Land. Arc. Expiration Date");
            end;
        end;
        //<<DK33

        pRevContract."Refund General Amount" := pRevContract."Sys. Refund General Amount";
        pRevContract."Refund Land. Arc. Amount" := pRevContract."Sys. Refund Land. Arc. Amount";

        pRevContract.CalcFields("Payment Amount", "Pay. Remaining Amount", "First Laying Date");

        //—¹‘÷€¦Ž¸ “Èí
        pRevContract."Sales Rev. Amount" := (_Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount");
        pRevContract."Sales Rev. Amount" := Round(((pRevContract."Sales Rev. Amount") / 100) * _RefundRate, 1, '=');

        _Contract.CalcFields("Admin. Expense Method"); //DK33
        if (pRevContract."First Laying Date" <> 0D) and (_Contract."Admin. Expense Method" = _Contract."Admin. Expense Method"::Contract) then begin //DK33
                                                                                                                                                     //ŠŽ˜„Ïœ Ž–„ŸˆÒŒ¡ “´“š Œ‚‰ªŸÀí ´„’ µÕ ˜»Š­€¦ Ž°!

            pRevContract."Refund Rate" := 0;
            pRevContract."Sys. Refund Cemetery Amount" := 0;
            pRevContract."Sys. Refund Bury Amount" := 0;
            pRevContract."Sales Rev. Amount" := 0;

        end else begin

            if _RefundRate = 0 then begin
                _RefundAmount := 0;
            end else
                if _RefundRate = 100 then begin
                    _RefundAmount := _TempCemeAmount;

                    //’ð‰œ…·Î Í“‹(2019-10-30)ˆ‡ž Â€¦ Ÿ‚‚ž ‹Ý•’íŒ¡
                    //˜»€Ãœ 100ž µÕ Ÿ ýˆ«Š±…… ’ð¿—Ÿ‘÷ Žš.!
                    if _Contract.Status = _Contract.Status::FullPayment then begin
                        if _Contract."Admin. Expense Method" = _Contract."Admin. Expense Method"::Contract then begin
                            //Ÿ‰¦ ‰ª¬
                            pRevContract."Sys. Refund General Amount" := _TempGenAmount;
                            pRevContract."Sys. Refund Land. Arc. Amount" := _TempLandAmount;
                        end else begin
                            //ŠŽ˜˜” ‰ª¬
                            pRevContract."Sys. Refund General Amount" := GetPaymentReceiptAmount(pRevContract."Contract No.", _AdminExpLedger."Admin. Expense Type"::General);
                            pRevContract."Sys. Refund Land. Arc. Amount" := GetPaymentReceiptAmount(pRevContract."Contract No.", _AdminExpLedger."Admin. Expense Type"::Landscape);
                        end;
                        pRevContract."Refund General Amount" := pRevContract."Sys. Refund General Amount";
                        pRevContract."Refund Land. Arc. Amount" := pRevContract."Sys. Refund Land. Arc. Amount";
                    end;
                end else begin
                    _RefundAmount := Round(((_TempCemeAmount) / 100) * _RefundRate, 1, '=');
                end;

            pRevContract."Refund Rate" := _RefundRate;
            pRevContract."Sys. Refund Cemetery Amount" := _RefundAmount;
            pRevContract."Sys. Refund Bury Amount" := _TempBuryAmount;

        end;

        pRevContract."Refund Cemetery Amount" := pRevContract."Sys. Refund Cemetery Amount";
        pRevContract."Refund Bury Amount" := pRevContract."Sys. Refund Bury Amount";

        //—³Ð
        pRevContract."System Refund Amount" := pRevContract."Sys. Refund Cemetery Amount" +
                                              pRevContract."Sys. Refund Bury Amount" +
                                              pRevContract."Sys. Refund General Amount" +
                                              pRevContract."Sys. Refund Land. Arc. Amount";
        pRevContract.Validate("Apply Refund Amount", pRevContract."System Refund Amount");

    end;

    local procedure GetRefundRate(pRevContract: Record "DK_Revocation Contract"): Decimal
    var
        _ContRefundRefTable: Record "DK_Cont. Refund Ref. Table";
        _ContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail";
        _TempContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail" temporary;
        _BlankDateform: DateFormula;
        _EstateTypeFilter: Option;
    begin
        Clear(_BlankDateform);

        pRevContract.CalcFields("Estate Type");

        //>>DK32
        //…Ÿ—© „Â‘÷ »—ý— ˜»Š­ ‘†——Ñí Ž°„’ µÕ °•Ô „Â‘÷ »—ý‹ ‹ÏÔ—¯!!!!!!!!!!!

        _ContRefundRefTable.Reset;
        _ContRefundRefTable.SetCurrentKey("Estate Type", "Starting Date");
        _ContRefundRefTable.SetRange(Status, _ContRefundRefTable.Status::Released);
        _ContRefundRefTable.SetRange("Estate Type", pRevContract."Estate Type");
        _ContRefundRefTable.SetFilter("Starting Date", '<=%1', pRevContract."Revocation Date");
        if _ContRefundRefTable.FindLast then
            _EstateTypeFilter := _ContRefundRefTable."Estate Type"
        else
            _EstateTypeFilter := _ContRefundRefTable."Estate Type"::Blank;
        //<<DK32

        _ContRefundRefTable.Reset;
        _ContRefundRefTable.SetCurrentKey("Estate Type", "Starting Date");
        _ContRefundRefTable.SetRange(Status, _ContRefundRefTable.Status::Released);
        _ContRefundRefTable.SetRange("Estate Type", _EstateTypeFilter);
        _ContRefundRefTable.SetFilter("Starting Date", '<=%1', pRevContract."Revocation Date");
        if _ContRefundRefTable.FindLast then begin


            _ContRefundRefDetail.Reset;
            _ContRefundRefDetail.SetRange("Starting Date", _ContRefundRefTable."Starting Date");
            _ContRefundRefDetail.SetRange("Estate Type", _ContRefundRefTable."Estate Type");
            _ContRefundRefDetail.SetRange("Contract Type", pRevContract."Contract Type");
            if _ContRefundRefDetail.FindSet then begin
                repeat
                    _TempContRefundRefDetail.Init;
                    _TempContRefundRefDetail.TransferFields(_ContRefundRefDetail);

                    if _TempContRefundRefDetail."Period From" = _BlankDateform then
                        _TempContRefundRefDetail."From Date" := 19000101D
                    else
                        _TempContRefundRefDetail."From Date" := CalcDate(StrSubstNo('<%1>', _TempContRefundRefDetail."Period From"), pRevContract."Contract Date");


                    if _TempContRefundRefDetail."Period To" = _BlankDateform then
                        _TempContRefundRefDetail."To Date" := 29990101D
                    else
                        _TempContRefundRefDetail."To Date" := CalcDate(StrSubstNo('<%1>', _TempContRefundRefDetail."Period To"), pRevContract."Contract Date");
                    _TempContRefundRefDetail.Insert;
                until _ContRefundRefDetail.Next = 0;
            end else begin
                Error(MSG002, _ContRefundRefTable.TableCaption,
                              pRevContract.FieldCaption("Contract Type"),
                              pRevContract."Contract Type");
            end;
        end else begin
            Error(MSG001, _ContRefundRefTable.TableCaption,
                          pRevContract.FieldCaption("Contract No."),
                          pRevContract."Contract No.",
                          pRevContract.FieldCaption("Contract Date"),
                          pRevContract."Contract Date",
                          pRevContract.FieldCaption("Revocation Date"),
                          pRevContract."Revocation Date");
        end;

        _TempContRefundRefDetail.Reset;
        _TempContRefundRefDetail.SetCurrentKey("Contract Type", "From Date");
        if _TempContRefundRefDetail.FindFirst then begin
            repeat
                //>>DK34
                if (pRevContract."Contract Type" = pRevContract."Contract Type"::Deposit) or
                  (pRevContract."Contract Type" = pRevContract."Contract Type"::"Change Location") or
                  (pRevContract."Contract Type" = pRevContract."Contract Type"::"Full Pay Change Location") then begin
                    //‰ŽÊ€¦,Â€¦‰œ‚‚(º”íŠ»µ),Â€¦Ÿ‚‚(º”íŠ»µ)Š €Ëú‘ª—© Ž°
                    exit(_TempContRefundRefDetail."Refund Rate");
                end else begin
                    if (_TempContRefundRefDetail."From Date" <= pRevContract."Revocation Date") and
                       (_TempContRefundRefDetail."To Date" >= pRevContract."Revocation Date") then
                        exit(_TempContRefundRefDetail."Refund Rate");
                end;
            //<<
            until _TempContRefundRefDetail.Next = 0;
        end;

        Error(MSG003, _ContRefundRefTable.TableCaption,
                  pRevContract.FieldCaption("Contract Type"),
                  pRevContract."Contract Type",
                  pRevContract.FieldCaption("Revocation Date"),
                  pRevContract."Revocation Date");
    end;


    procedure CalcContractPreiod(pContractDate: Date; pRevocationDate: Date): Text[30]
    var
        ArrContractDate: array[3] of Integer;
        ArrRevocationDate: array[3] of Integer;
        ArrDiffDate: array[3] of Integer;
    begin

        if (pContractDate = 0D) or (pRevocationDate = 0D) then
            exit('');


        ArrContractDate[1] := Date2DMY(pContractDate, 1); //Day
        ArrContractDate[2] := Date2DMY(pContractDate, 2); //Month
        ArrContractDate[3] := Date2DMY(pContractDate, 3); //Year

        ArrRevocationDate[1] := Date2DMY(pRevocationDate, 1); //Day
        ArrRevocationDate[2] := Date2DMY(pRevocationDate, 2); //Month
        ArrRevocationDate[3] := Date2DMY(pRevocationDate, 3); //Year

        ArrDiffDate[1] := ArrRevocationDate[1] - ArrContractDate[1]; //Day

        ArrDiffDate[2] := ArrRevocationDate[2] - ArrContractDate[2]; //Month

        if ArrDiffDate[1] < 0 then begin
            ArrDiffDate[2] -= 1; //Month
            ArrDiffDate[1] := ArrRevocationDate[1] + (CalcDate('<+CM>', pContractDate) - pContractDate); //Day
        end;

        ArrDiffDate[3] := ArrRevocationDate[3] - ArrContractDate[3]; //Year

        if ArrDiffDate[2] < 0 then begin
            ArrDiffDate[3] -= 1; //Month
            ArrDiffDate[2] := 12 + ArrDiffDate[2];
        end;

        exit(StrSubstNo('%1%2 %3%4 %5%6', ArrDiffDate[3], MSG005,
        ArrDiffDate[2], MSG006,
        ArrDiffDate[1], MSG007));
    end;


    procedure CalcContractYearPreiod(pContractDate: Date; pRevocationDate: Date): Text[30]
    var
        ArrContractDate: array[3] of Integer;
        ArrRevocationDate: array[3] of Integer;
        ArrDiffDate: array[3] of Integer;
    begin

        if (pContractDate = 0D) or (pRevocationDate = 0D) then
            exit('');


        ArrContractDate[1] := Date2DMY(pContractDate, 1); //Day
        ArrContractDate[2] := Date2DMY(pContractDate, 2); //Month
        ArrContractDate[3] := Date2DMY(pContractDate, 3); //Year

        ArrRevocationDate[1] := Date2DMY(pRevocationDate, 1); //Day
        ArrRevocationDate[2] := Date2DMY(pRevocationDate, 2); //Month
        ArrRevocationDate[3] := Date2DMY(pRevocationDate, 3); //Year

        ArrDiffDate[1] := ArrRevocationDate[1] - ArrContractDate[1]; //Day

        ArrDiffDate[2] := ArrRevocationDate[2] - ArrContractDate[2]; //Month

        if ArrDiffDate[1] < 0 then begin
            ArrDiffDate[2] -= 1; //Month
            ArrDiffDate[1] := ArrRevocationDate[1] + (CalcDate('<+CM>', pContractDate) - pContractDate); //Day
        end;

        ArrDiffDate[3] := ArrRevocationDate[3] - ArrContractDate[3]; //Year

        if ArrDiffDate[2] < 0 then begin
            ArrDiffDate[3] -= 1; //Month
            ArrDiffDate[2] := 12 + ArrDiffDate[2];
        end;

        if (ArrDiffDate[3] = 0) and (ArrDiffDate[2] = 0) then
            exit('');

        exit(StrSubstNo('%1.%2', ArrDiffDate[3], ArrDiffDate[2]));
    end;


    procedure RequestRemittance(pRec: Record "DK_Revocation Contract")
    var
        _RequestRemittanceLedger: Record "DK_Request Remittance Ledger";
    begin

        _RequestRemittanceLedger.Init;
        _RequestRemittanceLedger."Account Type" := _RequestRemittanceLedger."Account Type"::Customer;
        _RequestRemittanceLedger."Account No." := pRec."Customer No.";
        _RequestRemittanceLedger."Account Name" := pRec."Customer Name";
        _RequestRemittanceLedger.Validate("Request Payment Date", pRec."Revocation Date");
        _RequestRemittanceLedger."Bank Code" := pRec."Bank Code";
        _RequestRemittanceLedger."Bank Name" := pRec."Bank Name";
        _RequestRemittanceLedger."Bank Account No." := pRec."Bank Account No.";
        _RequestRemittanceLedger."Bank Account Holder" := pRec."Account Holder";
        _RequestRemittanceLedger."Source Type" := _RequestRemittanceLedger."Source Type"::Revocation;
        _RequestRemittanceLedger."Source No." := pRec."Document No.";
        _RequestRemittanceLedger.Amount := pRec."Bank Request Amount";
        _RequestRemittanceLedger.Description := '';
        _RequestRemittanceLedger."GroupWare Doc. No." := pRec."GroupWare Doc. No.";
        _RequestRemittanceLedger.Validate("Contract No.", pRec."Contract No.");
        _RequestRemittanceLedger."Supervise No." := pRec."Supervise No.";
        _RequestRemittanceLedger.Validate("Cemetery Code", pRec."Cemetery Code");
        _RequestRemittanceLedger."Cancel Pay. Card Amount" := pRec."Cancel Pay. Card Amount";
        _RequestRemittanceLedger."Payment Card Infor." := pRec."Payment Card Infor.";

        _RequestRemittanceLedger.Insert(true);
    end;

    local procedure GetPeriodAdminExpAmt(pContractNo: Code[20]; pAdminExpenseType: Option; pRevocationDate: Date; pExpirationDate: Date): Decimal
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _RefundAmount: Decimal;
    begin

        if pRevocationDate = 0D then exit(0);

        Clear(_RefundAmount);

        _AdminExpLedger.Reset;
        _AdminExpLedger.SetRange("Contract No.", pContractNo);
        _AdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
        _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Daily);
        _AdminExpLedger.SetRange(Date, pRevocationDate + 1, pExpirationDate); //—¹ŽÊÍ“‹Ÿµ „¾‚»Šž•— ýˆ«Š±í ˜»Š­…š!
        _AdminExpLedger.SetFilter("Payment Type", '<>%1', _AdminExpLedger."Payment Type"::DebtRelief); //•‘¿Š —¹„Ï Ž˜—¯
        _AdminExpLedger.SetRange("Add. Period", false); //ýˆ«Š± ¯€¦ €Ëú ’ðŽ¸ ‰È‹²ˆ‡ž “Èí ‘ª° €Ëú
        _AdminExpLedger.SetRange(Open, true);
        if _AdminExpLedger.FindSet then begin
            _AdminExpLedger.CalcSums(Amount);
            _RefundAmount := (_AdminExpLedger.Amount * -1);
        end;

        exit(_RefundAmount);
    end;


    procedure CalcContractPreiodMonth(pContractDate: Date; pRevocationDate: Date): Integer
    var
        ArrContractDate: array[3] of Integer;
        ArrRevocationDate: array[3] of Integer;
        ArrDiffDate: array[3] of Integer;
    begin

        if (pContractDate = 0D) or (pRevocationDate = 0D) then
            exit(0);

        ArrContractDate[1] := Date2DMY(pContractDate, 1); //Day
        ArrContractDate[2] := Date2DMY(pContractDate, 2); //Month
        ArrContractDate[3] := Date2DMY(pContractDate, 3); //Year

        ArrRevocationDate[1] := Date2DMY(pRevocationDate, 1); //Day
        ArrRevocationDate[2] := Date2DMY(pRevocationDate, 2); //Month
        ArrRevocationDate[3] := Date2DMY(pRevocationDate, 3); //Year

        ArrDiffDate[1] := ArrRevocationDate[1] - ArrContractDate[1]; //Day

        ArrDiffDate[2] := ArrRevocationDate[2] - ArrContractDate[2]; //Month

        if ArrDiffDate[1] < 0 then begin
            ArrDiffDate[2] -= 1; //Month
            ArrDiffDate[1] := ArrRevocationDate[1] + (CalcDate('<+CM>', pContractDate) - pContractDate); //Day
        end;

        ArrDiffDate[3] := ArrRevocationDate[3] - ArrContractDate[3]; //Year

        if ArrDiffDate[2] < 0 then begin
            ArrDiffDate[3] -= 1; //Month
            ArrDiffDate[2] := 12 + ArrDiffDate[2];
        end;

        if ArrDiffDate[1] > 0 then
            ArrDiffDate[1] := 1;

        exit((ArrDiffDate[3] * 12) + ArrDiffDate[2] + ArrDiffDate[1]);
    end;

    local procedure GetPeriodAdminExpenseAmount(pContract: Record DK_Contract; pAdminExpenseType: Option; pEndingDate: Date): Decimal
    var
        _RetAmount: Decimal;
        _LoopDate: Record Date;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _EntryRemAmount: Decimal;
    begin

        _LoopDate.Reset;
        _LoopDate.SetRange("Period Type", _LoopDate."Period Type"::Date);
        _LoopDate.SetRange("Period Start", pContract."Contract Date", pEndingDate);
        if _LoopDate.FindSet then begin
            repeat
                _RetAmount += _AdminExpenseMgt.GetContractDailyAdminExpense(pContract, _LoopDate."Period Start", pAdminExpenseType, 0D, false, _EntryRemAmount);
            until _LoopDate.Next = 0;
        end;

        exit(_RetAmount);
    end;

    local procedure ClearRefundAmount(var pRevContract: Record "DK_Revocation Contract")
    begin

        with pRevContract do begin
            "Refund Rate" := 0;
            "Sys. Refund Cemetery Amount" := 0;
            "Sys. Refund Bury Amount" := 0;
            "Sys. Refund General Amount" := 0;
            "Sys. Refund Land. Arc. Amount" := 0;
            "System Refund Amount" := 0;
            "Refund Cemetery Amount" := 0;
            "Refund Bury Amount" := 0;
            "Refund General Amount" := 0;
            "Refund Land. Arc. Amount" := 0;
            "Apply Refund Amount" := 0;
            "Cancel Pay. Card Amount" := 0;
            "Bank Request Amount" := 0;
        end;
    end;


    procedure CancelRequestRemittance(pRevocationContract: Record "DK_Revocation Contract")
    var
        _RequestRemittanceLedger: Record "DK_Request Remittance Ledger";
    begin

        _RequestRemittanceLedger.Reset;
        _RequestRemittanceLedger.SetRange("Source No.", pRevocationContract."Document No.");
        if _RequestRemittanceLedger.FindSet then begin
            _RequestRemittanceLedger.Validate(Status, _RequestRemittanceLedger.Status::Canceled);
            _RequestRemittanceLedger.Modify;
        end;
    end;

    local procedure GetPaymentReceiptAmount(pContractNo: Code[20]; pAdminExpenseType: Option): Decimal
    var
        _AdminExpLedger: Record "DK_Admin. Expense Ledger";
        _RefundAmount: Decimal;
    begin
        //>>DK33
        Clear(_RefundAmount);

        _AdminExpLedger.Reset;
        _AdminExpLedger.SetRange("Contract No.", pContractNo);
        _AdminExpLedger.SetRange("Admin. Expense Type", pAdminExpenseType);
        _AdminExpLedger.SetRange("Ledger Type", _AdminExpLedger."Ledger Type"::Receipt);
        _AdminExpLedger.SetFilter("Payment Type", '<>%1', _AdminExpLedger."Payment Type"::DebtRelief); //•‘¿Š —¹„Ï Ž˜—¯
        _AdminExpLedger.SetRange("Add. Period", false); //ýˆ«Š± ¯€¦ €Ëú ’ðŽ¸ ‰È‹²ˆ‡ž “Èí ‘ª° €Ëú
        if _AdminExpLedger.FindSet then begin
            _AdminExpLedger.CalcSums(Amount);
            _RefundAmount := (_AdminExpLedger.Amount);
        end;

        exit(_RefundAmount);

        //<<DK33
    end;
}

