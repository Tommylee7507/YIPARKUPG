page 50214 "DK_Payment Methods"
{
    // #DK36: 20211016
    //   - Add Field: "PG Code"

    Caption = 'Payment Methods';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "DK_Payment Method";

    layout
    {
        area(content)
        {
            group(Control9)
            {
                ShowCaption = false;
                field(TypeFilter; TypeFilter)
                {
                    Caption = 'Payment Mothed Type';
                    OptionCaption = 'Online Card,Card,Giro';

                    trigger OnValidate()
                    begin
                        SetRecFilters;
                    end;
                }
            }
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("PG Code"; Rec."PG Code")
                {
                    Enabled = bPGCode;
                    Visible = bPGCode;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetRecFilters;
    end;

    var
        TypeFilter: Option Online,Card,Giro;
        bPGCode: Boolean;

    procedure SetRecFilters()
    begin
        if TypeFilter = TypeFilter::Online then
            bPGCode := true
        else
            bPGCode := false;

        Rec.SetRange(Type, TypeFilter);
        CurrPage.Update(false);
    end;
}

