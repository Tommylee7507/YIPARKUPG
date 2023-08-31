page 50222 "DK_Interli. Cus. with CRM Log"
{
    Caption = 'Interli. Cus. with CRM Log';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interlink Cus. with CRM Log";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Data Type"; Rec."Data Type")
                {
                }
                field("Data Date"; Rec."Data Date")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(SocialSecurityNo; SocialSecurityNo)
                {
                    Caption = 'SocialSecurityNo';
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                field(Birthday; Rec.Birthday)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Company Post Code"; Rec."Company Post Code")
                {
                }
                field("Company Address"; Rec."Company Address")
                {
                }
                field("Company Address 2"; Rec."Company Address 2")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                }
                field(Memo; Rec.Memo)
                {
                }
                field("Record Del"; Rec."Record Del")
                {
                }
                field("Applied Date"; Rec."Applied Date")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if not Rec."SSN Encyption".HasValue then
            SocialSecurityNo := ''
        else
            SocialSecurityNo := '******-*******';
    end;

    var
        SocialSecurityNo: Text[20];
}

