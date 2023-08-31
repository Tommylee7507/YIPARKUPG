table 50091 "DK_Estate Group"
{
    Caption = 'Estate Group';
    DataCaptionFields = "Group Code", "Group Name";
    DrillDownPageID = "DK_Estate Group";
    LookupPageID = "DK_Estate Group";

    fields
    {
        field(1; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Group Code" <> xRec."Group Code" then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Estate Group Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Group Name"; Text[50])
        {
            Caption = 'Group Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin

                if (xRec."Group Name" <> "Group Name") and ("Group Name" <> '') then
                    _ChangeMasterName.UpdateEstateGroupName("Group Code", "Group Name", xRec."Group Name");
            end;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(4; "Old Code"; Code[20])
        {
            Caption = 'Old Code';
            DataClassification = ToBeClassified;
        }
        field(5; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Group Code", "Group Name")
        {
        }
    }

    trigger OnDelete()
    var
        _Estate: Record DK_Estate;
    begin
        //DK_Estate Delete chec
        _Estate.Reset;
        _Estate.SetRange("Group Code", "Group Code");
        if not _Estate.IsEmpty then
            Error(MSG001, TableCaption, "Group Code", _Estate.TableCaption);
    end;

    trigger OnInsert()
    begin
        //>>No
        if "Group Code" = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Estate Group Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Estate Group Nos.", xRec."No. Series", 0D, "Group Code", "No. Series");
        end;
        TestField("Group Code");
        //<<No
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'You must select an existing %1.';

    procedure GetEstGroupCode(EstateGroupText: Text): Text
    var
        _EstateGroup: Record "DK_Estate Group";
    begin

        if EstateGroupText = '' then
            exit('');

        if StrLen(EstateGroupText) <= MaxStrLen(_EstateGroup."Group Code") then
            if _EstateGroup.Get(CopyStr(EstateGroupText, 1, MaxStrLen(_EstateGroup."Group Code"))) then
                exit(_EstateGroup."Group Code");

        _EstateGroup.SetRange("Group Name", EstateGroupText);
        if _EstateGroup.FindFirst then
            exit(_EstateGroup."Group Code");

    end;

    procedure GetEstGroupName(pEstGroupCode: Code[20]): Text
    var
        _EstateGroup: Record "DK_Estate Group";
    begin

        if _EstateGroup.Get(pEstGroupCode) then
            exit(_EstateGroup."Group Name");

        exit('');
    end;


    procedure AssistEdit(OldEstateGroup: Record "DK_Estate Group"): Boolean
    var
        _EstateGroup: Record "DK_Estate Group";
    begin

        with _EstateGroup do begin
            _EstateGroup := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Estate Group Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Estate Group Nos.", OldEstateGroup."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Group Code");
                Rec := _EstateGroup;
                exit(true);
            end;
        end;
    end;

    procedure GetEstateGroupCode(pEstateGroupText: Text): Text
    begin
        exit(GetEstateGroupCodeOpenCard(pEstateGroupText));
    end;

    procedure GetEstateGroupCodeOpenCard(pEstateGroupText: Text): Code[20]
    var
        _EstateGroup: Record "DK_Estate Group";
        _EstateGroupCode: Code[20];
        _NoFiltersApplied: Boolean;
        _EstateGroupWithoutQuote: Text;
        _EstateGroupFilterFromStart: Text;
        _EstateGroupFilterContains: Text;
    begin

        if pEstateGroupText = '' then
            exit('');

        if StrLen(pEstateGroupText) <= MaxStrLen(_EstateGroup."Group Code") then
            if _EstateGroup.Get(CopyStr(pEstateGroupText, 1, MaxStrLen(_EstateGroup."Group Code"))) then
                exit(_EstateGroup."Group Code");

        _EstateGroup.SetRange("Group Name", pEstateGroupText);
        if _EstateGroup.FindFirst then
            exit(_EstateGroup."Group Code");

        _EstateGroup.SetCurrentKey("Group Name");

        _EstateGroupWithoutQuote := ConvertStr(pEstateGroupText, '''', '?');
        _EstateGroup.SetFilter("Group Name", '''@' + _EstateGroupWithoutQuote + '''');
        if _EstateGroup.FindFirst then
            exit(_EstateGroup."Group Code");

        _EstateGroup.SetRange("Group Name");

        _EstateGroupFilterFromStart := '''@' + _EstateGroupWithoutQuote + '*''';

        _EstateGroup.FilterGroup := -1;
        _EstateGroup.SetFilter("Group Code", _EstateGroupFilterFromStart);
        _EstateGroup.SetFilter("Group Name", _EstateGroupFilterFromStart);

        if _EstateGroup.FindFirst then
            exit(_EstateGroup."Group Code");

        _EstateGroupFilterContains := '''@*' + _EstateGroupWithoutQuote + '*''';

        _EstateGroup.SetFilter("Group Code", _EstateGroupFilterContains);
        _EstateGroup.SetFilter("Group Name", _EstateGroupFilterContains);

        if _EstateGroup.Count = 1 then begin
            _EstateGroup.FindFirst;
            exit(_EstateGroup."Group Code");
        end;

        if not GuiAllowed then
            Error(MSG002, _EstateGroup.TableCaption);


        Error(MSG002, _EstateGroup.TableCaption);
    end;
}

