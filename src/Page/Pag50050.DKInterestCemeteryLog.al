page 50050 "DK_Interest Cemetery Log"
{
    Caption = 'DK_Interest Cemetery Log';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interest Cemetery Log";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cemetery No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cemetery Description field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Interest DateTime"; Rec."Interest DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Date/Time field.';
                }
            }
        }
    }
}
