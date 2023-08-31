page 50303 "DK_Friends And Rel. Subform"
{
    Caption = 'Friends And Relatives Subform';
    CardPageID = "DK_Friends And Relatives";
    Editable = false;
    PageType = ListPart;
    SourceTable = "DK_Friends And Relatives";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Relation No."; Rec."Relation No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field("Cust. Personal Data"; Rec."Cust. Personal Data")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Marketing SMS"; Rec."Cust. Marketing SMS")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Marketing Phone"; Rec."Cust. Marketing Phone")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Marketing E-Mail"; Rec."Cust. Marketing E-Mail")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Per. Data Third Party"; Rec."Cust. Per. Data Third Party")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Per. Data Referral"; Rec."Cust. Per. Data Referral")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Per. Data Concu. Date"; Rec."Cust. Per. Data Concu. Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Re. Prov. Info Send Date"; Rec."Cust. Re. Prov. Info Send Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
            }
        }
    }

    actions
    {
    }
}

