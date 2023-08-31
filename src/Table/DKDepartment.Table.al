table 50019 DK_Department
{
    Caption = 'Department';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = DK_Department;
    LookupPageID = DK_Department;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if (xRec.Name <> Name) and (Name <> '') then
                    _ChangeMasterName.UpdateDepartment(Code, Name, xRec.Name);
            end;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(4; "No. of SMS"; Integer)
        {
            CalcFormula = Count(DK_SMS WHERE("Department Code" = FIELD(Code)));
            Caption = 'No. of SMS Message';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Litigation; Boolean)
        {
            Caption = 'Litigation';
            DataClassification = ToBeClassified;
        }
        field(6; Sales; Boolean)
        {
            Caption = 'Sales';
            DataClassification = ToBeClassified;
        }
        field(7; CustomerCenter; Boolean)
        {
            Caption = 'CustomerCenter';
            DataClassification = ToBeClassified;
        }
        field(8; ParkManager; Boolean)
        {
            Caption = 'ParkManager';
            DataClassification = ToBeClassified;
        }
        field(9; "Department Main Cat. Code"; Code[20])
        {
            Caption = 'Department Main Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Department Main Category" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _DepartmentMainCategory: Record "DK_Department Main Category";
            begin
                if _DepartmentMainCategory.Get("Department Main Cat. Code") then
                    "Department Main Cat. Name" := _DepartmentMainCategory.Name
                else
                    "Department Main Cat. Name" := '';
            end;
        }
        field(10; "Department Main Cat. Name"; Text[30])
        {
            Caption = 'Department Main Category Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Department Main Category" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _DepartmentMainCategory: Record "DK_Department Main Category";
            begin
                Validate("Department Main Cat. Code", _DepartmentMainCategory.GetDepartmentMCode("Department Main Cat. Name"));
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    trigger OnDelete()
    var
        _Employee: Record DK_Employee;
        _SMS: Record DK_SMS;
    begin
        //‹Ð‘ª ‘í› „Ô‹Ý
        /*
        _Employee.RESET;
        _Employee.SETRANGE("Department Code",Code);
        IF NOT _Employee.ISEMPTY THEN
          ERROR(MSG001, TABLECAPTION, Code, _Employee.TABLECAPTION);
          */
        _SMS.Reset;
        _SMS.SetRange("Department Code", Code);
        if not _SMS.IsEmpty then
            Error(MSG001, TableCaption, Code, _SMS.TableCaption);

    end;

    trigger OnInsert()
    begin
        TestField(Code);
        TestField(Name);
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Name);
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'You must select an existing %1.';

    procedure GetDeptCode(pDepartmentText: Text): Text
    begin
        exit(GetDeptCodeOpenCard(pDepartmentText));
    end;

    procedure GetDeptCodeOpenCard(pDepartmentText: Text): Code[20]
    var
        _Department: Record DK_Department;
        _DepartmentCode: Code[20];
        _NoFiltersApplied: Boolean;
        _DepartmentWithoutQuote: Text;
        _DepartmentFilterFromStart: Text;
        _DepartmentFilterContains: Text;
    begin
        if pDepartmentText = '' then
            exit('');

        if StrLen(pDepartmentText) <= MaxStrLen(_Department.Code) then
            if _Department.Get(CopyStr(pDepartmentText, 1, MaxStrLen(_Department.Code))) then
                exit(_Department.Code);

        _Department.SetRange(Blocked, false);
        _Department.SetRange(Name, pDepartmentText);
        if _Department.FindFirst then
            exit(_Department.Code);

        _Department.SetCurrentKey(Name);

        _DepartmentWithoutQuote := ConvertStr(pDepartmentText, '''', '?');
        _Department.SetFilter(Name, '''@' + _DepartmentWithoutQuote + '''');
        if _Department.FindFirst then
            exit(_Department.Code);

        _Department.SetRange(Name);

        _DepartmentFilterFromStart := '''@' + _DepartmentWithoutQuote + '*''';

        _Department.FilterGroup := -1;
        _Department.SetFilter(Code, _DepartmentFilterFromStart);
        _Department.SetFilter(Name, _DepartmentFilterFromStart);

        if _Department.FindFirst then
            exit(_Department.Code);

        _DepartmentFilterContains := '''@*' + _DepartmentWithoutQuote + '*''';

        _Department.SetFilter(Code, _DepartmentFilterContains);
        _Department.SetFilter(Name, _DepartmentFilterContains);

        if _Department.Count = 1 then begin
            _Department.FindFirst;
            exit(_Department.Code);
        end;

        if not GuiAllowed then
            Error(MSG002, _Department.TableCaption);

        Error(MSG002, _Department.TableCaption);
    end;
}

