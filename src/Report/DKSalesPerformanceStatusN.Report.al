report 50050 "DK_Sales Performance Status N"
{
    // //ÐŽÊ Š¨Œ« Šˆ×Œ¡
    // *DK11
    //   - INTEGER0 : ReportType
    //   - 0: “©ˆ•“Ë, 1: Honostone, 2: °°‰ª‘÷, 3: Ÿú ÐŽÊ€¦, 4: …ŽðÀŠ —ø(HONOR STONE), 5: …ŽðÀŠ —ø(°° ‰ª‘÷)
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKSalesPerformanceStatusN.rdl';

    Caption = 'Sales Performane Status';
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
            column(CategoryName; TEXT0)
            {
            }
            column(DailyCnt; INTEGER1)
            {
            }
            column(DailyAmt; DECIMAL0)
            {
            }
            column(MonthCnt; INTEGER2)
            {
            }
            column(MonthAmt; DECIMAL1)
            {
            }
            column(MonthTarget; DECIMAL2)
            {
            }
            column(MonthRate; TEXT1)
            {
            }
            column(YearCnt; INTEGER3)
            {
            }
            column(YearAmt; DECIMAL3)
            {
            }
            column(YearTarget; DECIMAL4)
            {
            }
            column(YearRate; TEXT2)
            {
            }
            column(PeriodTarget; DECIMAL5)
            {
            }
            column(PeriodRate; TEXT3)
            {
            }
            column(CemeteryType; TEXT4)
            {
            }
            column(CRMSalesType; TEXT5)
            {
            }
            column(SalesAmount; DECIMAL6)
            {
            }
            column(MainCustName; TEXT6)
            {
            }
            column(CemeteryNo; TEXT7)
            {
            }
            column(CemeteryConfName; TEXT8)
            {
            }
            column(CemeteryDigName; TEXT9)
            {
            }
            column(CRMSalesPerson; TEXT10)
            {
            }
            column(ReferenceDate; ReferenceDateText)
            {
            }
            column(HonoTotalDailyCnt; TotalDailyCnt[1])
            {
            }
            column(HonoTotalDailyAmt; TotalDailyAmt[1])
            {
            }
            column(HonoTotalMonthCnt; TotalMonthCnt[1])
            {
            }
            column(HonoTotalMonthAmt; TotalMonthAmt[1])
            {
            }
            column(HonoTotalMonthTarget; TotalMonthTarget[1])
            {
            }
            column(HonoTotalMonthRate; TotalMonthRate[1])
            {
            }
            column(HonoTotalPeriodTarget; TotalPeriodTarget[1])
            {
            }
            column(HonoTotalPerioRate; TotalPeriodRate[1])
            {
            }
            column(HonoTotalYearCnt; TotalYearCnt[1])
            {
            }
            column(HonoTotalYearAmt; TotalYearAmt[1])
            {
            }
            column(HonoTotalYearTarget; TotalYearTarget[1])
            {
            }
            column(HonoTotalYearRate; TotalYearRate[1])
            {
            }
            column(CemeTotalDailyCnt; TotalDailyCnt[2])
            {
            }
            column(CemeTotalDailyAmt; TotalDailyAmt[2])
            {
            }
            column(CemeTotalMonthCnt; TotalMonthCnt[2])
            {
            }
            column(CemeTotalMonthAmt; TotalMonthAmt[2])
            {
            }
            column(CemeTotalMonthTarget; TotalMonthTarget[2])
            {
            }
            column(CemeTotalMonthRate; TotalMonthRate[2])
            {
            }
            column(CemeTotalPeriodTarget; TotalPeriodTarget[2])
            {
            }
            column(CemeTotalPeriodRate; TotalPeriodRate[2])
            {
            }
            column(CemeTotalYearCnt; TotalYearCnt[2])
            {
            }
            column(CemeTotalYearAmt; TotalYearAmt[2])
            {
            }
            column(CemeTotalYearTarget; TotalYearTarget[2])
            {
            }
            column(CemeTotalYearRate; TotalYearRate[2])
            {
            }
            column(AllTotalMonthRate; TotalMonthRate[3])
            {
            }
            column(AllTotalPeriodRate; TotalPeriodRate[3])
            {
            }
            column(AllTotalYearRate; TotalYearRate[3])
            {
            }
            column(SalesPTotalDailyCnt; TotalDailyCnt[4])
            {
            }
            column(SalesPTotalDailyAmt; TotalDailyAmt[4])
            {
            }
            column(SalesPTotalMonthCnt; TotalMonthCnt[4])
            {
            }
            column(SalesPTotalMonthAmt; TotalMonthAmt[4])
            {
            }
            column(SalesPTotalYearCnt; TotalYearCnt[4])
            {
            }
            column(SalesPTotalYearAmt; TotalYearAmt[4])
            {
            }

            trigger OnPreDataItem()
            var
                _CRMSalesType: Record "DK_CRM Sales Type";
                _CRMSalesPerson: Record "DK_CRM SalesPerson";
                _Contract: Record DK_Contract;
                _ContractFindCount: Integer;
            begin
                Clear(MonthStartDate);
                Clear(YearStartDate);
                Clear(TotalDailyCnt);
                Clear(TotalDailyAmt);
                Clear(TotalMonthCnt);
                Clear(TotalMonthAmt);
                Clear(TotalMonthTarget);
                Clear(TotalMonthRate);
                Clear(TotalPeriodTarget);
                Clear(TotalPeriodRate);
                Clear(TotalYearCnt);
                Clear(TotalYearAmt);
                Clear(TotalYearTarget);
                Clear(TotalYearRate);

                MonthStartDate := CalcDate('<-CM>', ReferenceDate);
                if Date2DMY(ReferenceDate, 2) = 12 then
                    YearStartDate := CalcDate('<-CM>', ReferenceDate)
                else
                    YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));
                ReferenceDateText := Format(ReferenceDate, 0, ReferenceMSG);

                //MESSAGE('%1',FORMAT(YearStartDate));

                OBJECTID := '50050';

                //---------------------------------------µ‡žŠ ÐŽÊ ˆ•“Ë
                //----------------------- “©ˆ•“Ë
                Set_SalesPerformance(0);
                //----------------------- HONOSTONE
                Set_SalesPerformance(1);
                //----------------------- °°‰ª‘÷
                Set_SalesPerformance(2);

                //---------------------------------------Ÿú ÐŽÊ,Â€¦ ¯€¦
                Insert_ContractAmount;

                //---------------------------------------…ŽðÀŠ ÐŽÊ ˆ•“Ë
                Insert_SalesPerson(0);    // HONO STONE
                Insert_SalesPerson(1);    // °° ‰ª‘÷

                //---------------------------------------µ‡žŠ ÐŽÊ ˆ•“Ë Š±
                // õú Š±
                if TotalMonthTarget[1] <> 0 then
                    TotalMonthRate[1] := StrSubstNo(PersantageMSG, Round((TotalMonthAmt[1] / TotalMonthTarget[1] * 100), 0.1, '='));
                if TotalMonthTarget[2] <> 0 then
                    TotalMonthRate[2] := StrSubstNo(PersantageMSG, Round((TotalMonthAmt[2] / TotalMonthTarget[2] * 100), 0.1, '='));
                // ¼ú Š±
                if TotalYearTarget[1] <> 0 then
                    TotalYearRate[1] := StrSubstNo(PersantageMSG, Round((TotalYearAmt[1] / TotalYearTarget[1] * 100), 0.1, '='));
                if TotalYearTarget[2] <> 0 then
                    TotalYearRate[2] := StrSubstNo(PersantageMSG, Round((TotalYearAmt[2] / TotalYearTarget[2] * 100), 0.1, '='));
                // €ˆú Š±
                if TotalPeriodTarget[1] <> 0 then
                    TotalPeriodRate[1] := StrSubstNo(PersantageMSG, Round((TotalYearAmt[1] / TotalPeriodTarget[1] * 100), 0.1, '='));
                if TotalPeriodTarget[2] <> 0 then
                    TotalPeriodRate[2] := StrSubstNo(PersantageMSG, Round((TotalYearAmt[2] / TotalPeriodTarget[2] * 100), 0.1, '='));
                // “©ˆ•“Ë Š±
                if TotalMonthTarget[1] + TotalMonthTarget[2] <> 0 then
                    TotalMonthRate[3] := StrSubstNo(PersantageMSG,
                            Round(((TotalMonthAmt[1] + TotalMonthAmt[2]) / (TotalMonthTarget[1] + TotalMonthTarget[2]) * 100), 0.1, '='));
                if TotalPeriodTarget[1] + TotalPeriodTarget[2] <> 0 then
                    TotalPeriodRate[3] := StrSubstNo(PersantageMSG,
                            Round(((TotalYearAmt[1] + TotalYearAmt[2]) / (TotalPeriodTarget[1] + TotalPeriodTarget[2]) * 100), 0.1, '='));
                if TotalYearTarget[1] + TotalYearTarget[2] <> 0 then
                    TotalYearRate[3] := StrSubstNo(PersantageMSG,
                            Round(((TotalYearAmt[1] + TotalYearAmt[2]) / (TotalYearTarget[1] + TotalYearTarget[2]) * 100), 0.1, '='))
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(cReferenceDate; ReferenceDate)
                {
                    Caption = 'Reference Date';

                    trigger OnValidate()
                    begin
                        ReferenceDate_OnValidate;
                    end;
                }
                field(cSalesPersonFilter; SalesPersonFilter)
                {
                    Caption = 'Sales Person';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _CRMSalesPerson: Record "DK_CRM SalesPerson";
                    begin
                        _CRMSalesPerson.Reset;
                        _CRMSalesPerson.FilterGroup(2);
                        _CRMSalesPerson.SetRange(Blocked, false);
                        _CRMSalesPerson.FilterGroup(0);

                        if PAGE.RunModal(0, _CRMSalesPerson) = ACTION::LookupOK then begin
                            if _CRMSalesPerson.Code <> '' then begin
                                if Text = '' then
                                    Text := _CRMSalesPerson.Code
                                else
                                    Text := Text + '|' + _CRMSalesPerson.Code;
                            end;
                            exit(true);
                        end;
                    end;
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
        Title01Lb = 'ÐŽÊ Š¨Œ« Šˆ×Œ¡';
        Cap01Lb = '(„Âº : °)';
        Cap02Lb = 'Type';
        Cap03Lb = 'Daily';
        Cap04Lb = 'Month';
        Cap05Lb = 'Period';
        Cap06Lb = 'Year';
        Cap07Lb = 'Count';
        Cap08Lb = 'Amount';
        Cap09Lb = 'Target';
        Cap10Lb = 'Rate';
        Cap11Lb = 'Total';
        Cap12Lb = 'HONOR';
        Cap13Lb = 'STONE';
        Cap14Lb = 'Park';
        Cap15Lb = 'Cemetery';
        Cap16Lb = 'Total';
        Cap17Lb = 'Total';
        Cap18Lb = 'Path';
        Cap19Lb = 'Amount';
        Cap20Lb = 'Main Customer Name';
        Cap21Lb = 'Cemetery No.';
        Cap22Lb = 'Cemetery Conf. Name';
        Cap23Lb = 'Cemetery Dig. Name';
        Cap24Lb = 'CRM Sales Person';
        Cap25Lb = 'Remarks';
    }

    var
        ReferenceDate: Date;
        MSG001: Label 'Date greater than today (%1) is not available.';
        MonthStartDate: Date;
        YearStartDate: Date;
        EntryNo: Integer;
        ReferenceDateText: Text;
        ReferenceMSG: Label 'Reference Date : <Year4>-<Month,2>-<Day,2>';
        OBJECTID: Code[20];
        PersantageMSG: Label '%1 %';
        HonoStoneMSG: Label 'HONO STONE';
        CemeteryMSG: Label 'Cemetery';
        SalesPersonFilter: Text;
        TotalDailyCnt: array[100] of Integer;
        TotalDailyAmt: array[100] of Decimal;
        TotalMonthCnt: array[100] of Integer;
        TotalMonthAmt: array[100] of Decimal;
        TotalMonthTarget: array[100] of Decimal;
        TotalMonthRate: array[100] of Text;
        TotalPeriodTarget: array[100] of Decimal;
        TotalPeriodRate: array[100] of Text;
        TotalYearCnt: array[100] of Integer;
        TotalYearAmt: array[100] of Decimal;
        TotalYearTarget: array[100] of Decimal;
        TotalYearRate: array[100] of Text;

    local procedure ReferenceDate_OnValidate()
    begin

        if ReferenceDate > Today then
            Error(MSG001, Today);
    end;

    local procedure Set_SalesPerformance(pType: Option All,Honostone,Cemtery)
    var
        _Contract: Record DK_Contract;
        _RevocationContract: Record "DK_Revocation Contract";
        _CRMSalesType: Record "DK_CRM Sales Type";
        _KPITargetLine: Record "DK_KPI Target Line";
    begin
        // µ‡žŠ ˆ•“Ë —š• øÔ

        _Contract.Reset;
        _Contract.SetFilter(Status, '%1|%2|%3', _Contract.Status::Contract, _Contract.Status::FullPayment, _Contract.Status::Revocation);

        _RevocationContract.Reset;
        _RevocationContract.CalcFields("CRM Sales Type Seq");
        _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
        _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);

        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("OBJECT ID", OBJECTID);
        _KPITargetLine.SetRange(Status, _KPITargetLine.Status::Release);

        case pType of
            pType::Honostone:
                begin
                    _Contract.SetFilter("Supervise No.", 'H*');
                    _RevocationContract.SetFilter("Supervise No.", 'H*');
                end;
            pType::Cemtery:
                begin
                    _Contract.SetFilter("Supervise No.", '<>H*');
                    _RevocationContract.SetFilter("Supervise No.", '<>H*');
                end;
        end;

        _CRMSalesType.Reset;
        _CRMSalesType.SetRange(Item, _CRMSalesType.Item::Sales);
        _CRMSalesType.SetRange(Indicator, '1.˜¿——');
        if _CRMSalesType.FindSet then begin
            _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            //-------------------------------------------------- KPI ˆ±—Ñ ”À…Î Œ‚‘ñ
            case pType of
                pType::All:
                    _KPITargetLine.SetFilter("Report Taget Value Code", '%1|%2', '001', '006');  // HONO STONE - ˜¿——, °° ‰ª‘÷ - ˜¿——
                pType::Honostone:
                    _KPITargetLine.SetRange("Report Taget Value Code", '001');           // HONO STONE - ˜¿——
                pType::Cemtery:
                    _KPITargetLine.SetRange("Report Taget Value Code", '006');             // °° ‰ª‘÷ - ˜¿——
            end;

            Insert_SalesPerformance(pType, '˜¿——', _Contract, _RevocationContract, _KPITargetLine);
        end;

        _CRMSalesType.SetRange(Indicator, '2.˜ˆ°');
        if _CRMSalesType.FindSet then begin
            _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            //-------------------------------------------------- KPI ˆ±—Ñ ”À…Î Œ‚‘ñ
            case pType of
                pType::All:
                    _KPITargetLine.SetFilter("Report Taget Value Code", '%1|%2', '002', '007');  // HONO STONE - ˜ˆ°, °° ‰ª‘÷ - ˜ˆ°
                pType::Honostone:
                    _KPITargetLine.SetRange("Report Taget Value Code", '002');           // HONO STONE - ˜ˆ°
                pType::Cemtery:
                    _KPITargetLine.SetRange("Report Taget Value Code", '007');             // °° ‰ª‘÷ - ˜ˆ°
            end;

            Insert_SalesPerformance(pType, '˜ˆ°', _Contract, _RevocationContract, _KPITargetLine);
        end;

        _CRMSalesType.SetRange(Indicator, '3.Žð“Œ');
        if _CRMSalesType.FindSet then begin
            _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            //-------------------------------------------------- KPI ˆ±—Ñ ”À…Î Œ‚‘ñ
            case pType of
                pType::All:
                    _KPITargetLine.SetFilter("Report Taget Value Code", '%1|%2', '003', '008');  // HONO STONE - Žð“Œ, °° ‰ª‘÷ - Žð“Œ
                pType::Honostone:
                    _KPITargetLine.SetRange("Report Taget Value Code", '003');           // HONO STONE - Žð“Œ
                pType::Cemtery:
                    _KPITargetLine.SetRange("Report Taget Value Code", '008');             // °° ‰ª‘÷ - Žð“Œ
            end;

            Insert_SalesPerformance(pType, 'Žð“Œ', _Contract, _RevocationContract, _KPITargetLine);
        end;

        _CRMSalesType.SetRange(Indicator, '4.‘ª˜Ã');
        if _CRMSalesType.FindSet then begin
            _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            //-------------------------------------------------- KPI ˆ±—Ñ ”À…Î Œ‚‘ñ
            case pType of
                pType::All:
                    _KPITargetLine.SetFilter("Report Taget Value Code", '%1|%2', '004', '009');  // HONO STONE - ‘ª˜Ã, °° ‰ª‘÷ - ‘ª˜Ã
                pType::Honostone:
                    _KPITargetLine.SetRange("Report Taget Value Code", '004');           // HONO STONE - ‘ª˜Ã
                pType::Cemtery:
                    _KPITargetLine.SetRange("Report Taget Value Code", '009');             // °° ‰ª‘÷ - ‘ª˜Ã
            end;

            Insert_SalesPerformance(pType, '‘ª˜Ã', _Contract, _RevocationContract, _KPITargetLine);
        end;

        _CRMSalesType.SetRange(Indicator, '5.€Ë•ˆ');
        if _CRMSalesType.FindSet then begin
            _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
            //-------------------------------------------------- KPI ˆ±—Ñ ”À…Î Œ‚‘ñ
            case pType of
                pType::All:
                    _KPITargetLine.SetFilter("Report Taget Value Code", '%1|%2', '005', '010');  // HONO STONE - €Ë•ˆ, °° ‰ª‘÷ - €Ë•ˆ
                pType::Honostone:
                    _KPITargetLine.SetRange("Report Taget Value Code", '005');           // HONO STONE - €Ë•ˆ
                pType::Cemtery:
                    _KPITargetLine.SetRange("Report Taget Value Code", '010');             // °° ‰ª‘÷ - €Ë•ˆ
            end;

            Insert_SalesPerformance(pType, '€Ë•ˆ', _Contract, _RevocationContract, _KPITargetLine);
        end;
    end;

    local procedure Insert_SalesPerformance(pType: Option All,Honostone,Cemtery; pTypeText: Text; var pContract: Record DK_Contract; var pRevocationContract: Record "DK_Revocation Contract"; var pKPITargetLine: Record "DK_KPI Target Line")
    var
        _Contract: Record DK_Contract;
        _RevocationContract: Record "DK_Revocation Contract";
        _KPITargetLine: Record "DK_KPI Target Line";
    begin
        // µ‡žŠ ˆ•“Ë Insert

        //-------------------------------------------------- —š• Š‰‹Ï
        _Contract.Reset;
        _Contract.CopyFilters(pContract);

        _RevocationContract.Reset;
        _RevocationContract.CopyFilters(pRevocationContract);

        _KPITargetLine.Reset;
        _KPITargetLine.CopyFilters(pKPITargetLine);

        EntryNo += 1;
        Header.Init;
        Header."OBJECT ID" := REPORT::"DK_Sales Performance Status N";
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.TEXT0 := pTypeText;

        case pType of
            pType::All:
                begin
                    Header.INTEGER0 := 0;
                end;
            pType::Honostone:
                begin
                    Header.INTEGER0 := 1;
                end;
            pType::Cemtery:
                begin
                    Header.INTEGER0 := 2;
                end;
        end;

        //-------------------------------------------------- ˆ•“Ë
        _Contract.SetRange("Contract Date", ReferenceDate);
        if _Contract.FindSet then begin
            _Contract.CalcSums("Cemetery Amount");
            _Contract.CalcSums("Cemetery Class Discount");
            _Contract.CalcSums("Cemetery Discount");
            Header.INTEGER1 += _Contract.Count;
            Header.DECIMAL0 += _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount"; // ‰ª‘÷ ‹ÏÔ‡ß - ‰ª¬ …Ø€Ã—­ž - ‰ª¬ —­ž
        end;

        _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
        if _Contract.FindSet then begin
            _Contract.CalcSums("Cemetery Amount");
            _Contract.CalcSums("Cemetery Class Discount");
            _Contract.CalcSums("Cemetery Discount");
            Header.INTEGER2 += _Contract.Count;
            Header.DECIMAL1 += _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
        end;

        _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
        if _Contract.FindSet then begin
            _Contract.CalcSums("Cemetery Amount");
            _Contract.CalcSums("Cemetery Class Discount");
            _Contract.CalcSums("Cemetery Discount");
            Header.INTEGER3 += _Contract.Count;
            Header.DECIMAL3 += _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
        end;

        //-------------------------------------------------- ˜»Š­
        _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.INTEGER1 -= _RevocationContract.Count;
            Header.DECIMAL0 -= _RevocationContract."Sales Rev. Amount";
        end;

        _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.INTEGER2 -= _RevocationContract.Count;
            Header.DECIMAL1 -= _RevocationContract."Sales Rev. Amount";
        end;

        _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.INTEGER3 -= _RevocationContract.Count;
            Header.DECIMAL3 -= _RevocationContract."Sales Rev. Amount";
        end;

        //-------------------------------------------------- ˆ±—Ñ
        _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
        _KPITargetLine.SetRange(Month, Date2DMY(ReferenceDate, 2));
        if _KPITargetLine.FindSet then begin
            _KPITargetLine.CalcSums(Amount);
            Header.DECIMAL2 := _KPITargetLine.Amount;     // õú ˆ±—Ñ
        end;

        if Date2DMY(ReferenceDate, 2) = 12 then begin
            // 12õŸ µÕ ‚‹‚Ë…… ˆ±—Ñˆª í‘÷× ŽÈ —¯

            _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
            _KPITargetLine.SetRange(Month, 12);
            if _KPITargetLine.FindSet then begin
                _KPITargetLine.CalcSums(Amount);
                Header.DECIMAL4 += _KPITargetLine.Amount;                  // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                Header.DECIMAL5 += _KPITargetLine.Amount;                  // €ˆú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ —÷Ï ‘†˜ˆ ‚»’Ñ€Ø‘÷)
            end;

            //_KPITargetLine.SETRANGE(Month,1,DATE2DMY(ReferenceDate,2));  // €ˆú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ —÷Ï ‘†˜ˆ ‚»’Ñ€Ø‘÷)
            //IF _KPITargetLine.FINDSET THEN BEGIN
            //  _KPITargetLine.CALCSUMS(Amount);
            //  Header.DECIMAL5 += _KPITargetLine.Amount;
            //END;

            _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3) + 1);
            _KPITargetLine.SetRange(Month, 1, 11);                         // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
            if _KPITargetLine.FindSet then begin
                _KPITargetLine.CalcSums(Amount);
                Header.DECIMAL4 += _KPITargetLine.Amount;
            end;



        end else begin

            _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3) - 1);
            _KPITargetLine.SetRange(Month, 12);
            if _KPITargetLine.FindSet then begin
                _KPITargetLine.CalcSums(Amount);
                Header.DECIMAL4 += _KPITargetLine.Amount;                  // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
                Header.DECIMAL5 += _KPITargetLine.Amount;                  // €ˆú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ —÷Ï ‘†˜ˆ ‚»’Ñ€Ø‘÷)
            end;

            _KPITargetLine.SetRange(Year, Date2DMY(ReferenceDate, 3));
            _KPITargetLine.SetRange(Month, 1, 11);                         // ¼ú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ 20‚Ë 11õ€Ø‘÷)
            if _KPITargetLine.FindSet then begin
                _KPITargetLine.CalcSums(Amount);
                Header.DECIMAL4 += _KPITargetLine.Amount;
            end;

            _KPITargetLine.SetRange(Month, 1, Date2DMY(ReferenceDate, 2));  // €ˆú ˆ±—Ñ(˜ˆÐ‚Ë…… 19‚Ë 12õ ~ —÷Ï ‘†˜ˆ ‚»’Ñ€Ø‘÷)
            if _KPITargetLine.FindSet then begin
                _KPITargetLine.CalcSums(Amount);
                Header.DECIMAL5 += _KPITargetLine.Amount;
            end;

        end;

        //-------------------------------------------------- Š±
        // õú Š±
        if Header.DECIMAL2 <> 0 then
            Header.TEXT1 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL1 / Header.DECIMAL2 * 100), 0.1, '='));
        // ¼ú Š±
        if Header.DECIMAL4 <> 0 then
            Header.TEXT2 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL3 / Header.DECIMAL4 * 100), 0.1, '='));
        // €ˆú Š±
        if Header.DECIMAL5 <> 0 then
            Header.TEXT3 := StrSubstNo(PersantageMSG, Round((Header.DECIMAL3 / Header.DECIMAL5 * 100), 0.1, '='));

        //-------------------------------------------------- —³Ð

        case pType of
            pType::Honostone:
                begin
                    TotalDailyCnt[1] += Header.INTEGER1;
                    TotalDailyAmt[1] += Header.DECIMAL0;
                    TotalMonthCnt[1] += Header.INTEGER2;
                    TotalMonthAmt[1] += Header.DECIMAL1;
                    TotalMonthTarget[1] += Header.DECIMAL2;
                    TotalPeriodTarget[1] += Header.DECIMAL5;
                    TotalYearCnt[1] += Header.INTEGER3;
                    TotalYearAmt[1] += Header.DECIMAL3;
                    TotalYearTarget[1] += Header.DECIMAL4;
                end;
            pType::Cemtery:
                begin
                    TotalDailyCnt[2] += Header.INTEGER1;
                    TotalDailyAmt[2] += Header.DECIMAL0;
                    TotalMonthCnt[2] += Header.INTEGER2;
                    TotalMonthAmt[2] += Header.DECIMAL1;
                    TotalMonthTarget[2] += Header.DECIMAL2;
                    TotalPeriodTarget[2] += Header.DECIMAL5;
                    TotalYearCnt[2] += Header.INTEGER3;
                    TotalYearAmt[2] += Header.DECIMAL3;
                    TotalYearTarget[2] += Header.DECIMAL4;
                end;
        end;

        Header.Insert;
    end;

    local procedure Insert_ContractAmount()
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
        _PayRecDocLine: Record "DK_Payment Receipt Doc. Line";
        _Contract: Record DK_Contract;
        _CRMSalesType: Record "DK_CRM Sales Type";
    begin
        // „ÏŸ ý€Ë…˜ ÐŽÊ, Â€¦

        //---------------------------------------------------------¯€¦
        _PayRecDoc.Reset;
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Receipt);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("Posting Date", ReferenceDate);
        _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
        if _PayRecDoc.FindSet then begin
            repeat
                _PayRecDocLine.Reset;
                _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Document No.");
                _PayRecDocLine.SetFilter("Payment Target", '%1|%2|%3',
                            _PayRecDocLine."Payment Target"::Contract, _PayRecDocLine."Payment Target"::Deposit, _PayRecDocLine."Payment Target"::Remaining);
                if _PayRecDocLine.FindSet then begin
                    repeat
                        if _Contract.Get(_PayRecDoc."Contract No.") then begin
                            _Contract.CalcFields("Cemetery Dig. Name", "Cemetery Conf. Name", "Admin. Expense Method", "CRM SalesPerson");
                            EntryNo += 1;
                            Header.Init;
                            Header."OBJECT ID" := REPORT::"DK_Sales Performance Status N";
                            Header."USER ID" := UserId;
                            Header."Entry No." := EntryNo;
                            Header.INTEGER0 := 3;
                            // ------ €ˆŠ¨
                            if _Contract."Admin. Expense Method" = _Contract."Admin. Expense Method"::"After Corpse 10" then
                                Header.TEXT4 := HonoStoneMSG
                            else
                                Header.TEXT4 := CemeteryMSG;
                            // ------ µ‡ž
                            if _CRMSalesType.Get(_Contract."CRM Sales Type Seq") then
                                Header.TEXT5 := _CRMSalesType.Indicator;
                            // ------ ˆ•“ËŽ¸
                            Header.DECIMAL6 := _PayRecDocLine.Amount;
                            // ------ ÐŽÊÀ
                            Header.TEXT6 := _Contract."Main Customer Name";
                            // ------ ‰ª¬‰°˜ú
                            Header.TEXT7 := _Contract."Cemetery No.";
                            // ------ —ý•’
                            Header.TEXT8 := _Contract."Cemetery Conf. Name";
                            // ------ ºŒ÷
                            Header.TEXT9 := _Contract."Cemetery Dig. Name";
                            // ------ „Ì„Ï
                            Header.TEXT10 := _Contract."CRM SalesPerson";

                            Header.Insert;
                        end;
                    until _PayRecDocLine.Next = 0;
                end;
            until _PayRecDoc.Next = 0;
        end;

        //---------------------------------------------------------˜»Š­
        _PayRecDoc.Reset;
        _PayRecDoc.SetRange(Posted, true);
        _PayRecDoc.SetRange("Document Type", _PayRecDoc."Document Type"::Refund);
        _PayRecDoc.SetRange("Missing Contract", false);
        _PayRecDoc.SetRange("Payment Completion Date", ReferenceDate);
        _PayRecDoc.SetCurrentKey("Document Type", "Posting Date", Posted, "Missing Contract");
        if _PayRecDoc.FindSet then begin
            repeat
                _PayRecDocLine.Reset;
                _PayRecDocLine.SetCurrentKey("Document No.", "Payment Target");
                _PayRecDocLine.SetRange("Document No.", _PayRecDoc."Target Doc. No.");
                _PayRecDocLine.SetFilter("Payment Target", '%1|%2|%3',
                            _PayRecDocLine."Payment Target"::Contract, _PayRecDocLine."Payment Target"::Deposit, _PayRecDocLine."Payment Target"::Remaining);
                if _PayRecDocLine.FindSet then begin
                    repeat
                        if _Contract.Get(_PayRecDoc."Contract No.") then begin
                            _Contract.CalcFields("Cemetery Dig. Name", "Cemetery Conf. Name", "Admin. Expense Method", "CRM SalesPerson");
                            EntryNo += 1;
                            Header.Init;
                            Header."OBJECT ID" := REPORT::"DK_Sales Performance Status N";
                            Header."USER ID" := UserId;
                            Header."Entry No." := EntryNo;
                            Header.INTEGER0 := 3;
                            // ------ €ˆŠ¨
                            if _Contract."Admin. Expense Method" = _Contract."Admin. Expense Method"::"After Corpse 10" then
                                Header.TEXT4 := HonoStoneMSG
                            else
                                Header.TEXT4 := CemeteryMSG;
                            // ------ µ‡ž
                            if _CRMSalesType.Get(_Contract."CRM Sales Type Seq") then
                                Header.TEXT5 := _CRMSalesType.Indicator;
                            // ------ ˆ•“ËŽ¸
                            Header.DECIMAL6 := -(_PayRecDocLine.Amount);
                            // ------ ÐŽÊÀ
                            Header.TEXT6 := _Contract."Main Customer Name";
                            // ------ ‰ª¬‰°˜ú
                            Header.TEXT7 := _Contract."Cemetery No.";
                            // ------ —ý•’
                            Header.TEXT8 := _Contract."Cemetery Conf. Name";
                            // ------ ºŒ÷
                            Header.TEXT9 := _Contract."Cemetery Dig. Name";
                            // ------ „Ì„Ï
                            Header.TEXT10 := _Contract."CRM SalesPerson";

                            Header.Insert;
                        end;
                    until _PayRecDocLine.Next = 0;
                end;
            until _PayRecDoc.Next = 0;
        end;
    end;

    local procedure Insert_SalesPerson(pType: Option HonoStone,Cemetery)
    var
        _CRMSalesPerson: Record "DK_CRM SalesPerson";
        _Contract: Record DK_Contract;
        _RevContract: Record "DK_Revocation Contract";
    begin
        // …ŽðÀŠ ÐŽÊ ˆ•“Ë

        if SalesPersonFilter <> '' then begin
            _CRMSalesPerson.Reset;
            _CRMSalesPerson.SetRange(Blocked, false);
            _CRMSalesPerson.SetFilter(Code, SalesPersonFilter);
            if _CRMSalesPerson.FindSet then begin
                repeat
                    _Contract.Reset;
                    _Contract.SetFilter(Status, '%1|%2|%3', _Contract.Status::Contract, _Contract.Status::FullPayment, _Contract.Status::Revocation);
                    _Contract.SetRange("CRM SalesPerson Code", _CRMSalesPerson.Code);

                    _RevContract.Reset;
                    _RevContract.CalcFields("CRM SalesPerson Code");
                    _RevContract.SetRange("CRM SalesPerson Code", _CRMSalesPerson.Code);
                    _RevContract.SetRange(Status, _RevContract.Status::Complate);
                    _RevContract.SetRange("Contract Date", YearStartDate, ReferenceDate);

                    EntryNo += 1;
                    Header.Init;
                    Header."OBJECT ID" := REPORT::"DK_Sales Performance Status N";
                    Header."USER ID" := UserId;
                    Header."Entry No." := EntryNo;

                    if pType = pType::HonoStone then begin
                        Header.INTEGER0 := 4;
                        _Contract.SetFilter("Supervise No.", 'H*');
                        _RevContract.SetFilter("Supervise No.", 'H*');
                    end;
                    if pType = pType::Cemetery then begin
                        Header.INTEGER0 := 5;
                        _Contract.SetFilter("Supervise No.", '<>H*');
                        _RevContract.SetFilter("Supervise No.", '<>H*');
                    end;
                    // ------ „Ì„Ï
                    Header.TEXT0 := _CRMSalesPerson.Name;
                    //------------------------------------------------- ÐŽÊ —ø
                    // ------ Ÿú
                    _Contract.SetRange("Contract Date", ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("Cemetery Amount");
                        _Contract.CalcSums("Cemetery Class Discount");
                        _Contract.CalcSums("Cemetery Discount");
                        Header.INTEGER1 += _Contract.Count;
                        Header.DECIMAL0 += _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount"; // ‰ª‘÷ ‹ÏÔ‡ß - ‰ª¬ …Ø€Ã—­ž - ‰ª¬ —­ž
                    end;
                    // ------ õú
                    _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("Cemetery Amount");
                        _Contract.CalcSums("Cemetery Class Discount");
                        _Contract.CalcSums("Cemetery Discount");
                        Header.INTEGER2 += _Contract.Count;
                        Header.DECIMAL1 += _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
                    end;
                    // ------ ¼ú
                    _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
                    if _Contract.FindSet then begin
                        _Contract.CalcSums("Cemetery Amount");
                        _Contract.CalcSums("Cemetery Class Discount");
                        _Contract.CalcSums("Cemetery Discount");
                        Header.INTEGER3 += _Contract.Count;
                        Header.DECIMAL3 += _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
                    end;
                    //-------------------------------------------------- —¹ŽÊ
                    _RevContract.SetRange("Payment Completion Date", ReferenceDate);
                    if _RevContract.FindSet then begin
                        _RevContract.CalcSums("Sales Rev. Amount");
                        Header.INTEGER1 -= _RevContract.Count;
                        Header.DECIMAL0 -= _RevContract."Sales Rev. Amount";
                    end;

                    _RevContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
                    if _RevContract.FindSet then begin
                        _RevContract.CalcSums("Sales Rev. Amount");
                        Header.INTEGER2 -= _RevContract.Count;
                        Header.DECIMAL1 -= _RevContract."Sales Rev. Amount";
                    end;

                    _RevContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                    if _RevContract.FindSet then begin
                        _RevContract.CalcSums("Sales Rev. Amount");
                        Header.INTEGER3 -= _RevContract.Count;
                        Header.DECIMAL3 -= _RevContract."Sales Rev. Amount";
                    end;
                    //-------------------------------------------------- —³Ð
                    TotalDailyCnt[4] += Header.INTEGER1;
                    TotalDailyAmt[4] += Header.DECIMAL0;
                    TotalMonthCnt[4] += Header.INTEGER2;
                    TotalMonthAmt[4] += Header.DECIMAL1;
                    TotalYearCnt[4] += Header.INTEGER3;
                    TotalYearAmt[4] += Header.DECIMAL3;

                    Header.Insert;
                until _CRMSalesPerson.Next = 0;
            end;
        end;
    end;
}

