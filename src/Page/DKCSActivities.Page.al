page 50191 "DK_CS Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup("Cemetery Service")
            {
                Caption = 'Cemetery Service';
                field("Cem. Services Incomplete"; Rec."Cem. Services Incomplete")
                {
                }
                field("Cem. Services Complete"; Rec."Cem. Services Complete")
                {
                }
            }
            cuegroup(Contract)
            {
                Caption = 'Contract';
                field("No. of Open Contract"; Rec."No. of Open Contract")
                {
                }
                field("No. of Temp. Contract"; Rec."No. of Temp. Contract")
                {
                }
                field("No. of Pay. Bal. Contract"; Rec."No. of Pay. Bal. Contract")
                {
                }
                field("No. of Overdue Bal. Cont."; Rec."No. of Overdue Bal. Cont.")
                {
                }
            }
            cuegroup("TODAY PG Payment")
            {
                Caption = 'TODAY PG Payment';
                field("TODAY PG Receipt"; Rec."TODAY PG Receipt")
                {
                }
                field("TODAY PG Receipt2"; Rec."TODAY PG Receipt2")
                {
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
        Rec.SetFilter("Date Filter", '<%1', WorkDate);
        Rec.SetFilter("Date Filter 2", '%1', WorkDate);
        Rec.FilterGroup(0);
    end;
}

