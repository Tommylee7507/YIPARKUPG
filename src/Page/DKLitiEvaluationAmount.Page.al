page 50223 "DK_Liti. Evaluation Amount"
{
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2005 :2020-07-09
    //   - Add field: Bond Type
    //   - Rec. Modify field: "Litigation Employee Name" - Visible False
    // 
    // #2152: 20200907
    //   - Add field: Elapsed Amount

    Caption = 'Litigation Evaluation Amount';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    ShowFilter = false;
    SourceTable = "DK_Litigaion Evaluation Amount";
    SourceTableView = SORTING(Date, "Admin. Expense Type", "Litigation Employee No.", "Litigation Evaluation");

    layout
    {
        area(content)
        {
            group("Filter")
            {
                Caption = 'Filter';
                field(DateFilter; DateFilter)
                {
                    Caption = 'ŸÀ —š•';

                    trigger OnValidate()
                    begin
                        SetDateFilter;

                        CurrPage.Update;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(Date; Rec.Date)
                {
                }
                field("Admin. Expense Type"; Rec."Admin. Expense Type")
                {
                }
                field("Litigation Employee No."; Rec."Litigation Employee No.")
                {
                    Visible = false;
                }
                field("Litigation Employee Name"; Rec."Litigation Employee Name")
                {
                    Visible = false;
                }
                field("Bond Type"; Rec."Bond Type")
                {
                }
                field("Litigation Evaluation"; Rec."Litigation Evaluation")
                {
                }
                field(TotalCount; Rec.TotalCount)
                {
                }
                field(TotalSize; Rec.TotalSize)
                {
                }
                field("Non-Pay. Admin Exp. Amount"; Rec."Non-Pay. Admin Exp. Amount")
                {
                }
                field("Elapsed Amount"; Rec."Elapsed Amount")
                {
                }
                field("Admin Exp. Amount"; Rec."Admin Exp. Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Data Create")
            {
                Caption = 'Data Create';
                Image = CreateDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _BatchDailyLitiEvaul: Codeunit "DK_Batch Daily Liti. Evaul.";
                begin
                    _BatchDailyLitiEvaul.Run;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        DateFilter := WorkDate - 1;
        SetDateFilter;
    end;

    var
        DateFilter: Date;
        MSG001: Label 'Please specify a Date Filter.';

    local procedure SetDateFilter()
    begin

        if DateFilter = 0D then
            Error(MSG001);

        Rec.SetRange(Date, DateFilter);
    end;
}

