page 50161 "DK_Department Board"
{
    Caption = 'Department Board';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Department Board";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Additional;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Importance = Additional;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Contents; Rec.Contents)
                {
                    MultiLine = true;
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
            part(Control19; "DK_Attched Files Factbox")
            {
                SubPageLink = "Table ID" = CONST(50103),
                              //   "Source No." = FIELD("No."),////zzz
                              "Source Line No." = CONST(0);
            }
            part(Control18; "DK_Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50103),
                              //   "Source No." = FIELD("No."), ////zzz
                              "Source Line No." = CONST(0);
            }
            systempart(Control16; Notes)
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
        _Department: Record DK_Department;
    begin
        Rec.Date := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;
}

