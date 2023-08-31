page 50235 "DK_Admin. Liti. By Year"
{
    Caption = 'Admin Litigation By Year';
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
                field(StartDate; StartDate)
                {
                    Caption = 'Litigation Start Date';

                    trigger OnValidate()
                    begin
                        StartDate_Onvaildate;
                    end;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'Litigation End Date';

                    trigger OnValidate()
                    begin
                        EndDate_Onvaildate;
                    end;
                }
                field(ReferenceYear; ReferenceYear)
                {
                    Caption = 'Reference Date';
                    MaxValue = 3000;
                    MinValue = 1900;

                    trigger OnValidate()
                    begin
                        ReferenceYear_Onvaildate;
                    end;
                }
                field(OptionType; OptionType)
                {
                    Caption = 'Admin Type';
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
                field("SHORT TEXT4"; Rec."SHORT TEXT4")
                {
                    Caption = 'Admin Type';
                    StyleExpr = ColorStyle;
                }
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Contract No.';
                    Editable = false;
                    StyleExpr = ColorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        View_ContractDoc;
                    end;
                }
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Cemetery No.';
                    StyleExpr = ColorStyle;
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Name';
                    StyleExpr = ColorStyle;
                }
                field("SHORT TEXT2"; Rec."SHORT TEXT2")
                {
                    Caption = 'Phone No.';
                    StyleExpr = ColorStyle;
                }
                field("SHORT TEXT3"; Rec."SHORT TEXT3")
                {
                    Caption = 'Mobile No.';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'Cemetery Size';
                    StyleExpr = ColorStyle;
                }
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Litigation Start Date';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Litigation Term';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    Caption = 'Litigation Amount';
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL3; Rec.DECIMAL3)
                {
                    CaptionClass = '3,' + ColumnCaptionCount[1];
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL4; Rec.DECIMAL4)
                {
                    CaptionClass = '3,' + ColumnCaptionCount[2];
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL5; Rec.DECIMAL5)
                {
                    CaptionClass = '3,' + ColumnCaptionCount[3];
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL6; Rec.DECIMAL6)
                {
                    CaptionClass = '3,' + ColumnCaptionCount[4];
                    StyleExpr = ColorStyle;
                }
                field(DECIMAL7; Rec.DECIMAL7)
                {
                    CaptionClass = '3,' + ColumnCaptionCount[5];
                    StyleExpr = ColorStyle;
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
                end;
            }
            separator(Action26)
            {
            }
            action("View Contract Document")
            {
                Caption = 'View Contract Document';
                Image = View;
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
        ReferenceYear: Integer;
        OptionType: Option General,Landscape,All;
        ColumnCaptionCount: array[5] of Text[1024];
        YearMSG: Label '%1';
        PreYearMSG: Label '%1Previous';
        MSG001: Label 'Start Date cannot be greater than EndDate.';
        Contract: Record DK_Contract;
        EntryNo: Integer;
        ColorStyle: Text[20];

    local procedure SetData()
    begin
        EndDate := WorkDate;
        StartDate := CalcDate('<-CY>', WorkDate);

        ReferenceYear := Date2DMY(WorkDate, 3);
        OptionType := OptionType::General;

        SetCaption;
    end;

    local procedure SetFilterDelete()
    begin
        Rec.Reset;
        Rec.DeleteAll;
    end;

    local procedure SetCaption()
    var
        _i: Integer;
        _ReferenceYear: Integer;
    begin
        _ReferenceYear := ReferenceYear;

        _i := 5;
        while _i > 1 do begin
            ColumnCaptionCount[_i] := StrSubstNo(YearMSG, _ReferenceYear);
            _i -= 1;
            _ReferenceYear -= 1;
        end;
        ColumnCaptionCount[_i] := StrSubstNo(PreYearMSG, _ReferenceYear);
    end;


    procedure DataInquiry()
    var
        _Contract: Record DK_Contract;
    begin

        Contract.Reset;

        case OptionType of
            OptionType::General:
                begin
                    Contract.SetRange("General Expiration Date", StartDate - 1, EndDate + 1);
                    Insert_ReportBuffer(0);
                end;
            OptionType::Landscape:
                begin
                    Contract.SetRange("Land. Arc. Expiration Date", StartDate - 1, EndDate + 1);
                    Insert_ReportBuffer(1);
                end;
            OptionType::All:
                begin
                    Contract.SetRange("General Expiration Date", StartDate - 1, EndDate + 1);
                    Insert_ReportBuffer(0);

                    Contract.SetRange("General Expiration Date");
                    Contract.SetRange("Land. Arc. Expiration Date", StartDate - 1, EndDate + 1);
                    Insert_ReportBuffer(1);
                end;
        end;

        if EntryNo > 0 then begin
            Rec.SetCurrentKey(CODE0, "SHORT TEXT4");
            Rec.Ascending(true);
            Rec.FindFirst;
        end;
    end;

    local procedure Insert_ReportBuffer(pOption: Option General,Landscape)
    var
        _RefStartDate: Date;
        _RefEndDate: Date;
        _EntryNo: Integer;
        _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _DupReferenceYear: Integer;
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin
        if Contract.FindSet then begin
            repeat
                Contract.CalcFields("Cemetery Size", "Cust. Phone No.", "Cust. Mobile No.");

                EntryNo += 1;
                Rec."USER ID" := UserId;
                Rec."OBJECT ID" := PAGE::"DK_Admin. Liti. By Year";
                Rec."Entry No." := EntryNo;
                Rec.CODE0 := Contract."No.";
                Rec."SHORT TEXT0" := Contract."Cemetery No.";
                Rec."SHORT TEXT1" := Contract."Main Customer Name";
                Rec."SHORT TEXT2" := Contract."Cust. Phone No.";
                Rec."SHORT TEXT3" := Contract."Cust. Mobile No.";

                case pOption of
                    pOption::General:
                        begin
                            Rec."SHORT TEXT4" := Format(_AdminExpenseLedger."Admin. Expense Type"::General);
                            Rec.DATE0 := Contract."General Expiration Date" + 1;
                            Rec.DECIMAL0 := _RevocationContractMgt.CalcContractPreiodMonth(Contract."General Expiration Date" + 1, Today);
                            Rec.DECIMAL2 := Contract."Non-Pay. General Amount";
                            Rec.INTEGER0 := 0;
                        end;
                    pOption::Landscape:
                        begin
                            Rec."SHORT TEXT4" := Format(_AdminExpenseLedger."Admin. Expense Type"::Landscape);
                            Rec.DATE0 := Contract."Land. Arc. Expiration Date" + 1;
                            Rec.DECIMAL0 := _RevocationContractMgt.CalcContractPreiodMonth(Contract."Land. Arc. Expiration Date" + 1, Today);
                            Rec.DECIMAL2 := Contract."Non-Pay. Land. Arc. Amount";
                            Rec.INTEGER0 := 1;
                        end;
                end;

                Rec.DECIMAL1 := Contract."Cemetery Size";
                _DupReferenceYear := ReferenceYear;

                _RefStartDate := DMY2Date(1, 1, _DupReferenceYear);
                _RefEndDate := DMY2Date(31, 12, _DupReferenceYear);
                Rec.DECIMAL7 := CAL_LitigationAmount(Contract."No.", _RefStartDate, _RefEndDate, OptionType);
                _DupReferenceYear -= 1;

                _RefStartDate := DMY2Date(1, 1, _DupReferenceYear);
                _RefEndDate := DMY2Date(31, 12, _DupReferenceYear);
                Rec.DECIMAL6 := CAL_LitigationAmount(Contract."No.", _RefStartDate, _RefEndDate, OptionType);
                _DupReferenceYear -= 1;

                _RefStartDate := DMY2Date(1, 1, _DupReferenceYear);
                _RefEndDate := DMY2Date(31, 12, _DupReferenceYear);
                Rec.DECIMAL5 := CAL_LitigationAmount(Contract."No.", _RefStartDate, _RefEndDate, OptionType);
                _DupReferenceYear -= 1;

                _RefStartDate := DMY2Date(1, 1, _DupReferenceYear);
                _RefEndDate := DMY2Date(31, 12, _DupReferenceYear);
                Rec.DECIMAL4 := CAL_LitigationAmount(Contract."No.", _RefStartDate, _RefEndDate, OptionType);
                _DupReferenceYear -= 1;

                _RefStartDate := 0D;
                _RefEndDate := DMY2Date(31, 12, _DupReferenceYear);
                Rec.DECIMAL3 := CAL_LitigationAmount(Contract."No.", _RefStartDate, _RefEndDate, OptionType);

                Rec.Insert;
                ;
            until Contract.Next = 0;
        end;
    end;

    local procedure CAL_LitigationAmount(pContractNo: Code[20]; pStartDate: Date; pEndDate: Date; pOptionType: Option General,Landscape): Decimal
    var
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
    begin

        _DetailAdminExpLedger.Reset;
        _DetailAdminExpLedger.SetRange("Contract No.", pContractNo);
        _DetailAdminExpLedger.SetRange("Admin. Expense Type", pOptionType);
        _DetailAdminExpLedger.SetRange(Date, pStartDate, pEndDate);
        _DetailAdminExpLedger.SetRange("Ledger Type", _DetailAdminExpLedger."Ledger Type"::Daily);
        if _DetailAdminExpLedger.FindSet then begin
            _DetailAdminExpLedger.CalcSums(Amount);
            exit(-(_DetailAdminExpLedger.Amount));
        end;

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
        SetFilterDelete;
        SetCaption;
    end;

    local procedure OptionType_Onvaildate()
    begin
        SetFilterDelete;
        SetCaption;
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
}

