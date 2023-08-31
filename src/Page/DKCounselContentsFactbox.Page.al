page 50259 "DK_Counsel Contents Factbox"
{
    Caption = 'Counsel Contents';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "DK_Counsel History";

    layout
    {
        area(content)
        {
            group("Counsel Content")
            {
                Caption = 'Counsel Content';
                field(Control2; Rec."Counsel Content")
                {
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
            group("Process Content")
            {
                Caption = 'Process Content';
                Visible = Rec.Type = Rec.Type::General;
                field(Control3; Rec."Process Content")
                {
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
    }
}

