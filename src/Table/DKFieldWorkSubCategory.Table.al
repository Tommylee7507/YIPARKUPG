table 50073 "DK_Field Work Sub Category"
{
    Caption = 'Field Work Sub Category';
    DataCaptionFields = "Field Work Main Cat. Code", "Code", Name;
    DrillDownPageID = "DK_Field Work Sub Category";
    LookupPageID = "DK_Field Work Sub Category";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin

                if (xRec.Name <> Name) and (Name <> '') then
                    _ChangeMasterName.UpdateFieldWorkSubCat(Code, Name, xRec.Name);
            end;
        }
        field(3; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Field Work Main Category".Code;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin

                if "Field Work Main Cat. Code" = '' then begin
                    "Field Work Main Cat. Name" := '';
                end;

                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name;
            end;
        }
        field(4; "Field Work Main Cat. Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Field Work Main Category".Name WHERE(Code = FIELD("Field Work Main Cat. Code")));
            Caption = 'Field Work Main Cat. Name';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "DK_Field Work Main Category";

            trigger OnValidate()
            begin
                Validate("Field Work Main Cat. Code", FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(5; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FieldWorkHeader: Record "DK_Field Work Header";
            begin
                FieldWorkCheck(Rec);
            end;
        }
        field(6; "Work Blocked"; Boolean)
        {
            Caption = 'Work Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FieldWorkHeader: Record "DK_Field Work Header";
            begin
                FieldWorkCheck(Rec);
            end;
        }
        field(7; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(8; Unit; Text[20])
        {
            Caption = 'Unit';
            DataClassification = ToBeClassified;
        }
        field(9; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(10; "Min Unit"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Min Unit';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(11; "Min Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Min Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(12; "Connect Size"; Boolean)
        {
            Caption = 'Connect Size';
            DataClassification = ToBeClassified;
        }
        field(13; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkGroup: Record "DK_Work Group";
            begin

                if _WorkGroup.Get("Work Group Code") then
                    "Work Group" := _WorkGroup.Name
                else
                    "Work Group" := '';
            end;
        }
        field(14; "Work Group"; Text[30])
        {
            Caption = 'Work Group';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _WorkGroup: Record "DK_Work Group";
            begin

                Validate("Work Group Code", _WorkGroup.GetWorkGroupCode("Work Group"));
            end;
        }
    }

    keys
    {
        key(Key1; "Field Work Main Cat. Code", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code")
        {
        }
        key(Key3; Name)
        {
        }
        key(Key4; "Field Work Main Cat. Code", Blocked)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name, "Cost Amount", Remarks)
        {
        }
    }

    trigger OnDelete()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Field Work Sub Cat. Code", Code);
        _FieldWorkHeader.SetRange("Field Work Main Cat. Code", Rec."Field Work Main Cat. Code");
        _FieldWorkHeader.SetFilter(Status, '<>%1', _FieldWorkHeader.Status::Post);
        if _FieldWorkHeader.FindSet then
            Error(MSG001, _FieldWorkHeader.TableCaption);
    end;

    trigger OnInsert()
    begin

        TestField(Code);
    end;

    trigger OnModify()
    begin

        TestField(Code);
    end;

    var
        MSG001: Label 'It can not be deleted because it is being used in %1.';
        FieldWorkMainCategory: Record "DK_Field Work Main Category";
        MSG002: Label 'You must select an existing %1.';
        MSG003: Label 'It can not be modify because it is being used in %1.';

    procedure GetFieldWorkSCode(pFieldWorkSText: Text; pFieldWorkMCode: Code[20]): Text
    begin
        exit(GetFieldWorkSName(pFieldWorkSText, pFieldWorkMCode));
    end;

    procedure GetFieldWorkSName(pFieldWorkSText: Text; pFieldWorkMCode: Code[20]): Code[20]
    var
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        _FieldWorkSCatWithoutQuate: Text;
        _FieldWorkSCatFilterFromStart: Text;
        _FieldWorkSCatFilterContains: Text;
    begin
        if (pFieldWorkSText = '') or
          (pFieldWorkMCode = '') then
            exit('');

        if StrLen(pFieldWorkSText) <= MaxStrLen(_FieldWorkSubCategory.Code) then
            if _FieldWorkSubCategory.Get(CopyStr(pFieldWorkSText, 1, MaxStrLen(_FieldWorkSubCategory.Code))) then
                exit(_FieldWorkSubCategory.Code);

        _FieldWorkSubCategory.SetRange(Blocked, false);
        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", pFieldWorkMCode);
        _FieldWorkSubCategory.SetRange(Name, pFieldWorkSText);
        if _FieldWorkSubCategory.FindFirst then
            exit(_FieldWorkSubCategory.Code);

        _FieldWorkSubCategory.SetCurrentKey(Name);

        _FieldWorkSCatWithoutQuate := ConvertStr(pFieldWorkSText, '''', '?');
        _FieldWorkSubCategory.SetFilter(Name, '''@' + _FieldWorkSCatWithoutQuate + '''');
        if _FieldWorkSubCategory.FindFirst then
            exit(_FieldWorkSubCategory.Code);
        _FieldWorkSubCategory.SetRange(Name);

        _FieldWorkSCatFilterFromStart := '''@' + _FieldWorkSCatWithoutQuate + '*''';

        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", pFieldWorkMCode);

        _FieldWorkSubCategory.FilterGroup := -1;
        _FieldWorkSubCategory.SetFilter(Code, _FieldWorkSCatFilterFromStart);
        _FieldWorkSubCategory.SetFilter(Name, _FieldWorkSCatFilterFromStart);

        if _FieldWorkSubCategory.FindFirst then
            exit(_FieldWorkSubCategory.Code);

        _FieldWorkSCatFilterContains := '''@*' + _FieldWorkSCatWithoutQuate + '*''';

        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", pFieldWorkMCode);
        _FieldWorkSubCategory.SetFilter(Code, _FieldWorkSCatFilterContains);
        _FieldWorkSubCategory.SetFilter(Name, _FieldWorkSCatFilterContains);

        if _FieldWorkSubCategory.Count = 1 then begin
            _FieldWorkSubCategory.FindFirst;
            exit(_FieldWorkSubCategory.Code);
        end;

        if not GuiAllowed then
            Error(MSG002, _FieldWorkSubCategory.TableCaption);

        Error(MSG002, _FieldWorkSubCategory.TableCaption);
    end;


    procedure FieldWorkCheck(pFieldWorkSubCategory: Record "DK_Field Work Sub Category")
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Field Work Sub Cat. Code", pFieldWorkSubCategory.Code);
        _FieldWorkHeader.SetRange("Field Work Main Cat. Code", pFieldWorkSubCategory."Field Work Main Cat. Code");
        _FieldWorkHeader.SetFilter(Status, '<>%1', _FieldWorkHeader.Status::Post);
        if _FieldWorkHeader.FindSet then
            Error(MSG003, _FieldWorkHeader.TableCaption);
    end;
}

