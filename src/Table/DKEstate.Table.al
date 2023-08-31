table 50001 DK_Estate
{
    // #1974 :20200623
    //   - Modify Field : "Type".OptionString
    //                   Original : Blank,Stairs,Funeral Urn,Tree,Nature
    //                   Modify : Blank,Stairs,Funeral Urn,Tree,Nature,Charnelhouse
    // *DK32 : 20200716
    //   - Add Field : Admin. Expense  Method
    //   - Add C/AL Globals(Text Contents) : MSG004
    //   - Add Key : Admin. Expense Method
    //   - Modify DropDownCode,Name,Type,Admin. Expense Method

    Caption = 'Estate';
    DataCaptionFields = "Code", Name, Type;
    DrillDownPageID = DK_Estate;
    LookupPageID = DK_Estate;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Estate Nos.");
                    "No. Series" := '';
                end;
            end;
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
                    _ChangeMasterName.UpdateEstateName(Code, Name, xRec.Name);
            end;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Stairs,Funeral Urn,Tree,Nature,Charnel house';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature,Charnelhouse;
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(5; "Old Code"; Code[20])
        {
            Caption = 'Old Code';
            DataClassification = ToBeClassified;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(7; "Group Contract"; Boolean)
        {
            Caption = 'Group Contract';
            DataClassification = ToBeClassified;
        }
        field(8; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Estate Group" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                if EstateGroup.Get("Group Code") then
                    "Group Name" := EstateGroup."Group Name"
                else
                    "Group Name" := '';
            end;
        }
        field(9; "Group Name"; Text[50])
        {
            Caption = 'Group Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Estate Group"."Group Name" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Group Code", EstateGroup.GetEstateGroupCode("Group Name"));
            end;
        }
        field(10; "No. of Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE("Estate Code" = FIELD(Code)));
            Caption = 'No. of Register Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "No. of Unsold Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE("Estate Code" = FIELD(Code),
                                                   Status = CONST(Unsold)));
            Caption = 'No. of Unsold Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "No. of Reserved Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE("Estate Code" = FIELD(Code),
                                                   Status = CONST(Reserved)));
            Caption = 'No. of Reserved Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "No. of Contracted Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE("Estate Code" = FIELD(Code),
                                                   Status = CONST(Contracted)));
            Caption = 'No. of Contracted Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "No. of Used Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE("Estate Code" = FIELD(Code),
                                                   Status = CONST(Laying)));
            Caption = 'No. of Used Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "No. of Been Transp. Ceme."; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE("Estate Code" = FIELD(Code),
                                                   Status = CONST(BeenTransported)));
            Caption = 'No. of Been Transp. Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Charnel House"; Boolean)
        {
            Caption = 'Charnel House';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                TestField(Code);
                TestField(Name);

                if xRec."Charnel House" <> "Charnel House" then begin
                    if not "Charnel House" then begin
                        _Cemetery.Reset;
                        _Cemetery.SetRange("Estate Code", Code);
                        _Cemetery.FilterGroup := -1;
                        _Cemetery.SetFilter("Position Column", '<>%1', 0);
                        _Cemetery.SetFilter("Position Row", '<>%1', 0);
                        if _Cemetery.FindSet then
                            Error(MSG003, _Cemetery.Count);
                    end;
                end;
            end;
        }
        field(4000; "Admin. Expense Method"; Option)
        {
            Caption = 'Admin. Expense Method';
            DataClassification = ToBeClassified;
            Description = 'DK32';
            OptionCaption = 'Contract,After Corpse';
            OptionMembers = Contract,"After Corpse 10";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                //>>DK32
                if xRec."Admin. Expense Method" <> "Admin. Expense Method" then begin
                    if Code <> '' then begin
                        _Contract.Reset;
                        _Contract.SetRange("Estate Code", Code);
                        _Contract.SetFilter(Status, '%1|%2|%3|%4', _Contract.Status::Open,
                                                               _Contract.Status::Reservation,
                                                               _Contract.Status::Contract,
                                                               _Contract.Status::FullPayment);
                        if _Contract.FindSet then
                            Error(MSG004, _Contract.Count);
                    end;
                end;
                //<<DK32
            end;
        }
        field(5000; "Report Type"; Option)
        {
            Caption = 'Report Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Other,Jungmyung,Sky,Three';
            OptionMembers = Other,Jung,Sky,Three;
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
        key(Key3; Type)
        {
        }
        key(Key4; "Admin. Expense Method")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name, Type, "Admin. Expense Method")
        {
        }
    }

    trigger OnDelete()
    var
        _Cemetery: Record DK_Cemetery;
        MSG001: Label 'The value is currently in use on %1 and can not be deleted.';
    begin

        // DK_Cemetery Delete check
        _Cemetery.Reset;
        _Cemetery.SetRange("Estate Code", Code);
        if not _Cemetery.IsEmpty then
            Error(MSG001, TableCaption, Code, _Cemetery.TableCaption);
    end;

    trigger OnInsert()
    begin

        //>>No
        if Code = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Estate Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Estate Nos.", xRec."No. Series", 0D, Code, "No. Series");
        end;
        TestField(Code);
        TestField(Name);
        //<<No
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'You must select an existing %1.';
        EstateGroup: Record "DK_Estate Group";
        MSG003: Label 'You can not specify this value.';
        MSG004: Label 'You can not specify this value.';

    procedure GetEstNo(EstateText: Text): Text
    var
        DK_Estate: Record DK_Estate;
    begin
        if EstateText = '' then
            exit('');

        if StrLen(EstateText) <= MaxStrLen(DK_Estate.Code) then
            if DK_Estate.Get(CopyStr(EstateText, 1, MaxStrLen(DK_Estate.Code))) then
                exit(DK_Estate.Code);

        DK_Estate.SetRange(Name, EstateText);
        if DK_Estate.FindFirst then
            exit(DK_Estate.Code);
    end;

    procedure GetEstName(pEstCode: Code[20]): Text
    var
        _Estate: Record DK_Estate;
    begin
        if _Estate.Get(pEstCode) then
            exit(_Estate.Name);

        exit('');
    end;


    procedure AssistEdit(OldEstate: Record DK_Estate): Boolean
    var
        _Estate: Record DK_Estate;
    begin
        with _Estate do begin
            _Estate := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Estate Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Estate Nos.", OldEstate."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries(Code);
                Rec := _Estate;
                exit(true);
            end;
        end;
    end;

    procedure GetEstateCode(pEstateText: Text): Text
    begin
        exit(GetEstateCodeOpenCard(pEstateText));
    end;

    procedure GetEstateCodeOpenCard(pEstateText: Text): Code[20]
    var
        _Estate: Record DK_Estate;
        _EstateNo: Code[20];
        _NoFiltersApplied: Boolean;
        _EstateWithoutQuote: Text;
        _EstateFilterFromStart: Text;
        _EstateFilterContains: Text;
    begin
        if pEstateText = '' then
            exit('');

        if StrLen(pEstateText) <= MaxStrLen(_Estate.Code) then
            if _Estate.Get(CopyStr(pEstateText, 1, MaxStrLen(_Estate.Code))) then
                exit(_Estate.Code);

        _Estate.SetRange(Name, pEstateText);
        if _Estate.FindFirst then
            exit(_Estate.Code);

        _Estate.SetCurrentKey(Name);

        _EstateWithoutQuote := ConvertStr(pEstateText, '''', '?');
        _Estate.SetFilter(Name, '''@' + _EstateWithoutQuote + '''');
        if _Estate.FindFirst then
            exit(_Estate.Code);

        _Estate.SetRange(Name);

        _EstateFilterFromStart := '''@' + _EstateWithoutQuote + '*''';

        _Estate.FilterGroup := -1;
        _Estate.SetFilter(Code, _EstateFilterFromStart);
        _Estate.SetFilter(Name, _EstateFilterFromStart);

        if _Estate.FindFirst then
            exit(_Estate.Code);

        _EstateFilterContains := '''@*' + _EstateWithoutQuote + '*''';

        _Estate.SetFilter(Code, _EstateFilterContains);
        _Estate.SetFilter(Name, _EstateFilterContains);

        if _Estate.Count = 1 then begin
            _Estate.FindFirst;
            exit(_Estate.Code);
        end;

        if not GuiAllowed then
            Error(MSG002, _Estate.TableCaption);


        Error(MSG002, _Estate.TableCaption);
    end;
}

