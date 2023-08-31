table 50018 "DK_Item Sub Category"
{
    // 
    // #2038 : 2020-07-20
    //   - Modify OnValidate: Name

    Caption = 'Item Sub Category';
    DataCaptionFields = "Item Main Cat. Name","Code",Name;
    DrillDownPageID = "DK_Item Sub Category";
    LookupPageID = "DK_Item Sub Category";

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
                // >> #2038
                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdateItemSubCategory("Item Main Cat. Code",Code,Name,xRec.Name);
                // << #2038
            end;
        }
        field(3;"Item Main Cat. Code";Code[20])
        {
            Caption = 'Item Main Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Item Main Category".Code;

            trigger OnValidate()
            var
                _ItemMainCategory: Record "DK_Item Main Category";
            begin
                /*
                IF _ItemMainCategory.GET("Item Main Cat. Code") THEN
                  "Item Main Cat. Name" := _ItemMainCategory.Name
                ELSE
                  "Item Main Cat. Name" := '';
                  */
                CalcFields("Item Main Cat. Name");

            end;
        }
        field(4;"Item Main Cat. Name";Text[30])
        {
            CalcFormula = Lookup("DK_Item Main Category".Name WHERE (Code=FIELD("Item Main Cat. Code")));
            Caption = 'Item Main Category Name';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //VALIDATE("Item Main Cat. Code",ItemMainCategory.GetItemMCode("Item Main Cat. Name"));
            end;
        }
        field(5;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Item Main Cat. Code","Code")
        {
            Clustered = true;
        }
        key(Key2;"Code")
        {
        }
        key(Key3;Name)
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
        _Item: Record DK_Item;
    begin
        /*
        _Item.RESET;
        _Item.SETRANGE(_Item."Item Sub Cat. Code", Code);
        IF _Item.FINDSET THEN
          ERROR(MSG001,_Item.TABLECAPTION);
        */

    end;

    trigger OnInsert()
    begin

        TestField(Code);
    end;

    var
        ItemMainCategory: Record "DK_Item Main Category";
        MSG001: Label 'It can not be deleted because it is being used in %1.';
        MSG002: Label 'You must select an existing %1.';

    procedure GetItemSCode(pItemSText: Text;pItemMCatCode: Code[20]): Text
    begin
        exit(GetItemSName(pItemSText,pItemMCatCode));
    end;

    procedure GetItemSName(pItemSText: Text;pItemMCatCode: Code[20]): Code[20]
    var
        _ItemSubCategory: Record "DK_Item Sub Category";
        _ItemSCatWithoutQuate: Text;
        _ItemSCatFilterFromStart: Text;
        _ItemCatFilterContains: Text;
    begin
        if (pItemSText = '') or
          (pItemMCatCode= '') then
          exit('');

        if StrLen(pItemSText) <= MaxStrLen(_ItemSubCategory.Code) then
          if _ItemSubCategory.Get(CopyStr(pItemSText,1,MaxStrLen(_ItemSubCategory.Code))) then
            exit(_ItemSubCategory.Code);

        _ItemSubCategory.SetRange(Blocked,false);
        _ItemSubCategory.SetRange("Item Main Cat. Code", pItemMCatCode);
        _ItemSubCategory.SetRange(Name,pItemSText);
        if _ItemSubCategory.FindFirst then
          exit(_ItemSubCategory.Code);

        _ItemSubCategory.SetCurrentKey(Name);

        _ItemSCatWithoutQuate := ConvertStr(pItemSText,'''','?');
        _ItemSubCategory.SetFilter(Name,'''@' + _ItemSCatWithoutQuate + '''');
        if _ItemSubCategory.FindFirst then
          exit(_ItemSubCategory.Code);
        _ItemSubCategory.SetRange(Name);

        _ItemSCatFilterFromStart := '''@' + _ItemSCatWithoutQuate + '*''';

        _ItemSubCategory.SetRange("Item Main Cat. Code",pItemMCatCode);

        _ItemSubCategory.FilterGroup := -1;
        _ItemSubCategory.SetFilter(Code,_ItemSCatFilterFromStart);
        _ItemSubCategory.SetFilter(Name,_ItemSCatFilterFromStart);

        if _ItemSubCategory.FindFirst then
          exit(_ItemSubCategory.Code);

        _ItemCatFilterContains := '''@*' + _ItemSCatWithoutQuate + '*''';

        _ItemSubCategory.SetRange("Item Main Cat. Code",pItemMCatCode);
        _ItemSubCategory.SetFilter(Code, _ItemCatFilterContains);
        _ItemSubCategory.SetFilter(Name, _ItemCatFilterContains);

        if _ItemSubCategory.Count = 1 then begin
          _ItemSubCategory.FindFirst;
          exit(_ItemSubCategory.Code);
        end;

        if not GuiAllowed then
          Error(MSG002,_ItemSubCategory.TableCaption);

        Error(MSG002,_ItemSubCategory.TableCaption);
    end;
}

