report 50043 "DK_CS 1_2part Daily Report"
{
    // //×„ŒŽ• 1 2–”–« ŸŸ Žð‰½ Šˆ×Œ¡
    // *DK11
    //   - Data Source : INTEGER0, Name : ReportType
    //   - 1: Ÿ‰¦ýˆ«Š± “È™„Ô‹Ý, 2: ‘†µýˆ«Š± “È™„Ô‹Ý, 3: Õ–×/Œ¡‡õ ‰ÈŒÁ, 4:‹Ý„Ì •ÔÐ
    // 
    //   - Data Source : ReportTitleKey, Name : ReportTitleKey
    //   - 0: Ÿú, 1: õú, 2: ‚Ëú
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCS12partDailyReport.rdl';

    Caption = 'CS 1_2part Daily Report';
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
            column(FieldName; TEXT0)
            {
            }
            column(GeneralAdminCount; INTEGER14)
            {
            }
            column(GeneralAdminCemeterySize; DECIMAL0)
            {
            }
            column(GeneralAdminNonpayAmount; DECIMAL1)
            {
            }
            column(GeneralAdminPerfoCount; INTEGER1)
            {
            }
            column(GeneralAdminPerfoCemeterySize; DECIMAL2)
            {
            }
            column(GeneralAdminPerfoAmount; DECIMAL3)
            {
            }
            column(GeneralAdminPerfoPreviousAmount; DECIMAL4)
            {
            }
            column(GeneralAdminPerfoIncrease; TEXT1)
            {
            }
            column(TotalGeneralIncrease; GeneralAdminInc)
            {
            }
            column(LandAdminCount; INTEGER2)
            {
            }
            column(LandAdminCemeterySize; DECIMAL6)
            {
            }
            column(LandAdminNonpayAmount; DECIMAL7)
            {
            }
            column(LandAdminPerfoCount; DECIMAL8)
            {
            }
            column(LandAdminPerfoCemeterySize; DECIMAL9)
            {
            }
            column(LandAdminPerfoAmount; DECIMAL10)
            {
            }
            column(LandAdminPerfoPreviousAmount; DECIMAL11)
            {
            }
            column(LandAdminPerfoIncrease; TEXT2)
            {
            }
            column(TotalLandIncrease; LandAdminInc)
            {
            }
            column(TotalAdminIncrease; TotalAdminInc)
            {
            }
            column(MailCurrCount; DECIMAL13)
            {
            }
            column(MailPreviousCount; DECIMAL14)
            {
            }
            column(MailIncease; TEXT3)
            {
            }
            column(TotalMailIncrease; MailInc)
            {
            }
            column(CounselReception; INTEGER3)
            {
            }
            column(CounselSending; INTEGER4)
            {
            }
            column(CounselTalk; INTEGER5)
            {
            }
            column(CounselSMS; INTEGER6)
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
            column(CounselEtc; INTEGER11)
            {
            }
            column(CounselSum; INTEGER12)
            {
            }
            column(CounselPreviousSum; INTEGER13)
            {
            }
            column(CounselIncrease; TEXT4)
            {
            }
            column(TotalCounselIncrease; CounselInc)
            {
            }
            column(ReportTitleKey; ReportTitleKey)
            {
            }
            column(CreateDate; CreateDateText)
            {
            }
            column(Writer; WriterText)
            {
            }
            column(EmployeeText; EmployeeText)
            {
            }
            column(ReferenceDate; ReferenceDateText)
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
        end;
    }

    labels
    {
        Title01Lb = '×„ŒŽ• 1,2–”–« ŸŸ Žð‰½ Šˆ×Œ¡';
        Cap01Lb = 'Ÿ‰¦ýˆ«Š±';
        Cap02Lb = '(Ÿú Šˆ×Œ¡)';
        Cap03Lb = '(õú Šˆ×Œ¡)';
        Cap04Lb = '…Ø€Ã';
        Cap05Lb = '“È™ „Ô‹Ý';
        Cap06Lb = '„ÏŸ —ø';
        Cap07Lb = 'õú —ø';
        Cap08Lb = '—Œ÷';
        Cap09Lb = '–ÛŒ÷';
        Cap10Lb = '‰œ‚‚Ž¸';
        Cap11Lb = '¯€¦Ž¸';
        Cap12Lb = 'ýŸ „ÔŠ± ‘ã¿‡ý';
        Cap13Lb = 'ýõ „ÔŠ± ‘ã¿‡ý';
        Cap14Lb = 'ý‚Ë „ÔŠ± ‘ã¿‡ý';
        Cap15Lb = 'Õ–×/Œ¡‡õ ‰ÈŒÁ';
        Cap16Lb = '—¸ˆ±';
        Cap17Lb = '‰ÈŒÁ';
        Cap18Lb = '‘†µýˆ«Š±';
        Cap20Lb = '¼ú —ø';
        Cap19Lb = '(‚Ëú Šˆ×Œ¡)';
        Cap21Lb = 'Ÿ‰¦ —³Ð';
        Cap22Lb = '‘†µ —³Ð';
        Cap23Lb = 'ýˆ«Š± “©Ð';
        Cap24Lb = '—³Ð';
        Cap25Lb = 'ýŸ —Œ÷';
        Cap26Lb = '„ÏŸ —Œ÷';
        Cap27Lb = 'ýõ —Œ÷';
        Cap28Lb = '„Ïõ —Œ÷';
        Cap29Lb = 'ý‚Ë —Œ÷';
        Cap30Lb = '„Ï—¹ —Œ÷';
        Cap31Lb = 'ýŸ „ÔŠ± ‘ã¿‡ý';
        Cap32Lb = 'ýõ „ÔŠ± ‘ã¿‡ý';
        Cap33Lb = 'ý‚Ë „ÔŠ± ‘ã¿‡ý';
        Cap34Lb = '‹Ý„Ì•ÔÐ';
        Cap35Lb = '€ˆŠ¨';
        Cap36Lb = 'Œ÷•';
        Cap37Lb = '‰È•';
        Cap38Lb = 'ˆÒ„Ì';
        Cap39Lb = '‰«À';
        Cap40Lb = 'Õ–×';
        Cap41Lb = 'Œ­ŒÁ';
        Cap42Lb = '‰µ‰«';
        Cap43Lb = '€Ë•ˆ';
        Cap44Lb = '…—';
        Cap45Lb = 'ýŸ —ø';
        Cap46Lb = 'ýõ —ø';
        Cap47Lb = 'ý‚Ë —ø';
        Cap48Lb = 'ýˆ«Š± “©Ð';
    }

    trigger OnPreReport()
    var
        _Employee: Record DK_Employee;
        _TotalGeneralIncrease: Decimal;
        _TotalLandIncrease: Decimal;
        _TotalMailIncrease: Decimal;
        _TotalCounselIncrease: Decimal;
    begin
        Clear(LitigaionEvaluationAmount);
        Clear(PaymentReceiptDocument);
        Clear(MonthStartDate);
        Clear(YearSartDate);
        Clear(ReportPrtHistory);
        Clear(Employee);
        Clear(GeneralAdminInc);
        Clear(LandAdminInc);
        Clear(MailInc);
        Clear(CounselInc);
        Clear(TotalCurrGeneralAdmin);
        Clear(TotalPreGeneralAdmin);
        Clear(TotalCurrLandAdmin);
        Clear(TotalPreLandAdmin);
        Clear(TotalCurrMail);
        Clear(TotalPreMail);
        Clear(TotalCurrCounsel);
        Clear(TotalPreCounsel);

        if GuiAllowed then
            Window.Open(
              MSG100);

        MonthStartDate := CalcDate('<-CM>', ReferenceDate);
        if Date2DMY(ReferenceDate, 2) = 12 then
            YearSartDate := CalcDate('<-CM>', ReferenceDate)
        else
            YearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', ReferenceDate)));

        //>>Šˆ×Œ¡ ‘ªˆ± ŠžŠ¨
        ReportTitleKey := DateOption;
        CreateDateText := Format(WorkDate, 0, CreateDateMSG);
        case DateOption of
            DateOption::Day:
                ReferenceDateText := StrSubstNo(ReferenceDateMSG, Format(ReferenceDate, 0, '<Year4>-<Month,2>-<Day,2>'), Format(ReferenceDate, 0, '<Year4>-<Month,2>-<Day,2>'));
            DateOption::Month:
                ReferenceDateText := StrSubstNo(ReferenceDateMSG, Format(MonthStartDate, 0, '<Year4>-<Month,2>-<Day,2>'), Format(ReferenceDate, 0, '<Year4>-<Month,2>-<Day,2>'));
            DateOption::Year:
                ReferenceDateText := StrSubstNo(ReferenceDateMSG, Format(YearSartDate, 0, '<Year4>-<Month,2>-<Day,2>'), Format(ReferenceDate, 0, '<Year4>-<Month,2>-<Day,2>'));
        end;
        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then
            WriterText := StrSubstNo(WriterMSG, _Employee.Name);
        //<<

        PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount");
        PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
        PaymentReceiptDocument.SetRange(Posted, true);

        if EmployeeFilter <> '' then begin
            LitigaionEvaluationAmount.SetFilter("Litigation Employee No.", EmployeeFilter);
            PaymentReceiptDocument.SetFilter("Litigation Employee No.", EmployeeFilter);
            ReportPrtHistory.SetFilter("Employee No.", EmployeeFilter);
            Employee.SetFilter("No.", EmployeeFilter);

            _Employee.Reset;
            _Employee.SetFilter("No.", EmployeeFilter);
            if _Employee.FindSet then begin
                repeat
                    if EmployeeText = '' then
                        EmployeeText := _Employee.Name
                    else
                        EmployeeText += ',' + _Employee.Name;
                until _Employee.Next = 0;

                EmployeeText := StrSubstNo(EmployeeMSG, EmployeeText);
            end;
        end else begin
            LitigaionEvaluationAmount.SetRange("Litigation Employee No.", '');
            EmployeeText := StrSubstNo(EmployeeMSG, AllMSG);
        end;

        //Ÿ‰¦ ýˆ«Š± “È™„Ô‹Ý
        PaymentReceiptDocument.SetFilter("Line General Amount", '<>%1', 0);
        LitigaionEvaluationAmount.SetRange("Admin. Expense Type", LitigaionEvaluationAmount."Admin. Expense Type"::General);

        SetLitigationEvaludation(0);

        if TotalPreGeneralAdmin <> 0 then
            GeneralAdminInc := StrSubstNo(PercentageMSG, Round(((TotalCurrGeneralAdmin / TotalPreGeneralAdmin * 100) - 100), 1, '='))
        else
            GeneralAdminInc := '-';

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', 1, 4));


        //‘†µ ýˆ«Š± “È™„Ô‹Ý
        PaymentReceiptDocument.SetRange("Line General Amount");
        PaymentReceiptDocument.SetFilter("Line Land. Arc. Amount", '<>%1', 0);
        LitigaionEvaluationAmount.SetRange("Admin. Expense Type", LitigaionEvaluationAmount."Admin. Expense Type"::Landscape);

        SetLitigationEvaludation(1);

        if TotalPreLandAdmin <> 0 then
            LandAdminInc := StrSubstNo(PercentageMSG, Round(((TotalCurrLandAdmin / TotalPreLandAdmin * 100) - 100), 1, '='))
        else
            LandAdminInc := '-';

        if TotalPreGeneralAdmin + TotalPreLandAdmin <> 0 then
            TotalAdminInc := StrSubstNo(PercentageMSG, Round(((TotalCurrGeneralAdmin + TotalCurrLandAdmin) / (TotalPreGeneralAdmin + TotalPreLandAdmin) * 100) - 100, 1, '='))
        else
            TotalAdminInc := '-';

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', 2, 4));

        //Õ–×,Œ¡‡õ ‰ÈŒÁ
        InsertBuffer_MailSend(50033); //‚‚Šž —õ‘†‰«
        InsertBuffer_MailSend(50034); //‚‚Šž …†“›Î
        InsertBuffer_MailSend(50004); //‚‹Ô‘ãˆ×
        InsertBuffer_MailSend(50005); //“´×Œ¡1’ð
        InsertBuffer_MailSend(50006); //“´×Œ¡2’ð
        InsertBuffer_MailSend(50007); //ÐŽÊ —¹‘÷•ÔŠˆŒ¡
        InsertBuffer_MailSend(50008); //“´×Œ¡-—¹‘÷Ž˜‚‹
        InsertBuffer_MailSend(50009); //“´×Œ¡-º”íŠ»µ
        InsertBuffer_BillLetter;      //×‘÷Œ¡

        if TotalPreMail <> 0 then
            MailInc := StrSubstNo(PercentageMSG, Round(((TotalCurrMail / TotalPreMail * 100) - 100), 1, '='))
        else
            MailInc := '-';

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', 3, 4));

        //‹Ý„Ì•ÔÐ
        Employee.SetRange(Blocked, false);
        if Employee.FindSet then begin
            repeat
                if InsertBuffer_CounselHistoryCheck <> 0 then
                    InsertBuffer_CounselHistory;
            until Employee.Next = 0;
        end;

        if TotalPreCounsel <> 0 then
            CounselInc := StrSubstNo(PercentageMSG, Round(((TotalCurrCounsel / TotalPreCounsel * 100) - 100), 1, '='))
        else
            CounselInc := '-';

        if GuiAllowed then
            Window.Update(1, StrSubstNo('%1 / %2', 4, 4));

        if GuiAllowed then
            Window.Close;
    end;

    var
        ReferenceDate: Date;
        EmployeeFilter: Text;
        DateOption: Option Day,Month,Year;
        MonthStartDate: Date;
        YearSartDate: Date;
        LitigaionEvaluationAmount: Record "DK_Litigaion Evaluation Amount";
        PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        ReportPrtHistory: Record "DK_Report Prt. History";
        Employee: Record DK_Employee;
        EntryNo: Integer;
        ReportTitleKey: Integer;
        WriterText: Text;
        CreateDateText: Text;
        CreateDateMSG: Label 'ÁŒŠŸ : <Year4>-<Month,2>-<Day,2>';
        WriterMSG: Label 'ÁŒŠÀ : %1';
        ReferenceDateMSG: Label '€Ë‘¹Ÿ : %1 ~ %2';
        EmployeeText: Text;
        EmployeeMSG: Label '„Ô‹ÝÀ : %1';
        ReferenceDateText: Text;
        MSG001: Label '€Ë‘¹ŸŠ —÷Ï ‚»’ÑŠˆ„¾ •½ ‚»’Ñˆª ¯‡’—­ Œ÷ Ž°„Ÿ„¾.';
        PercentageMSG: Label '%1%';
        GeneralAdminInc: Text;
        LandAdminInc: Text;
        TotalAdminInc: Text;
        MailInc: Text;
        CounselInc: Text;
        AllMSG: Label 'All';
        Window: Dialog;
        MSG100: Label 'Processing ReceiptDocument   #1############\';
        TotalCurrGeneralAdmin: Decimal;
        TotalPreGeneralAdmin: Decimal;
        TotalCurrLandAdmin: Decimal;
        TotalPreLandAdmin: Decimal;
        TotalCurrMail: Decimal;
        TotalPreMail: Decimal;
        TotalCurrCounsel: Decimal;
        TotalPreCounsel: Decimal;

    local procedure SetLitigationEvaludation(pOption: Option General,Landscape)
    begin
        //…Ø€ÃŠ Ÿ‰¦ ýˆ«Š± “È™„Ô‹Ý

        LitigaionEvaluationAmount.SetRange("Litigation Evaluation", LitigaionEvaluationAmount."Litigation Evaluation"::A);
        PaymentReceiptDocument.SetRange("Litigation Evaluation", PaymentReceiptDocument."Litigation Evaluation"::A);
        if pOption = pOption::General then
            InsertBuffer_GeneralAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::A))
        else
            InsertBuffer_LandscapeAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::A));

        LitigaionEvaluationAmount.SetRange("Litigation Evaluation", LitigaionEvaluationAmount."Litigation Evaluation"::B);
        PaymentReceiptDocument.SetRange("Litigation Evaluation", PaymentReceiptDocument."Litigation Evaluation"::B);
        if pOption = pOption::General then
            InsertBuffer_GeneralAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::B))
        else
            InsertBuffer_LandscapeAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::B));

        LitigaionEvaluationAmount.SetRange("Litigation Evaluation", LitigaionEvaluationAmount."Litigation Evaluation"::C);
        PaymentReceiptDocument.SetRange("Litigation Evaluation", PaymentReceiptDocument."Litigation Evaluation"::C);
        if pOption = pOption::General then
            InsertBuffer_GeneralAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::C))
        else
            InsertBuffer_LandscapeAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::C));

        LitigaionEvaluationAmount.SetRange("Litigation Evaluation", LitigaionEvaluationAmount."Litigation Evaluation"::D);
        PaymentReceiptDocument.SetRange("Litigation Evaluation", PaymentReceiptDocument."Litigation Evaluation"::D);
        if pOption = pOption::General then
            InsertBuffer_GeneralAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::D))
        else
            InsertBuffer_LandscapeAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::D));

        LitigaionEvaluationAmount.SetRange("Litigation Evaluation", LitigaionEvaluationAmount."Litigation Evaluation"::E);
        PaymentReceiptDocument.SetRange("Litigation Evaluation", PaymentReceiptDocument."Litigation Evaluation"::E);
        if pOption = pOption::General then
            InsertBuffer_GeneralAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::E))
        else
            InsertBuffer_LandscapeAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::E));

        LitigaionEvaluationAmount.SetRange("Litigation Evaluation", LitigaionEvaluationAmount."Litigation Evaluation"::F);
        PaymentReceiptDocument.SetRange("Litigation Evaluation", PaymentReceiptDocument."Litigation Evaluation"::F);
        if pOption = pOption::General then
            InsertBuffer_GeneralAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::F))
        else
            InsertBuffer_LandscapeAdmin(Format(LitigaionEvaluationAmount."Litigation Evaluation"::F));
    end;

    local procedure InsertBuffer_GeneralAdmin(pFieldName: Text)
    var
        _PreMonthStartDate: Date;
        _PreMonthEndDate: Date;
        _PreYearSartDate: Date;
        _PreYeaEndDate: Date;
        _Increase: Decimal;
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
    begin
        //Ÿ‰¦ ýˆ«Š± “È™ „Ô‹Ý
        Clear(_PreMonthStartDate);
        Clear(_PreMonthEndDate);
        Clear(_PreYearSartDate);
        Clear(_PreYeaEndDate);

        _PreMonthEndDate := CalcDate('<-1D>', MonthStartDate);
        _PreMonthStartDate := CalcDate('<-CM>', _PreMonthEndDate);
        _PreYeaEndDate := CalcDate('<-1D>', YearSartDate);
        _PreYearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', _PreYeaEndDate)));

        EntryNo += 1;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 1_2part Daily Report";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 0; //Ÿ‰¦ ýˆ«Š± “È™ „Ô‹Ý
        Header.TEXT0 := pFieldName;

        case DateOption of
            DateOption::Day:
                begin
                    LitigaionEvaluationAmount.SetRange(Date, CalcDate('<-1D>', ReferenceDate));
                    PaymentReceiptDocument.SetRange("Posting Date", ReferenceDate);
                end;
            DateOption::Month:
                begin
                    LitigaionEvaluationAmount.SetRange(Date, CalcDate('<-1D>', MonthStartDate));
                    PaymentReceiptDocument.SetRange("Posting Date", MonthStartDate, ReferenceDate);
                end;
            DateOption::Year:
                begin
                    LitigaionEvaluationAmount.SetRange(Date, CalcDate('<-1D>', YearSartDate));
                    PaymentReceiptDocument.SetRange("Posting Date", YearSartDate, ReferenceDate);
                end;
        end;

        if LitigaionEvaluationAmount.FindSet then begin
            LitigaionEvaluationAmount.CalcSums(TotalCount);
            LitigaionEvaluationAmount.CalcSums(TotalSize);
            LitigaionEvaluationAmount.CalcSums("Non-Pay. Admin Exp. Amount");

            Header.INTEGER14 := LitigaionEvaluationAmount.TotalCount;
            Header.DECIMAL0 := LitigaionEvaluationAmount.TotalSize;
            Header.DECIMAL1 := LitigaionEvaluationAmount."Non-Pay. Admin Exp. Amount";
        end;

        if PaymentReceiptDocument.FindSet then begin
            Header.INTEGER1 := PaymentReceiptDocument.Count;
            repeat
                PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Cemetery Size");

                Header.DECIMAL2 += PaymentReceiptDocument."Cemetery Size";

                _AllExtraAmount := 0;
                _GeneralExtraAmount := 0;

                if PaymentReceiptDocument."Payment Type" <> PaymentReceiptDocument."Payment Type"::DebtRelief then begin
                    if (PaymentReceiptDocument."Line General Amount" <> 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                        _AllExtraAmount := (PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount") / 2;
                        Header.DECIMAL3 += PaymentReceiptDocument."Line General Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
                    end;

                    if (PaymentReceiptDocument."Line General Amount" <> 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" = 0) then begin
                        _GeneralExtraAmount := PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount";
                        Header.DECIMAL3 += PaymentReceiptDocument."Line General Amount" + _GeneralExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
                    end; //€¦‚Ë - Š±€‚„Ô‹Ý
                end;
            until PaymentReceiptDocument.Next = 0;
        end;

        case DateOption of
            DateOption::Day:
                begin
                    PaymentReceiptDocument.SetRange("Posting Date", ReferenceDate - 1);
                end;
            DateOption::Month:
                begin
                    PaymentReceiptDocument.SetRange("Posting Date", _PreMonthStartDate, _PreMonthEndDate);
                end;
            DateOption::Year:
                begin
                    PaymentReceiptDocument.SetRange("Posting Date", _PreYearSartDate, _PreYeaEndDate);
                end;
        end;

        if PaymentReceiptDocument.FindSet then begin
            repeat
                PaymentReceiptDocument.CalcFields("Line General Amount");

                _AllExtraAmount := 0;
                _GeneralExtraAmount := 0;
                if PaymentReceiptDocument."Payment Type" <> PaymentReceiptDocument."Payment Type"::DebtRelief then begin
                    if (PaymentReceiptDocument."Line General Amount" <> 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                        _AllExtraAmount := (PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount") / 2;
                        Header.DECIMAL4 += PaymentReceiptDocument."Line General Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
                    end;

                    if (PaymentReceiptDocument."Line General Amount" <> 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" = 0) then begin
                        _GeneralExtraAmount := PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount";
                        Header.DECIMAL4 += PaymentReceiptDocument."Line General Amount" + _GeneralExtraAmount - PaymentReceiptDocument."Reduction Amount 1";
                    end; //Á‚Ë - €Ë‘¹
                end;
            until PaymentReceiptDocument.Next = 0;
        end;

        //‘ã¿ = (Š±€‚„Ô‹Ý/€Ë‘¹ * 100) - 100
        if Header.DECIMAL4 <> 0 then begin
            _Increase := Round(((Header.DECIMAL3 / Header.DECIMAL4 * 100) - 100), 1, '=');

            if _Increase >= 1000 then begin
                Header.TEXT1 := StrSubstNo(PercentageMSG, 999);
            end else begin
                Header.TEXT1 := StrSubstNo(PercentageMSG, _Increase);
            end;
        end else begin
            Header.TEXT1 := '-';
        end;

        TotalCurrGeneralAdmin += Header.DECIMAL3;
        TotalPreGeneralAdmin += Header.DECIMAL4;

        Header.Insert;
    end;

    local procedure InsertBuffer_LandscapeAdmin(pFieldName: Text)
    var
        _PreMonthStartDate: Date;
        _PreMonthEndDate: Date;
        _PreYearSartDate: Date;
        _PreYeaEndDate: Date;
        _Increase: Decimal;
        _AllExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
    begin
        //‘†µ ýˆ«Š± “È™ „Ô‹Ý
        Clear(_PreMonthStartDate);
        Clear(_PreMonthEndDate);
        Clear(_PreYearSartDate);
        Clear(_PreYeaEndDate);

        _PreMonthEndDate := MonthStartDate - 1;
        _PreMonthStartDate := CalcDate('<-CM>', _PreMonthEndDate);
        _PreYeaEndDate := YearSartDate - 1;
        _PreYearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', _PreYeaEndDate)));

        EntryNo += 1;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 1_2part Daily Report";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 1; //‘†µ ýˆ«Š± “È™ „Ô‹Ý
        Header.TEXT0 := pFieldName;

        case DateOption of
            DateOption::Day:
                begin
                    LitigaionEvaluationAmount.SetRange(Date, ReferenceDate - 1);
                    PaymentReceiptDocument.SetRange("Posting Date", ReferenceDate);
                end;
            DateOption::Month:
                begin
                    LitigaionEvaluationAmount.SetRange(Date, MonthStartDate - 1);
                    PaymentReceiptDocument.SetRange("Posting Date", MonthStartDate, ReferenceDate);
                end;
            DateOption::Year:
                begin
                    LitigaionEvaluationAmount.SetRange(Date, YearSartDate - 1);
                    PaymentReceiptDocument.SetRange("Posting Date", YearSartDate, ReferenceDate);
                end;
        end;

        if LitigaionEvaluationAmount.FindSet then begin
            LitigaionEvaluationAmount.CalcSums(TotalCount);
            LitigaionEvaluationAmount.CalcSums(TotalSize);
            LitigaionEvaluationAmount.CalcSums("Non-Pay. Admin Exp. Amount");

            Header.INTEGER2 := LitigaionEvaluationAmount.TotalCount;
            Header.DECIMAL6 := LitigaionEvaluationAmount.TotalSize;
            Header.DECIMAL7 := LitigaionEvaluationAmount."Non-Pay. Admin Exp. Amount";
        end;

        if PaymentReceiptDocument.FindSet then begin
            Header.DECIMAL8 := PaymentReceiptDocument.Count;

            repeat
                PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Cemetery Size");

                Header.DECIMAL9 += PaymentReceiptDocument."Cemetery Size";
                _AllExtraAmount := 0;
                _LandExtraAmount := 0;
                if PaymentReceiptDocument."Payment Type" <> PaymentReceiptDocument."Payment Type"::DebtRelief then begin
                    if (PaymentReceiptDocument."Line General Amount" <> 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                        _AllExtraAmount := (PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount") / 2;
                        Header.DECIMAL10 += PaymentReceiptDocument."Line Land. Arc. Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
                    end;

                    if (PaymentReceiptDocument."Line General Amount" = 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                        _LandExtraAmount := PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount";
                        Header.DECIMAL10 += PaymentReceiptDocument."Line Land. Arc. Amount" + _LandExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
                    end; //€¦‚Ë - Š±€‚„Ô‹Ý
                end;
            until PaymentReceiptDocument.Next = 0;
        end;

        case DateOption of
            DateOption::Day:
                begin
                    PaymentReceiptDocument.SetRange("Posting Date", ReferenceDate - 1);
                end;
            DateOption::Month:
                begin
                    PaymentReceiptDocument.SetRange("Posting Date", _PreMonthStartDate, _PreMonthEndDate);
                end;
            DateOption::Year:
                begin
                    PaymentReceiptDocument.SetRange("Posting Date", _PreYearSartDate, _PreYeaEndDate);
                end;
        end;

        if PaymentReceiptDocument.FindSet then begin
            repeat
                PaymentReceiptDocument.CalcFields("Line Land. Arc. Amount");
                _AllExtraAmount := 0;
                _LandExtraAmount := 0;
                if PaymentReceiptDocument."Payment Type" <> PaymentReceiptDocument."Payment Type"::DebtRelief then begin
                    if (PaymentReceiptDocument."Line General Amount" <> 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                        _AllExtraAmount := (PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount") / 2;
                        Header.DECIMAL11 += PaymentReceiptDocument."Line Land. Arc. Amount" + _AllExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
                    end;

                    if (PaymentReceiptDocument."Line General Amount" = 0) and (PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                        _LandExtraAmount := PaymentReceiptDocument."Legal Amount" +
                                  PaymentReceiptDocument."Advance Payment Amount" +
                                  PaymentReceiptDocument."Delay Interest Amount";
                        Header.DECIMAL11 += PaymentReceiptDocument."Line Land. Arc. Amount" + _LandExtraAmount - PaymentReceiptDocument."Reduction Amount 2";
                    end; //Á‚Ë - €Ë‘¹
                end;
            until PaymentReceiptDocument.Next = 0;
        end;

        //‘ã¿ = (Š±€‚„Ô‹Ý/€Ë‘¹ * 100) - 100
        if Header.DECIMAL11 <> 0 then begin
            _Increase := Round(((Header.DECIMAL10 / Header.DECIMAL11 * 100) - 100), 1, '=');

            if _Increase >= 1000 then begin
                Header.TEXT2 := StrSubstNo(PercentageMSG, 999);
            end else begin
                Header.TEXT2 := StrSubstNo(PercentageMSG, _Increase);
            end;
        end else begin
            Header.TEXT2 := '-';
        end;

        TotalCurrLandAdmin += Header.DECIMAL10;
        TotalPreLandAdmin += Header.DECIMAL11;

        Header.Insert;
    end;

    local procedure InsertBuffer_MailSend(pReportID: Integer)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        _PreMonthStartDate: Date;
        _PreMonthEndDate: Date;
        _PreYearSartDate: Date;
        _PreYeaEndDate: Date;
        _Increase: Decimal;
    begin
        //Õ–×,Œ¡‡õ ‰ÈŒÁ
        Clear(_PreMonthStartDate);
        Clear(_PreMonthEndDate);
        Clear(_PreYearSartDate);
        Clear(_PreYeaEndDate);

        _PreMonthEndDate := MonthStartDate - 1;
        _PreMonthStartDate := CalcDate('<-CM>', _PreMonthEndDate);
        _PreYeaEndDate := YearSartDate - 1;
        _PreYearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', _PreYeaEndDate)));

        ReportPrtHistory.SetRange("Report ID", pReportID);

        EntryNo += 1;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 1_2part Daily Report";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 3; //Õ–×,Œ¡‡õ ‰ÈŒÁ

        AllObjWithCaption.Reset;
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Report);
        AllObjWithCaption.SetRange("Object ID", pReportID);
        if AllObjWithCaption.FindSet then
            Header.TEXT0 := AllObjWithCaption."Object Caption";

        case DateOption of
            DateOption::Day:
                begin
                    ReportPrtHistory.SetRange("Printing Date", ReferenceDate);
                end;
            DateOption::Month:
                begin
                    ReportPrtHistory.SetRange("Printing Date", MonthStartDate, ReferenceDate);
                end;
            DateOption::Year:
                begin
                    ReportPrtHistory.SetRange("Printing Date", YearSartDate, ReferenceDate);
                end;
        end;

        if ReportPrtHistory.FindSet then
            Header.DECIMAL13 := ReportPrtHistory.Count; //€¦‚Ë - Š±€‚„Ô‹Ý

        case DateOption of
            DateOption::Day:
                begin
                    ReportPrtHistory.SetRange("Printing Date", ReferenceDate - 1);
                end;
            DateOption::Month:
                begin
                    ReportPrtHistory.SetRange("Printing Date", _PreMonthStartDate, _PreMonthEndDate);
                end;
            DateOption::Year:
                begin
                    ReportPrtHistory.SetRange("Printing Date", _PreYearSartDate, _PreYeaEndDate);
                end;
        end;

        if ReportPrtHistory.FindSet then
            Header.DECIMAL14 := ReportPrtHistory.Count; //Á‚Ë - €Ë‘¹

        //‘ã¿ = (Š±€‚„Ô‹Ý/€Ë‘¹ * 100) - 100
        if Header.DECIMAL14 <> 0 then begin
            _Increase := Round(((Header.DECIMAL13 / Header.DECIMAL14 * 100) - 100), 1, '=');

            if _Increase >= 1000 then begin
                Header.TEXT3 := StrSubstNo(PercentageMSG, 999);
            end else begin
                Header.TEXT3 := StrSubstNo(PercentageMSG, _Increase);
            end;
        end else begin
            Header.TEXT3 := '-';
        end;

        TotalCurrMail += Header.DECIMAL13;
        TotalPreMail += Header.DECIMAL14;

        Header.Insert;
    end;

    local procedure InsertBuffer_BillLetter()
    var
        _PublishAdminExpenseDoc: Record "DK_Publish Admin. Expense Doc.";
        _Employee: Record DK_Employee;
        _PreMonthStartDate: Date;
        _PreMonthEndDate: Date;
        _PreYearSartDate: Date;
        _PreYeaEndDate: Date;
        _Increase: Decimal;
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        //Õ–×,Œ¡‡õ ‰ÈŒÁ

        _PreMonthEndDate := MonthStartDate - 1;
        _PreMonthStartDate := CalcDate('<-CM>', _PreMonthEndDate);
        _PreYeaEndDate := YearSartDate - 1;
        _PreYearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', _PreYeaEndDate)));

        _PublishAdminExpenseDoc.Reset;

        EntryNo += 1;
        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 1_2part Daily Report";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 3; //Õ–×,Œ¡‡õ ‰ÈŒÁ

        AllObjWithCaption.Reset;
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Report);
        AllObjWithCaption.SetRange("Object ID", 50025);
        if AllObjWithCaption.FindSet then
            Header.TEXT0 := AllObjWithCaption."Object Caption";

        if EmployeeFilter <> '' then
            _PublishAdminExpenseDoc.SetFilter("Employee No.", EmployeeFilter);

        case DateOption of
            DateOption::Day:
                begin
                    _PublishAdminExpenseDoc.SetRange("Document Date", ReferenceDate);
                end;
            DateOption::Month:
                begin
                    _PublishAdminExpenseDoc.SetRange("Document Date", MonthStartDate, ReferenceDate);
                end;
            DateOption::Year:
                begin
                    _PublishAdminExpenseDoc.SetRange("Document Date", YearSartDate, ReferenceDate);
                end;
        end;

        if _PublishAdminExpenseDoc.FindSet then
            Header.DECIMAL13 := _PublishAdminExpenseDoc.Count;  //€¦‚Ë - Š±€‚„Ô‹Ý

        case DateOption of
            DateOption::Day:
                begin
                    _PublishAdminExpenseDoc.SetRange("Document Date", ReferenceDate - 1);
                end;
            DateOption::Month:
                begin
                    _PublishAdminExpenseDoc.SetRange("Document Date", _PreMonthStartDate, _PreMonthEndDate);
                end;
            DateOption::Year:
                begin
                    _PublishAdminExpenseDoc.SetRange("Document Date", _PreYearSartDate, _PreYeaEndDate);
                end;
        end;

        if _PublishAdminExpenseDoc.FindSet then
            Header.DECIMAL14 := _PublishAdminExpenseDoc.Count;  //Á‚Ë - €Ë‘¹

        //‘ã¿ = (Š±€‚„Ô‹Ý/€Ë‘¹ * 100) - 100
        if Header.DECIMAL14 <> 0 then begin
            _Increase := Round(((Header.DECIMAL13 / Header.DECIMAL14 * 100) - 100), 1, '=');

            if _Increase >= 1000 then begin
                Header.TEXT3 := StrSubstNo(PercentageMSG, 999);
            end else begin
                Header.TEXT3 := StrSubstNo(PercentageMSG, _Increase);
            end;
        end else begin
            Header.TEXT3 := '-';
        end;

        TotalCurrMail += Header.DECIMAL13;
        TotalPreMail += Header.DECIMAL14;

        Header.Insert;
    end;

    local procedure InsertBuffer_CounselHistory()
    var
        _CounselHistory: Record "DK_Counsel History";
        _PreMonthStartDate: Date;
        _PreMonthEndDate: Date;
        _PreYearSartDate: Date;
        _PreYeaEndDate: Date;
        _Increase: Decimal;
    begin
        //‹Ý„Ì •ÔÐ
        _PreMonthEndDate := MonthStartDate - 1;
        _PreMonthStartDate := CalcDate('<-CM>', _PreMonthEndDate);
        _PreYeaEndDate := YearSartDate - 1;
        _PreYearSartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', _PreYeaEndDate)));

        EntryNo += 1;

        Header.Init;
        Header."USER ID" := UserId;
        Header."OBJECT ID" := REPORT::"DK_CS 1_2part Daily Report";
        Header."Entry No." := EntryNo;
        Header.INTEGER0 := 4; //‹Ý„Ì •ÔÐ
        Header.TEXT0 := Employee.Name;

        _CounselHistory.Reset;
        _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
        _CounselHistory.SetRange("Employee No.", Employee."No.");

        case DateOption of
            DateOption::Day:
                begin
                    _CounselHistory.SetRange(Date, ReferenceDate);
                end;
            DateOption::Month:
                begin
                    _CounselHistory.SetRange(Date, MonthStartDate, ReferenceDate);
                end;
            DateOption::Year:
                begin
                    _CounselHistory.SetRange(Date, YearSartDate, ReferenceDate);
                end;
        end;

        _CounselHistory.SetCurrentKey(Type, "Employee No.", Date, "Litigation Type");

        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Reception);
        if _CounselHistory.FindSet then begin
            Header.INTEGER3 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Sending);
        if _CounselHistory.FindSet then begin
            Header.INTEGER4 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Talk);
        if _CounselHistory.FindSet then begin
            Header.INTEGER5 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::SMS);
        if _CounselHistory.FindSet then begin
            Header.INTEGER6 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Etc);
        if _CounselHistory.FindSet then begin
            Header.INTEGER11 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Mail);
        if _CounselHistory.FindSet then begin
            Header.INTEGER7 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Law);
        if _CounselHistory.FindSet then begin
            Header.INTEGER8 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Visit);
        if _CounselHistory.FindSet then begin
            Header.INTEGER9 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Agree);
        if _CounselHistory.FindSet then begin
            Header.INTEGER10 := _CounselHistory.Count;
            Header.INTEGER12 += _CounselHistory.Count;  //€¦‚Ë - Š±€‚„Ô‹Ý
        end;

        case DateOption of
            DateOption::Day:
                begin
                    _CounselHistory.SetRange(Date, ReferenceDate - 1);
                end;
            DateOption::Month:
                begin
                    _CounselHistory.SetRange(Date, _PreMonthStartDate, _PreMonthEndDate);
                end;
            DateOption::Year:
                begin
                    _CounselHistory.SetRange(Date, _PreYearSartDate, _PreYeaEndDate);
                end;
        end;

        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Reception);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Sending);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Talk);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::SMS);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Etc);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Mail);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Law);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Visit);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;
        end;
        _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::Agree);
        if _CounselHistory.FindSet then begin
            Header.INTEGER13 += _CounselHistory.Count;  //Á‚Ë - €Ë‘¹
        end;

        //‘ã¿ = (Š±€‚„Ô‹Ý/€Ë‘¹ * 100)-100
        if Header.INTEGER13 <> 0 then begin
            _Increase := Round(((Header.INTEGER12 / Header.INTEGER13 * 100) - 100), 1, '=');

            if _Increase >= 1000 then begin
                Header.TEXT4 := StrSubstNo(PercentageMSG, 999);
            end else begin
                Header.TEXT4 := StrSubstNo(PercentageMSG, _Increase);
            end;
        end else begin
            Header.TEXT4 := '-';
        end;

        TotalCurrCounsel += Header.INTEGER12;
        TotalPreCounsel += Header.INTEGER13;

        Header.Insert;
    end;

    local procedure InsertBuffer_CounselHistoryCheck(): Integer
    var
        _CounselHistory: Record "DK_Counsel History";
        _CheckCount: Integer;
    begin
        //‹Ý„Ì •ÔÐ

        Clear(_CheckCount);

        _CounselHistory.Reset;
        _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
        _CounselHistory.SetRange("Employee No.", Employee."No.");

        case DateOption of
            DateOption::Day:
                begin
                    _CounselHistory.SetRange(Date, ReferenceDate);
                end;
            DateOption::Month:
                begin
                    _CounselHistory.SetRange(Date, MonthStartDate, ReferenceDate);
                end;
            DateOption::Year:
                begin
                    _CounselHistory.SetRange(Date, YearSartDate, ReferenceDate);
                end;
        end;

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

    local procedure ReferenceDate_Onvalidate()
    begin

        if ReferenceDate > WorkDate then
            Error(MSG001);
    end;
}

