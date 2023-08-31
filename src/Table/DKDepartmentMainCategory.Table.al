table 50106 "DK_Department Main Category"
{
    Caption = 'Department Main Category';

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if (xRec.Name <> Name) and (Name <> '')then
                  _ChangeMasterName.UpdateDepartmentMain(Code,Name,xRec.Name);
            end;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _Department: Record DK_Department;
    begin
        Check_Department;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'You must select an existing %1.';
        MSG002: Label 'Unable to delete as it is in use by %1.';

    local procedure Check_Department()
    var
        _Department: Record DK_Department;
    begin
        _Department.Reset;
        _Department.SetRange("Department Main Cat. Code",Code);
        if _Department.FindSet then
          Error(MSG002,_Department.TableCaption);
    end;

    procedure GetDepartmentMCode(pDepartmentMText: Text): Text
    begin
        exit(GetDepartmentMCodeOpenCard(pDepartmentMText));
    end;

    procedure GetDepartmentMCodeOpenCard(pDepartmentMText: Text): Code[20]
    var
        _DepartmentMCat: Record "DK_Department Main Category";
        _DepartmentMCatNo: Code[20];
        _NoFiltersApplied: Boolean;
        _DepartmentMCatWithoutQuote: Text;
        _DepartmentMCatFilterFromStart: Text;
        _DepartmentMCatFilterContains: Text;
    begin
        if pDepartmentMText = '' then
          exit('');

        if StrLen(pDepartmentMText) <= MaxStrLen(_DepartmentMCat.Code) then
          if _DepartmentMCat.Get(CopyStr(pDepartmentMText,1,MaxStrLen(_DepartmentMCat.Code))) then
            exit(_DepartmentMCat.Code);

        _DepartmentMCat.SetRange(Name,pDepartmentMText);
        if _DepartmentMCat.FindFirst then
          exit(_DepartmentMCat.Code);

        _DepartmentMCat.SetCurrentKey(Name);

        _DepartmentMCatWithoutQuote := ConvertStr(pDepartmentMText,'''','?');
        _DepartmentMCat.SetFilter(Name,'''@' + _DepartmentMCatWithoutQuote + '''');
        if _DepartmentMCat.FindFirst then
          exit(_DepartmentMCat.Code);

        _DepartmentMCat.SetRange(Name);

        _DepartmentMCatFilterFromStart := '''@' + _DepartmentMCatWithoutQuote + '*''';

        _DepartmentMCat.FilterGroup := -1;
        _DepartmentMCat.SetFilter(Code,_DepartmentMCatFilterFromStart);
        _DepartmentMCat.SetFilter(Name,_DepartmentMCatFilterFromStart);

        if _DepartmentMCat.FindFirst then
          exit(_DepartmentMCat.Code);

        _DepartmentMCatFilterContains := '''@*' + _DepartmentMCatWithoutQuote + '*''';

        _DepartmentMCat.SetFilter(Code,_DepartmentMCatFilterContains);
        _DepartmentMCat.SetFilter(Name,_DepartmentMCatFilterContains);

        if _DepartmentMCat.Count = 1 then begin
          _DepartmentMCat.FindFirst;
          exit(_DepartmentMCat.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_DepartmentMCat.TableCaption);


        Error(MSG001,_DepartmentMCat.TableCaption);
    end;
}

