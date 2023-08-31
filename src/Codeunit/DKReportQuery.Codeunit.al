codeunit 50039 "DK_Report Query"
{

    trigger OnRun()
    begin
    end;


    procedure CSDailyReportQuery(pPostingDate: Date; pMainCode: Code[20]; pSubCode: Code[20]; var rAmt: array[10] of Decimal; var rCnt: array[10] of Integer)
    var
        _qu: Query "DK_CS Daily Report";
        _totAmt: Decimal;
        _totCnt: Decimal;
        _MonthStartDate: Date;
        _YearStartDate: Date;
    begin
        // ‰ª‘÷ Œ¡Š±Š - œÎ ‘²Ð
        _MonthStartDate := CalcDate('<-CM>', pPostingDate);
        if Date2DMY(pPostingDate, 2) = 12 then
            _YearStartDate := CalcDate('<-CM>', pPostingDate)
        else
            _YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', pPostingDate)));

        Clear(_qu);
        _qu.SetFilter(_qu.PostingDateFilter, '%1..%2', _YearStartDate, pPostingDate);
        if pMainCode <> '' then _qu.SetRange(_qu.MainCatCodeFilter, pMainCode);
        if pSubCode <> '' then _qu.SetRange(_qu.SubCatCodeFilter, pSubCode);
        _qu.Open;
        while _qu.Read do begin
            if pSubCode = '001' then begin  // Œ­Š¨‡õí œÎ(ÐŽÊ€¦) Ÿ µÕíˆˆ —Œ÷ +
                if _qu.PostingDate = pPostingDate then
                    rCnt[1] += _qu.Count;
                if (_qu.PostingDate >= _MonthStartDate) and
                  (_qu.PostingDate <= pPostingDate) then
                    rCnt[2] += _qu.Count;
                if (_qu.PostingDate >= _YearStartDate) and
                  (_qu.PostingDate <= pPostingDate) then
                    rCnt[3] += _qu.Count;
            end;

            if _qu.PostingDate = pPostingDate then
                rAmt[1] += _qu.AmountSum;
            if (_qu.PostingDate >= _MonthStartDate) and
              (_qu.PostingDate <= pPostingDate) then
                rAmt[2] += _qu.AmountSum;
            if (_qu.PostingDate >= _YearStartDate) and
              (_qu.PostingDate <= pPostingDate) then
                rAmt[3] += _qu.AmountSum;
        end;
    end;


    procedure CSDailyReportServiceQuery(pPostingDate: Date; pMainCode: Code[20]; pSubCode: Code[20]; var rAmt: array[10] of Decimal; var rCnt: array[10] of Integer)
    var
        _qu: Query "DK_CS Daily Report";
        _totAmt: Decimal;
        _totCnt: Decimal;
        _MonthStartDate: Date;
        _YearStartDate: Date;
    begin
        // ‰ª‘÷ Œ¡Š±Š - ý“Œ ‘²Ð
        _MonthStartDate := CalcDate('<-CM>', pPostingDate);
        if Date2DMY(pPostingDate, 2) = 12 then
            _YearStartDate := CalcDate('<-CM>', pPostingDate)
        else
            _YearStartDate := CalcDate('<-CM>', CalcDate('<CY>', CalcDate('<-1Y>', pPostingDate)));

        Clear(_qu);
        _qu.SetFilter(_qu.PostingDateFilter, '%1..%2', _YearStartDate, pPostingDate);
        if pMainCode <> '' then _qu.SetRange(_qu.MainCatCodeFilter, pMainCode);
        if pSubCode <> '' then _qu.SetRange(_qu.SubCatCodeFilter, pSubCode);
        _qu.Open;
        while _qu.Read do begin
            if _qu.PostingDate = pPostingDate then
                rCnt[1] += _qu.Count;
            if (_qu.PostingDate >= _MonthStartDate) and
              (_qu.PostingDate <= pPostingDate) then
                rCnt[2] += _qu.Count;
            if (_qu.PostingDate >= _YearStartDate) and
              (_qu.PostingDate <= pPostingDate) then
                rCnt[3] += _qu.Count;

            if _qu.PostingDate = pPostingDate then
                rAmt[1] += _qu.AmountSum;
            if (_qu.PostingDate >= _MonthStartDate) and
              (_qu.PostingDate <= pPostingDate) then
                rAmt[2] += _qu.AmountSum;
            if (_qu.PostingDate >= _YearStartDate) and
              (_qu.PostingDate <= pPostingDate) then
                rAmt[3] += _qu.AmountSum;
        end;
    end;
}

