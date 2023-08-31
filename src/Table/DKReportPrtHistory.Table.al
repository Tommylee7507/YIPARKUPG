table 50105 "DK_Report Prt. History"
{
    Caption = 'Report Printing History -  Litigation';
    DrillDownPageID = "DK_Report Printing History";
    LookupPageID = "DK_Report Printing History";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;
        }
        field(4; "Printing Date"; Date)
        {
            Caption = 'Printing Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Printing Time"; Time)
        {
            Caption = 'Printing Time';
            DataClassification = ToBeClassified;
        }
        field(6; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));

            trigger OnValidate()
            begin
                CalcFields("Report Caption");
            end;
        }
        field(7; "Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Report ID")));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Printed Report"; BLOB)
        {
            Caption = 'Printed Report';
            DataClassification = ToBeClassified;
        }
        field(9; "Report Title"; Text[100])
        {
            Caption = 'Report Title';
            DataClassification = ToBeClassified;
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                if xRec."Employee No." <> "Employee No." then begin
                    if _Employee.Get("Employee No.") then begin
                        "Employee Name" := _Employee.Name;
                    end else begin
                        "Employee Name" := '';
                    end;
                end;
            end;
        }
        field(11; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(12; Contacts; Text[20])
        {
            Caption = 'Contacts';
            DataClassification = ToBeClassified;
        }
        field(13; "Add.Remaining Due Date"; Date)
        {
            Caption = 'Add.Remaining Due Date';
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
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
        key(Key3; "Contract No.")
        {
        }
        key(Key4; "Printing Date")
        {
        }
        key(Key5; "Report ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Entry No.");
    end;
}

