page 50242 "DK_Schedule Run His. Factbox"
{
    Caption = 'Schedule Run History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Schedule Run History";
    SourceTableView = SORTING("Run Date", "Run Type")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Run Date"; Rec."Run Date")
                {
                    StyleExpr = StyleTxt;
                }
                field("Run Type"; Rec."Run Type")
                {
                    StyleExpr = StyleTxt;
                }
                field(Message; Rec.Message)
                {
                    StyleExpr = StyleTxt;
                }
                field("Run Date/Time"; Rec."Run Date/Time")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("No. of Run"; Rec."No. of Run")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Manual Run")
            {
                Caption = 'Manual Run';
                Image = "Action";
                action(UpdateDailyAdminExpense)
                {
                    ApplicationArea = Suite;
                    Caption = 'Update Daily Admin. Expense';
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        _BatchDailyAdminExpense: Codeunit "DK_Batch Daily Admin. Expense";
                    begin
                        _BatchDailyAdminExpense.Run;
                    end;
                }
                action(UpdateLitigationEvaluation)
                {
                    ApplicationArea = Suite;
                    Caption = '&Update Litigation Evaluation';
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        _BatchDailyLitiEvaul: Codeunit "DK_Batch Daily Liti. Evaul.";
                    begin
                        _BatchDailyLitiEvaul.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Run Date" = Today then
            StyleTxt := 'Attention'
        else
            StyleTxt := '';
    end;

    trigger OnInit()
    begin
        DalcDueDate := CalcDate('-10D', Today);
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Run Date", DalcDueDate, Today);
        Rec.FilterGroup(0);
        if Rec.FindFirst then;
    end;

    var
        DalcDueDate: Date;
        StyleTxt: Text[15];
}

