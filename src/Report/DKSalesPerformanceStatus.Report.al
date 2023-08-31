report 50037 "DK_Sales Performance Status"
{
    // //ÐŽÊ Š¨Œ« Šˆ×Œ¡
    // *DK11
    //   - Data Source : INTEGER0, Name : ReportVisible
    //   - 0: µ‡žŠ ˆ•“Ë •ÔÐ , 1: Ÿú µ‡žŠ ˆ•“Ë
    // 
    //   - Data Source : INTEGER4, Name : ColorType
    //   - 1: Red font
    // 
    // DK34: 20201203
    //   - Modify Report Caption: ÐŽÊ Š¨Œ« Šˆ×Œ¡ -> ˆ•“Ë Š¨Œ« Šˆ×Œ¡
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKSalesPerformanceStatus.rdl';

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
            column(Type; TEXT0)
            {
            }
            column(ColorType; INTEGER4)
            {
            }
            column(ReportVisible; INTEGER0)
            {
            }
            column(SalesTypeDailyCount; INTEGER1)
            {
            }
            column(SalesTypeDailyAmount; DECIMAL0)
            {
            }
            column(SalesTypeMonthCount; INTEGER2)
            {
            }
            column(SalesTypeMonthAmount; DECIMAL1)
            {
            }
            column(SalesTypeYearCount; INTEGER3)
            {
            }
            column(SalesTypeYearAmount; DECIMAL2)
            {
            }
            column(DailySalesSorting; CODE0)
            {
            }
            column(DailySalesCemeteryConf; TEXT1)
            {
            }
            column(DailySalesCemeteryDigit; TEXT2)
            {
            }
            column(DailySalesCemeteryNo; TEXT3)
            {
            }
            column(DailySalesMainCustomer; TEXT4)
            {
            }
            column(DailySalesCemeteryAmount; DECIMAL3)
            {
            }
            column(DailySalesCRMSalesPerson; TEXT5)
            {
            }
            column(ReferenceDate; ReferenceDateText)
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
                Clear(Contract);
                MonthStartDate := CalcDate('<-CM>', ReferenceDate);
                if Date2DMY(ReferenceDate, 2) = 12 then
                    YearStartDate := CalcDate('<-CM>', ReferenceDate)
                else
                    YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));
                ReferenceDateText := Format(ReferenceDate, 0, ReferenceMSG);

                Contract.CalcFields("CRM SalesPerson", "CRM External Sales", "Cemetery Dig. Name");
                Contract.SetFilter(Status, '%1|%2|%3', Contract.Status::Contract, Contract.Status::FullPayment, Contract.Status::Revocation);

                _CRMSalesType.Reset;
                _CRMSalesType.SetRange(Item, _CRMSalesType.Item::Sales);
                _CRMSalesType.SetRange(Indicator, '1.˜¿——');
                if _CRMSalesType.FindSet then begin
                    Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                    SetSalesType(_CRMSalesType.Indicator, _CRMSalesType.Seq);
                    SetDailySalesType(_CRMSalesType.Indicator);
                end;

                _CRMSalesType.SetRange(Indicator, '2.˜ˆ°');
                if _CRMSalesType.FindSet then begin
                    Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                    SetSalesType(_CRMSalesType.Indicator, _CRMSalesType.Seq);
                    SetDailySalesType(_CRMSalesType.Indicator);
                end;

                _CRMSalesType.SetRange(Indicator, '3.Žð“Œ');
                if _CRMSalesType.FindSet then begin
                    Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                    SetSalesType(_CRMSalesType.Indicator, _CRMSalesType.Seq);
                    SetDailySalesType(_CRMSalesType.Indicator);
                end;

                _CRMSalesType.SetRange(Indicator, '4.‘ª˜Ã');
                if _CRMSalesType.FindSet then begin
                    Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                    SetSalesType(_CRMSalesType.Indicator, _CRMSalesType.Seq);
                    SetDailySalesType(_CRMSalesType.Indicator);
                end;

                _CRMSalesType.SetRange(Indicator, '5.€Ë•ˆ');
                if _CRMSalesType.FindSet then begin
                    Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                    SetSalesType(_CRMSalesType.Indicator, _CRMSalesType.Seq);
                    SetDailySalesType(_CRMSalesType.Indicator);
                end;

                SetDailyRevocationType;
            end;
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
                        ReferenceDate_OnValidate;
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
        Cap01Lb = '(„Âº : €Ë/°)';
        Cap02Lb = '€ˆŠ¨';
        Cap03Lb = 'µ‡ž';
        Cap04Lb = 'ŸŸ';
        Cap05Lb = 'õú';
        Cap06Lb = '¼ú';
        Cap07Lb = '—Œ÷';
        Cap08Lb = '€¦Ž¸';
        Cap09Lb = '“©Ð';
        Cap10Lb = '–Û€³';
        Cap11Lb = '—ý•’';
        Cap12Lb = 'ºŒ÷';
        Cap13Lb = '‰ª¬‰°˜ú';
        Cap14Lb = 'ÐŽÊÀ';
        Cap15Lb = 'ˆ•“ËŽ¸';
        Cap16Lb = '„Ì„Ï';
        Cap17Lb = 'Š±×';
        Cap18Lb = '—³Ð';
        Cap19Lb = '—';
        Cap20Lb = '°';
    }

    var
        ReferenceDate: Date;
        MSG001: Label 'Date greater than today (%1) is not available.';
        MonthStartDate: Date;
        YearStartDate: Date;
        Contract: Record DK_Contract;
        EntryNo: Integer;
        ReferenceDateText: Text;
        ReferenceMSG: Label 'Reference Date : <Year4>-<Month,2>-<Day,2>';

    local procedure ReferenceDate_OnValidate()
    begin

        if ReferenceDate > Today then
            Error(MSG001, Today);
    end;

    local procedure SetSalesType(pTypeText: Text; pTypeSeq: Integer)
    var
        _DailyAmount: Decimal;
        _MonthAmont: Decimal;
        _YearAmount: Decimal;
        _DaillyCount: Integer;
        _MonthCount: Integer;
        _YearCount: Integer;
        _RevocationContract: Record "DK_Revocation Contract";
        _Contract: Record DK_Contract;
        _DupliRevocationContract: Record "DK_Revocation Contract";
    begin
        //µ‡žŠ ˆ•“Ë •ÔÐ

        EntryNo += 1;

        Header.Init;
        Header."OBJECT ID" := REPORT::"DK_Sales Performance Status";
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 0;
        Header.TEXT0 := pTypeText;

        Contract.SetRange("Contract Date", ReferenceDate);
        if Contract.FindSet then begin
            Contract.CalcSums("Cemetery Amount");
            Contract.CalcSums("Cemetery Class Discount");
            Contract.CalcSums("Cemetery Discount");
            _DaillyCount := Contract.Count;
            _DailyAmount := Contract."Cemetery Amount" - Contract."Cemetery Class Discount" - Contract."Cemetery Discount"; // ‰ª‘÷ ‹ÏÔ‡ß - ‰ª¬ …Ø€Ã—­ž - ‰ª¬ —­ž
        end;

        Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
        if Contract.FindSet then begin
            Contract.CalcSums("Cemetery Amount");
            Contract.CalcSums("Cemetery Class Discount");
            Contract.CalcSums("Cemetery Discount");
            _MonthCount := Contract.Count;
            _MonthAmont := Contract."Cemetery Amount" - Contract."Cemetery Class Discount" - Contract."Cemetery Discount";
        end;

        Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
        if Contract.FindSet then begin
            Contract.CalcSums("Cemetery Amount");
            Contract.CalcSums("Cemetery Class Discount");
            Contract.CalcSums("Cemetery Discount");
            _YearCount := Contract.Count;
            _YearAmount := Contract."Cemetery Amount" - Contract."Cemetery Class Discount" - Contract."Cemetery Discount";
        end;

        _RevocationContract.Reset;
        _RevocationContract.CalcFields("CRM Sales Type Seq");
        _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
        _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);
        _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
        _RevocationContract.SetRange("CRM Sales Type Seq", pTypeSeq);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.DECIMAL0 := _DailyAmount - _RevocationContract."Sales Rev. Amount";
            Header.INTEGER1 := _DaillyCount - _RevocationContract.Count;
        end else begin
            Header.DECIMAL0 := _DailyAmount;
            Header.INTEGER1 := _DaillyCount;
        end;

        _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.DECIMAL1 := _MonthAmont - _RevocationContract."Sales Rev. Amount";
            Header.INTEGER2 := _MonthCount - _RevocationContract.Count;
        end else begin
            Header.DECIMAL1 := _MonthAmont;
            Header.INTEGER2 := _MonthCount;
        end;

        _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.DECIMAL2 := _YearAmount - _RevocationContract."Sales Rev. Amount";
            Header.INTEGER3 := _YearCount - _RevocationContract.Count;
        end else begin
            Header.DECIMAL2 := _YearAmount;
            Header.INTEGER3 := _YearCount;
        end;

        Header.Insert;
    end;

    local procedure SetDailySalesType(pTypeText: Text)
    begin
        //Ÿú µ‡žŠ ˆ•“Ë

        Contract.SetRange("Contract Date");
        Contract.SetRange("Contract Date", ReferenceDate);
        if Contract.FindSet then begin
            repeat
                Contract.CalcFields("Cemetery Conf. Name", "Cemetery Dig. Name", "CRM SalesPerson");
                EntryNo += 1;

                Header.Init;
                Header."OBJECT ID" := REPORT::"DK_Sales Performance Status";
                Header."USER ID" := UserId;
                Header."Entry No." := EntryNo;
                Header.INTEGER0 := 1;   //Ÿú µ‡žŠ ˆ•“Ë
                Header.CODE0 := 'ÐŽÊ'; //Ÿú µ‡žŠ ˆ•“Ë Š¨‡õ¬
                Header.TEXT0 := pTypeText;

                Header.TEXT1 := Contract."Cemetery Conf. Name";
                Header.TEXT2 := Contract."Cemetery Dig. Name";
                Header.TEXT3 := Contract."Cemetery No.";
                Header.TEXT4 := Contract."Main Customer Name";
                Header.DECIMAL3 := Contract."Cemetery Amount" - Contract."Cemetery Class Discount" - Contract."Cemetery Discount";
                Header.TEXT5 := Contract."CRM SalesPerson";

                Header.Insert;
            until Contract.Next = 0;
        end;
    end;

    local procedure SetDailyRevocationType()
    var
        _RevocationContract: Record "DK_Revocation Contract";
        _Contract: Record DK_Contract;
        _CRMSalesType: Record "DK_CRM Sales Type";
    begin
        _RevocationContract.Reset;
        _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
        _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);
        _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
        if _RevocationContract.FindSet then begin
            repeat
                if _RevocationContract."Refund Cemetery Amount" <> 0 then begin
                    _Contract.Reset;
                    _Contract.SetRange("No.", _RevocationContract."Contract No.");
                    if _Contract.FindSet then begin
                        _Contract.CalcFields("Cemetery Conf. Name", "Cemetery Dig. Name", "CRM SalesPerson");
                        EntryNo += 1;

                        Header.Init;
                        Header."OBJECT ID" := REPORT::"DK_Sales Performance Status";
                        Header."USER ID" := UserId;
                        Header."Entry No." := EntryNo;
                        Header.INTEGER0 := 1;   //Ÿú µ‡žŠ ˆ•“Ë
                        Header.INTEGER4 := 1;   //—¹ŽÊ –õ–«‹÷‹Ý Š®Š‹÷
                        Header.CODE0 := '—¹ŽÊ'; //Ÿú µ‡žŠ ˆ•“Ë Š¨‡õ¬

                        _CRMSalesType.Reset;
                        _CRMSalesType.SetRange(Seq, _Contract."CRM Sales Type Seq");
                        if _CRMSalesType.FindSet then
                            Header.TEXT0 := _CRMSalesType.Indicator;

                        Header.TEXT1 := _Contract."Cemetery Conf. Name";
                        Header.TEXT2 := _Contract."Cemetery Dig. Name";
                        Header.TEXT3 := _Contract."Cemetery No.";
                        Header.TEXT4 := _Contract."Main Customer Name";
                        Header.DECIMAL3 := -_RevocationContract."Refund Cemetery Amount";
                        Header.TEXT5 := _Contract."CRM SalesPerson";

                        Header.Insert;
                    end;
                end;
            until _RevocationContract.Next = 0;
        end;
    end;
}

