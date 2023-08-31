page 50219 "DK_Cemetery Sales By Product"
{
    Caption = 'Cemetery Sales By Product';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(ReferenceDate; ReferenceDate)
                {
                    Caption = 'Reference Date';

                    trigger OnValidate()
                    begin
                        RefDate_Onvalidate;
                    end;
                }
                field(DateType; DateType)
                {
                    Caption = 'Date Type';
                    OptionCaption = 'Week,Month,Current Date,Previous Date';

                    trigger OnValidate()
                    begin
                        DateType_Onvalidate;
                    end;
                }
                field(ConformationType; ConformationType)
                {
                    Caption = 'Conformation Type';
                    OptionCaption = 'Conformation,Digit';

                    trigger OnValidate()
                    begin
                        ConformationType_Onvalidate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Method';
                }
                field("MatrixData[1]"; MatrixData[1])
                {
                    CaptionClass = '3,' + MatrixCaptions[1];
                    Visible = Visible1;
                }
                field("MatrixData[2]"; MatrixData[2])
                {
                    CaptionClass = '3,' + MatrixCaptions[2];
                    Visible = Visible2;
                }
                field("MatrixData[3]"; MatrixData[3])
                {
                    CaptionClass = '3,' + MatrixCaptions[3];
                    Visible = Visible3;
                }
                field("MatrixData[4]"; MatrixData[4])
                {
                    CaptionClass = '3,' + MatrixCaptions[4];
                    Visible = Visible4;
                }
                field("MatrixData[5]"; MatrixData[5])
                {
                    CaptionClass = '3,' + MatrixCaptions[5];
                    Visible = Visible5;
                }
                field("MatrixData[6]"; MatrixData[6])
                {
                    CaptionClass = '3,' + MatrixCaptions[6];
                    Visible = Visible6;
                }
                field("MatrixData[7]"; MatrixData[7])
                {
                    CaptionClass = '3,' + MatrixCaptions[7];
                    Visible = Visible7;
                }
                field("MatrixData[8]"; MatrixData[8])
                {
                    CaptionClass = '3,' + MatrixCaptions[8];
                    Visible = Visible8;
                }
                field("MatrixData[9]"; MatrixData[9])
                {
                    CaptionClass = '3,' + MatrixCaptions[9];
                    Visible = Visible9;
                }
                field("MatrixData[10]"; MatrixData[10])
                {
                    CaptionClass = '3,' + MatrixCaptions[10];
                    Visible = Visible10;
                }
                field("MatrixData[11]"; MatrixData[11])
                {
                    CaptionClass = '3,' + MatrixCaptions[11];
                    Visible = Visible11;
                }
                field("MatrixData[12]"; MatrixData[12])
                {
                    CaptionClass = '3,' + MatrixCaptions[12];
                    Visible = Visible12;
                }
                field("MatrixData[13]"; MatrixData[13])
                {
                    CaptionClass = '3,' + MatrixCaptions[13];
                    Visible = Visible13;
                }
                field("MatrixData[14]"; MatrixData[14])
                {
                    CaptionClass = '3,' + MatrixCaptions[14];
                    Visible = Visible14;
                }
                field("MatrixData[15]"; MatrixData[15])
                {
                    CaptionClass = '3,' + MatrixCaptions[15];
                    Visible = Visible15;
                }
                field("MatrixData[16]"; MatrixData[16])
                {
                    CaptionClass = '3,' + MatrixCaptions[16];
                    Visible = Visible16;
                }
                field("MatrixData[17]"; MatrixData[17])
                {
                    CaptionClass = '3,' + MatrixCaptions[17];
                    Visible = Visible17;
                }
                field("MatrixData[18]"; MatrixData[18])
                {
                    CaptionClass = '3,' + MatrixCaptions[18];
                    Visible = Visible18;
                }
                field("MatrixData[19]"; MatrixData[19])
                {
                    CaptionClass = '3,' + MatrixCaptions[19];
                    Visible = Visible19;
                }
                field("MatrixData[20]"; MatrixData[20])
                {
                    CaptionClass = '3,' + MatrixCaptions[20];
                    Visible = Visible20;
                }
                field("MatrixData[21]"; MatrixData[21])
                {
                    CaptionClass = '3,' + MatrixCaptions[21];
                    Visible = Visible21;
                }
                field("MatrixData[22]"; MatrixData[22])
                {
                    CaptionClass = '3,' + MatrixCaptions[22];
                    Visible = Visible22;
                }
                field("MatrixData[23]"; MatrixData[23])
                {
                    CaptionClass = '3,' + MatrixCaptions[23];
                    Visible = Visible23;
                }
                field("MatrixData[24]"; MatrixData[24])
                {
                    CaptionClass = '3,' + MatrixCaptions[24];
                    Visible = Visible24;
                }
                field("MatrixData[25]"; MatrixData[25])
                {
                    CaptionClass = '3,' + MatrixCaptions[25];
                    Visible = Visible25;
                }
                field("MatrixData[26]"; MatrixData[26])
                {
                    CaptionClass = '3,' + MatrixCaptions[26];
                    Visible = Visible26;
                }
                field("MatrixData[27]"; MatrixData[27])
                {
                    CaptionClass = '3,' + MatrixCaptions[27];
                    Visible = Visible27;
                }
                field("MatrixData[28]"; MatrixData[28])
                {
                    CaptionClass = '3,' + MatrixCaptions[28];
                    Visible = Visible28;
                }
                field("MatrixData[29]"; MatrixData[29])
                {
                    CaptionClass = '3,' + MatrixCaptions[29];
                    Visible = Visible29;
                }
                field("MatrixData[30]"; MatrixData[30])
                {
                    CaptionClass = '3,' + MatrixCaptions[30];
                    Visible = Visible30;
                }
                field("MatrixData[31]"; MatrixData[31])
                {
                    CaptionClass = '3,' + MatrixCaptions[31];
                    Visible = Visible31;
                }
                field("MatrixData[32]"; MatrixData[32])
                {
                    CaptionClass = '3,' + MatrixCaptions[32];
                    Visible = Visible32;
                }
                field("MatrixData[33]"; MatrixData[33])
                {
                    CaptionClass = '3,' + MatrixCaptions[33];
                    Visible = Visible33;
                }
                field("MatrixData[34]"; MatrixData[34])
                {
                    CaptionClass = '3,' + MatrixCaptions[34];
                    Visible = Visible34;
                }
                field("MatrixData[35]"; MatrixData[35])
                {
                    CaptionClass = '3,' + MatrixCaptions[35];
                    Visible = Visible35;
                }
                field("MatrixData[36]"; MatrixData[36])
                {
                    CaptionClass = '3,' + MatrixCaptions[36];
                    Visible = Visible36;
                }
                field("MatrixData[37]"; MatrixData[37])
                {
                    CaptionClass = '3,' + MatrixCaptions[37];
                    Visible = Visible37;
                }
                field("MatrixData[38]"; MatrixData[38])
                {
                    CaptionClass = '3,' + MatrixCaptions[38];
                    Visible = Visible38;
                }
                field("MatrixData[39]"; MatrixData[39])
                {
                    CaptionClass = '3,' + MatrixCaptions[39];
                    Visible = Visible39;
                }
                field("MatrixData[40]"; MatrixData[40])
                {
                    CaptionClass = '3,' + MatrixCaptions[40];
                    Visible = Visible40;
                }
                field("MatrixData[41]"; MatrixData[41])
                {
                    CaptionClass = '3,' + MatrixCaptions[41];
                    Visible = Visible41;
                }
                field("MatrixData[42]"; MatrixData[42])
                {
                    CaptionClass = '3,' + MatrixCaptions[42];
                    Visible = Visible42;
                }
                field("MatrixData[43]"; MatrixData[43])
                {
                    CaptionClass = '3,' + MatrixCaptions[43];
                    Visible = Visible43;
                }
                field("MatrixData[44]"; MatrixData[44])
                {
                    CaptionClass = '3,' + MatrixCaptions[44];
                    Visible = Visible44;
                }
                field("MatrixData[45]"; MatrixData[45])
                {
                    CaptionClass = '3,' + MatrixCaptions[45];
                    Visible = Visible45;
                }
                field("MatrixData[46]"; MatrixData[46])
                {
                    CaptionClass = '3,' + MatrixCaptions[46];
                    Visible = Visible46;
                }
                field("MatrixData[47]"; MatrixData[47])
                {
                    CaptionClass = '3,' + MatrixCaptions[47];
                    Visible = Visible47;
                }
                field("MatrixData[48]"; MatrixData[48])
                {
                    CaptionClass = '3,' + MatrixCaptions[48];
                    Visible = Visible48;
                }
                field("MatrixData[49]"; MatrixData[49])
                {
                    CaptionClass = '3,' + MatrixCaptions[49];
                    Visible = Visible49;
                }
                field("MatrixData[50]"; MatrixData[50])
                {
                    CaptionClass = '3,' + MatrixCaptions[50];
                    Visible = Visible50;
                }
                field(INTEGER0; Rec.INTEGER0)
                {
                    Caption = 'Total';
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
                    SetMatrixRecord;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        _i: Integer;
    begin
        Clear(MatrixData);
        for _i := 1 to LastCol do
            MatrixData[_i] := SetOnAfterGetRecord(MatrixCondition[_i].Code);
    end;

    trigger OnOpenPage()
    begin
        SetMatrix;
    end;

    var
        DateType: Option Week,Month,Current,Previous;
        ConformationType: Option Conformation,Digits;
        ReferenceDate: Date;
        MatrixCaptions: array[100] of Text[1024];
        MatrixData: array[100] of Integer;
        LineText: Text[50];
        MatrixCondition: array[100] of Record "DK_Cemetery Digits";
        TmpContract: Record DK_Contract temporary;
        StartDate: Date;
        EndDate: Date;
        LastCol: Integer;
        Visible1: Boolean;
        Visible2: Boolean;
        Visible3: Boolean;
        Visible4: Boolean;
        Visible5: Boolean;
        Visible6: Boolean;
        Visible7: Boolean;
        Visible8: Boolean;
        Visible9: Boolean;
        Visible10: Boolean;
        Visible11: Boolean;
        Visible12: Boolean;
        Visible13: Boolean;
        Visible14: Boolean;
        Visible15: Boolean;
        Visible16: Boolean;
        Visible17: Boolean;
        Visible18: Boolean;
        Visible19: Boolean;
        Visible20: Boolean;
        Visible21: Boolean;
        Visible22: Boolean;
        Visible23: Boolean;
        Visible24: Boolean;
        Visible25: Boolean;
        Visible26: Boolean;
        Visible27: Boolean;
        Visible28: Boolean;
        Visible29: Boolean;
        Visible30: Boolean;
        Visible31: Boolean;
        Visible32: Boolean;
        Visible33: Boolean;
        Visible34: Boolean;
        Visible35: Boolean;
        Visible36: Boolean;
        Visible37: Boolean;
        Visible38: Boolean;
        Visible39: Boolean;
        Visible40: Boolean;
        Visible41: Boolean;
        Visible42: Boolean;
        Visible43: Boolean;
        Visible44: Boolean;
        Visible45: Boolean;
        Visible46: Boolean;
        Visible47: Boolean;
        Visible48: Boolean;
        Visible49: Boolean;
        Visible50: Boolean;
        CountMSG: Label 'Count';
        PercentMSG: Label 'Percent(%)';
        CaptionMSG: Label '%1-%2';

    local procedure SetMatrix()
    var
        _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
    begin
        ReferenceDate := WorkDate;
        ConformationType := ConformationType::Conformation;
        DateType := DateType::Week;
        DateType_Onvalidate;
        SetMatrixCaption;
        SetMatrixRecocdVisible;
    end;

    local procedure SetMatrixCaption()
    var
        _CemeteryConformation: Record "DK_Cemetery Conformation";
        _CemeteryDigits: Record "DK_Cemetery Digits";
    begin
        Clear(LastCol);
        Clear(MatrixCaptions);
        Clear(MatrixCondition);

        case ConformationType of
            ConformationType::Conformation:
                begin
                    if _CemeteryConformation.FindSet then begin
                        repeat
                            LastCol += 1;
                            MatrixCaptions[LastCol] := _CemeteryConformation.Name;
                            MatrixCondition[LastCol].Code := _CemeteryConformation.Code
                        until _CemeteryConformation.Next = 0;
                    end;
                end;
            ConformationType::Digits:
                begin
                    _CemeteryDigits.SetFilter("Cemetery Conf. Code", '<>%1', '');
                    if _CemeteryDigits.FindSet then begin
                        repeat
                            LastCol += 1;
                            _CemeteryDigits.CalcFields("Cemetery Conf. Name");
                            MatrixCaptions[LastCol] := StrSubstNo(CaptionMSG, _CemeteryDigits."Cemetery Conf. Name", _CemeteryDigits.Name);
                            MatrixCondition[LastCol]."Cemetery Conf. Code" := _CemeteryDigits."Cemetery Conf. Code";
                            MatrixCondition[LastCol].Code := _CemeteryDigits.Code
                        until _CemeteryDigits.Next = 0;
                    end;
                end;
        end;
    end;

    local procedure SetMatrixRecord()
    var
        _ReportMgt: Codeunit "DK_Report Mgt.";
        _Contract: Record DK_Contract;
    begin
        SetFilterDelete;
        Rec.Init;
        Rec."USER ID" := UserId;
        Rec."OBJECT ID" := PAGE::"DK_Cemetery Sales By Product";
        Rec."Entry No." := 1;
        Rec."SHORT TEXT0" := CountMSG;
        _Contract.Reset;
        _Contract.CalcFields("Cemetery Conf. Code", "Cemetery Dig. Code");
        _Contract.SetRange("Contract Date", StartDate, EndDate);
        if ConformationType = ConformationType::Conformation then
            _Contract.SetFilter("Cemetery Conf. Code", '<>%1', '')
        else
            _Contract.SetFilter("Cemetery Dig. Code", '<>%1', '');
        if _Contract.FindSet then
            Rec.INTEGER0 := _Contract.Count;
        Rec.Insert;

        Rec.Init;
        Rec."USER ID" := UserId;
        Rec."OBJECT ID" := PAGE::"DK_Cemetery Sales By Product";
        Rec."Entry No." := 2;
        Rec."SHORT TEXT0" := PercentMSG;
        if _Contract.FindSet then
            Rec.INTEGER0 := 100
        else
            Rec.INTEGER0 := 0;
        Rec.Insert;
        ;
    end;

    local procedure SetMatrixRecocdVisible()
    begin
        Visible1 := MatrixCaptions[1] <> '';
        Visible2 := MatrixCaptions[2] <> '';
        Visible3 := MatrixCaptions[3] <> '';
        Visible4 := MatrixCaptions[4] <> '';
        Visible5 := MatrixCaptions[5] <> '';
        Visible6 := MatrixCaptions[6] <> '';
        Visible7 := MatrixCaptions[7] <> '';
        Visible8 := MatrixCaptions[8] <> '';
        Visible9 := MatrixCaptions[9] <> '';
        Visible10 := MatrixCaptions[10] <> '';
        Visible11 := MatrixCaptions[11] <> '';
        Visible12 := MatrixCaptions[12] <> '';
        Visible13 := MatrixCaptions[13] <> '';
        Visible14 := MatrixCaptions[14] <> '';
        Visible15 := MatrixCaptions[15] <> '';
        Visible16 := MatrixCaptions[16] <> '';
        Visible17 := MatrixCaptions[17] <> '';
        Visible18 := MatrixCaptions[18] <> '';
        Visible19 := MatrixCaptions[19] <> '';
        Visible20 := MatrixCaptions[20] <> '';
        Visible21 := MatrixCaptions[21] <> '';
        Visible22 := MatrixCaptions[22] <> '';
        Visible23 := MatrixCaptions[23] <> '';
        Visible24 := MatrixCaptions[24] <> '';
        Visible25 := MatrixCaptions[25] <> '';
        Visible26 := MatrixCaptions[26] <> '';
        Visible27 := MatrixCaptions[27] <> '';
        Visible28 := MatrixCaptions[28] <> '';
        Visible29 := MatrixCaptions[29] <> '';
        Visible30 := MatrixCaptions[30] <> '';
        Visible31 := MatrixCaptions[31] <> '';
        Visible32 := MatrixCaptions[32] <> '';
        Visible33 := MatrixCaptions[33] <> '';
        Visible34 := MatrixCaptions[34] <> '';
        Visible35 := MatrixCaptions[35] <> '';
        Visible36 := MatrixCaptions[36] <> '';
        Visible37 := MatrixCaptions[37] <> '';
        Visible38 := MatrixCaptions[38] <> '';
        Visible39 := MatrixCaptions[39] <> '';
        Visible40 := MatrixCaptions[40] <> '';
        Visible41 := MatrixCaptions[41] <> '';
        Visible42 := MatrixCaptions[42] <> '';
        Visible43 := MatrixCaptions[43] <> '';
        Visible44 := MatrixCaptions[44] <> '';
        Visible45 := MatrixCaptions[45] <> '';
        Visible46 := MatrixCaptions[46] <> '';
        Visible47 := MatrixCaptions[47] <> '';
        Visible48 := MatrixCaptions[48] <> '';
        Visible49 := MatrixCaptions[49] <> '';
        Visible50 := MatrixCaptions[50] <> '';
        CurrPage.Update(false);
    end;

    local procedure SetFilterDelete()
    begin
        Rec.Reset;
        Rec.DeleteAll;
    end;

    local procedure ConformationType_Onvalidate()
    begin
        SetMatrixCaption;
        SetMatrixRecocdVisible;
        SetFilterDelete;
    end;

    local procedure DateType_Onvalidate()
    begin
        case DateType of
            DateType::Week:
                begin
                    StartDate := ReferenceDate;
                    EndDate := CalcDate('<+7D>', StartDate);
                end;
            DateType::Month:
                begin
                    StartDate := CalcDate('<-CM>', ReferenceDate);
                    EndDate := CalcDate('<+CM>', StartDate);
                end;
            DateType::Current:
                begin
                    StartDate := CalcDate('<-CY>', ReferenceDate);
                    EndDate := CalcDate('<+CY>', StartDate);
                end;
            DateType::Previous:
                begin
                    StartDate := CalcDate('<-CY-1Y>', ReferenceDate);
                    EndDate := CalcDate('<+CY>', StartDate);
                end;
        end;
        SetFilterDelete;
    end;

    local procedure RefDate_Onvalidate()
    begin
        if ReferenceDate = 0D then
            Error('');

        SetFilterDelete;
    end;

    local procedure SetOnAfterGetRecord(pCode: Code[20]): Integer
    var
        _Contract: Record DK_Contract;
        _StartDate: Date;
        _EndDate: Date;
        _CemeteryConformation: Record "DK_Cemetery Conformation";
        _TotalValue: Integer;
        _SomeValue: Integer;
    begin
        if Rec."Entry No." = 1 then begin
            _Contract.Reset;
            _Contract.SetRange("Contract Date", StartDate, EndDate);
            if ConformationType = ConformationType::Conformation then
                _Contract.SetRange("Cemetery Conf. Code", pCode)
            else
                _Contract.SetRange("Cemetery Dig. Code", pCode);

            if _Contract.FindSet then
                exit(_Contract.Count);
        end else begin
            //–ÁŒŽ–« = ŸŠž¬ / ý“Œ¬ * 100
            _Contract.Reset;
            _Contract.SetRange("Contract Date", StartDate, EndDate);

            if ConformationType = ConformationType::Conformation then
                _Contract.SetFilter("Cemetery Conf. Code", '<>%1', '')
            else
                _Contract.SetFilter("Cemetery Dig. Code", '<>%1', '');

            if _Contract.FindSet then
                _TotalValue := _Contract.Count;

            if ConformationType = ConformationType::Conformation then
                _Contract.SetRange("Cemetery Conf. Code", pCode)
            else
                _Contract.SetRange("Cemetery Dig. Code", pCode);

            if _Contract.FindSet then
                _SomeValue := _Contract.Count;

            if (_TotalValue = 0) or (_SomeValue = 0) then
                exit(0)
            else
                exit(Round(_SomeValue / _TotalValue * 100));
        end;
    end;
}

