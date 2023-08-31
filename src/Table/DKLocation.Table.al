table 50063 DK_Location
{
    Caption = 'Location';
    DrillDownPageID = DK_Location;
    LookupPageID = DK_Location;

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
                  _ChangeMasterName.UpdateLocation(Code,Name,xRec.Name);
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

    procedure GetLocationCode(pLocationText: Text): Text
    begin
        exit(GetLocatoionName(pLocationText));
    end;

    procedure GetLocatoionName(pLocationText: Text): Code[20]
    var
        _Location: Record DK_Location;
        _LocationWithoutQuote: Text;
        _LocationFilterFromStart: Text;
        _LocationFilterContains: Text;
    begin
        if pLocationText = '' then
          exit('');

        if StrLen(pLocationText) <= MaxStrLen(_Location.Code) then
          if _Location.Get(CopyStr(pLocationText,1,MaxStrLen(_Location.Code))) then
            exit(_Location.Code);

        _Location.SetRange(Blocked,false);
        _Location.SetRange(Name,pLocationText);
        if _Location.FindFirst then
          exit(_Location.Code);

        _Location.SetCurrentKey(Name);

        _LocationWithoutQuote := ConvertStr(pLocationText,'''','?');
        _Location.SetFilter(Name,'''@' + _LocationWithoutQuote + '''');
        if _Location.FindFirst then
          exit(_Location.Code);
        _Location.SetRange(Name);

        _LocationFilterFromStart := '''@' + _LocationWithoutQuote + '*''';

        _Location.FilterGroup := -1;
        _Location.SetFilter(Code,_LocationFilterFromStart);
        _Location.SetFilter(Name,_LocationFilterFromStart);

        if _Location.FindFirst then
          exit(_Location.Code);

        _LocationFilterContains := '''@*' + _LocationWithoutQuote + '*''';

        _Location.SetFilter(Code,_LocationFilterContains);
        _Location.SetFilter(Name,_LocationFilterContains);

        if _Location.Count = 1 then begin
          _Location.FindFirst;
          exit(_Location.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_Location.TableCaption);

        Error(MSG001,_Location.TableCaption);
    end;
}

