page 50014 "DK_Changed Customer History"
{
    Caption = 'Changed Customer History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Changed Customer History";
    SourceTableView = SORTING("No.", "Version No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Modified"; Rec."Date Modified")
                {
                }
                field("Modified Person"; Rec."Modified Person")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Version No."; Rec."Version No.")
                {
                }
                field(Type; Rec.Type)
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
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field(Memo; Rec.Memo)
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
                field("Company Post Code"; Rec."Company Post Code")
                {
                }
                field("Company Address"; Rec."Company Address")
                {
                }
                field("Company Address 2"; Rec."Company Address 2")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control24; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

