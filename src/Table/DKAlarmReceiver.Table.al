table 50092 "DK_Alarm Receiver"
{
    Caption = 'Alarm Receiver';

    fields
    {
        field(1;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type=CONST(Department)) DK_Department.Code WHERE (Blocked=CONST(false))
                            ELSE IF (Type=CONST(Employee)) DK_Employee."No." WHERE (Blocked=CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
                _Employee: Record DK_Employee;
            begin
                if Type = Type::Department then begin
                  if _Department.Get(Code) then
                    Name := _Department.Name
                  else
                    Name := '';
                end else begin
                  if _Employee.Get(Code) then
                    Name := _Employee.Name
                  else
                    Name := '';
                end;
            end;
        }
        field(4;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Department,Employee';
            OptionMembers = Department,Employee;
        }
        field(5;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type=CONST(Department)) DK_Department.Code WHERE (Blocked=CONST(false))
                            ELSE IF (Type=CONST(Employee)) DK_Employee."No." WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
                _Employee: Record DK_Employee;
            begin
                if Type = Type::Department then
                  Validate(Code,_Department.GetDeptCode(Name))
                else
                  Validate(Code,_Employee.GetEmployeeNo(Name));
            end;
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Code")
        {
        }
        key(Key3;Type)
        {
        }
        key(Key4;Name)
        {
        }
    }

    fieldgroups
    {
    }
}

