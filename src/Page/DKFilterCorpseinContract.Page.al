page 50241 "DK_Filter Corpse in Contract"
{
    Caption = 'Filter Corpse in Contract';
    DataCaptionExpression = '';
    PageType = StandardDialog;
    SourceTable = DK_Corpse;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            field(CoprseNameFilter; CoprseNameFilter)
            {
                Caption = 'Corpse Name';

                trigger OnValidate()
                begin
                    if CoprseNameFilter = '' then begin
                        Rec.Name := '';
                    end else begin
                        Rec.Name := CoprseNameFilter;
                    end;
                    Rec.Modify(false);
                end;
            }
        }
    }

    actions
    {
    }

    var
        CoprseNameFilter: Text[30];
}

