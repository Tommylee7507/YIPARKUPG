page 50151 "DK_Counsel General"
{
    Caption = 'Counsel General';
    DelayedInsert = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Counsel History";
    SourceTableView = WHERE(Type = CONST(General));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Date; Rec.Date)
                {
                    Editable = false;
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
                    ShowMandatory = true;
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    ShowMandatory = true;
                }
                group(Control18)
                {
                    ShowCaption = false;
                    field("Counsel Level 1"; Rec."Counsel Level 1")
                    {
                        ShowMandatory = true;
                    }
                    field("Counsel Level Code 2"; Rec."Counsel Level Code 2")
                    {
                        Importance = Additional;
                    }
                    field("Counsel Level Name 2"; Rec."Counsel Level Name 2")
                    {
                        ShowMandatory = true;
                    }
                }
                field("Result Process"; Rec."Result Process")
                {
                }
            }
            group(Content)
            {
                Caption = 'Content';
                group("Counsel Content")
                {
                    Caption = 'Counsel Content';
                    field(Control13; Rec."Counsel Content")
                    {
                        MultiLine = true;
                        ShowCaption = false;
                        ShowMandatory = true;
                    }
                }
                group("Process Content")
                {
                    Caption = 'Process Content';
                    field(Control15; Rec."Process Content")
                    {
                        MultiLine = true;
                        ShowCaption = false;
                        ShowMandatory = true;
                    }
                    field("Issue of membership"; Rec."Issue of membership")
                    {
                    }
                }
            }
            group("Development Target")
            {
                Caption = 'Development Target';
                field("Dev. Target Doc. No."; Rec."Dev. Target Doc. No.")
                {
                }
                field("Dev. Target Doc. Line No."; Rec."Dev. Target Doc. Line No.")
                {
                    BlankZero = true;
                }
            }
            group(Control40)
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
            part("Customer Request"; "DK_Customer Request Fact. List")
            {
                Caption = 'Customer Request';
                SubPageLink = "Contract No." = FIELD("Contract No.");
            }
            part(Control34; "DK_Counsel General Factbox")
            {
                SubPageLink = "Contract No." = FIELD("Contract No."), Type = FIELD(Type), "Delete Row" = CONST(false);
            }
            part(Control19; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control30; Notes)
            {
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
                Enabled = Rec."Result Process" <> Rec."Result Process"::Receipt;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetReceipt;
                end;
            }
            action(Processing)
            {
                Caption = 'Processing';
                Enabled = Rec."Result Process" <> Rec."Result Process"::Processing;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetProcessig;

                    Message(MSG001, Rec.FieldCaption("Result Process"), Rec."Result Process"::Processing);
                end;
            }
            action(Completed)
            {
                Caption = 'Completed';
                Enabled = Rec."Result Process" = Rec."Result Process"::Processing;
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetCompleted;

                    Message(MSG001, Rec.FieldCaption("Result Process"), Rec."Result Process"::Completed);
                end;
            }
            group(Action41)
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
    begin
        Rec.Date := Today;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
        /*
        Rec.Validate("Contract No.", NewContractNo);
        Type := NewType;
        "Dev. Target Doc. No." := NewDevTargetNo;
        "Dev. Target Doc. Line No." := NewDevTargetLineNo;
        */

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec."Line No." <> 0) and (Rec.idx = 0) then begin
            if Rec."Result Process" = Rec."Result Process"::Receipt then begin
                if Rec."Employee Name" = '' then
                    Error(MSG002, Rec.FieldCaption("Employee Name"));
                if Rec."Contract No." = '' then
                    Error(MSG002, Rec.FieldCaption("Contract No."));
                if Rec."Counsel Level 1" = Rec."Counsel Level 1"::Blank then
                    Error(MSG002, Rec.FieldCaption("Counsel Level 1"));
                if Rec."Counsel Level Name 2" = '' then
                    Error(MSG002, Rec.FieldCaption("Counsel Level Name 2"));
                if Rec."Counsel Content" = '' then
                    Error(MSG002, Rec.FieldCaption("Counsel Content"));
                if Rec."Process Content" = '' then
                    Error(MSG002, Rec.FieldCaption("Process Content"));
            end;
        end;
    end;

    var
        MSG001: Label 'The %1 has been Rec. Modify to a %2.';
        MSG002: Label '%1 is a required input value. You cannot exit this window.';
        NewContractNo: Code[20];
        NewType: Option;
        NewDevTargetNo: Code[20];
        NewDevTargetLineNo: Integer;

    local procedure CloseValidateValue()
    begin
    end;


    procedure SetParameter(pContractNo: Code[20]; pType: Option; pDevTargetNo: Code[20]; pDevTargetLineNo: Integer)
    begin

        NewContractNo := pContractNo;
        NewType := pType;
        NewDevTargetNo := pDevTargetNo;
        NewDevTargetLineNo := pDevTargetLineNo;
    end;
}

