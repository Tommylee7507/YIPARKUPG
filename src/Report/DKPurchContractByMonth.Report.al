report 50040 "DK_Purch. Contract By Month"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKPurchContractByMonth.rdl';
    Caption = 'Purchase Contract By Month';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(RecDate; Date)
        {
            DataItemTableView = SORTING("Period Type", "Period Start") WHERE("Period Type" = CONST(Month));
            column(YearMonth_; Format(RecDate."Period Start", 0, '<Year4>-<Month,2>'))
            {
            }
            column(NewContract_; NewContract)
            {
                AutoFormatType = 1;
            }
            column(ExtContract_; ExtContract)
            {
                AutoFormatType = 1;
            }
            column(DueContract_; DueContract)
            {
                AutoFormatType = 1;
            }
            column(DuetoExpireContract_; DuetoExpireContract)
            {
            }
            column(PringDate_; Format(WorkDate, 0, '<Year4>-<Month,2>-<Day,2>'))
            {
            }

            trigger OnAfterGetRecord()
            begin

                MonthContract(RecDate."Period Start", NewContract, ExtContract, DueContract);
            end;

            trigger OnPreDataItem()
            begin

                ExtContractFind;

                RecDate.SetRange("Period Type", RecDate."Period Type"::Month);
                RecDate.SetRange("Period Start", DMY2Date(1, 1, YearFilter), DMY2Date(31, 12, YearFilter));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(YearFilter; YearFilter)
                {
                    BlankZero = true;
                    Caption = 'Year Filter';
                    MaxValue = 2999;
                    MinValue = 1900;

                    trigger OnValidate()
                    begin
                        if YearFilter = 0 then
                            Error(MSG001);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Lbl001 = 'Monthly Contract Expiration and Extension';
        Lbl002 = 'Print Date';
        Lbl003 = 'Base Date (Year-Month)';
        Lbl004 = 'New';
        Lbl005 = 'Extension';
        Lbl006 = 'Expire';
        Lbl007 = 'Due to Expire';
        Lbl008 = 'Total';
    }

    trigger OnInitReport()
    begin
        YearFilter := Date2DWY(Today, 3);
        BaseDate := WorkDate;
    end;

    var
        NewContract: Decimal;
        ExtContract: Decimal;
        DueContract: Decimal;
        DuetoExpireContract: Decimal;
        YearFilter: Integer;
        MSG001: Label 'Please specify a Year Filter.';
        ArrMonthCount: array[12] of Decimal;
        BaseDate: Date;

    local procedure MonthContract(pDate: Date; var pNewContract: Decimal; var pExtContract: Decimal; var pDueContract: Decimal)
    var
        _PurchContract: Record "DK_Purchase Contract";
        _StartDate: Date;
        _EndDate: Date;
    begin

        _StartDate := CalcDate('<-CM>', pDate);
        _EndDate := CalcDate('<+CM>', pDate);

        NewContract := 0;
        ExtContract := 0;
        DueContract := 0;

        //•€¯ ÐŽÊ —Œ÷
        _PurchContract.Reset;
        _PurchContract.SetRange("Contract Date", _StartDate, _EndDate);
        if _PurchContract.FindSet then
            NewContract := _PurchContract.Count;


        //¼Î ÐŽÊ
        ExtContract := ArrMonthCount[Date2DMY(pDate, 2)];

        //ˆˆ€Ë —Œ÷
        if (_StartDate <= BaseDate) and (_EndDate >= BaseDate) then
            _EndDate := BaseDate - 1;

        _PurchContract.Reset;
        _PurchContract.SetRange("Max Contract Date To", _StartDate, _EndDate);
        _PurchContract.SetFilter(Status, '%1', _PurchContract.Status::Expiration);
        if _PurchContract.FindSet then
            DueContract := _PurchContract.Count;

        //ˆˆ€Ë ‰‘ñ —Œ÷
        _StartDate := CalcDate('<-CM>', pDate);
        _EndDate := CalcDate('<+CM>', pDate);

        if (_StartDate <= BaseDate) and (_EndDate >= BaseDate) then begin
            _StartDate := BaseDate;

            _PurchContract.Reset;
            _PurchContract.SetRange("Max Contract Date To", _StartDate, _EndDate);
            _PurchContract.SetFilter(Status, '%1', _PurchContract.Status::Contract);
            if _PurchContract.FindSet then
                DuetoExpireContract := _PurchContract.Count;
        end;
    end;

    local procedure ExtContractFind()
    var
        _PurchContract: Record "DK_Purchase Contract";
        _StartDate: Date;
        _PurchContractLine: Record "DK_Purchase Contract Line";
    begin
        //‚Ë…… —š• œý ÐŽÊ—…Ò ‘È
        //‚Ë…… —š• €Ëúí ‹• ‚‹¬œ ´„’‘÷ Šž ˜«ž

        _StartDate := DMY2Date(1, 1, YearFilter);

        Clear(ArrMonthCount);

        _PurchContract.Reset;
        _PurchContract.SetFilter("Contract Date", '<%1', _StartDate);
        _PurchContract.SetRange(Status, _PurchContract.Status::Contract);
        if _PurchContract.FindSet then begin
            repeat

                _PurchContractLine.Reset;
                _PurchContractLine.SetRange("Purchase Contract No.", _PurchContract."No.");
                _PurchContractLine.SetRange("Contract Date From", DMY2Date(1, 1, YearFilter), DMY2Date(31, 12, YearFilter));
                if _PurchContractLine.FindSet then
                    ArrMonthCount[Date2DMY(_PurchContract."Contract Date", 2)] += 1;

            until _PurchContract.Next = 0;
        end;
    end;
}

