table 50017 "DK_Item Main Category"
{
    Caption = 'Item Main Category';
    DataCaptionFields = "Code",Name;
    DrillDownPageID = "DK_Item Main Category";
    LookupPageID = "DK_Item Main Category";

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

                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdateItemMainCategory(Code,Name,xRec.Name);
            end;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
        key(Key2;Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Name)
        {
        }
    }

    trigger OnDelete()
    var
        "_Item Sub Category": Record "DK_Item Sub Category";
    begin

        "_Item Sub Category".Reset;
        "_Item Sub Category".SetRange("_Item Sub Category"."Item Main Cat. Code", Code);
        if "_Item Sub Category".FindSet then
          Error(MSG001,"_Item Sub Category".TableCaption);
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
        Error(MSG002,TableCaption);
    end;

    var
        MSG001: Label 'It can not be deleted because it is being used in %1.';
        MSG002: Label 'You cannot rename a %1.';
        MSG003: Label 'You must select an existing %1.';

    procedure GetItemMCode(ItemMText: Text): Text
    var
        "DK_Item Main Category": Record "DK_Item Main Category";
    begin
        exit(GetItemMName(ItemMText));
    end;

    procedure GetItemMName(pItemMText: Text): Code[20]
    var
        _ItemMainCategory: Record "DK_Item Main Category";
        _ItemMCatWithoutQuote: Text;
        _ItemMCatFilterFromStart: Text;
        _ItemCatFilterContains: Text;
    begin
        if pItemMText = '' then
          exit('');

        if StrLen(pItemMText) <= MaxStrLen(_ItemMainCategory.Code) then
          if _ItemMainCategory.Get(CopyStr(pItemMText,1,MaxStrLen(_ItemMainCategory.Code))) then
            exit(_ItemMainCategory.Code);

        //_ItemMainCategory.SETRANGE(Blocked,FALSE);
        _ItemMainCategory.SetRange(Name,pItemMText);
        if _ItemMainCategory.FindFirst then
          exit(_ItemMainCategory.Code);

        _ItemMainCategory.SetCurrentKey(Name);

        _ItemMCatWithoutQuote := ConvertStr(pItemMText,'''','?');
        _ItemMainCategory.SetFilter(Name,'''@' + _ItemMCatWithoutQuote + '''');
        if _ItemMainCategory.FindFirst then
          exit(_ItemMainCategory.Code);
        _ItemMainCategory.SetRange(Name);

        _ItemMCatFilterFromStart := '''@' + _ItemMCatWithoutQuote + '*''';

        _ItemMainCategory.FilterGroup := -1;
        _ItemMainCategory.SetFilter(Code,_ItemMCatFilterFromStart);
        _ItemMainCategory.SetFilter(Name,_ItemMCatFilterFromStart);

        if _ItemMainCategory.FindFirst then
          exit(_ItemMainCategory.Code);

        _ItemCatFilterContains := '''@*' + _ItemMCatWithoutQuote + '*''';

        _ItemMainCategory.SetFilter(Code,_ItemCatFilterContains);
        _ItemMainCategory.SetFilter(Name,_ItemCatFilterContains);

        if _ItemMainCategory.Count = 1 then begin
          _ItemMainCategory.FindFirst;
          exit(_ItemMainCategory.Code);
        end;

        if not GuiAllowed then
          Error(MSG003,_ItemMainCategory.TableCaption);

        Error(MSG003,_ItemMainCategory.TableCaption);
    end;
}

