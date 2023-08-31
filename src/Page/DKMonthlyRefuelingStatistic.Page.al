page 50216 "DK_Monthly Refueling Statistic"
{
    Caption = 'Monthly Refueling Statistics';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "DK_Report Buffer";

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(ReferenceDateFilter; ReferenceDateFilter)
                {
                    Caption = 'Reference DateYear';
                    MaxValue = 2999;
                    MinValue = 1999;

                    trigger OnValidate()
                    begin
                        Option_Onvalidate;
                    end;
                }
                group(Control33)
                {
                    ShowCaption = false;
                    group(Control7)
                    {
                        ShowCaption = false;
                        field(MonthFromFilter; MonthFromFilter)
                        {
                            Caption = 'MonthFrom';
                            MaxValue = 12;
                            MinValue = 1;

                            trigger OnValidate()
                            begin
                                Option_Onvalidate;
                            end;
                        }
                        field(MonthToFilter; MonthToFilter)
                        {
                            Caption = 'MonthTo';
                            MaxValue = 12;
                            MinValue = 1;

                            trigger OnValidate()
                            begin
                                Option_Onvalidate;
                            end;
                        }
                    }
                }
            }
            repeater(Group)
            {
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Vehicle Type';
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Vehicle No.';
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Operating Distance';
                }
                field(DECIMAL13; Rec.DECIMAL13)
                {
                    Caption = 'Km Cumulative';
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Average Fuel Economy';
                }
                field(INTEGER0; Rec.INTEGER0)
                {
                    CaptionClass = '3,' + MatrixColumnCaptionCount[1];
                    Caption = '1Month Count';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    CaptionClass = MatrixColumnCaptionAmount[1];
                    Caption = '1Month Amount';
                }
                field(INTEGER1; Rec.INTEGER1)
                {
                    CaptionClass = MatrixColumnCaptionCount[2];
                    Caption = '2Month Count';
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    CaptionClass = MatrixColumnCaptionAmount[2];
                    Caption = '2Month Amount';
                }
                field(INTEGER2; Rec.INTEGER2)
                {
                    CaptionClass = MatrixColumnCaptionCount[3];
                    Caption = '3Month Count';
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    CaptionClass = MatrixColumnCaptionAmount[3];
                    Caption = '3Month Amount';
                }
                field(INTEGER3; Rec.INTEGER3)
                {
                    CaptionClass = MatrixColumnCaptionCount[4];
                    Caption = '4Month Countr';
                }
                field(DECIMAL3; Rec.DECIMAL3)
                {
                    CaptionClass = MatrixColumnCaptionAmount[4];
                    Caption = '4Month Amount';
                }
                field(INTEGER4; Rec.INTEGER4)
                {
                    CaptionClass = MatrixColumnCaptionCount[5];
                    Caption = '5Month Countr';
                }
                field(DECIMAL4; Rec.DECIMAL4)
                {
                    CaptionClass = MatrixColumnCaptionAmount[5];
                    Caption = '5Month Amount';
                }
                field(INTEGER5; Rec.INTEGER5)
                {
                    CaptionClass = MatrixColumnCaptionCount[6];
                    Caption = '6Month Countr';
                }
                field(DECIMAL5; Rec.DECIMAL5)
                {
                    CaptionClass = MatrixColumnCaptionAmount[6];
                    Caption = '6Month Amount';
                }
                field(INTEGER6; Rec.INTEGER6)
                {
                    CaptionClass = MatrixColumnCaptionCount[7];
                    Caption = '7Month Count';
                }
                field(DECIMAL6; Rec.DECIMAL6)
                {
                    CaptionClass = MatrixColumnCaptionAmount[7];
                    Caption = '7Month Amount';
                }
                field(INTEGER7; Rec.INTEGER7)
                {
                    CaptionClass = MatrixColumnCaptionCount[8];
                    Caption = '8Month Countr';
                }
                field(DECIMAL7; Rec.DECIMAL7)
                {
                    CaptionClass = MatrixColumnCaptionAmount[8];
                    Caption = '8Month Amount';
                }
                field(INTEGER8; Rec.INTEGER8)
                {
                    CaptionClass = MatrixColumnCaptionCount[9];
                    Caption = '9Month Count';
                }
                field(DECIMAL8; Rec.DECIMAL8)
                {
                    CaptionClass = MatrixColumnCaptionAmount[9];
                    Caption = '9Month Amount';
                }
                field(INTEGER9; Rec.INTEGER9)
                {
                    CaptionClass = MatrixColumnCaptionCount[10];
                    Caption = '10Month Count';
                }
                field(DECIMAL9; Rec.DECIMAL9)
                {
                    CaptionClass = MatrixColumnCaptionAmount[10];
                    Caption = '10Month Amount';
                }
                field(INTEGER10; Rec.INTEGER10)
                {
                    CaptionClass = MatrixColumnCaptionCount[11];
                    Caption = '11Month Count';
                }
                field(DECIMAL10; Rec.DECIMAL10)
                {
                    CaptionClass = MatrixColumnCaptionAmount[11];
                    Caption = '11Month Amount';
                }
                field(INTEGER11; Rec.INTEGER11)
                {
                    CaptionClass = MatrixColumnCaptionCount[12];
                    Caption = '12Month Count';
                }
                field(DECIMAL11; Rec.DECIMAL11)
                {
                    CaptionClass = MatrixColumnCaptionAmount[12];
                    Caption = '12Month Amount';
                }
                field(INTEGER12; Rec.INTEGER12)
                {
                    Caption = 'Total Count';
                }
                field(DECIMAL12; Rec.DECIMAL12)
                {
                    Caption = 'Total Amount';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Inquiry)
            {
                Caption = 'Inquiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SetFilterDelete;
                    SetMatrixRecord;

                    if Rec.FindFirst then;

                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetFilterDelete;

        SetFilterOnUser;
        SetMatrix;
    end;

    var
        ReferenceDateFilter: Integer;
        MonthFromFilter: Integer;
        MonthToFilter: Integer;
        ParamYear: Integer;
        MatrixColumnCaptionCount: array[12] of Text[1024];
        MatrixColumnCaptionAmount: array[12] of Text[1024];
        ParamStartMonth: Integer;
        ParamEndMonth: Integer;


    procedure SetFilterOnUser()
    begin

        Rec.FilterGroup(2);
        Rec.SetRange("USER ID", UserId);
        Rec.SetRange("OBJECT ID", PAGE::"DK_Monthly Refueling Statistic");
        Rec.FilterGroup(0);
    end;

    local procedure SetMatrix()
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
    begin
        ReferenceDateFilter := Date2DMY(WorkDate, 3);
        MonthFromFilter := 1;

        _VehicleRefueLedEntry.Reset;
        _VehicleRefueLedEntry.SetCurrentKey("Entry No.");
        _VehicleRefueLedEntry.SetFilter("Oiling Date", '<>%1', 0D);
        if _VehicleRefueLedEntry.FindLast then begin
            MonthToFilter := Date2DMY(_VehicleRefueLedEntry."Oiling Date", 2);
        end else begin
            MonthToFilter := Date2DMY(WorkDate, 2);
        end;

        ParamYear := ReferenceDateFilter;
        ParamStartMonth := MonthFromFilter;
        ParamEndMonth := MonthToFilter;

        SetMatrixCaption;
    end;

    local procedure SetMatrixCaption()
    var
        _ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _ReportMgt.Page50216_SetMatrixCaption(MatrixColumnCaptionCount, MatrixColumnCaptionAmount);
    end;

    local procedure SetMatrixRecord()
    var
        _ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _ReportMgt.Page50216_SetMatrixRecord(Rec, ParamYear, ParamStartMonth, ParamEndMonth);
    end;

    local procedure SetFilterDelete()
    begin
        Rec.SetRange("USER ID", UserId);
        Rec.SetRange("OBJECT ID", PAGE::"DK_Monthly Refueling Statistic");
        if Rec.FindSet then
            Rec.DeleteAll;
    end;

    local procedure Previousrecord()
    begin
        /*
        IF ParamYear = 0 THEN BEGIN
          ParamYear := YearFromFilter;
        END ELSE BEGIN
          IF ParamYear > YearFromFilter THEN BEGIN
            ParamYear -= 1;
            IF YearFromFilter <> YearToFilter THEN BEGIN
              IF ParamYear < YearToFilter THEN
                ParamEndMonth := 12
              ELSE
                ParamEndMonth := MonthToFilter;
        
              IF ParamYear = YearFromFilter THEN
                ParamStartMonth := MonthFromFilter
              ELSE
                ParamStartMonth := 1;
            END;
          END;
        END;
        
        SetMatrixCaption;
        SetFilterDelete;
        SetMatrixRecord;
        FINDFIRST;
        */

    end;

    local procedure NextRecord()
    begin
        /*
        IF ParamYear = 0 THEN BEGIN
          ParamYear := YearFromFilter;
        END ELSE BEGIN
          IF ParamYear < YearToFilter THEN BEGIN
            ParamYear += 1;
            IF YearFromFilter <> YearToFilter THEN BEGIN
              IF ParamYear < YearToFilter THEN
                ParamEndMonth := 12
              ELSE
                ParamEndMonth := MonthToFilter;
        
              IF ParamYear = YearFromFilter THEN
                ParamStartMonth := MonthFromFilter
              ELSE
                ParamStartMonth := 1;
            END;
          END;
        END;
        
        SetMatrixCaption;
        SetFilterDelete;
        SetMatrixRecord;
        FINDFIRST;
        */

    end;

    local procedure Option_Onvalidate()
    begin
        ParamYear := ReferenceDateFilter;
        ParamStartMonth := MonthFromFilter;
        ParamEndMonth := MonthToFilter;

        SetFilterDelete;
        SetMatrixCaption;
    end;
}

