page 50248 "DK_Interlink Cus. with CRM Log"
{
    Caption = 'Interlink Cus. with CRM Log';
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
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
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
                field("Mobile No."; Rec."Mobile No.")
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
                field("SSN Encyption"; Rec."SSN Encyption")
                {
                }
                field("Personal Data"; Rec."Personal Data")
                {
                }
                field("Marketing SMS"; Rec."Marketing SMS")
                {
                }
                field("Marketing Phone"; Rec."Marketing Phone")
                {
                }
                field("Marketing E-Mail"; Rec."Marketing E-Mail")
                {
                }
                field("Personal Data Third Party"; Rec."Personal Data Third Party")
                {
                }
                field("Personal Data Referral"; Rec."Personal Data Referral")
                {
                }
                field("Personal Data Concu. Date"; Rec."Personal Data Concu. Date")
                {
                }
                field("Record Del"; Rec."Record Del")
                {
                }
                field("Applied Date"; Rec."Applied Date")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control27; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

