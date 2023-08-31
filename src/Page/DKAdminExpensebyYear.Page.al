page 50207 "DK_Admin. Expense by Year"
{
    Caption = 'Admin. Expense by Year';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Inquiry';
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(cStartDate; StartDate)
                {
                    Caption = 'Start Date';

                    trigger OnValidate()
                    begin
                        StartDate_OnValidate;
                    end;
                }
                field(cEndDate; EndDate)
                {
                    Caption = 'End Date';

                    trigger OnValidate()
                    begin
                        EndDate_OnValidate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(TEXT3; Rec.TEXT3)
                {
                    Caption = 'Admin. Expense  Type';
                }
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Contract No.';
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Name';
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Contact';
                }
                field(cDate0; Rec.DATE0)
                {
                    Caption = 'Date';
                }
                field(TEXT2; Rec.TEXT2)
                {
                    Caption = 'Period';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Size';
                }
                field(cFieldRemain; Rec.DECIMAL1)
                {
                    Caption = 'Remaining Amount';
                }
                field(cFieldAmt1; Rec.DECIMAL2)
                {
                    CaptionClass = '3,' + ColumnCaptions[1];
                }
                field(cFieldAmt2; Rec.DECIMAL3)
                {
                    CaptionClass = '3,' + ColumnCaptions[2];
                }
                field(cFieldAmt3; Rec.DECIMAL4)
                {
                    CaptionClass = '3,' + ColumnCaptions[3];
                }
                field(cFieldAmt4; Rec.DECIMAL5)
                {
                    CaptionClass = '3,' + ColumnCaptions[4];
                }
                field(cFieldAmt5; Rec.DECIMAL6)
                {
                    CaptionClass = '3,' + ColumnCaptions[5];
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(cSetRecord)
            {
                Caption = 'Inquery';
                Ellipsis = true;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetRecord;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        PageInit;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        ColumnCaptions: array[10] of Text[100];
        CapYear: Label 'Year';
        CapPre: Label 'Priv';
        DatePeriod: array[10] of Date;
        TextDateError: Label 'Start date is greater than end date.';

    local procedure PageInit()
    begin
        StartDate := CalcDate('-CM', WorkDate);
        EndDate := WorkDate;
        UpdateColumnCaptions;
    end;

    local procedure StartDate_OnValidate()
    begin
        if StartDate <> 0D then
            DateOnValidate;

        DelRecord;
        UpdateColumnCaptions;
    end;

    local procedure EndDate_OnValidate()
    begin
        if EndDate <> 0D then
            DateOnValidate;

        DelRecord;
        UpdateColumnCaptions;
    end;

    local procedure DateOnValidate()
    begin
        if StartDate > EndDate then
            Error(TextDateError);
    end;

    local procedure SetRecord()
    var
        _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _DK_ReportMgt.Page50207_SetRecord(DatePeriod, Rec);
    end;

    local procedure DelRecord()
    begin
        Rec.Reset;
        Rec.DeleteAll;
        CurrPage.Update(false);
    end;

    local procedure UpdateColumnCaptions()
    var
        _BaseYear: Integer;
    begin
        _BaseYear := Date2DMY(EndDate, 3);
        ColumnCaptions[5] := Format(_BaseYear) + ' ' + CapYear;
        ColumnCaptions[4] := Format(_BaseYear - 1) + ' ' + CapYear;
        ColumnCaptions[3] := Format(_BaseYear - 2) + ' ' + CapYear;
        ColumnCaptions[2] := Format(_BaseYear - 3) + ' ' + CapYear;
        ColumnCaptions[1] := Format(_BaseYear - 4) + ' ' + CapYear + ' ' + CapPre;

        DatePeriod[1] := 0D;
        DatePeriod[2] := DMY2Date(31, 12, _BaseYear - 4);
        DatePeriod[3] := DMY2Date(1, 1, _BaseYear - 3);
        DatePeriod[4] := DMY2Date(31, 12, _BaseYear - 3);
        DatePeriod[5] := DMY2Date(1, 1, _BaseYear - 2);
        DatePeriod[6] := DMY2Date(31, 12, _BaseYear - 2);
        DatePeriod[7] := DMY2Date(1, 1, _BaseYear - 1);
        DatePeriod[8] := DMY2Date(31, 12, _BaseYear - 1);
        DatePeriod[9] := StartDate;
        DatePeriod[10] := EndDate;
    end;
}

