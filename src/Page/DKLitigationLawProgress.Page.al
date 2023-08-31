page 50278 "DK_Litigation Law Progress"
{
    // 
    // DK34: 20201105
    //   - Create

    Caption = 'Litigation Law Progress';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Litigation Law Progress";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Progress Status"; Rec."Progress Status")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Cemetery Status"; Rec."Cemetery Status")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                }
                field("Litigation Evaluation"; Rec."Litigation Evaluation")
                {
                }
                field("General Expiration Date"; Rec."General Expiration Date")
                {
                }
                field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
                {
                }
                field("Lawsuit Reception Date"; Rec."Lawsuit Reception Date")
                {
                }
                field("Lawsuit Party"; Rec."Lawsuit Party")
                {
                }
                field("Lawsuit Case No."; Rec."Lawsuit Case No.")
                {
                }
                field("Lawsuit Value"; Rec."Lawsuit Value")
                {
                }
                field("General Lawsuit Value"; Rec."General Lawsuit Value")
                {
                }
                field("Land. Arc. Lawsuit Value"; Rec."Land. Arc. Lawsuit Value")
                {
                }
                field("Lawsuit Val. Manual"; Rec."Lawsuit Val. Manual")
                {
                }
                field("Fixed Date Time"; Rec."Fixed Date Time")
                {
                }
                field("Fixed Date Type"; Rec."Fixed Date Type")
                {
                }
                field("Winning Type"; Rec."Winning Type")
                {
                }
                field("Loss Reasons"; Rec."Loss Reasons")
                {
                }
                field("Lawsuit Future Dir. Code"; Rec."Lawsuit Future Dir. Code")
                {
                }
                field("Lawsuit Future Dir. Name"; Rec."Lawsuit Future Dir. Name")
                {
                }
                field("Deposit Reception Date"; Rec."Deposit Reception Date")
                {
                }
                field("Deposit Party"; Rec."Deposit Party")
                {
                }
                field("Deposit Case No."; Rec."Deposit Case No.")
                {
                }
                field("Deposit Quotation Code"; Rec."Deposit Quotation Code")
                {
                }
                field("Deposit Quotation Name"; Rec."Deposit Quotation Name")
                {
                }
                field("Deposit Future Dir. Code"; Rec."Deposit Future Dir. Code")
                {
                }
                field("Deposit Future Dir. Name"; Rec."Deposit Future Dir. Name")
                {
                }
                field("Insurance Reception Date"; Rec."Insurance Reception Date")
                {
                }
                field("Insurance Party"; Rec."Insurance Party")
                {
                }
                field("Insurance Case No."; Rec."Insurance Case No.")
                {
                }
                field("Insurance Quotation Code"; Rec."Insurance Quotation Code")
                {
                }
                field("Insurance Quotation Name"; Rec."Insurance Quotation Name")
                {
                }
                field("Insurance Future Dir. Code"; Rec."Insurance Future Dir. Code")
                {
                }
                field("Insurance Future Dir. Name"; Rec."Insurance Future Dir. Name")
                {
                }
                field("Corporeal Reception Date"; Rec."Corporeal Reception Date")
                {
                }
                field("Corporeal Party"; Rec."Corporeal Party")
                {
                }
                field("Corporeal Case No."; Rec."Corporeal Case No.")
                {
                }
                field("Corporeal Quotation Code"; Rec."Corporeal Quotation Code")
                {
                }
                field("Corporeal Quotation Name"; Rec."Corporeal Quotation Name")
                {
                }
                field("Corporeal Future Dir. Code"; Rec."Corporeal Future Dir. Code")
                {
                }
                field("Corporeal Future Dir. Name"; Rec."Corporeal Future Dir. Name")
                {
                }
                field("Obligation Reception Date"; Rec."Obligation Reception Date")
                {
                }
                field("Obligation Party"; Rec."Obligation Party")
                {
                }
                field("Obligation Case No."; Rec."Obligation Case No.")
                {
                }
                field("Obligation Quotation Code"; Rec."Obligation Quotation Code")
                {
                }
                field("Obligation Quotation Name"; Rec."Obligation Quotation Name")
                {
                }
                field("Obligation Future Dir. Code"; Rec."Obligation Future Dir. Code")
                {
                }
                field("Obligation Future Dir. Name"; Rec."Obligation Future Dir. Name")
                {
                }
                field("Completion Status"; Rec."Completion Status")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
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
            systempart(Control63; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action65)
            {
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        Rec.SetRelease;
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        Rec.SetReOpen;
                    end;
                }
            }
        }
    }

    var
        MSG001: Label 'You can not have a date that is less than or equal to the current %1. %1:%2';
        MSG002: Label 'Admin. Expense cannot be calculated!';
        MSG003: Label 'Do you really want to calculate?';
}

