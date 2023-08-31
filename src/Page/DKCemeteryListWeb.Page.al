page 50293 "DK_Cemetery List (Web)"
{
    // *DK32 : 20200716
    //   - Rec. Modify Function : GetAmounts

    Caption = 'Cemetery List (Web)';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Cemetery;
    SourceTableView = SORTING("Cemetery No.")
                      WHERE(Status = CONST(Unsold),
                            "Contract No." = FILTER(''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CemeteryCode; Rec."Cemetery Code")
                {
                }
                field(CemeteryNo; Rec."Cemetery No.")
                {
                }
                field(Class; Rec.Class)
                {
                }
                field(Size; Rec.Size)
                {
                }
                field(Size2; Rec."Size 2")
                {
                }
                field(ManageUnitPeriod; ManageUnit)
                {
                    Caption = 'Management Period';
                }
                field(CemAmount_; CemAmount)
                {
                    Caption = 'Cemetery Amount';
                }
                field(CemClassDisRate_; CemClassDisRate)
                {
                    Caption = 'Cemetery Class Discount Rate';
                }
                field(CemClassDisAmt_; CemClassDisAmt)
                {
                    Caption = 'Cemetery Class Discount';
                }
                field(GeneralPrice_; GeneralPrice)
                {
                    Caption = 'General Price';
                }
                field(GeneralAmount_; GeneralAmount)
                {
                    Caption = 'General Expense Amount';
                }
                field(LandPrice_; LandPrice)
                {
                    Caption = 'Land. Price';
                }
                field(LandAmount_; LandAmount)
                {
                    Caption = 'Land. Expense Amount';
                }
                field(EstateCode; Rec."Estate Code")
                {
                }
                field(EstateName; Rec."Estate Name")
                {
                }
                field(CemConfName; Rec."Cemetery Conf. Name")
                {
                }
                field(CemDigName; Rec."Cemetery Dig. Name")
                {
                }
                field(CemOptionName; Rec."Cemetery Option Name")
                {
                }
                field(UnitPriceTypeName; Rec."Unit Price Type Name")
                {
                }
                field(LandArchi; Rec."Landscape Architecture")
                {
                }
                field(DateFilter; Rec."Date Filter")
                {
                }
                field(GroupContractFilter; Rec."Group Contract Filter")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        _GroupContractNo: Code[20];
        _Contract: Record DK_Contract;
    begin

        if Rec.GetFilter("Group Contract Filter") <> '' then
            _GroupContractNo := Rec.GetRangeMin("Group Contract Filter")
        else
            Rec.SetRange("Estate Code");

        if _GroupContractNo <> '' then begin
            if _Contract.Get(_GroupContractNo) then begin
                _Contract.CalcFields("Estate Code");
                Rec.SetRange("Estate Code", _Contract."Estate Code");
            end;
        end;

        GetAmounts(Rec);
    end;

    trigger OnOpenPage()
    begin
        FunctionSetup.Get;
        ManageUnit := FunctionSetup."Management Unit";
    end;

    var
        ManageUnit: Integer;
        FunctionSetup: Record "DK_Function Setup";
        CemAmount: Decimal;
        CemClassDisRate: Decimal;
        CemClassDisAmt: Decimal;
        GeneralPrice: Decimal;
        LandPrice: Decimal;
        GeneralAmount: Decimal;
        LandAmount: Decimal;

    local procedure GetAmounts(pCemetery: Record DK_Cemetery)
    var
        _GroupContractNo: Code[20];
        _ContractDate: Date;
        _Contract: Record DK_Contract;
        _CemeteryPrice: Codeunit "DK_Cemetery Price";
    begin
        ClearReturnValue;

        if Rec.GetFilter("Date Filter") <> '' then
            _ContractDate := Rec.GetRangeMin("Date Filter");
        if Rec.GetFilter("Group Contract Filter") <> '' then
            _GroupContractNo := Rec.GetRangeMin("Group Contract Filter");

        if _ContractDate = 0D then exit;

        if pCemetery."Cemetery Code" <> '' then begin

            if _GroupContractNo = '' then begin
                CemAmount := _CemeteryPrice.GetCemAmount(pCemetery, _ContractDate) * Rec.Size;
                _CemeteryPrice.AdminExpenseAmt(pCemetery, _ContractDate, GeneralPrice, LandPrice, CemClassDisRate);

            end else begin
                if _Contract.Get(_GroupContractNo) then begin
                    if _Contract."Admin. Expense Option" = _Contract."Admin. Expense Option"::"Per Contract" then begin
                        CemAmount := _CemeteryPrice.GetCemAmount(pCemetery, _ContractDate) * Rec.Size;
                        _CemeteryPrice.AdminExpenseAmt(pCemetery, _ContractDate, GeneralPrice, LandPrice, CemClassDisRate);
                    end;
                end;
            end;
        end;

        if CemClassDisRate <> 0 then
            CemClassDisAmt := Round(CemAmount * (CemClassDisRate / 100), 1, '=');

        GeneralAmount := GeneralPrice * ManageUnit;
        LandAmount := LandPrice * ManageUnit;
    end;

    local procedure ClearReturnValue()
    begin
        CemAmount := 0;
        CemClassDisRate := 0;
        CemClassDisAmt := 0;
        GeneralPrice := 0;
        LandPrice := 0;
        GeneralAmount := 0;
        LandAmount := 0;
    end;
}

