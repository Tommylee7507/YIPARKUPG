page 50301 "DK_KPI Target Subform"
{
    AutoSplitKey = true;
    Caption = 'KPI Target Line';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "DK_KPI Target Line";
    SourceTableView = WHERE(Month = CONST(1));

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Report Taget Value Code"; Rec."Report Taget Value Code")
                {
                    Visible = false;
                }
                field("Report Taget Value Name"; Rec."Report Taget Value Name")
                {
                    Editable = false;
                }
                field(Field1; TargetAmount[1])
                {
                    Caption = 'Jan. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(1, TargetAmount[1]);
                    end;
                }
                field(Field2; TargetAmount[2])
                {
                    Caption = 'Feb. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(2, TargetAmount[2]);
                    end;
                }
                field(Field3; TargetAmount[3])
                {
                    Caption = 'Mar. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(3, TargetAmount[3]);
                    end;
                }
                field(Field4; TargetAmount[4])
                {
                    Caption = 'Apr. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(4, TargetAmount[4]);
                    end;
                }
                field(Field5; TargetAmount[5])
                {
                    Caption = 'May. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(5, TargetAmount[5]);
                    end;
                }
                field(Field6; TargetAmount[6])
                {
                    Caption = 'Jun. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(6, TargetAmount[6]);
                    end;
                }
                field(Field7; TargetAmount[7])
                {
                    Caption = 'Jul. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(7, TargetAmount[7]);
                    end;
                }
                field(Field8; TargetAmount[8])
                {
                    Caption = 'Aug. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(8, TargetAmount[8]);
                    end;
                }
                field(Field9; TargetAmount[9])
                {
                    Caption = 'Sep. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(9, TargetAmount[9]);
                    end;
                }
                field(Field10; TargetAmount[10])
                {
                    Caption = 'Oct. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(10, TargetAmount[10]);
                    end;
                }
                field(Field11; TargetAmount[11])
                {
                    Caption = 'Nov. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(11, TargetAmount[11]);
                    end;
                }
                field(Field12; TargetAmount[12])
                {
                    Caption = 'Dec. Amout';

                    trigger OnValidate()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        UpdateKPITargetLine(12, TargetAmount[12]);
                    end;
                }
                field(TotalAmount; TotalAmount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetTargetAmount;
    end;

    trigger OnOpenPage()
    begin
        SetTargetAmount;
    end;

    var
        TargetAmount: array[100] of Decimal;
        TotalAmount: Decimal;

    local procedure UpdateKPITargetLine(pMonth: Integer; pAmount: Decimal)
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin

        with _KPITargetLine do begin
            Rec.Reset;
            SetRange("Document No.", Rec."Document No.");
            SetRange("Report Taget Value Code", Rec."Report Taget Value Code");
            SetRange(Month, pMonth);
            if FindSet then begin
                Amount := pAmount;
                Rec.Modify(true);
            end else begin
                Rec.Reset;
                Init;
                "Document No." := Rec."Document No.";
                Rec."OBJECT ID" := Rec."OBJECT ID";
                Rec.Validate("Report Taget Value Code", Rec."Report Taget Value Code");
                Month := pMonth;
                Amount := pAmount;
                Year := Rec.Year;
                Status := Rec.Status;
                Rec.Insert(true);
            end;
        end;

        CalcTotalAmount;
    end;

    local procedure SetTargetAmount()
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin
        Clear(TargetAmount);
        Clear(TotalAmount);

        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("Document No.", Rec."Document No.");
        _KPITargetLine.SetRange("Report Taget Value Code", Rec."Report Taget Value Code");
        _KPITargetLine.SetCurrentKey(Month);
        if _KPITargetLine.FindSet then begin
            repeat
                case _KPITargetLine.Month of
                    1:
                        TargetAmount[1] := _KPITargetLine.Amount;
                    2:
                        TargetAmount[2] := _KPITargetLine.Amount;
                    3:
                        TargetAmount[3] := _KPITargetLine.Amount;
                    4:
                        TargetAmount[4] := _KPITargetLine.Amount;
                    5:
                        TargetAmount[5] := _KPITargetLine.Amount;
                    6:
                        TargetAmount[6] := _KPITargetLine.Amount;
                    7:
                        TargetAmount[7] := _KPITargetLine.Amount;
                    8:
                        TargetAmount[8] := _KPITargetLine.Amount;
                    9:
                        TargetAmount[9] := _KPITargetLine.Amount;
                    10:
                        TargetAmount[10] := _KPITargetLine.Amount;
                    11:
                        TargetAmount[11] := _KPITargetLine.Amount;
                    12:
                        TargetAmount[12] := _KPITargetLine.Amount;
                end;
            until _KPITargetLine.Next = 0;

            CalcTotalAmount;
        end;
    end;

    local procedure CalcTotalAmount()
    var
        _KPITargetLine: Record "DK_KPI Target Line";
    begin
        Clear(TotalAmount);

        _KPITargetLine.Reset;
        _KPITargetLine.SetRange("Document No.", Rec."Document No.");
        _KPITargetLine.SetRange("Report Taget Value Code", Rec."Report Taget Value Code");
        if _KPITargetLine.FindSet then begin
            _KPITargetLine.CalcSums(Amount);
            TotalAmount := _KPITargetLine.Amount;
        end;
    end;
}

