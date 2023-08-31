table 50103 "DK_Department Board"
{
    Caption = 'Department Board';
    DataCaptionFields = Title, "Department Name", "Employee Name";
    DrillDownPageID = "DK_Department Board List";
    LookupPageID = "DK_Department Board List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                if _Department.Get("Department Code") then
                    "Department Name" := _Department.Name
                else begin
                    "Department Name" := '';
                    Insert_NoticeText;
                end;
            end;
        }
        field(3; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code", _Department.GetDeptCode("Department Name"));
            end;
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';

                Validate("Department Code", _Employee.GetDepartmentCode("Employee No."));
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(6; Title; Text[50])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(8; Contents; Text[250])
        {
            Caption = 'Contents';
            DataClassification = ToBeClassified;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _AttchedFiles: Record "DK_Attched Files";
    begin

        _AttchedFiles.Reset;
        _AttchedFiles.SetRange("Table ID", DATABASE::"DK_Purchase Contract");
        _AttchedFiles.SetRange("Source Line No.", "No.");
        if _AttchedFiles.FindFirst then
            _AttchedFiles.DeleteAll;
    end;

    trigger OnInsert()
    begin

        Check_EmployeeUserID(UserId);

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'The %2 has not been set in %1.';
        Notice: Label 'Notice';


    procedure Check_EmployeeUserID(pUserID: Code[50])
    var
        _Employee: Record DK_Employee;
    begin
        _Employee.Reset;
        _Employee.SetRange("ERP User ID", pUserID);
        if _Employee.IsEmpty then begin
            Error(MSG001, _Employee.TableCaption, _Employee.FieldCaption("ERP User ID"));
        end;
    end;

    local procedure Insert_NoticeText()
    begin
        if "Department Code" <> '' then
            exit;

        Title := Notice;
    end;
}

