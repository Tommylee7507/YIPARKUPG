page 50122 "DK_Field Work Sub Cat. Detail"
{
    Caption = 'Field Work Item';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Field Work Sub Cat. Detail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Used Assets No."; Rec."Used Assets No.")
                {

                    trigger OnValidate()
                    begin
                        Insert_CostAmount;
                    end;
                }
                field("Used Assets"; Rec."Used Assets")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(CostAmount; CostAmount)
                {
                    Caption = 'Cost Amount';
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Insert_CostAmount;
    end;

    var
        CostAmount: Decimal;

    local procedure Insert_CostAmount()
    begin
        Clear(CostAmount);

        case rec.Type of
            rec.Type::Item:
                begin
                    Rec.CalcFields("Item Cost Amount");
                    CostAmount := rec."Item Cost Amount";
                end;
            rec.Type::Vehicle:
                begin
                    Rec.CalcFields("Vehicle Cost Amount");
                    CostAmount := rec."Vehicle Cost Amount";
                end;
            rec.Type::WorkGroup:
                begin
                    Rec.CalcFields("Work Group Cost Amount");
                    CostAmount := rec."Work Group Cost Amount";
                end;
        end;
    end;
}

