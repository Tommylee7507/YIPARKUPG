page 50308 "DK_Web Contract List 2 (API)"
{
    // #2542 : 20200416
    //   - Create

    Caption = 'Web Contract List (API)';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Contract;
    SourceTableView = SORTING("No.")
                      WHERE(Status = CONST(FullPayment));

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
                field(MainCustName; Rec."Main Customer Name")
                {
                    Caption = 'MainCustName';
                }
                field(MainCustBirthday; Rec."Main Customer Birthday")
                {
                    Caption = 'MainCustBirthday';
                }
                field(MainCustAddr; MainCustAddr)
                {
                    Caption = 'MainCustAddr';
                }
                field(MainCustEmail; Rec."Main Custmer E-mail")
                {
                    Caption = 'MainCustEmail';
                }
                field(MainCustPhoneNo; Rec."Main Custmer Phone No.")
                {
                }
                field(MainCustMobileNo; Rec."Main Custmer Mobile No.")
                {
                }
                field(CustName2; Rec."Customer Name 2")
                {
                    Caption = 'CustName2';
                }
                field(CustBirthday2; Rec."Custmer Birthday 2")
                {
                    Caption = 'CustBirthday2';
                }
                field(CustAddr2; CustAddr2)
                {
                    Caption = 'CustAddr2';
                }
                field(CustName3; Rec."Customer Name 3")
                {
                    Caption = 'CustName3';
                }
                field(CustBirthday3; Rec."Custmer Birthday 3")
                {
                    Caption = 'CustBirthday3';
                }
                field(CustAddr3; CustAddr3)
                {
                    Caption = 'CustAddr3';
                }
                field(CemeteryCode; Rec."Cemetery Code")
                {
                    Caption = 'CemeteryCode';
                }
                field(CemeteryNo; Rec."Cemetery No.")
                {
                    Caption = 'CemeteryNo';
                }
                field(LandscapeArchitecture; Rec."Cemetery Landscape Archit.")
                {
                    Caption = 'LandscapeArchitecture';
                }
                field(ContractDate; Rec."Contract Date")
                {
                    Caption = 'ContractDate';
                }
                field(GeneralExpirationDate; Rec."General Expiration Date")
                {
                    Caption = 'GeneralExpirationDate';
                }
                field(LandArcExpirationDate; Rec."Land. Arc. Expiration Date")
                {
                    Caption = 'LandArcExpirationDate';
                }
                field(Default; Default)
                {
                    Caption = 'Default';
                }
                field(MainAssociateName; Rec."Main Associate Name")
                {
                    Caption = 'MainAssociateName';
                }
                field(MainAssociateEMail; Rec."Main Associate E-Mail")
                {
                    Caption = 'MainAssociateEMail';
                }
                field(MainAssociateMobileNo; Rec."Main Associate Mobile No.")
                {
                    Caption = 'MainAssociateMobileNo';
                }
                field(MainAssociateAddr; MainAssociateAddr)
                {
                    Caption = 'MainAssociateAddr';
                }
                field(CemeterySize; Rec."Cemetery Size")
                {
                    Caption = 'CemeterySize';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Landscape Architecture", Rec."Main Customer Address", Rec."Main Customer Address 2", "Custmer Address 2", "Custmer Address 2 2", "Custmer Address 3", "Custmer Address 2 3");
        if Rec."Landscape Architecture" then begin
            if (Rec."General Expiration Date" < Today) or (Rec."Land. Arc. Expiration Date" < Today) then
                Default := true
            else
                Default := false;
        end else begin
            if (Rec."General Expiration Date" < Today) then
                Default := true
            else
                Default := false;
        end;


        if Rec."Main Customer Address 2" = '' then
            MainCustAddr := Rec."Main Customer Address"
        else
            MainCustAddr := Rec."Main Customer Address" + ' ' + Rec."Main Customer Address 2";

        if Rec."Custmer Address 2 2" = '' then
            CustAddr2 := Rec."Custmer Address 2"
        else
            CustAddr2 := Rec."Custmer Address 2" + ' ' + Rec."Custmer Address 2 2";

        if Rec."Custmer Address 2 2" = '' then
            CustAddr3 := Rec."Custmer Address 3"
        else
            CustAddr3 := Rec."Custmer Address 3" + ' ' + Rec."Custmer Address 2 3";

        if Rec."Main Associate Address 2" = '' then
            MainAssociateAddr := Rec."Main Associate Address"
        else
            MainAssociateAddr := Rec."Main Associate Address" + ' ' + Rec."Main Associate Address 2";
    end;

    var
        Default: Boolean;
        MainCustAddr: Text[150];
        CustAddr2: Text[150];
        CustAddr3: Text[150];
        MainAssociateAddr: Text[150];
}

