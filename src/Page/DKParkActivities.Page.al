page 50190 "DK_Park Activities"
{
    // // Date Filter : WORKDATE €Ë‘¹

    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup("Field Work")
            {
                Caption = 'Field Work';
                field("Field Work Incomplete"; Rec."Field Work Incomplete")
                {
                    Image = Document;
                }
                field("Field Work Complete"; Rec."Field Work Complete")
                {
                    Image = Document;
                }
                field("Acc. Field Work Incomplete"; Rec."Acc. Field Work Incomplete")
                {
                    Image = Document;
                }
            }
            cuegroup("Customer Request")
            {
                Caption = 'Customer Request';
                field("Customer Request Incomplete"; Rec."Customer Request Incomplete")
                {
                    Image = People;
                }
                field("Customer Request Complete"; Rec."Customer Request Complete")
                {
                    Image = People;
                }
                field("Acc. Cust. Req. Incomplete"; Rec."Acc. Cust. Req. Incomplete")
                {
                    Image = People;
                }
            }
            cuegroup("Cemetery Services")
            {
                Caption = 'Cemetery Services';
                field("Cem. Services Incomplete"; Rec."Cem. Services Incomplete")
                {
                    Image = Checklist;
                }
                field("Cem. Services Complete"; Rec."Cem. Services Complete")
                {
                    Image = Checklist;
                }
                field("Acc. Cem. Ser. Incomplete"; Rec."Acc. Cem. Ser. Incomplete")
                {
                    Image = Checklist;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Date Filter", '%1', WorkDate);
        Rec.SetFilter("Date Filter 2", '%1', WorkDate);
        Rec.FilterGroup(0);
    end;
}

