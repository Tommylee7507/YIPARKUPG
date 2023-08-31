page 50314 "DK_Cust Req honorstone List"
{
    Caption = 'Customer Requests List(HT)';
    CardPageID = "DK_Customer Request Card HT";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    RefreshOnActivate = false;
    SourceTable = "DK_Customer Requests";
    SourceTableView = SORTING("Receipt Date")
                      WHERE(Status = FILTER(<> Complete & <> Impossible),
                            "Service Type" = CONST("1"));

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
            systempart(Control41; Notes)
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

        if CHECKUSER then;
    end;

    local procedure CHECKUSER(): Boolean
    var
        _UserSetup: Record "User Setup";
        ERR001: Label '‹ÏÔÀ Œ‚‘ñí …Ø‡Ÿ…˜ ‹ÏÔÀí Ž–„³„Ÿ„¾. ýˆ«Àí¯ ‰«— —ŸŒŒÍ. ';
        ERR002: Label '‹ÏÔÀ Œ‚‘ñ ×„ Í“‹‹Ï—¸ - ýˆ«– í “Œ•í …—ŽØ ´‘÷ Žš„Ÿ„¾. ýˆ«Àí¯ ‰«— —ŸŒŒÍ. ';
        ERR003: Label '‹ÏÔÀ Œ‚‘ñ ×„ Í“‹‹Ï—¸ - ×„‘÷° í “Œ•í …—ŽØ ´‘÷ Žš„Ÿ„¾. ýˆ«Àí¯ ‰«— —ŸŒŒÍ. ';
    begin

        if _UserSetup.Get(UserId) then begin
            if _UserSetup."DK_Cust Req B" = false then begin
                Error(ERR003);
            end;
        end else begin
            Error(ERR001);
        end;

        exit(true);
    end;
}

