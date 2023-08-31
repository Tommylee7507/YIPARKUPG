page 50019 DK_Department
{
    Caption = 'Department';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Department;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Department Main Cat. Name"; Rec."Department Main Cat. Name")
                {
                }
                field(Litigation; Rec.Litigation)
                {
                }
                field(Sales; Rec.Sales)
                {
                }
                field(ParkManager; Rec.ParkManager)
                {
                }
                field(Blocked; Rec.Blocked)
                {
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
}

