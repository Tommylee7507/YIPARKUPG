page 50110 "DK_Move The Grave List"
{
    // 
    // DK34: 20201130
    //   - Add Field: "Conversion Agency"

    Caption = 'Move The Grave List';
    CardPageID = "DK_Move The Grave";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Move The Grave";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Completion Date"; Rec."Completion Date")
                {
                }
                field(Service; Rec.Service)
                {
                }
                field("Move Type"; Rec."Move Type")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Contact"; Rec."Cust. Contact")
                {
                }
                field("Cust. E-mail"; Rec."Cust. E-mail")
                {
                }
                field("Cemetery Digits"; Rec."Cemetery Digits")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field(Religion; Rec.Religion)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Conversion Agency"; Rec."Conversion Agency")
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
            systempart(Control30; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

