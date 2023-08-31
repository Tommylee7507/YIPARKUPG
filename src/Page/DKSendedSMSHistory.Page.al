page 50148 "DK_Sended SMS History"
{
    Caption = 'Sended SMS History';
    CardPageID = "DK_Sended SMS History Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Sended SMS History";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Sending Date"; Rec."Sending Date")
                {
                }
                field("Sending Time"; Rec."Sending Time")
                {
                }
                field(Status; Rec.Status)
                {
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Report Date"; Rec."Report Date")
                {
                }
                field("Result Status Code"; Rec."Result Status Code")
                {
                    Visible = false;
                }
                field("Result Status"; Rec."Result Status")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("From Phone No."; Rec."From Phone No.")
                {
                }
                field("To Phone No."; Rec."To Phone No.")
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Short Message"; Rec."Short Message")
                {
                    Caption = 'SMSt Message';
                }
                field("Auto Sending"; Rec."Auto Sending")
                {
                }
                field("Change Send"; Rec."Change Send")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Biz Talk Template No."; Rec."Biz Talk Template No.")
                {
                }
                field("Contract No."; Rec."Contract No.")
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
            systempart(Control24; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Result")
            {
                Caption = 'Update Result';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _BatchSMSSending: Codeunit "DK_Batch SMS Sending";
                begin

                    Clear(_BatchSMSSending);
                    _BatchSMSSending.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Result Status");
    end;

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

