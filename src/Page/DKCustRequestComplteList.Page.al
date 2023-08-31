page 50246 "DK_Cust. Request Complte List"
{
    Caption = 'Customer Request Complte List';
    CardPageID = "DK_Cust. Request Complete Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Customer Requests";
    SourceTableView = SORTING("Receipt Date")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Complete | Impossible));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Work Division"; Rec."Work Division")
                {
                }
                field("Customer Status"; Rec."Customer Status")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee name"; Rec."Employee name")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cust. E-mail"; Rec."Cust. E-mail")
                {
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("Appl. Phone No."; Rec."Appl. Phone No.")
                {
                }
                field("Appl. E-mail"; Rec."Appl. E-mail")
                {
                }
                field("Relationship With Cust."; Rec."Relationship With Cust.")
                {
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Receipt Method"; Rec."Receipt Method")
                {
                }
                field("Receipt Division"; Rec."Receipt Division")
                {
                }
                field("Receipt Contents"; Rec."Receipt Contents")
                {
                }
                field("Process No."; Rec."Process No.")
                {
                }
                field("Process Date"; Rec."Process Date")
                {
                }
                field("Feedback Date"; Rec."Feedback Date")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field(Lawn; Rec.Lawn)
                {
                }
                field("Work Time Spent"; Rec."Work Time Spent")
                {
                }
                field("Work Indicator"; Rec."Work Indicator")
                {
                }
                field("Work Manager"; Rec."Work Manager")
                {
                }
                field("Work Group"; Rec."Work Group")
                {
                }
                field("Work Personnel"; Rec."Work Personnel")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Email Status"; Rec."Email Status")
                {
                }
                field("Per. Info. Aggreement"; Rec."Per. Info. Aggreement")
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
            systempart(Control57; Notes)
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

