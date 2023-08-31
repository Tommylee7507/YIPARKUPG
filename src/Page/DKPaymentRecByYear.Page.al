page 50236 "DK_Payment Rec. By Year"
{
    Caption = 'Payment Receipt By Imputed Year';
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
            group(Control19)
            {
                ShowCaption = false;
                group(Control56)
                {
                    ShowCaption = false;
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';

                        trigger OnValidate()
                        begin
                            if StartDate = 0D then
                                Error(MSG004);

                            StartDate_Onvaildate;
                        end;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'Expiration Date';

                        trigger OnValidate()
                        begin
                            if EndDate = 0D then
                                Error(MSG005);

                            EndDate_Onvaildate;
                        end;
                    }
                }
                group(Control57)
                {
                    ShowCaption = false;
                    field(StartYear; StartYear)
                    {
                        Caption = 'Reference Year';
                        MaxValue = 3000;
                        MinValue = 1900;

                        trigger OnValidate()
                        begin
                            ReferenceYear_Onvaildate;
                        end;
                    }
                    field(EndYear; EndYear)
                    {
                        Caption = 'Reference Year';
                        MaxValue = 3000;
                        MinValue = 1900;

                        trigger OnValidate()
                        begin
                            ReferenceYear_Onvaildate;
                        end;
                    }
                }
                field(OptionType; OptionType)
                {
                    Caption = 'Option Type';
                    OptionCaption = 'General,LandScape,All';

                    trigger OnValidate()
                    begin
                        OptionType_Onvaildate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Payment Date';
                    StyleExpr = ColorStyle;
                }
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Contract No.';
                    Editable = false;
                    StyleExpr = ColorStyle;

                    trigger OnDrillDown()
                    begin
                        //¯€¦‰«Œ¡
                        View_ContractDoc;
                    end;
                }
                field(CODE1; Rec.CODE1)
                {
                    Caption = 'Payment Document No.';
                    Editable = false;
                    StyleExpr = ColorStyle;

                    trigger OnDrillDown()
                    begin
                        //ÐŽÊ‰«Œ¡
                        View_PaymentDoc;
                    end;
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Cemetery No.';
                    StyleExpr = ColorStyle;
                }
                field("SHORT TEXT2"; Rec."SHORT TEXT2")
                {
                    Caption = 'Type';
                    StyleExpr = ColorStyle;
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Name';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'Unit Cost';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Cemetery Size';
                    StyleExpr = ColorStyle;
                }
                field(DATE1; Rec.DATE1)
                {
                    Caption = 'Start Date';
                    StyleExpr = ColorStyle;
                }
                field(DATE2; Rec.DATE2)
                {
                    Caption = 'Expiration Date';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    Caption = 'Payment Amount';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL3; Rec.DECIMAL3)
                {
                    Caption = 'Admin. Expense Amount';
                    StyleExpr = ColorStyle;
                }
                field("DECIMAL2-DECIMAL3"; Rec.DECIMAL2 - Rec.DECIMAL3)
                {
                    Caption = '*Diff. Amount';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL11; Rec.DECIMAL11)
                {
                    CaptionClass = '3,' + ArrColumnCaption[1];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 1;
                }
                field(DECIMAL12; Rec.DECIMAL12)
                {
                    CaptionClass = '3,' + ArrColumnCaption[2];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 2;
                }
                field(DECIMAL13; Rec.DECIMAL13)
                {
                    CaptionClass = '3,' + ArrColumnCaption[3];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 3;
                }
                field(DECIMAL14; Rec.DECIMAL14)
                {
                    CaptionClass = '3,' + ArrColumnCaption[4];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 4;
                }
                field(DECIMAL15; Rec.DECIMAL15)
                {
                    CaptionClass = '3,' + ArrColumnCaption[5];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 5;
                }
                field(DECIMAL16; Rec.DECIMAL16)
                {
                    CaptionClass = '3,' + ArrColumnCaption[6];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 6;
                }
                field(DECIMAL17; Rec.DECIMAL17)
                {
                    CaptionClass = '3,' + ArrColumnCaption[7];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 7;
                }
                field(DECIMAL18; Rec.DECIMAL18)
                {
                    CaptionClass = '3,' + ArrColumnCaption[8];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 8;
                }
                field(DECIMAL19; Rec.DECIMAL19)
                {
                    CaptionClass = '3,' + ArrColumnCaption[9];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 9;

                    trigger OnValidate()
                    var
                        ColorStyle: Text[30];
                    begin
                    end;
                }
                field(DECIMAL20; Rec.DECIMAL20)
                {
                    CaptionClass = '3,' + ArrColumnCaption[10];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 10;
                }
                field(DECIMAL21; Rec.DECIMAL21)
                {
                    CaptionClass = '3,' + ArrColumnCaption[11];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 11;
                }
                field(DECIMAL22; Rec.DECIMAL22)
                {
                    CaptionClass = '3,' + ArrColumnCaption[12];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 12;
                }
                field(DECIMAL23; Rec.DECIMAL23)
                {
                    CaptionClass = '3,' + ArrColumnCaption[13];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 13;
                }
                field(DECIMAL24; Rec.DECIMAL24)
                {
                    CaptionClass = '3,' + ArrColumnCaption[14];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 14;
                }
                field(DECIMAL25; Rec.DECIMAL25)
                {
                    CaptionClass = '3,' + ArrColumnCaption[15];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 15;
                }
                field(DECIMAL26; Rec.DECIMAL26)
                {
                    CaptionClass = '3,' + ArrColumnCaption[16];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 16;
                }
                field(DECIMAL27; Rec.DECIMAL27)
                {
                    CaptionClass = '3,' + ArrColumnCaption[17];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 17;
                }
                field(DECIMAL28; Rec.DECIMAL28)
                {
                    CaptionClass = '3,' + ArrColumnCaption[18];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 18;
                }
                field(DECIMAL29; Rec.DECIMAL29)
                {
                    CaptionClass = '3,' + ArrColumnCaption[19];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 19;
                }
                field(DECIMAL30; Rec.DECIMAL30)
                {
                    CaptionClass = '3,' + ArrColumnCaption[20];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 20;
                }
                field(DECIMAL31; Rec.DECIMAL31)
                {
                    CaptionClass = '3,' + ArrColumnCaption[21];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 21;
                }
                field(DECIMAL32; Rec.DECIMAL32)
                {
                    CaptionClass = '3,' + ArrColumnCaption[22];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 22;
                }
                field(DECIMAL33; Rec.DECIMAL33)
                {
                    CaptionClass = '3,' + ArrColumnCaption[23];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 23;
                }
                field(DECIMAL34; Rec.DECIMAL34)
                {
                    CaptionClass = '3,' + ArrColumnCaption[24];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 24;
                }
                field(DECIMAL35; Rec.DECIMAL35)
                {
                    CaptionClass = '3,' + ArrColumnCaption[25];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 25;
                }
                field(DECIMAL36; Rec.DECIMAL36)
                {
                    CaptionClass = '3,' + ArrColumnCaption[26];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 26;
                }
                field(DECIMAL37; Rec.DECIMAL37)
                {
                    CaptionClass = '3,' + ArrColumnCaption[27];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 27;
                }
                field(DECIMAL38; Rec.DECIMAL38)
                {
                    CaptionClass = '3,' + ArrColumnCaption[28];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 28;
                }
                field(DECIMAL39; Rec.DECIMAL39)
                {
                    CaptionClass = '3,' + ArrColumnCaption[29];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 29;
                }
                field(DECIMAL40; Rec.DECIMAL40)
                {
                    CaptionClass = '3,' + ArrColumnCaption[30];
                    StyleExpr = ColorStyle;
                    Visible = CaptionLoop >= 30;
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
                    DataInquiry;


                    Rec.Reset;
                    Rec.SetCurrentKey(DATE0, CODE0, CODE1);
                    if Rec.FindFirst then;

                    CurrPage.Update;
                end;
            }
            separator(Action30)
            {
            }
            action("View Document")
            {
                Caption = 'View Document';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
            action("View Payment Doc")
            {
                Caption = 'View Payment Doc';
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.INTEGER0 = 1 then
            ColorStyle := 'StandardAccent'
        else
            ColorStyle := '';
    end;

    trigger OnOpenPage()
    begin
        SetData;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        StartYear: Integer;
        EndYear: Integer;
        OptionType: Option General,Landscape,All;
        ArrColumnCaption: array[40] of Text[10];
        YearMSG: Label '%1';
        MSG001: Label 'Start Date cannot be greater than End Date.';
        MSG002: Label 'Start Year cannot be greater than End Year.';
        MSG003: Label 'Only available until 2010.';
        ArrYear: array[40] of Integer;
        CaptionLoop: Integer;
        MSG004: Label 'Please specify a start date';
        MSG005: Label 'Please specify a end date';
        MSG100: Label 'Processing ReceiptDocument   #1############\';
        MSG101: Label 'Processing  #2##########\';
        Window: Dialog;
        ColorStyle: Text[20];
        EntryNo: Integer;

    local procedure SetData()
    begin
        EndDate := WorkDate;
        StartDate := CalcDate('<-CM>', WorkDate);

        StartYear := Date2DMY(WorkDate, 3);
        EndYear := Date2DMY(WorkDate, 3) + 5;
        OptionType := OptionType::General;

        SetCaption;
    end;

    local procedure SetFilterDelete()
    begin
        Rec.Reset;
        if Rec.FindSet then begin
            Rec.DeleteAll;
            Commit;
        end;
    end;

    local procedure SetCaption()
    begin
        Clear(ArrColumnCaption);
        Clear(CaptionLoop);
        Clear(ArrYear);

        while CaptionLoop < (EndYear - StartYear) + 1 do begin
            ArrColumnCaption[CaptionLoop + 1] := StrSubstNo(YearMSG, StartYear + CaptionLoop);
            ArrYear[CaptionLoop + 1] := StartYear + CaptionLoop;
            CaptionLoop += 1;
        end;
    end;

    local procedure DataInquiry()
    var
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PayReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PayReceiptDocLine2: Record "DK_Payment Receipt Doc. Line";
        _Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _Loop: Integer;
        _YearFilter: Integer;
        _MaxLoop: Integer;
        _MainLoop: Integer;
        _LoopEndYear: Integer;
        _ArrTotalAmount: array[41] of Decimal;
    begin
        if (StartDate = 0D) or (EndDate = 0D) then exit;

        if GuiAllowed then
            Window.Open(
              MSG100 +
              MSG101);


        Clear(_ArrTotalAmount);

        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetRange(Posted, true);
        _PayReceiptDoc.SetRange("Missing Contract", false);
        _PayReceiptDoc.SetRange("Document Type", _PayReceiptDocLine."Document Type"::Receipt);
        _PayReceiptDoc.SetFilter("Payment Type", '<>%1&<>%2', _PayReceiptDocLine."Payment Type"::DebtRelief, _PayReceiptDocLine."Payment Type"::None);
        _PayReceiptDoc.SetRange("Payment Date", StartDate, EndDate);
        _PayReceiptDoc.SetRange("Refund Document No.", '');
        _PayReceiptDoc.SetRange("New Admin. Expense", false);
        if _PayReceiptDoc.FindSet then begin
            _MaxLoop := _PayReceiptDoc.Count;

            repeat
                _MainLoop += 1;

                if GuiAllowed then begin
                    Window.Update(1, StrSubstNo('%1 / %2', _MainLoop, _MaxLoop));
                    Window.Update(2, _PayReceiptDoc."Document No.");
                end;

                _PayReceiptDocLine.Reset;
                _PayReceiptDocLine.SetRange("Document No.", _PayReceiptDoc."Document No.");
                if OptionType = OptionType::General then
                    _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::General)
                else
                    if OptionType = OptionType::Landscape then
                        _PayReceiptDocLine.SetRange("Payment Target", _PayReceiptDocLine."Payment Target"::Landscape)
                    else
                        _PayReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PayReceiptDocLine."Payment Target"::General,
                                                                               _PayReceiptDocLine."Payment Target"::Landscape);

                if _PayReceiptDocLine.FindSet then begin

                    repeat

                        EntryNo += 1;

                        _PayReceiptDocLine.CalcFields("Led. Gen. Total Amount", "Led. Lan. Total Amount");

                        Rec.Init;
                        Rec."USER ID" := UserId;
                        Rec."OBJECT ID" := PAGE::"DK_Admin. Liti. By Year";
                        Rec."Entry No." := EntryNo;
                        Rec."SHORT TEXT2" := Format(_PayReceiptDocLine."Payment Target");
                        Rec.CODE0 := _PayReceiptDoc."Contract No.";
                        Rec.CODE1 := _PayReceiptDoc."Document No.";

                        Rec.DATE0 := _PayReceiptDoc."Payment Date";

                        if _Contract.Get(_PayReceiptDoc."Contract No.") then begin
                            _Contract.CalcFields("Unit Price Type Code", "Cemetery Size");
                            Rec."SHORT TEXT0" := _Contract."Cemetery No.";
                            Rec."SHORT TEXT1" := _Contract."Main Customer Name";
                            Rec.DECIMAL0 := _Contract."Cemetery Size";

                            if _PayReceiptDocLine."Payment Target" = _PayReceiptDocLine."Payment Target"::General then begin
                                Rec.DECIMAL1 := Calc_UnitPrice(0, _Contract."Unit Price Type Code", _PayReceiptDoc."Payment Date");
                                Rec.INTEGER0 := 0;
                            end else begin
                                Rec.DECIMAL1 := Calc_UnitPrice(1, _Contract."Unit Price Type Code", _PayReceiptDoc."Payment Date");
                                Rec.INTEGER0 := 1;
                            end;
                        end;

                        Rec.DATE1 := _PayReceiptDocLine."Start Date";
                        Rec.DATE2 := _PayReceiptDocLine."Expiration Date";
                        Rec.DECIMAL2 := _PayReceiptDocLine.Amount;

                        if _PayReceiptDocLine."Payment Target" = _PayReceiptDocLine."Payment Target"::General then
                            Rec.DECIMAL3 := _PayReceiptDocLine."Led. Gen. Total Amount"
                        else
                            Rec.DECIMAL3 := _PayReceiptDocLine."Led. Lan. Total Amount";


                        Clear(_YearFilter);
                        _PayReceiptDocLine2.Reset;
                        _PayReceiptDocLine2.SetRange("Document No.", _PayReceiptDocLine."Document No.");
                        _PayReceiptDocLine2.SetRange("Line No.", _PayReceiptDocLine."Line No.");

                        //Loop!!
                        _LoopEndYear := Date2DWY(_PayReceiptDocLine."Expiration Date", 3);
                        Clear(_Loop);
                        while _Loop < (_LoopEndYear - StartYear) + 1 do begin
                            _YearFilter := StartYear + _Loop;

                            _PayReceiptDocLine2.SetRange("Date Filter", DMY2Date(1, 1, _YearFilter), DMY2Date(31, 12, _YearFilter));
                            if _PayReceiptDocLine2.FindSet then begin
                                _PayReceiptDocLine2.CalcFields("Led. Gen. SubTot Amount", "Led. Lan. SubTot Amount");

                                if _PayReceiptDocLine."Payment Target" = _PayReceiptDocLine."Payment Target"::General then begin
                                    case _YearFilter of
                                        ArrYear[1]:
                                            Rec.DECIMAL11 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[2]:
                                            Rec.DECIMAL12 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[3]:
                                            Rec.DECIMAL13 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[4]:
                                            Rec.DECIMAL14 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[5]:
                                            Rec.DECIMAL15 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[6]:
                                            Rec.DECIMAL16 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[7]:
                                            Rec.DECIMAL17 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[8]:
                                            Rec.DECIMAL18 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[9]:
                                            Rec.DECIMAL19 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[10]:
                                            Rec.DECIMAL20 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[11]:
                                            Rec.DECIMAL21 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[12]:
                                            Rec.DECIMAL22 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[13]:
                                            Rec.DECIMAL23 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[14]:
                                            Rec.DECIMAL24 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[15]:
                                            Rec.DECIMAL25 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[16]:
                                            Rec.DECIMAL26 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[17]:
                                            Rec.DECIMAL27 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[18]:
                                            Rec.DECIMAL28 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[19]:
                                            Rec.DECIMAL29 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[20]:
                                            Rec.DECIMAL30 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[21]:
                                            Rec.DECIMAL31 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[22]:
                                            Rec.DECIMAL32 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[23]:
                                            Rec.DECIMAL33 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[24]:
                                            Rec.DECIMAL34 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[25]:
                                            Rec.DECIMAL35 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[26]:
                                            Rec.DECIMAL36 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[27]:
                                            Rec.DECIMAL37 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[28]:
                                            Rec.DECIMAL38 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[29]:
                                            Rec.DECIMAL39 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                        ArrYear[30]:
                                            Rec.DECIMAL40 := _PayReceiptDocLine2."Led. Gen. SubTot Amount";
                                    end;
                                end else begin
                                    case _YearFilter of
                                        ArrYear[1]:
                                            Rec.DECIMAL11 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[2]:
                                            Rec.DECIMAL12 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[3]:
                                            Rec.DECIMAL13 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[4]:
                                            Rec.DECIMAL14 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[5]:
                                            Rec.DECIMAL15 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[6]:
                                            Rec.DECIMAL16 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[7]:
                                            Rec.DECIMAL17 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[8]:
                                            Rec.DECIMAL18 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[9]:
                                            Rec.DECIMAL19 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[10]:
                                            Rec.DECIMAL20 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[11]:
                                            Rec.DECIMAL21 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[12]:
                                            Rec.DECIMAL22 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[13]:
                                            Rec.DECIMAL23 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[14]:
                                            Rec.DECIMAL24 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[15]:
                                            Rec.DECIMAL25 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[16]:
                                            Rec.DECIMAL26 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[17]:
                                            Rec.DECIMAL27 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[18]:
                                            Rec.DECIMAL28 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[19]:
                                            Rec.DECIMAL29 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[20]:
                                            Rec.DECIMAL30 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[21]:
                                            Rec.DECIMAL31 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[22]:
                                            Rec.DECIMAL32 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[23]:
                                            Rec.DECIMAL33 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[24]:
                                            Rec.DECIMAL34 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[25]:
                                            Rec.DECIMAL35 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[26]:
                                            Rec.DECIMAL36 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[27]:
                                            Rec.DECIMAL37 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[28]:
                                            Rec.DECIMAL38 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[29]:
                                            Rec.DECIMAL39 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                        ArrYear[30]:
                                            Rec.DECIMAL40 := _PayReceiptDocLine2."Led. Lan. SubTot Amount";
                                    end;
                                end;


                            end;
                            _Loop += 1;
                        end;

                        Rec.Insert;

                        //>>Total Data
                        _ArrTotalAmount[1] += Rec.DECIMAL11;
                        _ArrTotalAmount[2] += Rec.DECIMAL12;
                        _ArrTotalAmount[3] += Rec.DECIMAL13;
                        _ArrTotalAmount[4] += Rec.DECIMAL14;
                        _ArrTotalAmount[5] += Rec.DECIMAL15;
                        _ArrTotalAmount[6] += Rec.DECIMAL16;
                        _ArrTotalAmount[7] += Rec.DECIMAL17;
                        _ArrTotalAmount[8] += Rec.DECIMAL18;
                        _ArrTotalAmount[9] += Rec.DECIMAL19;
                        _ArrTotalAmount[10] += Rec.DECIMAL20;
                        _ArrTotalAmount[11] += Rec.DECIMAL21;
                        _ArrTotalAmount[12] += Rec.DECIMAL22;
                        _ArrTotalAmount[13] += Rec.DECIMAL23;
                        _ArrTotalAmount[14] += Rec.DECIMAL24;
                        _ArrTotalAmount[15] += Rec.DECIMAL25;
                        _ArrTotalAmount[16] += Rec.DECIMAL26;
                        _ArrTotalAmount[17] += Rec.DECIMAL27;
                        _ArrTotalAmount[18] += Rec.DECIMAL28;
                        _ArrTotalAmount[19] += Rec.DECIMAL29;
                        _ArrTotalAmount[20] += Rec.DECIMAL30;
                        _ArrTotalAmount[21] += Rec.DECIMAL31;
                        _ArrTotalAmount[22] += Rec.DECIMAL32;
                        _ArrTotalAmount[23] += Rec.DECIMAL33;
                        _ArrTotalAmount[24] += Rec.DECIMAL34;
                        _ArrTotalAmount[25] += Rec.DECIMAL35;
                        _ArrTotalAmount[26] += Rec.DECIMAL36;
                        _ArrTotalAmount[27] += Rec.DECIMAL37;
                        _ArrTotalAmount[28] += Rec.DECIMAL38;
                        _ArrTotalAmount[29] += Rec.DECIMAL39;
                        _ArrTotalAmount[30] += Rec.DECIMAL40;
                    until _PayReceiptDocLine.Next = 0;
                end;
            until _PayReceiptDoc.Next = 0;

            EntryNo += 1;
            Rec.Init;
            Rec."USER ID" := UserId;
            Rec."OBJECT ID" := PAGE::"DK_Admin. Liti. By Year";
            Rec."Entry No." := EntryNo;
            Rec."SHORT TEXT0" := '';
            Rec."SHORT TEXT2" := '';
            Rec."SHORT TEXT1" := '';
            Rec.DECIMAL1 := 0;
            Rec.DECIMAL0 := 0;
            Rec.DATE1 := 0D;
            Rec.DATE2 := 0D;
            Rec.DECIMAL2 := 0;
            Rec.DECIMAL3 := 0;
            Rec.DECIMAL11 := _ArrTotalAmount[1];
            Rec.DECIMAL12 := _ArrTotalAmount[2];
            Rec.DECIMAL13 := _ArrTotalAmount[3];
            Rec.DECIMAL14 := _ArrTotalAmount[4];
            Rec.DECIMAL15 := _ArrTotalAmount[5];
            Rec.DECIMAL16 := _ArrTotalAmount[6];
            Rec.DECIMAL17 := _ArrTotalAmount[7];
            Rec.DECIMAL18 := _ArrTotalAmount[8];
            Rec.DECIMAL19 := _ArrTotalAmount[9];
            Rec.DECIMAL20 := _ArrTotalAmount[10];
            Rec.DECIMAL21 := _ArrTotalAmount[11];
            Rec.DECIMAL22 := _ArrTotalAmount[12];
            Rec.DECIMAL23 := _ArrTotalAmount[13];
            Rec.DECIMAL24 := _ArrTotalAmount[14];
            Rec.DECIMAL25 := _ArrTotalAmount[15];
            Rec.DECIMAL26 := _ArrTotalAmount[16];
            Rec.DECIMAL27 := _ArrTotalAmount[17];
            Rec.DECIMAL28 := _ArrTotalAmount[18];
            Rec.DECIMAL29 := _ArrTotalAmount[19];
            Rec.DECIMAL30 := _ArrTotalAmount[20];
            Rec.DECIMAL31 := _ArrTotalAmount[21];
            Rec.DECIMAL32 := _ArrTotalAmount[22];
            Rec.DECIMAL33 := _ArrTotalAmount[23];
            Rec.DECIMAL34 := _ArrTotalAmount[24];
            Rec.DECIMAL35 := _ArrTotalAmount[25];
            Rec.DECIMAL36 := _ArrTotalAmount[26];
            Rec.DECIMAL37 := _ArrTotalAmount[27];
            Rec.DECIMAL38 := _ArrTotalAmount[28];
            Rec.DECIMAL39 := _ArrTotalAmount[29];
            Rec.DECIMAL40 := _ArrTotalAmount[30];
            Rec.Insert;
        end;
        if GuiAllowed then
            Window.Close;
    end;

    local procedure Insert_ReportBuffter(pOption: Option General,Landscape)
    var
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _RefYear: Integer;
    begin
        /*
        IF PaymentReceiptDocument.FINDSET THEN BEGIN
          REPEAT
            PaymentReceiptDocument.CALCFIELDS("Cemetery No.");
            _PaymentReceiptDocLine.RESET;
            _PaymentReceiptDocLine.SETRANGE("Document No.",PaymentReceiptDocument."Document No.");
            CASE pOption OF
              pOption::General:_PaymentReceiptDocLine.SETRANGE("Payment Target",_PaymentReceiptDocLine."Payment Target"::General);
              pOption::Landscape:_PaymentReceiptDocLine.SETRANGE("Payment Target",_PaymentReceiptDocLine."Payment Target"::Landscape);
            END;
            IF _PaymentReceiptDocLine.FINDSET THEN BEGIN
        
              //DECIMAL3 ~ Rec.DECIMAL9 €¦Ž¸ ‘ñŠˆ INSERT
        
              //DECIMAL3 ~ Rec.DECIMAL9 €¦Ž¸ ‘ñŠˆ INSERT
             Rec.Insert;;
            END;
          UNTIL PaymentReceiptDocument.NEXT = 0;
        END;
        */

    end;

    local procedure Calc_UnitPrice(pOption: Option General,Landscape; pUnitPriceTypeCode: Code[20]; pPaymentDate: Date): Decimal
    var
        _AdminExpensePrice: Record "DK_Admin. Expense Price";
    begin

        _AdminExpensePrice.Reset;
        _AdminExpensePrice.SetCurrentKey("Price Type", "Unit Price Type Code", "Starting Date");
        _AdminExpensePrice.SetRange("Price Type", pOption);
        _AdminExpensePrice.SetRange("Unit Price Type Code", pUnitPriceTypeCode);
        _AdminExpensePrice.SetFilter("Starting Date", '<=%1', pPaymentDate);
        if _AdminExpensePrice.FindLast then
            exit(_AdminExpensePrice."Unit Price");

        exit(0);
    end;

    local procedure StartDate_Onvaildate()
    begin
        if EndDate <> 0D then begin
            if StartDate > EndDate then
                Error(MSG001);
        end;

        SetFilterDelete;
        SetCaption;
    end;

    local procedure EndDate_Onvaildate()
    begin
        if StartDate <> 0D then begin
            if StartDate > EndDate then
                Error(MSG001);
        end;

        SetFilterDelete;
        SetCaption;
    end;

    local procedure ReferenceYear_Onvaildate()
    begin
        if StartYear > EndYear then
            Error(MSG002, StartYear);

        if (EndYear - StartYear) > 30 then
            Error(MSG003, StartYear + 30);

        SetFilterDelete;
        SetCaption;
    end;

    local procedure OptionType_Onvaildate()
    begin
        SetFilterDelete;
    end;


    procedure View_ContractDoc()
    var
        _Contract: Record DK_Contract;
        _ContractCard: Page "DK_Contract Card";
    begin

        if Rec.CODE0 = '' then
            exit;

        if _Contract.Get(Rec.CODE0) then begin
            Clear(_ContractCard);
            _ContractCard.LookupMode(true);
            _ContractCard.SetTableView(_Contract);
            _ContractCard.SetRecord(_Contract);
            _ContractCard.RunModal;
        end;
    end;


    procedure View_PaymentDoc()
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _PostedPayReceiptDoc: Page "DK_Posted Pay. Receipt Doc.";
    begin

        if Rec.CODE1 = '' then
            exit;

        _PaymentReceiptDocument.SetRange("Document No.", Rec.CODE1);

        Clear(_PostedPayReceiptDoc);
        _PostedPayReceiptDoc.LookupMode(true);
        _PostedPayReceiptDoc.SetTableView(_PaymentReceiptDocument);
        _PostedPayReceiptDoc.SetRecord(_PaymentReceiptDocument);
        _PostedPayReceiptDoc.RunModal;
    end;
}

