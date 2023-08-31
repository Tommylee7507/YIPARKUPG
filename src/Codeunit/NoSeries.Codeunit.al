codeunit 60002 NoSeries
{

    trigger OnRun()
    var
        _FromDate: Date;
        _ToDate: Date;
        _Date: Record Date;
        _NewLineNo: Integer;
        _SerieslCode: Code[20];
        _NoSeries: Record "No. Series";
        _NoSeriesLine: Record "No. Series Line";
    begin

        _FromDate := 20190101D;
        _ToDate := 20500101D;
        _SerieslCode := 'PCO';

        _NoSeries.Reset;
        _NoSeries.SetRange(Code, _SerieslCode);
        if not _NoSeries.FindFirst then
            Error(MSG001, _NoSeries.TableCaption, _SerieslCode);

        _NoSeriesLine.Reset;
        _NoSeriesLine.SetCurrentKey("Series Code", "Line No.");
        _NoSeriesLine.SetRange("Series Code", _SerieslCode);
        if _NoSeriesLine.FindSet then
            _NoSeriesLine.DeleteAll;

        _Date.Reset;
        _Date.SetRange("Period Type", _Date."Period Type"::Month);
        _Date.SetRange("Period Start", _FromDate, _ToDate);
        if _Date.FindSet then begin
            Message('¼Œ÷ %1', _Date.Count);
            repeat
                CreateCustmer(_Date."Period Start", _SerieslCode, '', _NewLineNo);
            until _Date.Next = 0;
        end else begin
            Message('€Ëú ‡õ');
        end;
    end;

    var
        NoSeriesLine: Record "No. Series Line";
        MSG001: Label 'Test';////

    local procedure CreateCustmer(pDate: Date; pNoSeriesCode: Code[20]; pFirstCode: Code[5]; var pNewLineNo: Integer)
    var
        _NoSeries: Record "No. Series";
        _NoSeriesLine: Record "No. Series Line";
    begin

        //Check
        //_NewLineNo := _NoSeriesLine."Line No.";

        pNewLineNo += 10000;

        _NoSeriesLine.Init;
        _NoSeriesLine."Series Code" := pNoSeriesCode;
        _NoSeriesLine."Line No." := pNewLineNo;
        _NoSeriesLine."Starting Date" := pDate;
        _NoSeriesLine."Starting No." := StrSubstNo('%1%2%3', pFirstCode, Format(pDate, 0, '<Year4>-<Month,2>'), '-0001');
        _NoSeriesLine."Ending No." := StrSubstNo('%1%2%3', pFirstCode, Format(pDate, 0, '<Year4>-<Month,2>'), '-9999');
        _NoSeriesLine."Warning No." := StrSubstNo('%1%2%3', pFirstCode, Format(pDate, 0, '<Year4>-<Month,2>'), '-9900');
        _NoSeriesLine.Insert;
    end;
}

