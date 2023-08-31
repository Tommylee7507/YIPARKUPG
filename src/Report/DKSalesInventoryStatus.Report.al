report 50042 "DK_Sales Inventory Status"
{
    // //Ï× —÷˜(‰œ–—ˆ•‘÷)
    // *DK11
    //   - Data Source : CODE0, Name : ReportKey1
    //   - CemeteryConfCode
    // 
    //   - Data Source : CODE1, Name : ReportKey2
    //   - CemeteryDigitCode
    // 
    //   - Data Source : INTEGER3, Name : ReportVsible
    //   - 1 : Ï× —÷˜(‰œ–—ˆ•‘÷)
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKSalesInventoryStatus.rdl';

    Caption = 'Sales Inventory Status';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            UseTemporary = true;
            column(ReportKey1; CODE0)
            {
            }
            column(ReportKey2; CODE1)
            {
            }
            column(CemeteryConfName; TEXT0)
            {
            }
            column(CemeteryDigitName; TEXT1)
            {
            }
            column(CemeteryUnsoldCount; INTEGER0)
            {
            }
            column(CemeteryUnsoldAmount; DECIMAL0)
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
                label("Always current date, based on the inquiry.")
                {
                    Caption = 'Always current date, based on the inquiry.';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Title01Lb = 'Ï× Š¨Œ« Šˆ×Œ¡';
        Cap01Lb = '€ˆŠ¨';
        Cap02Lb = '—ý•’';
        Cap03Lb = 'ºŒ÷';
        Cap04Lb = '€Ë‘¹Ÿ';
        Cap05Lb = '—Œ÷';
        Cap06Lb = '€¦Ž¸';
        Cap07Lb = '“©Ð';
        Cap08Lb = '–Û€³';
        Cap09Lb = '—³Ð';
        Cap10Lb = '(„Âº : €Ë/°)';
    }

    trigger OnPreReport()
    var
        _CemeteryConformation: Record "DK_Cemetery Conformation";
        _CemeteryDigits: Record "DK_Cemetery Digits";
        _Cemetery: Record DK_Cemetery;
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _CemeteryAmount: Decimal;
    begin

        _CemeteryConformation.Reset;
        if _CemeteryConformation.FindSet then begin
            repeat
                _CemeteryDigits.Reset;
                _CemeteryDigits.SetRange("Cemetery Conf. Code", _CemeteryConformation.Code);
                if _CemeteryDigits.FindSet then begin
                    repeat
                        Clear(_CemeteryAmount);
                        EntryNo += 1;

                        Header.Init;
                        Header."USER ID" := UserId;
                        Header."OBJECT ID" := REPORT::"DK_Sales Inventory Status";
                        Header."Entry No." := EntryNo;
                        Header.CODE0 := _CemeteryConformation.Code;
                        Header.CODE1 := _CemeteryDigits.Code;
                        Header.TEXT0 := _CemeteryConformation.Name;
                        Header.TEXT1 := _CemeteryDigits.Name;

                        _Cemetery.Reset;
                        _Cemetery.SetRange("Cemetery Conf. Code", _CemeteryConformation.Code);
                        _Cemetery.SetRange("Cemetery Dig. Code", _CemeteryDigits.Code);
                        _Cemetery.SetRange(Status, _Cemetery.Status::Unsold);
                        if _Cemetery.FindSet then begin
                            repeat
                                _CemeteryAmount += GetCemAmount(_Cemetery, WorkDate) * _Cemetery.Size;
                            until _Cemetery.Next = 0;
                            Header.INTEGER0 := _Cemetery.Count;
                            Header.DECIMAL0 := _CemeteryAmount;
                        end;
                        Header.Insert;
                    until _CemeteryDigits.Next = 0;


                    //ºŒ÷ „†Þ—
                    _Cemetery.Reset;
                    _Cemetery.SetRange("Cemetery Conf. Code", _CemeteryConformation.Code);
                    _Cemetery.SetRange("Cemetery Dig. Code", '');
                    _Cemetery.SetRange(Status, _Cemetery.Status::Unsold);
                    if _Cemetery.FindSet then begin

                        Clear(_CemeteryAmount);
                        repeat
                            _CemeteryAmount += GetCemAmount(_Cemetery, WorkDate) * _Cemetery.Size;
                        until _Cemetery.Next = 0;
                        EntryNo += 1;
                        Header.Init;
                        Header."USER ID" := UserId;
                        Header."OBJECT ID" := REPORT::"DK_Sales Inventory Status";
                        Header."Entry No." := EntryNo;
                        Header.CODE0 := _CemeteryConformation.Code;
                        Header.CODE1 := '';
                        Header.TEXT0 := _CemeteryConformation.Name;
                        Header.TEXT1 := '-';
                        Header.INTEGER0 := _Cemetery.Count;
                        Header.DECIMAL0 := _CemeteryAmount;
                        Header.Insert;
                    end;
                end;
            until _CemeteryConformation.Next = 0;

            //—ý•’,ºŒ÷ „†Þ—
            _Cemetery.Reset;
            _Cemetery.SetRange("Cemetery Conf. Code", '');
            _Cemetery.SetRange("Cemetery Dig. Code", '');
            _Cemetery.SetRange(Status, _Cemetery.Status::Unsold);
            if _Cemetery.FindSet then begin

                Clear(_CemeteryAmount);
                repeat
                    _CemeteryAmount += GetCemAmount(_Cemetery, WorkDate) * _Cemetery.Size;
                until _Cemetery.Next = 0;
                EntryNo += 1;
                Header.Init;
                Header."USER ID" := UserId;
                Header."OBJECT ID" := REPORT::"DK_Sales Inventory Status";
                Header."Entry No." := EntryNo;
                Header.CODE0 := '';
                Header.CODE1 := '';
                Header.TEXT0 := '-';
                Header.TEXT1 := '-';
                Header.INTEGER0 := _Cemetery.Count;
                Header.DECIMAL0 := _CemeteryAmount;
                Header.Insert;
            end;
        end;

        ReferenceDateText := Format(WorkDate, 0, ReferenceMSG);
    end;

    var
        ReferenceDate: Date;
        EntryNo: Integer;
        ReferenceDateText: Text;
        ReferenceMSG: Label 'Reference Date : <Year4>-<Month,2>-<Day,2>';

    local procedure GetCemAmount(pCemetery: Record DK_Cemetery; pContractDate: Date): Decimal
    var
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
    begin

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetCurrentKey("Starting Date");
        _CemeteryUnitPrice.SetRange("Estate Code", pCemetery."Estate Code");
        _CemeteryUnitPrice.SetRange("Cemetery Conf. Code", pCemetery."Cemetery Conf. Code");
        _CemeteryUnitPrice.SetRange("Cemetery Option Code", pCemetery."Cemetery Option Code");
        _CemeteryUnitPrice.SetFilter("Starting Date", '<=%1', pContractDate);
        if _CemeteryUnitPrice.FindLast then begin
            exit(_CemeteryUnitPrice."Unit Price");
        end;
    end;
}

