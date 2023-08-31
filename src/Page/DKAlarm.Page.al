page 50164 DK_Alarm
{
    Caption = 'Alarm';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Alarm;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Vehicle Document No."; Rec."Vehicle Document No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field(Subject; rEC.Subject)
                {
                }
                field(Contents; Rec.Contents)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

