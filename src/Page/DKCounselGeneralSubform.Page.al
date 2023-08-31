page 50154 "DK_Counsel General Subform"
{
    Caption = 'Counsel General';
    CardPageID = "DK_Counsel General";
    Editable = false;
    PageType = ListPart;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Type, Date, "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE("Delete Row" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Result Process"; Rec."Result Process")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Counsel Level 1"; Rec."Counsel Level 1")
                {
                }
                field("Counsel Level Code 2"; Rec."Counsel Level Code 2")
                {
                }
                field("Counsel Level Name 2"; Rec."Counsel Level Name 2")
                {
                }
                field("Counsel Content"; Rec."Counsel Content")
                {
                }
                field("Process Content"; Rec."Process Content")
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

