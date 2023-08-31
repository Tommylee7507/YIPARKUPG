page 50269 "DK_Customer Delete List"
{
    Caption = 'Customer Delete List';
    CardPageID = "DK_Customer Delete Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Customer Delete Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                field("Address Unkonwn"; Rec."Address Unkonwn")
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
                field(Type; Rec.Type)
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
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
                {
                }
                field("Delete DateTime"; Rec."Delete DateTime")
                {
                }
                field("Delete Person"; Rec."Delete Person")
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
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

