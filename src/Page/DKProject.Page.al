page 50057 DK_Project
{
    Caption = 'Project';
    PageType = Document;
    SourceTable = "DK_Project Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control30)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                        Importance = Additional;

                        trigger OnAssistEdit()
                        begin
                            Rec.AssistEdit(Rec);
                        end;
                    }
                    field("Project Name"; Rec."Project Name")
                    {
                    }
                    field("Project Date From"; Rec."Project Date From")
                    {
                    }
                    field("Project Date To"; Rec."Project Date To")
                    {
                    }
                    field("Employee No."; Rec."Employee No.")
                    {
                        Importance = Additional;
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                    }
                    field("Budget Amount"; Rec."Budget Amount")
                    {

                        trigger OnDrillDown()
                        var
                            _ProjectBudgetRec: Record "DK_Project Budget";
                            _ProjectBudget: Page "DK_Project Budget";
                        begin

                            Clear(_ProjectBudget);

                            _ProjectBudgetRec.Reset;
                            _ProjectBudgetRec.SetRange("Project No.", Rec."No.");

                            _ProjectBudget.LookupMode(true);
                            _ProjectBudget.SetRecord(_ProjectBudgetRec);
                            _ProjectBudget.SetTableView(_ProjectBudgetRec);
                            _ProjectBudget.RunModal;
                        end;
                    }
                    field("Actual Amount"; Rec."Actual Amount")
                    {
                    }
                    field("Balance Amount"; Rec."Balance Amount")
                    {
                    }
                    field(ProcessRate; ProcessRate)
                    {
                        Caption = 'Process Rate(%)';
                        //The DecimalPlaces property is only supported on fields of type Decimal.
                        //DecimalPlaces = 0:0;
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                    }
                }
                group(Memo)
                {
                    Caption = 'Memo';
                    field(WorkMemo; WorkMemo)
                    {
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.SetWorkMemo(WorkMemo);
                        end;
                    }
                }
            }
            part(Control18; "DK_Project Line")
            {
                SubPageLink = "Project No." = FIELD("No.");
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Project Budget")
            {
                Caption = 'Project Budget';
                Image = LedgerBudget;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Project Budget";
                RunPageLink = "Project No." = FIELD("No.");
            }
            group(Action26)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.SetReleased;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.SetReOpen;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcProcessRate(Rec."Budget Amount", Rec."Actual Amount");
    end;

    trigger OnAfterGetRecord()
    begin
        WorkMemo := Rec.GetWorkMemo;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    var
        ProcessRate: Integer;
        WorkMemo: Text;

    local procedure CalcProcessRate(pBudget: Decimal; pActual: Decimal)
    begin

        if pBudget = 0 then
            ProcessRate := 0
        else
            ProcessRate := Round((pActual / pBudget) * 100, 1, '=');
    end;
}

