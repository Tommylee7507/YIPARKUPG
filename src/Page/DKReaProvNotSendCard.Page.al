page 50272 "DK_Rea. Prov. Not Send Card"
{
    Caption = 'Reagree To Provide Information Not Send Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "DK_Reagree To Provide Info";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
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
            }
            group(Contact)
            {
                Caption = 'Contact';
                field("Mobile No."; Rec."Mobile No.")
                {
                    ExtendedDatatype = PhoneNo;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    ExtendedDatatype = PhoneNo;
                }
                field("E-mail"; Rec."E-mail")
                {
                    Editable = false;
                    ExtendedDatatype = EMail;
                }
                group(Control5)
                {
                    ShowCaption = false;
                    field("Post Code"; Rec."Post Code")
                    {
                        Editable = false;
                    }
                    field(Address; Rec.Address)
                    {
                        Editable = false;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        Editable = false;
                    }
                }
            }
            group("Agreement on Personal Information")
            {
                Caption = 'Agreement on Personal Information';
                Editable = false;
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
            systempart(Control30; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

