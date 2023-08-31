page 50186 "DK_Liti. Law. History"
{
    Caption = 'Litigation Lawsuit History';
    DelayedInsert = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Litigation Lawsuit History";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Date; Rec.Date)
                {
                    ShowMandatory = true;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ShowMandatory = true;
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Importance = Additional;
                    Lookup = false;
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    ShowMandatory = true;
                }
                field("Lawsuit Status"; Rec."Lawsuit Status")
                {
                    ShowMandatory = true;
                }
                field("Lawsuit Method"; Rec."Lawsuit Method")
                {
                }
                field("Lawsuit Type"; Rec."Lawsuit Type")
                {
                    ShowMandatory = true;
                }
                field("Process Content"; Rec."Process Content")
                {
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                }
            }
            group(Control33)
            {
                Caption = 'Request Delete';
                field("Request Del"; Rec."Request Del")
                {
                }
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
                {
                }
            }
            group(Information)
            {
                Caption = 'Information';
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
            systempart(Control16; Notes)
            {
            }
            part(Control23; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Enabled = Rec.Status <> Rec.Status::Open;
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
            action(Release)
            {
                Caption = 'Release';
                Enabled = Rec.Status <> Rec.Status::Release;
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
            group(Action29)
            {
                action("Request Delete")
                {
                    Caption = 'Request Delete';
                    Image = DeleteAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."Contract No." <> '' then begin
                            Rec.Validate("Request Del", true);
                            Rec.Modify;
                        end;
                    end;
                }
                action("Cancel Request Delete")
                {
                    Caption = 'Cancel Request Delete';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."Contract No." <> '' then begin
                            Rec.Validate("Request Del", false);
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
        _LitigationLawsuitHistory: Record "DK_Litigation Lawsuit History";
    begin

        Rec.Date := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));

        _LitigationLawsuitHistory.Reset;
        _LitigationLawsuitHistory.SetRange("Contract No.", Rec."Contract No.");
        if _LitigationLawsuitHistory.FindLast then
            Rec."Line No." := _LitigationLawsuitHistory."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec."Line No." <> 0) then begin

            if Rec.Date = 0D then
                Error(MSG001, Rec.FieldCaption(Date));

            if Rec.Date > Today then
                Error(MSG002, Rec.FieldCaption(Date));

            if Rec."Employee Name" = '' then
                Error(MSG001, Rec.FieldCaption("Employee Name"));
            if Rec."Contract No." = '' then
                Error(MSG001, Rec.FieldCaption("Contract No."));
            if Rec."Lawsuit Type" = '' then
                Error(MSG001, Rec.FieldCaption("Lawsuit Type"));
            if Rec."Process Content" = '' then
                Error(MSG001, Rec.FieldCaption("Process Content"));

        end;
    end;

    var
        MSG001: Label '%1 is a required input value. You cannot exit this window.';
        MSG002: Label 'You cannot specify a date in the future.';
}

