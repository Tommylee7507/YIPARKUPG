page 50187 "DK_Interest Cemetery Log2"
{
    Caption = 'Interest Cemetery Log2';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Interest Cemetery Log";
    SourceTableView = SORTING("Cemetery Code", "Line No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Interest DateTime"; Rec."Interest DateTime")
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
        if Rec.FindFirst then;
    end;
}

