page 50092 "DK_Dev. Target Subform"
{
    AutoSplitKey = true;
    Caption = 'Development Target Subform';
    PageType = ListPart;
    SourceTable = "DK_Dev. Target Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field("No. of Detail"; Rec."No. of Detail")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                    Visible = false;
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Customer No. 2"; Rec."Customer No. 2")
                {
                    Visible = false;
                }
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                }
                field("Customer No. 3"; Rec."Customer No. 3")
                {
                    Visible = false;
                }
                field("Customer Name 3"; Rec."Customer Name 3")
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Multiple Selection")
            {
                AccessByPermission = TableData DK_Contract = R;
                Caption = 'Multiple Selection';
                Image = ShowSelected;

                trigger OnAction()
                begin
                    Rec.SelectMultipleContracts;
                end;
            }
            action("Create Counsel General")
            {
                Caption = 'Create Counsel General';
                Image = Card;
                Promoted = true;
                RunObject = Page "DK_Counsel General";
                RunPageLink = "Contract No." = FIELD("Contract No."),
                              Type = CONST(General),
                              "Dev. Target Doc. No." = FIELD("Document No."),
                              "Dev. Target Doc. Line No." = FIELD("Line No.");
                RunPageMode = Create;

                trigger OnAction()
                var
                    _CounselGeneral: Page "DK_Counsel General";
                    _CounselHistory: Record "DK_Counsel History";
                begin
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("No. of Detail");
    end;
}

