codeunit 50040 "DK_Cemetery Price"
{
    // *DK32 : 20200716
    //   - Create
    // 


    trigger OnRun()
    begin
    end;


    procedure AdminExpenseAmt(pCemetery: Record DK_Cemetery; pContractDate: Date; var pGeneralPrice: Decimal; var pLandPrice: Decimal; var pCemeteryDisRate: Decimal)
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _UnitPrice: Decimal;
        _CemClassDis: Record "DK_Cemetery Class Discount";
    begin

        pCemetery.CalcFields("Admin. Expense Method");
        case pCemetery."Admin. Expense Method" of
            pCemetery."Admin. Expense Method"::Contract:
                begin
                    Clear(_AdminExpenseMgt);
                    _UnitPrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pCemetery."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::General, pContractDate);
                    pGeneralPrice := _UnitPrice * pCemetery.Size;

                    if pCemetery."Landscape Architecture" then begin
                        Clear(_AdminExpenseMgt);
                        _UnitPrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(pCemetery."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::Landscape, pContractDate);
                        pLandPrice := _UnitPrice * pCemetery.Size;
                    end else begin
                        pLandPrice := 0;
                    end;
                end;
        end;


        _CemClassDis.Reset;
        _CemClassDis.SetCurrentKey("Starting Date");
        _CemClassDis.SetRange("Estate Code", pCemetery."Estate Code");
        _CemClassDis.SetRange("Cemetery Conf. Code", pCemetery."Cemetery Conf. Code");
        _CemClassDis.SetRange("Cemetery Option Code", pCemetery."Cemetery Option Code");
        _CemClassDis.SetRange(Class, pCemetery.Class);
        _CemClassDis.SetFilter("Starting Date", '<=%1', pContractDate);
        if _CemClassDis.FindLast then begin
            pCemeteryDisRate := _CemClassDis.Discount;
        end;
    end;


    procedure GetCemAmount(pCemetery: Record DK_Cemetery; pContractDate: Date): Decimal
    var
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
    begin

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetCurrentKey("Starting Date");
        _CemeteryUnitPrice.SetRange("Estate Code", pCemetery."Estate Code");
        _CemeteryUnitPrice.SetRange("Cemetery Conf. Code", pCemetery."Cemetery Conf. Code");
        _CemeteryUnitPrice.SetRange("Cemetery Option Code", pCemetery."Cemetery Option Code");
        _CemeteryUnitPrice.SetFilter("Starting Date", '<=%1', pContractDate);
        if _CemeteryUnitPrice.FindLast then begin
            exit(_CemeteryUnitPrice."Unit Price");
        end;
    end;
}

