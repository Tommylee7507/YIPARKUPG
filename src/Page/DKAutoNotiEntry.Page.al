page 50033 "DK_Auto. Noti. Entry"
{
    Caption = 'Auto. Noti. Entry';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Auto. Noti. Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field(Message; Rec.Message)
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field("Sending DateTime"; Rec."Sending DateTime")
                {
                }
                field(Seceiver; Rec.Seceiver)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

