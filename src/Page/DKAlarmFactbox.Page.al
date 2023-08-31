page 50165 "DK_Alarm Factbox"
{
    Caption = 'Alarm';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = DK_Alarm;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source No."; Rec."Source No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(Type; rEC.Type)
                {
                }
                field("Sending Date"; Rec."Sending Date")
                {
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

