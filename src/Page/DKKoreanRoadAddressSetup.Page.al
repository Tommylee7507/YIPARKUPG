page 50100 "DK_Korean Road Address Setup"
{
    // DK_KRADDR1.0
    //   - Create New

    Caption = 'Korean Road Address Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Korean Road Address Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Activated; Rec.Activated)
                {
                }
                field("Count Per Page"; Rec."Count Per Page")
                {
                }
                field("Default Language"; Rec."Default Language")
                {
                }
                field("Default Country/Region Code"; Rec."Default Country/Region Code")
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
        Rec.InsertIfNotExists();
    end;

    var
        KoreanRaodAddressMgt: Codeunit "DK_Korean Road Address Mgt.";
}

