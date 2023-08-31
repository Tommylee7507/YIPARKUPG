page 50200 "DK_Payment Refund Doc. List"
{
    // 
    // DK34: 20201201
    //   - Add Field: "Department Code", "Department Name"

    Caption = 'Payment Refund Doc. List';
    CardPageID = "DK_Payment Refund Document";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Payment Receipt Document";
    SourceTableView = SORTING("Document Type", "Document No.")
                      WHERE(Posted = CONST(false),
                            "Document Type" = CONST(Refund));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Request Refund Date"; Rec."Request Refund Date")
                {
                }
                field("Target Doc. No."; Rec."Target Doc. No.")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Refund Status"; Rec."Refund Status")
                {
                }
                field("Missing Contract"; Rec."Missing Contract")
                {
                }
                field("Before Document No."; Rec."Before Document No.")
                {
                }
                field("After Document No."; Rec."After Document No.")
                {
                }
                field("Contract Status"; Rec."Contract Status")
                {
                }
                field(Correction; Rec.Correction)
                {
                }
                field(Division; Rec.Division)
                {
                }
                field("Legal Amount"; Rec."Legal Amount")
                {
                }
                field("Advance Payment Amount"; Rec."Advance Payment Amount")
                {
                }
                field("Delay Interest Amount"; Rec."Delay Interest Amount")
                {
                }
                field("MTG Amount"; Rec."MTG Amount")
                {
                }
                field("Move The Grave"; Rec."Move The Grave")
                {
                }
                field("Reduction Amount"; Rec."Reduction Amount")
                {
                }
                field("Withdraw Mothed"; Rec."Withdraw Mothed")
                {
                }
                field("Litigation Ramark"; Rec."Litigation Ramark")
                {
                }
                field("Final Amount"; Rec."Final Amount")
                {
                }
                field("Litigation Employee Name"; Rec."Litigation Employee Name")
                {
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Visible = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Refund Reason"; Rec."Refund Reason")
                {
                }
                field("Refund Bank Code"; Rec."Refund Bank Code")
                {
                }
                field("Refund Bank Name"; Rec."Refund Bank Name")
                {
                }
                field("Refund Bank Account No."; Rec."Refund Bank Account No.")
                {
                }
                field("Refund Account Holder"; Rec."Refund Account Holder")
                {
                }
                field("Payment Request Date"; Rec."Payment Request Date")
                {
                }
                field("Payment Completion Date"; Rec."Payment Completion Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control32; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control31; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

