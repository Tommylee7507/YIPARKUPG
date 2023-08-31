page 50218 "DK_Cemetery Digits2"
{
    Caption = 'Cemetery Digits';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "DK_Cemetery Digits";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CemeteryConfCode; CemeteryConfCode)
                {
                    Caption = 'Cemetery Conformation Code';
                    TableRelation = "DK_Cemetery Conformation";
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if CemeteryConfCode = '' then
                            Error('¬‹ ‘÷‘ñ—ŸŒŒÍ');

                        ValidateCemeteryConfCode(CemeteryConfCode);

                        SetFixedFilter;
                    end;
                }
                field(CemeteryConfName; CemeteryConfName)
                {
                    Caption = 'Cemetery Conformation Name';
                    TableRelation = "DK_Cemetery Conformation";

                    trigger OnValidate()
                    begin
                        CemeteryConfCode := CemeteryConf.GetCemeteryConfCode(CemeteryConfName);
                        ValidateCemeteryConfCode(CemeteryConfName);

                        SetFixedFilter;
                    end;
                }
            }
            repeater(Group)
            {
                field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
                {
                    Visible = false;
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                    Visible = false;
                }
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control5; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        _CemeteryConfor: Record "DK_Cemetery Conformation";
    begin

        if CemeteryConf.FindSet then begin
            CemeteryConfCode := CemeteryConf.Code;
            ValidateCemeteryConfCode(CemeteryConf.Code);
        end;

        SetFixedFilter;
    end;

    var
        CemeteryConfCode: Code[20];
        CemeteryConfName: Text[50];
        CemeteryConf: Record "DK_Cemetery Conformation";

    local procedure ValidateCemeteryConfCode(pCode: Code[20])
    begin

        if CemeteryConf.Get(pCode) then
            CemeteryConfName := CemeteryConf.Name
        else
            CemeteryConfName := '';
    end;

    local procedure SetFixedFilter()
    begin

        Rec.Reset;
        Rec.FilterGroup(2);
        Rec.SetRange("Cemetery Conf. Code", CemeteryConfCode);
        Rec.FilterGroup(0);

        CurrPage.Update;
    end;
}

