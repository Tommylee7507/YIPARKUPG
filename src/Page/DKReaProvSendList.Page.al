page 50273 "DK_Rea. Prov. Send List"
{
    // 
    // DK34 : 20201026
    //   - Create

    Caption = 'Reagree Provide To Information Send List';
    CardPageID = "DK_Rea. Prov. Send Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Reagree To Provide Info";
    SourceTableView = SORTING("No.")
                      WHERE("Send Type" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
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
                field(Name; Rec.Name)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
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
                field("E-mail"; Rec."E-mail")
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
                field("Send Date"; Rec."Send Date")
                {
                }
                field("Send Person"; Rec."Send Person")
                {
                }
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
            systempart(Control31; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

