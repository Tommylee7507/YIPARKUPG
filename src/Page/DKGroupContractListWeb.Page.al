page 50292 "DK_Group Contract List (Web)"
{
    Caption = 'Group Contract List (Web)';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Contract;
    SourceTableView = WHERE("Contract Type" = CONST(Group),
                            Status = CONST(FullPayment));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ContractNo; Rec."No.")
                {
                }
                field(MainCustomerName; Rec."Main Customer Name")
                {
                }
                field(EstateCode; Rec."Estate Code")
                {
                }
                field(EstateName; Rec."Estate Name")
                {
                }
                field(CemeterySize; Rec."Cemetery Size")
                {
                }
                field(ContractDate; Rec."Contract Date")
                {
                }
                field(AdminExpenseOption; Rec."Admin. Expense Option")
                {
                }
            }
        }
    }

    actions
    {
    }
}

