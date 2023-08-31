page 50268 "DK_Change Log Entry"
{
    // 
    // #2194: 20201005
    //   - Create
    Caption = 'Change Log Entry';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Change Log Entry";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Date and Time"; Rec."Date and Time")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Table No."; Rec."Table No.")
                {
                    Lookup = false;
                    Visible = false;
                }
                field("Table Caption"; Rec."Table Caption")
                {
                }
                field("Field No."; Rec."Field No.")
                {
                    Lookup = false;
                    Visible = false;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                }
                field("Type of Change"; Rec."Type of Change")
                {
                }
                field("Old Value Local"; Rec.GetLocalOldValue)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Old Value (Local)';
                    ToolTip = 'Specifies the value that the field had before a user made changes to the field.';
                }
                field("New Value Local"; Rec.GetLocalNewValue)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Value (Local)';
                    ToolTip = 'Specifies the value that the field had after a user made changes to the field.';
                }
            }
        }
    }

    actions
    {
    }
}

