page 50244 "DK_Customer Cer. His. List"
{
    // 
    // *DK34 : 20201020
    //   - Rec. Modify Action : Action13
    //   - Rec. Modify Page Caption: ˜ˆ°‘ã ’ž ˆ±‡Ÿ -> ˜ˆ°‘ã ‰È€Ã ˆ±‡Ÿ

    Caption = 'Customer Cer. His. List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Customer Certficate History";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending)
                      WHERE(Apprval = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Contract Status"; Rec."Contract Status")
                {
                }
                field("Req. Employee No."; Rec."Req. Employee No.")
                {
                }
                field("Req. Employee Name"; Rec."Req. Employee Name")
                {
                }
                field("Member. Request Date"; Rec."Member. Request Date")
                {
                }
                field("Allow Employee No."; Rec."Allow Employee No.")
                {
                }
                field("Allow Employee Name"; Rec."Allow Employee Name")
                {
                }
                field("Allow Mem. Printing DateTime"; Rec."Allow Mem. Printing DateTime")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                }
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Approval Cancel")
            {
                Caption = 'Approval Cancel';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    _CustomerCertficateHistory: Codeunit "DK_Customer Certficate History";
                begin
                    /*
                    IF NOT CONFIRM(MSG001,FALSE) THEN EXIT;
                    _CustomerCertficateHistory.ApprovalCancel(Rec);
                    */

                end;
            }
        }
    }

    var
        MSG001: Label 'If you cancel, the document number will be deleted. Would you like to go on?';
}

