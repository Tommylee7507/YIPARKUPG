report 50038 "DK_Customer Salesman Status"
{
    // //Žð“Œ •‡í“‚ …ŽðÀ —÷˜
    // *DK11
    //   - Data Source : INTEGER0, Name : IndexNo
    //   - 1: Žð“Œ •‡í“‚ …ŽðÀ —÷˜
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCustomerSalesmanStatus.rdl';

    Caption = 'Customer Salesman Status';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            UseTemporary = true;
            column(IndexNo; INTEGER0)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(ChannelVendor; TEXT0)
            {
            }
            column(MonthCount; INTEGER1)
            {
            }
            column(YearCount; INTEGER2)
            {
            }
            column(DailyCont; INTEGER3)
            {
            }
            column(MonthAmount; DECIMAL0)
            {
            }
            column(YearAmount; DECIMAL1)
            {
            }
            column(DailyAmount; DECIMAL2)
            {
            }
            column(ReferenceDateText; ReferenceDateText)
            {
            }

            trigger OnPreDataItem()
            var
                _CRMExternalSales: Record "DK_CRM External Sales";
                _Contract: Record DK_Contract;
                _RevocationContract: Record "DK_Revocation Contract";
                _MonthStartDate: Date;
                _YearStartDate: Date;
                _ContractCount: Integer;
                _CRMSalesType: Record "DK_CRM Sales Type";
            begin

                MonthStartDate := CalcDate('<-CM>', ReferenceDate);
                if Date2DMY(ReferenceDate, 2) = 12 then
                    YearStartDate := CalcDate('<-CM>', ReferenceDate)
                else
                    YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));

                ReferenceDateText := StrSubstNo(RefDateMSG, Format(ReferenceDate, 0, '<Year4>-<Month,2>-<Day,2>'));

                _Contract.Reset;
                _Contract.SetFilter(Status, '%1|%2|%3', _Contract.Status::Contract, _Contract.Status::FullPayment, _Contract.Status::Revocation);

                _RevocationContract.Reset;
                _RevocationContract.CalcFields("CRM Sales Type Seq");
                _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
                _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);

                _CRMSalesType.Reset;
                _CRMSalesType.SetRange(Indicator, '3.Žð“Œ');
                if _CRMSalesType.FindSet then begin
                    _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                    _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);
                end;


                _CRMExternalSales.Reset;
                if _CRMExternalSales.FindSet then begin
                    repeat
                        _RevocationContract.CalcFields("CRM External Sales Code");
                        _ContractCount := 0;

                        _Contract.SetRange("CRM External Sales Code", _CRMExternalSales.Code);
                        _RevocationContract.SetRange("CRM External Sales Code", _CRMExternalSales.Code);

                        _Contract.SetRange("Contract Date", ReferenceDate);
                        _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
                        if _Contract.FindSet then
                            _ContractCount += 1;
                        if _RevocationContract.FindSet then
                            _ContractCount += 1;

                        _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
                        _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
                        if _Contract.FindSet then
                            _ContractCount += 1;
                        if _RevocationContract.FindSet then
                            _ContractCount += 1;

                        _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
                        _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                        if _Contract.FindSet then
                            _ContractCount += 1;
                        if _RevocationContract.FindSet then
                            _ContractCount += 1;

                        if _ContractCount <> 0 then
                            Insert_CRMChannel(_CRMExternalSales.Code, _CRMExternalSales.Name);
                    until _CRMExternalSales.Next = 0;
                end;

                _ContractCount := 0;
                _RevocationContract.CalcFields("CRM External Sales Code");

                _Contract.SetRange("CRM External Sales Code", '');
                _RevocationContract.SetRange("CRM External Sales Code", '');

                _Contract.SetRange("Contract Date", ReferenceDate);
                _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
                if _Contract.FindSet then
                    _ContractCount += 1;
                if _RevocationContract.FindSet then
                    _ContractCount += 1;

                _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
                _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
                if _Contract.FindSet then
                    _ContractCount += 1;
                if _RevocationContract.FindSet then
                    _ContractCount += 1;

                _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
                _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
                if _Contract.FindSet then
                    _ContractCount += 1;
                if _RevocationContract.FindSet then
                    _ContractCount += 1;

                if _ContractCount <> 0 then
                    Insert_CRMChannel('', BlankMSG);
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
        Titlelb1 = 'Žð“Œ Š¨Œ« Šˆ×Œ¡';
        Caplb1 = '€ˆŠ¨';
        Caplb2 = 'ŸŸ';
        Caplb3 = 'õú';
        Caplb4 = '¼ú';
        Caplb5 = '—³Ð';
        Caplb6 = '“©Ð';
        Caplb7 = '–Û€³';
        Caplb8 = '—Œ÷';
        Caplb9 = '€¦Ž¸';
        Caplb10 = '(„Âº : €Ë/°)';
    }

    var
        ReferenceDate: Date;
        EntryNo: Integer;
        ReferenceDateText: Text;
        RefDateMSG: Label 'ÐŽÊŸÀ : %1';
        MonthStartDate: Date;
        YearStartDate: Date;
        MSG001: Label 'You cannot enter a date larger than %1.';
        BlankMSG: Label 'Blank';

    local procedure ReferenceDate_OnValidate()
    begin

        if ReferenceDate > WorkDate then
            Error(MSG001, WorkDate);
    end;

    local procedure Insert_CRMChannel(pVendorNo: Code[20]; pVendorName: Text)
    var
        _Contract: Record DK_Contract;
        _DailyAmount: Decimal;
        _MonthAmount: Decimal;
        _YearAmount: Decimal;
        _RevocationContract: Record "DK_Revocation Contract";
        _DailyCount: Integer;
        _MonthCount: Integer;
        _YearCount: Integer;
        _CRMSalesType: Record "DK_CRM Sales Type";
    begin

        EntryNo += 1;

        Header.Init;
        Header."OBJECT ID" := REPORT::"DK_Customer Salesman Status";
        Header."USER ID" := UserId;
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 1; // Žð“Œ •‡í“‚ …ŽðÀ —÷˜
        Header.TEXT0 := pVendorName;

        _Contract.Reset;
        _Contract.SetRange("CRM External Sales Code", pVendorNo);
        _Contract.SetFilter(Status, '%1|%2|%3', _Contract.Status::Contract, _Contract.Status::FullPayment, _Contract.Status::Revocation);

        _CRMSalesType.Reset;
        _CRMSalesType.SetRange(Indicator, '3.Žð“Œ');
        if _CRMSalesType.FindSet then
            _Contract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);

        _Contract.SetRange("Contract Date", ReferenceDate);
        if _Contract.FindSet then begin
            _Contract.CalcSums("Cemetery Amount");
            _Contract.CalcSums("Cemetery Class Discount");
            _Contract.CalcSums("Cemetery Discount");
            _DailyCount := _Contract.Count;
            _DailyAmount := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount"; //‰ª‘÷ ‹ÏÔ‡ß - ‰ª‘÷…Ø€Ã—­ž - ‰ª‘÷—­ž
        end;

        _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
        if _Contract.FindSet then begin
            _Contract.CalcSums("Cemetery Amount");
            _Contract.CalcSums("Cemetery Class Discount");
            _Contract.CalcSums("Cemetery Discount");
            _MonthCount := _Contract.Count;
            _MonthAmount := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
        end;

        _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
        if _Contract.FindSet then begin
            _Contract.CalcSums("Cemetery Amount");
            _Contract.CalcSums("Cemetery Class Discount");
            _Contract.CalcSums("Cemetery Discount");
            _YearCount := _Contract.Count;
            _YearAmount := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
        end;

        _RevocationContract.Reset;
        _RevocationContract.CalcFields("CRM External Sales Code", "CRM Sales Type Seq");
        if _CRMSalesType.FindSet then
            _RevocationContract.SetRange("CRM Sales Type Seq", _CRMSalesType.Seq);

        _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
        _RevocationContract.SetRange("CRM External Sales Code", pVendorNo);
        _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);
        _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.DECIMAL2 := _DailyAmount - _RevocationContract."Sales Rev. Amount";
            Header.INTEGER3 := _DailyCount - _RevocationContract.Count;
        end else begin
            Header.DECIMAL2 := _DailyAmount;
            Header.INTEGER3 := _DailyCount;
        end;

        _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.DECIMAL0 := _MonthAmount - _RevocationContract."Sales Rev. Amount";
            Header.INTEGER1 := _MonthCount - _RevocationContract.Count;
        end else begin
            Header.DECIMAL0 := _MonthAmount;
            Header.INTEGER1 := _MonthCount;
        end;

        _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
        if _RevocationContract.FindSet then begin
            _RevocationContract.CalcSums("Sales Rev. Amount");
            Header.DECIMAL1 := _YearAmount - _RevocationContract."Sales Rev. Amount";
            Header.INTEGER2 := _YearCount - _RevocationContract.Count;
        end else begin
            Header.DECIMAL1 := _YearAmount;
            Header.INTEGER2 := _YearCount;
        end;

        Header.Insert;
    end;
}

