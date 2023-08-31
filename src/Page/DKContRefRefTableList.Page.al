page 50066 "DK_Cont. Ref. Ref. Table List"
{
    // *DK33 : 20200730
    //   - Add Field : Type

    Caption = 'Contract refund Reference Table List';
    CardPageID = "DK_Cont. Ref. Ref. Table";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Cont. Refund Ref. Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Estate Type"; Rec."Estate Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

