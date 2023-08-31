table 50122 "DK_Change Evaluation History"
{
    // 
    // DK34: 20201130
    //   - Add Field: "Before Department Code", "Before Department Name", "After Department Code", "After Department Name"
    //   - Modify Field: "Before Evaluation", "After Evaluation"

    Caption = 'Change Evaluation History';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Before Evaluation"; Option)
        {
            Caption = 'Before Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon,Blank';
            OptionMembers = A,B,C,D,E,F,Blank;
        }
        field(3; "After Evaluation"; Option)
        {
            Caption = 'After Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon,Blank';
            OptionMembers = A,B,C,D,E,F,Blank;
        }
        field(4; "Receipt Amount"; Decimal)
        {
            Caption = 'Receipt Amount';
            DataClassification = ToBeClassified;
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
        }
        field(8; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Cemetery No."; Text[30])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
        }
        field(12; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Main Customer Name"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Name';
            FieldClass = FlowField;
        }
        field(200; "Before Department Code"; Code[20])
        {
            Caption = 'Before Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
        }
        field(201; "Before Department Name"; Text[50])
        {
            Caption = 'Before Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
        }
        field(202; "After Department Code"; Code[20])
        {
            Caption = 'After Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
        }
        field(203; "After Department Name"; Text[50])
        {
            Caption = 'After Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Before Evaluation")
        {
        }
        key(Key3; "After Evaluation")
        {
        }
        key(Key4; "Receipt Amount")
        {
        }
        key(Key5; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        _DK_ChangeEvaluationHistory: Record "DK_Change Evaluation History";
    begin
        _DK_ChangeEvaluationHistory.SetCurrentKey("Entry No.");
        if _DK_ChangeEvaluationHistory.FindLast then
            exit(_DK_ChangeEvaluationHistory."Entry No." + 1);

        exit(1);
    end;
}

