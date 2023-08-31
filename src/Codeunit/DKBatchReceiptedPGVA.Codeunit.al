codeunit 50037 "DK_Batch Receipted PG/VA"
{
    // //“ú AM 7“ ~ PM 10“
    // //ˆ•Ÿ 1“ú ‘´€Ë‡ž …Á!


    trigger OnRun()
    begin


        //PG ß‘ª Žð…Ñœ–«
        BatchDailyReceiptedPGDoc;

        //í‹ÝÐ‘’ ß‘ª Žð…Ñœ–«
        BatchDailyReceiptedVADoc('');

        Commit;

        //¯€¦‰«Œ¡ ‹²ŒŠ ‰¸ ý€Ë
        BatchCreatePayReceiptDocPost('');

        Commit;

        //PG and VA »˜€Ëú ˆˆ€Ë— ˜«ž.!
        CheckExpirationDate_UpdatePayExpectDoc;
    end;

    var
        PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
        PayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
        MSG001: Label 'Updating Result';
        Windows: Dialog;
        PaymentExpectMgt: Codeunit "DK_Payment Expect";
        PayExpectProHis: Record "DK_Pay. Expect Process History";

    local procedure CheckExpirationDate_UpdatePayExpectDoc()
    var
        _PayExpect: Codeunit "DK_Payment Expect";
    begin

        //PG —­„Ï —¹‘ª
        PayExpectDocHdr.Reset;
        PayExpectDocHdr.SetCurrentKey("Payment Type", "Expiration Date", "Assgin Date", "UnAssgin Date");
        PayExpectDocHdr.SetRange("Payment Type", PayExpectDocHdr."Payment Type"::PG);
        PayExpectDocHdr.SetFilter("Expiration Date", '<%1', Today);
        PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        if PayExpectDocHdr.FindSet then begin
            Clear(PaymentExpectMgt);
            repeat

                PayExpectDocHdr.Status := PayExpectDocHdr.Status::UnAssgin;
                PayExpectDocHdr.Validate("UnAssgin Date", Today);
                PayExpectDocHdr.Modify;

                PaymentExpectMgt.AddPayExpectDocProcessHistory(PayExpectDocHdr."Contract No.",
                                              PayExpectDocHdr."Cemetery Code",
                                              PayExpectDocHdr."Cemetery No.",
                                              PayExpectDocHdr."Document No.",
                                              '',
                                              PayExpectProHis.Status::UnAssgin);
            until PayExpectDocHdr.Next = 0;
        end;

        //í‹ÝÐ‘’ —­„Ï —¹‘ª
        PayExpectDocHdr.Reset;
        PayExpectDocHdr.SetCurrentKey("Payment Type", "Expiration Date", "Assgin Date", "UnAssgin Date");
        PayExpectDocHdr.SetRange("Payment Type", PayExpectDocHdr."Payment Type"::VA);
        PayExpectDocHdr.SetFilter("Expiration Date", '<%1', Today);
        PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        if PayExpectDocHdr.FindSet then begin
            repeat

                _PayExpect.UnAssginVirtualAccnt(PayExpectDocHdr);
            until PayExpectDocHdr.Next = 0;
        end;
    end;


    procedure BatchDailyReceiptedPGDoc()
    var
        _ReceiptedPGDoc: Record "DK_Receipted PG Document";
        _PayExpectDocNo: Code[20];
        _RepCardCompName: Text[10];
        _PGCardComp: Code[20];
        _Contract: Record DK_Contract;
        _NewLineNo: Integer;
        _PaymentExpect: Codeunit "DK_Payment Expect";
    begin

        _ReceiptedPGDoc.Reset;
        _ReceiptedPGDoc.SetRange("Pay. Expect Doc No.", '');
        if _ReceiptedPGDoc.FindSet then begin
            repeat

                _RepCardCompName := CopyStr(_ReceiptedPGDoc."Card Comp. Name", 1, 2);

                //CARD ˜ˆ‹Ï Š»˜»
                case _ReceiptedPGDoc."Card Comp. Code" of
                    '11', 'CNB':
                        begin
                            _PGCardComp := 'A002';    //€‰‰ž
                        end;
                    '21':
                        begin//Â˜»,—Ÿ‚¬
                            if _RepCardCompName = 'Â˜»' then
                                _PGCardComp := 'A004'   //Â˜»
                            else
                                _PGCardComp := 'A011';  //—Ÿ‚¬
                        end;
                    'KEB':
                        begin
                            _PGCardComp := 'A004';    //Â˜»
                        end;
                    'HNB':
                        begin
                            _PGCardComp := 'A011';    //—Ÿ‚¬
                        end;
                    '31':
                        begin//ŽŽ–Œ,Š±ŽŽ
                            if _RepCardCompName = 'ŽŽ–Œ' then
                                _PGCardComp := 'A005'   //ŽŽ–Œ
                            else
                                _PGCardComp := 'A001';  //Š±ŽŽ
                        end;
                    'CIT':
                        begin
                            _PGCardComp := 'A005';    //ŽŽ–Œ
                        end;
                    'BCC', 'PHB':
                        begin
                            _PGCardComp := 'A001';    //Š±ŽŽ
                        end;
                    '41', 'LGC':
                        begin
                            _PGCardComp := 'A003';    //•—©
                        end;
                    '51', 'WIN':
                        begin
                            _PGCardComp := 'A010';    //‹ÙŒŠ
                        end;
                    '61', 'DIN':
                        begin
                            _PGCardComp := 'A007';    //—÷„Ô
                        end;
                    '71', 'AMX':
                        begin
                            _PGCardComp := 'A006';    //‡¯…Ñ
                        end;
                    '91', 'NLC':
                        begin
                            _PGCardComp := 'A009';    //‚Ý—õ
                        end;
                    else begin
                        _PGCardComp := 'A999';    //€Ë•ˆ
                    end;
                end;

                Clear(_PayExpectDocNo);
                Clear(_NewLineNo);

                if _ReceiptedPGDoc."Payment Type" = _ReceiptedPGDoc."Payment Type"::DirectPG then begin
                    //‘ð‘ó ß‘ª
                    //New Data
                    PayExpectDocHdr.Init;
                    PayExpectDocHdr."Document No." := '';
                    PayExpectDocHdr.Validate("Payment Date", _ReceiptedPGDoc."Payment Date");
                    PayExpectDocHdr."Payment Type" := PayExpectDocHdr."Payment Type"::DirectPG;
                    PayExpectDocHdr.Validate("Payment Method Code", _PGCardComp);
                    PayExpectDocHdr."PG Approval No." := _ReceiptedPGDoc."Approval No.";
                    PayExpectDocHdr.Validate("Contract No.", _ReceiptedPGDoc."Contract No.");
                    PayExpectDocHdr."Payment Remark" := _ReceiptedPGDoc."Card Comp. Name";

                    PayExpectDocHdr.Insert(true);

                    //DocumentNo
                    _PayExpectDocNo := PayExpectDocHdr."Document No.";

                    _Contract.Get(PayExpectDocHdr."Contract No.");
                    _Contract.CalcFields("Landscape Architecture");

                    if not _Contract."Landscape Architecture" then begin

                        _NewLineNo += 10000;
                        PayExpectDocLine.Init;
                        PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
                        PayExpectDocLine."Line No." := _NewLineNo;
                        PayExpectDocLine.Validate("Payment Target", PayExpectDocLine."Payment Target"::General);
                        PayExpectDocLine.Validate(Amount, (_ReceiptedPGDoc."General Amount" + _ReceiptedPGDoc."Land. Amount"));
                        PayExpectDocLine.Insert;

                    end else begin

                        if _ReceiptedPGDoc."General Amount" <> 0 then begin

                            _NewLineNo += 10000;
                            PayExpectDocLine.Init;
                            PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
                            PayExpectDocLine."Line No." := _NewLineNo;
                            PayExpectDocLine.Validate("Payment Target", PayExpectDocLine."Payment Target"::General);
                            PayExpectDocLine.Validate(Amount, _ReceiptedPGDoc."General Amount");
                            //PayExpectDocLine."Start Date" := _Contract."General Expiration Date" + 1;
                            //PayExpectDocLine."Expiration Date" := CALCDATE(STRSUBSTNO('<+%1Y>',PayExpectDocLine."Add. Years"), PayExpectDocLine."Start Date")-1;
                            PayExpectDocLine.Insert;
                        end;


                        if _ReceiptedPGDoc."Land. Amount" <> 0 then begin
                            _NewLineNo += 10000;
                            PayExpectDocLine.Init;
                            PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
                            PayExpectDocLine."Line No." := _NewLineNo;
                            PayExpectDocLine.Validate("Payment Target", PayExpectDocLine."Payment Target"::Landscape);
                            PayExpectDocLine.Validate(Amount, _ReceiptedPGDoc."Land. Amount");
                            //PayExpectDocLine."Start Date" := _Contract."Land. Arc. Expiration Date" + 1;
                            //PayExpectDocLine."Expiration Date" := CALCDATE(STRSUBSTNO('<+%1Y>',PayExpectDocLine."Add. Years"), PayExpectDocLine."Start Date")-1;
                            PayExpectDocLine.Insert;
                        end;
                    end;


                end else begin
                    //PG ß‘ª
                    //Update

                    PayExpectDocHdr.Reset;
                    PayExpectDocHdr.SetRange("Payment Type", PayExpectDocHdr."Payment Type"::PG);
                    PayExpectDocHdr.SetRange("Document No.", _ReceiptedPGDoc."Document No.");
                    if PayExpectDocHdr.FindSet then begin

                        PayExpectDocHdr.Validate("Payment Date", _ReceiptedPGDoc."Payment Date");
                        PayExpectDocHdr.Validate("Payment Method Code", _PGCardComp);
                        PayExpectDocHdr."PG Approval No." := _ReceiptedPGDoc."Approval No.";
                        PayExpectDocHdr."Payment Remark" := _ReceiptedPGDoc."Card Comp. Name";
                        PayExpectDocHdr.Status := PayExpectDocHdr.Status::UnAssgin;
                        PayExpectDocHdr.Validate("UnAssgin Date", Today);

                        //Update
                        PaymentExpectMgt.AddPayExpectDocProcessHistory(PayExpectDocHdr."Contract No.",
                                                      PayExpectDocHdr."Cemetery Code",
                                                      PayExpectDocHdr."Cemetery No.",
                                                      PayExpectDocHdr."Document No.",
                                                      '',
                                                      PayExpectProHis.Status::UnAssgin);

                        //DocumentNo
                        _PayExpectDocNo := PayExpectDocHdr."Document No.";


                    end;
                end;

                //ß· Žð…Ñœ–«

                PayExpectDocHdr.Status := PayExpectDocHdr.Status::CustomerPayment;
                PayExpectDocHdr.Modify;

                //Update
                PaymentExpectMgt.AddPayExpectDocProcessHistory(PayExpectDocHdr."Contract No.",
                                              PayExpectDocHdr."Cemetery Code",
                                              PayExpectDocHdr."Cemetery No.",
                                              PayExpectDocHdr."Document No.",
                                              '',
                                              PayExpectProHis.Status::CustomerPayment);

                _ReceiptedPGDoc."Pay. Expect Doc No." := _PayExpectDocNo;
                _ReceiptedPGDoc.Modify;

            until _ReceiptedPGDoc.Next = 0;
        end;
    end;


    procedure BatchDailyReceiptedVADoc(pPayExpectNo: Code[20])
    var
        _MaxCount: Integer;
        _LoopCount: Integer;
        _ExternalDBProcess: Codeunit "DK_External DB Process";
        _PaymentExpect: Codeunit "DK_Payment Expect";
        _VirtualAccount: Record "DK_Virtual Account";
    begin
        ////zzz++
        // PayExpectDocHdr.Reset;
        // PayExpectDocHdr.SetRange("Payment Type", PayExpectDocHdr."Payment Type"::VA);
        // PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        // PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        // PayExpectDocHdr.SetRange("Pay. Receipt Doc. No.", '');
        // //ß‘ª ‰‘ñ ‰«Œ¡ ˜«ž
        // if pPayExpectNo <> '' then
        //     PayExpectDocHdr.SetRange("Document No.", pPayExpectNo);
        // if PayExpectDocHdr.FindSet then begin
        //     repeat

        //         if _ExternalDBProcess.UpdateVirtualAccountResult(PayExpectDocHdr) then begin

        //             if PayExpectDocHdr.Status = PayExpectDocHdr.Status::CustomerPayment then begin
        //                 //UPDATE

        //                 //IF _VirtualAccount.GET(PayExpectDocHdr."Virtual Account No.") THEN BEGIN
        //                 //    _VirtualAccount."Last UnAssgin Date" := TODAY;
        //                 //    _VirtualAccount.MODIFY;
        //                 //END;

        //                 PaymentExpectMgt.AddPayExpectDocProcessHistory(PayExpectDocHdr."Contract No.",
        //                                               PayExpectDocHdr."Cemetery Code",
        //                                               PayExpectDocHdr."Cemetery No.",
        //                                               PayExpectDocHdr."Document No.",
        //                                               '',
        //                                               PayExpectProHis.Status::CustomerPayment);
        //             end;
        //         end;
        //     until PayExpectDocHdr.Next = 0;
        // end;
        ////zzz--
    end;

    local procedure BatchCreatePayReceiptDocPost(pPayExpectNo: Code[20])
    var
        _PaymentExpect: Codeunit "DK_Payment Expect";
    begin
        //¯€¦‰«Œ¡ ‹²ŒŠ ‰¸ ý€Ë(‘ÈŠ‰ ß‘ª —œ ‘ˆÏ—­ Œ÷ ´ˆ‰—‡ž ¯€¦‰«Œ¡ ‹²ŒŠ ˜” ‰¾‡ž ý€Ë“‚ˆ«—¯.!)

        PayExpectDocHdr.Reset;
        PayExpectDocHdr.SetRange(Status, PayExpectDocHdr.Status::CustomerPayment);
        PayExpectDocHdr.SetRange("Pay. Receipt Doc. No.", '');
        //ß‘ª ‰‘ñ ‰«Œ¡ ˜«ž
        if pPayExpectNo <> '' then
            PayExpectDocHdr.SetRange("Document No.", pPayExpectNo);
        if PayExpectDocHdr.FindSet then begin
            repeat

                _PaymentExpect.CreatePayReceiptDoc(PayExpectDocHdr);

                //20200302À… ý€Ë €Ë„™ ‹ÏÔŽ˜—¯ ’†Ýž”½…Î/í‹ÝÐ‘’
                /*
                IF PayExpectDocHdr."Payment Type" <> PayExpectDocHdr."Payment Type"::VA THEN BEGIN
                  //í‹ÝÐ‘’„’ À…ý€Ë—Ÿ‘÷ Žš.!
                    //History
                    PaymentExpectMgt.AddPayExpectDocProcessHistory(PayExpectDocHdr."Contract No.",
                                                  PayExpectDocHdr."Cemetery Code",
                                                  PayExpectDocHdr."Cemetery No.",
                                                  PayExpectDocHdr."Document No.",
                                                  PayExpectDocHdr."Pay. Receipt Doc. No.",
                                                  PayExpectProHis.Status::PostedPayReceiptDoc);
                END;
                */

                if PayExpectDocHdr."Payment Type" = PayExpectDocHdr."Payment Type"::VA then begin
                    //í‹ÝÐ‘’ —­„Ï —¹‘ª!
                    _PaymentExpect.UnAssginVirtualAccnt2(PayExpectDocHdr);
                end;

            until PayExpectDocHdr.Next = 0;
        end;

    end;
}

