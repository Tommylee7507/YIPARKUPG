page 50274 "DK_Rea. Prov. Send Card"
{
    // 
    // DK34 : 20201026
    //   - Create

    Caption = 'Reagree Provide To Information Send Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "DK_Reagree To Provide Info";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Send Date"; Rec."Send Date")
                {
                }
                field("Send Person"; Rec."Send Person")
                {
                }
            }
            group(Contact)
            {
                Caption = 'Contact';
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                group(Control30)
                {
                    ShowCaption = false;
                    field("Post Code"; Rec."Post Code")
                    {
                    }
                    field(Address; Rec.Address)
                    {
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                    }
                }
            }
            group("Agreement on Personal Information")
            {
                Caption = 'Agreement on Personal Information';
                field("Personal Data"; Rec."Personal Data")
                {
                }
                field("Marketing SMS"; Rec."Marketing SMS")
                {
                }
                field("Marketing Phone"; Rec."Marketing Phone")
                {
                }
                field("Markeing E-mail"; Rec."Markeing E-mail")
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
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control32; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

