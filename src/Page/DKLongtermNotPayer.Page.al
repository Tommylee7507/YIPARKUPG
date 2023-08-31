page 50227 "DK_Long-term Not Payer"
{
    Caption = 'Long-term Not Payer';
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
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Contract No.';
                    Editable = false;
                }
                field(DATE1; Rec.DATE1)
                {
                    Caption = 'Contract Date';
                }
                field(CODE1; Rec.CODE1)
                {
                    Caption = 'Cemetery Code';
                    Editable = false;
                    Visible = false;
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Cemetery No.';
                    Editable = false;
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Cemetery Size';
                    Editable = false;
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Period';
                    Editable = false;
                }
                field(TEXT2; Rec.TEXT2)
                {
                    Caption = 'Period';
                    Editable = false;
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'Total Amont';
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    Caption = 'Non-Payment General Amount';
                }
                field(DECIMAL3; Rec.DECIMAL3)
                {
                    Caption = 'Non-Payment Landscape Arc. Amount';
                }
                field(DECIMAL4; Rec.DECIMAL4)
                {
                    Caption = 'Receipt Amount';
                }
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Receipt Date';
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
                PromotedOnly = true;

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
        TextDateError: Label 'Start date is greater than end date.';

    local procedure PageInit()
    begin
        StartDate := CalcDate('-CM', WorkDate);
        EndDate := WorkDate;
    end;

    local procedure StartDate_OnValidate()
    begin
        if StartDate <> 0D then
            DateOnValidate;

        DelRecord;
    end;

    local procedure EndDate_OnValidate()
    begin
        if EndDate <> 0D then
            DateOnValidate;

        DelRecord;
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
        _DK_ReportMgt.Page50227_SetRecord(StartDate, EndDate, Rec);
    end;

    local procedure DelRecord()
    begin
        Rec.Reset;
        Rec.DeleteAll;
        CurrPage.Update(false);
    end;
}

