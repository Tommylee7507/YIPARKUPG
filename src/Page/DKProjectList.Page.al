page 50056 "DK_Project List"
{
    Caption = 'Project List';
    CardPageID = DK_Project;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Project Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field(ProcessRate; ProcessRate)
                {
                    Caption = 'Process Rate(%)';
                    ExtendedDatatype = Ratio;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                }
                field("Balance Amount"; Rec."Balance Amount")
                {
                }
                field("Project Date From"; Rec."Project Date From")
                {
                }
                field("Project Date To"; Rec."Project Date To")
                {
                }
                field("Short Memo"; Rec."Short Memo")
                {
                    Caption = 'Memo';
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Status; Rec.Status)
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

    trigger OnAfterGetCurrRecord()
    begin
        CalcProcessRate(Rec."Budget Amount", Rec."Actual Amount");
    end;

    var
        ProcessRate: Decimal;

    local procedure CalcProcessRate(pBudget: Decimal; pActual: Decimal)
    begin

        if pBudget = 0 then
            ProcessRate := 0
        else
            ProcessRate := Round((pActual / pBudget) * 10000, 1, '=');
    end;
}

