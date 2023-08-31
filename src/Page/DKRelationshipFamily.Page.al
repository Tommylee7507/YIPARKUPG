page 50055 "DK_Relationship Family"
{
    // 
    // DK34: 20201026
    //   - Add Field: "Reagree Prov. Info Send Date"
    //     : 20201027
    //   - Add Action: <Page DK_Rea. Prov. Send List>

    AutoSplitKey = true;
    Caption = 'Relationship Family';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Relationship Family";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("E-mail"; Rec."E-mail")
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
                field(Remark; Rec.Remark)
                {
                    MultiLine = true;
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
                field("Reagree Prov. Info Send Date"; Rec."Reagree Prov. Info Send Date")
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
            systempart(Control23; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reagree Provide To Information List")
            {
                Caption = 'Reagree Provide To Information List';
                Ellipsis = true;
                Image = ShowList;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "DK_Rea. Prov. Send List";
                RunPageLink = "Source No." = FIELD("Contract No."),
                              "Source Line No." = FIELD("Line No.");
            }
        }
    }
}

