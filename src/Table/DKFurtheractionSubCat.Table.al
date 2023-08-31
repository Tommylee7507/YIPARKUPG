table 50127 "DK_Further action Sub Cat."
{
    // 
    // DK34: 20201030
    //   - Create

    Caption = 'Further action Sub Category';
    DrillDownPageID = "DK_Further action Sub Cat.";
    LookupPageID = "DK_Further action Sub Cat.";

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
        }
        field(3;"Further action Main Cat. Code";Code[20])
        {
            Caption = 'Further action Main Category Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Further action Main Cat.".Code;

            trigger OnValidate()
            begin
                CalcFields("Further action Main Cat. Name");
            end;
        }
        field(4;"Further action Main Cat. Name";Text[30])
        {
            CalcFormula = Lookup("DK_Further action Main Cat.".Name WHERE (Code=FIELD("Further action Main Cat. Code")));
            Caption = 'Further action Main Category Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Further action Main Cat. Code","Code")
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
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("Fur. Main Cat. Code",Code);
        if _Contract.FindSet then
          Error(MSG002,_Contract.TableCaption,_Contract.FieldCaption("No."),_Contract."No.");
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
        MSG001: Label 'You must select an existing %1.';
        MSG002: Label 'In use by %1. %2: %3';

    procedure GetFurtheractionSubCode(pFurtheractionSText: Text;pFurtheractionMCode: Code[20]): Text
    begin
        exit(GetFurtheractionSubName(pFurtheractionSText,pFurtheractionMCode));
    end;

    procedure GetFurtheractionSubName(pFurtheractionSText: Text;pFurtheractionMCode: Code[20]): Code[20]
    var
        _FurtheractionSubCat: Record "DK_Further action Sub Cat.";
        _FurtheractionSCatWithoutQuate: Text;
        _FurtheractionSCatFilterFromStart: Text;
        _FurtheractionSCatFilterContains: Text;
    begin
        if (pFurtheractionSText = '') or
          (pFurtheractionMCode= '') then
          exit('');

        if StrLen(pFurtheractionSText) <= MaxStrLen(_FurtheractionSubCat.Code) then
          if _FurtheractionSubCat.Get(CopyStr(pFurtheractionSText,1,MaxStrLen(_FurtheractionSubCat.Code))) then
            exit(_FurtheractionSubCat.Code);

        _FurtheractionSubCat.SetRange(Blocked,false);
        _FurtheractionSubCat.SetRange("Further action Main Cat. Code", pFurtheractionMCode);
        _FurtheractionSubCat.SetRange(Name,pFurtheractionSText);
        if _FurtheractionSubCat.FindFirst then
          exit(_FurtheractionSubCat.Code);

        _FurtheractionSubCat.SetCurrentKey(Name);

        _FurtheractionSCatWithoutQuate := ConvertStr(pFurtheractionSText,'''','?');
        _FurtheractionSubCat.SetFilter(Name,'''@' + _FurtheractionSCatWithoutQuate + '''');
        if _FurtheractionSubCat.FindFirst then
          exit(_FurtheractionSubCat.Code);
        _FurtheractionSubCat.SetRange(Name);

        _FurtheractionSCatFilterFromStart := '''@' + _FurtheractionSCatWithoutQuate + '*''';

        _FurtheractionSubCat.SetRange("Further action Main Cat. Code",pFurtheractionMCode);

        _FurtheractionSubCat.FilterGroup := -1;
        _FurtheractionSubCat.SetFilter(Code,_FurtheractionSCatFilterFromStart);
        _FurtheractionSubCat.SetFilter(Name,_FurtheractionSCatFilterFromStart);

        if _FurtheractionSubCat.FindFirst then
          exit(_FurtheractionSubCat.Code);

        _FurtheractionSCatFilterContains := '''@*' + _FurtheractionSCatWithoutQuate + '*''';

        _FurtheractionSubCat.SetRange("Further action Main Cat. Code",pFurtheractionMCode);
        _FurtheractionSubCat.SetFilter(Code, _FurtheractionSCatFilterContains);
        _FurtheractionSubCat.SetFilter(Name, _FurtheractionSCatFilterContains);

        if _FurtheractionSubCat.Count = 1 then begin
          _FurtheractionSubCat.FindFirst;
          exit(_FurtheractionSubCat.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_FurtheractionSubCat.TableCaption);

        Error(MSG001,_FurtheractionSubCat.TableCaption);
    end;
}

