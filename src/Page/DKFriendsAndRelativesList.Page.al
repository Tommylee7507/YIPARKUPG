page 50305 "DK_Friends And Relatives List"
{
    Caption = 'Friends And Relatives List';
    CardPageID = "DK_Friends And Relatives";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Friends And Relatives";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Relation No."; Rec."Relation No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field("Cust. Post Code"; Rec."Cust. Post Code")
                {
                }
                field("Cust. Address"; Rec."Cust. Address")
                {
                }
                field("Cust. Address 2"; Rec."Cust. Address 2")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cust. Type"; Rec."Cust. Type")
                {
                }
                field("Cust. E-Mail"; Rec."Cust. E-Mail")
                {
                }
                field("Cust. Birthday"; Rec."Cust. Birthday")
                {
                }
                field("Cust. Gender"; Rec."Cust. Gender")
                {
                }
                field("Cust. Company Post Code"; Rec."Cust. Company Post Code")
                {
                }
                field("Cust. Company Address"; Rec."Cust. Company Address")
                {
                }
                field("Cust. Compnay Address 2"; Rec."Cust. Compnay Address 2")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Cust. Personal Data"; Rec."Cust. Personal Data")
                {
                }
                field("Cust. Marketing SMS"; Rec."Cust. Marketing SMS")
                {
                }
                field("Cust. Marketing Phone"; Rec."Cust. Marketing Phone")
                {
                }
                field("Cust. Marketing E-Mail"; Rec."Cust. Marketing E-Mail")
                {
                }
                field("Cust. Per. Data Third Party"; Rec."Cust. Per. Data Third Party")
                {
                }
                field("Cust. Per. Data Referral"; Rec."Cust. Per. Data Referral")
                {
                }
                field("Cust. Per. Data Concu. Date"; Rec."Cust. Per. Data Concu. Date")
                {
                }
                field("Cust. Re. Prov. Info Send Date"; Rec."Cust. Re. Prov. Info Send Date")
                {
                }
                field("Create Organizer"; Rec."Create Organizer")
                {
                    Visible = false;
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
            systempart(Control33; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

