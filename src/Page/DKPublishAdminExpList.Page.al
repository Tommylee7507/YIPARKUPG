page 50138 "DK_Publish Admin. Exp. List"
{
    Caption = 'Publish Admin. Expense Document List';
    CardPageID = "DK_Publish Admin. Exp. Doc.";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Publish Admin. Expense Doc.";
    SourceTableView = SORTING("Document No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("From Date"; Rec."From Date")
                {
                    Editable = false;
                }
                field("To Date"; Rec."To Date")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("No. of Line"; Rec."No. of Line")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("No. of Check Cust. Infor."; Rec."No. of Check Cust. Infor.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("No. of UnCheck Cust. Infor."; Rec."No. of UnCheck Cust. Infor.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("General Amount"; Rec."General Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
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
            systempart(Control18; Notes)
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

