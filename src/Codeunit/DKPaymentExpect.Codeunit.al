codeunit 50034 "DK_Payment Expect"
{

    trigger OnRun()
    begin

        //BatchCheckVAExpirationDate(TODAY);
    end;

    var
        MSG001: Label 'This function works only when %1 is %2.';
        MSG002: Label '%1 is already assigned. %1:%2';
        MSG003: Label 'There is currently no %1 Assigined.';
        MSG004: Label 'There is no virtual account number available.';
        PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
        PayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
        FunSetup: Record "DK_Function Setup";
        MSG005: Label 'Cancel!';
        MSG006: Label 'The message %2 set on %1 does not exist. Please set a message for %2!';
        MSG007: Label 'Auto Created Document';
        MSG008: Label 'There is no free virtual account no. available for allocation.';
        MSG011: Label 'This document has been canceled. %1:%2';
        MSG012: Label '%1 has been exceeded. %1:%2';
        MSG013: Label 'This %1 can''t send SMS. %1:%2';
        MSG016: Label 'This document is valid until %2. Would you like to send SMS to the customer?';
        MSG017: Label 'The %1 is %2. Do you want to send a payment instructions SMS to the customer?';
        PaymentExpect: Codeunit "DK_Payment Expect";
        PayExpectProHis: Record "DK_Pay. Expect Process History";
        MSG018: Label 'The amount is (0). %1:%2';
        MSG019: Label 'The %1 %2 has an %3 of (0).';
        MSG020: Label '%3 is not specified for %1 %2.';
        MSG021: Label 'There is a line for which %1 is not specified.';
        MSG022: Label 'There are %1 Payment Expect Document that are still valid. To register a Admin. Expense, please unassign these Payment Expect Document before proceeding.';
        MSG023: Label 'Payment Expect Document cannot be found.';

    local procedure CheckPayExpectDoc(pRec: Record "DK_Pay. Expect Doc. Header")
    begin
        pRec.TestField("Document No.");
        pRec.TestField("Contract No.");

        pRec.TestField("Appl. Name");
        pRec.TestField("Appl. Mobile No.");

        pRec.CalcFields("Total Amount");
        if pRec."Total Amount" = 0 then
            Error(MSG018, pRec.FieldCaption("Document No."),
                          pRec."Document No.");

        PayExpectDocLine.Reset;
        PayExpectDocLine.SetRange("Document No.", pRec."Document No.");
        if PayExpectDocLine.FindSet then begin
            repeat

                case PayExpectDocLine."Payment Target" of
                    PayExpectDocLine."Payment Target"::Blank:
                        begin
                            Error(MSG021, PayExpectDocLine.FieldCaption("Payment Target"));
                        end;
                    PayExpectDocLine."Payment Target"::Deposit,
                    PayExpectDocLine."Payment Target"::Contract,
                    PayExpectDocLine."Payment Target"::Remaining:
                        begin
                            if PayExpectDocLine.Amount = 0 then
                                Error(MSG019, PayExpectDocLine.FieldCaption("Payment Target"),
                                              PayExpectDocLine."Payment Target",
                                              PayExpectDocLine.FieldCaption(Amount));
                        end;
                    PayExpectDocLine."Payment Target"::Service:
                        begin
                            if PayExpectDocLine."Cem. Services No." = '' then
                                Error(MSG020, PayExpectDocLine.FieldCaption("Payment Target"),
                                              PayExpectDocLine."Payment Target",
                                              PayExpectDocLine.FieldCaption("Cem. Services No."));
                            if PayExpectDocLine.Amount = 0 then
                                Error(MSG019, PayExpectDocLine.FieldCaption("Payment Target"),
                                              PayExpectDocLine."Payment Target",
                                              PayExpectDocLine.FieldCaption(Amount));
                        end;
                    PayExpectDocLine."Payment Target"::General,
                    PayExpectDocLine."Payment Target"::Landscape:
                        begin
                            if PayExpectDocLine.Amount = 0 then
                                Error(MSG019, PayExpectDocLine.FieldCaption("Payment Target"),
                                              PayExpectDocLine."Payment Target",
                                              PayExpectDocLine.FieldCaption(Amount));
                        end;
                end;
            until PayExpectDocLine.Next = 0;
        end;
    end;


    procedure FindAvailableVirtualAccnt() Rtn_VirtualAccountNo: Code[20]
    var
        _VirtualAccount: Record "DK_Virtual Account";
    begin

        _VirtualAccount.Reset;
        _VirtualAccount.SetCurrentKey("Last UnAssgin Date");
        _VirtualAccount.SetRange(Blocked, false);
        _VirtualAccount.SetRange("Pay. Expect Doc. No.", '');
        if _VirtualAccount.FindSet then
            exit(_VirtualAccount."Virtual Account No.");

        exit('');
    end;


    procedure AssginVirtualAccnt(var pRec: Record "DK_Pay. Expect Doc. Header"): Boolean
    var
        _ExtDBProcess: Codeunit "DK_External DB Process";
    begin
        CheckPayExpectDoc(pRec);
        CheckVirtualAccountSetup;

        pRec.TestField("Expiration Date");

        if pRec."Virtual Account No." <> '' then begin

            //--------------------------------------------------------
            //í‹ÝÐ‘’ DBí Žð…Ñœ–« ‘°—Ê
            // _ExtDBProcess.AssginVirtualAccount(pRec);////zzz
            //--------------------------------------------------------
            //pRec.TESTFIELD("Expiration Date");
            pRec.Status := pRec.Status::Assgin;
            pRec."Assgin Date" := Today;
            pRec.Modify;

            AddPayExpectDocProcessHistory(pRec."Contract No.",
                                          pRec."Cemetery Code",
                                          pRec."Cemetery No.",
                                          pRec."Document No.",
                                          '',
                                          PayExpectProHis.Status::Assgin);
            exit(true);
        end;
    end;


    procedure AssginPG(var pRec: Record "DK_Pay. Expect Doc. Header"): Boolean
    var
        _ExtDBProcess: Codeunit "DK_External DB Process";
    begin
        CheckPayExpectDoc(pRec);
        CheckPGSetup;

        pRec.UpdatePGURL;

        if pRec."PG URL" <> '' then begin
            pRec.Status := pRec.Status::Assgin;
            pRec."Assgin Date" := Today;
            pRec.Modify;

            AddPayExpectDocProcessHistory(pRec."Contract No.",
                                          pRec."Cemetery Code",
                                          pRec."Cemetery No.",
                                          pRec."Document No.",
                                          '',
                                          PayExpectProHis.Status::Assgin);
            exit(true);

        end;
    end;


    procedure UnAssginVirtualAccnt(var pRec: Record "DK_Pay. Expect Doc. Header"): Boolean
    begin

        if pRec."Payment Type" = pRec."Payment Type"::VA then begin
            CheckVirtualAccountSetup;

            if pRec."Virtual Account No." <> '' then begin
                if UpdateUnAssginVirtualAccount(pRec."Virtual Account No.", pRec) then begin
                    //“Èí ˆÃŒŒ‘÷

                end;

                ///Žð…Ñœ–«
                pRec.Status := pRec.Status::UnAssgin;
                pRec."UnAssgin Date" := Today;
                pRec.Modify;

                AddPayExpectDocProcessHistory(pRec."Contract No.",
                                              pRec."Cemetery Code",
                                              pRec."Cemetery No.",
                                              pRec."Document No.",
                                              '',
                                              PayExpectProHis.Status::UnAssgin);
                exit(true);
            end;
        end;
    end;


    procedure UnAssginVirtualAccnt2(var pRec: Record "DK_Pay. Expect Doc. Header"): Boolean
    begin

        if pRec."Payment Type" = pRec."Payment Type"::VA then begin
            CheckVirtualAccountSetup;

            if pRec."Virtual Account No." <> '' then begin
                if UpdateUnAssginVirtualAccount(pRec."Virtual Account No.", pRec) then begin
                    //“Èí ˆÃŒŒ‘÷

                end;

                AddPayExpectDocProcessHistory(pRec."Contract No.",
                                              pRec."Cemetery Code",
                                              pRec."Cemetery No.",
                                              pRec."Document No.",
                                              '',
                                              PayExpectProHis.Status::UnAssgin);
                exit(true);
            end;
        end;
    end;


    procedure AllUnAssgin(var pRec: Record "DK_Pay. Expect Doc. Header"): Boolean
    begin

        //PG
        pRec.SetRange("Payment Type", pRec."Payment Type"::PG);
        if pRec.FindSet then begin
            repeat

                ///Žð…Ñœ–«
                pRec.Status := pRec.Status::UnAssgin;
                pRec."UnAssgin Date" := Today;
                pRec.Modify;

                AddPayExpectDocProcessHistory(pRec."Contract No.",
                                              pRec."Cemetery Code",
                                              pRec."Cemetery No.",
                                              pRec."Document No.",
                                              '',
                                              PayExpectProHis.Status::UnAssgin);

            until pRec.Next = 0;
        end;

        //í‹ÝÐ‘’
        pRec.SetRange("Payment Type", pRec."Payment Type"::VA);
        if pRec.FindSet then begin
            repeat

                if pRec."Virtual Account No." <> '' then begin
                    if UpdateUnAssginVirtualAccount(pRec."Virtual Account No.", pRec) then begin
                        //“Èí ˆÃŒŒ‘÷

                    end;

                    ///Žð…Ñœ–«
                    pRec.Status := pRec.Status::UnAssgin;
                    pRec."UnAssgin Date" := Today;
                    pRec.Modify;

                    AddPayExpectDocProcessHistory(pRec."Contract No.",
                                                  pRec."Cemetery Code",
                                                  pRec."Cemetery No.",
                                                  pRec."Document No.",
                                                  '',
                                                  PayExpectProHis.Status::UnAssgin);
                    Commit;
                end;
            until pRec.Next = 0;
        end;
    end;


    procedure CreateFromPublichAdminExpense(var pRec: Record "DK_Publish Admin. Exp. Doc. Li") NewDocNo: Code[20]
    var
        _Contract: Record DK_Contract;
        _NewLineNo: Integer;
        _VirtualAccntNo: Code[20];
    begin
        if not CheckVirtualAccountSetup_PublishAdminExpenseDoc then
            exit('');

        _VirtualAccntNo := FindAvailableVirtualAccnt;

        if _VirtualAccntNo = '' then
            exit('');

        if pRec."Contract No." = '' then exit('');

        PayExpectDocHdr.Init;
        PayExpectDocHdr."Payment Type" := PayExpectDocHdr."Payment Type"::VA;
        PayExpectDocHdr."Document Date" := Today;
        PayExpectDocHdr."Document No." := '';
        PayExpectDocHdr.Validate("Contract No.", pRec."Contract No.");
        PayExpectDocHdr."Source Type" := PayExpectDocHdr."Source Type"::AdminExpense;
        PayExpectDocHdr."Source No." := pRec."Document No.";
        PayExpectDocHdr."Source Line No." := pRec."Line No.";
        PayExpectDocHdr."Expiration Date" := pRec."Payment Due Date";
        PayExpectDocHdr.Validate("Virtual Account No.", _VirtualAccntNo);

        if _Contract.Get(pRec."Contract No.") then begin
            _Contract.CalcFields("Cust. Mobile No.");
            PayExpectDocHdr.Validate("Appl. Name", _Contract."Main Customer Name");
            PayExpectDocHdr.Validate("Appl. Mobile No.", _Contract."Cust. Mobile No.");
        end;

        PayExpectDocHdr."Payment Type" := PayExpectDocHdr."Payment Type"::VA;
        PayExpectDocHdr.Insert(true);

        //Line-----------------------------------------------------------------------
        Clear(_NewLineNo);
        //Ÿ‰¦ýˆ«Š±
        if (pRec."Non-Pay. General Amount" + pRec."General Amount") > 0 then begin
            _NewLineNo += 10000;

            PayExpectDocLine.Init;
            PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
            PayExpectDocLine."Line No." := _NewLineNo;
            PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::General;

            if pRec."Non-Payment From Date 1" = 0D then
                PayExpectDocLine."Start Date" := pRec."Prepayment From Date 1"
            else
                PayExpectDocLine."Start Date" := pRec."Non-Payment From Date 1";

            PayExpectDocLine."Expiration Date" := pRec."Prepayment To Date 1";

            PayExpectDocLine.Amount := (pRec."Non-Pay. General Amount" + pRec."General Amount");

            PayExpectDocLine."Source No." := pRec."Document No.";
            PayExpectDocLine."Source Line No." := pRec."Line No.";
            PayExpectDocLine.Insert;
        end;

        //‘†µýˆ«Š±
        if (pRec."Non-Pay. Land. Arc. Amount" + pRec."Landscape Arc. Amount") > 0 then begin
            _NewLineNo += 10000;

            PayExpectDocLine.Init;
            PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
            PayExpectDocLine."Line No." := _NewLineNo;
            PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::Landscape;

            if pRec."Non-Payment From Date 2" = 0D then
                PayExpectDocLine."Start Date" := pRec."Prepayment From Date 2"
            else
                PayExpectDocLine."Start Date" := pRec."Non-Payment From Date 2";

            PayExpectDocLine."Expiration Date" := pRec."Prepayment To Date 2";

            PayExpectDocLine.Amount := (pRec."Non-Pay. Land. Arc. Amount" + pRec."Landscape Arc. Amount");

            PayExpectDocLine."Source No." := pRec."Document No.";
            PayExpectDocLine."Source Line No." := pRec."Line No.";
            PayExpectDocLine.Insert;
        end;

        //AssginVirtualAccnt
        if PayExpectDocHdr."Payment Type" = PayExpectDocHdr."Payment Type"::VA then
            AssginVirtualAccnt(PayExpectDocHdr);

        //Return Value
        PayExpectDocHdr.CalcFields("Bank Code", "Bank Name", "Account Holder");
        pRec."Account Type" := pRec."Account Type"::VA;
        pRec."Account Code" := PayExpectDocHdr."Virtual Account No.";
        pRec."Bank Code" := PayExpectDocHdr."Bank Code";
        pRec."Bank Name" := PayExpectDocHdr."Bank Name";
        pRec."Bank Account No." := PayExpectDocHdr."Virtual Account No.";
        pRec."Account Holder" := PayExpectDocHdr."Account Holder";
        pRec.Modify;
        exit(PayExpectDocHdr."Document No.");
    end;


    procedure CreateFromCemeteryService(var pRec: Record "DK_Cemetery Services") NewDocNo: Code[20]
    begin
        FunSetup.Get;

        pRec.CalcFields("Pay. Expect Doc. No.");
        if pRec."Pay. Expect Doc. No." <> '' then
            Error('', pRec.FieldCaption("Pay. Expect Doc. No."), pRec."Pay. Expect Doc. No.");

        PayExpectDocHdr.Init;
        PayExpectDocHdr.Validate("Document Date", Today);
        PayExpectDocHdr."Document No." := '';
        PayExpectDocHdr."Payment Type" := PayExpectDocHdr."Payment Type"::PG;
        PayExpectDocHdr.Validate("Contract No.", pRec."Contract No.");
        PayExpectDocHdr."Source Type" := PayExpectDocHdr."Source Type"::Service;
        PayExpectDocHdr."Source No." := pRec."No.";

        PayExpectDocHdr.Validate("Appl. Name", pRec."Appl. Name");
        PayExpectDocHdr.Validate("Appl. Mobile No.", pRec."Appl. Mobile No.");

        PayExpectDocHdr.Insert(true);

        //Line-----------------------------------------------------------------------
        PayExpectDocLine.Init;
        PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
        PayExpectDocLine."Line No." := 10000;
        PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::Service;
        PayExpectDocLine.Validate("Cem. Services No.", pRec."No.");
        PayExpectDocLine.Amount := pRec.Amount;
        PayExpectDocLine."Source No." := pRec."No.";
        PayExpectDocLine.Insert(true);

        exit(PayExpectDocHdr."Document No.");
    end;


    procedure CreateFromContract(pRec: Record DK_Contract) NewDocNo: Code[20]
    begin
        FunSetup.Get;

        if pRec."Rece. Remaining Amount" = 0 then
            Error('', pRec.FieldCaption("Rece. Remaining Amount"));

        PayExpectDocHdr.Init;
        PayExpectDocHdr."Document No." := '';
        PayExpectDocHdr."Payment Type" := PayExpectDocHdr."Payment Type"::PG;
        PayExpectDocHdr.Validate("Document Date", Today);

        PayExpectDocHdr."Expiration Date" := CalcDate(FunSetup."Payment Expect Due Period", Today);

        PayExpectDocHdr."Contract No." := pRec."No.";
        PayExpectDocHdr."Source Type" := PayExpectDocHdr."Source Type"::Contract;
        PayExpectDocHdr."Source No." := pRec."No.";

        pRec.CalcFields("Cust. Mobile No.");
        PayExpectDocHdr.Validate("Appl. Name", pRec."Main Customer Name");
        PayExpectDocHdr.Validate("Appl. Mobile No.", pRec."Cust. Mobile No.");

        PayExpectDocHdr.Insert(true);

        //Line-----------------------------------------------------------------------
        /*
        PayExpectDocLine.INIT;
        PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
        PayExpectDocLine."Line No." := 10000;
        
        CASE pPayTarget OF
          PayExpectDocLine."Payment Target"::Deposit:
            PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::Deposit;
          PayExpectDocLine."Payment Target"::Contract:
            PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::Contract;
          PayExpectDocLine."Payment Target"::Remaining:
            PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::Remaining;
        END;
        
        PayExpectDocLine.Amount := pAmount;
        PayExpectDocLine."Source No." := pRec."No.";
        PayExpectDocLine.INSERT(TRUE);
        */
        exit(PayExpectDocHdr."Document No.");

    end;


    procedure CreateFromContractAdminExpence(pRec: Record DK_Contract) NewDocNo: Code[20]
    begin
        FunSetup.Get;

        PayExpectDocHdr.Init;
        PayExpectDocHdr."Document No." := '';
        PayExpectDocHdr."Payment Type" := PayExpectDocHdr."Payment Type"::PG;
        PayExpectDocHdr.Validate("Document Date", Today);

        PayExpectDocHdr."Expiration Date" := CalcDate(FunSetup."Payment Expect Due Period", Today);

        PayExpectDocHdr."Contract No." := pRec."No.";
        PayExpectDocHdr."Source Type" := PayExpectDocHdr."Source Type"::Contract;
        PayExpectDocHdr."Source No." := pRec."No.";

        pRec.CalcFields("Cust. Mobile No.");
        PayExpectDocHdr.Validate("Appl. Name", pRec."Main Customer Name");
        PayExpectDocHdr.Validate("Appl. Mobile No.", pRec."Cust. Mobile No.");
        PayExpectDocHdr.Insert(true);

        //Line-----------------------------------------------------------------------
        //Ÿ‰¦ýˆ«Š±‡ž €ËŠ‹ ‹²ŒŠ
        pRec.CalcFields("Landscape Architecture");
        if not pRec."Landscape Architecture" then begin
            PayExpectDocLine.Init;
            PayExpectDocLine."Document No." := PayExpectDocHdr."Document No.";
            PayExpectDocLine."Line No." := 10000;
            PayExpectDocLine."Payment Target" := PayExpectDocLine."Payment Target"::General;
            PayExpectDocLine.Insert(true);
        end;

        exit(PayExpectDocHdr."Document No.");
    end;


    procedure UpdateUnAssginVirtualAccount(pVirtualAccountNo: Code[20]; pPayExpectDocHdr: Record "DK_Pay. Expect Doc. Header"): Boolean
    var
        _VirtualAccount: Record "DK_Virtual Account";
        _ExtDBProcess: Codeunit "DK_External DB Process";
    begin

        if _VirtualAccount.Get(pVirtualAccountNo) then begin
            //--------------------------------------------------------
            //í‹ÝÐ‘’DBí —­„Ï Žð…Ñœ–« ‘°—Ê
            // _ExtDBProcess.UnAssginVirtualAccount(pPayExpectDocHdr);////zzz
            //--------------------------------------------------------
            _VirtualAccount."Last UnAssgin Date" := Today;
            _VirtualAccount.Modify;
        end;

        exit(true);
    end;


    procedure SMSSending(var pRec: Record "DK_Pay. Expect Doc. Header")
    var
        _SMS: Record DK_SMS;
        _SMSSending: Codeunit "DK_Batch SMS Sending";
        _SMSMessage: Text;
        _ComInfor: Record "Company Information";
    begin
        FunSetup.Get;
        FunSetup.TestField("SMS Phone No.");

        _ComInfor.Get;

        case pRec."Payment Type" of
            pRec."Payment Type"::PG:
                begin
                    pRec.TestField("PG URL");
                end;
            pRec."Payment Type"::VA:
                begin
                    FunSetup.TestField("Virtual Accnt. DB Con. Code");
                    FunSetup.TestField("Virtual Account ID");
                    FunSetup.TestField("Use Virtual Account");

                    pRec.TestField("Virtual Account No.");

                    if pRec."UnAssgin Date" <> 0D then
                        Error(MSG011, pRec.FieldCaption(pRec."UnAssgin Date"), pRec."UnAssgin Date");

                    if pRec."Expiration Date" < Today then begin
                        pRec."UnAssgin Date" := Today;
                        pRec.Modify;
                        Message(MSG012, pRec.FieldCaption(pRec."Expiration Date"), pRec."Expiration Date");
                    end;
                end;
            else
                Error(MSG013, pRec.FieldCaption("Payment Type"), pRec."Payment Type");
        end;


        if pRec."Last SMS Sent Date" <> 0D then begin
            pRec.TestField("Appl. Mobile No.");
            pRec.TestField("Appl. Name");

            if pRec."Expiration Date" > (pRec."Expiration Date" - 10) then begin
                if not Confirm(MSG016, false, pRec.FieldCaption(pRec."Expiration Date"), pRec."Expiration Date") then
                    exit;
            end else begin
                if not Confirm(MSG017, false, pRec.FieldCaption("Last SMS Sent Date"), pRec."Last SMS Sent Date") then
                    exit;
            end;

        end;

        //SMS Sending
        _SMS.Reset;
        if pRec."Payment Type" = pRec."Payment Type"::PG then
            _SMS.SetRange(Type, _SMS.Type::PaymentExpectPG)
        else
            _SMS.SetRange(Type, _SMS.Type::PaymentExpectVA);
        if _SMS.FindSet then begin

            _SMSMessage := _SMSSending.SetMessageType(_SMS.Type, _SMS."Short Message", pRec."Document No.");

            if not Confirm(_SMSMessage, false) then begin
                Message(MSG005);
                exit;
            end;


            _SMSSending.SingleSendingSMS(FunSetup."SMS Phone No.",
                                        pRec."Appl. Mobile No.",
                                        _ComInfor.Name,
                                        _SMSMessage,
                                        '',
                                        '',
                                        '',
                                        true,
                                        _SMS.Type,
                                        pRec."Document No.",
                                        0,
                                        _SMS."Biz Talk Tamplate No.",
                                        pRec."Contract No.");

            pRec.Status := pRec.Status::SendSMS;
            pRec."Last SMS Sent Date" := Today;
            pRec.Modify(true);

            AddPayExpectDocProcessHistory(pRec."Contract No.",
                                          pRec."Cemetery Code",
                                          pRec."Cemetery No.",
                                          pRec."Document No.",
                                          '',
                                          PayExpectProHis.Status::SendSMS);
        end else begin

            if pRec."Payment Type" = pRec."Payment Type"::PG then
                Error(MSG006, _SMS.TableCaption, _SMS.Type::PaymentExpectPG)
            else
                Error(MSG006, _SMS.TableCaption, _SMS.Type::PaymentExpectVA);

        end;
    end;

    local procedure CheckVirtualAccountSetup()
    var
        _FunSetup: Record "DK_Function Setup";
    begin

        _FunSetup.Get;
        _FunSetup.TestField("Use Virtual Account");
        _FunSetup.TestField("Virtual Account ID");
        _FunSetup.TestField("Virtual Accnt. DB Con. Code");
    end;

    local procedure CheckPGSetup()
    var
        _FunSetup: Record "DK_Function Setup";
    begin

        _FunSetup.Get;
        _FunSetup.TestField("PG URL");
    end;

    local procedure CheckVirtualAccountSetup_PublishAdminExpenseDoc(): Boolean
    var
        _FunSetup: Record "DK_Function Setup";
    begin

        _FunSetup.Get;

        if _FunSetup."Use Virtual Account" = false then
            exit(false);
        if _FunSetup."Virtual Account ID" = '' then
            exit(false);
        if _FunSetup."Virtual Accnt. DB Con. Code" = '' then
            exit(false);

        exit(true);
    end;


    procedure UpdateExpirationDate(pUnitPriceUpdateDate: Date; pUnitPriceType: Code[20]; pPriceType: Option)
    var
        _Cemetery: Record DK_Cemetery;
    begin
        //í¦ Š»µˆ‡ž ß‘ª ‰‘ñ ‰«Œ¡ Žð…Ñœ–«
        PayExpectDocHdr.Reset;
        PayExpectDocHdr.SetCurrentKey("Payment Type", "Expiration Date", "Assgin Date", "UnAssgin Date");
        PayExpectDocHdr.SetRange("Payment Type", PayExpectDocHdr."Payment Type"::PG);
        PayExpectDocHdr.SetFilter("Expiration Date", '>%1', pUnitPriceUpdateDate);
        PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        PayExpectDocHdr.SetRange("Unit Price Type Code", pUnitPriceType);

        if pPriceType = 0 then
            PayExpectDocHdr.SetRange("Payment Target Filter", PayExpectDocHdr."Payment Target Filter"::General)
        else
            PayExpectDocHdr.SetRange("Payment Target Filter", PayExpectDocHdr."Payment Target Filter"::Landscape);

        if PayExpectDocHdr.FindSet then begin
            repeat

                //SMS ˆˆ€ËŸÀ Š»µ Žð…Ñœ–« ý„Ã!!!!!!!
                //í¦Š»µ Žð…Ñœ–«
                PayExpectDocHdr."Befor Expiration Date" := PayExpectDocHdr."Expiration Date";
                PayExpectDocHdr.Validate("Expiration Date", Today);
                PayExpectDocHdr.Modify;

                //-----------------------------------------------------------------------
                //œˆÃŸ ‰ÈŒÁ
                //-----------------------------------------------------------------------

                AddPayExpectDocProcessHistory(PayExpectDocHdr."Contract No.",
                                              PayExpectDocHdr."Cemetery Code",
                                              PayExpectDocHdr."Cemetery No.",
                                              PayExpectDocHdr."Document No.",
                                              '',
                                              PayExpectProHis.Status::ChangeExpirationDate);
            until PayExpectDocHdr.Next = 0;
        end;
    end;


    procedure AddPayExpectDocProcessHistory(PContractNo: Code[20]; pCemeteryCode: Code[20]; pCemeteryNo: Code[20]; pPayExpDocNo: Code[20]; pPayRecDocNo: Code[20]; pStatus: Option)
    var
        _PayExpectProHis: Record "DK_Pay. Expect Process History";
    begin

        _PayExpectProHis.Init;
        _PayExpectProHis."Entry Date" := Today;
        _PayExpectProHis."Entry Time" := Time;
        _PayExpectProHis."Contract No." := PContractNo;
        _PayExpectProHis."Cemetery Code" := pCemeteryCode;
        _PayExpectProHis."Cemetery No." := pCemeteryNo;
        _PayExpectProHis."Pay. Expect Doc. No." := pPayExpDocNo;
        _PayExpectProHis."Pay. Receipt Doc. No." := pPayRecDocNo;
        _PayExpectProHis.Status := pStatus;
        _PayExpectProHis.Insert(true);
    end;


    procedure CreatePayReceiptDoc(var pPayExpectDocHdr: Record "DK_Pay. Expect Doc. Header")
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _NewLineNo: Integer;
        _CalcExpirationDate: Date;
        _PayRecePost: Codeunit "DK_Payment Receipt - Post";
        _GenSetup: Record "General Ledger Setup";
    begin

        //-----------------------------------------------------------------
        //Hdader
        _PayReceiptDoc.Init;
        _PayReceiptDoc."Document No." := '';
        _PayReceiptDoc.Validate("Document Type", _PayReceiptDoc."Document Type"::Receipt);
        _PayReceiptDoc.Validate("Payment Date", pPayExpectDocHdr."Payment Date");
        //_PayReceiptDoc.VALIDATE("Posting Date", _PayReceiptDoc."Payment Date");

        pPayExpectDocHdr.CalcFields("Total Amount");
        _PayReceiptDoc.Validate(Amount, pPayExpectDocHdr."Total Amount");

        _PayReceiptDoc.Validate("Contract No.", pPayExpectDocHdr."Contract No.");
        _PayReceiptDoc."Pay. Expect Doc. No." := pPayExpectDocHdr."Document No.";

        if pPayExpectDocHdr."Payment Type" = pPayExpectDocHdr."Payment Type"::VA then begin
            //Virtual Account
            _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::VirtualAccount);
            _PayReceiptDoc.Validate("Virtual Account No.", pPayExpectDocHdr."Virtual Account No.");
        end else begin
            //Direct PG, PG
            _PayReceiptDoc.Validate("Payment Type", _PayReceiptDoc."Payment Type"::OnlineCard);
            _PayReceiptDoc."Payment Method Code" := pPayExpectDocHdr."Payment Method Code";
            _PayReceiptDoc."Payment Method Name" := pPayExpectDocHdr."Payment Method Name";
            _PayReceiptDoc."Card Approval No." := pPayExpectDocHdr."PG Approval No.";
        end;

        _PayReceiptDoc.Depositor := pPayExpectDocHdr."Appl. Name";
        _PayReceiptDoc."Appl. Mobile No." := pPayExpectDocHdr."Appl. Mobile No.";
        _PayReceiptDoc.Description := MSG007;
        _PayReceiptDoc."Created Auto." := true;
        _PayReceiptDoc.Litigation := false;
        _PayReceiptDoc.Insert(true);

        //-----------------------------------------------------------------
        //Line
        PayExpectDocLine.Reset;
        PayExpectDocLine.SetRange("Document No.", pPayExpectDocHdr."Document No.");
        PayExpectDocLine.SetFilter(Amount, '<>0');
        if PayExpectDocLine.FindSet then begin
            Clear(_NewLineNo);
            repeat
                _NewLineNo += 10000;
                _PayReceiptDocLine.Init;
                _PayReceiptDocLine."Document No." := _PayReceiptDoc."Document No.";
                _PayReceiptDocLine."Line No." := _NewLineNo;
                _PayReceiptDocLine.Validate("Payment Target", PayExpectDocLine."Payment Target");

                case PayExpectDocLine."Payment Target" of
                    PayExpectDocLine."Payment Target"::Deposit,
                    PayExpectDocLine."Payment Target"::Contract,
                    PayExpectDocLine."Payment Target"::Remaining:
                        begin
                            _PayReceiptDocLine.Validate(Amount, PayExpectDocLine.Amount);
                        end;
                    PayExpectDocLine."Payment Target"::General,
                    PayExpectDocLine."Payment Target"::Landscape:
                        begin

                            //Calc. Date
                            //_CalcExpirationDate := CALCDATE(STRSUBSTNO('%1Y', PayExpectDocLine."Add. Years"), _PayReceiptDocLine."Start Date")-1;

                            _PayReceiptDocLine.Validate(Amount, PayExpectDocLine.Amount);
                            //_PayReceiptDocLine.VALIDATE("Expiration Date", _CalcExpirationDate);
                        end;
                    PayExpectDocLine."Payment Target"::Service:
                        begin
                            _PayReceiptDocLine.Validate("Cem. Services No.", PayExpectDocLine."Cem. Services No.");
                            _PayReceiptDocLine.Validate(Amount, PayExpectDocLine.Amount);
                        end;
                end;
                _PayReceiptDocLine.Insert(true);

            until PayExpectDocLine.Next = 0;

            //ß‘ª‰‘ñ‰«Œ¡í Žð…Ñœ–«
            pPayExpectDocHdr.Status := pPayExpectDocHdr.Status::CreatePaymentReceipt;
            pPayExpectDocHdr.Validate("Pay. Receipt Doc. No.", _PayReceiptDoc."Document No.");
            pPayExpectDocHdr.Modify;

            AddPayExpectDocProcessHistory(pPayExpectDocHdr."Contract No.",
                                          pPayExpectDocHdr."Cemetery Code",
                                          pPayExpectDocHdr."Cemetery No.",
                                          pPayExpectDocHdr."Document No.",
                                          _PayReceiptDoc."Document No.",
                                          PayExpectProHis.Status::CreatePayReceiptDoc);

            //ý€ËŸÀ ˜«‘ñ
            if pPayExpectDocHdr."Payment Type" <> pPayExpectDocHdr."Payment Type"::VA then begin
                _GenSetup.Get;
                if (_GenSetup."DK_Allow Posting Time" = 0T) or
                   (_GenSetup."DK_Allow Posting Time" < 0T) then begin
                    _PayReceiptDoc."Posting Date" := Today;
                end else begin
                    _PayReceiptDoc."Posting Date" := Today + 1;
                end;
            end else begin
                //
                _PayReceiptDoc."Posting Date" := 0D;
            end;
            _PayReceiptDoc.Modify;

            //20200302 ’†Ýž”½…Î/í‹ÝÐ‘’ ˆÚ…Î À… ý€Ë—Ÿ‘÷ Žš.!
            //Post(í‹ÝÐ‘’„’ À… ý€Ë—Ÿ‘÷ Žš)
            //IF pPayExpectDocHdr."Payment Type" <> pPayExpectDocHdr."Payment Type"::VA THEN
            //  _PayRecePost.Post(_PayReceiptDoc, FALSE);

        end;
    end;

    local procedure BatchCheckVAExpirationDate(pTODAY: Date)
    begin
        //ˆˆ€ËŸÀ ‘Ž‡ß
        PayExpectDocHdr.Reset;
        PayExpectDocHdr.SetRange("Payment Type", PayExpectDocHdr."Payment Type"::VA);
        PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        PayExpectDocHdr.SetFilter("Expiration Date", '<=%1', pTODAY);
        if PayExpectDocHdr.FindSet then
            PayExpectDocHdr.ModifyAll("UnAssgin Date", pTODAY, true);
    end;


    procedure CheckAdminExpensToPayExpectDoc(pRec: Record "DK_Admin. Expense Price")
    var
        _PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
    begin
        //ýˆ«Š± “Èí“ ß‘ª ‰‘ñ‰«Œ¡ ˜«ž

        _PayExpectDocHdr.Reset;
        _PayExpectDocHdr.SetFilter("Payment Type", '%1|%2', _PayExpectDocHdr."Payment Type"::VA,
                                                            _PayExpectDocHdr."Payment Type"::PG);
        _PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        _PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        _PayExpectDocHdr.SetFilter("Expiration Date", '>=%1', pRec."Starting Date");
        _PayExpectDocHdr.SetRange("Unit Price Type Code", pRec."Unit Price Type Code");
        if pRec."Price Type" = pRec."Price Type"::General then begin
            _PayExpectDocHdr.SetFilter("Line General Amount", '<>%1', 0);
        end else begin
            _PayExpectDocHdr.SetFilter("Line Land. Arc. Amount", '<>%1', 0);
        end;
        if _PayExpectDocHdr.FindSet then
            Error(MSG022, _PayExpectDocHdr.Count);
    end;


    procedure CheckPayExpectDocInAdminExpense()
    var
        _PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
    begin
        //ß‘ª ‰‘ñ ‰«Œ¡ ‘È ýˆ«Š± ˜«ž

        _PayExpectDocHdr.Reset;
        _PayExpectDocHdr.SetFilter("Payment Type", '%1|%2', _PayExpectDocHdr."Payment Type"::VA,
                                                            _PayExpectDocHdr."Payment Type"::PG);
        _PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        _PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        _PayExpectDocHdr.SetFilter("Expiration Date", '>=%1', Today);
        _PayExpectDocHdr.FilterGroup := -1;
        _PayExpectDocHdr.SetFilter("Line General Amount", '<>%1', 0);
        _PayExpectDocHdr.SetFilter("Line Land. Arc. Amount", '<>%1', 0);
        if _PayExpectDocHdr.FindSet then
            Error(MSG022, _PayExpectDocHdr.Count);
    end;


    procedure ShowPaymentExpectDoc(pRec: Record "DK_Admin. Expense Price")
    var
        _PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
        _PayExpectDocList: Page "DK_Pay. Expect Document List";
    begin
        //ýˆ«Š± “Èí“ ß‘ª ‰‘ñ‰«Œ¡ ˜«ž

        _PayExpectDocHdr.Reset;
        _PayExpectDocHdr.SetFilter("Payment Type", '%1|%2', _PayExpectDocHdr."Payment Type"::VA,
                                                            _PayExpectDocHdr."Payment Type"::PG);
        _PayExpectDocHdr.SetFilter("Assgin Date", '<>%1', 0D);
        _PayExpectDocHdr.SetRange("UnAssgin Date", 0D);
        //_PayExpectDocHdr.SETFILTER("Expiration Date",'>=%1', pRec."Starting Date");
        _PayExpectDocHdr.SetFilter("Expiration Date", '>=%1', Today);
        _PayExpectDocHdr.SetRange("Unit Price Type Code", pRec."Unit Price Type Code");
        if pRec."Price Type" = pRec."Price Type"::General then begin
            _PayExpectDocHdr.SetFilter("Line General Amount", '<>%1', 0);
        end else begin
            _PayExpectDocHdr.SetFilter("Line Land. Arc. Amount", '<>%1', 0);
        end;
        if _PayExpectDocHdr.FindSet then begin

            Clear(_PayExpectDocList);
            _PayExpectDocList.LookupMode(true);
            _PayExpectDocList.SetTableView(_PayExpectDocHdr);
            _PayExpectDocList.SetRecord(_PayExpectDocHdr);
            _PayExpectDocList.Run;

        end else begin
            Error(MSG023);
        end;
    end;
}

