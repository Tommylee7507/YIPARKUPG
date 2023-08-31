report 50039 "DK_CS 3part Receipt Status"
{
    // //×„ŒŽ• 3–”–« ‘óŒ÷—÷˜ Šˆ×Œ¡
    // *DK11
    //   - Data Source : INTEGER0, Name : ReportType
    //   - 0: ×„‹Ý„Ì ‰¸ ‚ž‘ñŠˆ˜Ô…— Œ¡ˆ× —÷˜, 1: œÎ•“‹ ‘óŒ÷ —÷˜, 2: €Ë•ˆ ‘óŒ÷ —÷˜
    // 
    // #2040 : 2020-07-22
    //   - Add function: Insert_OtherReceipt, Insert_OtherReceiptCheck
    //   - Add Variable: DateText
    //   - Add Text Constants: DayMSG, MonthMSG, YearMSG
    //   - Add Label: Title04Lb, Cap16Lb, Cap17Lb, Cap18Lb, Cap19Lb, Cap20Lb, Cap21Lb, Cap22Lb
    //   - Modify Layout
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCS3partReceiptStatus.rdl';

    Caption = 'CS 3part Receipt Status';
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
            column(EmployeeName; TEXT0)
            {
            }
            column(CounselBlank; INTEGER1)
            {
            }
            column(CounselReception; INTEGER2)
            {
            }
            column(CounselSending; INTEGER3)
            {
            }
            column(CounselTalk; INTEGER4)
            {
            }
            column(CounselSMS; INTEGER5)
            {
            }
            column(CounselEtc; INTEGER6)
            {
            }
            column(CounselMail; INTEGER7)
            {
            }
            column(CounselLaw; INTEGER8)
            {
            }
            column(CounselVisit; INTEGER9)
            {
            }
            column(CounselAgree; INTEGER10)
            {
            }
            column(CounselSum; DECIMAL2)
            {
            }
            column(MoveContractCount; INTEGER11)
            {
            }
            column(MoveContractAmount; DECIMAL0)
            {
            }
            column(MoveRemainingAmount; DECIMAL1)
            {
            }
            column(MoveTotalAmount; DECIMAL3)
            {
            }
            column(CustomerRequestCount; INTEGER12)
            {
            }
            column(OtherReceiptTotal; INTEGER13)
            {
            }
            column(ReferenceDate; ReferenceDateText)
            {
            }
            column(DateTitle; DateText)
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
                field(DateOption; DateOption)
                {
                    Caption = 'Date Option';
                    OptionCaption = 'Day,Month,Year';
                }
                field(EmployeeFilter; EmployeeFilter)
                {
                    Caption = 'Employee';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _Employee: Record DK_Employee;
                    begin
                        _Employee.Reset;
                        _Employee.FilterGroup(2);
                        _Employee.SetRange(Blocked, false);
                        _Employee.FilterGroup(0);

                        if PAGE.RunModal(0, _Employee) = ACTION::LookupOK then begin
                            if _Employee."No." <> '' then begin
                                if Text = '' then
                                    Text := _Employee."No."
                                else
                                    Text := Text + '|' + _Employee."No.";
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
            DateOption := DateOption::Day;
        end;
    }

    labels
    {
        Title01Lb = '×„ŒŽ• ‘óŒ÷—÷˜ Šˆ×Œ¡';
        Title02Lb = '1. ×„‹Ý„Ì ‰¸ ‚ž‘ñŠˆ˜Ô…— Œ¡ˆ× —÷˜';
        Title03Lb = '2. œÎ•“‹ ‘óŒ÷ —÷˜';
        Title04Lb = '3. €Ë•ˆ ‘óŒ÷—÷˜';
        Cap01Lb = '€ˆŠ¨';
        Cap02Lb = '€Ëú';
        Cap03Lb = 'Œ÷•';
        Cap04Lb = '‰È•';
        Cap05Lb = 'ˆÒ„Ì';
        Cap06Lb = '‰«À';
        Cap07Lb = 'Õ–×';
        Cap08Lb = 'Œ­ŒÁ';
        Cap09Lb = '‰µ‰«';
        Cap10Lb = '€Ë•ˆ';
        Cap11Lb = '…—';
        Cap12Lb = '—³Ð';
        Cap13Lb = 'ÐŽÊ—Œ÷';
        Cap14Lb = 'ÐŽÊ€¦';
        Cap15Lb = 'Â€¦';
        Cap16Lb = '…— (‘°—Ê‘È)';
        Cap17Lb = '„ÂŒ°‰«—';
        Cap18Lb = '×„Í“‹';
        Cap19Lb = '•€¯Š¨ŽÏ';
        Cap20Lb = 'NASŽð‡ž…Î';
        Cap21Lb = 'ÂŠžœÎŒ÷Í';
        Cap22Lb = '‚‹ŠžœÎŒ÷Í';
    }

    trigger OnPreReport()
    var
        _CheckCount: Integer;
    begin

        Clear(EntryNo);
        Clear(StartDate);
        Clear(EndDate);
        Clear(Employee);

        case DateOption of
            DateOption::Day:
                begin
                    StartDate := ReferenceDate;
                    DateText := DayMSG;
                end;
            DateOption::Month:
                begin
                    StartDate := CalcDate('<-CM>', ReferenceDate);
                    DateText := MonthMSG;
                end;
            DateOption::Year:
                begin
                    if Date2DMY(ReferenceDate, 2) = 12 then
                        StartDate := CalcDate('<-CM>', ReferenceDate)
                    else
                        StartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));

                    DateText := YearMSG;
                end;
        end;
        EndDate := ReferenceDate;

        ReferenceDateText := StrSubstNo(ReferenceMSG, Format(StartDate, 0, '<Year4>-<Month,2>-<Day,2>'), Format(EndDate, 0, '<Year4>-<Month,2>-<Day,2>'));

        Employee.SetRange(Blocked, false);

        if EmployeeFilter <> '' then
            Employee.SetFilter("No.", EmployeeFilter);

        if Employee.FindSet then begin
            repeat
                _CheckCount := Insert_CounselHistoryCheck;
                if _CheckCount <> 0 then
                    Insert_CounselHistory;

                _CheckCount := Insert_MoveTheGraveCheck;
                if _CheckCount <> 0 then
                    Insert_MoveTheGrave;

                _CheckCount := Insert_OtherReceiptCheck;
                if _CheckCount <> 0 then
                    Insert_OtherReceipt;
            until Employee.Next = 0;
        end;
    end;

    var
        DateOption: Option Day,Month,Year;
        ReferenceDate: Date;
        EmployeeFilter: Text;
        MSG001: Label '€Ë‘¹ŸÀ„’ Š±÷‚ã‹ Œ÷ Ž°„Ÿ„¾.';
        EntryNo: Integer;
        Employee: Record DK_Employee;
        StartDate: Date;
        EndDate: Date;
        ReferenceMSG: Label 'Reference Date : <Year4>-<Month,2>-<Day,2>';
        ReferenceDateText: Text;
        DayMSG: Label 'Ÿú';
        MonthMSG: Label 'õú';
        YearMSG: Label '‚Ëú';
        DateText: Text;

    local procedure ReferenceDate_Onvalidate()
    begin

        if ReferenceDate = 0D then
            Error(MSG001);
    end;

    local procedure Insert_CounselHistory()
    var
        _CounselHistory: Record "DK_Counsel History";
    begin
        //×„‹Ý„Ì ‰¸ ‚ž‘ñŠˆ˜Ô…— Œ¡ˆ× —÷˜

        EntryNo += 1;

        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 3part Receipt Status";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 0; //×„ ‹Ý„Ì
        Header.TEXT0 := Employee.Name;

        _CounselHistory.Reset;
        _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
        _CounselHistory.SetRange("Employee No.", Employee."No.");
        _CounselHistory.SetRange(Date, StartDate, EndDate);
        _CounselHistory.SetRange("Delete Row", false);
        _CounselHistory.SetCurrentKey(Type, "Employee No.", Date, "Litigation Type");

        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Blank);
        if _CounselHistory.FindSet then begin
            Header.INTEGER1 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Reception);
        if _CounselHistory.FindSet then begin
            Header.INTEGER2 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Sending);
        if _CounselHistory.FindSet then begin
            Header.INTEGER3 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Talk);
        if _CounselHistory.FindSet then begin
            Header.INTEGER4 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::SMS);
        if _CounselHistory.FindSet then begin
            Header.INTEGER5 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Etc);
        if _CounselHistory.FindSet then begin
            Header.INTEGER6 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Mail);
        if _CounselHistory.FindSet then begin
            Header.INTEGER7 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Law);
        if _CounselHistory.FindSet then begin
            Header.INTEGER8 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Visit);
        if _CounselHistory.FindSet then begin
            Header.INTEGER9 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Agree);
        if _CounselHistory.FindSet then begin
            Header.INTEGER10 := _CounselHistory.Count;
            Header.DECIMAL2 += _CounselHistory.Count;
        end;

        Header.Insert;
    end;

    local procedure Insert_CounselHistoryCheck(): Integer
    var
        _CounselHistory: Record "DK_Counsel History";
        _CheckCount: Integer;
    begin
        //×„‹Ý„Ì ‰¸ ‚ž‘ñŠˆ˜Ô…— Œ¡ˆ× —÷˜

        Clear(_CheckCount);

        _CounselHistory.Reset;
        _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
        _CounselHistory.SetRange("Employee No.", Employee."No.");
        _CounselHistory.SetRange(Date, StartDate, EndDate);
        _CounselHistory.SetCurrentKey(Type, "Employee No.", Date, "Litigation Type");

        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Blank);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Reception);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Sending);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Talk);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::SMS);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Etc);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Mail);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Law);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Visit);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Agree);
        if _CounselHistory.FindSet then begin
            _CheckCount += 1;
        end;

        exit(_CheckCount);
    end;

    local procedure Insert_MoveTheGrave()
    var
        _CemeteryServices: Record "DK_Cemetery Services";
    begin
        //œÎ•“‹ ‘óŒ÷ —÷˜

        EntryNo += 1;

        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 3part Receipt Status";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 1; //œÎ
        Header.TEXT0 := Employee.Name;

        _CemeteryServices.Reset;
        _CemeteryServices.SetFilter(Status, '<>%1', _CemeteryServices.Status::Open);
        _CemeteryServices.SetRange("Employee No.", Employee."No.");
        _CemeteryServices.SetRange("Receipt Date", StartDate, EndDate);
        _CemeteryServices.SetRange("Field Work Main Cat. Code", '908');
        _CemeteryServices.SetCurrentKey(Status, "Employee No.", "Receipt Date", "Field Work Main Cat. Code", "Field Work Sub Cat. Code");

        _CemeteryServices.SetRange("Field Work Sub Cat. Code", '001');
        if _CemeteryServices.FindSet then begin
            _CemeteryServices.CalcSums("Receipt Amount");
            Header.INTEGER11 := _CemeteryServices.Count;
            Header.DECIMAL0 := _CemeteryServices."Receipt Amount";
        end;

        _CemeteryServices.SetRange("Field Work Sub Cat. Code", '002');
        if _CemeteryServices.FindSet then begin
            _CemeteryServices.CalcSums("Receipt Amount");
            Header.DECIMAL1 := _CemeteryServices."Receipt Amount";
        end;

        Header.DECIMAL3 := Header.DECIMAL0 + Header.DECIMAL1;

        Header.Insert;
    end;

    local procedure Insert_MoveTheGraveCheck(): Integer
    var
        _CemeteryServices: Record "DK_Cemetery Services";
        _CheckCount: Integer;
    begin
        //œÎ•“‹ ‘óŒ÷ —÷˜

        Clear(_CheckCount);

        _CemeteryServices.Reset;
        _CemeteryServices.SetFilter(Status, '<>%1', _CemeteryServices.Status::Open);
        _CemeteryServices.SetRange("Employee No.", Employee."No.");
        _CemeteryServices.SetRange("Receipt Date", StartDate, EndDate);
        _CemeteryServices.SetRange("Field Work Main Cat. Code", '908');
        _CemeteryServices.SetCurrentKey(Status, "Employee No.", "Receipt Date", "Field Work Main Cat. Code", "Field Work Sub Cat. Code");

        _CemeteryServices.SetRange("Field Work Sub Cat. Code", '001');
        if _CemeteryServices.FindSet then begin
            _CheckCount += 1;
        end;

        _CemeteryServices.SetRange("Field Work Sub Cat. Code", '002');
        if _CemeteryServices.FindSet then begin
            _CheckCount += 1;
        end;

        exit(_CheckCount);
    end;

    local procedure Insert_OtherReceipt()
    var
        _CustomerRequests: Record "DK_Customer Requests";
    begin
        //€Ë•ˆ ‘óŒ÷ —÷˜

        EntryNo += 1;

        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 3part Receipt Status";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 2;
        Header.TEXT0 := Employee.Name;

        _CustomerRequests.Reset;
        _CustomerRequests.SetFilter(Status, '<>%1', _CustomerRequests.Status::Open);
        _CustomerRequests.SetRange("Employee No.", Employee."No.");
        _CustomerRequests.SetRange("Receipt Date", StartDate, EndDate);
        if _CustomerRequests.FindSet then begin
            Header.INTEGER12 := _CustomerRequests.Count;
            Header.INTEGER13 += _CustomerRequests.Count;
        end;

        Header.Insert;
    end;

    local procedure Insert_OtherReceiptCheck(): Integer
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _CheckCount: Integer;
    begin
        //€Ë•ˆ ‘óŒ÷ —÷˜

        Clear(_CheckCount);

        _CustomerRequests.Reset;
        _CustomerRequests.SetFilter(Status, '<>%1', _CustomerRequests.Status::Open);
        _CustomerRequests.SetRange("Employee No.", Employee."No.");
        _CustomerRequests.SetRange("Receipt Date", StartDate, EndDate);

        if _CustomerRequests.FindSet then
            _CheckCount += 1;

        exit(_CheckCount);
    end;
}

