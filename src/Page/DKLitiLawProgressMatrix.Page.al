page 50281 "DK_Liti. Law Progress Matrix"
{
    Caption = 'Litigation Law Progress Matrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(cTypeFilter; TypeFilter)
                {
                    Caption = 'Type';
                    OptionCaption = 'Blank,Lawsuit,Deposit,Insurance,Corporeal,Obligation';

                    trigger OnValidate()
                    begin
                        TypeFilter_Onvalidate;
                    end;
                }
                field(cContractNoFilter; ContractNoFilter)
                {
                    Caption = 'Contract No';
                    TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));

                    trigger OnValidate()
                    begin
                        ContractNo_Onvalidate;
                    end;
                }
                field(cCemeteryFilter; CemeteryFilter)
                {
                    Caption = 'Cemetery';
                    TableRelation = DK_Cemetery;

                    trigger OnValidate()
                    begin
                        Cemetery_Onvalidate;
                    end;
                }
            }
            group("Date Option")
            {
                Caption = 'Date Option';
                field(cLawRecStartDateFilter; LawRecStartDateFilter)
                {
                    Caption = 'LawsuitRecDateFilter';

                    trigger OnValidate()
                    begin
                        LawRecStartDateFilter_Onvalidate;
                    end;
                }
                field(LawRecEndDateFilter; LawRecEndDateFilter)
                {
                    Caption = 'LawRecEndDateFilter';

                    trigger OnValidate()
                    begin
                        LawRecEndDateFilter_Onvalidate;
                    end;
                }
            }
            repeater(Control2)
            {
                Editable = false;
                ShowCaption = false;
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'No.';
                    Visible = false;
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Type';
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Progress Status';
                }
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Contract Date';
                }
                field("SHORT TEXT2"; Rec."SHORT TEXT2")
                {
                    Caption = 'Main Customer Name';
                }
                field(TEXT3; Rec.TEXT3)
                {
                    Caption = 'Cemetery No.';
                }
                field("SHORT TEXT3"; Rec."SHORT TEXT3")
                {
                    Caption = 'Cemetery Status';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Cemetery Size';
                }
                field(DATE1; Rec.DATE1)
                {
                    Caption = 'General Expiration Date';
                }
                field(DATE2; Rec.DATE2)
                {
                    Caption = 'Land. Arc. Expiration Date';
                }
                field("SHORT TEXT4"; Rec."SHORT TEXT4")
                {
                    Caption = 'Litigation Evaluation';
                }
                field(Field1; Rec.DATE3)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                }
                field(Field2; Rec.TEXT6)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                }
                field(Field3; Rec.TEXT7)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                }
                field(Field4; Rec.TEXT8)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                }
                field(Field5; Rec.TEXT9)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                }
                field(Field6; Rec.TEXT10)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                }
                field(Field7; Rec.TEXT11)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                }
                field(Field8; Rec.TEXT12)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                }
                field(Field9; Rec.DECIMAL1)
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                }
                field(Fied12; Rec.DECIMAL2)
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                }
                field(Fied13; Rec.DECIMAL3)
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[13];
                }
                field(Field10; Rec.DATE4)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                }
                field(Field11; Rec.TEXT13)
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
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
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SetMatrixDelete;
                    SetMatrixInit;

                    if Rec.FindSet then begin
                        Rec.FindSet;
                        CurrPage.Update(false);
                    end;
                end;
            }
            group(Action27)
            {
                action(PreviousSet)
                {
                    Caption = 'Previous';
                    Image = PreviousSet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        PreviousRecord;
                    end;
                }
                action(NextSet)
                {
                    Caption = 'Next';
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
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetMatrix;
    end;

    var
        MatrixData: array[100] of Text[1024];
        MatrixColumnCaptions: array[100] of Text[1024];
        TypeFilter: Option Blank,Lawsuit,Deposit,Insurance,Corporeal,Obligation;
        ContractNoFilter: Code[20];
        CemeteryFilter: Code[20];
        LawRecStartDateFilter: Date;
        LawRecEndDateFilter: Date;
        ParamType: Option Lawsuit,Deposit,Insurance,Corporeal,Obligation;
        MSG001: Label 'Start date is greater than end date.';
        MSG002: Label 'The start date is empty.';
        MSG003: Label 'The end date is empty.';

    local procedure SetMatrix()
    begin

        ParamType := ParamType::Lawsuit;        // ”ˆŒ— €ˆŠ¨

        TypeFilter := TypeFilter::Blank;        // ‘†˜ˆ €ˆŠ¨
        ContractNoFilter := '';
        CemeteryFilter := '';

        LawRecStartDateFilter := 0D;
        LawRecEndDateFilter := 0D;

        SetMatrixDelete;
        SetMatrixCaption;
    end;

    local procedure SetMatrixInit()
    var
        _LitigationLawProgress: Record "DK_Litigation Law Progress";
        _EntryNo: BigInteger;
    begin

        SetMatrixDelete;

        if (LawRecStartDateFilter = 0D) and (LawRecEndDateFilter <> 0D) then
            Error(MSG002)
        else
            if (LawRecStartDateFilter <> 0D) and (LawRecEndDateFilter = 0D) then
                Error(MSG003);

        _LitigationLawProgress.Reset;

        if TypeFilter <> TypeFilter::Blank then
            _LitigationLawProgress.SetRange(Type, (TypeFilter - 1));

        if ContractNoFilter <> '' then
            _LitigationLawProgress.SetRange("Contract No.", ContractNoFilter);

        if CemeteryFilter <> '' then
            _LitigationLawProgress.SetRange("Cemetery Code", CemeteryFilter);

        if (LawRecStartDateFilter <> 0D) and (LawRecEndDateFilter <> 0D) then
            _LitigationLawProgress.SetRange("Lawsuit Reception Date", LawRecStartDateFilter, LawRecEndDateFilter);

        if _LitigationLawProgress.FindSet then begin
            repeat
                _LitigationLawProgress.CalcFields("Main Customer Name", "Cemetery Status", "General Expiration Date", "Land. Arc. Expiration Date");
                _EntryNo += 1;

                Rec.Init;
                Rec."USER ID" := UserId;
                Rec."Entry No." := _EntryNo;
                Rec."OBJECT ID" := PAGE::"DK_Liti. Law Progress Matrix";
                Rec.CODE0 := _LitigationLawProgress."No.";                                    // ‰°˜ú
                Rec."SHORT TEXT0" := Format(_LitigationLawProgress.Type);                     // €ˆŠ¨
                Rec."SHORT TEXT1" := Format(_LitigationLawProgress."Progress Status");        // ‘°—Ê ‹Ý•’
                Rec.DATE0 := _LitigationLawProgress."Contract Date";                          // ÐŽÊ ŸÀ
                Rec."SHORT TEXT2" := _LitigationLawProgress."Main Customer Name";             // ÐŽÊÀ
                Rec.TEXT3 := _LitigationLawProgress."Cemetery No.";                           // ‰ª¬ ‰°˜ú
                Rec."SHORT TEXT3" := Format(_LitigationLawProgress."Cemetery Status");        // ‰ª¬ ‹Ý•’
                Rec.DECIMAL0 := _LitigationLawProgress."Cemetery Size";                       // ‰ª¬ ˆÒø
                Rec.DATE1 := _LitigationLawProgress."General Expiration Date";                // Ÿ‰¦ ýˆ«Š± ‘Ž‡ßŸ
                Rec.DATE2 := _LitigationLawProgress."Land. Arc. Expiration Date";             // ‘†µ ýˆ«Š± ‘Ž‡ßŸ
                Rec."SHORT TEXT4" := Format(_LitigationLawProgress."Litigation Evaluation");  // …Ø€Ã

                //Lawsuit,Deposit,Insurance,Corporeal,Obligation
                case ParamType of
                    ParamType::Lawsuit:
                        begin     // Š‹Ž˜Œ­ŒÁ / ‘÷€¦ ˆ×‡™
                            Rec.DATE3 := _LitigationLawProgress."Lawsuit Reception Date";       // Š‹Ž˜Œ­ŒÁ / ‘÷€Ãˆ×‡™ ‘óŒ÷Ÿ
                            Rec.TEXT6 := _LitigationLawProgress."Lawsuit Party";                // Š‹Ž˜Œ­ŒÁ / ‘÷€Ãˆ×‡™ „Ï‹ÏÀ
                            Rec.TEXT7 := _LitigationLawProgress."Lawsuit Case No.";             // Š‹Ž˜Œ­ŒÁ / ‘÷€Ãˆ×‡™ ‹Ï—‰°˜ú
                            Rec.TEXT8 := Format(_LitigationLawProgress."Winning Type");         // ’Œ­ Šž
                            Rec.TEXT9 := Format(_LitigationLawProgress."Loss Reasons");         // –¨Œ­ Šž
                            Rec.TEXT10 := _LitigationLawProgress."Lawsuit Future Dir. Name";    // —Ë˜” ‘°—Ê ‰µ—Ë
                            Rec.TEXT11 := Format(_LitigationLawProgress."Completion Status");   // Ÿ‡ß ‹Ý•’
                            Rec.TEXT12 := Format(_LitigationLawProgress.Remark);                // Š±×
                            Rec.DECIMAL1 := _LitigationLawProgress."Lawsuit Value";             // Œ­íŽ¸
                            Rec.DECIMAL2 := _LitigationLawProgress."General Lawsuit Value";     // Ÿ‰¦ ýˆ« Œ­íŽ¸
                            Rec.DECIMAL3 := _LitigationLawProgress."Land. Arc. Lawsuit Value";  // ‘†µ ýˆ« Œ­íŽ¸
                            Rec.DATE4 := _LitigationLawProgress."Fixed Date Time";              // €ËŸ “ú
                            Rec.TEXT13 := Format(_LitigationLawProgress."Fixed Date Type");     // €ËŸ ‘Ž‡õ
                        end;
                    ParamType::Deposit:
                        begin
                            Rec.DATE3 := _LitigationLawProgress."Deposit Reception Date";       // ‰€¦Ž¨‡õ ‘óŒ÷Ÿ
                            Rec.TEXT6 := _LitigationLawProgress."Deposit Party";                // ‰€¦Ž¨‡õ „Ï‹ÏÀ
                            Rec.TEXT7 := _LitigationLawProgress."Deposit Case No.";             // ‰€¦Ž¨‡õ ‹Ï—‰°˜ú
                            Rec.TEXT8 := _LitigationLawProgress."Deposit Quotation Name";       // ‰€¦Ž¨‡õ žÔŠž
                            Rec.TEXT9 := _LitigationLawProgress."Deposit Future Dir. Name";     // ‰€¦Ž¨‡õ —Ë˜” ‘°—Ê ‰µ—Ë
                        end;
                    ParamType::Insurance:
                        begin
                            Rec.DATE3 := _LitigationLawProgress."Insurance Reception Date";     // Šˆ—ÐŽ¨‡õ ‘óŒ÷Ÿ
                            Rec.TEXT6 := _LitigationLawProgress."Insurance Party";              // Šˆ—ÐŽ¨‡õ „Ï‹ÏÀ
                            Rec.TEXT7 := _LitigationLawProgress."Insurance Case No.";           // Šˆ—ÐŽ¨‡õ ‹Ï—‰°˜ú
                            Rec.TEXT8 := _LitigationLawProgress."Insurance Quotation Name";     // Šˆ—ÐŽ¨‡õ žÔŠž
                            Rec.TEXT9 := _LitigationLawProgress."Insurance Future Dir. Name";   // Šˆ—ÐŽ¨‡õ —Ë˜” ‘°—Ê ‰µ—Ë
                        end;
                    ParamType::Corporeal:
                        begin
                            Rec.DATE3 := _LitigationLawProgress."Corporeal Reception Date";     // »“Œ…‹ÓŽ¨‡õ ‘óŒ÷Ÿ
                            Rec.TEXT6 := _LitigationLawProgress."Corporeal Party";              // »“Œ…‹ÓŽ¨‡õ „Ï‹ÏÀ
                            Rec.TEXT7 := _LitigationLawProgress."Corporeal Case No.";           // »“Œ…‹ÓŽ¨‡õ ‹Ï—‰°˜ú
                            Rec.TEXT8 := _LitigationLawProgress."Corporeal Quotation Name";     // »“Œ…‹ÓŽ¨‡õ žÔŠž
                            Rec.TEXT9 := _LitigationLawProgress."Corporeal Future Dir. Name";   // »“Œ…‹ÓŽ¨‡õ —Ë˜” ‘°—Ê ‰µ—Ë
                        end;
                    ParamType::Obligation:
                        begin
                            Rec.DATE3 := _LitigationLawProgress."Obligation Reception Date";    // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ ‘óŒ÷Ÿ
                            Rec.TEXT6 := _LitigationLawProgress."Obligation Party";             // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ „Ï‹ÏÀ
                            Rec.TEXT7 := _LitigationLawProgress."Obligation Case No.";          // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ ‹Ï—‰°˜ú
                            Rec.TEXT8 := _LitigationLawProgress."Obligation Quotation Name";    // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ žÔŠž
                            Rec.TEXT9 := _LitigationLawProgress."Obligation Future Dir. Name";  // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ —Ë˜” ‘°—Ê‰µ—Ë
                        end;
                end;

                if ParamType <> ParamType::Lawsuit then begin
                    Rec.TEXT10 := Format(_LitigationLawProgress."Completion Status");   // Ÿ‡ß ‹Ý•’
                    Rec.TEXT11 := Format(_LitigationLawProgress.Remark);                // Š±×
                end;

                Rec.Insert;
                ;
            until _LitigationLawProgress.Next = 0;
        end;
    end;

    local procedure SetMatrixCaption()
    var
        _LitigationLawProgress: Record "DK_Litigation Law Progress";
    begin

        //Lawsuit,Deposit,Insurance,Corporeal,Obligation
        case ParamType of
            ParamType::Lawsuit:
                begin     // Š‹Ž˜Œ­ŒÁ / ‘÷€Ã ˆ×‡™
                    MatrixColumnCaptions[1] := _LitigationLawProgress.FieldCaption("Lawsuit Reception Date");      // Š‹Ž˜Œ­ŒÁ / ‘÷€Ãˆ×‡™ ‘óŒ÷Ÿ
                    MatrixColumnCaptions[2] := _LitigationLawProgress.FieldCaption("Lawsuit Party");               // Š‹Ž˜Œ­ŒÁ / ‘÷€Ãˆ×‡™ „Ï‹ÏÀ
                    MatrixColumnCaptions[3] := _LitigationLawProgress.FieldCaption("Lawsuit Case No.");            // Š‹Ž˜Œ­ŒÁ / ‘÷€Ãˆ×‡™ ‹Ï—‰°˜ú
                    MatrixColumnCaptions[4] := _LitigationLawProgress.FieldCaption("Winning Type");                // ’Œ­ Šž
                    MatrixColumnCaptions[5] := _LitigationLawProgress.FieldCaption("Loss Reasons");                // –¨Œ­ Šž
                    MatrixColumnCaptions[6] := _LitigationLawProgress.FieldCaption("Lawsuit Future Dir. Name");    // —Ë˜” ‘°—Ê ‰µ—Ë
                    MatrixColumnCaptions[7] := _LitigationLawProgress.FieldCaption("Completion Status");           // Ÿ‡ß ‹Ý•’
                    MatrixColumnCaptions[8] := _LitigationLawProgress.FieldCaption(Remark);                        // Š±×
                    MatrixColumnCaptions[9] := _LitigationLawProgress.FieldCaption("Lawsuit Value");               // Œ­íŽ¸
                    MatrixColumnCaptions[10] := _LitigationLawProgress.FieldCaption("Fixed Date Time");            // €ËŸ “ú
                    MatrixColumnCaptions[11] := _LitigationLawProgress.FieldCaption("Fixed Date Type");            // €ËŸ ‘Ž‡õ
                    MatrixColumnCaptions[12] := _LitigationLawProgress.FieldCaption("General Lawsuit Value");      // Ÿ‰¦ ýˆ« Œ­íŽ¸
                    MatrixColumnCaptions[13] := _LitigationLawProgress.FieldCaption("Land. Arc. Lawsuit Value");   // ‘†µ ýˆ« Œ­íŽ¸
                end;
            ParamType::Deposit:
                begin
                    MatrixColumnCaptions[1] := _LitigationLawProgress.FieldCaption("Deposit Reception Date");       // ‰€¦Ž¨‡õ ‘óŒ÷Ÿ
                    MatrixColumnCaptions[2] := _LitigationLawProgress.FieldCaption("Deposit Party");                // ‰€¦Ž¨‡õ „Ï‹ÏÀ
                    MatrixColumnCaptions[3] := _LitigationLawProgress.FieldCaption("Deposit Case No.");             // ‰€¦Ž¨‡õ ‹Ï—‰°˜ú
                    MatrixColumnCaptions[4] := _LitigationLawProgress.FieldCaption("Deposit Quotation Name");       // ‰€¦Ž¨‡õ žÔŠž
                    MatrixColumnCaptions[5] := _LitigationLawProgress.FieldCaption("Deposit Future Dir. Name");     // ‰€¦Ž¨‡õ —Ë˜” ‘°—Ê ‰µ—Ë
                end;
            ParamType::Insurance:
                begin
                    MatrixColumnCaptions[1] := _LitigationLawProgress.FieldCaption("Insurance Reception Date");     // Šˆ—ÐŽ¨‡õ ‘óŒ÷Ÿ
                    MatrixColumnCaptions[2] := _LitigationLawProgress.FieldCaption("Insurance Party");              // Šˆ—ÐŽ¨‡õ „Ï‹ÏÀ
                    MatrixColumnCaptions[3] := _LitigationLawProgress.FieldCaption("Insurance Case No.");           // Šˆ—ÐŽ¨‡õ ‹Ï—‰°˜ú
                    MatrixColumnCaptions[4] := _LitigationLawProgress.FieldCaption("Insurance Quotation Name");     // Šˆ—ÐŽ¨‡õ žÔŠž
                    MatrixColumnCaptions[5] := _LitigationLawProgress.FieldCaption("Insurance Future Dir. Name");   // Šˆ—ÐŽ¨‡õ —Ë˜” ‘°—Ê ‰µ—Ë
                end;
            ParamType::Corporeal:
                begin
                    MatrixColumnCaptions[1] := _LitigationLawProgress.FieldCaption("Corporeal Reception Date");     // »“Œ…‹ÓŽ¨‡õ ‘óŒ÷Ÿ
                    MatrixColumnCaptions[2] := _LitigationLawProgress.FieldCaption("Corporeal Party");              // »“Œ…‹ÓŽ¨‡õ „Ï‹ÏÀ
                    MatrixColumnCaptions[3] := _LitigationLawProgress.FieldCaption("Corporeal Case No.");           // »“Œ…‹ÓŽ¨‡õ ‹Ï—‰°˜ú
                    MatrixColumnCaptions[4] := _LitigationLawProgress.FieldCaption("Corporeal Quotation Name");     // »“Œ…‹ÓŽ¨‡õ žÔŠž
                    MatrixColumnCaptions[5] := _LitigationLawProgress.FieldCaption("Corporeal Future Dir. Name");   // »“Œ…‹ÓŽ¨‡õ —Ë˜” ‘°—Ê ‰µ—Ë
                end;
            ParamType::Obligation:
                begin
                    MatrixColumnCaptions[1] := _LitigationLawProgress.FieldCaption("Obligation Reception Date");    // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ ‘óŒ÷Ÿ
                    MatrixColumnCaptions[2] := _LitigationLawProgress.FieldCaption("Obligation Party");             // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ „Ï‹ÏÀ
                    MatrixColumnCaptions[3] := _LitigationLawProgress.FieldCaption("Obligation Case No.");          // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ ‹Ï—‰°˜ú
                    MatrixColumnCaptions[4] := _LitigationLawProgress.FieldCaption("Obligation Quotation Name");    // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ žÔŠž
                    MatrixColumnCaptions[5] := _LitigationLawProgress.FieldCaption("Obligation Future Dir. Name");  // “ñ‰½Š­œ—ÊÀˆ×Šž…ØÏ —Ë˜” ‘°—Ê‰µ—Ë
                end;
        end;

        if ParamType <> ParamType::Lawsuit then begin
            MatrixColumnCaptions[6] := _LitigationLawProgress.FieldCaption("Completion Status");            // Ÿ‡ß ‹Ý•’
            MatrixColumnCaptions[7] := _LitigationLawProgress.FieldCaption(Remark);                         // Š±×
            MatrixColumnCaptions[8] := '';
            MatrixColumnCaptions[9] := '';
            MatrixColumnCaptions[10] := '';
            MatrixColumnCaptions[11] := '';
            MatrixColumnCaptions[12] := '';
            MatrixColumnCaptions[13] := '';
        end;
    end;

    local procedure SetMatrixDelete()
    begin

        Rec.DeleteAll;

        CurrPage.Update(false);
    end;

    local procedure PreviousRecord()
    begin
        //Lawsuit,Deposit,Insurance,Corporeal,Obligation

        if ParamType <> ParamType::Lawsuit then
            ParamType -= 1;

        SetMatrixCaption;

        if Rec.FindSet then begin
            SetMatrixInit;
            Rec.FindSet;
            CurrPage.Update(false);
        end;
    end;

    local procedure NextRecord()
    begin
        //Lawsuit,Deposit,Insurance,Corporeal,Obligation

        if ParamType <> ParamType::Obligation then
            ParamType += 1;

        SetMatrixCaption;

        if Rec.FindSet then begin
            SetMatrixInit;
            Rec.FindSet;
            CurrPage.Update(false);
        end;
    end;

    local procedure TypeFilter_Onvalidate()
    begin
        SetMatrixDelete;
    end;

    local procedure ContractNo_Onvalidate()
    begin
        SetMatrixDelete;
    end;

    local procedure Cemetery_Onvalidate()
    begin
        SetMatrixDelete;
    end;

    local procedure LawRecStartDateFilter_Onvalidate()
    begin
        if (LawRecStartDateFilter <> 0D) and (LawRecEndDateFilter <> 0D) and
          (LawRecStartDateFilter > LawRecEndDateFilter) then
            Error(MSG001);

        SetMatrixDelete;
    end;

    local procedure LawRecEndDateFilter_Onvalidate()
    begin
        if (LawRecStartDateFilter <> 0D) and (LawRecEndDateFilter <> 0D) and
          (LawRecStartDateFilter > LawRecEndDateFilter) then
            Error(MSG001);

        SetMatrixDelete;
    end;
}

