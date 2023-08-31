page 50309 "DK_Web Corpse List (API)"
{
    // #2542 : 20200416
    //   - Create

    Caption = 'Web Corpse List (API)';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Corpse;
    SourceTableView = WHERE("Contract Status" = CONST(FullPayment),
                            "Move The Grave Type" = CONST(false));

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
                field(LineNo; Rec."Line No.")
                {
                    Caption = 'LineNo';
                }
                field(CemeteryCode; Rec."Cemetery Code")
                {
                    Caption = 'CemeteryCode';
                }
                field(CemeteryNo; Rec."Cemetery No.")
                {
                    Caption = 'CemeteryNo';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(DeathDate; Rec."Death Date")
                {
                    Caption = 'DeathDate';
                }
                field(LayingDate; Rec."Laying Date")
                {
                    Caption = 'LayingDate';
                }
                field(SocialSecurityNo; Rec."Social Security No.")
                {
                    Caption = 'SocialSecurityNo';
                }
                field(DeathCause; Rec."Death Cause")
                {
                    Caption = 'DeathCause';
                }
                field(DeathPlace; Rec."Death Place")
                {
                    Caption = 'DeathPlace';
                }
                field(CemeterySize; Rec."Cemetery Size")
                {
                    Caption = 'CemeterySize';
                }
                field(Relationship; Rec.Relationship)
                {
                    Caption = 'Relationship';
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
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

