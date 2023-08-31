page 50124 "DK_Cem. Services List"
{
    Caption = 'Cemetery Services List';
    CardPageID = "DK_Cem. Services";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Cemetery Services";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(<> Complete));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Work Date"; Rec."Work Date")
                {
                }
                field("Desired Date"; Rec."Desired Date")
                {
                }
                field("SMS Send Date"; Rec."SMS Send Date")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Religion; Rec.Religion)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Unit; Rec.Unit)
                {
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Receipt Amount Date"; Rec."Receipt Amount Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Corpse Name"; Rec."Corpse Name")
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field("Death Date"; Rec."Death Date")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
                {
                }
                field("Payment Rec. Doc. No."; Rec."Payment Rec. Doc. No.")
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
            part(Control20; "DK_Contract Detail Factbox")
            {
                // SubPageLink = "No." = FIELD("Contract No.");////zzz
            }
            systempart(Control30; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

