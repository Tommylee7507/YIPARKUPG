page 50068 "DK_Cont. Refund Ref. Detail"
{
    AutoSplitKey = true;
    Caption = 'Contract refund Ref.e Table Detail';
    PageType = ListPart;
    SourceTable = "DK_Cont. Refund Ref. Detail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Period From"; Rec."Period From")
                {
                }
                field("Period To"; Rec."Period To")
                {
                }
                field("Refund Rate"; Rec."Refund Rate")
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
        Rec."Contract Type" := xRec."Contract Type";
    end;
}

