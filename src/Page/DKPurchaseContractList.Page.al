page 50011 "DK_Purchase Contract List"
{
    Caption = 'Purchase Contract List';
    CardPageID = "DK_Purchase Contract Card";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Purchase Contract";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Max Contract Date To"; Rec."Max Contract Date To")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field(Relation; Rec.Relation)
                {
                }
                field(Notice; Rec.Notice)
                {
                }
                field("Automatic Extension"; Rec."Automatic Extension")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control13; "DK_Posted Attched Files Facbox")
            {
                SubPageLink = "Table ID" = CONST(50011),
                              "Source No." = FIELD("No."),
                              "Source Line No." = CONST(0);
            }
            part(Control14; "DK_Alarm Factbox")
            {
                SubPageLink = "Source No." = FIELD("No."),
                              "Source Type" = CONST(PurchaseContract);
                UpdatePropagation = Both;
            }
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

