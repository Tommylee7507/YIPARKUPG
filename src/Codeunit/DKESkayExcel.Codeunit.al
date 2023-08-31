codeunit 50024 "DK_E-Skay Excel"
{
    // A : Œ°Œ¡
    // B : “Œ‚€ˆŠ¨
    // C : €ˆŠ¨
    // D : €‰ø€ˆŠ¨
    // E : ŒŠŠ
    // F : ‹Ïˆ‘Àˆ×
    // G : ‘´‰ž…Ø‡Ÿ‰°˜ú
    // H : ‹Ïˆ‘ŸÀ
    // I : œÔŸÀ
    // J : œÔŸÀ
    // K : ‘´Œ­
    // L : Õ–×‰°˜ú
    // M : …Ø‡ŸŸÀ
    // N : €‰ø€ˆŠ¨
    // O : ŒŠŠ
    // P : ŒŠˆ×
    // Q : ‹²‚ËõŸ
    // R : ‹Ïˆ‘À—ýÐ
    // S : ý˜¡‰°˜ú
    // T : ‘´Œ­
    // U : Õ–×‰°˜ú
    // V : Š±×


    trigger OnRun()
    begin
    end;

    var
        DK_ESkyData: Record "DK_E-Sky Data";
        ExcelBuf: Record "Excel Buffer";
        ServerFileName: Text;
        SheetName: Text[250];
        StartRows: Integer;
        Text001: Label 'Import Excel File';
        TextConfirm: Label 'There is already data. Are you sure you want to delete and re-upload?';
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;
        TotalRows: Integer;
        LastSequence: Integer;
        BaseYear: Integer;
        BaseMonth: Option;
        LineNo: Integer;
        StartDate: Date;
        EndDate: Date;

    procedure ImportExcelFiles(pYear: Integer; pMonth: Option)
    begin
        BaseYear := pYear;
        BaseMonth := pMonth;

        StartDate := DMY2Date(1, BaseMonth + 1, BaseYear);
        EndDate := CalcDate('CM', StartDate);
        if ESkyExists then
            if not Confirm(TextConfirm, false) then
                exit;

        if not UploadFiles then
            exit;

        ESkyDelete;

        ExcelBuf.LockTable;
        // ExcelBuf.OpenBook(ServerFileName, SheetName);////zzz
        ExcelBuf.ReadSheet;
        GetLastRows;
        for StartRows := 4 to TotalRows do
            InsertESky(StartRows);

        ExcelBuf.DeleteAll;

        Excel_Record;
        ComPare_RecordLast;
    end;

    local procedure UploadFiles(): Boolean
    var
        _FileMgt: Codeunit "File Management";
    begin
        // ServerFileName := _FileMgt.UploadFile(Text001, ExcelFileExtensionTok);////zzz
        if ServerFileName = '' then
            exit(false);

        // SheetName := ExcelBuf.SelectSheetsName(ServerFileName);////zzz
        if SheetName = '' then
            exit(false)
        else
            exit(true);
    end;

    local procedure InsertESky(pStartRows: Integer)
    var
        _Integer: Integer;
        _Date: Date;
    begin
        LineNo += 10000;
        with DK_ESkyData do begin
            Init;
            "Base Year" := BaseYear;
            "Base Month" := BaseMonth;
            "Line No" := LineNo;
            if GetValueCell(pStartRows, 1) = '' then
                _Integer := 0
            else
                if not Evaluate(_Integer, GetValueCell(pStartRows, 1)) then
                    _Integer := 0;
            "E-Sequence" := _Integer;
            Sequence := _Integer;
            LastSequence := Sequence;
            "Company Name" := GetValueCell(pStartRows, 2);
            Type := GetValueCell(pStartRows, 3);
            Nationality := GetValueCell(pStartRows, 4);
            Sex := GetValueCell(pStartRows, 5);
            Name := DelChr(GetValueCell(pStartRows, 6), '=', ' ');
            "Social Security No." := DelChr(GetValueCell(pStartRows, 7), '=', ' ');
            if GetValueCell(pStartRows, 8) = '' then
                _Date := 0D
            else
                if not Evaluate(_Date, GetValueCell(pStartRows, 8)) then
                    _Date := 0D;
            if _Date <> 0D then
                "Date of death Text" := Format(_Date, 0, '<Year4>-<Month,2>-<day,2>');

            if GetValueCell(pStartRows, 9) = '' then
                _Date := 0D
            else
                if not Evaluate(_Date, GetValueCell(pStartRows, 9)) then
                    _Date := 0D;
            "Start Date" := _Date;
            if GetValueCell(pStartRows, 10) = '' then
                _Date := 0D
            else
                if not Evaluate(_Date, GetValueCell(pStartRows, 10)) then
                    _Date := 0D;
            "End Date" := _Date;
            Address := GetValueCell(pStartRows, 11);
            "Post Code" := GetValueCell(pStartRows, 12);
            if GetValueCell(pStartRows, 13) = '' then
                _Date := 0D
            else
                if not Evaluate(_Date, GetValueCell(pStartRows, 13)) then
                    _Date := 0D;
            "Reg. Date" := _Date;
            "Nationality 2" := GetValueCell(pStartRows, 14);
            "Sex 2" := GetValueCell(pStartRows, 15);
            "Name 2" := GetValueCell(pStartRows, 16);
            if GetValueCell(pStartRows, 17) = '' then
                _Date := 0D
            else
                if not Evaluate(_Date, GetValueCell(pStartRows, 17)) then
                    _Date := 0D;
            "Birth Date" := _Date;
            Relation := GetValueCell(pStartRows, 18);
            "Tel No." := GetValueCell(pStartRows, 19);
            "Address 2" := GetValueCell(pStartRows, 20);
            "Post Code 2" := GetValueCell(pStartRows, 21);
            Remark := GetValueCell(pStartRows, 22);
            "Style No." := 0;
            "Upload Date" := Today;
            Insert(true);
        end;
    end;

    local procedure GetValueCell(RowNo: Integer; ColNo: Integer): Text
    var
        _ExcelBuffer: Record "Excel Buffer";
    begin
        if _ExcelBuffer.Get(RowNo, ColNo) then;
        exit(_ExcelBuffer."Cell Value as Text");
    end;

    local procedure GetLastRows()
    begin
        ExcelBuf.SetCurrentKey("Row No.");
        ExcelBuf.FindLast;
        TotalRows := ExcelBuf."Row No.";
    end;

    local procedure ESkyExists(): Boolean
    begin
        with DK_ESkyData do begin
            Reset;
            SetRange("Base Year", BaseYear);
            SetRange("Base Month", BaseMonth);
            exit(FindFirst);
        end;
    end;

    local procedure ESkyDelete(): Boolean
    var
        _DK_ESkyData: Record "DK_E-Sky Data";
    begin
        with DK_ESkyData do begin
            Reset;
            SetRange("Base Year", BaseYear);
            SetRange("Base Month", BaseMonth);
            if FindSet then
                DeleteAll;
        end;
        Commit;
    end;

    local procedure Excel_Record()
    var
        _DK_Corpse: Record DK_Corpse;
    begin
        with _DK_Corpse do begin
            Reset;
            SetRange("Laying Date", StartDate, EndDate);
            if FindSet then
                repeat
                    if not Excel_Update(_DK_Corpse) then
                        Excel_Insert(_DK_Corpse);
                until Next = 0;
        end;
    end;

    local procedure Excel_Update(pDK_Corpse: Record DK_Corpse): Boolean
    var
        _DK_Contract: Record DK_Contract;
    begin
        with DK_ESkyData do begin
            Reset;
            SetRange("Base Year", BaseYear);
            SetRange("Base Month", BaseMonth);
            SetRange(Name, pDK_Corpse.Name);
            SetRange("Start Date", pDK_Corpse."Laying Date");
            if FindSet then begin
                "Contract No." := pDK_Corpse."Contract No.";
                "Cemetery Code" := pDK_Corpse."Cemetery Code";
                "Cemetery No." := pDK_Corpse."Cemetery No.";
                if _DK_Contract.Get("Contract No.") then begin
                    "Main Customer No." := _DK_Contract."Main Customer No.";
                    "Main Customer Name" := _DK_Contract."Main Customer Name";
                end;
                "Field Work Sub Cat. Code" := pDK_Corpse."Field Work Main Cat. Code";
                "Field Work Sub Cat. Name" := pDK_Corpse."Field Work Main Cat. Name";
                "Death Date" := pDK_Corpse."Death Date";
                "Laying Date" := pDK_Corpse."Laying Date";
                "Name 3" := pDK_Corpse.Name;
                "Social Security No 2." := pDK_Corpse."Social Security No.";
                ComPare_Record(DK_ESkyData);
                Modify;
                exit(true);
            end else begin
                exit(false);
            end;
        end;
    end;

    local procedure Excel_Insert(pDK_Corpse: Record DK_Corpse)
    var
        _DK_Contract: Record DK_Contract;
    begin
        with DK_ESkyData do begin
            LineNo += 10000;
            LastSequence += 1;
            Reset;
            Init;
            "Base Year" := BaseYear;
            "Base Month" := "Base Month";
            "Line No" := LineNo;
            Sequence := LastSequence;
            "Contract No." := pDK_Corpse."Contract No.";
            "Cemetery Code" := pDK_Corpse."Cemetery Code";
            "Cemetery No." := pDK_Corpse."Cemetery No.";
            if _DK_Contract.Get("Contract No.") then begin
                "Main Customer No." := _DK_Contract."Main Customer No.";
                "Main Customer Name" := _DK_Contract."Main Customer Name";
            end;
            "Field Work Sub Cat. Code" := pDK_Corpse."Field Work Main Cat. Code";
            "Field Work Sub Cat. Name" := pDK_Corpse."Field Work Main Cat. Name";
            "Death Date" := pDK_Corpse."Death Date";
            "Laying Date" := pDK_Corpse."Laying Date";
            "Name 3" := pDK_Corpse.Name;
            "Social Security No 2." := pDK_Corpse."Social Security No.";
            "Style No." := 3;
            Insert(true);
        end;
    end;

    local procedure ComPare_Record(var pDK_ESkyData: Record "DK_E-Sky Data")
    begin
        with pDK_ESkyData do begin
            if "Social Security No 2." <> "Social Security No." then
                "Style No." := 2;
            if "Name 2" <> "Main Customer Name" then
                "Style No." := 5;
        end;
    end;

    local procedure ComPare_RecordLast()
    begin
        with DK_ESkyData do begin
            Reset;
            SetRange("Base Year", BaseYear);
            SetRange("Base Month", BaseMonth);
            SetRange("Contract No.", '');
            if FindSet then
                ModifyAll("Style No.", 7);
        end;
    end;
}

