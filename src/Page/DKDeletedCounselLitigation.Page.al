page 50255 "DK_Deleted Counsel Litigation"
{
    // 
    // #2044 : 2020-07-23
    //   - Rec. Modify Page Caption : ‹Ð‘ª…˜ ŒÁ‰½ ‹Ý„Ì -> ‹Ð‘ª…˜ ×„ ‹Ý„Ì
    // 
    // Error01: 20201006
    //   - Rec. Modify Trigger: OnQueryClosePage

    Caption = 'Deleted Counsel Litigtion';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Counsel History";
    SourceTableView = WHERE(Type = CONST(Litigation));

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
                field("Counsel Time"; Rec."Counsel Time")
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
                    ShowMandatory = true;
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
                group(Control13)
                {
                    ShowCaption = false;
                    field("Litigation Type"; Rec."Litigation Type")
                    {
                        ShowMandatory = true;
                    }
                    field("Contact Method"; Rec."Contact Method")
                    {
                        ShowMandatory = true;
                    }
                    field("Counsel Target"; Rec."Counsel Target")
                    {
                        ShowMandatory = true;
                    }
                }
                field("Deposit Plan Date"; Rec."Deposit Plan Date")
                {
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
                    field(WorkLitigationContent; WorkLitigationContent)
                    {
                        Editable = NOT EditWorkLitiCon;
                        MultiLine = true;
                        ShowCaption = false;
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            if Rec."Result Process" <> Rec."Result Process"::Receipt then
                                Error(MSG002);

                            Rec.SetWorkLitigationContent(WorkLitigationContent);
                        end;
                    }
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
            part(Control14; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control27; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        WorkLitigationContent := Rec.GetWorkLitigationContent;

        if Rec."Result Process" = Rec."Result Process"::Receipt then
            EditWorkLitiCon := false
        else
            EditWorkLitiCon := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        Rec.Date := Today;
        Rec."Counsel Time" := Time;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        /*
        IF ("Line No." <> 0) AND (idx = 0) THEN BEGIN
        
          IF "Counsel Time" = 0T THEN
            ERROR(MSG003, FIELDCAPTION("Counsel Time"));
          IF "Employee Name" = '' THEN
            ERROR(MSG003, FIELDCAPTION("Employee Name"));
          IF "Contract No." = '' THEN
            ERROR(MSG003, FIELDCAPTION("Contract No."));
          IF "Litigation Type" = "Litigation Type"::Blank THEN
            ERROR(MSG003, FIELDCAPTION("Litigation Type"));
          IF "Contact Method" = "Contact Method"::Blank THEN
            ERROR(MSG003, FIELDCAPTION("Contact Method"));
          IF "Counsel Target" = "Counsel Target"::Blank THEN
            ERROR(MSG003, FIELDCAPTION("Counsel Target"));
          IF WorkLitigationContent = '' THEN
            ERROR(MSG003, FIELDCAPTION("Counsel Content"));
        
        END;
        */

    end;

    var
        WorkLitigationContent: Text;
        MSG001: Label 'The %1 has been Rec. Modify to a %2.';
        EditWorkLitiCon: Boolean;
        MSG002: Label 'I can not change Value.';
        MSG003: Label '%1 is a required input value. You cannot exit this window.';
        MSG004: Label '%1 must be specified.';
        MSG005: Label 'Contract information not found';
}

