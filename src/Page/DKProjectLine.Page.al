page 50058 "DK_Project Line"
{
    AutoSplitKey = true;
    Caption = 'Project Line';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "DK_Project Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Date := WorkDate;
    end;
}

