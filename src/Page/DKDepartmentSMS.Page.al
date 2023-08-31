page 50081 "DK_Department SMS"
{
    Caption = 'Department SMS';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("No. of SMS"; Rec."No. of SMS")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("SMS Message")
            {
                Caption = 'SMS Message';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_SMS List";
                RunPageLink = "Department Code" = FIELD(Code);
            }
        }
    }

    var
        DeptCode: Code[20];
        DeptName: Text[50];
}

