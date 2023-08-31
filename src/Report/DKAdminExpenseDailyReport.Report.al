report 50022 "DK_Admin. Expense Daily Report"////DK_Admin. Expense Daily Report -> DK_Admin. Expense Daily_Report
{
    // //ýˆ«Š± ŸŸ Šˆ×
    // *DK11
    //   - Data Source : INTEGER0, Name : ReportType
    //   - 0: ŸŸ¯€¦—÷˜, 1: ’†Ýžß‘ª, 2: ýˆ«Š±¯€¦ •ÔÐ, 3: ŸŸ ‰œ˜«ž ¯€¦ —÷˜
    // 
    // *Line 178
    //   - ýˆ«Š± ¯€¦ •ÔÐ
    //   - Š—Ê ŒÁ€¦ - […Žð]‰ŽÊ,ÐŽÊ,Â€¦-‚Ý—õ Ð‘’ ‹Ð‘ª
    // 
    // #2112: 20200820
    //   - Add function: CheckHonorFirstAdminExpense, CheckHonorFirstAdminExpenseRefund
    //   - Modify function: SetReportRange
    // 
    // #2123: 20200827
    //   - Modify function: SetReportRange, InsertBuffer_AdminPaymentStatics, InsertBuffer_AdminPaymentStaticsMethod
    // 
    // #2144: 20200904
    //   - Modify Layout sorting: Default
    // 
    // #2171: 20200916
    //   - Modify function: SetReportRange, CheckHonorFirstAdminExpense, CheckHonorFirstAdminExpenseRefund
    // 
    // #2177: 20200921
    //   - Modify function: InsertBuffer_AdminPaymentStatics, SetReportRange, InsertBuffer_AdminPaymentStaticsMethod
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAdminExpenseDailyReport.rdl';

    Caption = 'DK_Admin. Expense Daily Report';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            UseTemporary = true;
            column(ReportNo; INTEGER0)
            {
            }
            column(AdminCemteryNo; TEXT0)
            {
            }
            column(AdminMainCustName; TEXT1)
            {
            }
            column(AdminCemeterySize; DECIMAL1)
            {
            }
            column(AdminIlIlGigan; INTEGER1)
            {
            }
            column(AdminExpirationDate; DATE0)
            {
            }
            column(AdminPaymentAmount; DECIMAL0)
            {
            }
            column(AdminPaymentType; TEXT2)
            {
            }
            column(AdminContractDate; DATE1)
            {
            }
            column(AdminExpenseType; TEXT3)
            {
            }
            column(AdminHwaeWonNo; TEXT4)
            {
            }
            column(AdminName; TEXT5)
            {
            }
            column(AdminPyungSoo; DECIMAL2)
            {
            }
            column(AdminGigan; INTEGER2)
            {
            }
            column(AdminOnlineExpirDate; DATE2)
            {
            }
            column(AdminOnlineIpGeumAek; DECIMAL5)
            {
            }
            column(AdminOnilineIpGeumGooBoon; TEXT6)
            {
            }
            column(AdminOnlineGyuljaeDateTime; DATE3)
            {
            }
            column(AdminOnlineSeungIn; TEXT7)
            {
            }
            column(GwanliIpgeumGooBoon; TEXT8)
            {
            }
            column(GwanLliDangWolGGun; DECIMAL6)
            {
            }
            column(GwanLliDangWolAmount; DECIMAL7)
            {
            }
            column(GwanliJeonWolGGun; DECIMAL8)
            {
            }
            column(GwanliJeonWolAmount; DECIMAL9)
            {
            }
            column(GwanliBigo; TEXT14)
            {
            }
            column(GwanliOption; INTEGER3)
            {
            }
            column(GwanliIlIlGGun; DECIMAL10)
            {
            }
            column(GwanliIlIlAmount; DECIMAL11)
            {
            }
            column(UnConfirmCemeteryNo; TEXT9)
            {
            }
            column(UnConfirmMainCustName; TEXT10)
            {
            }
            column(UnConfrimPaymentDate; DATE4)
            {
            }
            column(UnConfirmPaymentAmount; DECIMAL4)
            {
            }
            column(UnConfirmPaymentType; TEXT11)
            {
            }
            column(UnConfirmContractDate; DATE5)
            {
            }
            column(UnConfirmExpenseType; TEXT13)
            {
            }
            column(CustomerType; TEXT12)
            {
            }
            column(CurrDateCustomer; DECIMAL15)
            {
            }
            column(PreDateCustomer; DECIMAL16)
            {
            }
            column(gDate; gDate)
            {
            }
            column(ColorType; INTEGER2)
            {
            }

            trigger OnPreDataItem()
            begin

                Header.Reset;
                Header.SetRange("USER ID", UserId);
                Header.SetRange("OBJECT ID", REPORT::"DK_Admin. Expense Daily Report");
                if Header.FindSet then
                    Header.DeleteAll;

                SetReportRange(gDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(gDate; gDate)
                {
                    Caption = 'Date';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            gDate := WorkDate;
        end;
    }

    labels
    {
        l = 'TongHap';
        DamDangLbl = 'DamDang';
        BujangLbl = 'Bujang';
        EsaLbl = 'Esa';
        BusajangLbl = 'BusaJang';
        EsajangLbl = 'ESajang';
        IllIllLbl = 'ILLILL';
        HwaeWonLbl = 'HwaeWon';
        SungMyungLbl = 'SungMyung';
        PyungSooLbl = 'PyungSoo';
        GiganLbl = 'Gigan';
        GwanliEndLbl = 'GwanliEnd';
        IpGeumAeklbl = 'IpGemAek';
        IpGeumGooBoonLbl = 'IpGeumGooBoon';
        OnlineLbl = 'Online';
        GyaeYakIllLbl = 'GaeYakill';
        GyulJaeillJaLbl = 'GyulJaeIll';
        SeungInLbl = 'SeungIn';
        KwanLibiLbl = 'KwanLibi';
        DangWolGgunLbl = 'DangWol';
        DangWoGeumLbl = 'DangWolGeum';
        JeonWolGgunLbl = 'JeonWol';
        JeonWolGeumLbl = 'JeonWol';
        BigoLbl = 'Bigo';
        ByungGyungLbl = 'ByungGyung';
        ByunGJalbl = 'ByungGyungJa';
        HwaeWonGunLbl = 'HwaeWon';
        BongAnLbl = 'BongAnGunSoo';
        IpGeumLbl = 'IpGeum';
        MunUiLbl = 'MunUi';
        HaeYakLbl = 'HaeYak';
        BigoOnlyLbl = 'Bigo';
        TongGyaeLbl = 'TongGyae';
        ByuGyungGooBoonLbl = 'ByunG';
        DangWolByunlbl = 'DangWol';
        JeonwolByunLbl = 'JeonWonl';
        CountLb = 'Count';
        GgunLb = 'Count';
        CorporationLB = 'Corporation';
        YonginParkLb = 'YoninPark';
        SectionChiefLb = 'Section Chief';
        CenterManagerLb = 'Center Manager';
        GeneralManagerLb = 'General Manager';
        ReferenceDateLb = '(Reference Date : Pre 17:01 ~ Curr 17:00)';
        TodayPrePaymentLb = 'Today PrePayment Statics';
        PaymentDateLb = 'Payment Date';
        PaymentMethodLb = 'Payment Method';
        PartLeaderLb = 'Part Leader';
        DaliyCountLb = 'ŸŸ ¯€¦—Œ÷';
        DaliyPaymentLb = 'ŸŸ ¯€¦€¦Ž¸';
    }

    var
        gDate: Date;
        CashMSG: Label 'Cash';
        VirtualAccountMSG: Label 'VirtualAccount';
        GiroMSG: Label 'Giro';
        GeneralExpirationMSG: Label 'General Expiration';
        LandArcExpirationMSG: Label 'Landscapre Expiration';
        EntryNo: Integer;
        PaymentTypeMSG: Label 'Bank-%1';
        CustomerInfoMSG: Label '%1. Customer Information';
        CorpseInfoMSG: Label '%1. Corpse Information';
        PaymentInfoMSG: Label '%1. Payment Information';
        CounselInfoMSG: Label '%1. Counsel Information';
        RevocationInfoMSG: Label '%1. Revocation Information';
        PaymentMethodMSG: Label '%1-%2';
        PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        ReceiptBankAccount: Record "DK_Receipt Bank Account";
        PaymentMethod: Record "DK_Payment Method";
        TotalCurrAdminCount: Decimal;
        TotalCurrAdminPayment: Decimal;
        TotalPreAdminCount: Decimal;
        TotalPreAdminPayment: Decimal;
        TotalMSG: Label '%1-%2';
        SubTotalMSG: Label '—³Ð';
        TotalDaliyAdminCount: Decimal;
        TotalDaliyAdminPayment: Decimal;


    procedure SetReportRange(pDate: Date)
    var
        _Contract: Record DK_Contract;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _CurrMonStartDate: Date;
        _CurrMonEndDate: Date;
        _PreMonStartDate: Date;
        _PreMonEndDate: Date;
        _Employee: Record DK_Employee;
        _ChangeInt: Integer;
        _TotalDailyAdminCount: Decimal;
        _TotalDailyAdminPayment: Decimal;
        _TotalCurrAdminCount: Decimal;
        _TotalCurrAdminPayment: Decimal;
        _TotalPreAdminCount: Decimal;
        _TotalPreAdminPayment: Decimal;
        _MethodText: Text;
        _Count: Decimal;
        _Decimal1: Decimal;
    begin
        //_ReferenceStartDateTime := CREATEDATETIME(pDate-1,170100T); //¯€¦€Ë‘¹ “Á Ÿ“ú
        //_ReferenceEndDateTime := CREATEDATETIME(pDate,170000T);     //¯€¦€Ë‘¹ ‘Ž‡ß Ÿ“ú
        _CurrMonStartDate := CalcDate('<-CM>', pDate); //„Ïõ“š
        _CurrMonEndDate := CalcDate('<CM>', pDate);    //„Ïõˆ‹
        _PreMonStartDate := CalcDate('<-CM-1M>', pDate);  //ýõ“š
        _PreMonEndDate := CalcDate('<CM-1M>', pDate);    //ýõˆ‹

        //ŸŸ ¯€¦ —÷˜
        with PaymentReceiptDocument do begin
            Clear(PaymentReceiptDocument);
            SetRange("Document Type", "Document Type"::Receipt);
            SetRange(Posted, true);
            SetRange("Posting Date", pDate);
            SetFilter("Payment Type", '%1|%2|%3', "Payment Type"::Bank, "Payment Type"::Giro, "Payment Type"::VirtualAccount);
            SetRange("Missing Contract", false);
            SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract", "Payment Type");
            if FindSet then begin
                repeat
                    // >> #2112
                    if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                      (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then
                        InsertBuffer_DailyPayment;
                // <<
                until PaymentReceiptDocument.Next = 0;
            end;

            Clear(PaymentReceiptDocument);
            SetFilter("Payment Type", '%1|%2|%3', "Payment Type"::Bank, "Payment Type"::Giro, "Payment Type"::VirtualAccount);
            SetRange("Document Type", "Document Type"::Refund);
            SetRange("Payment Completion Date", pDate);
            if FindSet then begin
                repeat
                    // >> #2112
                    if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                      (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then
                        InsertBuffer_DailyPaymentRefund;
                // <<
                until PaymentReceiptDocument.Next = 0;
            end;
        end;

        //ŸŸ ‰œ˜«ž ¯€¦—÷˜
        with PaymentReceiptDocument do begin
            Clear(PaymentReceiptDocument);
            SetRange("Document Type", "Document Type"::Receipt);
            SetRange(Posted, true);
            SetRange("Posting Date", pDate);
            SetRange("Missing Contract", true);
            if FindSet then begin
                repeat
                    InsertBuffer_DailyMissingPayment;
                until Next = 0;
            end;
        end;

        with PaymentReceiptDocument do begin
            SetRange("Missing Contract", false);
            SetFilter("Before Document No.", '<>%1', '');
            if FindSet then begin
                repeat
                    InsertBuffer_DailyMissingPayment2;
                until Next = 0;
            end;
        end;

        //’†Ýžß‘ª ¯€¦—÷˜
        with PaymentReceiptDocument do begin
            SetRange("Missing Contract", false);
            SetRange("Before Document No.");
            SetRange("Payment Type");
            SetRange("Payment Type", "Payment Type"::OnlineCard);
            if FindSet then begin // - ¯€¦—
                repeat
                    // >> #2112
                    if not CheckHonorFirstAdminExpense(PaymentReceiptDocument) then
                        InsertBuffer_OnlinePayment2;
                // <<
                until Next = 0;
            end;

            SetRange("Posting Date");
            SetRange("Document Type", "Document Type"::Refund);
            SetRange("Payment Completion Date", pDate);
            if FindSet then begin // - ˜»Š­—
                repeat
                    // >> 2112
                    if not CheckHonorFirstAdminExpenseRefund(PaymentReceiptDocument) then
                        InsertBuffer_OnlinePayment3;
                // <<
                until Next = 0;
            end;
        end;

        Clear(TotalDaliyAdminCount);
        Clear(TotalDaliyAdminPayment);
        Clear(TotalCurrAdminCount);
        Clear(TotalCurrAdminPayment);
        Clear(TotalPreAdminCount);
        Clear(TotalPreAdminPayment);
        Clear(PaymentReceiptDocument);
        PaymentReceiptDocument.CalcFields("Line Admin. Expense", "Target Line Admin. Expense");
        PaymentReceiptDocument.SetRange("Missing Contract", false);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        //PaymentReceiptDocument.SETRANGE("Refund Document No.",'');
        PaymentReceiptDocument.SetRange(Posted, true);
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);

        //ýˆ«Š± ¯€¦ •ÔÐ - ŒÁ€¦
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Bank);
        ReceiptBankAccount.Reset;
        ReceiptBankAccount.SetCurrentKey(Blocked);
        ReceiptBankAccount.SetRange(Blocked, false);
        //ReceiptBankAccount.SETFILTER(Code,'<>%1','BA004'); //[…Žð] ‰ŽÊ,ÐŽÊ,Â€¦ - ‚Ý—õ Ð‘’ ‘ª•
        if ReceiptBankAccount.FindSet then begin
            repeat
                PaymentReceiptDocument.SetRange("Bank Account Code", ReceiptBankAccount.Code);
                InsertBuffer_AdminPaymentStatics(pDate, ReceiptBankAccount."Bank Name", ReceiptBankAccount.Description);
            until ReceiptBankAccount.Next = 0;
        end;

        //ýˆ«Š± ¯€¦ •ÔÐ - —÷€¦
        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Bank Account Code");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Cash);

        EntryNo += 1;
        Header.Reset;
        Header.Init;
        Header.INTEGER0 := 2; //ýˆ«Š± ¯€¦ •ÔÐ
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
        Header."Entry No." := EntryNo;
        Header.TEXT8 := Format(PaymentReceiptDocument."Payment Type"::Cash);

        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat

                if StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0 then begin
                    // Ž–‚šŠ•µ ‘ªÂ ‡ž‘ð ‘ª• Í“‹ # 5312
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");

                end else begin

                    if PaymentReceiptDocument."New Admin. Expense" = false then begin

                        PaymentReceiptDocument.CalcFields("Line Service Amount");

                        _Count += 1;
                        _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                      PaymentReceiptDocument."Reduction Amount");


                    end;


                end;


            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL10 := _Count;
            Header.DECIMAL11 := _Decimal1;

            //Header.DECIMAL10 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL11 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Cash);
        PaymentReceiptDocument.SetRange("Payment Completion Date", pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0 then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL11 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end else begin

                    if PaymentReceiptDocument."New Admin. Expense" = false then begin

                        PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                        Header.DECIMAL11 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                 PaymentReceiptDocument."Reduction Amount");


                    end;


                end;


            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL11 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.Reset;
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Cash);
        PaymentReceiptDocument.SetRange("Posting Date", _CurrMonStartDate, pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat

                if StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0 then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end else begin

                    if PaymentReceiptDocument."New Admin. Expense" = false then begin
                        PaymentReceiptDocument.CalcFields("Line Service Amount");

                        _Count += 1;
                        _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                      PaymentReceiptDocument."Reduction Amount");


                    end;
                end;



            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL6 := _Count;
            Header.DECIMAL7 := _Decimal1;

            //Header.DECIMAL6 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Payment Completion Date", _CurrMonStartDate, pDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Cash);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0 then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL7 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end else begin

                    if PaymentReceiptDocument."New Admin. Expense" = false then begin
                        PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                        Header.DECIMAL7 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                        PaymentReceiptDocument."Reduction Amount");


                    end;
                end;
            until PaymentReceiptDocument.Next = 0;


            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.Reset;
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Cash);
        PaymentReceiptDocument.SetRange("Posting Date", _PreMonStartDate, _PreMonEndDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat

                if StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0 then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end else begin

                    if PaymentReceiptDocument."New Admin. Expense" = false then begin
                        PaymentReceiptDocument.CalcFields("Line Service Amount");

                        _Count += 1;
                        _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                      PaymentReceiptDocument."Reduction Amount");

                    end;
                end;

            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL8 := _Count;
            Header.DECIMAL9 := _Decimal1;

            //Header.DECIMAL8 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Payment Completion Date", _PreMonStartDate, _PreMonEndDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Cash);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0 then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL9 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end else begin

                    if PaymentReceiptDocument."New Admin. Expense" = false then begin

                        PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                        Header.DECIMAL9 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                      PaymentReceiptDocument."Reduction Amount");
                    end;
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        TotalDaliyAdminCount += Header.DECIMAL10;
        TotalDaliyAdminPayment += Header.DECIMAL11;
        TotalCurrAdminCount += Header.DECIMAL6;
        TotalCurrAdminPayment += Header.DECIMAL7;
        TotalPreAdminCount += Header.DECIMAL8;
        TotalPreAdminPayment += Header.DECIMAL9;

        Header.Insert;

        _Count := 0;
        _Decimal1 := 0;

        //ýˆ«Š± ¯€¦ •ÔÐ - í‹ÝÐ‘’
        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::VirtualAccount);

        EntryNo += 1;
        Header.Reset;
        Header.Init;
        Header.INTEGER0 := 2; //ýˆ«Š± ¯€¦ •ÔÐ
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
        Header."Entry No." := EntryNo;
        Header.TEXT8 := Format(PaymentReceiptDocument."Payment Type"::VirtualAccount);

        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL10 := _Count;
            Header.DECIMAL11 := _Decimal1;

            //Header.DECIMAL10 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS(Amount);
            //Header.DECIMAL11 := PaymentReceiptDocument.Amount;
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Completion Date", pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL11 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL11 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Posting Date", _CurrMonStartDate, pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL6 := _Count;
            Header.DECIMAL7 := _Decimal1;

            //Header.DECIMAL6 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Completion Date", _CurrMonStartDate, pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL7 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Posting Date", _PreMonStartDate, _PreMonEndDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL8 := _Count;
            Header.DECIMAL9 := _Decimal1;

            //Header.DECIMAL8 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        PaymentReceiptDocument.SetRange("Payment Completion Date", _PreMonStartDate, _PreMonEndDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL9 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        TotalDaliyAdminCount += Header.DECIMAL10;
        TotalDaliyAdminPayment += Header.DECIMAL11;
        TotalCurrAdminCount += Header.DECIMAL6;
        TotalCurrAdminPayment += Header.DECIMAL7;
        TotalPreAdminCount += Header.DECIMAL8;
        TotalPreAdminPayment += Header.DECIMAL9;

        Header.Insert;

        //ýˆ«Š± ¯€¦ •ÔÐ - ’†Ýž”½…Î
        PaymentReceiptDocument.SetRange("Payment Type");
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::OnlineCard);

        PaymentMethod.Reset;
        PaymentMethod.SetRange(Blocked, false);
        PaymentMethod.SetRange(Type, PaymentMethod.Type::Online);
        if PaymentMethod.FindSet then begin
            repeat
                PaymentReceiptDocument.SetRange("Payment Method Code", PaymentMethod.Code);
                InsertBuffer_AdminPaymentStaticsMethod(pDate, Format(PaymentMethod.Type), PaymentMethod.Name,
                _TotalDailyAdminCount, _TotalDailyAdminPayment, _TotalCurrAdminCount, _TotalCurrAdminPayment, _TotalPreAdminCount, _TotalPreAdminPayment);
            until PaymentMethod.Next = 0;
            _MethodText := StrSubstNo(TotalMSG, PaymentMethod.Type::Online);
            InsertBuffer_TotalAdminPayment(_MethodText, _TotalDailyAdminCount, _TotalDailyAdminPayment, _TotalCurrAdminCount, _TotalCurrAdminPayment, _TotalPreAdminCount, _TotalPreAdminPayment);
        end;

        TotalDaliyAdminCount += _TotalDailyAdminCount;
        TotalDaliyAdminPayment += _TotalDailyAdminPayment;
        TotalCurrAdminCount += _TotalCurrAdminCount;
        TotalCurrAdminPayment += _TotalCurrAdminPayment;
        TotalPreAdminCount += _TotalPreAdminCount;
        TotalPreAdminPayment += _TotalPreAdminPayment;

        _TotalDailyAdminCount := 0;
        _TotalDailyAdminPayment := 0;
        _TotalCurrAdminCount := 0;
        _TotalCurrAdminPayment := 0;
        _TotalPreAdminCount := 0;
        _TotalPreAdminPayment := 0;

        //ýˆ«Š± ¯€¦ •ÔÐ - ”½…Î
        PaymentReceiptDocument.SetRange("Payment Type");
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Card);

        PaymentMethod.SetRange(Type, PaymentMethod.Type::Card);
        if PaymentMethod.FindSet then begin
            repeat
                PaymentReceiptDocument.SetRange("Payment Method Code", PaymentMethod.Code);
                InsertBuffer_AdminPaymentStaticsMethod(pDate, Format(PaymentMethod.Type), PaymentMethod.Name,
                _TotalDailyAdminCount, _TotalDailyAdminPayment, _TotalCurrAdminCount, _TotalCurrAdminPayment, _TotalPreAdminCount, _TotalPreAdminPayment);
            until PaymentMethod.Next = 0;
            _MethodText := StrSubstNo(TotalMSG, PaymentMethod.Type::Card);
            InsertBuffer_TotalAdminPayment(_MethodText, _TotalDailyAdminCount, _TotalDailyAdminPayment, _TotalCurrAdminCount, _TotalCurrAdminPayment, _TotalPreAdminCount, _TotalPreAdminPayment);
        end;

        TotalDaliyAdminCount += _TotalDailyAdminCount;
        TotalDaliyAdminPayment += _TotalDailyAdminPayment;
        TotalCurrAdminCount += _TotalCurrAdminCount;
        TotalCurrAdminPayment += _TotalCurrAdminPayment;
        TotalPreAdminCount += _TotalPreAdminCount;
        TotalPreAdminPayment += _TotalPreAdminPayment;

        _TotalDailyAdminCount := 0;
        _TotalDailyAdminPayment := 0;
        _TotalCurrAdminCount := 0;
        _TotalCurrAdminPayment := 0;
        _TotalPreAdminCount := 0;
        _TotalPreAdminPayment := 0;

        //ýˆ«Š± ¯€¦ •ÔÐ - ‘÷‡ž
        PaymentReceiptDocument.SetRange("Payment Type");
        PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::Giro);

        PaymentMethod.SetRange(Type, PaymentMethod.Type::Giro);
        if PaymentMethod.FindSet then begin
            repeat
                PaymentReceiptDocument.SetRange("Payment Method Code", PaymentMethod.Code);
                InsertBuffer_AdminPaymentStaticsMethod(pDate, Format(PaymentMethod.Type), PaymentMethod.Name,
                _TotalDailyAdminCount, _TotalDailyAdminPayment, _TotalCurrAdminCount, _TotalCurrAdminPayment, _TotalPreAdminCount, _TotalPreAdminPayment);
            until PaymentMethod.Next = 0;
            _MethodText := StrSubstNo(TotalMSG, PaymentMethod.Type::Giro);
            InsertBuffer_TotalAdminPayment(_MethodText, _TotalDailyAdminCount, _TotalDailyAdminPayment, _TotalCurrAdminCount, _TotalCurrAdminPayment, _TotalPreAdminCount, _TotalPreAdminPayment);
        end;

        TotalDaliyAdminCount += _TotalDailyAdminCount;
        TotalDaliyAdminPayment += _TotalDailyAdminPayment;
        TotalCurrAdminCount += _TotalCurrAdminCount;
        TotalCurrAdminPayment += _TotalCurrAdminPayment;
        TotalPreAdminCount += _TotalPreAdminCount;
        TotalPreAdminPayment += _TotalPreAdminPayment;

        InsertBuffer_TotalAdminPayment(SubTotalMSG, TotalDaliyAdminCount, TotalDaliyAdminPayment, TotalCurrAdminCount, TotalCurrAdminPayment, TotalPreAdminCount, TotalPreAdminPayment);
    end;


    procedure InsertBuffer_DailyPaymentRefund()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //ŸŸ ¯€¦ —÷˜
        //PaymentReceiptDocument.CALCFIELDS("Cemetery No.");
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* //‰²Š±Ô + Œ€‚‚€¦ + ‘÷¼œÀ
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        _LineGeneralAmount := 0;
        _LineLandAmount := 0;
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
        with _PaymentReceiptDocLine do begin
            Reset;
            SetRange("Document No.", PaymentReceiptDocument."Target Doc. No.");
            SetFilter("Payment Target", '%1|%2', "Payment Target"::General, "Payment Target"::Landscape);
            if FindSet then begin
                repeat
                    EntryNo += 1;
                    CalcFields("Payment Type");
                    Header.Reset;
                    Header.Init;
                    Header.INTEGER0 := 0; //ŸŸ ¯€¦ —÷˜
                    Header."USER ID" := UserId;
                    Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
                    Header."Entry No." := EntryNo;
                    Header.TEXT0 := PaymentReceiptDocument."Cemetery No.";
                    if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
                        _Contract.CalcFields("Cemetery Size");
                        Header.TEXT1 := _Contract."Main Customer Name";
                        Header.DECIMAL1 := _Contract."Cemetery Size";
                        Header.DATE1 := _Contract."Contract Date";
                    end;
                    Header.INTEGER1 := _RevocationContractMgt.CalcContractPreiodMonth("Start Date", "Expiration Date");
                    Header.DATE0 := "Expiration Date";
                    if "Payment Target" = "Payment Target"::General then
                        Header.DECIMAL0 := -(_PaymentReceiptDocLine.Amount - PaymentReceiptDocument."Reduction Amount 1")
                    else
                        Header.DECIMAL0 := -(_PaymentReceiptDocLine.Amount - PaymentReceiptDocument."Reduction Amount 2");
                    case "Payment Type" of
                        "Payment Type"::Bank:
                            begin
                                if _ReceiptBankAccount.Get(PaymentReceiptDocument."Bank Account Code") then
                                    Header.TEXT2 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"::Bank), _ReceiptBankAccount."Bank Name");
                            end;
                        "Payment Type"::Card, "Payment Type"::Giro:
                            begin
                                Header.TEXT2 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), PaymentReceiptDocument."Payment Method Name");
                            end;
                        "Payment Type"::Cash, "Payment Type"::VirtualAccount:
                            begin
                                Header.TEXT2 := Format("Payment Type");
                            end;
                    end;
                    if "Payment Target" = "Payment Target"::General then
                        Header.TEXT3 := GeneralExpirationMSG
                    else
                        Header.TEXT3 := LandArcExpirationMSG;
                    Header.Insert;
                until Next = 0;
            end;
        end;

    end;


    procedure InsertBuffer_DailyPayment()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //ŸŸ ¯€¦ —÷˜
        //PaymentReceiptDocument.CALCFIELDS("Cemetery No.");
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* //‰²Š±Ô + Œ€‚‚€¦ + ‘÷¼œÀ
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        _LineGeneralAmount := 0;
        _LineLandAmount := 0;
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
        with _PaymentReceiptDocLine do begin
            Reset;
            SetRange("Document No.", PaymentReceiptDocument."Document No.");
            SetFilter("Payment Target", '%1|%2', "Payment Target"::General, "Payment Target"::Landscape);
            if FindSet then begin
                repeat
                    EntryNo += 1;
                    CalcFields("Payment Type");
                    Header.Reset;
                    Header.Init;
                    Header.INTEGER0 := 0; //ŸŸ ¯€¦ —÷˜
                    Header."USER ID" := UserId;
                    Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
                    Header."Entry No." := EntryNo;
                    Header.TEXT0 := PaymentReceiptDocument."Cemetery No.";
                    if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
                        _Contract.CalcFields("Cemetery Size");
                        Header.TEXT1 := _Contract."Main Customer Name";
                        Header.DECIMAL1 := _Contract."Cemetery Size";
                        Header.DATE1 := _Contract."Contract Date";
                    end;
                    Header.INTEGER1 := _RevocationContractMgt.CalcContractPreiodMonth("Start Date", "Expiration Date");
                    Header.DATE0 := "Expiration Date";

                    //€¦Ž¸í –ð—¯…—ŽØ ´„’ ¿ˆÒŽ¸ ‘ªÂ
                    if "Payment Target" = "Payment Target"::General then
                        Header.DECIMAL0 := PaymentReceiptDocument."Line General Amount" - PaymentReceiptDocument."Reduction Amount 1"
                    else
                        Header.DECIMAL0 := PaymentReceiptDocument."Line Land. Arc. Amount" - PaymentReceiptDocument."Reduction Amount 2";

                    case "Payment Type" of
                        "Payment Type"::Bank:
                            begin
                                if _ReceiptBankAccount.Get(PaymentReceiptDocument."Bank Account Code") then
                                    Header.TEXT2 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"::Bank), _ReceiptBankAccount."Bank Name");
                            end;
                        "Payment Type"::Card, "Payment Type"::Giro:
                            begin
                                Header.TEXT2 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), PaymentReceiptDocument."Payment Method Name");
                            end;
                        "Payment Type"::Cash, "Payment Type"::VirtualAccount:
                            begin
                                Header.TEXT2 := Format("Payment Type");
                            end;
                    end;
                    if "Payment Target" = "Payment Target"::General then
                        Header.TEXT3 := GeneralExpirationMSG
                    else
                        Header.TEXT3 := LandArcExpirationMSG;
                    Header.Insert;
                until Next = 0;
            end;
        end;

    end;


    procedure InsertBuffer_DailyMissingPayment()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //ŸŸ ‰œ˜«ž ¯€¦ —÷˜
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* // ‰²Š±Ô + Œ€‚‚€¦ + ‘÷¼œÀ
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        _LineGeneralAmount := 0;
        _LineLandAmount := 0;
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

        with _PaymentReceiptDocLine do begin
            Reset;
            SetRange("Document No.", PaymentReceiptDocument."Document No.");
            SetFilter("Payment Target", '%1|%2', "Payment Target"::General, "Payment Target"::Landscape);
            if FindSet then begin
                repeat
                    EntryNo += 1;
                    CalcFields("Payment Type");
                    Header.Reset;
                    Header.Init;
                    Header.INTEGER0 := 3; //ŸŸ ‰œ˜«ž ¯€¦ —÷˜
                    Header."USER ID" := UserId;
                    Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
                    Header."Entry No." := EntryNo;
                    Header.TEXT9 := PaymentReceiptDocument."Cemetery No.";
                    if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
                        Header.TEXT10 := _Contract."Main Customer Name";
                        Header.DATE5 := _Contract."Contract Date";
                    end;
                    Header.DATE4 := "Payment Date";

                    if "Payment Target" = "Payment Target"::General then
                        Header.DECIMAL4 := PaymentReceiptDocument."Line General Amount" - PaymentReceiptDocument."Reduction Amount 1"
                    else
                        Header.DECIMAL4 := PaymentReceiptDocument."Line Land. Arc. Amount" - PaymentReceiptDocument."Reduction Amount 2";

                    case "Payment Type" of
                        "Payment Type"::Bank:
                            begin
                                if _ReceiptBankAccount.Get(PaymentReceiptDocument."Bank Account Code") then
                                    Header.TEXT11 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"::Bank), _ReceiptBankAccount."Bank Name");
                            end;
                        "Payment Type"::Card, "Payment Type"::Giro:
                            begin
                                Header.TEXT11 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), PaymentReceiptDocument."Payment Method Name");
                            end;
                        "Payment Type"::Cash, "Payment Type"::VirtualAccount:
                            begin
                                Header.TEXT11 := Format("Payment Type");
                            end;
                    end;
                    if "Payment Target" = "Payment Target"::General then
                        Header.TEXT13 := GeneralExpirationMSG
                    else
                        Header.TEXT13 := LandArcExpirationMSG;
                    Header.Insert;
                until Next = 0;
            end;
        end;

    end;


    procedure InsertBuffer_DailyMissingPayment2()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _ReceiptBankAccount: Record "DK_Receipt Bank Account";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //ŸŸ ‰œ˜«ž ¯€¦ —÷˜ - ˜»Š­
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* // ‰²Š±Ô + Œ€‚‚€¦ + ‘÷¼œÀ
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        _LineGeneralAmount := 0;
        _LineLandAmount := 0;
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

        with _PaymentReceiptDocLine do begin
            Reset;
            SetRange("Document No.", PaymentReceiptDocument."Target Doc. No.");
            SetFilter("Payment Target", '%1|%2', "Payment Target"::General, "Payment Target"::Landscape);
            if FindSet then begin
                repeat
                    EntryNo += 1;
                    CalcFields("Payment Type");
                    Header.Reset;
                    Header.Init;
                    Header.INTEGER0 := 3; //ŸŸ ‰œ˜«ž ¯€¦ —÷˜
                    Header."USER ID" := UserId;
                    Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
                    Header."Entry No." := EntryNo;
                    Header.TEXT9 := PaymentReceiptDocument."Cemetery No.";
                    if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
                        Header.TEXT10 := _Contract."Main Customer Name";
                        Header.DATE5 := _Contract."Contract Date";
                    end;
                    Header.DATE4 := "Payment Date";

                    if "Payment Target" = "Payment Target"::General then
                        Header.DECIMAL4 := -(PaymentReceiptDocument."Line General Amount" - PaymentReceiptDocument."Reduction Amount 1")
                    else
                        Header.DECIMAL4 := -(PaymentReceiptDocument."Line Land. Arc. Amount" - PaymentReceiptDocument."Reduction Amount 2");

                    case "Payment Type" of
                        "Payment Type"::Bank:
                            begin
                                if _ReceiptBankAccount.Get(PaymentReceiptDocument."Bank Account Code") then
                                    Header.TEXT11 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"::Bank), _ReceiptBankAccount."Bank Name");
                            end;
                        "Payment Type"::Card, "Payment Type"::Giro:
                            begin
                                Header.TEXT11 := StrSubstNo(PaymentMethodMSG, Format("Payment Type"), PaymentReceiptDocument."Payment Method Name");
                            end;
                        "Payment Type"::Cash, "Payment Type"::VirtualAccount:
                            begin
                                Header.TEXT11 := Format("Payment Type");
                            end;
                    end;
                    if "Payment Target" = "Payment Target"::General then
                        Header.TEXT13 := GeneralExpirationMSG
                    else
                        Header.TEXT13 := LandArcExpirationMSG;
                    Header.Insert;
                until Next = 0;
            end;
        end;

    end;


    procedure InsertBuffer_OnlinePayment3()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //’†Ýžß‘ª ˜»Š­
        //PaymentReceiptDocument.CALCFIELDS("Cemetery No.");
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* // ‰²Š±Ô + Œ€‚‚€¦ + ‘÷¼œÀ
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        _LineGeneralAmount := 0;
        _LineLandAmount := 0;
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
        with _PaymentReceiptDocLine do begin
            Reset;
            SetRange("Document No.", PaymentReceiptDocument."Target Doc. No.");
            SetFilter("Payment Target", '%1|%2', "Payment Target"::General, "Payment Target"::Landscape);
            if FindSet then begin
                repeat
                    EntryNo += 1;
                    Header.Reset;
                    Header.Init;
                    Header.INTEGER0 := 1; //’†Ýžß‘ª ¯€¦ —÷˜
                    Header."USER ID" := UserId;
                    Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
                    Header."Entry No." := EntryNo;
                    Header.TEXT4 := PaymentReceiptDocument."Cemetery No.";
                    if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
                        _Contract.CalcFields("Cemetery Size");
                        Header.TEXT5 := _Contract."Main Customer Name";
                        Header.DECIMAL2 := _Contract."Cemetery Size";
                    end;
                    Header.INTEGER2 := _RevocationContractMgt.CalcContractPreiodMonth("Start Date", "Expiration Date");
                    Header.DATE2 := _PaymentReceiptDocLine."Expiration Date";

                    if "Payment Target" = "Payment Target"::General then
                        Header.DECIMAL5 := -(_PaymentReceiptDocLine.Amount - PaymentReceiptDocument."Reduction Amount 1")
                    else
                        Header.DECIMAL5 := -(_PaymentReceiptDocLine.Amount - PaymentReceiptDocument."Reduction Amount 2");

                    Header.TEXT6 := StrSubstNo(PaymentMethodMSG, Format(PaymentReceiptDocument."Payment Type"::OnlineCard), PaymentReceiptDocument."Payment Method Name");
                    Header.DATE3 := PaymentReceiptDocument."Payment Date";
                    Header.TEXT7 := PaymentReceiptDocument."Card Approval No.";
                    Header.Insert;
                until Next = 0;
            end;
        end;

    end;


    procedure InsertBuffer_OnlinePayment2()
    var
        _Contract: Record DK_Contract;
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
    begin
        //’†Ýžß‘ª ¯€¦ —÷˜
        //PaymentReceiptDocument.CALCFIELDS("Cemetery No.");
        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
        /* // ‰²Š±Ô + Œ€‚‚€¦ + ‘÷¼œÀ
        _AllExtraAmount := 0;
        _GeneralExtraAmount := 0;
        _LandExtraAmount := 0;
        _LineGeneralAmount := 0;
        _LineLandAmount := 0;
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

        with _PaymentReceiptDocLine do begin
            Reset;
            SetRange("Document No.", PaymentReceiptDocument."Document No.");
            SetFilter("Payment Target", '%1|%2', "Payment Target"::General, "Payment Target"::Landscape);
            if FindSet then begin
                repeat
                    EntryNo += 1;
                    Header.Reset;
                    Header.Init;
                    Header.INTEGER0 := 1; //’†Ýžß‘ª ¯€¦ —÷˜
                    Header."USER ID" := UserId;
                    Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
                    Header."Entry No." := EntryNo;
                    Header.TEXT4 := PaymentReceiptDocument."Cemetery No.";
                    if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
                        _Contract.CalcFields("Cemetery Size");
                        Header.TEXT5 := _Contract."Main Customer Name";
                        Header.DECIMAL2 := _Contract."Cemetery Size";
                    end;
                    Header.INTEGER2 := _RevocationContractMgt.CalcContractPreiodMonth("Start Date", "Expiration Date");
                    Header.DATE2 := _PaymentReceiptDocLine."Expiration Date";

                    if "Payment Target" = "Payment Target"::General then
                        Header.DECIMAL5 := PaymentReceiptDocument."Line General Amount" - PaymentReceiptDocument."Reduction Amount 1"
                    else
                        Header.DECIMAL5 := PaymentReceiptDocument."Line Land. Arc. Amount" - PaymentReceiptDocument."Reduction Amount 2";

                    Header.TEXT6 := StrSubstNo(PaymentMethodMSG, Format(PaymentReceiptDocument."Payment Type"::OnlineCard), PaymentReceiptDocument."Payment Method Name");
                    Header.DATE3 := PaymentReceiptDocument."Payment Date";
                    Header.TEXT7 := PaymentReceiptDocument."Card Approval No.";
                    Header.Insert;
                until Next = 0;
            end;
        end;

    end;

    local procedure InsertBuffer_OnlinePayment(pAdminExpenseLedger: Record "DK_Admin. Expense Ledger"; pContract: Record DK_Contract)
    var
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    begin
        //’†Ýžß‘ª ¯€¦ —÷˜
        Header.Reset;
        Header.Init;
        Header.INTEGER0 := 1; //’†Ýžß‘ª ¯€¦ —÷˜
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
        Header."Entry No." := EntryNo;

        Header.TEXT4 := pContract."Cemetery No.";
        Header.TEXT5 := pContract."Main Customer Name";

        pContract.CalcFields("Cemetery Size");
        pAdminExpenseLedger.CalcFields("Bank Account Name", "Credit Card Comp. Name", "Document Datetime", "Aproval No.");
        Header.DECIMAL2 := pContract."Cemetery Size";

        Header.TEXT11 := _RevocationContractMgt.CalcContractPreiod(pAdminExpenseLedger."Starting Date", pAdminExpenseLedger."Ending Date");

        Header.DATE2 := pAdminExpenseLedger."Ending Date";
        Header.DECIMAL4 := pAdminExpenseLedger.Amount;
        Header.TEXT6 := StrSubstNo(PaymentMethodMSG, Format(pAdminExpenseLedger."Payment Type"), pAdminExpenseLedger.FieldCaption("Credit Card Comp. Name"));
        Header.DATETIME0 := pAdminExpenseLedger."Document Datetime";
        Header.TEXT7 := pAdminExpenseLedger."Aproval No.";
        Header.Insert;
    end;


    procedure InsertBuffer_AdminPaymentStatics(pDate: Date; pBankName: Text; pBankDescription: Text)
    var
        _CurrStartDate: Date;
        _PreStartDate: Date;
        _PreEndDate: Date;
        _DailyAmount: Decimal;
        _MonthAmount: Decimal;
        _YearAmount: Decimal;
        _Count: Decimal;
        _Decimal1: Decimal;
    begin
        EntryNo += 1;
        _CurrStartDate := CalcDate('<-CM>', pDate);
        _PreStartDate := CalcDate('<-CM>', CalcDate('<-1M>', pDate));
        _PreEndDate := CalcDate('<CM>', _PreStartDate);

        Header.Reset;
        Header.Init;
        Header.INTEGER0 := 2; //ýˆ«Š± ¯€¦ •ÔÐ
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
        Header."Entry No." := EntryNo;
        Header.TEXT8 := StrSubstNo(PaymentMethodMSG, Format(PaymentReceiptDocument."Payment Type"::Bank), pBankName);
        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL10 := _Count;
            _DailyAmount := _Decimal1;

            //Header.DECIMAL10 := PaymentReceiptDocument.COUNT;
            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //_DailyAmount := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date", pDate);
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL11 := _DailyAmount - _Decimal1;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL11 := _DailyAmount - PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end else begin
            Header.DECIMAL11 := _DailyAmount;
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Posting Date", _CurrStartDate, pDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL6 := _Count;
            _MonthAmount := _Decimal1;

            //Header.DECIMAL6 := PaymentReceiptDocument.COUNT;
            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //_MonthAmount := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date", _CurrStartDate, pDate);
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL7 := _MonthAmount - _Decimal1;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 := _MonthAmount - PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end else begin
            Header.DECIMAL7 := _MonthAmount;
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange("Posting Date", _PreStartDate, _PreEndDate);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL8 := _Count;
            _YearAmount := _Decimal1;

            //Header.DECIMAL8 := PaymentReceiptDocument.COUNT;
            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //_YearAmount := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date", _PreStartDate, _PreEndDate);
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL9 := _Decimal1;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 := _YearAmount - PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end else begin
            Header.DECIMAL9 := _YearAmount;
        end;

        Header.TEXT14 := pBankDescription;

        TotalDaliyAdminCount += Header.DECIMAL10;
        TotalDaliyAdminPayment += Header.DECIMAL11;
        TotalCurrAdminCount += Header.DECIMAL6;
        TotalCurrAdminPayment += Header.DECIMAL7;
        TotalPreAdminCount += Header.DECIMAL8;
        TotalPreAdminPayment += Header.DECIMAL9;

        Header.Insert;
    end;


    procedure InsertBuffer_AdminPaymentStaticsMethod(pDate: Date; pPaymentType: Text; pMethodName: Text; var pTotalDaliyAdminCount: Decimal; var pTotalDaliyAdminPayment: Decimal; var pTotalCurrAdminCount: Decimal; var pTotalCurrAdminPayment: Decimal; var pTotalPreAdminCount: Decimal; var pTotalPreAdminPayment: Decimal)
    var
        _CurrStartDate: Date;
        _PreStartDate: Date;
        _PreEndDate: Date;
        _DailyAmount: Decimal;
        _MonthAmount: Decimal;
        _YearAmount: Decimal;
        _Count: Decimal;
        _Decimal1: Decimal;
    begin
        EntryNo += 1;
        _CurrStartDate := CalcDate('<-CM>', pDate);
        _PreStartDate := CalcDate('<-CM>', CalcDate('<-1M>', pDate));
        _PreEndDate := CalcDate('<CM>', _PreStartDate);

        Header.Reset;
        Header.Init;
        Header.INTEGER0 := 2; //ýˆ«Š± ¯€¦ •ÔÐ
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
        Header."Entry No." := EntryNo;
        Header.TEXT8 := StrSubstNo(PaymentMethodMSG, pPaymentType, pMethodName);

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Posting Date", pDate);
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL10 := _Count;
            Header.DECIMAL11 := _Decimal1;

            //Header.DECIMAL10 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL11 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Payment Completion Date", pDate);
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL11 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL11 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Posting Date", _CurrStartDate, pDate);
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL6 := _Count;
            Header.DECIMAL7 := _Decimal1;

            //Header.DECIMAL6 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Payment Completion Date", _CurrStartDate, pDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL7 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL7 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        _Count := 0;
        _Decimal1 := 0;

        PaymentReceiptDocument.SetRange("Payment Completion Date");
        PaymentReceiptDocument.SetRange("Target Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Posting Date", _PreStartDate, _PreEndDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpense(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Line Service Amount");

                    _Count += 1;
                    _Decimal1 += (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            Header.DECIMAL8 := _Count;
            Header.DECIMAL9 := _Decimal1;

            //Header.DECIMAL8 := PaymentReceiptDocument.COUNT;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 := PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        PaymentReceiptDocument.SetRange("Posting Date");
        PaymentReceiptDocument.SetRange("Line Admin. Expense");
        PaymentReceiptDocument.SetFilter("Target Line Admin. Expense", '<>%1', 0);
        PaymentReceiptDocument.SetRange("Payment Completion Date", _PreStartDate, _PreEndDate);
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Refund);
        if PaymentReceiptDocument.FindSet then begin
            repeat
                if (CheckHonorAdminExpenseRefund(PaymentReceiptDocument)) or
                  (StrPos(PaymentReceiptDocument."Supervise No.", 'H') = 0) then begin
                    PaymentReceiptDocument.CalcFields("Target Line Service Amount");

                    Header.DECIMAL9 -= (PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Target Line Service Amount" -
                                  PaymentReceiptDocument."Reduction Amount");
                end;
            until PaymentReceiptDocument.Next = 0;

            //PaymentReceiptDocument.CALCSUMS("Final Amount","Reduction Amount");
            //Header.DECIMAL9 -= PaymentReceiptDocument."Final Amount" - PaymentReceiptDocument."Reduction Amount";
        end;

        pTotalDaliyAdminCount += Header.DECIMAL10;
        pTotalDaliyAdminPayment += Header.DECIMAL11;
        pTotalCurrAdminCount += Header.DECIMAL6;
        pTotalCurrAdminPayment += Header.DECIMAL7;
        pTotalPreAdminCount += Header.DECIMAL8;
        pTotalPreAdminPayment += Header.DECIMAL9;

        Header.Insert;
    end;


    procedure InsertBuffer_TotalAdminPayment(pMethodName: Text; pTotalDailyAdminCount: Decimal; pTotalDailyAdminPayment: Decimal; pTotalCurrAdminCount: Decimal; pTotalCurrAdminPayment: Decimal; pTotalPreAdminCount: Decimal; pTotalPreAdminPayment: Decimal)
    begin
        EntryNo += 1;

        Header.Reset;
        Header.Init;
        Header.INTEGER0 := 2; //ýˆ«Š± ¯€¦ •ÔÐ
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Admin. Expense Daily Report";
        Header."Entry No." := EntryNo;

        Header.TEXT8 := pMethodName;
        Header.DECIMAL10 := pTotalDailyAdminCount;
        Header.DECIMAL11 := pTotalDailyAdminPayment;
        Header.DECIMAL6 := pTotalCurrAdminCount;
        Header.DECIMAL7 := pTotalCurrAdminPayment;
        Header.DECIMAL8 := pTotalPreAdminCount;
        Header.DECIMAL9 := pTotalPreAdminPayment;
        Header.INTEGER2 := 1;

        Header.Insert;
    end;

    local procedure "-----------------#2112"()
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
                _PaymentReceiptDocument.Reset;
                _PaymentReceiptDocument.CalcFields("Line Admin. Expense", Refund);
                _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
                _PaymentReceiptDocument.SetRange("Contract No.", pPaymentReceiptDocument."Contract No.");
                _PaymentReceiptDocument.SetRange(Posted, true);
                _PaymentReceiptDocument.SetFilter("Posting Date", '<%1', _PaymentReceiptDocument."Posting Date");
                _PaymentReceiptDocument.SetRange("Missing Contract", false);
                _PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
                _PaymentReceiptDocument.SetRange(Refund, false);
                _PaymentReceiptDocument.SetCurrentKey("Payment Date");
                if not _PaymentReceiptDocument.FindFirst then
                    exit(true);
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
                if _RefundPayRecDoc.FindSet then begin
                    _PaymentReceiptDocument.Reset;
                    _PaymentReceiptDocument.CalcFields("Line Admin. Expense", Refund);
                    _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
                    _PaymentReceiptDocument.SetRange("Contract No.", pPaymentReceiptDocument."Contract No.");
                    _PaymentReceiptDocument.SetRange(Posted, true);
                    _PaymentReceiptDocument.SetFilter("Posting Date", '<%1', _RefundPayRecDoc."Posting Date");
                    _PaymentReceiptDocument.SetRange("Missing Contract", false);
                    _PaymentReceiptDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
                    _PaymentReceiptDocument.SetRange(Refund, false);
                    _PaymentReceiptDocument.SetCurrentKey("Payment Date");
                    if not _PaymentReceiptDocument.FindFirst then
                        exit(true);
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
        // Ž–‚šŠ•µ ‘ñ€¯ ýˆ«Š± Š±€‚ (¯€¦)
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
                  (pPayRecDoc."Line Admin. Expense" <> 0) and
                  (pPayRecDoc."Payment Type" <> pPayRecDoc."Payment Type"::DebtRelief) then
                    exit(true);
        end;

        exit(false);
    end;

    local procedure CheckHonorAdminExpenseRefund(pPayRecDoc: Record "DK_Payment Receipt Document"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _Contract: Record DK_Contract;
        _PayRecDocument: Record "DK_Payment Receipt Document";
    begin
        // Ž–‚šŠ•µ ‘ñ€¯ ýˆ«Š± Š±€‚ (˜»Š­)
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
                _PayRecDocument.Reset;
                _PayRecDocument.CalcFields("Line Admin. Expense");
                _PayRecDocument.SetRange("Document No.", pPayRecDoc."Target Doc. No.");
                _PayRecDocument.SetRange("New Admin. Expense", false);
                _PayRecDocument.SetFilter("Line Admin. Expense", '<>%1', 0);
                _PayRecDocument.SetFilter("Payment Type", '<>%1', _PayRecDocument."Payment Type"::DebtRelief);
                if _PayRecDocument.FindSet then
                    exit(true);
            end;
        end;

        exit(false);
    end;
}

