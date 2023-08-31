page 50306 "DK_Interlink Fr. with CRM Log"
{
    Caption = 'Interlink Fr. with CRM Log';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interlink Fr. with CRM Log";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Data Type"; Rec."Data Type")
                {
                }
                field("Data Date"; Rec."Data Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Relation No."; Rec."Relation No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field(Relation; Rec.Relation)
                {
                }
                field("Record Del"; Rec."Record Del")
                {
                }
                field("Applied Date"; Rec."Applied Date")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
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

