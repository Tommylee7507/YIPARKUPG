report 50041 "DK_Sales Product Status" ////zzz
{
    // // //‹Ý –—ˆ• —÷˜
    // // *DK11
    // //   - Data Source : CODE0, Name : ReportKey1
    // //   - CemeteryConfCode
    // // 
    // //   - Data Source : CODE1, Name : ReportKey2
    // //   - CemeteryDigitCode
    // // 
    // //   - Data Source : INTEGER3, Name : ReportVsible
    // //   - 1 : ‹Ý –—ˆ• —÷˜
    // DefaultLayout = RDLC;
    // RDLCLayout = './src/layout/DKSalesProductStatus.rdl';

    // Caption = 'Sales Product Satus';
    // PreviewMode = PrintLayout;
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;

    // dataset
    // {
    //     dataitem(Header; "DK_Report Buffer")
    //     {
    //         DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
    //         UseTemporary = true;
    //         column(EntryNo; "Entry No.")
    //         {
    //         }
    //         column(ReportKey1; CODE0)
    //         {
    //         }
    //         column(ReportKey2; CODE1)
    //         {
    //         }
    //         column(ReportVisible; INTEGER3)
    //         {
    //         }
    //         column(CemeteryConfName; TEXT0)
    //         {
    //         }
    //         column(CemeteryDigitName; TEXT1)
    //         {
    //         }
    //         column(ProductDailyCount; Header.INTEGER0)
    //         {
    //         }
    //         column(ProductDailyAmount; Header.DECIMAL0)
    //         {
    //         }
    //         column(ProductMonthCount; Header.INTEGER1)
    //         {
    //         }
    //         column(ProductMonthAmount; Header.DECIMAL1)
    //         {
    //         }
    //         column(ProductYearCount; Header.INTEGER2)
    //         {
    //         }
    //         column(ProductYearAmount; Header.DECIMAL2)
    //         {
    //         }
    //         column(ReferenceDaeText; ReferenceDateText)
    //         {
    //         }
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             field(ReferenceDate; ReferenceDate)
    //             {
    //                 Caption = 'Reference Date';

    //                 trigger OnValidate()
    //                 begin
    //                     ReferenceDate_Onvalidate;
    //                 end;
    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }

    //     trigger OnOpenPage()
    //     begin

    //         ReferenceDate := WorkDate;
    //     end;
    // }

    // labels
    // {
    //     Title01Lb = '‹Ý— Š¨Œ« Šˆ×Œ¡';
    //     Cap01Lb = '—ý•’';
    //     Cap02Lb = 'ºŒ÷';
    //     Cap03Lb = 'ŸŸ';
    //     Cap04Lb = 'õú';
    //     Cap05Lb = '¼ú';
    //     Cap06Lb = '—Œ÷';
    //     Cap07Lb = '€¦Ž¸';
    //     Cap08Lb = '“©Ð';
    //     Cap09Lb = '–Û€³';
    //     Cap10Lb = '(„Âº : €Ë/°)';
    //     Cap11Lb = '—³Ð';
    // }

    // trigger OnPreReport()
    // var
    //     _CemeteryConformation: Record "DK_Cemetery Conformation";
    //     _CemeteryDigits: Record "DK_Cemetery Digits";
    //     _ContractCount: Integer;
    //     _Contract: Record DK_Contract;
    //     _RevocationContract: Record "DK_Revocation Contract";
    // begin
    //     Clear(MonthStartDate);
    //     Clear(YearStartDate);
    //     Clear(ReferenceDateText);
    //     Clear(EntryNo);

    //     MonthStartDate := CalcDate('<-CM>', ReferenceDate);
    //     if Date2DMY(ReferenceDate, 2) = 12 then
    //         YearStartDate := CalcDate('<-CM>', ReferenceDate)
    //     else
    //         YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));
    //     ReferenceDateText := Format(ReferenceDate, 0, ReferenceMSG);

    //     _Contract.Reset;
    //     _Contract.SetFilter(Status, '%1|%2|%3', _Contract.Status::Contract, _Contract.Status::FullPayment, _Contract.Status::Revocation);
    //     _Contract.CalcFields("Cemetery Conf. Code", "Cemetery Dig. Code");

    //     _RevocationContract.Reset;
    //     _RevocationContract.CalcFields("Cemetery Conf. Code", "Cemetery Digits Code");
    //     _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
    //     _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);

    //     _CemeteryConformation.Reset;
    //     if _CemeteryConformation.FindSet then begin
    //         repeat
    //             _CemeteryDigits.Reset;
    //             _CemeteryDigits.SetRange("Cemetery Conf. Code", _CemeteryConformation.Code);
    //             if _CemeteryDigits.FindSet then begin
    //                 repeat
    //                     Insert_ProductStatus(_CemeteryConformation.Code, _CemeteryConformation.Name, _CemeteryDigits.Code, _CemeteryDigits.Name);
    //                 until _CemeteryDigits.Next = 0;
    //                 _ContractCount := 0;

    //                 _Contract.SetRange("Cemetery Conf. Code", _CemeteryConformation.Code);
    //                 _Contract.SetRange("Cemetery Dig. Code", '');
    //                 _RevocationContract.SetRange("Cemetery Conf. Code", _CemeteryConformation.Code);
    //                 _RevocationContract.SetRange("Cemetery Digits Code", '');

    //                 _Contract.SetRange("Contract Date", ReferenceDate);
    //                 _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
    //                 if _Contract.FindSet then
    //                     _ContractCount += 1;
    //                 if _RevocationContract.FindSet then
    //                     _ContractCount += 1;

    //                 _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
    //                 _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
    //                 if _Contract.FindSet then
    //                     _ContractCount += 1;
    //                 if _RevocationContract.FindSet then
    //                     _ContractCount += 1;

    //                 _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
    //                 _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
    //                 if _Contract.FindSet then
    //                     _ContractCount += 1;
    //                 if _RevocationContract.FindSet then
    //                     _ContractCount += 1;

    //                 if _ContractCount <> 0 then
    //                     Insert_ProductStatus(_CemeteryConformation.Code, _CemeteryConformation.Name, '', BlankMSG);
    //             end;
    //         until _CemeteryConformation.Next = 0;
    //         _ContractCount := 0;

    //         _Contract.SetRange("Cemetery Conf. Code", '');
    //         _Contract.SetRange("Cemetery Dig. Code", '');
    //         _RevocationContract.SetRange("Cemetery Conf. Code", '');
    //         _RevocationContract.SetRange("Cemetery Digits Code", '');

    //         _Contract.SetRange("Contract Date", ReferenceDate);
    //         if _Contract.FindSet then
    //             _ContractCount += 1;
    //         if _RevocationContract.FindSet then
    //             _ContractCount += 1;

    //         _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
    //         if _Contract.FindSet then
    //             _ContractCount += 1;
    //         if _RevocationContract.FindSet then
    //             _ContractCount += 1;

    //         _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
    //         if _Contract.FindSet then
    //             _ContractCount += 1;
    //         if _RevocationContract.FindSet then
    //             _ContractCount += 1;

    //         if _ContractCount <> 0 then
    //             Insert_ProductStatus('', BlankMSG, '', BlankMSG);
    //     end;
    // end;

    // var
    //     ReferenceMSG: Label 'Reference Date : <Year4>-<Month,2>-<Day,2>';
    //     ReferenceDate: Date;
    //     ReferenceDateText: Text;
    //     MonthStartDate: Date;
    //     YearStartDate: Date;
    //     EntryNo: Integer;
    //     MSG001: Label '„“Šˆ„¾ •½ ‚»’Ñ„’ ¯‡’ Š­í—³„Ÿ„¾.';
    //     BlankMSG: Label 'Blank';

    // local procedure Insert_ProductStatus(pCemeteryConfCode: Code[20]; pCemeteryConfName: Text; pCemeteryDigitCode: Code[20]; pCemeteryDigitName: Text)
    // var
    //     _DailyAmoumt: Decimal;
    //     _MonthAmount: Decimal;
    //     _YearAmount: Decimal;
    //     _RevocationContract: Record "DK_Revocation Contract";
    //     _Contract: Record DK_Contract;
    //     _DailyCount: Integer;
    //     _MonthCount: Integer;
    //     _YearCount: Integer;
    // begin

    //     _DailyAmoumt := 0;
    //     _MonthAmount := 0;
    //     _YearAmount := 0;

    //     EntryNo += 1;

    //     Header.Init;
    //     Header."OBJECT ID" := REPORT::"DK_Sales Product Status";
    //     Header."USER ID" := UserId;
    //     Header."Entry No." := EntryNo;
    //     Header.CODE0 := pCemeteryConfCode;
    //     Header.CODE1 := pCemeteryDigitCode;
    //     Header.TEXT0 := pCemeteryConfName;
    //     Header.TEXT1 := pCemeteryDigitName;

    //     _Contract.Reset;
    //     _Contract.SetFilter(Status, '%1|%2|%3', _Contract.Status::Contract, _Contract.Status::FullPayment, _Contract.Status::Revocation);
    //     _Contract.CalcFields("Cemetery Conf. Code", "Cemetery Dig. Code");
    //     _Contract.SetRange("Cemetery Conf. Code", pCemeteryConfCode);
    //     _Contract.SetRange("Cemetery Dig. Code", pCemeteryDigitCode);
    //     _Contract.SetRange("Contract Date", ReferenceDate);
    //     if _Contract.FindSet then begin
    //         _DailyCount := _Contract.Count;
    //         _Contract.CalcSums("Cemetery Amount");
    //         _Contract.CalcSums("Cemetery Class Discount");
    //         _Contract.CalcSums("Cemetery Discount");

    //         _DailyAmoumt := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount"; // ‰ª¬ ‹ÏÔ‡ß - …Ø€Ã—­ž - ‰ª¬ —­ž
    //     end;

    //     _Contract.SetRange("Contract Date");
    //     _Contract.SetRange("Contract Date", MonthStartDate, ReferenceDate);
    //     if _Contract.FindSet then begin
    //         _MonthCount := _Contract.Count;
    //         _Contract.CalcSums("Cemetery Amount");
    //         _Contract.CalcSums("Cemetery Class Discount");
    //         _Contract.CalcSums("Cemetery Discount");

    //         _MonthAmount := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
    //     end;

    //     _Contract.SetRange("Contract Date");
    //     _Contract.SetRange("Contract Date", YearStartDate, ReferenceDate);
    //     if _Contract.FindSet then begin
    //         _YearCount := _Contract.Count;
    //         _Contract.CalcSums("Cemetery Amount");
    //         _Contract.CalcSums("Cemetery Class Discount");
    //         _Contract.CalcSums("Cemetery Discount");

    //         _YearAmount := _Contract."Cemetery Amount" - _Contract."Cemetery Class Discount" - _Contract."Cemetery Discount";
    //     end;

    //     _RevocationContract.Reset;
    //     _RevocationContract.CalcFields("Cemetery Conf. Code", "Cemetery Digits Code");
    //     _RevocationContract.SetRange(Status, _RevocationContract.Status::Complate);
    //     _RevocationContract.SetRange("Contract Date", YearStartDate, ReferenceDate);
    //     _RevocationContract.SetRange("Cemetery Conf. Code", pCemeteryConfCode);
    //     _RevocationContract.SetRange("Cemetery Digits Code", pCemeteryDigitCode);

    //     _RevocationContract.SetRange("Payment Completion Date", ReferenceDate);
    //     if _RevocationContract.FindSet then begin
    //         _RevocationContract.CalcSums("Sales Rev. Amount");
    //         Header.DECIMAL0 := _DailyAmoumt - _RevocationContract."Sales Rev. Amount";
    //         Header.INTEGER0 := _DailyCount - _RevocationContract.Count;
    //     end else begin
    //         Header.DECIMAL0 := _DailyAmoumt;
    //         Header.INTEGER0 := _DailyCount;
    //     end;

    //     _RevocationContract.SetRange("Payment Completion Date", MonthStartDate, ReferenceDate);
    //     if _RevocationContract.FindSet then begin
    //         _RevocationContract.CalcSums("Sales Rev. Amount");
    //         Header.DECIMAL1 := _MonthAmount - _RevocationContract."Sales Rev. Amount";
    //         Header.INTEGER1 := _MonthCount - _RevocationContract.Count;
    //     end else begin
    //         Header.DECIMAL1 := _MonthAmount;
    //         Header.INTEGER1 := _MonthCount;
    //     end;

    //     _RevocationContract.SetRange("Payment Completion Date", YearStartDate, ReferenceDate);
    //     if _RevocationContract.FindSet then begin
    //         _RevocationContract.CalcSums("Sales Rev. Amount");
    //         Header.DECIMAL2 := _YearAmount - _RevocationContract."Sales Rev. Amount";
    //         Header.INTEGER2 := _YearCount - _RevocationContract.Count;
    //     end else begin
    //         Header.DECIMAL2 := _YearAmount;
    //         Header.INTEGER2 := _YearCount;
    //     end;

    //     Header.Insert;
    // end;

    // local procedure ReferenceDate_Onvalidate()
    // begin

    //     if ReferenceDate > WorkDate then
    //         Error(MSG001);
    // end;
}

