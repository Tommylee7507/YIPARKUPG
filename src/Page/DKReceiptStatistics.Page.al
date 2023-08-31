page 50205 "DK_Receipt Statistics"
{
    Caption = 'Receipt Statistics';
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
                field(cBaseYear; BaseYear)
                {
                    Caption = 'Base Year';
                    MaxValue = 3000;
                    MinValue = 1900;

                    trigger OnValidate()
                    begin
                        BaseYear_OnValidate;
                    end;
                }
                field(cBaseMonth; BaseMonth)
                {
                    Caption = 'Base Month';

                    trigger OnValidate()
                    begin
                        BaseMonth_OnValidate;
                    end;
                }
                field(cPaymentType; PaymentType)
                {
                    Caption = 'Payment Type';
                    OptionCaption = 'All,Bank Transfer,Credit Card,Cash,Giro,Onlie Credit Card,Virtual Account"';

                    trigger OnValidate()
                    begin
                        PaymentType_OnValidate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(cDate; Rec.DATE0)
                {
                    Caption = 'Date';
                }
                field(cFieldTot; Rec.DECIMAL0)
                {
                    Caption = 'Total Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(cFieldAmt1; Rec.DECIMAL1)
                {
                    Caption = 'Deposit Amount';
                }
                field(cFieldAmt6; Rec.DECIMAL26)
                {
                    Caption = 'Contract Amount';
                }
                field(cFieldAmt7; Rec.DECIMAL27)
                {
                    Caption = 'Remaining Amount';
                }
                field(cFieldAmt8; Rec.DECIMAL28)
                {
                    Caption = 'Refund Amount';
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(cFieldAmt2; Rec.DECIMAL2)
                {
                    Caption = 'Gen. Amount - 5 Year';
                }
                field(cFieldAmt3; Rec.DECIMAL3)
                {
                    Caption = 'Lan. Amount - 5 Year';
                }
                field(cFieldAmt4; Rec.DECIMAL4)
                {
                    Caption = 'Gen. Amount - 2nd';
                }
                field(cFieldAmt5; Rec.DECIMAL5)
                {
                    Caption = 'Lan. Amount - 2nd';
                }
                field(cField1; Rec.DECIMAL6)
                {
                    CaptionClass = '3,' + ColumnCaptions[1];
                    Visible = FieldVisible01;
                }
                field(cField2; Rec.DECIMAL7)
                {
                    CaptionClass = '3,' + ColumnCaptions[2];
                    Visible = FieldVisible02;
                }
                field(cField3; Rec.DECIMAL8)
                {
                    CaptionClass = '3,' + ColumnCaptions[3];
                    Visible = FieldVisible03;
                }
                field(cField4; Rec.DECIMAL9)
                {
                    CaptionClass = '3,' + ColumnCaptions[4];
                    Visible = FieldVisible04;
                }
                field(cField5; Rec.DECIMAL10)
                {
                    CaptionClass = '3,' + ColumnCaptions[5];
                    Visible = FieldVisible05;
                }
                field(cField6; Rec.DECIMAL11)
                {
                    CaptionClass = '3,' + ColumnCaptions[6];
                    Visible = FieldVisible06;
                }
                field(cField7; Rec.DECIMAL12)
                {
                    CaptionClass = '3,' + ColumnCaptions[7];
                    Visible = FieldVisible07;
                }
                field(cField8; Rec.DECIMAL13)
                {
                    CaptionClass = '3,' + ColumnCaptions[8];
                    Visible = FieldVisible08;
                }
                field(cField9; Rec.DECIMAL14)
                {
                    CaptionClass = '3,' + ColumnCaptions[9];
                    Visible = FieldVisible09;
                }
                field(cField10; Rec.DECIMAL15)
                {
                    CaptionClass = '3,' + ColumnCaptions[10];
                    Visible = FieldVisible10;
                }
                field(cField11; Rec.DECIMAL16)
                {
                    CaptionClass = '3,' + ColumnCaptions[11];
                    Visible = FieldVisible11;
                }
                field(cField12; Rec.DECIMAL17)
                {
                    CaptionClass = '3,' + ColumnCaptions[12];
                    Visible = FieldVisible12;
                }
                field(cField13; Rec.DECIMAL18)
                {
                    CaptionClass = '3,' + ColumnCaptions[13];
                    Visible = FieldVisible13;
                }
                field(cField14; Rec.DECIMAL19)
                {
                    CaptionClass = '3,' + ColumnCaptions[14];
                    Visible = FieldVisible14;
                }
                field(cField15; Rec.DECIMAL20)
                {
                    CaptionClass = '3,' + ColumnCaptions[15];
                    Visible = FieldVisible15;
                }
                field(cField16; Rec.DECIMAL21)
                {
                    CaptionClass = '3,' + ColumnCaptions[16];
                    Visible = FieldVisible16;
                }
                field(cField17; Rec.DECIMAL22)
                {
                    CaptionClass = '3,' + ColumnCaptions[17];
                    Visible = FieldVisible17;
                }
                field(cField18; Rec.DECIMAL23)
                {
                    CaptionClass = '3,' + ColumnCaptions[18];
                    Visible = FieldVisible18;
                }
                field(cField19; Rec.DECIMAL24)
                {
                    CaptionClass = '3,' + ColumnCaptions[19];
                    Visible = FieldVisible19;
                }
                field(cField20; Rec.DECIMAL25)
                {
                    CaptionClass = '3,' + ColumnCaptions[20];
                    Visible = FieldVisible20;
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

    trigger OnInit()
    begin
        FieldVisible20 := false;
        FieldVisible19 := false;
        FieldVisible18 := false;
        FieldVisible17 := false;
        FieldVisible16 := false;
        FieldVisible15 := false;
        FieldVisible14 := false;
        FieldVisible13 := false;
        FieldVisible12 := false;
        FieldVisible11 := false;
        FieldVisible10 := false;
        FieldVisible09 := false;
        FieldVisible08 := false;
        FieldVisible07 := false;
        FieldVisible06 := false;
        FieldVisible05 := false;
        FieldVisible04 := false;
        FieldVisible03 := false;
        FieldVisible02 := false;
        FieldVisible01 := false;
    end;

    trigger OnOpenPage()
    begin
        PageInit;
    end;

    var
        BaseYear: Integer;
        BaseMonth: Option "1","2","3","4","5","6","7","8","9","10","11","12";
        PaymentType: Option "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount;
        StartDate: Date;
        EndDate: Date;
        ColumnRecord: array[20] of Record "DK_Field Work Main Category";
        ColumnCaptions: array[20] of Text[100];
        MaxColumns: Integer;
        FieldVisible01: Boolean;
        FieldVisible02: Boolean;
        FieldVisible03: Boolean;
        FieldVisible04: Boolean;
        FieldVisible05: Boolean;
        FieldVisible06: Boolean;
        FieldVisible07: Boolean;
        FieldVisible08: Boolean;
        FieldVisible09: Boolean;
        FieldVisible10: Boolean;
        FieldVisible11: Boolean;
        FieldVisible12: Boolean;
        FieldVisible13: Boolean;
        FieldVisible14: Boolean;
        FieldVisible15: Boolean;
        FieldVisible16: Boolean;
        FieldVisible17: Boolean;
        FieldVisible18: Boolean;
        FieldVisible19: Boolean;
        FieldVisible20: Boolean;

    local procedure PageInit()
    begin
        BaseYear := Date2DMY(WorkDate, 3);
        BaseMonth := Date2DMY(WorkDate, 2) - 1;
        //PaymentType := PaymentType::Bank;
        UpdateColumnCaptions;
        RefreshDate;
    end;

    local procedure BaseYear_OnValidate()
    begin
        if (BaseYear < 1900) or (BaseYear > 2999) then
            Error('');

        RefreshDate;
    end;

    local procedure BaseMonth_OnValidate()
    begin
        RefreshDate;
    end;

    local procedure PaymentType_OnValidate()
    begin
        DelRecord;
    end;

    local procedure RefreshDate()
    begin
        StartDate := DMY2Date(1, BaseMonth + 1, BaseYear);
        EndDate := CalcDate('CM', StartDate);
        DelRecord;
    end;

    local procedure SetRecord()
    var
        _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    begin
        _DK_ReportMgt.Page50205_SetRecord(StartDate, EndDate, PaymentType, ColumnRecord, Rec);
    end;

    local procedure DelRecord()
    begin
        Rec.Reset;
        Rec.DeleteAll;
        CurrPage.Update(false);
    end;

    local procedure UpdateColumnCaptions()
    var
        _DK_FieldWorkMainCategory: Record "DK_Field Work Main Category";
    begin
        Clear(MaxColumns);
        Clear(ColumnRecord);
        Clear(ColumnCaptions);

        _DK_FieldWorkMainCategory.SetRange("Cemetery Services", true);
        if _DK_FieldWorkMainCategory.FindSet then
            repeat
                MaxColumns += 1;
                ColumnRecord[MaxColumns].Code := _DK_FieldWorkMainCategory.Code;
                ColumnCaptions[MaxColumns] := _DK_FieldWorkMainCategory.Name;
            until _DK_FieldWorkMainCategory.Next = 0;
        UpdateColumnVisible;
    end;

    local procedure UpdateColumnVisible()
    begin
        FieldVisible01 := ColumnCaptions[1] <> '';
        FieldVisible02 := ColumnCaptions[2] <> '';
        FieldVisible03 := ColumnCaptions[3] <> '';
        FieldVisible04 := ColumnCaptions[4] <> '';
        FieldVisible05 := ColumnCaptions[5] <> '';
        FieldVisible06 := ColumnCaptions[6] <> '';
        FieldVisible07 := ColumnCaptions[7] <> '';
        FieldVisible08 := ColumnCaptions[8] <> '';
        FieldVisible09 := ColumnCaptions[9] <> '';
        FieldVisible10 := ColumnCaptions[10] <> '';
        FieldVisible11 := ColumnCaptions[11] <> '';
        FieldVisible12 := ColumnCaptions[12] <> '';
        FieldVisible13 := ColumnCaptions[13] <> '';
        FieldVisible14 := ColumnCaptions[14] <> '';
        FieldVisible15 := ColumnCaptions[15] <> '';
        FieldVisible16 := ColumnCaptions[16] <> '';
        FieldVisible17 := ColumnCaptions[17] <> '';
        FieldVisible18 := ColumnCaptions[18] <> '';
        FieldVisible19 := ColumnCaptions[19] <> '';
        FieldVisible20 := ColumnCaptions[20] <> '';
    end;
}

