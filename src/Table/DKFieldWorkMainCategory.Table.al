table 50072 "DK_Field Work Main Category"
{
    // 
    // DK34: 20201202
    //   - Modify Trigger: OnDelete()

    Caption = 'Field Work Main Category';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = "DK_Field Work Main Category";
    LookupPageID = "DK_Field Work Main Category";

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
                _ReportTargetValue: Record "DK_Report Target Value";
            begin

                if (xRec.Name <> Name) and (Name <> '') then begin
                    _ChangeMasterName.UpdateFieldWorkMainCat(Code, Name, xRec.Name);

                    _ReportTargetValue.Reset;
                    _ReportTargetValue.SetRange("Field Work Main Cat. Code", Code);
                    if _ReportTargetValue.FindSet then begin
                        _ReportTargetValue.CalcFields("Report Target Name");
                        Message(MSG005, _ReportTargetValue.TableCaption, _ReportTargetValue."Report Target Name", _ReportTargetValue.Name);
                    end;
                end;
            end;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                FieldWorkCheck(Rec);
            end;
        }
        field(4; "Connect Work"; Boolean)
        {
            Caption = 'Connect Work';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                FieldWorkCheck(Rec);
            end;
        }
        field(5; "Funeral Type"; Option)
        {
            Caption = 'Funeral Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Funeral,Move';
            OptionMembers = Blank,Funeral,Move;
        }
        field(6; "Cemetery Services"; Boolean)
        {
            Caption = 'Cemetery Services';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin

                _FieldWorkSubCategory.Reset;
                _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", Code);
                _FieldWorkSubCategory.SetFilter("Cost Amount", '<>%1', 0);
                if _FieldWorkSubCategory.FindSet then begin
                    Error(MSG004, _FieldWorkSubCategory.TableCaption);
                end;
            end;
        }
        field(8; Unassigned; Boolean)
        {
            Caption = 'Unassigned';
            DataClassification = ToBeClassified;
        }
        field(9; "Other Services"; Boolean)
        {
            Caption = 'Other Services';
            DataClassification = ToBeClassified;
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
        key(Key3; Blocked, "Cemetery Services")
        {
        }
        key(Key4; Blocked, "Cemetery Services", "Other Services", "Code")
        {
        }
        key(Key5; Blocked, "Code")
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
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        _ReportTargetValue: Record "DK_Report Target Value";
    begin
        _FieldWorkSubCategory.Reset;
        _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", Code);
        if _FieldWorkSubCategory.FindSet then
            Error(MSG001, _FieldWorkSubCategory.TableCaption);

        _ReportTargetValue.Reset;
        _ReportTargetValue.SetRange("Field Work Main Cat. Code", Code);
        if _ReportTargetValue.FindSet then
            Error(MSG001, _ReportTargetValue.TableCaption);
    end;

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    trigger OnModify()
    begin
        TestField(Code);
    end;

    trigger OnRename()
    begin
        //ERROR(MSG002,TABLECAPTION);
    end;

    var
        MSG001: Label 'It can not be deleted because it is being used in %1.';
        MSG002: Label 'You cannot rename a %1.';
        MSG003: Label 'You must select an existing %1.';
        MSG004: Label 'It can not be modify because it is being used in %1.';
        MSG005: Label '%1íŒ¡ ‹ÏÔ‘È¯„Ÿ„¾. …Ÿ—© œˆºˆ‡ž Œ÷‘ñ—¹‘´ŒŒÍ. %2: %3';

    procedure GetFieldWorkMCode(pFieldWorkMText: Text): Text
    begin
        exit(GetFieldWorkMName(pFieldWorkMText));
    end;

    procedure GetFieldWorkMName(pFieldWorkMText: Text): Code[20]
    var
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
        _FieldWorkMCatWithoutQuote: Text;
        _FieldWorkMCatFilterFromStart: Text;
        _FieldWorkMCatFilterContains: Text;
    begin
        if pFieldWorkMText = '' then
            exit('');

        if StrLen(pFieldWorkMText) <= MaxStrLen(_FieldWorkMainCategory.Code) then
            if _FieldWorkMainCategory.Get(CopyStr(pFieldWorkMText, 1, MaxStrLen(_FieldWorkMainCategory.Code))) then
                exit(_FieldWorkMainCategory.Code);

        _FieldWorkMainCategory.SetRange(Blocked, false);
        _FieldWorkMainCategory.SetRange(Name, pFieldWorkMText);
        if _FieldWorkMainCategory.FindFirst then
            exit(_FieldWorkMainCategory.Code);

        _FieldWorkMainCategory.SetCurrentKey(Name);

        _FieldWorkMCatWithoutQuote := ConvertStr(pFieldWorkMText, '''', '?');
        _FieldWorkMainCategory.SetFilter(Name, '''@' + _FieldWorkMCatWithoutQuote + '''');
        if _FieldWorkMainCategory.FindFirst then
            exit(_FieldWorkMainCategory.Code);
        _FieldWorkMainCategory.SetRange(Name);

        _FieldWorkMCatFilterFromStart := '''@' + _FieldWorkMCatWithoutQuote + '*''';

        _FieldWorkMainCategory.FilterGroup := -1;
        _FieldWorkMainCategory.SetFilter(Code, _FieldWorkMCatFilterFromStart);
        _FieldWorkMainCategory.SetFilter(Name, _FieldWorkMCatFilterFromStart);

        if _FieldWorkMainCategory.FindFirst then
            exit(_FieldWorkMainCategory.Code);

        _FieldWorkMCatFilterContains := '''@*' + _FieldWorkMCatWithoutQuote + '*''';

        _FieldWorkMainCategory.SetFilter(Code, _FieldWorkMCatFilterContains);
        _FieldWorkMainCategory.SetFilter(Name, _FieldWorkMCatFilterContains);

        if _FieldWorkMainCategory.Count = 1 then begin
            _FieldWorkMainCategory.FindFirst;
            exit(_FieldWorkMainCategory.Code);
        end;

        if not GuiAllowed then
            Error(MSG003, _FieldWorkMainCategory.TableCaption);

        Error(MSG003, _FieldWorkMainCategory.TableCaption);
    end;


    procedure FieldWorkCheck(pFieldWorkMainCategory: Record "DK_Field Work Main Category")
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Field Work Main Cat. Code", pFieldWorkMainCategory.Code);
        _FieldWorkHeader.SetFilter(Status, '<>%1', _FieldWorkHeader.Status::Post);
        if _FieldWorkHeader.FindSet then
            Error(MSG003, _FieldWorkHeader.TableCaption);
    end;
}

