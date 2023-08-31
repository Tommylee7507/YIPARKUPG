page 50208 "DK_Prepayment Not Defined"
{
    Caption = 'Prepayment Not Defined';
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
                field(cDate0; Rec.DATE0)
                {
                    Caption = 'Receipt Date';
                }
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Bank Account Code';
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Bank Account Name';
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Description';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Amount';
                }
            }
            group(Total)
            {
                Caption = 'Total';
                field(TotalAmount; TotalAmount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
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
        TextDateError: Label 'Start date is greater than end date.';
        TotalAmount: Decimal;

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
        _DK_ReportMgt.Page50208_SetRecord(StartDate, EndDate, TotalAmount, Rec);
    end;

    local procedure DelRecord()
    begin
        Clear(TotalAmount);
        Rec.Reset;
        Rec.DeleteAll;
        CurrPage.Update(false);
    end;
}

