report 50024 "DK_Park Mang. DailyReport"
{
    // //°°ýˆ«Œ­ ŸŸŠˆ×
    // *DK08 // Œ÷‘ñý
    //   - Data Source : INTEGER0, Name : ReportType
    //   - 0: Ÿú ÁŽð‘÷“ •ÔÐ, 1: „“— Î‡š, 2: õú —÷Î ÁŽðýˆ« •ÔÐ, 3: Š±—ýˆ«, 4: ×„ Í“‹‹Ï—¸ ŸŸ ‘°“„ —÷˜,
    //     5: ×„ Í“‹‹Ï—¸ “‚ˆ« •ÔÐ
    // 
    // //Œ÷‘ñ ˜” - 191106
    //   - Data Source : INTEGER0, Name : ReportType
    //   - 1: —÷Î ÁŽðýˆ« •ÔÐ, 2: ×„ Í“‹‹Ï—¸ “‚ˆ« •ÔÐ, 3: Š±—ýˆ«
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKParkMangDailyReport.rdl';

    Caption = 'Park Managment DailyReport';
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
            column(WorkTypeName; TEXT4)
            {
            }
            column(WorkDailyCount; INTEGER1)
            {
            }
            column(WorkMonthCount; INTEGER2)
            {
            }
            column(WorkYearCount; INTEGER3)
            {
            }
            column(WorkTimeDailyCount; INTEGER4)
            {
            }
            column(WorkTimeMonthCount; INTEGER5)
            {
            }
            column(WorkTimeYearCount; INTEGER6)
            {
            }
            column(WorkGroupDailyCount; INTEGER7)
            {
            }
            column(WorkGroupMonthCount; INTEGER8)
            {
            }
            column(WorkGroupYearCount; INTEGER9)
            {
            }
            column(WorkItemDailyCount; INTEGER10)
            {
            }
            column(WorkItemMonthCount; INTEGER11)
            {
            }
            column(WorkItemYearCount; INTEGER12)
            {
            }
            column(WorkDailyAmount; DECIMAL0)
            {
            }
            column(WorkMonthAmount; DECIMAL1)
            {
            }
            column(WorkYearAmount; DECIMAL2)
            {
            }
            column(CustRequestDailyReceipt; INTEGER13)
            {
            }
            column(CustRequestMonthReceipt; INTEGER14)
            {
            }
            column(CustRequestYearReceipt; INTEGER15)
            {
            }
            column(CustRequestDialyComplete; INTEGER16)
            {
            }
            column(CsutRequestMonthComplete; INTEGER17)
            {
            }
            column(CustRequestYearComplete; INTEGER18)
            {
            }
            column(CsutRequestRelease; INTEGER19)
            {
            }
            column(CustRequestPreRelease; INTEGER20)
            {
            }
            column(RequestExpItem; TEXT0)
            {
            }
            column(RequestExpPurpose; TEXT1)
            {
            }
            column(RequestExpStandard; TEXT2)
            {
            }
            column(RequestExpQuantity; DECIMAL3)
            {
            }
            column(RequestExpAmount; DECIMAL4)
            {
            }
            column(RequestExpRemarks; TEXT3)
            {
            }
            column(ReferenceDate; gReferenceDate)
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
                field(gReferenceDate; gReferenceDate)
                {
                    Caption = 'Reference Date';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            gReferenceDate := WorkDate;
        end;
    }

    labels
    {
        Title01Lb = '°°ýˆ«Œ­ ŸŸŽð‰½Šˆ×';
        Title02Lb = '—÷Î ÁŽðýˆ« •ÔÐ';
        Title03Lb = '×„ Í“‹‹Ï—¸ “‚ˆ«•ÔÐ';
        Title04Lb = 'Š±—ýˆ«';
        Cap01Lb = '€ˆ Š¨';
        Cap02Lb = '—Œ÷';
        Cap03Lb = 'ÁŽð“ú';
        Cap04Lb = 'ÁŽðž°';
        Cap05Lb = 'ÎŠ±‹ÏÔ';
        Cap06Lb = '€¦ Ž¸';
        Cap07Lb = '„ÏŸ';
        Cap08Lb = 'õú';
        Cap09Lb = '‚Ëú';
        Cap10Lb = '„Ï Ÿ';
        Cap11Lb = 'õ ú';
        Cap12Lb = '‚Ë ú';
        Cap13Lb = '‘ó Œ÷ —';
        Cap14Lb = '“‚ ˆ« —';
        Cap15Lb = '‰œ“‚ˆ«—';
        Cap16Lb = '“‹€ˆ‰—';
        Cap17Lb = 'Ô ……';
        Cap18Lb = '€¯ ¦';
        Cap19Lb = 'Œ÷ ‡«';
        Cap20Lb = 'Š± ×';
        Cap21Lb = '„Ì „Ï';
        Cap22Lb = '· Î';
        Cap23Lb = '’ð Î';
        Cap24Lb = 'Š‹ŠžÎ';
        Cap25Lb = '—³ Ð';
        Cap26Lb = 'œõ ‰œ“‚ˆ«—';
    }

    trigger OnPreReport()
    var
        _FuneralType: Record "DK_Funeral Type";
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
    begin
        Clear(MonthStartDate);
        Clear(YearSartDate);
        Clear(FieldWorkHeader);
        Clear(FieldWorkLineItem);

        MonthStartDate := CalcDate('<-CM>', gReferenceDate);
        if Date2DMY(gReferenceDate, 2) = 12 then
            YearSartDate := CalcDate('<-CM>', gReferenceDate)
        else
            YearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', gReferenceDate)));


        FieldWorkLineItem.CalcFields("Funeral Type Code", "Document Status", "Document Date", "Field Work Main Cat. Code");

        FieldWorkHeader.SetRange(Status, FieldWorkHeader.Status::Post);
        FieldWorkLineItem.SetRange("Document Status", FieldWorkLineItem."Document Status"::Post);

        // —÷Î ÁŽð ýˆ« •ÔÐ
        _FuneralType.Reset;
        _FuneralType.SetRange(Blocked, false);
        if _FuneralType.FindSet then begin
            repeat
                FieldWorkHeader.SetRange("Funeral Type Code", _FuneralType.Code);
                FieldWorkLineItem.SetRange("Funeral Type Code", _FuneralType.Code);
                InsertBuffer_FieldWorkStatistics(_FuneralType.Name);
            until _FuneralType.Next = 0;
        end;

        // —÷Î ÁŽð ýˆ« •ÔÐ
        FieldWorkHeader.SetRange("Funeral Type Code");
        FieldWorkLineItem.SetRange("Funeral Type Code");
        _FieldWorkMainCategory.Reset;
        _FieldWorkMainCategory.SetFilter(Code, '<>%1', '001');
        _FieldWorkMainCategory.SetRange(Blocked, false);
        _FieldWorkMainCategory.SetRange("Connect Work", true);
        if _FieldWorkMainCategory.FindSet then begin
            repeat
                FieldWorkHeader.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                FieldWorkLineItem.SetRange("Field Work Main Cat. Code", _FieldWorkMainCategory.Code);
                InsertBuffer_FieldWorkStatistics(_FieldWorkMainCategory.Name);
            until _FieldWorkMainCategory.Next = 0;
        end;

        //×„ Í“‹‹Ï—¸ “‚ˆ« •ÔÐ
        InsertBuffer_CustReqStatistics;

        //Š±— ýˆ«
        InsertBuffer_ReqExpense;
    end;

    var
        gReferenceDate: Date;
        EntryNo: Integer;
        ParkManager: Label 'T007';
        MonthStartDate: Date;
        YearSartDate: Date;
        FieldWorkHeader: Record "DK_Field Work Header";
        FieldWorkLineItem: Record "DK_Field Work Line Item";

    local procedure InsertBuffer_FieldWorkStatistics(pName: Text)
    begin
        // —÷Î ÁŽð ýˆ« •ÔÐ
        EntryNo += 1;
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Park Mang. DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 1; // —÷Î ÁŽðýˆ« •ÔÐ
        Header.TEXT4 := pName;

        FieldWorkHeader.SetRange(Date);
        FieldWorkHeader.SetRange(Date, gReferenceDate);
        if FieldWorkHeader.FindSet then begin
            FieldWorkHeader.CalcSums("Work Time Spent");
            FieldWorkHeader.CalcSums(TotalAmount);
            Header.INTEGER1 := FieldWorkHeader.Count;
            Header.INTEGER4 := FieldWorkHeader."Work Time Spent";
            Header.DECIMAL0 := FieldWorkHeader.TotalAmount;
        end;
        FieldWorkHeader.SetRange(Date);
        FieldWorkHeader.SetRange(Date, MonthStartDate, gReferenceDate);
        if FieldWorkHeader.FindSet then begin
            FieldWorkHeader.CalcSums("Work Time Spent");
            FieldWorkHeader.CalcSums(TotalAmount);
            Header.INTEGER2 := FieldWorkHeader.Count;
            Header.INTEGER5 := FieldWorkHeader."Work Time Spent";
            Header.DECIMAL1 := FieldWorkHeader.TotalAmount;
        end;
        FieldWorkHeader.SetRange(Date);
        FieldWorkHeader.SetRange(Date, YearSartDate, gReferenceDate);
        if FieldWorkHeader.FindSet then begin
            FieldWorkHeader.CalcSums("Work Time Spent");
            FieldWorkHeader.CalcSums(TotalAmount);
            Header.INTEGER3 := FieldWorkHeader.Count;
            Header.INTEGER6 := FieldWorkHeader."Work Time Spent";
            Header.DECIMAL2 := FieldWorkHeader.TotalAmount;
        end;
        FieldWorkLineItem.SetRange("Document Date");
        FieldWorkLineItem.SetRange("Document Date", gReferenceDate);
        FieldWorkLineItem.SetRange(Type, FieldWorkLineItem.Type::WorkGroup);
        if FieldWorkLineItem.FindSet then begin
            FieldWorkLineItem.CalcSums(Quantity);
            Header.INTEGER7 := FieldWorkLineItem.Quantity;
        end;
        FieldWorkLineItem.SetRange(Type, FieldWorkLineItem.Type::Vehicle);
        if FieldWorkLineItem.FindSet then begin
            FieldWorkLineItem.CalcSums(Quantity);
            Header.INTEGER10 := FieldWorkLineItem.Quantity;
        end;
        FieldWorkLineItem.SetRange("Document Date");
        FieldWorkLineItem.SetRange("Document Date", MonthStartDate, gReferenceDate);
        if FieldWorkLineItem.FindSet then begin
            FieldWorkLineItem.CalcSums(Quantity);
            Header.INTEGER11 := FieldWorkLineItem.Quantity;
        end;
        FieldWorkLineItem.SetRange(Type);
        FieldWorkLineItem.SetRange(Type, FieldWorkLineItem.Type::WorkGroup);
        if FieldWorkLineItem.FindSet then begin
            FieldWorkLineItem.CalcSums(Quantity);
            Header.INTEGER8 := FieldWorkLineItem.Quantity;
        end;
        FieldWorkLineItem.SetRange("Document Date");
        FieldWorkLineItem.SetRange("Document Date", YearSartDate, gReferenceDate);
        if FieldWorkLineItem.FindSet then begin
            FieldWorkLineItem.CalcSums(Quantity);
            Header.INTEGER9 := FieldWorkLineItem.Quantity;
        end;
        FieldWorkLineItem.SetRange(Type);
        FieldWorkLineItem.SetRange(Type, FieldWorkLineItem.Type::Vehicle);
        if FieldWorkLineItem.FindSet then begin
            FieldWorkLineItem.CalcSums(Quantity);
            Header.INTEGER12 := FieldWorkLineItem.Quantity;
        end;

        Header.Insert;
    end;

    local procedure InsertBuffer_CustReqStatistics()
    var
        _CustomerRequests: Record "DK_Customer Requests";
    begin
        //×„ Í“‹‹Ï—¸ “‚ˆ« •ÔÐ
        EntryNo += 1;
        Header.Reset;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_Park Mang. DailyReport";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 2; // ×„ Í“‹‹Ï—¸ “‚ˆ« •ÔÐ

        _CustomerRequests.Reset;
        _CustomerRequests.SetFilter(Status, '%1|%2|%3', _CustomerRequests.Status::Release, _CustomerRequests.Status::Post, _CustomerRequests.Status::Complete);
        _CustomerRequests.SetRange("Receipt Date", gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER13 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Receipt Date");
        _CustomerRequests.SetRange("Receipt Date", MonthStartDate, gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER14 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Receipt Date");
        _CustomerRequests.SetRange("Receipt Date", YearSartDate, gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER15 := _CustomerRequests.Count;

        _CustomerRequests.SetRange(Status);
        _CustomerRequests.SetRange("Receipt Date");
        _CustomerRequests.SetRange(Status, _CustomerRequests.Status::Complete);
        _CustomerRequests.SetRange("Process Date", gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER16 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Process Date");
        _CustomerRequests.SetRange("Process Date", MonthStartDate, gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER17 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Process Date");
        _CustomerRequests.SetRange("Process Date", YearSartDate, gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER18 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Process Date");
        _CustomerRequests.SetRange(Status);
        _CustomerRequests.SetFilter(Status, '%1|%2', _CustomerRequests.Status::Release, _CustomerRequests.Status::Post);
        _CustomerRequests.SetRange("Receipt Date", 0D, gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER19 := _CustomerRequests.Count;

        _CustomerRequests.SetRange("Receipt Date", 0D, YearSartDate - 1);
        if _CustomerRequests.FindSet then
            Header.INTEGER20 := _CustomerRequests.Count;

        _CustomerRequests.SetRange(Status, _CustomerRequests.Status::Complete);
        _CustomerRequests.SetRange("Process Date", YearSartDate, gReferenceDate);
        if _CustomerRequests.FindSet then
            Header.INTEGER20 += _CustomerRequests.Count;

        Header.Insert;
    end;


    procedure InsertBuffer_ReqExpense()
    var
        _RequestExpensesLine: Record "DK_Request Expenses Line";
        _RequestExpensesHeader: Record "DK_Request Expenses Header";
    begin
        //Š±— ýˆ«
        _RequestExpensesHeader.Reset;
        _RequestExpensesHeader.SetRange("Posting Date", gReferenceDate);
        _RequestExpensesHeader.SetFilter(Status, '%1|%2', _RequestExpensesHeader.Status::Post, _RequestExpensesHeader.Status::Completed);
        _RequestExpensesHeader.SetRange("Department Code", ParkManager);
        if _RequestExpensesHeader.FindSet then begin
            repeat
                _RequestExpensesLine.Reset;
                _RequestExpensesLine.SetRange("Document No.", _RequestExpensesHeader."No.");
                if _RequestExpensesLine.FindSet then begin
                    repeat
                        EntryNo += 1;
                        Header.Reset;
                        Header.Init;
                        Header."USER ID" := UserId;
                        Header."OBJECT ID" := REPORT::"DK_Park Mang. DailyReport";
                        Header."Entry No." := EntryNo;
                        Header.INTEGER0 := 3; //Š±— ýˆ«
                        Header.TEXT0 := _RequestExpensesLine."Purchased Item";
                        Header.TEXT1 := _RequestExpensesLine.Purpose;
                        Header.TEXT2 := _RequestExpensesLine.StandardSize;
                        Header.DECIMAL3 := _RequestExpensesLine.Quantity;
                        Header.DECIMAL4 := _RequestExpensesLine.Amount;
                        Header.TEXT3 := _RequestExpensesHeader.Remarks;
                        Header.Insert;
                    until _RequestExpensesLine.Next = 0;
                end;
            until _RequestExpensesHeader.Next = 0;
        end;
    end;
}

