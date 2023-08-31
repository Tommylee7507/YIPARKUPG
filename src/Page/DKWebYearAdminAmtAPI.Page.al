page 50310 "DK_Web Year Admin. Amt (API)"
{
    // #2542 : 20200416
    //   - Create

    Caption = 'Web Year Admin. Amount (API)';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Contract;
    SourceTableView = WHERE(Status = CONST(FullPayment));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ContractNo; Rec."No.")
                {
                    Caption = 'ContractNo';
                }
                field(CemeteryCode; Rec."Cemetery Code")
                {
                    Caption = 'CemeteryCode';
                }
                field(CemeteryNo; Rec."Cemetery No.")
                {
                    Caption = 'CemeteryNo';
                }
                field(LandscapeArchitecture; Rec."Landscape Architecture")
                {
                    Caption = 'LandscapeArchitecture';
                }
                field(YearGeneralAmount; YearGeneralAmount)
                {
                    Caption = 'YearGeneralAmount';
                }
                field(YearLandAmount; YearLandAmount)
                {
                    Caption = 'YearLandAmount';
                }
                field(MainCustBirthday; Rec."Main Customer Birthday")
                {
                    Caption = 'MainCustBirthday';
                }
                field(MainCustPhoneNo; Rec."Main Custmer Phone No.")
                {
                    Caption = 'MainCustPhoneNo';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        //¼ýˆ«Š±
        GetYearAdminExpensePrice;
    end;

    var
        YearGeneralAmount: Decimal;
        YearLandAmount: Decimal;

    local procedure GetYearAdminExpensePrice()
    var
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _Contract: Record DK_Contract;
    begin

        YearGeneralAmount := 0;
        YearLandAmount := 0;

        Rec.CalcFields("Cemetery Size", "Landscape Architecture");

        //°„Âº ‰¦“ˆ
        if Rec."Cemetery Code" <> '' then begin
            YearGeneralAmount := Round(_AdminExpenseMgt.GetCurrAdminExpensePrice(Rec."Cemetery Code", 0, Today) * Rec."Cemetery Size", 1, '=');
            if Rec."Landscape Architecture" then
                YearLandAmount := Round(_AdminExpenseMgt.GetCurrAdminExpensePrice(Rec."Cemetery Code", 0, Today) * Rec."Cemetery Size", 1, '=');
        end;
    end;
}

