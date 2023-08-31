page 50047 "DK_Cemetery Detail Factbox"
{
    Caption = 'Cemetery Detail';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = DK_Cemetery;

    layout
    {
        area(content)
        {
            field("Cemetery Code"; Rec."Cemetery Code")
            {
                TableRelation = DK_Cemetery WHERE("Cemetery Code" = FIELD("Cemetery Code"));
            }
            field("Cemetery No."; Rec."Cemetery No.")
            {
            }
            field(Class; Rec.Class)
            {
            }
            field("Estate Name"; Rec."Estate Name")
            {
            }
            field("Estate Type"; Rec."Estate Type")
            {
            }
            field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
            {
            }
            field("Cemetery Option Name"; Rec."Cemetery Option Name")
            {
            }
            field("Unit Price Type Name"; Rec."Unit Price Type Name")
            {
            }
            field("Admin. Expense Method"; Rec."Admin. Expense Method")
            {
            }
            field(Size; Rec.Size)
            {
            }
            field("Size 2"; Rec."Size 2")
            {
            }
            field("Corpse Size"; Rec."Corpse Size")
            {
            }
            field("Landscape Architecture"; Rec."Landscape Architecture")
            {
            }
            field(Status; Rec.Status)
            {
            }
            field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
            {
            }
            field("Visual Zone"; Rec."Visual Zone")
            {
            }
            field("Contract No."; Rec."Contract No.")
            {
            }
            field("No. of Corpse"; Rec."No. of Corpse")
            {
            }
        }
    }

    actions
    {
    }
}

