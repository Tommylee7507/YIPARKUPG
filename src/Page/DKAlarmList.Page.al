page 50163 "DK_Alarm List"
{
    Caption = 'Alarm List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Alarm;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Vehicle Document No."; Rec."Vehicle Document No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field(Subject; Rec.Subject)
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

