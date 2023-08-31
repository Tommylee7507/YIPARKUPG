table 50034 "DK_Counsel Level 2"
{
    Caption = 'Counsel Level 2';
    DataCaptionFields = "Code",Name;
    DrillDownPageID = "DK_Counsel Level 2";
    LookupPageID = "DK_Counsel Level 2";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdateCounselLevel2(Code,Name,xRec.Name);
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
        _CounselHistory: Record "DK_Counsel History";
    begin
        _CounselHistory.Reset;
        _CounselHistory.SetRange("Counsel Level Code 2",Code);
        if not _CounselHistory.IsEmpty then
          Error(MSG001, TableCaption, Code, _CounselHistory.TableCaption);
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

    procedure GetCode(pCounselText: Text): Text
    begin
        exit(GetCodeOpenCard(pCounselText));
    end;

    procedure GetCodeOpenCard(pCounselText: Text): Code[20]
    var
        _CounselLevel2: Record "DK_Counsel Level 2";
        _Code: Code[20];
        _NoFiltersApplied: Boolean;
        _WithoutQuote: Text;
        _FilterFromStart: Text;
        _FilterContains: Text;
    begin
        if pCounselText = '' then
          exit('');

        if StrLen(pCounselText) <= MaxStrLen(_CounselLevel2.Code) then
          if _CounselLevel2.Get(CopyStr(pCounselText,1,MaxStrLen(_CounselLevel2.Code))) then
            exit(_CounselLevel2.Code);

        _CounselLevel2.SetRange(Blocked,false);
        _CounselLevel2.SetRange(Name,pCounselText);
        if _CounselLevel2.FindFirst then
          exit(_CounselLevel2.Code);

        _CounselLevel2.SetCurrentKey(Name);

        _WithoutQuote := ConvertStr(pCounselText,'''','?');
        _CounselLevel2.SetFilter(Name,'''@' + _WithoutQuote + '''');
        if _CounselLevel2.FindFirst then
          exit(_CounselLevel2.Code);
        _CounselLevel2.SetRange(Name);

        _FilterFromStart := '''@' + _WithoutQuote + '*''';

        _CounselLevel2.FilterGroup := -1;
        _CounselLevel2.SetFilter(Code,_FilterFromStart);
        _CounselLevel2.SetFilter(Name,_FilterFromStart);

        if _CounselLevel2.FindFirst then
          exit(_CounselLevel2.Code);

        _FilterContains := '''@*' + _WithoutQuote + '*''';

        _CounselLevel2.SetFilter(Code,_FilterContains);
        _CounselLevel2.SetFilter(Name,_FilterContains);

        if _CounselLevel2.Count = 1 then begin
          _CounselLevel2.FindFirst;
          exit(_CounselLevel2.Code);
        end;

        if not GuiAllowed then
          Error(MSG002,_CounselLevel2.TableCaption);

        Error(MSG002,_CounselLevel2.TableCaption);
    end;
}

