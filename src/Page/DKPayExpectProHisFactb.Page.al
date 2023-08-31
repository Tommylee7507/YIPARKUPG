page 50177 "DK_Pay. Expect Pro. His. Factb"
{
    Caption = 'Payment Expect Process History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Pay. Expect Process History";
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
                field("Entry Date"; Rec."Entry Date")
                {
                }
                field("Entry Time"; Rec."Entry Time")
                {
                }
                field("Pay. Receipt Doc. No."; Rec."Pay. Receipt Doc. No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("List window")
            {
                Caption = 'List window';
                Image = ListPage;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Page "DK_Pay. Expect Process History";
                RunPageLink = "Pay. Expect Doc. No." = FIELD("Pay. Expect Doc. No.");
                RunPageMode = View;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

