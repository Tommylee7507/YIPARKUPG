page 50254 "DK_Deleted Counsel General"
{
    // 
    // Error01: 20201006
    //   - Rec. Modify Trigger: OnQueryClosePage

    Caption = 'Deleted Counsel General';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Delete Row"; Rec."Delete Row")
                {
                }
                field("Delete DateTime"; Rec."Delete DateTime")
                {
                }
                field("Delete Person"; Rec."Delete Person")
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
            group("Request Delete")
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
        /*
        IF ("Line No." <> 0) AND (idx = 0) THEN BEGIN
        
          IF "Employee Name" = '' THEN
            ERROR(MSG002, FIELDCAPTION("Employee Name"));
          IF "Contract No." = '' THEN
            ERROR(MSG002, FIELDCAPTION("Contract No."));
          IF "Counsel Level 1" = "Counsel Level 1"::Blank THEN
            ERROR(MSG002, FIELDCAPTION("Counsel Level 1"));
          IF "Counsel Level Name 2" = '' THEN
            ERROR(MSG002, FIELDCAPTION("Counsel Level Name 2"));
          IF "Counsel Content" = '' THEN
            ERROR(MSG002, FIELDCAPTION("Counsel Content"));
          IF "Result Process" = "Result Process"::Completed THEN BEGIN
            IF "Process Content" = '' THEN
              ERROR(MSG002, FIELDCAPTION("Process Content"));
          END;
        END;
        */

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

