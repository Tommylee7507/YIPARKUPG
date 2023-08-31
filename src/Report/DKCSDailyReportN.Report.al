report 50047 "DK_CS Daily Report N"
{
    // //°°ýˆ«Œ­ ŸŸŠˆ×
    // *DK34: 20201118
    //   - INTEGER0 : ReportType
    //   - 0: ýˆ«Š± / 1: ‰ª‘÷ Œ¡Š±Š / 2: €Ë•ˆ ˆ•“Ë / 3: €Ë•ˆ Œ¡Š±Š / 4: „“— Î‡š
    // 
    //   - INTEGER1 : ReportKey1
    //   - 0: Ÿ‰¦ ýˆ«Š±, ‰ª‘÷ Œ¡Š±Š, €Ë•ˆˆ•“Ë, €Ë•ˆŒ¡Š±Š, „“— Î‡š / 1: ‘†µ ýˆ«Š±, ‚‹Ÿ— Î‡š / 2: Ž–‚šŠ•µ ýˆ«Š±
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú #1996: 2020-07-06
    //   - Modify Function: Insert_AdminExpensesSolomon
    //   - Modify OnPreReport: Insert_AdminExpenses Function Filter Modify(Filter: <>A -> B|C|D|E)
    // 
    // DK34: 20201102
    //   - Re-Create
    // 
    // DK34: 20201207
    //   - Modify Function: Insert_CemeteryServices
    // 
    // #2314: 20201229
    //   - Modify Function: Insert_AdminExpDelayIntAmount, Insert_AdminExpensesNew, Insert_AdminExpDelayAmount
    // 
    // #2330: 20210107
    //   - Modify Layout: “©ˆ•“Ë —³Ðí €Ë•ˆˆ•“Ë —³Ð “Èí
    // 
    // #2351: 20210112
    //   - Modify Layout: ¼ú ýˆ«Š± „Ð ‡õ‡ž ž—© Œ÷‘ñ
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCSDailyReportN.rdl';

    Caption = 'CS Daily Report';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            UseTemporary = true;
            column(EntryNo; "Entry No.")
            {
            }
            column(CategoryName; TEXT0)
            {
            }
            column(ReportType; INTEGER0)
            {
            }
            column(ReportKey1; INTEGER1)
            {
            }
            column(DailyCnt; INTEGER2)
            {
            }
            column(DailyAmt; DECIMAL0)
            {
            }
            column(MonthCnt; INTEGER3)
            {
            }
            column(MonthAmt; DECIMAL1)
            {
            }
            column(MonthTarget; DECIMAL2)
            {
            }
            column(MonthRateTxt; TEXT1)
            {
            }
            column(YearCnt; INTEGER4)
            {
            }
            column(YearAmt; DECIMAL4)
            {
            }
            column(YearTarget; DECIMAL5)
            {
            }
            column(YearRateTxt; TEXT2)
            {
            }
            column(Today; ReferenceDate)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TabTitle; TabTitle)
            {
            }
            column(TodayFunTempAnchi; TodayFuneralCnt[1])
            {
            }
            column(TodayFunAnchi; TodayFuneralCnt[2])
            {
            }
            column(TodayFunMaejang; TodayFuneralCnt[3])
            {
            }
            column(TodayFunYeejang; TodayFuneralCnt[4])
            {
            }
            column(TomoFunTempAnchi; TomorrowFuneralcnt[1])
            {
            }
            column(TomoFunAnch; TomorrowFuneralcnt[2])
            {
            }
            column(TomoFunMaejang; TomorrowFuneralcnt[3])
            {
            }
            column(TomoFunYeejang; TomorrowFuneralcnt[4])
            {
            }
            column(GeneralTotalDailyCnt; TotalDailyCnt[1])
            {
            }
            column(LandTotalDailyCnt; TotalDailyCnt[2])
            {
            }
            column(HonoTotalDailyCnt; TotalDailyCnt[3])
            {
            }
            column(ServiceTotalDailyCnt; TotalDailyCnt[4])
            {
            }
            column(OtherTotalDailyCnt; TotalDailyCnt[5])
            {
            }
            column(OtherSaleTotalDailyCnt; TotalDailyCnt[6])
            {
            }
            column(GeneralTotalDailyAmt; TotalDailyAmt[1])
            {
            }
            column(LandTotalDailyAmt; TotalDailyAmt[2])
            {
            }
            column(HonoTotalDailyAmt; TotalDailyAmt[3])
            {
            }
            column(ServiceTotalDailyAmt; TotalDailyAmt[4])
            {
            }
            column(OtherTotalDailyAmt; TotalDailyAmt[5])
            {
            }
            column(OtherSaleTotalDailyAmt; TotalDailyAmt[6])
            {
            }
            column(GeneralTotalMonthCnt; TotalMonthCnt[1])
            {
            }
            column(LandTotalMonthCnt; TotalMonthCnt[2])
            {
            }
            column(HonoTotalMonthCnt; TotalMonthCnt[3])
            {
            }
            column(ServiceTotalMonthCnt; TotalMonthCnt[4])
            {
            }
            column(OtherTotalMonthCnt; TotalMonthCnt[5])
            {
            }
            column(OtherSaleTotalMonthCnt; TotalMonthCnt[6])
            {
            }
            column(GeneralTotalMonthAmt; TotalMonthAmt[1])
            {
            }
            column(LandTotalMonthAmt; TotalMonthAmt[2])
            {
            }
            column(HonoTotalMonthAmt; TotalMonthAmt[3])
            {
            }
            column(ServiceTotalMonthAmt; TotalMonthAmt[4])
            {
            }
            column(OtherTotalMonthAmt; TotalMonthAmt[5])
            {
            }
            column(OtherSaleTotalMonthAmt; TotalMonthAmt[6])
            {
            }
            column(GeneralTotalMonthTarget; TotalMonthTarget[1])
            {
            }
            column(LandTotalMonthTarget; TotalMonthTarget[2])
            {
            }
            column(HonoTotalMonthTarget; TotalMonthTarget[3])
            {
            }
            column(ServiceTotalMonthTarget; TotalMonthTarget[4])
            {
            }
            column(OtherTotalMonthTarget; TotalMonthTarget[5])
            {
            }
            column(GeneralTotalMonthRate; TotalMonthRate[1])
            {
            }
            column(LandTotalMonthRate; TotalMonthRate[2])
            {
            }
            column(HonoTotalMonthRate; TotalMonthRate[3])
            {
            }
            column(ServiceTotalMonthRate; TotalMonthRate[4])
            {
            }
            column(OtherTotalMonthRate; TotalMonthRate[5])
            {
            }
            column(GeneralTotalYearCnt; TotalYearCnt[1])
            {
            }
            column(LandTotalYearCnt; TotalYearCnt[2])
            {
            }
            column(HonoTotalYearCnt; TotalYearCnt[3])
            {
            }
            column(ServiceTotalYearCnt; TotalYearCnt[4])
            {
            }
            column(OtherTotalYearCnt; TotalYearCnt[5])
            {
            }
            column(OtherSaleTotalYearCnt; TotalYearCnt[6])
            {
            }
            column(GeneralTotalYearAmt; TotalYearAmt[1])
            {
            }
            column(LandTotalYearAmt; TotalYearAmt[2])
            {
            }
            column(HonoTotalYearAmt; TotalYearAmt[3])
            {
            }
            column(ServiceTotalYearAmt; TotalYearAmt[4])
            {
            }
            column(OtherTotalYearAmt; TotalYearAmt[5])
            {
            }
            column(OtherSaleTotalYearAmt; TotalYearAmt[6])
            {
            }
            column(GeneralTotalYearTarget; TotalYearTarget[1])
            {
            }
            column(LandTotalYearTarget; TotalYearTarget[2])
            {
            }
            column(HonoTotalYearTarget; TotalYearTarget[3])
            {
            }
            column(ServiceTotalYearTarget; TotalYearTarget[4])
            {
            }
            column(OtherTotalYearTarget; TotalYearTarget[5])
            {
            }
            column(GeneralTotalYearRate; TotalYearRate[1])
            {
            }
            column(LandTotalYearRate; TotalYearRate[2])
            {
            }
            column(HonoTotalYearRate; TotalYearRate[3])
            {
            }
            column(ServiceTotalYearRate; TotalYearRate[4])
            {
            }
            column(OtherTotalYearRate; TotalYearRate[5])
            {
            }
            column(AdminTotalMonthRate; TotalMonthRate[6])
            {
            }
            column(AdminTotalYearRate; TotalYearRate[6])
            {
            }
            column(AdminServTotalMonthRate; TotalMonthRate[7])
            {
            }
            column(AdminServTotalYearRate; TotalYearRate[7])
            {
            }
            column(AdminServOthTotalMonthRate; TotalMonthRate[8])
            {
            }
            column(AdminServOthTotalYearRate; TotalYearRate[8])
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ReferenceDate; ReferenceDate)
                {
                    Caption = 'Reference Date';

                    trigger OnValidate()
                    begin
                        ReferenceDate_Onvalidate;
                    end;
                }
                field(TabTitle; TabTitle)
                {
                    Caption = 'Tab Title';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            ReferenceDate := WorkDate;
        end;
    }

    labels
    {
        Title01lb = 'Custom Center Daily Report';
        Cap01lb = 'Reference Date';
        Cap02lb = 'Employee';
        Cap03lb = 'Type';
        Cap04lb = 'Day';
        Cap05lb = 'Month';
        Cap06lb = 'Year';
        Cap07lb = 'Count';
        Cap08lb = 'Amount';
        Cap09lb = 'Target';
        Cap10lb = 'Rate';
        Cap11lb = 'Admin Expense';
        Cap12lb = 'General';
        Cap13lb = 'Landscape';
        Cap14lb = 'Honostone';
        Cap15lb = 'Œ¡Š±Š';
        Cap16lb = 'Other';
        Cap17lb = 'Sum';
        Cap18lb = 'Total';
        Cap20lb = 'Cemetery';
        Cap21lb = 'Admin Expense Total';
        Cap22lb = 'Total';
        Cap23lb = 'Total';
        Cap24lb = 'Today';
        Cap25lb = 'Tomorrow';
        Cap26lb = 'Anchi';
        Cap27lb = 'Maejang';
        Cap28lb = 'yeejang';
        Cap29lb = 'ritual romm';
        Cap30lb = 'Other Amount';
    }

    trigger OnPreReport()
    var
        _Employee: Record DK_Employee;
        _I: Integer;
        _TotalAmt: Decimal;
        _TotalTarget: Decimal;
    begin
        Clear(EmployeeName);
        Clear(MonthStartDate);
        Clear(YearStartDate);
        Clear(TodayFuneralCnt);
        Clear(TomorrowFuneralcnt);
        Clear(TotalDailyCnt);
        Clear(TotalDailyAmt);
        Clear(TotalMonthCnt);
        Clear(TotalMonthAmt);
        Clear(TotalMonthTarget);
        Clear(TotalMonthRate);
        Clear(TotalYearCnt);
        Clear(TotalYearAmt);
        Clear(TotalYearTarget);
        Clear(TotalYearRate);

        MonthStartDate := CalcDate('<-CM>', ReferenceDate);
        if Date2DMY(ReferenceDate, 2) = 12 then
            YearStartDate := CalcDate('<-CM>', ReferenceDate)
        else
            YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));

        OBJECTID := '50047';  //REPORT::"DK_CS Daily Report"

        if GuiAllowed then
            Window.Open(
              MSG100);

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindFirst then
            EmployeeName := _Employee.Name;

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', 0, 7));

        // ------------------------------------------------ Ÿ‰¦ ýˆ«Š±

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '1) Ÿ‰¦ ýˆ«Š±', 7));

        Insert_AdminExpensesNew(0);         // Ÿ‰¦ ýˆ«Š± - •€¯
        Insert_AdminExpRegular(0);          // Ÿ‰¦ ýˆ«Š± - ‘ñ€¯Š¨
        Insert_AdminExpArrears(0);          // Ÿ‰¦ ýˆ«Š± - ‰œ‚‚Š¨
        Insert_AdminExpLitigation(0);       // Ÿ‰¦ ýˆ«Š± - ŒÁ‰½“È™
        //Insert_AdminExpDelayIntAmount(0);   // Ÿ‰¦ ýˆ«Š± - ŒÁ‰½€Ë•ˆ
        Insert_RefundPayment(0);            // Ÿ‰¦ ýˆ«Š± - ˜»Š­ (ˆ±—Ñ Ž°)

        // ------------------------------------------------ ‘†µ ýˆ«Š±

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '2) ‘†µ ýˆ«Š±', 7));

        Insert_AdminExpensesNew(1);         // ‘†µ ýˆ«Š± - •€¯
        Insert_AdminExpRegular(1);          // ‘†µ ýˆ«Š± - ‘ñ€¯Š¨
        Insert_AdminExpArrears(1);          // ‘†µ ýˆ«Š± - ‰œ‚‚Š¨
        Insert_AdminExpLitigation(1);       // ‘†µ ýˆ«Š± - ŒÁ‰½“È™
        //Insert_AdminExpDelayIntAmount(1);   // ‘†µ ýˆ«Š± - ŒÁ‰½€Ë•ˆ
        Insert_RefundPayment(1);            // ‘†µ ýˆ«Š± - ˜»Š­ (ˆ±—Ñ Ž°)

        // ------------------------------------------------ Ž–‚šŠ•µ ýˆ«Š±

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '3) Ž–‚šŠ•µ ýˆ«Š±', 7));

        Insert_AdminExpensesNew(2);         // Ž–‚šŠ•µ ýˆ«Š± - •€¯
        Insert_AdminExpRegular(2);          // Ž–‚šŠ•µ ýˆ«Š± - ‘ñ€¯Š¨
        Insert_AdminExpArrears(2);          // Ž–‚šŠ•µ ýˆ«Š± - ‰œ‚‚Š¨
        Insert_AdminExpLitigation(2);       // Ž–‚šŠ•µ ýˆ«Š± - ŒÁ‰½“È™
        //Insert_AdminExpDelayIntAmount(2);   // Ž–‚šŠ•µ ýˆ«Š± - ŒÁ‰½€Ë•ˆ
        Insert_RefundPayment(2);            // Ž–‚šŠ•µ ýˆ«Š± - ˜»Š­ (ˆ±—Ñ Ž°)

        // ------------------------------------------------ ‰ª‘÷Œ¡Š±Š
        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '4) ‰ª‘÷Œ¡Š±Š', 7));

        Insert_CemeteryServices;            // ‰ª‘÷Œ¡Š±Š
        Insert_RefundPayment(3);            // ‰ª‘÷Œ¡Š±Š - ˜»Š­ (ˆ±—Ñ Ž°)

        // ------------------------------------------------ €Ë•ˆ ˆ•“Ë
        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '5) €Ë•ˆˆ•“Ë', 7));

        Insert_AdminExpDelayAmount;

        // ------------------------------------------------ €Ë•ˆŒ¡Š±Š
        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '5) €Ë•ˆŒ¡Š±Š', 7));

        if TabTitle <> '' then  // ‘ªˆ± —š…Îí ¯‡’ …—Ž·‹ µÕíˆˆ …Ñœ• ‘†˜ˆ
            Insert_OtherServices; // €Ë•ˆŒ¡Š±Š

        // ------------------------------------------------ „“— Î‡š
        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', '6) „“— Î‡š', 7));

        Insert_TodayFuneral(0, TodayFuneralCnt);   // „“— Î‡š

        Insert_TodayFuneral(1, TomorrowFuneralcnt);   // ‚‹Ÿ— Î‡š

        // ------------------------------------------------ „Ð „ÃŒŠ‡ý

        for _I := 1 to 5 do begin
            if TotalMonthTarget[_I] <> 0 then
                TotalMonthRate[_I] := StrSubstNo(PersantageMSG, Round((TotalMonthAmt[_I] / TotalMonthTarget[_I] * 100), 0.1, '='));

            if TotalYearTarget[_I] <> 0 then
                TotalYearRate[_I] := StrSubstNo(PersantageMSG, Round((TotalYearAmt[_I] / TotalYearTarget[_I] * 100), 0.1, '='));
        end;

        // ------------------------------------------------- “© ýˆ«Š±(Ÿ‰¦+‘†µ+Ž–‚šŠ•µ) „ÃŒŠ‡ý
        _TotalAmt := TotalMonthAmt[1] + TotalMonthAmt[2] + TotalMonthAmt[3];
        _TotalTarget := TotalMonthTarget[1] + TotalMonthTarget[2] + TotalMonthTarget[3];

        if _TotalTarget <> 0 then
            TotalMonthRate[6] := StrSubstNo(PersantageMSG, Round((_TotalAmt / _TotalTarget * 100), 0.1, '='));

        Clear(_TotalAmt);
        Clear(_TotalTarget);

        _TotalAmt := TotalYearAmt[1] + TotalYearAmt[2] + TotalYearAmt[3];
        _TotalTarget := TotalYearTarget[1] + TotalYearTarget[2] + TotalYearTarget[3];

        if _TotalTarget <> 0 then
            TotalYearRate[6] := StrSubstNo(PersantageMSG, Round((_TotalAmt / _TotalTarget * 100), 0.1, '='));

        // ------------------------------------------------- “© —³Ð(Ÿ‰¦+‘†µ+Ž–‚šŠ•µ+‰ª‘÷Œ¡Š±Š+€Ë•ˆˆ•“Ë) „ÃŒŠ‡ý
        Clear(_TotalAmt);
        Clear(_TotalTarget);

        _TotalAmt := TotalMonthAmt[1] + TotalMonthAmt[2] + TotalMonthAmt[3] + TotalMonthAmt[4] + TotalMonthAmt[6];
        _TotalTarget := TotalMonthTarget[1] + TotalMonthTarget[2] + TotalMonthTarget[3] + TotalMonthTarget[4];

        if _TotalTarget <> 0 then
            TotalMonthRate[7] := StrSubstNo(PersantageMSG, Round((_TotalAmt / _TotalTarget * 100), 0.1, '='));

        Clear(_TotalAmt);
        Clear(_TotalTarget);

        _TotalAmt := TotalYearAmt[1] + TotalYearAmt[2] + TotalYearAmt[3] + TotalYearAmt[4] + TotalYearAmt[6];
        _TotalTarget := TotalYearTarget[1] + TotalYearTarget[2] + TotalYearTarget[3] + TotalYearTarget[4];

        if _TotalTarget <> 0 then
            TotalYearRate[7] := StrSubstNo(PersantageMSG, Round((_TotalAmt / _TotalTarget * 100), 0.1, '='));

        // ------------------------------------------------- “© ˆ•“Ë(Ÿ‰¦+‘†µ+Ž–‚šŠ•µ+‰ª‘÷Œ¡Š±Š+€Ë•ˆŒ¡Š±Š+€Ë•ˆˆ•“Ë) „ÃŒŠ‡ý
        Clear(_TotalAmt);
        Clear(_TotalTarget);

        _TotalAmt := TotalMonthAmt[1] + TotalMonthAmt[2] + TotalMonthAmt[3] + TotalMonthAmt[4] + TotalMonthAmt[5] + TotalMonthAmt[6];
        _TotalTarget := TotalMonthTarget[1] + TotalMonthTarget[2] + TotalMonthTarget[3] + TotalMonthTarget[4] + TotalMonthTarget[5];

        if _TotalTarget <> 0 then
            TotalMonthRate[8] := StrSubstNo(PersantageMSG, Round((_TotalAmt / _TotalTarget * 100), 0.1, '='));

        Clear(_TotalAmt);
        Clear(_TotalTarget);

        _TotalAmt := TotalYearAmt[1] + TotalYearAmt[2] + TotalYearAmt[3] + TotalYearAmt[4] + TotalYearAmt[5] + TotalYearAmt[6];
        _TotalTarget := TotalYearTarget[1] + TotalYearTarget[2] + TotalYearTarget[3] + TotalYearTarget[4] + TotalYearTarget[5];

        if _TotalTarget <> 0 then
            TotalYearRate[8] := StrSubstNo(PersantageMSG, Round((_TotalAmt / _TotalTarget * 100), 0.1, '='));

        if GuiAllowed then
            Window.Close;
    end;

    var
        ReferenceDate: Date;
        TabTitle: Text;
        EntryNo: Integer;
        MonthStartDate: Date;
        YearStartDate: Date;
        EmployeeName: Text;
        NewMSG: Label 'New';
        RegularMSG: Label 'Regular';
        UnpaidMSG: Label 'Unpaid';
        SolomonMSG: Label 'Solomon';
        MSG001: Label 'Reference Date cannot be empty';
        MSG002: Label 'You cannot enter a date greater than today.';
        Window: Dialog;
        MSG100: Label 'Processing ReceiptDocument   #1############\';
        RefundMSG: Label '˜»Š­';
        OBJECTID: Code[20];
        LitigationMSG: Label 'Litigation';
        DelayIntAmtMSG: Label 'ŒÁ‰½€Ë•ˆ';
        OtherServiceMSG: Label 'Other Service';
        TodayFuneralCnt: array[5] of Decimal;
        TomorrowFuneralcnt: array[5] of Decimal;
        TotalDailyCnt: array[100] of Integer;
        TotalDailyAmt: array[100] of Decimal;
        TotalMonthCnt: array[100] of Integer;
        TotalMonthAmt: array[100] of Decimal;
        TotalMonthTarget: array[100] of Decimal;
        TotalMonthRate: array[100] of Text;
        TotalYearCnt: array[100] of Integer;
        TotalYearAmt: array[100] of Decimal;
        TotalYearTarget: array[100] of Decimal;
        TotalYearRate: array[100] of Text;
        PersantageMSG: Label '%1 %';
        CustDelayIntAmtMSG: Label '×„ŒŽ• €Ë•ˆ';

    local procedure Insert_AdminExpensesNew(pAdminType: Option General,LandScape,Honostone)
    var
        _Contract: Record DK_Contract;
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _KPITargetLine: Record "DK_KPI Target Line";
        _Cemetery: Record DK_Cemetery;
        _Estate: Record DK_Estate;
        _Count: Integer;
        _Amount: Decimal;
    begin
        //•€¯Š¨
        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := NewMSG;

        _Contract.Reset;
        _Contract.SetFilter(Status, '%1|%2', _Contract.Status::FullPayment, _Contract.Status::Revocation);
        _Contract.SetCurrentKey(Status, "Rem. Amount Posting Date");
        case pAdminType of
            pAdminType::General:
                begin

                    Header.INTEGER0 := 0; // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 0; // ReportKey1 : Ÿ‰¦ ýˆ«Š±
                    _Contract.SetFilter("General Amount", '<>%1', 0);
                    _Contract.SetFilter("Supervise No.", '<>H*');
                    // -----------Ÿú
                    _Contract.SetRange("Rem. Amount Posting Date", ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("General Amount");

                        Header.INTEGER2 := _Contract.Count;
                        Header.DECIMAL0 := _Contract."General Amount";
                    end;
                    // -----------õú
                    _Contract.SetRange("Rem. Amount Posting Date", MonthStartDate, ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("General Amount");

                        Header.INTEGER3 := _Contract.Count;
                        Header.DECIMAL1 := _Contract."General Amount";
                    end;
                    // -----------¼ú
                    _Contract.SetRange("Rem. Amount Posting Date", YearStartDate, ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("General Amount");

                        Header.INTEGER4 := _Contract.Count;
                        Header.DECIMAL4 := _Contract."General Amount";
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '001');   // Ÿ‰¦ ýˆ«Š± - •€¯
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[1] += Header.INTEGER2;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER3;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalMonthTarget[1] += Header.DECIMAL2;
                    TotalYearCnt[1] += Header.INTEGER4;
                    TotalYearAmt[1] += Header.DECIMAL4;
                    TotalYearTarget[1] += Header.DECIMAL5;
                end;
            pAdminType::LandScape:
                begin
                    Header.INTEGER0 := 0; // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 1; // ReportKey1 : ‘†µ ýˆ«Š±
                    _Contract.SetFilter("Landscape Arc. Amount", '<>%1', 0);
                    _Contract.SetFilter("Supervise No.", '<>H*');

                    // -----------Ÿú
                    _Contract.SetRange("Rem. Amount Posting Date", ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("Landscape Arc. Amount");

                        Header.INTEGER2 := _Contract.Count;
                        Header.DECIMAL0 := _Contract."Landscape Arc. Amount";
                    end;

                    // -----------õú
                    _Contract.SetRange("Rem. Amount Posting Date", MonthStartDate, ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("Landscape Arc. Amount");

                        Header.INTEGER3 := _Contract.Count;
                        Header.DECIMAL1 := _Contract."Landscape Arc. Amount";
                    end;

                    // -----------¼ú
                    _Contract.SetRange("Rem. Amount Posting Date", YearStartDate, ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("Landscape Arc. Amount");

                        Header.INTEGER4 := _Contract.Count;
                        Header.DECIMAL4 := _Contract."Landscape Arc. Amount";
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '006');   // ‘†µ ýˆ«Š± - •€¯
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[2] += Header.INTEGER2;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER3;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalMonthTarget[2] += Header.DECIMAL2;
                    TotalYearCnt[2] += Header.INTEGER4;
                    TotalYearAmt[2] += Header.DECIMAL4;
                    TotalYearTarget[2] += Header.DECIMAL5;
                end;
            pAdminType::Honostone:
                begin
                    Header.INTEGER0 := 0; // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 2; // ReportKey1 : Ž–‚šŠ•µ ýˆ«Š±
                    _PayRecDoc.Reset;
                    _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SetRange(Posted, true);
                    _PayRecDoc.SetFilter("Supervise No.", 'H*');
                    _PayRecDoc.SetRange("Missing Contract", false);
                    _PayRecDoc.SetRange("New Admin. Expense", true);   // •€¯ ýˆ«Š±

                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '011');   // Ž–‚šŠ•µ ýˆ«Š± - •€¯
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;



                    // -----------„Ð
                    TotalDailyCnt[3] += Header.INTEGER2;
                    TotalDailyAmt[3] += Header.DECIMAL0;
                    TotalMonthCnt[3] += Header.INTEGER3;
                    TotalMonthAmt[3] += Header.DECIMAL1;
                    TotalMonthTarget[3] += Header.DECIMAL2;
                    TotalYearCnt[3] += Header.INTEGER4;
                    TotalYearAmt[3] += Header.DECIMAL4;
                    TotalYearTarget[3] += Header.DECIMAL5;
                end;
        end;

        // -----------‘°……
        // õú ‘°……
        if Header.DECIMAL2 <> 0 then
            Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
        // ¼ú ‘°……
        if Header.DECIMAL5 <> 0 then
            Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

        Header.Insert;
    end;

    local procedure Insert_CemeteryServices()
    var
        _CemeteryServices: Record "DK_Cemetery Services";
        _AnchiCemeteryServices: Record "DK_Cemetery Services";
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        _MoveMSG: Label 'Total Move The Grave';
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _KPITargetLine: Record "DK_KPI Target Line";
        _ReportTargetValue: Record "DK_Report Target Value";
    begin
        // ‰ª‘÷ Œ¡Š±Š
        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetRange(Blocked, false);
        _FieldWorkMainCategory.SetRange("Cemetery Services", true);
        //_FieldWorkMainCategory.SETRANGE("Other Services",FALSE);
        _FieldWorkMainCategory.SetFilter(Code, '<>%1&<>%2', '908', '999');      // œÎ,€Ë•ˆ ‘ªÂ—© ‰ª‘÷Œ¡Š±Š
        _FieldWorkMainCategory.SetCurrentKey(Blocked, "Cemetery Services", "Other Services", Code);
        if _FieldWorkMainCategory.FindSet then begin
            repeat
                EntryNo += 1;
                Header.Init;
                //// Header."OBJECT ID" := REPORT::Report50035;
                Header."USER ID" := UserId;
                Header."Entry No." := EntryNo;
                Header.INTEGER0 := 1;     // ReportType : ‰ª‘÷Œ¡Š±Š
                Header.INTEGER1 := 0;     // ReportKey1 : ‰ª‘÷Œ¡Š±Š
                Header.TEXT0 := _FieldWorkMainCategory.Name;

                // ------------------------------------- “´“š Ž˜”í ----------------------------------
                if _FieldWorkMainCategory.Code = '015' then begin
                    _CemeteryServices.Reset;
                    _CemeteryServices.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                    _CemeteryServices.SetRange("Field Work Sub Cat. Code", '007');
                    _CemeteryServices.SetFilter(Status, '<>%1', _CemeteryServices.Status::Open);
                    _CemeteryServices.SetCurrentKey("Field Work Main Cat. Code", Status);
                    if _CemeteryServices.FindSet then begin
                        // -----------Ÿú
                        _CemeteryServices.SetRange("Work Date", ReferenceDate);
                        if _CemeteryServices.FindSet then begin
                            _CemeteryServices.CalcSums("Receipt Amount");
                            Header.INTEGER2 += _CemeteryServices.Count;
                            Header.DECIMAL0 += _CemeteryServices."Receipt Amount";
                        end;
                        // -----------õú
                        _CemeteryServices.SetRange("Work Date", MonthStartDate, ReferenceDate);
                        if _CemeteryServices.FindSet then begin
                            _CemeteryServices.CalcSums("Receipt Amount");
                            Header.INTEGER3 += _CemeteryServices.Count;
                            Header.DECIMAL1 += _CemeteryServices."Receipt Amount";
                        end;
                        // -----------Ÿú
                        _CemeteryServices.SetRange("Work Date", YearStartDate, ReferenceDate);
                        if _CemeteryServices.FindSet then begin
                            _CemeteryServices.CalcSums("Receipt Amount");
                            Header.INTEGER4 += _CemeteryServices.Count;
                            Header.DECIMAL4 += _CemeteryServices."Receipt Amount";
                        end;
                    end;
                end;
                // -------------------------------------------------------------------------------
                // ------------------------------------- Ÿ‰¦ ‰ª‘÷ Œ¡Š±Š --------------------------

                _PaymentReceiptDocument.Reset;
                _PaymentReceiptDocument.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
                _PaymentReceiptDocument.CalcFields("Line Service Amount");
                _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
                _PaymentReceiptDocument.SetRange(Posted, true);
                _PaymentReceiptDocument.SetRange("Missing Contract", false);
                _PaymentReceiptDocument.SetRange("New Admin. Expense", false);
                _PaymentReceiptDocument.SetFilter("Line Service Amount", '<>%1', 0);
                _PaymentReceiptDocument.SetRange("Posting Date", YearStartDate, ReferenceDate);
                if _PaymentReceiptDocument.FindSet then begin
                    repeat
                        _PaymentReceiptDocument.CalcFields(Refund);
                        _PaymentReceiptDocLine.Reset;
                        _PaymentReceiptDocLine.CalcFields("Field Work Main Cat. Code");
                        _PaymentReceiptDocLine.SetRange("Document No.", _PaymentReceiptDocument."Document No.");
                        _PaymentReceiptDocLine.SetFilter("Cem. Services No.", '<>%1', '');
                        _PaymentReceiptDocLine.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                        if _PaymentReceiptDocLine.FindSet then begin
                            repeat
                                // -----------Ÿú
                                if _PaymentReceiptDocument."Posting Date" = ReferenceDate then begin
                                    if _PaymentReceiptDocument.Refund then
                                        Header.INTEGER2 += 1
                                    else begin
                                        _CemeteryServices.Reset;
                                        _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                        _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                        if _CemeteryServices.FindSet then
                                            Header.INTEGER2 += 1;
                                    end;

                                    Header.DECIMAL0 += _PaymentReceiptDocLine.Amount;
                                end;
                                // -----------õú
                                if (_PaymentReceiptDocument."Posting Date" >= MonthStartDate) and
                                  (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) then begin
                                    if _PaymentReceiptDocument.Refund then
                                        Header.INTEGER3 += 1
                                    else begin
                                        _CemeteryServices.Reset;
                                        _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                        _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                        if _CemeteryServices.FindSet then
                                            Header.INTEGER3 += 1;
                                    end;

                                    Header.DECIMAL1 += _PaymentReceiptDocLine.Amount;
                                end;
                                // -----------‚Ëú
                                if (_PaymentReceiptDocument."Posting Date" >= YearStartDate) and
                                  (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) then begin
                                    if _PaymentReceiptDocument.Refund then
                                        Header.INTEGER4 += 1
                                    else begin
                                        _CemeteryServices.Reset;
                                        _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                        _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                        if _CemeteryServices.FindSet then
                                            Header.INTEGER4 += 1;
                                    end;

                                    Header.DECIMAL4 += _PaymentReceiptDocLine.Amount;
                                end;
                            until _PaymentReceiptDocLine.Next = 0;
                        end;
                    until _PaymentReceiptDocument.Next = 0;
                end;

                // -------------------------------------------------------------------------------

                // -----------ˆ±—Ñ —ø
                _ReportTargetValue.Reset;
                _ReportTargetValue.SetRange(Blocked, false);
                _ReportTargetValue.SetRange("OBJECT ID", OBJECTID);
                _ReportTargetValue.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                if _ReportTargetValue.FindSet then begin
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", _ReportTargetValue.Code);   // ‰ª‘÷Œ¡Š±Š ˆ±—Ñ —ø
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;
                end;

                // -----------„Ð
                TotalDailyCnt[4] += Header.INTEGER2;
                TotalDailyAmt[4] += Header.DECIMAL0;
                TotalMonthCnt[4] += Header.INTEGER3;
                TotalMonthAmt[4] += Header.DECIMAL1;
                TotalMonthTarget[4] += Header.DECIMAL2;
                TotalYearCnt[4] += Header.INTEGER4;
                TotalYearAmt[4] += Header.DECIMAL4;
                TotalYearTarget[4] += Header.DECIMAL5;

                // -----------‘°……
                // õú ‘°……
                if Header.DECIMAL2 <> 0 then
                    Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
                // ¼ú ‘°……
                if Header.DECIMAL5 <> 0 then
                    Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

                Header.Insert;
            until _FieldWorkMainCategory.Next = 0;
        end;

        // ------------------------------------- €Ë•ˆ ----------------------------------
        /*
        EntryNo +=1;
        Header.INIT;
        Header."OBJECT ID" := REPORT::"DK_CS Daily Report";
        Header."USER ID" := USERID;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := OtherServiceMSG;
        Header.INTEGER0 := 1;     // ReportType : ‰ª‘÷Œ¡Š±Š
        Header.INTEGER1 := 0;     // ReportKey1 : ‰ª‘÷Œ¡Š±Š
        
        // -----------ŒÁ‰½ FALSE ‘÷¼œÀ
        
        _PaymentReceiptDocument.RESET;
        _PaymentReceiptDocument.SETCURRENTKEY("Document Type","Posting Date",Posted,"Missing Contract");
        _PaymentReceiptDocument.SETRANGE("Document Type",_PaymentReceiptDocument."Document Type"::Receipt);
        _PaymentReceiptDocument.SETRANGE(Posted,TRUE);
        _PaymentReceiptDocument.SETRANGE("Missing Contract",FALSE);
        _PaymentReceiptDocument.SETRANGE(Litigation,FALSE);
        _PaymentReceiptDocument.SETRANGE("Posting Date",YearStartDate,ReferenceDate);
        _PaymentReceiptDocument.FILTERGROUP(-1);
        _PaymentReceiptDocument.SETFILTER("Liti. Delay Interest Amount",'<>%1',0);
        _PaymentReceiptDocument.SETFILTER("Delay Interest Amount",'<>%1',0);
        IF _PaymentReceiptDocument.FINDSET THEN BEGIN
          REPEAT
            // -----------Ÿú
            IF _PaymentReceiptDocument."Posting Date" = ReferenceDate THEN BEGIN
              Header.INTEGER2 += 1;
              // —ø = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
              Header.DECIMAL0 += _PaymentReceiptDocument."Delay Interest Amount" + _PaymentReceiptDocument."Liti. Delay Interest Amount";
            END;
            // -----------õú
            IF (_PaymentReceiptDocument."Posting Date" >= MonthStartDate) AND
                      (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) THEN BEGIN
              Header.INTEGER3 += 1;
              // —ø = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
              Header.DECIMAL1 += _PaymentReceiptDocument."Delay Interest Amount" + _PaymentReceiptDocument."Liti. Delay Interest Amount";
            END;
            // -----------¼ú
            IF (_PaymentReceiptDocument."Posting Date" >= YearStartDate) AND
                      (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) THEN BEGIN
              Header.INTEGER4 += 1;
              // —ø = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
              Header.DECIMAL4 += _PaymentReceiptDocument."Delay Interest Amount" + _PaymentReceiptDocument."Liti. Delay Interest Amount";
            END;
          UNTIL _PaymentReceiptDocument.NEXT = 0;
        END;
        */

        // -----------€Ë•ˆ(999) ‰ª‘÷ Œ¡Š±Š

        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetRange(Code, '999');  // €Ë•ˆ(999) ‰ª‘÷ Œ¡Š±Š
        _FieldWorkMainCategory.SetRange(Blocked, false);
        _FieldWorkMainCategory.SetRange("Cemetery Services", true);
        //_FieldWorkMainCategory.SETRANGE("Other Services",FALSE);
        if _FieldWorkMainCategory.FindSet then begin
            EntryNo += 1;
            Header.Init;
            //// Header."OBJECT ID" := REPORT::Report50035;
            Header."USER ID" := UserId;
            Header."Entry No." := EntryNo;
            Header.TEXT0 := OtherServiceMSG;
            Header.INTEGER0 := 1;     // ReportType : ‰ª‘÷Œ¡Š±Š
            Header.INTEGER1 := 0;     // ReportKey1 : ‰ª‘÷Œ¡Š±Š

            _PaymentReceiptDocument.Reset;
            _PaymentReceiptDocument.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
            _PaymentReceiptDocument.CalcFields("Line Service Amount");
            _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
            _PaymentReceiptDocument.SetRange(Posted, true);
            _PaymentReceiptDocument.SetRange("Missing Contract", false);
            _PaymentReceiptDocument.SetRange("New Admin. Expense", false);
            _PaymentReceiptDocument.SetFilter("Line Service Amount", '<>%1', 0);
            _PaymentReceiptDocument.SetRange("Posting Date", YearStartDate, ReferenceDate);
            if _PaymentReceiptDocument.FindSet then begin
                repeat
                    _PaymentReceiptDocument.CalcFields(Refund);
                    _PaymentReceiptDocLine.Reset;
                    _PaymentReceiptDocLine.CalcFields("Field Work Main Cat. Code");
                    _PaymentReceiptDocLine.SetRange("Document No.", _PaymentReceiptDocument."Document No.");
                    _PaymentReceiptDocLine.SetFilter("Cem. Services No.", '<>%1', '');
                    _PaymentReceiptDocLine.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                    if _PaymentReceiptDocLine.FindSet then begin
                        repeat
                            // -----------Ÿú
                            if _PaymentReceiptDocument."Posting Date" = ReferenceDate then begin
                                if _PaymentReceiptDocument.Refund then
                                    Header.INTEGER2 += 1
                                else begin
                                    _CemeteryServices.Reset;
                                    _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                    _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                    if _CemeteryServices.FindSet then
                                        Header.INTEGER2 += 1;
                                end;

                                Header.DECIMAL0 += _PaymentReceiptDocLine.Amount;
                            end;
                            // -----------õú
                            if (_PaymentReceiptDocument."Posting Date" >= MonthStartDate) and
                              (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) then begin
                                if _PaymentReceiptDocument.Refund then
                                    Header.INTEGER3 += 1
                                else begin
                                    _CemeteryServices.Reset;
                                    _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                    _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                    if _CemeteryServices.FindSet then
                                        Header.INTEGER3 += 1;
                                end;

                                Header.DECIMAL1 += _PaymentReceiptDocLine.Amount;
                            end;
                            // -----------‚Ëú
                            if (_PaymentReceiptDocument."Posting Date" >= YearStartDate) and
                              (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) then begin
                                if _PaymentReceiptDocument.Refund then
                                    Header.INTEGER4 += 1
                                else begin
                                    _CemeteryServices.Reset;
                                    _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                    _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                    if _CemeteryServices.FindSet then
                                        Header.INTEGER4 += 1;
                                end;

                                Header.DECIMAL4 += _PaymentReceiptDocLine.Amount;
                            end;
                        until _PaymentReceiptDocLine.Next = 0;
                    end;
                until _PaymentReceiptDocument.Next = 0;
            end;


            _KPITargetLine.Reset;
            _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
            _KPITargetLine.SetRange("Report Taget Value Code", '028');   // ‰ª‘÷Œ¡Š±Š - €Ë•ˆ ˆ±—Ñ —ø
            _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
            _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
            _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
            if _KPITargetLine.FindSet then
                Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

            _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
            _KPITargetLine.SetRange(Month, 12);
            if _KPITargetLine.FindSet then begin
                Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
            end;

            _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
            _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
            if _KPITargetLine.FindSet then begin
                _KPITargetLine.CalcSums(Amount);
                Header.DECIMAL5 += _KPITargetLine.Amount;
            end;

            // -----------„Ð
            TotalDailyCnt[4] += Header.INTEGER2;
            TotalDailyAmt[4] += Header.DECIMAL0;
            TotalMonthCnt[4] += Header.INTEGER3;
            TotalMonthAmt[4] += Header.DECIMAL1;
            TotalMonthTarget[4] += Header.DECIMAL2;
            TotalYearCnt[4] += Header.INTEGER4;
            TotalYearAmt[4] += Header.DECIMAL4;
            TotalYearTarget[4] += Header.DECIMAL5;

            // -----------‘°……
            // õú ‘°……
            if Header.DECIMAL2 <> 0 then
                Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
            // ¼ú ‘°……
            if Header.DECIMAL5 <> 0 then
                Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

            Header.Insert;
        end;

        // -----------------------------------------------------------------------------

        // -----------œÎ(908) ‰ª‘÷ Œ¡Š±Š
        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetRange(Code, '908');  // œÎ(908) ‰ª‘÷ Œ¡Š±Š
        _FieldWorkMainCategory.SetRange(Blocked, false);
        _FieldWorkMainCategory.SetRange("Cemetery Services", true);
        //_FieldWorkMainCategory.SETRANGE("Other Services",FALSE);
        if _FieldWorkMainCategory.FindSet then begin
            EntryNo += 1;
            Header.Init;
            //// Header."OBJECT ID" := REPORT::Report50035;
            Header."USER ID" := UserId;
            Header."Entry No." := EntryNo;
            Header.TEXT0 := _FieldWorkMainCategory.Name;
            Header.INTEGER0 := 1;     // ReportType : ‰ª‘÷Œ¡Š±Š
            Header.INTEGER1 := 0;     // ReportKey1 : ‰ª‘÷Œ¡Š±Š

            _PaymentReceiptDocument.Reset;
            _PaymentReceiptDocument.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
            _PaymentReceiptDocument.CalcFields("Line Service Amount");
            _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
            _PaymentReceiptDocument.SetRange(Posted, true);
            _PaymentReceiptDocument.SetRange("Missing Contract", false);
            _PaymentReceiptDocument.SetRange("New Admin. Expense", false);
            _PaymentReceiptDocument.SetFilter("Line Service Amount", '<>%1', 0);
            _PaymentReceiptDocument.SetRange("Posting Date", YearStartDate, ReferenceDate);
            if _PaymentReceiptDocument.FindSet then begin
                repeat
                    _PaymentReceiptDocument.CalcFields(Refund);
                    _PaymentReceiptDocLine.Reset;
                    _PaymentReceiptDocLine.CalcFields("Field Work Main Cat. Code");
                    _PaymentReceiptDocLine.SetRange("Document No.", _PaymentReceiptDocument."Document No.");
                    _PaymentReceiptDocLine.SetFilter("Cem. Services No.", '<>%1', '');
                    _PaymentReceiptDocLine.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                    if _PaymentReceiptDocLine.FindSet then begin
                        repeat
                            _PaymentReceiptDocLine.CalcFields("Field Work Sub Cat. Code");
                            // -----------Ÿú
                            if _PaymentReceiptDocument."Posting Date" = ReferenceDate then begin
                                if _PaymentReceiptDocLine."Field Work Sub Cat. Code" = '001' then begin
                                    if _PaymentReceiptDocument.Refund then
                                        Header.INTEGER2 += 1
                                    else begin
                                        _CemeteryServices.Reset;
                                        _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                        _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                        if _CemeteryServices.FindSet then
                                            Header.INTEGER2 += 1;
                                    end;
                                end;
                                Header.DECIMAL0 += _PaymentReceiptDocLine.Amount;
                            end;
                            // -----------õú
                            if (_PaymentReceiptDocument."Posting Date" >= MonthStartDate) and
                              (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) then begin
                                if _PaymentReceiptDocLine."Field Work Sub Cat. Code" = '001' then begin
                                    if _PaymentReceiptDocument.Refund then
                                        Header.INTEGER3 += 1
                                    else begin
                                        _CemeteryServices.Reset;
                                        _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                        _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                        if _CemeteryServices.FindSet then
                                            Header.INTEGER3 += 1;
                                    end;
                                end;
                                Header.DECIMAL1 += _PaymentReceiptDocLine.Amount;
                            end;
                            // -----------¼ú
                            if (_PaymentReceiptDocument."Posting Date" >= YearStartDate) and
                              (_PaymentReceiptDocument."Posting Date" <= ReferenceDate) then begin
                                if _PaymentReceiptDocLine."Field Work Sub Cat. Code" = '001' then begin
                                    if _PaymentReceiptDocument.Refund then
                                        Header.INTEGER4 += 1
                                    else begin
                                        _CemeteryServices.Reset;
                                        _CemeteryServices.SetRange("No.", _PaymentReceiptDocLine."Cem. Services No.");
                                        _CemeteryServices.SetRange("Payment Type", _PaymentReceiptDocument."Payment Type");
                                        if _CemeteryServices.FindSet then
                                            Header.INTEGER4 += 1;
                                    end;
                                end;
                                Header.DECIMAL4 += _PaymentReceiptDocLine.Amount;
                            end;
                        until _PaymentReceiptDocLine.Next = 0;
                    end;
                until _PaymentReceiptDocument.Next = 0;
            end;

            // -----------ˆ±—Ñ —ø
            _ReportTargetValue.Reset;
            _ReportTargetValue.SetRange(Blocked, false);
            _ReportTargetValue.SetRange("OBJECT ID", OBJECTID);
            _ReportTargetValue.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
            if _ReportTargetValue.FindSet then begin
                _KPITargetLine.Reset;
                _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                _KPITargetLine.SetRange("Report Taget Value Code", _ReportTargetValue.Code);   // ‰ª‘÷Œ¡Š±Š ˆ±—Ñ —ø
                _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                if _KPITargetLine.FindSet then
                    Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                _KPITargetLine.SetRange(Month, 12);
                if _KPITargetLine.FindSet then begin
                    Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                end;

                _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                if _KPITargetLine.FindSet then begin
                    _KPITargetLine.CalcSums(Amount);
                    Header.DECIMAL5 += _KPITargetLine.Amount;
                end;
            end;

            // -----------„Ð
            TotalDailyCnt[4] += Header.INTEGER2;
            TotalDailyAmt[4] += Header.DECIMAL0;
            TotalMonthCnt[4] += Header.INTEGER3;
            TotalMonthAmt[4] += Header.DECIMAL1;
            TotalMonthTarget[4] += Header.DECIMAL2;
            TotalYearCnt[4] += Header.INTEGER4;
            TotalYearAmt[4] += Header.DECIMAL4;
            TotalYearTarget[4] += Header.DECIMAL5;

            // -----------‘°……
            // õú ‘°……
            if Header.DECIMAL2 <> 0 then
                Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
            // ¼ú ‘°……
            if Header.DECIMAL5 <> 0 then
                Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

            Header.Insert;
        end;

    end;

    local procedure Insert_OtherServices()
    var
        _FieldWorkMainCat: Record "DK_Field Work Main Category";
        _OtherSerLine: Record "DK_Other Service Line";
        _KPITargetLine: Record "DK_KPI Target Line";
        _ReportTargetValue: Record "DK_Report Target Value";
    begin
        // €Ë•ˆ Œ¡Š±Š

        _FieldWorkMainCat.Reset;
        _FieldWorkMainCat.SetRange(Blocked, false);
        _FieldWorkMainCat.SetRange("Other Services", true);
        if _FieldWorkMainCat.FindSet then begin
            repeat
                EntryNo += 1;
                Header.Reset;
                Header.Init;
                //// Header."OBJECT ID" := REPORT::Report50035;
                Header."USER ID" := UserId;
                Header."Entry No." := EntryNo;
                Header.TEXT0 := _FieldWorkMainCat.Name;
                Header.INTEGER0 := 3;                     // ReportType : €Ë•ˆŒ¡Š±Š
                Header.INTEGER1 := 0;                     // ReportKey1 : €Ë•ˆŒ¡Š±Š

                _OtherSerLine.Reset;
                _OtherSerLine.SetRange("Field Work Main Cat. Code", _FieldWorkMainCat.Code);
                _OtherSerLine.SetRange(Status, _OtherSerLine.Status::Release);
                // -----------Ÿú
                _OtherSerLine.SetRange(Date, ReferenceDate);
                if _OtherSerLine.FindSet then begin
                    _OtherSerLine.CalcSums(Quantity);
                    _OtherSerLine.CalcSums(Amount);

                    Header.INTEGER2 := _OtherSerLine.Quantity;
                    Header.DECIMAL0 := _OtherSerLine.Amount;
                end;
                // -----------õú
                _OtherSerLine.SetRange(Date, MonthStartDate, ReferenceDate);
                if _OtherSerLine.FindSet then begin
                    _OtherSerLine.CalcSums(Quantity);
                    _OtherSerLine.CalcSums(Amount);

                    Header.INTEGER3 := _OtherSerLine.Quantity;
                    Header.DECIMAL1 := _OtherSerLine.Amount;
                end;
                // -----------¼ú
                _OtherSerLine.SetRange(Date, YearStartDate, ReferenceDate);
                if _OtherSerLine.FindSet then begin
                    _OtherSerLine.CalcSums(Quantity);
                    _OtherSerLine.CalcSums(Amount);

                    Header.INTEGER4 := _OtherSerLine.Quantity;
                    Header.DECIMAL4 := _OtherSerLine.Amount;
                end;

                // -----------ˆ±—Ñ —ø
                _ReportTargetValue.Reset;
                _ReportTargetValue.SetRange("OBJECT ID", OBJECTID);
                _ReportTargetValue.SetRange("Field Work Main Cat. Code", _FieldWorkMainCat.Code);
                _ReportTargetValue.SetRange(Blocked, false);
                if _ReportTargetValue.FindSet then begin
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", _ReportTargetValue.Code);   // €Ë•ˆ Œ¡Š±Š ˆ±—Ñ
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;
                end;

                // -----------„Ð
                TotalDailyCnt[5] += Header.INTEGER2;
                TotalDailyAmt[5] += Header.DECIMAL0;
                TotalMonthCnt[5] += Header.INTEGER3;
                TotalMonthAmt[5] += Header.DECIMAL1;
                TotalMonthTarget[5] += Header.DECIMAL2;
                TotalYearCnt[5] += Header.INTEGER4;
                TotalYearAmt[5] += Header.DECIMAL4;
                TotalYearTarget[5] += Header.DECIMAL5;

                // -----------‘°……
                // õú ‘°……
                if Header.DECIMAL2 <> 0 then
                    Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
                // ¼ú ‘°……
                if Header.DECIMAL5 <> 0 then
                    Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

                Header.Insert;
            until _FieldWorkMainCat.Next = 0;
        end;
    end;

    local procedure Insert_TodayFuneral(pOption: Option Today,Tomorrow; var pFuneralCnt: array[5] of Decimal)
    var
        _TodayFuneral: Record "DK_Today Funeral";
    begin
        // „“— Î‡š, ‚‹Ÿ— Î‡š

        _TodayFuneral.Reset;
        _TodayFuneral.SetCurrentKey(Status, Date, "Working Group Code");
        _TodayFuneral.SetFilter(Status, '<>%1', _TodayFuneral.Status::Open);

        case pOption of
            pOption::Today:
                begin
                    _TodayFuneral.SetRange(Date, ReferenceDate);
                end;
            pOption::Tomorrow:
                begin
                    _TodayFuneral.SetRange(Date, ReferenceDate + 1);
                end;
        end;

        //------------------------ Ž˜”í ----------------------------
        _TodayFuneral.SetFilter("Working Group Code", '%1|%2', '0000', '0008');              // ÁŽð‘†: ‘ð…(0000), Ž˜”í(0008)
        _TodayFuneral.SetRange("Field Work Main Cat. Code", '001');
        if _TodayFuneral.FindSet then
            pFuneralCnt[1] := _TodayFuneral.Count;
        //------------------------ ˆ•Î ----------------------------
        _TodayFuneral.SetFilter("Working Group Code", '%1|%2|%3', '0001', '0002', '0007');    // ÁŽð‘†: 1‘†(0001), 2‘†(0002), ˆ•Î(0007)
        _TodayFuneral.SetRange("Field Work Main Cat. Code", '001');
        if _TodayFuneral.FindSet then
            pFuneralCnt[2] := _TodayFuneral.Count;
        //------------------------ œÎ ----------------------------
        _TodayFuneral.SetRange("Working Group Code");
        _TodayFuneral.SetRange("Field Work Main Cat. Code", '002');
        if _TodayFuneral.FindSet then
            pFuneralCnt[3] := _TodayFuneral.Count;
        //------------------------ ‘ª‡š— ----------------------------
        _TodayFuneral.SetFilter("Field Work Main Cat. Code", '%1|%2', '100', '101');
        if _TodayFuneral.FindSet then
            pFuneralCnt[4] := _TodayFuneral.Count;
    end;

    local procedure ReferenceDate_Onvalidate()
    begin

        if ReferenceDate = 0D then
            Error(MSG001);

        if ReferenceDate > Today then
            Error(MSG002);
    end;

    local procedure Insert_RefundPayment(pAdminType: Option General,LandScape,Honostone,Service)
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _TargetPayRecDoc: Record "DK_Payment Receipt Document";
        _TargetPayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _RevContract: Record "DK_Revocation Contract";
        _KPITargetLine: Record "DK_KPI Target Line";
        _Count: Integer;
        _Amount: Decimal;
    begin
        //˜»Š­

        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := RefundMSG;


        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetRange("Document Type", _PayReceiptDoc."Document Type"::Refund);
        _PayReceiptDoc.SetRange(Posted, true);
        _PayReceiptDoc.SetFilter("Target Doc. No.", '<>%1', '');
        _PayReceiptDoc.SetCurrentKey("Target Doc. No.", "Document Type");

        _TargetPayRecDoc.Reset;
        _TargetPayRecDoc.SetRange("Document Type", _TargetPayRecDoc."Document Type"::Receipt);

        case pAdminType of
            pAdminType::General:
                begin
                    Header.INTEGER0 := 0; // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 0; // ReportKey1 : Ÿ‰¦ ýˆ«Š±

                    _PayReceiptDoc.SetFilter("Supervise No.", '<>H*');       // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨

                    _TargetPayRecDocLine.Reset;
                    _TargetPayRecDocLine.SetRange("Payment Target", _TargetPayRecDocLine."Payment Target"::General);     // ß‘ª „Ô‹Ý: Ÿ‰¦ ýˆ«Š±

                    // -----------—¹ŽÊ €¦Ž¸
                    _RevContract.Reset;
                    _RevContract.SetRange(Status, _RevContract.Status::Complate);
                    _RevContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                    _RevContract.SetFilter("Supervise No.", '<>H*');
                    _RevContract.SetFilter("Refund General Amount", '<>%1', 0);
                    if _RevContract.FindSet then
                        repeat
                            // -----------Ÿú
                            if _RevContract."Payment Completion Date" = ReferenceDate then begin
                                Header.INTEGER2 -= 1;
                                // —ø €¦Ž¸ = -(Ÿ‰¦ ýˆ«Š±)
                                Header.DECIMAL0 -= _RevContract."Refund General Amount";
                            end;
                            // -----------õú
                            if (_RevContract."Payment Completion Date" >= MonthStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER3 -= 1;
                                // —ø €¦Ž¸ = -(Ÿ‰¦ ýˆ«Š±)
                                Header.DECIMAL1 -= _RevContract."Refund General Amount";
                            end;
                            // -----------¼ú
                            if (_RevContract."Payment Completion Date" >= YearStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER4 -= 1;
                                // —ø €¦Ž¸ = -(Ÿ‰¦ ýˆ«Š±)
                                Header.DECIMAL4 -= _RevContract."Refund General Amount"
                            end;
                        until _RevContract.Next = 0;
                end;
            pAdminType::LandScape:
                begin
                    Header.INTEGER0 := 0; // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 1; // ReportKey1 : ‘†µ ýˆ«Š±

                    _PayReceiptDoc.SetFilter("Supervise No.", '<>H*');       // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨

                    _TargetPayRecDocLine.Reset;
                    _TargetPayRecDocLine.SetRange("Payment Target", _TargetPayRecDocLine."Payment Target"::Landscape);   // ß‘ª „Ô‹Ý: ‘†µ ýˆ«Š±

                    _RevContract.SetFilter("Supervise No.", '<>H*');
                    _RevContract.SetFilter("Refund Land. Arc. Amount", '<>%1', 0);

                    // -----------—¹ŽÊ €¦Ž¸
                    _RevContract.Reset;
                    _RevContract.SetRange(Status, _RevContract.Status::Complate);
                    _RevContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                    _RevContract.SetFilter("Supervise No.", '<>H*');
                    _RevContract.SetFilter("Refund Land. Arc. Amount", '<>%1', 0);
                    if _RevContract.FindSet then
                        repeat
                            // -----------Ÿú
                            if _RevContract."Payment Completion Date" = ReferenceDate then begin
                                Header.INTEGER2 -= 1;
                                // —ø €¦Ž¸ = -(‘†µ ýˆ«Š±)
                                Header.DECIMAL0 -= _RevContract."Refund Land. Arc. Amount";
                            end;
                            // -----------õú
                            if (_RevContract."Payment Completion Date" >= MonthStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER3 -= 1;
                                // —ø €¦Ž¸ = -(‘†µ ýˆ«Š±)
                                Header.DECIMAL1 -= _RevContract."Refund Land. Arc. Amount";
                            end;
                            // -----------¼ú
                            if (_RevContract."Payment Completion Date" >= YearStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER4 -= 1;
                                // —ø €¦Ž¸ = -(‘†µ ýˆ«Š±)
                                Header.DECIMAL4 -= _RevContract."Refund Land. Arc. Amount"
                            end;
                        until _RevContract.Next = 0;
                end;
            pAdminType::Honostone:
                begin
                    Header.INTEGER0 := 0; // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 2; // ReportKey1 : Ž–‚šŠ•µ ýˆ«Š±

                    _PayReceiptDoc.SetFilter("Supervise No.", 'H*');       // Ž–‚šŠ•µ ‰ª‘÷ €ˆŠ¨

                    _TargetPayRecDocLine.Reset;
                    _TargetPayRecDocLine.SetRange("Payment Target", _TargetPayRecDocLine."Payment Target"::General);     // ß‘ª „Ô‹Ý: Ž–‚šŠ•µ ýˆ«Š±

                    _RevContract.SetFilter("Supervise No.", 'H*');
                    _RevContract.SetFilter("Refund General Amount", '<>%1', 0);

                    // -----------—¹ŽÊ €¦Ž¸
                    _RevContract.Reset;
                    _RevContract.SetRange(Status, _RevContract.Status::Complate);
                    _RevContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                    _RevContract.SetFilter("Supervise No.", 'H*');
                    _RevContract.SetFilter("Refund General Amount", '<>%1', 0);
                    if _RevContract.FindSet then
                        repeat
                            // -----------Ÿú
                            if _RevContract."Payment Completion Date" = ReferenceDate then begin
                                Header.INTEGER2 -= 1;
                                // —ø €¦Ž¸ = -(Ÿ‰¦ ýˆ«Š±)
                                Header.DECIMAL0 -= _RevContract."Refund General Amount";
                            end;
                            // -----------õú
                            if (_RevContract."Payment Completion Date" >= MonthStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER3 -= 1;
                                // —ø €¦Ž¸ = -(Ÿ‰¦ ýˆ«Š±)
                                Header.DECIMAL1 -= _RevContract."Refund General Amount";
                            end;
                            // -----------¼ú
                            if (_RevContract."Payment Completion Date" >= YearStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER4 -= 1;
                                // —ø €¦Ž¸ = -(Ÿ‰¦ ýˆ«Š±)
                                Header.DECIMAL4 -= _RevContract."Refund General Amount"
                            end;
                        until _RevContract.Next = 0;
                end;
            pAdminType::Service:
                begin
                    Header.INTEGER0 := 1; // ReportType : Œ¡Š±Š
                    Header.INTEGER1 := 0; // ReportKey1 : ‰ª‘÷ Œ¡Š±Š

                    _TargetPayRecDocLine.Reset;
                    _TargetPayRecDocLine.SetRange("Payment Target", _TargetPayRecDocLine."Payment Target"::Service);     // ß‘ª „Ô‹Ý: ‰ª‘÷ Œ¡Š±Š

                    //>>#2314
                    // -----------—¹ŽÊ €¦Ž¸(ˆ•Î/Ž˜”íŠ±)
                    _RevContract.Reset;
                    _RevContract.SetRange(Status, _RevContract.Status::Complate);
                    _RevContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                    _RevContract.SetFilter("Supervise No.", '<>H*');
                    _RevContract.SetFilter("Refund Bury Amount", '<>%1', 0);
                    if _RevContract.FindSet then
                        repeat
                            // -----------Ÿú
                            if _RevContract."Payment Completion Date" = ReferenceDate then begin
                                Header.INTEGER2 -= 1;
                                // —ø €¦Ž¸ = -(ˆ•Î/Ž˜”íŠ±)
                                Header.DECIMAL0 -= _RevContract."Refund Bury Amount";
                            end;
                            // -----------õú
                            if (_RevContract."Payment Completion Date" >= MonthStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER3 -= 1;
                                // —ø €¦Ž¸ = -(ˆ•Î/Ž˜”íŠ±)
                                Header.DECIMAL1 -= _RevContract."Refund Bury Amount";
                            end;
                            // -----------¼ú
                            if (_RevContract."Payment Completion Date" >= YearStartDate) and
                              (_RevContract."Payment Completion Date" <= ReferenceDate) then begin
                                Header.INTEGER4 -= 1;
                                // —ø €¦Ž¸ = -(ˆ•Î/Ž˜”íŠ±)
                                Header.DECIMAL4 -= _RevContract."Refund Bury Amount"
                            end;
                        until _RevContract.Next = 0;
                    //
                end;
        end;

        // -----------˜»Š­ €¦Ž¸
        _PayReceiptDoc.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
        if _PayReceiptDoc.FindSet then begin
            repeat
                _TargetPayRecDoc.SetRange("Document No.", _PayReceiptDoc."Target Doc. No.");
                if _TargetPayRecDoc.FindSet then begin
                    _TargetPayRecDocLine.SetRange("Document No.", _TargetPayRecDoc."Document No.");
                    if _TargetPayRecDocLine.FindSet then begin
                        // -----------Ÿú
                        if _PayReceiptDoc."Payment Completion Date" = ReferenceDate then begin
                            Header.INTEGER2 -= 1;
                            // —ø €¦Ž¸ = -(†Ýž €¦Ž¸)
                            Header.DECIMAL0 -= _TargetPayRecDocLine.Amount;
                        end;
                        // -----------õú
                        if (_PayReceiptDoc."Payment Completion Date" >= MonthStartDate) and
                          (_PayReceiptDoc."Payment Completion Date" <= ReferenceDate) then begin
                            Header.INTEGER3 -= 1;
                            // —ø €¦Ž¸ = -(†Ýž €¦Ž¸)
                            Header.DECIMAL1 -= _TargetPayRecDocLine.Amount;
                        end;
                        // -----------¼ú
                        if (_PayReceiptDoc."Payment Completion Date" >= YearStartDate) and
                          (_PayReceiptDoc."Payment Completion Date" <= ReferenceDate) then begin
                            Header.INTEGER4 -= 1;
                            // —ø €¦Ž¸ = -(†Ýž €¦Ž¸)
                            Header.DECIMAL4 -= _TargetPayRecDocLine.Amount;
                        end;
                    end;
                end;
            until _PayReceiptDoc.Next = 0;
        end;

        // -----------„Ð

        case pAdminType of
            pAdminType::General:
                begin
                    TotalDailyCnt[1] += Header.INTEGER2;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER3;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalYearCnt[1] += Header.INTEGER4;
                    TotalYearAmt[1] += Header.DECIMAL4;
                end;
            pAdminType::LandScape:
                begin
                    TotalDailyCnt[2] += Header.INTEGER2;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER3;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalYearCnt[2] += Header.INTEGER4;
                    TotalYearAmt[2] += Header.DECIMAL4;
                end;
            pAdminType::Honostone:
                begin
                    TotalDailyCnt[3] += Header.INTEGER2;
                    TotalDailyAmt[3] += Header.DECIMAL0;
                    TotalMonthCnt[3] += Header.INTEGER3;
                    TotalMonthAmt[3] += Header.DECIMAL1;
                    TotalYearCnt[3] += Header.INTEGER4;
                    TotalYearAmt[3] += Header.DECIMAL4;
                end;
            pAdminType::Service:
                begin
                    TotalDailyCnt[4] += Header.INTEGER2;
                    TotalDailyAmt[4] += Header.DECIMAL0;
                    TotalMonthCnt[4] += Header.INTEGER3;
                    TotalMonthAmt[4] += Header.DECIMAL1;
                    TotalYearCnt[4] += Header.INTEGER4;
                    TotalYearAmt[4] += Header.DECIMAL4;
                end;
        end;


        Header.Insert;
    end;

    local procedure Insert_AdminExpRegular(pAdminType: Option General,LandScape,Honostone)
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Department: Record DK_Department;
        _KPITargetLine: Record "DK_KPI Target Line";
        _DebtDeliefAmt: Decimal;
    begin
        //‘ñ€¯Š¨

        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := RegularMSG;

        _PayRecDoc.Reset;
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("New Admin. Expense", false);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange("Befor Liti. Eval.", _PayRecDoc."Befor Liti. Eval."::A);
        _PayRecDoc.SetCurrentKey("Document Type", "Befor Liti. Eval.", "Posting Date");

        _Department.Reset;
        _Department.SetRange(Blocked, false);
        _Department.SetRange(Litigation, true);
        if _Department.FindSet then
            _PayRecDoc.SetFilter("Department Code", '<>%1', _Department.Code);

        case pAdminType of
            pAdminType::General:
                begin
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 0;                              // ReportKey1 : Ÿ‰¦ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');      // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '002');   // Ÿ‰¦ ýˆ«Š± - ‘ñ€¯Š¨
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[1] += Header.INTEGER2;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER3;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalMonthTarget[1] += Header.DECIMAL2;
                    TotalYearCnt[1] += Header.INTEGER4;
                    TotalYearAmt[1] += Header.DECIMAL4;
                    TotalYearTarget[1] += Header.DECIMAL5;
                end;
            pAdminType::LandScape:
                begin
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 1;                              // ReportKey1 : ‘†µ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');      // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::Landscape);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '007');   // ‘†µ ýˆ«Š± - ‘ñ€¯Š¨
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[2] += Header.INTEGER2;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER3;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalMonthTarget[2] += Header.DECIMAL2;
                    TotalYearCnt[2] += Header.INTEGER4;
                    TotalYearAmt[2] += Header.DECIMAL4;
                    TotalYearTarget[2] += Header.DECIMAL5;
                end;
            pAdminType::Honostone:
                begin
                    Header.INTEGER0 := 0;                            // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 2;                            // ReportKey1 : Ž–‚šŠ•µ ýˆ«Š±


                    _PayRecDoc.SetFilter("Supervise No.", 'H*');      // Ž–‚šŠ•µ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '012');   // Ž–‚šŠ•µ ýˆ«Š± - ‘ñ€¯Š¨
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[3] += Header.INTEGER2;
                    TotalDailyAmt[3] += Header.DECIMAL0;
                    TotalMonthCnt[3] += Header.INTEGER3;
                    TotalMonthAmt[3] += Header.DECIMAL1;
                    TotalMonthTarget[3] += Header.DECIMAL2;
                    TotalYearCnt[3] += Header.INTEGER4;
                    TotalYearAmt[3] += Header.DECIMAL4;
                    TotalYearTarget[3] += Header.DECIMAL5;
                end;
        end;

        // -----------‘°……
        // õú ‘°……
        if Header.DECIMAL2 <> 0 then
            Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
        // ¼ú ‘°……
        if Header.DECIMAL5 <> 0 then
            Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

        Header.Insert;
    end;

    local procedure Insert_AdminExpArrears(pAdminType: Option General,LandScape,Honostone)
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Department: Record DK_Department;
        _KPITargetLine: Record "DK_KPI Target Line";
        _DebtDeliefAmt: Decimal;
    begin
        //‰œ‚‚Š¨

        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := UnpaidMSG;

        _PayRecDoc.Reset;
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetFilter("Befor Liti. Eval.", '%1|%2|%3|%4',
                                _PayRecDoc."Befor Liti. Eval."::B, _PayRecDoc."Befor Liti. Eval."::C, _PayRecDoc."Befor Liti. Eval."::D,
                                _PayRecDoc."Befor Liti. Eval."::E);              // ‰œ‚‚ = B,C,D,E …Ø€Ã
        _PayRecDoc.SetCurrentKey("Document Type", "Befor Liti. Eval.", "Posting Date");

        _Department.Reset;
        _Department.SetRange(Blocked, false);
        _Department.SetRange(Litigation, true);
        if _Department.FindSet then
            _PayRecDoc.SetFilter("Department Code", '<>%1', _Department.Code);

        case pAdminType of
            pAdminType::General:
                begin                           // €ˆŠ¨: Ÿ‰¦ ýˆ«Š±
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 0;                              // ReportKey1 : Ÿ‰¦ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');      // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '003');   // Ÿ‰¦ ýˆ«Š± - ‰œ‚‚Š¨
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[1] += Header.INTEGER2;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER3;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalMonthTarget[1] += Header.DECIMAL2;
                    TotalYearCnt[1] += Header.INTEGER4;
                    TotalYearAmt[1] += Header.DECIMAL4;
                    TotalYearTarget[1] += Header.DECIMAL5;
                end;
            pAdminType::LandScape:
                begin                         // €ˆŠ¨: ‘†µ ýˆ«Š±
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 1;                              // ReportKey1 : ‘†µ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');      // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::Landscape);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '008');   // ‘†µ ýˆ«Š± - ‰œ‚‚Š¨
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[2] += Header.INTEGER2;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER3;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalMonthTarget[2] += Header.DECIMAL2;
                    TotalYearCnt[2] += Header.INTEGER4;
                    TotalYearAmt[2] += Header.DECIMAL4;
                    TotalYearTarget[2] += Header.DECIMAL5;
                end;
            pAdminType::Honostone:
                begin                       // €ˆŠ¨: Ž–‚šŠ•µ ýˆ«Š±
                    Header.INTEGER0 := 0;                            // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 2;                            // ReportKey1 : Ž–‚šŠ•µ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", 'H*');      // Ž–‚šŠ•µ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '013');   // Ž–‚šŠ•µ ýˆ«Š± - ‰œ‚‚Š¨
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[3] += Header.INTEGER2;
                    TotalDailyAmt[3] += Header.DECIMAL0;
                    TotalMonthCnt[3] += Header.INTEGER3;
                    TotalMonthAmt[3] += Header.DECIMAL1;
                    TotalMonthTarget[3] += Header.DECIMAL2;
                    TotalYearCnt[3] += Header.INTEGER4;
                    TotalYearAmt[3] += Header.DECIMAL4;
                    TotalYearTarget[3] += Header.DECIMAL5;
                end;
        end;

        // -----------‘°……
        // õú ‘°……
        if Header.DECIMAL2 <> 0 then
            Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
        // ¼ú ‘°……
        if Header.DECIMAL5 <> 0 then
            Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

        Header.Insert;
    end;

    local procedure Insert_AdminExpLitigation(pAdminType: Option General,LandScape,Honostone)
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Department: Record DK_Department;
        _KPITargetLine: Record "DK_KPI Target Line";
        _DebtDeliefAmt: Decimal;
        _MonthOtherAmt: Decimal;
        _YearOtherAmt: Decimal;
    begin
        // ŒÁ‰½ “È™
        Clear(_MonthOtherAmt);
        Clear(_YearOtherAmt);


        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := LitigationMSG;

        _PayRecDoc.Reset;
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("New Admin. Expense", false);
        _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");

        _Department.Reset;
        _Department.SetRange(Blocked, false);
        _Department.SetRange(Litigation, true);
        if _Department.FindSet then
            _PayRecDoc.SetRange("Department Code", _Department.Code);

        case pAdminType of
            pAdminType::General:
                begin                           // €ˆŠ¨: Ÿ‰¦ ýˆ«Š±
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 0;                              // ReportKey1 : Ÿ‰¦ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');      // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ŒÁ‰½ €Ë•ˆ
                    /*
                    _PayRecDoc.RESET;
                    _PayRecDoc.SETCURRENTKEY("Document Type","Posting Date",Posted,"Missing Contract");
                    _PayRecDoc.SETRANGE(Posted,TRUE);
                    _PayRecDoc.SETRANGE("Missing Contract",FALSE);
                    _PayRecDoc.SETRANGE("Document Type",_PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SETRANGE(Litigation,TRUE);
                    _PayRecDoc.SETFILTER("Supervise No.",'<>H*');       // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SETRANGE("Posting Date",YearStartDate,ReferenceDate);
                    _PayRecDoc.FILTERGROUP(-1);
                    _PayRecDoc.SETFILTER("Delay Interest Amount",'<>%1',0);
                    _PayRecDoc.SETFILTER("Liti. Delay Interest Amount",'<>%1',0);
                    IF _PayRecDoc.FINDSET THEN BEGIN
                      REPEAT
                        _PayRecDocLine.RESET;
                        _PayRecDocLine.SETCURRENTKEY("Document No.","Payment Target");
                        _PayRecDocLine.SETRANGE("Payment Target",_PayRecDocLine."Payment Target"::General);     // Ÿ‰¦ ýˆ«Š±
                        _PayRecDocLine.SETRANGE("Document No.",_PayRecDoc."Document No.");
                        IF _PayRecDocLine.FINDSET THEN BEGIN
                          // -----------õú
                          IF (_PayRecDoc."Posting Date" >= MonthStartDate) AND
                            (_PayRecDoc."Posting Date" <= ReferenceDate) THEN BEGIN
                            // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                            _MonthOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                          END;
                          // -----------¼ú
                          IF (_PayRecDoc."Posting Date" >= YearStartDate) AND
                            (_PayRecDoc."Posting Date" <= ReferenceDate) THEN BEGIN
                            // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                            _YearOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                          END;
                        END;
                      UNTIL _PayRecDoc.NEXT = 0;
                    END;
                    */

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '004');   // Ÿ‰¦ ýˆ«Š± - ŒÁ‰½“È™
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[1] += Header.INTEGER2;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER3;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalMonthTarget[1] += Header.DECIMAL2;
                    TotalYearCnt[1] += Header.INTEGER4;
                    TotalYearAmt[1] += Header.DECIMAL4;
                    TotalYearTarget[1] += Header.DECIMAL5;
                end;
            pAdminType::LandScape:
                begin                         // €ˆŠ¨: ‘†µ ýˆ«Š±
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 1;                              // ReportKey1 : ‘†µ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');      // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::Landscape);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - ‘†µ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 2" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ŒÁ‰½ €Ë•ˆ
                    /*
                    _PayRecDoc.RESET;
                    _PayRecDoc.SETCURRENTKEY("Document Type","Posting Date",Posted,"Missing Contract");
                    _PayRecDoc.SETRANGE(Posted,TRUE);
                    _PayRecDoc.SETRANGE("Missing Contract",FALSE);
                    _PayRecDoc.SETRANGE("Document Type",_PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SETRANGE(Litigation,TRUE);
                    _PayRecDoc.SETFILTER("Supervise No.",'<>H*');       // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SETRANGE("Posting Date",YearStartDate,ReferenceDate);
                    _PayRecDoc.FILTERGROUP(-1);
                    _PayRecDoc.SETFILTER("Delay Interest Amount",'<>%1',0);
                    _PayRecDoc.SETFILTER("Liti. Delay Interest Amount",'<>%1',0);
                    IF _PayRecDoc.FINDSET THEN BEGIN
                      REPEAT
                        _PayRecDocLine.RESET;
                        _PayRecDocLine.SETRANGE("Payment Target",_PayRecDocLine."Payment Target"::Landscape); // ‘†µýˆ«Š±
                        _PayRecDocLine.SETCURRENTKEY("Document No.","Payment Target");
                        _PayRecDocLine.SETRANGE("Document No.",_PayRecDoc."Document No.");
                        IF _PayRecDocLine.FINDSET THEN BEGIN
                          // -----------õú
                          IF (_PayRecDoc."Posting Date" >= MonthStartDate) AND
                            (_PayRecDoc."Posting Date" <= ReferenceDate) THEN BEGIN
                            // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                            _MonthOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                          END;
                          // -----------¼ú
                          IF (_PayRecDoc."Posting Date" >= YearStartDate) AND
                            (_PayRecDoc."Posting Date" <= ReferenceDate) THEN BEGIN
                            // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                            _YearOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                          END;
                        END;
                      UNTIL _PayRecDoc.NEXT = 0;
                    END;
                    */

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '009');   // ‘†µ ýˆ«Š± - ŒÁ‰½“È™
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[2] += Header.INTEGER2;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER3;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalMonthTarget[2] += Header.DECIMAL2;
                    TotalYearCnt[2] += Header.INTEGER4;
                    TotalYearAmt[2] += Header.DECIMAL4;
                    TotalYearTarget[2] += Header.DECIMAL5;
                end;
            pAdminType::Honostone:
                begin                       // €ˆŠ¨: Ž–‚šŠ•µ ýˆ«Š±
                    Header.INTEGER0 := 0;                            // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 2;                            // ReportKey1 : Ž–‚šŠ•µ ýˆ«Š±

                    _PayRecDoc.SetFilter("Supervise No.", 'H*');      // Ž–‚šŠ•µ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDoc.CalcFields("Line General Amount", "Line Land. Arc. Amount");

                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------“ñ‰½ •‘¿Ž¸
                                if (_PayRecDoc."Line General Amount" <> 0) and (_PayRecDoc."Line Land. Arc. Amount" <> 0) then
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount" / 2
                                else
                                    _DebtDeliefAmt := _PayRecDoc."Debt Relief Amount";
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL0 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL1 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = †Ýž €¦Ž¸ - Ÿ‰¦ ýˆ«Š± ¿ˆÒŽ¸ - “ñ‰½•‘¿Ž¸
                                    Header.DECIMAL4 += _PayRecDocLine.Amount - _PayRecDoc."Reduction Amount 1" - _DebtDeliefAmt;
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ŒÁ‰½ €Ë•ˆ
                    /*
                    _PayRecDoc.RESET;
                    _PayRecDoc.SETCURRENTKEY("Document Type","Posting Date",Posted,"Missing Contract");
                    _PayRecDoc.SETRANGE(Posted,TRUE);
                    _PayRecDoc.SETRANGE("Missing Contract",FALSE);
                    _PayRecDoc.SETRANGE("Document Type",_PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SETRANGE(Litigation,TRUE);
                    _PayRecDoc.SETFILTER("Supervise No.",'H*');       // Ž–‚šŠ•µ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SETRANGE("Posting Date",YearStartDate,ReferenceDate);
                    _PayRecDoc.FILTERGROUP(-1);
                    _PayRecDoc.SETFILTER("Delay Interest Amount",'<>%1',0);
                    _PayRecDoc.SETFILTER("Liti. Delay Interest Amount",'<>%1',0);
                    IF _PayRecDoc.FINDSET THEN BEGIN
                      REPEAT
                        _PayRecDocLine.RESET;
                        _PayRecDocLine.SETRANGE("Payment Target",_PayRecDocLine."Payment Target"::General);
                        _PayRecDocLine.SETCURRENTKEY("Document No.","Payment Target");
                        _PayRecDocLine.SETRANGE("Document No.",_PayRecDoc."Document No.");
                        IF _PayRecDocLine.FINDSET THEN BEGIN
                          // -----------õú
                          IF (_PayRecDoc."Posting Date" >= MonthStartDate) AND
                            (_PayRecDoc."Posting Date" <= ReferenceDate) THEN BEGIN
                            // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                            _MonthOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                          END;
                          // -----------¼ú
                          IF (_PayRecDoc."Posting Date" >= YearStartDate) AND
                            (_PayRecDoc."Posting Date" <= ReferenceDate) THEN BEGIN
                            // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                            _YearOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                          END;
                        END;
                      UNTIL _PayRecDoc.NEXT = 0;
                    END;
                    */

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '014');   // Ž–‚šŠ•µ ýˆ«Š± - ŒÁ‰½“È™
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(YearStartDate, 3));
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3) + 1);
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[3] += Header.INTEGER2;
                    TotalDailyAmt[3] += Header.DECIMAL0;
                    TotalMonthCnt[3] += Header.INTEGER3;
                    TotalMonthAmt[3] += Header.DECIMAL1;
                    TotalMonthTarget[3] += Header.DECIMAL2;
                    TotalYearCnt[3] += Header.INTEGER4;
                    TotalYearAmt[3] += Header.DECIMAL4;
                    TotalYearTarget[3] += Header.DECIMAL5;
                end;
        end;

        // -----------ŒÁ‰½ €Ë•ˆ
        _PayRecDoc.Reset;
        _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange(Litigation, true);              // ŒÁ‰½ : TRUE - ŒÁ‰½ €Ë•ˆ
        _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
        _PayRecDoc.FilterGroup(-1);
        _PayRecDoc.SetFilter("Delay Interest Amount", '<>%1', 0);
        _PayRecDoc.SetFilter("Liti. Delay Interest Amount", '<>%1', 0);
        //>>#2314
        _PayRecDoc.SetFilter("Legal Amount", '<>%1', 0);
        //
        if _PayRecDoc.FindSet then begin
            repeat
                // -----------õú
                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ + ‰²Š±Ô
                    _MonthOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount" + _PayRecDoc."Legal Amount";
                end;
                // -----------¼ú
                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ + ‰²Š±Ô
                    _YearOtherAmt += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount" + _PayRecDoc."Legal Amount";
                end;
            until _PayRecDoc.Next = 0;
        end;

        // -----------‘°……
        // õú ‘°……
        if Header.DECIMAL2 <> 0 then
            Header.TEXT1 := StrSubstNo(PersantageMSG, Round(((Header.DECIMAL1) / Header.DECIMAL2 * 100), 0.1, '='));  // „ÃŒŠ‡ý = ŒÁ‰½ “È™—ø  / ŒÁ‰½ “È™ ˆ±—Ñ * 100
                                                                                                                      //  Header.TEXT1 := STRSUBSTNO(PersantageMSG,ROUND(((Header.DECIMAL1 + _MonthOtherAmt) / Header.DECIMAL2 * 100),0.1,'='));  // „ÃŒŠ‡ý = ŒÁ‰½ “È™—ø + ŒÁ‰½ €Ë•ˆ / ŒÁ‰½ “È™ ˆ±—Ñ * 100
                                                                                                                      // DK#2523

        // ¼ú ‘°……
        if Header.DECIMAL5 <> 0 then
            Header.TEXT2 := StrSubstNo(PersantageMSG, Round(((Header.DECIMAL4) / Header.DECIMAL5 * 100), 0.1, '='));   // „ÃŒŠ‡ý = ŒÁ‰½ “È™—ø  / ŒÁ‰½ “È™ ˆ±—Ñ * 100
        //  Header.TEXT2 := STRSUBSTNO(PersantageMSG,ROUND(((Header.DECIMAL4 + _YearOtherAmt) / Header.DECIMAL5 * 100),0.1,'='));   // „ÃŒŠ‡ý = ŒÁ‰½ “È™—ø + ŒÁ‰½ €Ë•ˆ / ŒÁ‰½ “È™ ˆ±—Ñ * 100
        // DK#2523
        Header.Insert;

    end;

    local procedure Insert_AdminExpDelayIntAmount(pAdminType: Option General,LandScape,Honostone)
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Department: Record DK_Department;
        _KPITargetLine: Record "DK_KPI Target Line";
        _DebtDeliefAmt: Decimal;
    begin
        // ŒÁ‰½ €Ë•ˆ

        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := DelayIntAmtMSG;

        case pAdminType of
            pAdminType::General:
                begin                           // €ˆŠ¨: Ÿ‰¦ ýˆ«Š±
                    Header.INTEGER0 := 0;                              // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 0;                              // ReportKey1 : Ÿ‰¦ ýˆ«Š±

                    _PayRecDoc.Reset;
                    _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
                    _PayRecDoc.SetRange(Posted, true);
                    _PayRecDoc.SetRange("Missing Contract", false);
                    _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SetRange(Litigation, true);
                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');       // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    _PayRecDoc.FilterGroup(-1);
                    _PayRecDoc.SetFilter("Delay Interest Amount", '<>%1', 0);
                    _PayRecDoc.SetFilter("Liti. Delay Interest Amount", '<>%1', 0);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);     // Ÿ‰¦ ýˆ«Š±
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL0 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL1 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL4 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '005');   // Ÿ‰¦ ýˆ«Š± - ŒÁ‰½€Ë•ˆ
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3) - 1);
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[1] += Header.INTEGER2;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER3;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalMonthTarget[1] += Header.DECIMAL2;
                    TotalYearCnt[1] += Header.INTEGER4;
                    TotalYearAmt[1] += Header.DECIMAL4;
                    TotalYearTarget[1] += Header.DECIMAL5;
                end;
            pAdminType::LandScape:
                begin                      // €ˆŠ¨: ‘†µ ýˆ«Š±
                    Header.INTEGER0 := 0;                           // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 1;                           // ReportKey1 : ‘†µ ýˆ«Š±

                    _PayRecDoc.Reset;
                    _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
                    _PayRecDoc.SetRange(Posted, true);
                    _PayRecDoc.SetRange("Missing Contract", false);
                    _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SetRange(Litigation, true);
                    _PayRecDoc.SetFilter("Supervise No.", '<>H*');       // Ÿ‰¦ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    _PayRecDoc.FilterGroup(-1);
                    _PayRecDoc.SetFilter("Delay Interest Amount", '<>%1', 0);
                    _PayRecDoc.SetFilter("Liti. Delay Interest Amount", '<>%1', 0);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::Landscape);
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL0 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL1 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL4 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '010');   // ‘†µ ýˆ«Š± - ŒÁ‰½€Ë•ˆ
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3) - 1);
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[2] += Header.INTEGER2;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER3;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalMonthTarget[2] += Header.DECIMAL2;
                    TotalYearCnt[2] += Header.INTEGER4;
                    TotalYearAmt[2] += Header.DECIMAL4;
                    TotalYearTarget[2] += Header.DECIMAL5;
                end;
            pAdminType::Honostone:
                begin                     // €ˆŠ¨: Ž–‚šŠ•µ ýˆ«Š±
                    Header.INTEGER0 := 0;                          // ReportType : ýˆ«Š±
                    Header.INTEGER1 := 2;                          // ReportKey1 : Ž–‚šŠ•µ ýˆ«Š±

                    _PayRecDoc.Reset;
                    _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
                    _PayRecDoc.SetRange(Posted, true);
                    _PayRecDoc.SetRange("Missing Contract", false);
                    _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
                    _PayRecDoc.SetRange(Litigation, true);
                    _PayRecDoc.SetFilter("Supervise No.", 'H*');       // Ž–‚šŠ•µ ‰ª‘÷ €ˆŠ¨
                    _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
                    _PayRecDoc.FilterGroup(-1);
                    _PayRecDoc.SetFilter("Delay Interest Amount", '<>%1', 0);
                    _PayRecDoc.SetFilter("Liti. Delay Interest Amount", '<>%1', 0);
                    if _PayRecDoc.FindSet then begin
                        repeat
                            _PayRecDocLine.Reset;
                            _PayRecDocLine.SetRange("Payment Target", _PayRecDocLine."Payment Target"::General);
                            _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                            _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                            if _PayRecDocLine.FindSet then begin
                                // -----------Ÿú
                                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                                    Header.INTEGER2 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL0 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                                // -----------õú
                                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER3 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL1 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                                // -----------¼ú
                                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                                    Header.INTEGER4 += 1;
                                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                                    Header.DECIMAL4 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                                end;
                            end;
                        until _PayRecDoc.Next = 0;
                    end;

                    // -----------ˆ±—Ñ —ø
                    _KPITargetLine.Reset;
                    _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
                    _KPITargetLine.SetRange("Report Taget Value Code", '015');   // Ž–‚šŠ•µ ýˆ«Š± - ŒÁ‰½€Ë•ˆ
                    _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);
                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
                    if _KPITargetLine.FindSet then
                        Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3) - 1);
                    _KPITargetLine.SetRange(Month, 12);
                    if _KPITargetLine.FindSet then begin
                        Header.DECIMAL5 += _KPITargetLine.Amount;     // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    end;

                    _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
                    _KPITargetLine.SetRange(Month, 1, 11);            // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                    if _KPITargetLine.FindSet then begin
                        _KPITargetLine.CalcSums(Amount);
                        Header.DECIMAL5 += _KPITargetLine.Amount;
                    end;

                    // -----------„Ð
                    TotalDailyCnt[3] += Header.INTEGER2;
                    TotalDailyAmt[3] += Header.DECIMAL0;
                    TotalMonthCnt[3] += Header.INTEGER3;
                    TotalMonthAmt[3] += Header.DECIMAL1;
                    TotalMonthTarget[3] += Header.DECIMAL2;
                    TotalYearCnt[3] += Header.INTEGER4;
                    TotalYearAmt[3] += Header.DECIMAL4;
                    TotalYearTarget[3] += Header.DECIMAL5;
                end;
        end;

        // -----------‘°……
        // õú ‘°……
        if Header.DECIMAL2 <> 0 then
            Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
        // ¼ú ‘°……
        if Header.DECIMAL5 <> 0 then
            Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL4 / Header.DECIMAL5 * 100), 0.1, '='));

        Header.Insert;
    end;

    local procedure Insert_AdminExpDelayAmount()
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Department: Record DK_Department;
        _KPITargetLine: Record "DK_KPI Target Line";
        _DebtDeliefAmt: Decimal;
    begin
        // €Ë•ˆ ˆ•“Ë

        //---------- ×„ŒŽ• €Ë•ˆ
        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := CustDelayIntAmtMSG;
        Header.INTEGER0 := 2;                              // ReportType : €Ë•ˆˆ•“Ë
        Header.INTEGER1 := 0;                              // ReportKey1 : €Ë•ˆˆ•“Ë

        _PayRecDoc.Reset;
        _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange(Litigation, false);              // ŒÁ‰½ : FALSE - ×„ŒŽ• €Ë•ˆ
        _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
        _PayRecDoc.FilterGroup(-1);
        _PayRecDoc.SetFilter("Delay Interest Amount", '<>%1', 0);
        _PayRecDoc.SetFilter("Liti. Delay Interest Amount", '<>%1', 0);
        if _PayRecDoc.FindSet then begin
            repeat
                // -----------Ÿú
                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                    Header.INTEGER2 += 1;
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                    Header.DECIMAL0 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                end;
                // -----------õú
                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                    Header.INTEGER3 += 1;
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                    Header.DECIMAL1 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                end;
                // -----------¼ú
                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                    Header.INTEGER4 += 1;
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ
                    Header.DECIMAL4 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount";
                end;
            until _PayRecDoc.Next = 0;
        end;

        // -----------„Ð
        TotalDailyCnt[6] += Header.INTEGER2;
        TotalDailyAmt[6] += Header.DECIMAL0;
        TotalMonthCnt[6] += Header.INTEGER3;
        TotalMonthAmt[6] += Header.DECIMAL1;
        TotalYearCnt[6] += Header.INTEGER4;
        TotalYearAmt[6] += Header.DECIMAL4;

        Header.Insert;

        //---------- ŒÁ‰½ €Ë•ˆ
        EntryNo += 1;
        Header.Init;
        //// Header."OBJECT ID" := REPORT::Report50035;
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := DelayIntAmtMSG;
        Header.INTEGER0 := 2;                              // ReportType : €Ë•ˆˆ•“Ë
        Header.INTEGER1 := 0;                              // ReportKey1 : €Ë•ˆˆ•“Ë

        _PayRecDoc.Reset;
        _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange(Litigation, true);              // ŒÁ‰½ : TRUE - ŒÁ‰½ €Ë•ˆ
        _PayRecDoc.SetRange("Posting Date", YearStartDate, ReferenceDate);
        _PayRecDoc.FilterGroup(-1);
        _PayRecDoc.SetFilter("Delay Interest Amount", '<>%1', 0);
        _PayRecDoc.SetFilter("Liti. Delay Interest Amount", '<>%1', 0);
        //>>#2314
        _PayRecDoc.SetFilter("Legal Amount", '<>%1', 0);
        //
        if _PayRecDoc.FindSet then begin
            repeat
                // -----------Ÿú
                if _PayRecDoc."Posting Date" = ReferenceDate then begin
                    Header.INTEGER2 += 1;
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ + ‰²Š±Ô
                    Header.DECIMAL0 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount" + _PayRecDoc."Legal Amount";
                end;
                // -----------õú
                if (_PayRecDoc."Posting Date" >= MonthStartDate) and
                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                    Header.INTEGER3 += 1;
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ + ‰²Š±Ô
                    Header.DECIMAL1 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount" + _PayRecDoc."Legal Amount";
                end;
                // -----------¼ú
                if (_PayRecDoc."Posting Date" >= YearStartDate) and
                  (_PayRecDoc."Posting Date" <= ReferenceDate) then begin
                    Header.INTEGER4 += 1;
                    // —ø €¦Ž¸ = ×„ŒŽ• ‘÷¼œÀ + ŒÁ‰½ ‘÷¼œÀ + ‰²Š±Ô
                    Header.DECIMAL4 += _PayRecDoc."Delay Interest Amount" + _PayRecDoc."Liti. Delay Interest Amount" + _PayRecDoc."Legal Amount";
                end;
            until _PayRecDoc.Next = 0;
        end;

        // -----------„Ð
        TotalDailyCnt[6] += Header.INTEGER2;
        TotalDailyAmt[6] += Header.DECIMAL0;
        TotalMonthCnt[6] += Header.INTEGER3;
        TotalMonthAmt[6] += Header.DECIMAL1;
        TotalYearCnt[6] += Header.INTEGER4;
        TotalYearAmt[6] += Header.DECIMAL4;

        Header.Insert;
    end;
}

