page 50167 "DK_Selected Contract Matrix"
{
    // 
    // DK34: 20201028
    //   - Add Var: PeriodType, EvaluationFilter,YearDate, MonthDate
    //   - Add Function: PeriodType_Onvalidate, Evaluation_Onvalidate, YearDate_Onvalidate, MonthDate_Onvalidate
    //   - Rec. Modify Function: SetMatrix()
    // 
    // DK34: 20201207
    //   - Delete Field: "Litigation Employee Name"
    //   - Add Field: "Department Name"
    //   - Rec. Modify Function: SetMatrixInit, SetMatrixExportToExcel

    Caption = 'Selected Contract Matrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    ShowFilter = false;
    SourceTable = "DK_Selected Contract";

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(cPeriodType; PeriodType)
                {
                    Caption = 'Period Type';
                    OptionCaption = 'Period,Month';

                    trigger OnValidate()
                    begin
                        PeriodType_Onvalidate;
                    end;
                }
                field(cEmployeeFilter; EmployeeFilter)
                {
                    Caption = 'Employee Filter';

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

                    trigger OnValidate()
                    begin
                        EmployeeFilter_Onvalidate;
                    end;
                }
            }
            group("Date Options")
            {
                Caption = 'Date Options';
                Visible = PeriodVisible;
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
            group("Month Option")
            {
                Caption = 'Month Option';
                Visible = MonthVisible;
                field(cYearDate; YearDate)
                {
                    Caption = 'Year';
                    MaxValue = 2900;
                    MinValue = 1900;

                    trigger OnValidate()
                    begin
                        YearDate_Onvalidate;
                    end;
                }
                field(cMonthDate; MonthDate)
                {
                    Caption = 'Month';
                    MaxValue = 12;
                    MinValue = 1;

                    trigger OnValidate()
                    begin
                        MonthDate_Onvalidate;
                    end;
                }
            }
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    Editable = false;
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                    Editable = false;
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
                field(Field1; MatrixData[1])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Editable = false;
                }
                field(Field2; MatrixData[2])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Editable = false;
                }
                field(Field3; MatrixData[3])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Editable = false;
                }
                field(Field4; MatrixData[4])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Editable = false;
                }
                field(Field5; MatrixData[5])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Editable = false;
                }
                field(Field6; MatrixData[6])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Editable = false;
                }
                field(Field7; MatrixData[7])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Editable = false;
                }
                field(Field8; MatrixData[8])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Editable = false;
                }
                field(Field9; MatrixData[9])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Editable = false;
                }
                field(Field10; MatrixData[10])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PreviousSet)
            {
                Caption = 'Previous Degree';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Previousrecord;
                end;
            }
            action(NextSet)
            {
                Caption = 'Next Degree';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    NextRecord;
                end;
            }
            separator(Action15)
            {
            }
            action(ExportToExcel)
            {
                Caption = 'Export To Excel';
                Ellipsis = true;
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    SetMatrixExportToExcel;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetMatrixRecord;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilterOnUser;
        SetMatrix;
    end;

    var
        TmpDK_CounselHistory: Record "DK_Counsel History" temporary;
        Rows: Integer;
        MatrixCount: Integer;
        MatrixColumnCaptions: array[100] of Text[1024];
        MatrixColumnDegree: array[100] of Integer;
        MatrixData: array[100] of Text[1024];
        TextDegree: Label ' Degree';
        StartDate: Date;
        EndDate: Date;
        Param: Integer;
        TextDateError: Label 'Start date is greater than end date.';
        PeriodType: Option Period,Month;
        YearDate: Integer;
        MonthDate: Integer;
        PeriodVisible: Boolean;
        MonthVisible: Boolean;
        EmployeeFilter: Text;

    local procedure SetMatrix()
    begin
        Param := 0;
        //>> DK34
        PeriodType := PeriodType::Period;
        PeriodType_Onvalidate;

        //StartDate := CALCDATE('-CM',WORKDATE);
        //EndDate := WORKDATE;
        //SetMatrixInit;
        //<<
        SetMatrixCaptioin;
    end;

    local procedure SetMatrixInit()
    var
        _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _DK_ReportMgt.Page50167_SetMatrixInit(TmpDK_CounselHistory, StartDate, EndDate, EmployeeFilter);
    end;

    local procedure SetMatrixCaptioin()
    var
        _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _DK_ReportMgt.Page50167_SetMatrixCaptioin(Param, MatrixColumnCaptions, MatrixColumnDegree);
    end;

    local procedure SetMatrixRecord()
    var
        _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        Clear(MatrixData);
        _DK_ReportMgt.Page50167_SetMatrixRecord(Rec."Contract No.", MatrixColumnDegree, TmpDK_CounselHistory, MatrixData);
    end;

    local procedure SetMatrixExportToExcel()
    var
        _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _DK_ReportMgt.Page50167_ToExcel(StartDate, EndDate, EmployeeFilter);
    end;

    local procedure Previousrecord()
    begin
        if Param = 0 then begin
            Param := 0;
        end else begin
            Param := Param - 10;
        end;
        SetMatrixCaptioin;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure NextRecord()
    begin
        if Param = 0 then begin
            Param := 10;
        end else begin
            Param := Param + 10;
        end;
        SetMatrixCaptioin;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure StartDate_OnValidate()
    begin
        if StartDate <> 0D then
            DateOnValidate;

        SetMatrixInit;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure EndDate_OnValidate()
    begin
        if EndDate <> 0D then
            DateOnValidate;

        SetMatrixInit;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure DateOnValidate()
    begin
        if StartDate > EndDate then
            Error(TextDateError);
    end;

    local procedure PeriodType_Onvalidate()
    begin

        if PeriodType = PeriodType::Period then begin
            PeriodVisible := true;
            MonthVisible := false
        end else begin
            PeriodVisible := false;
            MonthVisible := true;
        end;

        YearDate := Date2DMY(WorkDate, 3);
        MonthDate := Date2DMY(WorkDate, 2);
        StartDate := DMY2Date(1, MonthDate, YearDate);
        EndDate := CalcDate('<CM>', StartDate);

        SetMatrixInit;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure YearDate_Onvalidate()
    begin

        StartDate := DMY2Date(1, MonthDate, YearDate);
        EndDate := CalcDate('<CM>', StartDate);

        SetMatrixInit;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure MonthDate_Onvalidate()
    begin

        StartDate := DMY2Date(1, MonthDate, YearDate);
        EndDate := CalcDate('<CM>', StartDate);

        SetMatrixInit;
        Rec.FindSet;
        CurrPage.Update(false);
    end;

    local procedure EmployeeFilter_Onvalidate()
    begin

        SetMatrixInit;
        Rec.FindSet;
        CurrPage.Update(false);
    end;
}

