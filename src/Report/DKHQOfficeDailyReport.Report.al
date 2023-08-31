report 50021 "DK_HQ Office DailyReport"
{
    // //•Ô—³ˆ†”™–“ Š‹Šž ŸŸ Šˆ×
    // *DK11
    //   - Data Source : INTEGER0, Name : ReportType
    //   - 0: ÐŽÊýˆ«, 1: ÐŽÊýˆ«•ÔÐ, 2: ÐŽÊÂ ¯€¦, 3: ŸŸ—÷Î ýˆ«Š± ¯€¦—÷˜, 4: ‰Â¯€¦, 5: Š±—ýˆ«, 6: Î‡š ‰¸ ……€Ã
    //   - 7: ŸŸ ×„Í“‹‹Ï—¸ ‘óŒ÷—÷˜, 8: ×„Í“‹‹Ï—¸ “‚ˆ« •ÔÐ
    // 
    // #2106: 20200814
    //   - Modify function: SetReportRange, InsertBuffer_ContractAmountLedger, InsertBuffer_ContractAmountLedgerRefund
    //   - Add function: CheckHonorFirstAdminExpense, CheckHonorFirstAdminExpenseRefund
    //   - Add Text Constants: FirstAdminExpMSG
    // 
    // #2114: 20200824
    //   - Modify function: SetReportRange
    // 
    // #2171: 20200916
    //   - Modify function: SetReportRange, CheckHonorFirstAdminExpense, CheckHonorFirstAdminExpenseRefund
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKHQOfficeDailyReport.rdl';

    Caption = 'HQ Office DailyReport';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            UseTemporary = true;
            column(ReportType; INTEGER0)
            {
            }
            column(ContractCusName; TEXT0)
            {
            }
            column(ContractCemNo; TEXT28)
            {
            }
            column(ContractArea; DECIMAL2)
            {
            }
            column(ContractNaeYeok; TEXT1)
            {
            }
            column(ContractAmount; DECIMAL3)
            {
            }
            column(ContractDamDangJa; TEXT2)
            {
            }
            column(ContractReceiptAmountType; TEXT20)
            {
            }
            column(ContractAnNaeJa; TEXT3)
            {
            }
            column(ContractStatus; TEXT16)
            {
            }
            column(ContractGooBoon; TEXT4)
            {
            }
            column(ContractGaeYakGunSu; DECIMAL4)
            {
            }
            column(ContractMaeChoolAek; DECIMAL5)
            {
            }
            column(ContractMaeJangBongAnNo; DECIMAL6)
            {
            }
            column(ContractJungMyungNo; DECIMAL7)
            {
            }
            column(ContractHaNeulNo; DECIMAL8)
            {
            }
            column(ContractSaeSuNo; DECIMAL9)
            {
            }
            column(ContractAmountCusName; TEXT5)
            {
            }
            column(ContractAmountCemeteryNo; TEXT29)
            {
            }
            column(ConractAmountService; TEXT30)
            {
            }
            column(ContractAmountArea; DECIMAL10)
            {
            }
            column(ContractAmountCemeteryDigit; TEXT26)
            {
            }
            column(ContractAmountServiceName; TEXT27)
            {
            }
            column(ContractAmountAmount; DECIMAL11)
            {
            }
            column(ContractAmountType; TEXT21)
            {
            }
            column(ContractAmountTarget; TEXT22)
            {
            }
            column(AdminCusNo; TEXT6)
            {
            }
            column(AdminCusName; TEXT7)
            {
            }
            column(AdminArea; DECIMAL12)
            {
            }
            column(AdminProcessDate; TEXT20)
            {
            }
            column(AdminGaeYakDate; DATE0)
            {
            }
            column(AdminGwanLiDate; DATE1)
            {
            }
            column(AdminIpGeumAek; INTEGER2)
            {
            }
            column(AdminIpGeumGooboon; TEXT8)
            {
            }
            column(ContractAmountNaeYong; TEXT9)
            {
            }
            column(ContractAmountPaymentDate; DATE2)
            {
            }
            column(ContractAmountRemarks; TEXT24)
            {
            }
            column(ContractAmountLinePaymentType; TEXT25)
            {
            }
            column(RequestChungGoo; TEXT10)
            {
            }
            column(RequestYongdo; TEXT11)
            {
            }
            column(RequestSooRyang; INTEGER3)
            {
            }
            column(RequestGyuKyuk; TEXT12)
            {
            }
            column(RequestGeumAek; INTEGER4)
            {
            }
            column(FieldworkGooBoon; TEXT13)
            {
            }
            column(FieldworkWorkJo; TEXT29)
            {
            }
            column(FieldworkNaeYonog; TEXT14)
            {
            }
            column(FieldWorkCemNo; TEXT15)
            {
            }
            column(FieldWorkTuIp; DECIMAL13)
            {
            }
            column(CustomerRequestCemNo; TEXT17)
            {
            }
            column(CustomerRequestJupSuJa; TEXT18)
            {
            }
            column(CustomerRequestJupSuNaeYong; "LONG TEXT0")
            {
            }
            column(CustomerRequestDangWolJupSu; INTEGER5)
            {
            }
            column(CustomerRequestDangWolChuhri; INTEGER6)
            {
            }
            column(CustomerRequestYiWolDangwol; INTEGER7)
            {
            }
            column(CustomerRequestJeonWolJeopSu; INTEGER8)
            {
            }
            column(CustomerRequestJeonWolChuhri; INTEGER9)
            {
            }
            column(CustomerRequestYiWolJeonwo; INTEGER10)
            {
            }
            column(CustomerRequestNujeokMi; INTEGER11)
            {
            }
            column(CustomerRequestNuJeokBul; INTEGER12)
            {
            }
            column(gReferenceDate; gReferenceDate)
            {
            }

            trigger OnPreDataItem()
            begin

                Header.Reset;
                Header.SetRange("USER ID", UserId);
                Header.SetRange("OBJECT ID", REPORT::"DK_HQ Office DailyReport");
                if Header.FindSet then
                    Header.DeleteAll;

                SetReportRange(gReferenceDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(gReferenceDate; gReferenceDate)
                {
                    Caption = 'Date';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        var
            _Department: Record DK_Department;
        begin

            gReferenceDate := WorkDate;
        end;
    }

    labels
    {
        TongHapLbl = 'TongHap';
        DamDangLbl = 'DamDang';
        BujangLbl = 'Bujang';
        EsaLbl = 'Esa';
        BusajangLbl = 'BusaJang';
        EsajangLbl = 'ESajang';
        GaeYakLbl = 'GaeYak';
        GaeYakJaLbl = 'Contractor';
        MyoJiNoLbl = 'CemNo';
        AreaLbl = 'Area';
        NaeYukLbl = 'NaeYuk';
        AmountLbl = 'Amount';
        DamDangJalbl = 'DamDangJa';
        AnNaeJaLbl = 'AnNaeJa';
        SogyaeLbl = 'Sogyae';
        TonggaeLbl = 'TongGae';
        GooBunLbl = 'GooBoon';
        GunSooLbl = 'Gunsoo';
        MaeChoolLbl = 'MaeChool';
        BongAnLbl = 'BongAn';
        JungMyungLbl = 'JungMyung';
        HaNeulLbl = 'HaNeul';
        SaeSuLbl = 'SaeSu';
        GaeYakWaeIpGeumLbl = 'IpGeum';
        GaeYakJaSungMyungLbl = 'SungMyung';
        NaeYoekLbl = 'NaeYeok';
        MyeonJeoklbl = 'MeonJeok';
        GeumAekLbl = 'GeumAek';
        IpGeumLbl = 'Payment Amount';
        DangIlLbl = 'DangIl';
        IllIllLbl = 'IllIll';
        CardIpgumLbl = 'CardIpGum';
        YaeWaeLbl = 'YaeWae';
        BiPumLbl = 'BiPum';
        JangRyaeLbl = 'JangRyae';
        IllIllJijjukLbl = 'IllIllJiJuk';
        ChuriLbl = 'JiJuk';
        CountLb = 'Count';
        NameLb = 'Name';
        SizeLb = 'Size';
        TermLb = 'Term';
        ContractDateLb = 'Contract Date';
        EndDateLb = 'EndDate';
        RemarksLb = 'Remarks';
        PaymentTypeLb = 'Payment Type';
        ContentLb = 'Content';
        ClaimItemLb = 'Claim Item';
        UsageLb = 'Usage';
        QuantityLb = 'Quantity';
        SpecificationLb = 'Specification';
        FieldWorkLb = 'Field Work';
        FieldWorkGorupLb = 'Field Work Group';
        FieldWorkContentLb = 'Field Work Content';
        FieldWorkAreaLb = 'Field Work Area';
        FieldWorkPersonLb = 'Field Work Person';
        CustRequestLb = 'Customer Request Recipt';
        CustReqApplicantLb = 'Customer Request Apllicant';
        CusReqContentLb = 'Customer Request Content';
        CustReqStatisticsLb = 'Customer Requst Statistics';
        CurrReceiptLb = 'Current Date Receipt';
        CurrProcessLb = 'Current Date Process';
        PreRecCurrProcessLb = 'Previous Date Receipt Current Date Process';
        PreReceiptLb = 'Previous Date Receipt';
        PreProcessLb = 'Previous Date Process';
        PreRecPreProcessLb = 'Previous Date Receipt Previous Date Process';
        CurrCumulUnprocessLb = 'Current Date Cumulative Unprocess';
        CurrCumulImpossibleLb = 'Current Date Cumulative Impossible';
        CorporationLb = 'Corporation';
        YonginParkLb = 'YonginPark';
        ServiceLb = 'Cemetery on that day display service deposit';
        FieldAdminPayLb = 'The amount of cash and card deposits from visiting customers in the marketing department';
        BankPayLb = 'Deposit of bank account on designated date';
        ReqExpenseLb = 'Integrated Marketing Department displays daily furniture application';
        SectionChiefLb = 'Section Chief';
        CenterManagerLb = 'Center Manager';
        GeneralManagerLb = 'General Manager';
        TeamManagerLb = 'Team Manager';
        CountNameLb = 'Count';
        TypeNameLb = '»—ý';
        PaymentDateLb = '¯€¦ ŸÀ';
        CemeteryDigitLb = 'ºŒ÷';
        PartLeaderLb = '–”–«Î';
        ContractStatusLb = 'ÐŽÊ‹Ý•’';
    }

    var
        gReferenceDate: Date;
        EntryNo: Integer;
        TypeMSG: Label 'Complete';
        CashMSG: Label 'Cash';
        ExceptionAmountMSG: Label '%1 : %2 %3';
        FieldworkContentMSG: Label '%1 (%2) : %3';
        PaymentMethodMSG: Label '%1-%2';
        Sales: Label 'T005';
        PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        FieldWorkHeader: Record "DK_Field Work Header";
        TodayFuneral: Record "DK_Today Funeral";
        RevocationContract: Record "DK_Revocation Contract";
        CardMSG: Label 'Card';
        CompoundMSG: Label 'Compound';
        FirstAdminExpMSG: Label 'First Admin Expense';


    procedure SetReportRange(pDate: Date)
    var
        _Contract: Record DK_Contract;
        _CustomerRequests: Record "DK_Customer Requests";
        _RequestExpensesHeader: Record "DK_Request Expenses Header";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _CurrMonStartDate: Date;
        _CurrMonEndDate: Date;
        _PreMonStartDate: Date;
        _PreMonEndDate: Date;
        _Employee: Record DK_Employee;
        _Cemetery: Record DK_Cemetery;
    begin
        //_ReferenceStartDateTime := CREATEDATETIME(pDate-1,170100T);
        //_ReferenceEndDateTime := CREATEDATETIME(pDate,170000T);
        _CurrMonStartDate := CalcDate('<-CM>', pDate); //„Ïõ“š
        _CurrMonEndDate := CalcDate('<CM>', pDate);    //„Ïõˆ‹
        _PreMonStartDate := CalcDate('<-CM-1M>', pDate);  //ýõ“š
        _PreMonEndDate := CalcDate('<CM-1M>', pDate);    //ýõˆ‹


        Clear(PaymentReceiptDocument);
        PaymentReceiptDocument.SetRange(Posted, true);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Missing Contract", false);
        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        PaymentReceiptDocument.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
        if PaymentReceiptDocument.FindSet then begin
            repeat
                //ÐŽÊýˆ« - ¯€¦—
                PaymentReceiptDocLine.Reset;
                PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Document No.");
                PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', PaymentReceiptDocLine."Payment Target"::Contract, PaymentReceiptDocLine."Payment Target"::Deposit);
                PaymentReceiptDocLine.SetCurrentKey("Document No.", "Payment Target");
                if PaymentReceiptDocLine.FindSet then begin
                    repeat
                        EntryNo += 1;
                        InsertBuffer_Contract;
                    until PaymentReceiptDocLine.Next = 0;
                end;
                //ÐŽÊÂ ¯€¦ - ¯€¦ —
                PaymentReceiptDocLine.SetRange("Payment Target");
                PaymentReceiptDocLine.SetFilter("Payment Target", '<>%1&<>%2&<>%3&<>%4',
                              PaymentReceiptDocLine."Payment Target"::Contract,
                              PaymentReceiptDocLine."Payment Target"::Deposit,
                              PaymentReceiptDocLine."Payment Target"::General,
                              PaymentReceiptDocLine."Payment Target"::Landscape);
                if PaymentReceiptDocLine.FindSet then begin
                    repeat
                        EntryNo += 1;
                        InsertBuffer_ContractAmountLedger;
                    until PaymentReceiptDocLine.Next = 0;
                end;
                // >> #2106
                //ÐŽÊÂ ¯€¦(Ž–‚šŠ•µ) - ¯€¦—
                if CheckHonorFirstAdminExpense(PaymentReceiptDocument) then begin
                    PaymentReceiptDocLine.SetRange("Payment Target");
                    PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', PaymentReceiptDocLine."Payment Target"::General, PaymentReceiptDocLine."Payment Target"::Landscape);
                    if PaymentReceiptDocLine.FindSet then begin
                        EntryNo += 1;
                        InsertBuffer_ContractAmountLedger;
                    end;
                end;
            // <<
            until PaymentReceiptDocument.Next = 0;
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Completion Date", pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                //ÐŽÊýˆ« - ˜»Š­—
                PaymentReceiptDocLine.Reset;
                PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Target Doc. No.");
                PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', PaymentReceiptDocLine."Payment Target"::Contract, PaymentReceiptDocLine."Payment Target"::Deposit);
                PaymentReceiptDocLine.SetCurrentKey("Document No.", "Payment Target");
                if PaymentReceiptDocLine.FindSet then begin
                    repeat
                        EntryNo += 1;
                        InsertBuffer_ContractRefund;
                    until PaymentReceiptDocLine.Next = 0;
                end;
                //ÐŽÊÂ ¯€¦ - ˜»Š­—
                PaymentReceiptDocLine.SetRange("Payment Target");
                PaymentReceiptDocLine.SetFilter("Payment Target", '<>%1&<>%2&<>%3&<>%4',
                              PaymentReceiptDocLine."Payment Target"::Contract,
                              PaymentReceiptDocLine."Payment Target"::Deposit,
                              PaymentReceiptDocLine."Payment Target"::General,
                              PaymentReceiptDocLine."Payment Target"::Landscape);
                if PaymentReceiptDocLine.FindSet then begin
                    repeat
                        EntryNo += 1;
                        InsertBuffer_ContractAmountLedgerRefund;
                    until PaymentReceiptDocLine.Next = 0;
                end;
                // >> #2106
                //ÐŽÊÂ ¯€¦(Ž–‚šŠ•µ) - ˜»Š­—
                if CheckHonorFirstAdminExpenseRefund(PaymentReceiptDocument) then begin
                    PaymentReceiptDocLine.SetRange("Payment Target");
                    PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', PaymentReceiptDocLine."Payment Target"::General, PaymentReceiptDocLine."Payment Target"::Landscape);
                    if PaymentReceiptDocLine.FindSet then begin
                        EntryNo += 1;
                        InsertBuffer_ContractAmountLedgerRefund;
                    end;
                end;
            // <<
            until PaymentReceiptDocument.Next = 0;
        end;


        //ÐŽÊ ýˆ« - —¹ŽÊ ‘÷€Ã Ÿ‡ß—
        Clear(RevocationContract);
        RevocationContract.SetRange("Payment Completion Date", pDate);
        RevocationContract.SetRange(Status, RevocationContract.Status::Complate);
        RevocationContract.SetRange("Giving Up", false);  //–ð€Ë œÎ— ‘ªÂ 20191101 Í“‹
        if RevocationContract.FindSet then begin
            repeat
                EntryNo += 1;
                InsertBuffer_RevocationContract;
            until RevocationContract.Next = 0;
        end;

        EntryNo += 1;
        with _Contract do begin
            Reset;
            SetRange("Contract Date", _CurrMonStartDate, pDate);
            SetRange(Status, Status::FullPayment);
            //>>ÐŽÊýˆ« •ÔÐ
            Header.Reset;
            Header.Init;
            Header."USER ID" := UserId;
            Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
            Header."Entry No." := EntryNo;
            Header.INTEGER0 := 1; //ÐŽÊýˆ« •ÔÐ
            Header.TEXT4 := TypeMSG;
            if _Contract.FindSet then begin
                Header.DECIMAL4 := _Contract.Count;

                _Contract.CalcSums("Cemetery Amount");
                Header.DECIMAL5 := _Contract."Cemetery Amount";
            end;

            SetRange("Estate Report Type");
            SetRange("Estate Report Type", "Estate Report Type"::Other);
            if FindSet then
                Header.DECIMAL6 := _Contract.Count;

            SetRange("Estate Report Type");
            SetRange("Estate Report Type", "Estate Report Type"::Jung);
            if FindSet then
                Header.DECIMAL7 := _Contract.Count;

            SetRange("Estate Report Type");
            SetRange("Estate Report Type", "Estate Report Type"::Sky);
            if FindSet then
                Header.DECIMAL8 := _Contract.Count;

            SetRange("Estate Report Type");
            SetRange("Estate Report Type", "Estate Report Type"::Three);
            if FindSet then
                Header.DECIMAL9 := _Contract.Count;
            Header.Insert;
            //<<ÐŽÊýˆ« •ÔÐ
        end;


        //ŸŸ—÷Î ýˆ«Š± ¯€¦
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Card,
                                                       PaymentReceiptDocument."Payment Type"::Cash);
        PaymentReceiptDocument.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract", "Payment Type");
        if PaymentReceiptDocument.FindSet then begin
            repeat
                // >> #2106
                /*
                IF STRPOS(PaymentReceiptDocument."Supervise No.",'H') = 0 THEN BEGIN
                  PaymentReceiptDocLine.RESET;
                  PaymentReceiptDocLine.SETRANGE("Document No.",PaymentReceiptDocument."Document No.");
                  PaymentReceiptDocLine.SETRANGE("Payment Target",PaymentReceiptDocLine."Payment Target"::General,
                                                                  PaymentReceiptDocLine."Payment Target"::Landscape);
                  PaymentReceiptDocLine.SETCURRENTKEY("Document No.","Payment Target");
                  IF PaymentReceiptDocLine.FINDSET THEN BEGIN
                    REPEAT
                      EntryNo+=1;
                      InsertBuffer_DaliyFieldAdimAmount;
                    UNTIL PaymentReceiptDocLine.NEXT = 0;
                  END;
                END;
                */
                // <<

                // >> #2451
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                 (StrPos(PaymentReceiptDocument."Supervise No.", 'H') <> 1) then begin
                    PaymentReceiptDocLine.Reset;
                    PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Document No.");
                    PaymentReceiptDocLine.SetRange("Payment Target", PaymentReceiptDocLine."Payment Target"::General,
                                                                    PaymentReceiptDocLine."Payment Target"::Landscape);
                    PaymentReceiptDocLine.SetCurrentKey("Document No.", "Payment Target");
                    if PaymentReceiptDocLine.FindSet then begin
                        repeat
                            EntryNo += 1;
                            InsertBuffer_DaliyFieldAdimAmount;
                        until PaymentReceiptDocLine.Next = 0;
                    end;
                end;
            // <<
            until PaymentReceiptDocument.Next = 0;
        end;

        //ŸŸ—÷Î ýˆ«Š± ¯€¦ - ˜»Š­—
        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date", pDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                /*
                // >> #2106
                IF NOT CheckHonorFirstAdminExpenseRefund(PaymentReceiptDocument) THEN BEGIN
                  PaymentReceiptDocLine.RESET;
                  PaymentReceiptDocLine.SETRANGE("Document No.",PaymentReceiptDocument."Target Doc. No.");
                  PaymentReceiptDocLine.SETRANGE("Payment Target",PaymentReceiptDocLine."Payment Target"::General,
                                                                  PaymentReceiptDocLine."Payment Target"::Landscape);
                  PaymentReceiptDocLine.SETCURRENTKEY("Document No.","Payment Target");
                  IF PaymentReceiptDocLine.FINDSET THEN BEGIN
                    REPEAT
                      EntryNo+=1;
                      InsertBuffer_DaliyFieldAdimAmountRefund;
                    UNTIL PaymentReceiptDocLine.NEXT = 0;
                  END;
                END;
                // <<
                */

                // >> #2451
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                (StrPos(PaymentReceiptDocument."Supervise No.", 'H') <> 1) then begin
                    // H‡ž ‰«Œ¡‰°˜úí “Á—Ÿ‘÷ ŽšˆˆÒ “Ë‡’
                    PaymentReceiptDocLine.Reset;
                    PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Target Doc. No.");
                    PaymentReceiptDocLine.SetRange("Payment Target", PaymentReceiptDocLine."Payment Target"::General,
                                                                    PaymentReceiptDocLine."Payment Target"::Landscape);
                    PaymentReceiptDocLine.SetCurrentKey("Document No.", "Payment Target");
                    if PaymentReceiptDocLine.FindSet then begin
                        repeat
                            EntryNo += 1;
                            InsertBuffer_DaliyFieldAdimAmountRefund;
                        until PaymentReceiptDocLine.Next = 0;
                    end;
                end;
            // <<
            until PaymentReceiptDocument.Next = 0;
        end;



        //‰Â¯€¦ - ‰²ž •ÔÎˆˆ
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Bank);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                PaymentReceiptDocLine.Reset;
                PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Document No.");
                PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2|%3', PaymentReceiptDocLine."Payment Target"::Contract,
                                                                       PaymentReceiptDocLine."Payment Target"::Remaining,
                                                                       PaymentReceiptDocLine."Payment Target"::Service);
                if PaymentReceiptDocLine.FindSet then begin
                    repeat
                        EntryNo += 1;
                        InsertBuffer_ExceptionAmount;
                    until PaymentReceiptDocLine.Next = 0;
                end;

                //>> #2114
                if CheckHonorFirstAdminExpense(PaymentReceiptDocument) then begin
                    PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', PaymentReceiptDocLine."Payment Target"::General,
                                                                            PaymentReceiptDocLine."Payment Target"::Landscape);
                    if PaymentReceiptDocLine.FindSet then begin
                        repeat
                            EntryNo += 1;
                            InsertBuffer_ExceptionAmount;
                        until PaymentReceiptDocLine.Next = 0;
                    end;
                end;
            //<<
            until PaymentReceiptDocument.Next = 0;
        end;

        //Š±—ýˆ«
        _RequestExpensesHeader.Reset;
        _RequestExpensesHeader.SetRange("Posting Date", pDate);
        _RequestExpensesHeader.SetFilter(Status, '%1|%2', _RequestExpensesHeader.Status::Post, _RequestExpensesHeader.Status::Completed);
        _RequestExpensesHeader.SetFilter("Department Code", '%1|%2', 'T005', 'T006'); //…Žðýˆ«, ×„ŒŽ•
        _RequestExpensesHeader.SetCurrentKey("Posting Date", Status);
        if _RequestExpensesHeader.FindSet then begin
            repeat
                InsertBuffer_RequestExpense(_RequestExpensesHeader);
            until _RequestExpensesHeader.Next = 0;
        end;


        //Î‡š ‰¸ ……€Ã
        TodayFuneral.Reset;
        TodayFuneral.SetRange(Date, pDate);
        TodayFuneral.SetFilter(Status, '%1|%2', TodayFuneral.Status::Post, TodayFuneral.Status::Complete);
        if TodayFuneral.FindSet then begin
            repeat
                EntryNo += 1;
                InsertBuffer_TodayFuneral;
            until TodayFuneral.Next = 0;
        end;

        //ŸŸ ×„Í“‹‹Ï—¸ ‘óŒ÷—÷˜
        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Receipt Date", pDate);
        _CustomerRequests.SetFilter(Status, '<>%1', _CustomerRequests.Status::Open);
        _CustomerRequests.SetCurrentKey("Receipt Date", Status);
        if _CustomerRequests.FindSet then begin
            repeat
                EntryNo += 1;
                InsertBuffer_CustomerRequest(_CustomerRequests);
            until _CustomerRequests.Next = 0;
        end;

        //>>×„Í“‹‹Ï—¸ “‚ˆ« •ÔÐ

        EntryNo += 1;
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 8; // ×„Í“‹‹Ï—¸ “‚ˆ« •ÔÐ

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Receipt Date", _CurrMonStartDate, _CurrMonEndDate);
        _CustomerRequests.SetFilter(Status, '%1|%2', _CustomerRequests.Status::Release, _CustomerRequests.Status::Post);
        _CustomerRequests.SetCurrentKey("Receipt Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER5 := _CustomerRequests.Count;

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Process Date", _CurrMonStartDate, _CurrMonEndDate);
        _CustomerRequests.SetRange(Status, _CustomerRequests.Status::Complete);
        _CustomerRequests.SetCurrentKey("Process Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER6 := _CustomerRequests.Count;

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Receipt Date", _PreMonStartDate, _PreMonEndDate);
        _CustomerRequests.SetRange("Process Date", _CurrMonStartDate, _CurrMonEndDate);
        _CustomerRequests.SetRange(Status, _CustomerRequests.Status::Complete);
        _CustomerRequests.SetCurrentKey("Receipt Date", "Process Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER7 := _CustomerRequests.Count;

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Receipt Date", _PreMonStartDate, _PreMonEndDate);
        _CustomerRequests.SetFilter(Status, '%1|%2', _CustomerRequests.Status::Release, _CustomerRequests.Status::Post);
        _CustomerRequests.SetCurrentKey("Receipt Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER8 := _CustomerRequests.Count;

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Process Date", _PreMonStartDate, _PreMonEndDate);
        _CustomerRequests.SetRange(Status, _CustomerRequests.Status::Complete);
        _CustomerRequests.SetCurrentKey("Process Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER9 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Receipt Date", _PreMonStartDate, _PreMonEndDate);
        _CustomerRequests.SetCurrentKey("Receipt Date", "Process Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER10 := _CustomerRequests.Count;

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Receipt Date", 0D, _CurrMonEndDate);
        _CustomerRequests.SetFilter(Status, '%1|%2', _CustomerRequests.Status::Release, _CustomerRequests.Status::Post);
        _CustomerRequests.SetCurrentKey("Receipt Date", Status);
        if _CustomerRequests.FindSet then
            Header.INTEGER11 := _CustomerRequests.Count;

        _CustomerRequests.SetFilter(Status, '%1', _CustomerRequests.Status::Impossible);
        if _CustomerRequests.FindSet then
            Header.INTEGER12 := _CustomerRequests.Count;

        Header.Insert;
        //<<×„Í“‹‹Ï—¸ “‚ˆ« •ÔÐ

    end;


    procedure InsertBuffer_ContractRefund()
    var
        _Contract: Record DK_Contract;
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _CRMSalesType: Record "DK_CRM Sales Type";
        _Employee: Record DK_Employee;
    begin
        //ÐŽÊýˆ«
        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size", "Cemetery Dig. Name", "CRM SalesPerson");
            Header.Reset;
            Header.Init;
            Header."USER ID" := UserId;
            Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
            Header."Entry No." := EntryNo;
            Header.INTEGER0 := 0; //ÐŽÊýˆ«
            Header.TEXT0 := _Contract."Main Customer Name";
            Header.TEXT28 := _Contract."Cemetery No.";
            Header.DECIMAL2 := _Contract."Cemetery Size";
            Header.TEXT1 := _Contract."Cemetery Dig. Name";
            Header.DECIMAL3 := -(PaymentReceiptDocLine.Amount);
            Header.TEXT2 := _Contract."CRM SalesPerson";
            Header.TEXT16 := Format(_Contract.Status);

            _CRMSalesType.Reset;
            _CRMSalesType.SetRange(Seq, _Contract."CRM Sales Type Seq");
            if _CRMSalesType.FindSet then
                Header.TEXT3 := _CRMSalesType.Indicator;

            with PaymentReceiptDocument do begin
                case "Payment Type" of
                    "Payment Type"::Bank:
                        begin
                            _ReceiptBankAccount.Reset;
                            _ReceiptBankAccount.SetRange(Code, "Bank Account Code");
                            if _ReceiptBankAccount.FindSet then
                                Header.TEXT20 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), _ReceiptBankAccount."Bank Name");
                        end;
                    "Payment Type"::Card,
                    "Payment Type"::Giro,
                    "Payment Type"::OnlineCard:
                        begin
                            Header.TEXT20 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), "Payment Method Name");
                        end;
                    "Payment Type"::Cash,
                    "Payment Type"::VirtualAccount:
                        begin
                            Header.TEXT20 := Format("Payment Type");
                        end;
                end;
            end;
            Header.Insert;
        end;
    end;


    procedure InsertBuffer_Contract()
    var
        _Contract: Record DK_Contract;
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _CRMSalesType: Record "DK_CRM Sales Type";
        _Employee: Record DK_Employee;
    begin
        //ÐŽÊýˆ«
        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size", "Cemetery Dig. Name", "CRM SalesPerson");
            Header.Reset;
            Header.Init;
            Header."USER ID" := UserId;
            Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
            Header."Entry No." := EntryNo;
            Header.INTEGER0 := 0; //ÐŽÊýˆ«
            Header.TEXT0 := _Contract."Main Customer Name";
            Header.TEXT28 := _Contract."Cemetery No.";
            Header.DECIMAL2 := _Contract."Cemetery Size";
            Header.TEXT1 := _Contract."Cemetery Dig. Name";
            Header.DECIMAL3 := PaymentReceiptDocLine.Amount;
            Header.TEXT2 := _Contract."CRM SalesPerson";
            Header.TEXT16 := Format(_Contract.Status);

            _CRMSalesType.Reset;
            _CRMSalesType.SetRange(Seq, _Contract."CRM Sales Type Seq");
            if _CRMSalesType.FindSet then
                Header.TEXT3 := _CRMSalesType.Indicator;

            with PaymentReceiptDocument do begin
                case "Payment Type" of
                    "Payment Type"::Bank:
                        begin
                            _ReceiptBankAccount.Reset;
                            _ReceiptBankAccount.SetRange(Code, "Bank Account Code");
                            if _ReceiptBankAccount.FindSet then
                                Header.TEXT20 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), _ReceiptBankAccount."Bank Name");
                        end;
                    "Payment Type"::Card,
                    "Payment Type"::Giro,
                    "Payment Type"::OnlineCard:
                        begin
                            Header.TEXT20 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), "Payment Method Name");
                        end;
                    "Payment Type"::Cash,
                    "Payment Type"::VirtualAccount:
                        begin
                            Header.TEXT20 := Format("Payment Type");
                        end;
                end;
            end;
            Header.Insert;
        end;
    end;


    procedure InsertBuffer_ContractAmountLedgerRefund()
    var
        _Contract: Record DK_Contract;
        _CemeteryServices: Record "DK_Cemetery Services";
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
    begin
        //ÐŽÊÂ¯€¦ - ÐŽÊ€¦ ‘ªÂ—© ˆÚ…Ï ¯€¦ - ˜»Š­
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 2; // ÐŽÊÂ ¯€¦
        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size", "Cemetery Dig. Name");
            Header.TEXT5 := _Contract."Main Customer Name";
            Header.TEXT29 := _Contract."Cemetery No.";
            Header.DECIMAL10 := _Contract."Cemetery Size";
            Header.TEXT26 := _Contract."Cemetery Dig. Name";
            Header.TEXT16 := Format(_Contract.Status);
        end;

        Header.TEXT30 := PaymentReceiptDocLine.Remark;
        Header.DECIMAL11 := -(PaymentReceiptDocLine.Amount);
        with PaymentReceiptDocument do begin
            case "Payment Type" of
                "Payment Type"::Bank:
                    begin
                        _ReceiptBankAccount.Reset;
                        _ReceiptBankAccount.SetRange(Code, "Bank Account Code");
                        if _ReceiptBankAccount.FindSet then
                            Header.TEXT21 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), _ReceiptBankAccount."Bank Name");
                    end;
                "Payment Type"::Card,
                "Payment Type"::Giro,
                "Payment Type"::OnlineCard:
                    begin
                        Header.TEXT21 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), "Payment Method Name");
                    end;
                "Payment Type"::Cash,
                "Payment Type"::VirtualAccount:
                    begin
                        Header.TEXT21 := Format("Payment Type");
                    end;
            end;
        end;

        Header.TEXT22 := Format(PaymentReceiptDocLine."Payment Target");

        // >> #2106
        with PaymentReceiptDocLine do begin
            case "Payment Target" of
                "Payment Target"::Service:
                    begin
                        _CemeteryServices.Reset;
                        _CemeteryServices.SetRange("No.", PaymentReceiptDocLine."Cem. Services No.");
                        if _CemeteryServices.FindSet then
                            Header.TEXT27 := _CemeteryServices."Field Work Sub Cat. Name";
                    end;
                "Payment Target"::General, "Payment Target"::Landscape:
                    begin
                        Header.TEXT27 := FirstAdminExpMSG;
                    end;
                else
                    Header.TEXT27 := '';
            end;
        end;
        /*
        IF PaymentReceiptDocLine."Payment Target" = PaymentReceiptDocLine."Payment Target"::Service THEN BEGIN
          _CemeteryServices.RESET;
          _CemeteryServices.SETRANGE("No.",PaymentReceiptDocLine."Cem. Services No.");
          IF _CemeteryServices.FINDSET THEN
            Header.TEXT27 := _CemeteryServices."Field Work Sub Cat. Name";
        END;
        */
        // <<

        Header.Insert;

    end;


    procedure InsertBuffer_ContractAmountLedger()
    var
        _Contract: Record DK_Contract;
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _CemeteryServices: Record "DK_Cemetery Services";
    begin
        //ÐŽÊÂ¯€¦ - ÐŽÊ€¦ ‘ªÂ—© ˆÚ…Ï ¯€¦ - ¯€¦
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 2; // ÐŽÊÂ ¯€¦
        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size", "Cemetery Dig. Name");
            Header.TEXT5 := _Contract."Main Customer Name";
            Header.TEXT29 := _Contract."Cemetery No.";
            Header.DECIMAL10 := _Contract."Cemetery Size";
            Header.TEXT26 := _Contract."Cemetery Dig. Name";
            Header.TEXT16 := Format(_Contract.Status);
        end;

        Header.TEXT30 := PaymentReceiptDocLine.Remark;
        Header.DECIMAL11 := PaymentReceiptDocLine.Amount;
        with PaymentReceiptDocument do begin
            case "Payment Type" of
                "Payment Type"::Bank:
                    begin
                        _ReceiptBankAccount.Reset;
                        _ReceiptBankAccount.SetRange(Code, "Bank Account Code");
                        if _ReceiptBankAccount.FindSet then
                            Header.TEXT21 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), _ReceiptBankAccount."Bank Name");
                    end;
                "Payment Type"::Card,
                "Payment Type"::Giro,
                "Payment Type"::OnlineCard:
                    begin
                        Header.TEXT21 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), "Payment Method Name");
                    end;
                "Payment Type"::Cash,
                "Payment Type"::VirtualAccount:
                    begin
                        Header.TEXT21 := Format("Payment Type");
                    end;
            end;
        end;

        Header.TEXT22 := Format(PaymentReceiptDocLine."Payment Target");


        // >> #2106
        with PaymentReceiptDocLine do begin
            case "Payment Target" of
                "Payment Target"::Service:
                    begin
                        _CemeteryServices.Reset;
                        _CemeteryServices.SetRange("No.", PaymentReceiptDocLine."Cem. Services No.");
                        if _CemeteryServices.FindSet then
                            Header.TEXT27 := _CemeteryServices."Field Work Sub Cat. Name";
                    end;
                "Payment Target"::General, "Payment Target"::Landscape:
                    begin
                        Header.TEXT27 := FirstAdminExpMSG;
                    end;
                else
                    Header.TEXT27 := '';
            end;
        end;
        /*
        IF PaymentReceiptDocLine."Payment Target" = PaymentReceiptDocLine."Payment Target"::Service THEN BEGIN
          _CemeteryServices.RESET;
          _CemeteryServices.SETRANGE("No.",PaymentReceiptDocLine."Cem. Services No.");
          IF _CemeteryServices.FINDSET THEN
            Header.TEXT27 := _CemeteryServices."Field Work Sub Cat. Name";
        END;
        */
        // <<

        Header.Insert;

    end;


    procedure InsertBuffer_DaliyFieldAdimAmount()
    var
        _Contract: Record DK_Contract;
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //ŸŸ—÷Î ýˆ«Š± ¯€¦ —÷˜
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 3; // ŸŸ—÷Î ýˆ«Š± ¯€¦

        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size");
            Header.TEXT6 := _Contract."Cemetery No.";
            Header.TEXT7 := _Contract."Main Customer Name";
            Header.DECIMAL12 := _Contract."Cemetery Size";
            Header.DATE0 := _Contract."Contract Date";
        end;

        Header.TEXT20 := _RevocationContractMgt.CalcContractPreiod(PaymentReceiptDocLine."Start Date", PaymentReceiptDocLine."Expiration Date");
        Header.DATE1 := PaymentReceiptDocLine."Expiration Date";
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* //‰²Š±Ô + ‘÷¼œÀ + Œ€‚‚€¦
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        PaymentReceiptDocument.CALCFIELDS("Line General Amount","Line Land. Arc. Amount","Line Admin. Expense");
        IF (PaymentReceiptDocument."Line General Amount" <> 0) AND (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) THEN BEGIN
          _AllExtraAmount := (PaymentReceiptDocument."Legal Amount"+
                    PaymentReceiptDocument."Advance Payment Amount"+
                    PaymentReceiptDocument."Delay Interest Amount")/2;
          _LineGeneralAmount += PaymentReceiptDocument."Line General Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
          _LineLandAmount += PaymentReceiptDocument."Line Land. Arc. Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
        END;
        
        IF (PaymentReceiptDocument."Line General Amount" <> 0) AND (PaymentReceiptDocument."Line Land. Arc. Amount" = 0) THEN BEGIN
          _GeneralExtraAmount := PaymentReceiptDocument."Legal Amount"+
                    PaymentReceiptDocument."Advance Payment Amount"+
                    PaymentReceiptDocument."Delay Interest Amount";
          _LineGeneralAmount += PaymentReceiptDocument."Line General Amount" + _GeneralExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
        END;
        
        IF (PaymentReceiptDocument."Line General Amount" = 0) AND (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) THEN BEGIN
          _LandExtraAmount := PaymentReceiptDocument."Legal Amount"+
                    PaymentReceiptDocument."Advance Payment Amount"+
                    PaymentReceiptDocument."Delay Interest Amount";
          _LineLandAmount += PaymentReceiptDocument."Line Land. Arc. Amount" + _LandExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
        END;
        */

        if PaymentReceiptDocLine."Payment Target" = PaymentReceiptDocLine."Payment Target"::General then
            Header.INTEGER2 := PaymentReceiptDocument."Line General Amount" - PaymentReceiptDocument."Reduction Amount 1" // ¿ˆÒŽ¸ˆˆ ‘ªÂ
        else
            Header.INTEGER2 := PaymentReceiptDocument."Line Land. Arc. Amount" - PaymentReceiptDocument."Reduction Amount 2"; // ¿ˆÒŽ¸ˆˆ ‘ªÂ

        if PaymentReceiptDocument."Payment Type" = PaymentReceiptDocument."Payment Type"::Card then begin
            Header.TEXT8 := StrSubstNo(PaymentMethodMSG, Format(PaymentReceiptDocument."Payment Type"::Card), PaymentReceiptDocument."Payment Method Name");
        end else begin
            Header.TEXT8 := Format(PaymentReceiptDocument."Payment Type"::Cash);
        end;
        Header.Insert;

    end;


    procedure InsertBuffer_DaliyFieldAdimAmountRefund()
    var
        _Contract: Record DK_Contract;
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //ŸŸ—÷Î ýˆ«Š± ¯€¦ —÷˜ - ˜»Š­—
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 3; // ŸŸ—÷Î ýˆ«Š± ¯€¦

        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size");
            Header.TEXT6 := _Contract."Cemetery No.";
            Header.TEXT7 := _Contract."Main Customer Name";
            Header.DECIMAL12 := _Contract."Cemetery Size";
            Header.DATE0 := _Contract."Contract Date";
        end;

        Header.TEXT20 := _RevocationContractMgt.CalcContractPreiod(PaymentReceiptDocLine."Start Date", PaymentReceiptDocLine."Expiration Date");
        Header.DATE1 := PaymentReceiptDocLine."Expiration Date";
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* //‰²Š±Ô + ‘÷¼œÀ + Œ€‚‚€¦
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        PaymentReceiptDocument.CALCFIELDS("Line General Amount","Line Land. Arc. Amount","Line Admin. Expense");
        IF (PaymentReceiptDocument."Line General Amount" <> 0) AND (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) THEN BEGIN
          _AllExtraAmount := (PaymentReceiptDocument."Legal Amount"+
                    PaymentReceiptDocument."Advance Payment Amount"+
                    PaymentReceiptDocument."Delay Interest Amount")/2;
          _LineGeneralAmount += PaymentReceiptDocument."Line General Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
          _LineLandAmount += PaymentReceiptDocument."Line Land. Arc. Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
        END;
        
        IF (PaymentReceiptDocument."Line General Amount" <> 0) AND (PaymentReceiptDocument."Line Land. Arc. Amount" = 0) THEN BEGIN
          _GeneralExtraAmount := PaymentReceiptDocument."Legal Amount"+
                    PaymentReceiptDocument."Advance Payment Amount"+
                    PaymentReceiptDocument."Delay Interest Amount";
          _LineGeneralAmount += PaymentReceiptDocument."Line General Amount" + _GeneralExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
        END;
        
        IF (PaymentReceiptDocument."Line General Amount" = 0) AND (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) THEN BEGIN
          _LandExtraAmount := PaymentReceiptDocument."Legal Amount"+
                    PaymentReceiptDocument."Advance Payment Amount"+
                    PaymentReceiptDocument."Delay Interest Amount";
          _LineLandAmount += PaymentReceiptDocument."Line Land. Arc. Amount" + _LandExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
        END;
        */

        if PaymentReceiptDocLine."Payment Target" = PaymentReceiptDocLine."Payment Target"::General then
            Header.INTEGER2 := -(PaymentReceiptDocLine.Amount - PaymentReceiptDocument."Reduction Amount 1") // ¿ˆÒŽ¸ˆˆ ‘ªÂ
        else
            Header.INTEGER2 := -(PaymentReceiptDocLine.Amount - PaymentReceiptDocument."Reduction Amount 2"); // ¿ˆÒŽ¸ˆˆ ‘ªÂ

        if PaymentReceiptDocument."Payment Type" = PaymentReceiptDocument."Payment Type"::Card then begin
            Header.TEXT8 := StrSubstNo(PaymentMethodMSG, Format(PaymentReceiptDocument."Payment Type"::Card), PaymentReceiptDocument."Payment Method Name");
        end else begin
            Header.TEXT8 := Format(PaymentReceiptDocument."Payment Type"::Cash);
        end;
        Header.Insert;

    end;


    procedure InsertBuffer_ExceptionAmount()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    begin
        //‰Â¯€¦(‰²ž•ÔÎ) - •ÔÎ¯€¦…˜ — ýŠž
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 4; // ‰Â ¯€¦
        _Contract.Reset;
        _Contract.SetRange("No.", PaymentReceiptDocument."Contract No.");
        if _Contract.FindSet then begin
            Header.TEXT9 := StrSubstNo(ExceptionAmountMSG, _Contract."Cemetery No.", PaymentReceiptDocLine.Amount);
        end;
        Header.DATE2 := PaymentReceiptDocument."Payment Date";
        Header.TEXT24 := PaymentReceiptDocument.Description;
        Header.TEXT25 := Format(PaymentReceiptDocLine."Payment Target");
        Header.Insert;
    end;


    procedure InsertBuffer_RequestExpense(pRequestExpensesHeader: Record "DK_Request Expenses Header")
    var
        _RequestExpensesLine: Record "DK_Request Expenses Line";
    begin
        //Š±—ýˆ«
        _RequestExpensesLine.Reset;
        _RequestExpensesLine.SetRange("Document No.", pRequestExpensesHeader."No.");
        if _RequestExpensesLine.FindSet then begin
            repeat
                EntryNo += 1;

                Header.Reset;
                Header.Init;
                Header."USER ID" := UserId;
                Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
                Header."Entry No." := EntryNo;
                Header.INTEGER0 := 5; // Š±—ýˆ«
                Header.TEXT10 := _RequestExpensesLine."Purchased Item";
                Header.TEXT11 := pRequestExpensesHeader.Remarks;
                Header.INTEGER3 := _RequestExpensesLine.Quantity;
                Header.TEXT12 := _RequestExpensesLine.StandardSize;
                Header.INTEGER4 := _RequestExpensesLine.Amount;
                Header.Insert;
            until _RequestExpensesLine.Next = 0;
        end;
    end;


    procedure InsertBuffer_TodayFuneral()
    var
        _Cemetery: Record DK_Cemetery;
        _TodayFuneral: Record "DK_Today Funeral";
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        //Î‡š ‰¸ ……€Ã
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 6; // Î‡š ‰¸ ……€Ã
        Header.TEXT13 := TodayFuneral."Field Work Main Cat. Name";

        Header.TEXT29 := TodayFuneral."Working Group Name";

        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery Code", TodayFuneral."Cemetery Code");
        if _Cemetery.FindSet then begin
            Header.TEXT14 := StrSubstNo(ExceptionAmountMSG, _Cemetery."Cemetery No.", _Cemetery.Size);
            Header.TEXT15 := _Cemetery."Cemetery No.";
        end;

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Source Type", _FieldWorkHeader."Source Type"::Today);
        _FieldWorkHeader.SetRange("Source No.", TodayFuneral."No.");
        if _FieldWorkHeader.FindSet then begin
            _FieldWorkLineItem.Reset;
            _FieldWorkLineItem.SetRange("Document No.", _FieldWorkHeader."No.");
            _FieldWorkLineItem.SetRange(Type, _FieldWorkLineItem.Type::WorkGroup);
            if _FieldWorkLineItem.FindSet then begin
                _FieldWorkLineItem.CalcSums(Quantity);
                Header.DECIMAL13 := _FieldWorkLineItem.Quantity;
            end;
        end;
        Header.Insert;
    end;


    procedure InsertBuffer_CustomerRequest(pCustomerRequests: Record "DK_Customer Requests")
    begin
        //ŸŸ ×„Í“‹‹Ï—¸ ‘óŒ÷ —÷˜
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 7; // ×„Í“‹‹Ï—¸
        if pCustomerRequests."Work Cemetery No." = '' then
            Header.TEXT17 := pCustomerRequests."Cemetery No."
        else
            Header.TEXT17 := pCustomerRequests."Work Cemetery No.";

        Header.TEXT18 := pCustomerRequests."Employee name";
        Header."LONG TEXT0" := pCustomerRequests."Receipt Contents";
        Header.Insert;
    end;


    procedure InsertBuffer_RevocationContract()
    var
        _Contract: Record DK_Contract;
        _CRMSalesType: Record "DK_CRM Sales Type";
    begin
        //ÐŽÊýˆ« - —¹ŽÊ ‘÷€Ã Ÿ‡ß—
        _Contract.Reset;
        _Contract.SetRange("No.", RevocationContract."Contract No.");
        if _Contract.FindSet then begin
            _Contract.CalcFields("Cemetery Size", "Cemetery Dig. Name", "CRM SalesPerson");
            Header.Reset;
            Header.Init;
            Header."USER ID" := UserId;
            Header."OBJECT ID" := REPORT::"DK_HQ Office DailyReport";
            Header."Entry No." := EntryNo;
            Header.INTEGER0 := 0; //ÐŽÊýˆ«
            Header.TEXT0 := _Contract."Main Customer Name";
            Header.TEXT28 := _Contract."Cemetery No.";
            Header.DECIMAL2 := _Contract."Cemetery Size";
            Header.TEXT1 := _Contract."Cemetery Dig. Name";
            Header.DECIMAL3 := -RevocationContract."Apply Refund Amount";
            Header.TEXT2 := _Contract."CRM SalesPerson";
            Header.TEXT16 := Format(_Contract.Status);

            _CRMSalesType.Reset;
            _CRMSalesType.SetRange(Seq, _Contract."CRM Sales Type Seq");
            if _CRMSalesType.FindSet then
                Header.TEXT3 := _CRMSalesType.Indicator;

            if RevocationContract."Bank Name" <> '' then begin
                Header.TEXT20 := RevocationContract."Bank Name";
            end;

            if RevocationContract."Payment Card Infor." <> '' then begin
                Header.TEXT20 := CardMSG;
            end;

            if (RevocationContract."Bank Name" <> '') and
              (RevocationContract."Payment Card Infor." <> '') then begin
                Header.TEXT20 := CompoundMSG;
            end;

            Header.Insert;
        end;
    end;

    local procedure "-----------------#2106"()
    begin
    end;

    local procedure CheckHonorFirstAdminExpense(pPaymentReceiptDocument: Record "DK_Payment Receipt Document"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _Contract: Record DK_Contract;
    begin
        // Ž–‚šŠ•µ •€¯ ýˆ«Š± Š±€‚(¯€¦)
        // #2106
        _Cemetery.Reset;
        _Cemetery.CalcFields("Estate Type");
        _Cemetery.SetRange("Cemetery Code", pPaymentReceiptDocument."Cemetery Code");
        _Cemetery.SetRange("Estate Type", _Cemetery."Estate Type"::Charnelhouse);
        if not _Cemetery.FindSet then
            exit(false);

        if _Cemetery.FindSet then begin
            _Contract.Reset;
            _Contract.SetRange("No.", pPaymentReceiptDocument."Contract No.");
            _Contract.SetRange("General Amount", 0);
            _Contract.SetRange("Landscape Arc. Amount", 0);
            if _Contract.FindSet then begin
                if pPaymentReceiptDocument."New Admin. Expense" then
                    exit(true);
                /*
                _PaymentReceiptDocument.RESET;
                _PaymentReceiptDocument.CALCFIELDS("Line Admin. Expense",Refund);
                _PaymentReceiptDocument.SETRANGE("Document Type",_PaymentReceiptDocument."Document Type"::Receipt);
                _PaymentReceiptDocument.SETRANGE("Contract No.",pPaymentReceiptDocument."Contract No.");
                _PaymentReceiptDocument.SETRANGE(Posted,TRUE);
                _PaymentReceiptDocument.SETFILTER("Posting Date",'<%1',_PaymentReceiptDocument."Posting Date");
                _PaymentReceiptDocument.SETRANGE("Missing Contract",FALSE);
                _PaymentReceiptDocument.SETFILTER("Line Admin. Expense",'<>%1',0);
                _PaymentReceiptDocument.SETRANGE(Refund,FALSE);
                _PaymentReceiptDocument.SETCURRENTKEY("Payment Date");
                IF NOT _PaymentReceiptDocument.FINDFIRST THEN
                  EXIT(TRUE);
                */
            end;
        end;

        exit(false);

    end;

    local procedure CheckHonorFirstAdminExpenseRefund(pPaymentReceiptDocument: Record "DK_Payment Receipt Document"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _Contract: Record DK_Contract;
        _RefundPayRecDoc: Record "DK_Payment Receipt Document";
    begin
        // Ž–‚šŠ•µ •€¯ ýˆ«Š± Š±€‚(˜»Š­)
        // #2106
        _Cemetery.Reset;
        _Cemetery.CalcFields("Estate Type");
        _Cemetery.SetRange("Cemetery Code", pPaymentReceiptDocument."Cemetery Code");
        _Cemetery.SetRange("Estate Type", _Cemetery."Estate Type"::Charnelhouse);
        if not _Cemetery.FindSet then
            exit(false);

        if _Cemetery.FindSet then begin
            _Contract.Reset;
            _Contract.SetRange("No.", pPaymentReceiptDocument."Contract No.");
            _Contract.SetRange("General Amount", 0);
            _Contract.SetRange("Landscape Arc. Amount", 0);
            if _Contract.FindSet then begin
                _RefundPayRecDoc.Reset;
                _RefundPayRecDoc.SetRange("Document No.", pPaymentReceiptDocument."Target Doc. No.");
                _RefundPayRecDoc.SetRange(Posted, true);
                _RefundPayRecDoc.SetRange("New Admin. Expense", true);
                if _RefundPayRecDoc.FindSet then begin
                    exit(true);

                    /*
                    _PaymentReceiptDocument.RESET;
                    _PaymentReceiptDocument.CALCFIELDS("Line Admin. Expense",Refund);
                    _PaymentReceiptDocument.SETRANGE("Document Type",_PaymentReceiptDocument."Document Type"::Receipt);
                    _PaymentReceiptDocument.SETRANGE("Contract No.",pPaymentReceiptDocument."Contract No.");
                    _PaymentReceiptDocument.SETRANGE(Posted,TRUE);
                    _PaymentReceiptDocument.SETFILTER("Posting Date",'<%1',_RefundPayRecDoc."Posting Date");
                    _PaymentReceiptDocument.SETRANGE("Missing Contract",FALSE);
                    _PaymentReceiptDocument.SETFILTER("Line Admin. Expense",'<>%1',0);
                    _PaymentReceiptDocument.SETRANGE(Refund,FALSE);
                    _PaymentReceiptDocument.SETCURRENTKEY("Payment Date");
                    IF NOT _PaymentReceiptDocument.FINDFIRST THEN
                      EXIT(TRUE);
                    */
                end;
            end;
        end;

        exit(false);

    end;

    local procedure CheckHonorAdminExpense(pPayRecDoc: Record "DK_Payment Receipt Document"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _Contract: Record DK_Contract;
    begin
        // Ž–‚šŠ•µ ‘ñ€¯ ýˆ«Š± Š±€‚(¯€¦)
        // #2451

        pPayRecDoc.CalcFields("Line Admin. Expense");

        _Cemetery.Reset;
        _Cemetery.CalcFields("Estate Type");
        _Cemetery.SetRange("Cemetery Code", pPayRecDoc."Cemetery Code");
        _Cemetery.SetRange("Estate Type", _Cemetery."Estate Type"::Charnelhouse);
        if _Cemetery.FindSet then begin
            _Contract.Reset;
            _Contract.SetRange("No.", pPayRecDoc."Contract No.");
            _Contract.SetRange("General Amount", 0);
            _Contract.SetRange("Landscape Arc. Amount", 0);
            if _Contract.FindSet then
                if (pPayRecDoc."New Admin. Expense" = false) and
                  (pPayRecDoc."Line Admin. Expense" <> 0) then
                    exit(true);
        end;

        exit(false);
    end;

    local procedure CheckHonorAdminExpenseRefund(pPayRecDoc: Record "DK_Payment Receipt Document"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _Contract: Record DK_Contract;
        _PayReceiptDocument: Record "DK_Payment Receipt Document";
    begin
        // Ž–‚šŠ•µ ‘ñ€¯ ýˆ«Š± Š±€‚(˜»Š­)
        // #2451

        _Cemetery.Reset;
        _Cemetery.CalcFields("Estate Type");
        _Cemetery.SetRange("Cemetery Code", pPayRecDoc."Cemetery Code");
        _Cemetery.SetRange("Estate Type", _Cemetery."Estate Type"::Charnelhouse);
        if _Cemetery.FindSet then begin
            _Contract.Reset;
            _Contract.SetRange("No.", pPayRecDoc."Contract No.");
            _Contract.SetRange("General Amount", 0);
            _Contract.SetRange("Landscape Arc. Amount", 0);
            if _Contract.FindSet then begin
                _PayReceiptDocument.Reset;
                _PayReceiptDocument.CalcFields("Line Admin. Expense");
                _PayReceiptDocument.SetRange("Document No.", pPayRecDoc."Target Doc. No.");
                _PayReceiptDocument.SetRange(Posted, true);
                _PayReceiptDocument.SetRange("New Admin. Expense", false);
                _PayReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
                if _PayReceiptDocument.FindSet then
                    exit(true);
            end;
        end;

        exit(false);
    end;
}

