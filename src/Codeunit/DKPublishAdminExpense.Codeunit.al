codeunit 50012 "DK_Publish Admin. Expense"
{
    // *DK32 :20200715
    //   - Modify Function : ChangeContract


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'Receipt Bank Information does not exist';
        MSG002: Label '%1 does not exist.';
        MSG003: Label 'The publication target does not exist.';
        MSG004: Label 'Customer information not confirmed.. Unconfirmed : %1';
        _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
        MSG005: Label 'No employee information can be found for the current user. Please contact your administrator.';
        MSG006: Label 'General %1 %2 Month %3 KRW %4, Period : %5';
        MSG007: Label 'Land. %1 %2 Month %3 KRW %4, Period : %5';
        MSG008: Label 'General %1 %2 Month %3 KRW %4, Land. %5 %6 Month %7 KRW %8, Period : %9';
        MSG009: Label 'Please check the Contract. %5: %6';
        MSG010: Label 'A virtual account is assigned. You cannot change the Status of this document to open.';


    procedure ChangeContract(var pPublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li")
    var
        _Contract: Record DK_Contract;
        _Customer: Record DK_Customer;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _FunctionSetup: Record "DK_Function Setup";
        _Cemetery: Record DK_Cemetery;
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _BankAccountCode: Code[20];
        _CustomerNo: Code[20];
    begin
        //_Contract

        _FunctionSetup.Get;
        //_FunctionSetup.TESTFIELD("Management Unit");

        _ReceiptBankAccount.Reset;
        _ReceiptBankAccount.SetRange(Blocked, false);
        _ReceiptBankAccount.SetRange("Admin. Expense", true);
        if _ReceiptBankAccount.FindSet then begin
            _BankAccountCode := _ReceiptBankAccount.Code;
        end else begin
            Error(MSG001, _ReceiptBankAccount.TableCaption);
        end;

        if _Contract.Get(pPublishAdminExpDocLine."Contract No.") then begin

            pPublishAdminExpDocLine.Validate("Supervise No.", _Contract."Supervise No.");
            pPublishAdminExpDocLine.Validate("Cemetery Code", _Contract."Cemetery Code");
            pPublishAdminExpDocLine.Validate("Customer No.", _Contract."Main Customer No.");

            if _Cemetery.Get(_Contract."Cemetery Code") then begin
                pPublishAdminExpDocLine."Estate Code" := _Cemetery."Estate Code";
                pPublishAdminExpDocLine."Estate Name" := _Cemetery."Estate Name";
                pPublishAdminExpDocLine."Unit Price Type Code" := _Cemetery."Unit Price Type Code";
                pPublishAdminExpDocLine."Unit Price Type Name" := _Cemetery."Unit Price Type Name";
            end;

            pPublishAdminExpDocLine."Contact Target" := _Contract."Contact Target";

            if _Contract."Contact Target" = _Contract."Contact Target"::MainAssociate then begin
                _CustomerNo := _Contract."Main Associate No.";

                if _CustomerNo = '' then
                    Error(MSG009, _Contract.TableCaption,
                              _Contract.FieldCaption("Contact Target"),
                              _Contract."Contact Target",
                              _Contract.FieldCaption("Main Associate No."),
                              _Contract.FieldCaption("No."),
                              _Contract."No.");
            end else
                if _Contract."Contact Target" = _Contract."Contact Target"::SubAssociate then begin
                    _CustomerNo := _Contract."Sub Associate No.";

                    if _CustomerNo = '' then
                        Error(MSG009, _Contract.TableCaption,
                                _Contract.FieldCaption("Contact Target"),
                                _Contract."Contact Target",
                                _Contract.FieldCaption("Contact Target"),
                                _Contract.FieldCaption("No."),
                                _Contract."No.");
                end else begin
                    _CustomerNo := _Contract."Main Customer No.";

                    if _CustomerNo = '' then
                        Error(MSG009, _Contract.TableCaption,
                                _Contract.FieldCaption("Contact Target"),
                                _Contract."Contact Target",
                                _Contract.FieldCaption("Main Customer No."),
                                _Contract.FieldCaption("No."),
                                _Contract."No.");
                end;

            if _Customer.Get(_CustomerNo) then begin
                pPublishAdminExpDocLine."Customer Name" := _Customer.Name;
                pPublishAdminExpDocLine.Address := _Customer.Address;
                pPublishAdminExpDocLine."Address 2" := _Customer."Address 2";
                pPublishAdminExpDocLine."Post Code" := _Customer."Post Code";
                pPublishAdminExpDocLine."Phone No." := _Customer."Phone No.";
                pPublishAdminExpDocLine."Mobile No." := _Customer."Mobile No.";
            end;


            if _Contract."General Expiration Date" <> 0D then begin
                pPublishAdminExpDocLine."Prepayment From Date 1" := (_Contract."General Expiration Date" + 1);
                //>>DK32
            end else begin
                _Contract.CalcFields("Admin. Expense Method");
                if (_Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract) and
                   (_Contract."Admin. Exp. Start Date" <> 0D) then begin
                    pPublishAdminExpDocLine."Prepayment From Date 1" := _Contract."Admin. Exp. Start Date";


                end;

            end;
            pPublishAdminExpDocLine.Validate("Prepayment To Date 1", CalcDate(StrSubstNo('<+%1Y>', _Contract."Management Unit"),
                                                                                pPublishAdminExpDocLine."Prepayment From Date 1") - 1);
            //<<DK32

            _Contract.CalcFields("Landscape Architecture");
            if _Contract."Landscape Architecture" then begin

                if _Contract."Land. Arc. Expiration Date" = 0D then
                    pPublishAdminExpDocLine."Non-Payment From Date 2" := _Contract."Contract Date";

                if pPublishAdminExpDocLine."Non-Payment From Date 2" <> 0D then
                    pPublishAdminExpDocLine."Non-Payment To Date 2" := _Contract."Land. Arc. Expiration Date" + 1;

                pPublishAdminExpDocLine.Validate("Non-Payment To Date 2", pPublishAdminExpDocLine."Prepayment From Date 1" - 1);
                pPublishAdminExpDocLine."Prepayment From Date 2" := pPublishAdminExpDocLine."Prepayment From Date 1";
                pPublishAdminExpDocLine.Validate("Prepayment To Date 2", pPublishAdminExpDocLine."Prepayment To Date 1");

            end;

            //>>DK32
            //IF _Contract."General Expiration Date" <= WORKDATE THEN
            //  pPublishAdminExpDocLine."Payment Due Date" := CALCDATE('<+2M+CM>',WORKDATE)
            //ELSE
            //  pPublishAdminExpDocLine."Payment Due Date" := _Contract."General Expiration Date";
            //ýˆ«Š± ‘Ž‡ßŸœ „“Šˆ„¾ œýœ•‚¬ †—„’ ýˆ«Š± ‘Ž‡ßŸœ „“ŸÀ €Ë‘¹ (2‚õ ˜” ˆ‹Ÿ)Šˆ„¾ •½ µÕ ‚‚€ËŸÀ„’ (2‚õ ˜” ˆ‹Ÿ)ˆ‡ž “‚ˆ«
            //WORKDATE := 2020-07-23
            //CALCDATE('<+2M+CM>',WORKDATE) := 2020-09-30
            if ((pPublishAdminExpDocLine."Prepayment From Date 1" - 1) <= WorkDate) or
               ((pPublishAdminExpDocLine."Prepayment From Date 1" - 1) > CalcDate('<+2M+CM>', WorkDate)) then
                pPublishAdminExpDocLine."Payment Due Date" := CalcDate('<+2M+CM>', WorkDate)
            else
                pPublishAdminExpDocLine."Payment Due Date" := pPublishAdminExpDocLine."Prepayment From Date 1" - 1;
            //<<DK32

            //í‹ÝÐ‘’ Šž ˜«ž —šÍ!!!
            pPublishAdminExpDocLine."Account Type" := pPublishAdminExpDocLine."Account Type"::General;
            pPublishAdminExpDocLine.Validate("Account Code", _BankAccountCode);
        end else begin
            pPublishAdminExpDocLine.Validate("Supervise No.", '');
            pPublishAdminExpDocLine.Validate("Cemetery Code", '');
            pPublishAdminExpDocLine.Validate("Customer Name", '');
            pPublishAdminExpDocLine."Estate Code" := '';
            pPublishAdminExpDocLine."Estate Name" := '';
            pPublishAdminExpDocLine."Unit Price Type Code" := '';
            pPublishAdminExpDocLine."Unit Price Type Name" := '';
            pPublishAdminExpDocLine.Address := '';
            pPublishAdminExpDocLine."Address 2" := '';
            pPublishAdminExpDocLine."Post Code" := '';
            pPublishAdminExpDocLine."Phone No." := '';
            pPublishAdminExpDocLine."Mobile No." := '';

            pPublishAdminExpDocLine."Prepayment From Date 1" := 0D;
            pPublishAdminExpDocLine."Prepayment To Date 1" := 0D;
            pPublishAdminExpDocLine."General Amount" := 0;

            pPublishAdminExpDocLine."Non-Payment From Date 2" := 0D;
            pPublishAdminExpDocLine."Non-Payment To Date 2" := 0D;
            pPublishAdminExpDocLine."Prepayment From Date 2" := 0D;
            pPublishAdminExpDocLine."Prepayment To Date 2" := 0D;
            pPublishAdminExpDocLine."Landscape Arc. Amount" := 0;
            pPublishAdminExpDocLine."Landscape Arc. Amount" := 0;

            pPublishAdminExpDocLine."Payment Due Date" := 0D;

            pPublishAdminExpDocLine.Validate("Account Code", '');
        end;
    end;


    procedure CheckReleased(pRec: Record "DK_Publish Admin. Expense Doc."): Boolean
    var
        _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
    begin

        pRec.CalcFields("No. of Line");
        pRec.TestField(Description);

        if pRec."No. of Line" = 0 then
            Error(MSG003);

        exit(true);
    end;


    procedure UpdateGeneralCounsel(pRec: Record "DK_Publish Admin. Expense Doc.")
    var
        _CounselHis: Record "DK_Counsel History";
        _Employee: Record DK_Employee;
        _FromDate1: Date;
        _FromDate2: Date;
        _Month1: Integer;
        _Month2: Integer;
        _RevContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    begin

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if not _Employee.FindSet then
            Error(MSG005);

        _PublishAdminExpDocLine.Reset;
        _PublishAdminExpDocLine.SetRange("Document No.", pRec."Document No.");
        _PublishAdminExpDocLine.SetRange("Check Customer Infor.", true);
        _PublishAdminExpDocLine.SetRange("Print Select", true);
        if _PublishAdminExpDocLine.FindSet then begin
            repeat

                _CounselHis.Init;
                _CounselHis.Date := Today;
                _CounselHis.Type := _CounselHis.Type::General;
                _CounselHis.Validate("Contract No.", _PublishAdminExpDocLine."Contract No.");
                _CounselHis."Employee No." := _Employee."No.";
                _CounselHis."Employee Name" := _Employee.Name;
                _CounselHis."Counsel Level 1" := _CounselHis."Counsel Level 1"::General;
                _CounselHis.Validate("Counsel Level Code 2", '001');


                if (_PublishAdminExpDocLine."General Amount" + _PublishAdminExpDocLine."Non-Pay. General Amount" <> 0) and
                   (_PublishAdminExpDocLine."Landscape Arc. Amount" + _PublishAdminExpDocLine."Non-Pay. Land. Arc. Amount" <> 0) then begin

                    //Œ°Œ¡ ‘ÈÍ
                    if _PublishAdminExpDocLine."Prepayment From Date 1" <> 0D then
                        _FromDate1 := _PublishAdminExpDocLine."Prepayment From Date 1";

                    if _PublishAdminExpDocLine."Non-Payment From Date 1" <> 0D then
                        _FromDate1 := _PublishAdminExpDocLine."Non-Payment From Date 1";

                    if _PublishAdminExpDocLine."Prepayment From Date 2" <> 0D then
                        _FromDate2 := _PublishAdminExpDocLine."Prepayment From Date 2";

                    if _PublishAdminExpDocLine."Non-Payment From Date 2" <> 0D then
                        _FromDate2 := _PublishAdminExpDocLine."Non-Payment From Date 2";

                    Clear(_RevContractMgt);
                    _Month1 := _RevContractMgt.CalcContractPreiodMonth(_FromDate1, _PublishAdminExpDocLine."Prepayment To Date 1");
                    _Month2 := _RevContractMgt.CalcContractPreiodMonth(_FromDate2, _PublishAdminExpDocLine."Prepayment To Date 2");

                    _CounselHis."Counsel Content" := StrSubstNo(MSG008, _FromDate1,
                                                                       _Month1,
                                                                       _PublishAdminExpDocLine."Prepayment To Date 1",
                                                                       _PublishAdminExpDocLine."General Amount" + _PublishAdminExpDocLine."Non-Pay. General Amount",
                                                                       _FromDate2,
                                                                       _Month2,
                                                                       _PublishAdminExpDocLine."Prepayment To Date 2",
                                                                       _PublishAdminExpDocLine."Landscape Arc. Amount" + _PublishAdminExpDocLine."Non-Pay. Land. Arc. Amount",
                                                                       _PublishAdminExpDocLine."Payment Due Date");
                end else begin
                    if _PublishAdminExpDocLine."General Amount" <> 0 then begin

                        if _PublishAdminExpDocLine."Prepayment From Date 1" <> 0D then
                            _FromDate1 := _PublishAdminExpDocLine."Prepayment From Date 1";

                        if _PublishAdminExpDocLine."Non-Payment From Date 1" <> 0D then
                            _FromDate1 := _PublishAdminExpDocLine."Non-Payment From Date 1";

                        Clear(_RevContractMgt);
                        _Month1 := _RevContractMgt.CalcContractPreiodMonth(_FromDate1, _PublishAdminExpDocLine."Prepayment To Date 1");

                        _CounselHis."Counsel Content" := StrSubstNo(MSG006, _FromDate1,
                                                                           _Month1,
                                                                           _PublishAdminExpDocLine."Prepayment To Date 1",
                                                                           _PublishAdminExpDocLine."General Amount" + _PublishAdminExpDocLine."Non-Pay. General Amount",
                                                                           _PublishAdminExpDocLine."Payment Due Date");
                    end else begin

                        if _PublishAdminExpDocLine."Prepayment From Date 2" <> 0D then
                            _FromDate2 := _PublishAdminExpDocLine."Prepayment From Date 2";

                        if _PublishAdminExpDocLine."Non-Payment From Date 2" <> 0D then
                            _FromDate2 := _PublishAdminExpDocLine."Non-Payment From Date 2";

                        Clear(_RevContractMgt);
                        _Month1 := _RevContractMgt.CalcContractPreiodMonth(_FromDate2, _PublishAdminExpDocLine."Prepayment To Date 2");

                        _CounselHis."Counsel Content" := StrSubstNo(MSG007, _FromDate2,
                                                                           _Month2,
                                                                           _PublishAdminExpDocLine."Prepayment To Date 2",
                                                                           _PublishAdminExpDocLine."Landscape Arc. Amount" + _PublishAdminExpDocLine."Non-Pay. Land. Arc. Amount",
                                                                           _PublishAdminExpDocLine."Payment Due Date");
                    end;
                end;

                _CounselHis."Result Process" := _CounselHis."Result Process"::Completed;
                _CounselHis.Insert(true);

            until _PublishAdminExpDocLine.Next = 0;
        end;
    end;


    procedure CheckOpen(pRec: Record "DK_Publish Admin. Expense Doc.")
    var
        _PubAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
    begin

        _PubAdminExpDocLine.Reset;
        _PubAdminExpDocLine.SetRange("Document No.", pRec."Document No.");
        _PubAdminExpDocLine.SetRange("Account Type", _PubAdminExpDocLine."Account Type"::VA);
        if _PubAdminExpDocLine.FindSet then
            Error(MSG010, _PubAdminExpDocLine.Count);
    end;
}

