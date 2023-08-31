page 50049 "DK_Land. Arch. Picture"
{
    AutoSplitKey = true;
    Caption = 'Land. Arch. Picture';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Land. Arch. Picture";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Upload Date"; Rec."Upload Date")
                {
                }
                field(Remark; Rec.Remark)
                {
                    ShowMandatory = true;
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
            part(Control17; "DK_Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50036),
                              "Source No." = FIELD("Contract No."),
                              "Source Line No." = FIELD("Line No.");
            }
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Cemetery No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec.Validate("Contract No.", ContractNo);
        Rec.Validate("Supervise No.", SuperviseNo);
        Rec.Validate("Cemetery Code", CemeteryNo);
    end;

    var
        ContractNo: Code[20];
        SuperviseNo: Code[20];
        CemeteryNo: Code[20];


    procedure SetParameter(var pContractNo: Code[20]; var pSuperviseNo: Code[20]; var pCemeteryNo: Code[20])
    begin
        ContractNo := pContractNo;
        SuperviseNo := pSuperviseNo;
        CemeteryNo := pCemeteryNo;
    end;
}

