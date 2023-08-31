page 50311 "DK_Web Pay. Receipt List (API)"
{
    // #2542 : 20200416
    //   - Create

    Caption = 'Web Payment Receipt List (API)';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Payment Receipt Doc. Line";
    SourceTableView = WHERE("Payment Target" = FILTER(General | Landscape),
                            Refund = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ContractNo; Rec."Contract No.")
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
                field(PaymentDate; Rec."Payment Date")
                {
                    Caption = 'PaymentDate';
                }
                field(PaymentTarget; Rec."Payment Target")
                {
                    Caption = 'PaymentTarget';
                }
                field(StartDate; Rec."Start Date")
                {
                    Caption = 'StartDate';
                }
                field(ExpirationDate; Rec."Expiration Date")
                {
                    Caption = 'ExpirationDate';
                }
                field(PaymentType; Rec."Payment Type")
                {
                    Caption = 'PaymentType';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(MainCustNo; Rec."Main Customer No.")
                {
                    Caption = 'MainCustNo';
                }
                field(MainCustBirthday; Rec."Main Customer Birthday")
                {
                    Caption = 'MainCustBirthday';
                }
            }
        }
    }

    actions
    {
    }
}

