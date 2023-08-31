page 50213 "DK_Closing Setup"
{
    Caption = 'Closing Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "General Ledger Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                }
                field("DK_Allow Posting Time"; Rec."DK_Allow Posting Time")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        _GenSetup: Record "General Ledger Setup";
    begin
        //Initial data generation
        _GenSetup.Reset;
        if not _GenSetup.Get then begin
            //Default
            _GenSetup.Init;
            _GenSetup."DK_Allow Posting Time" := 170000T;
            _GenSetup.Insert;
            CurrPage.Update;
        end;
    end;
}

