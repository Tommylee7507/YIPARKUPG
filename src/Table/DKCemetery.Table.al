table 50004 "DK_Cemetery"
{
    // #1974 :20200623
    //   - Modify Field : "Estate Type".OptionString
    //                   Original : Blank,Stairs,Funeral Urn,Tree,Nature
    //                   Modify : Blank,Stairs,Funeral Urn,Tree,Nature,Charnelhouse
    // *DK32 : 20200716
    //   - Add Field : Admin. Expense Method
    //   - Modify Function : Estate Code - OnValidate()
    // 
    // #2106 : 20200818
    //   - Modify Trigger: Position Row - OnValidate, Position Column - OnValidate
    // 
    // DK34 : 20201130
    //   - Modify Field: "No. of Corpse"

    Caption = 'Cemetery';
    DrillDownPageID = "DK_Cemetery List";
    LookupPageID = "DK_Cemetery List";

    fields
    {
        field(1; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "Cemetery Code" <> xRec."Cemetery Code" then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Cemetery Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Estate Code"; Code[20])
        {
            Caption = 'Estate Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Estate;

            trigger OnValidate()
            begin
                TestField(Status, Status::Unsold);

                if Estate.Get("Estate Code") then
                    "Estate Name" := Estate.Name
                else
                    "Estate Name" := '';

                CalcFields("Estate Type", "Group Contract", "Charnel House");
                //>>DK32
                CalcFields("Admin. Expense Method");
                //<<DK32
                if xRec."Estate Code" <> "Estate Code" then begin
                    "Position Column" := 0;
                    "Position Row" := 0;
                    "Tree Type Code" := '';
                    "Tree Type Name" := '';
                end;
            end;
        }
        field(3; "Estate Name"; Text[50])
        {
            Caption = 'Estate Name';
            TableRelation = DK_Estate.Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Estate Code", Estate.GetEstateCode("Estate Name"));
            end;
        }
        field(4; "Cemetery Conf. Code"; Code[20])
        {
            Caption = 'Cemetery Conformation Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Cemetery Conformation";

            trigger OnValidate()
            begin
                //TESTFIELD(Status, Status::Unsold);

                if CemeteryConf.Get("Cemetery Conf. Code") then
                    "Cemetery Conf. Name" := CemeteryConf.Name
                else
                    "Cemetery Conf. Name" := '';

                if xRec."Cemetery Conf. Code" <> "Cemetery Conf. Code" then begin
                    "Cemetery Dig. Code" := '';
                    "Cemetery Dig. Name" := '';

                end;
            end;
        }
        field(5; "Cemetery Conf. Name"; Text[50])
        {
            Caption = 'Cemetery Conformation Name';
            TableRelation = "DK_Cemetery Conformation".Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                Validate("Cemetery Conf. Code", CemeteryConf.GetCemeteryConfCode("Cemetery Conf. Name"));
            end;
        }
        field(6; "Cemetery Option Code"; Code[20])
        {
            Caption = 'Cemetery Option Code';
            FieldClass = Normal;
            TableRelation = "DK_Cemetery Option";

            trigger OnValidate()
            begin
                //TESTFIELD(Status, Status::Unsold);

                if CemeteryOpti.Get("Cemetery Option Code") then
                    "Cemetery Option Name" := CemeteryOpti.Name
                else
                    "Cemetery Option Name" := '';
            end;
        }
        field(7; "Cemetery Option Name"; Text[50])
        {
            Caption = 'Cemetery Option Name';
            TableRelation = "DK_Cemetery Option".Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Cemetery Option Code", CemeteryOpti.GetCemeteryOptionCode("Cemetery Option Name"));
            end;
        }
        field(8; "Unit Price Type Code"; Code[20])
        {
            Caption = 'Unit Price Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Unit Price Type";

            trigger OnValidate()
            begin
                GetUserSetUp;

                if UnitPriceType.Get("Unit Price Type Code") then
                    "Unit Price Type Name" := UnitPriceType.Name
                else
                    "Unit Price Type Name" := '';
            end;
        }
        field(9; "Unit Price Type Name"; Text[50])
        {
            Caption = 'Unit Price Type Name';
            TableRelation = "DK_Unit Price Type".Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Unit Price Type Code", UnitPriceType.GetUnitPriceTypeCode("Unit Price Type Name"));
            end;
        }
        field(10; Size; Decimal)
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec.Size <> Size then begin

                    GetUserSetUp;

                    CalcFields("Contract No.");
                    if "Contract No." <> '' then
                        if not (Status in [Status::Unsold, Status::BeenTransported]) then
                            if not Confirm(MSG007, false, FieldCaption(Size), xRec.Size, Size, "Contract No.") then
                                Error(MSG006, FieldCaption(Size));

                    "Size 2" := Round(Size * 3.3, 0.01, '=');
                end;
            end;
        }
        field(11; "GPS-X"; Text[30])
        {
            Caption = 'GPS-X';
            DataClassification = ToBeClassified;
        }
        field(12; "GPS-Y"; Text[30])
        {
            Caption = 'GPS-Y';
            DataClassification = ToBeClassified;
        }
        field(13; "Landscape Architecture"; Boolean)
        {
            Caption = 'Landscape Architecture';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetUserSetUp;
                //TESTFIELD(Status, Status::Unsold);
            end;
        }
        field(14; "Estate Type"; Option)
        {
            CalcFormula = Lookup(DK_Estate.Type WHERE(Code = FIELD("Estate Code")));
            Caption = 'Estate Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Stairs,Funeral Urn,Tree,Nature,Charnel house';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature,Charnelhouse;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Unsold,Reserved Tomb,Contracted Tomb,Laying Tomb,Been Transported Tomb';
            OptionMembers = Unsold,Reserved,Contracted,Laying,BeenTransported;
        }
        field(16; "Charnel House"; Boolean)
        {
            CalcFormula = Lookup(DK_Estate."Charnel House" WHERE(Code = FIELD("Estate Code")));
            Caption = 'Charnel House';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Cemetery Dig. Code"; Code[20])
        {
            Caption = 'Digits Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Cemetery Digits".Code WHERE("Cemetery Conf. Code" = FIELD("Cemetery Conf. Code"));

            trigger OnValidate()
            begin
                //TESTFIELD(Status, Status::Unsold);

                if CemeteryDigi.Get("Cemetery Conf. Code", "Cemetery Dig. Code") then
                    "Cemetery Dig. Name" := CemeteryDigi.Name
                else
                    "Cemetery Dig. Name" := '';
            end;
        }
        field(21; "Cemetery Dig. Name"; Text[50])
        {
            Caption = 'Digits Name';
            TableRelation = "DK_Cemetery Digits".Name WHERE("Cemetery Conf. Code" = FIELD("Cemetery Conf. Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Cemetery Dig. Code", CemeteryDigi.GetCemeteryDigitsCode("Cemetery Conf. Code", "Cemetery Dig. Name"));
            end;
        }
        field(22; "Visual Zone"; Option)
        {
            Caption = 'Visual Zone';
            DataClassification = ToBeClassified;
            OptionCaption = ',A,B,C,D,E,F';
            OptionMembers = Blank,A,B,C,D,E,F;
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(24; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if xRec."Cemetery No." <> "Cemetery No." then begin
                    TestField(Status, Status::Unsold);

                    if "Cemetery No." <> '' then begin
                        _Cemetery.Reset;
                        _Cemetery.SetRange("Cemetery No.", "Cemetery No.");
                        _Cemetery.SetFilter("Cemetery Code", '<>%1', "Cemetery Code");
                        if _Cemetery.FindFirst then
                            Error(MSG002, _Cemetery."Cemetery Code", "Cemetery No.");

                        _ChangeMasterName.UpdateCemeteryNo("Cemetery Code", "Cemetery No.", xRec."Cemetery No.");
                    end;
                end;
            end;
        }
        field(30; Class; Option)
        {
            Caption = 'Class';
            DataClassification = ToBeClassified;
            OptionCaption = 'A,B,C,D';
            OptionMembers = A,B,C,D;

            trigger OnValidate()
            begin
                //TESTFIELD(Status, Status::Unsold);
            end;
        }
        field(31; "Size 2"; Decimal)
        {
            Caption = 'Size 2';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                GetUserSetUp;
            end;
        }
        field(32; "Corpse Size"; Decimal)
        {
            Caption = 'Corpse Size';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Unsold);
            end;
        }
        field(33; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(34; "Contract No."; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."No." WHERE("Cemetery Code" = FIELD("Cemetery Code"),
                                                          Status = FILTER(<> Revocation)));
            Caption = 'Contract No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Unsold);
            end;
        }
        field(35; "No. of Corpse"; Integer)
        {
            CalcFormula = Count(DK_Corpse WHERE("Cemetery Code" = FIELD("Cemetery Code"),
                                                 "Contract Status" = FILTER(<> Revocation),
                                                 "Move The Grave Type" = CONST(false)));
            Caption = 'No. of Corpse';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Group Contract"; Boolean)
        {
            CalcFormula = Lookup(DK_Estate."Group Contract" WHERE(Code = FIELD("Estate Code")));
            Caption = 'Group Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Position Row"; Integer)
        {
            BlankZero = true;
            Caption = 'Position Row';
            DataClassification = ToBeClassified;
            MaxValue = 10;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Position Row" <> "Position Row" then begin
                    if "Position Row" <> 0 then begin
                        // >> #2106
                        // CALCFIELDS("Charnel House");
                        // IF NOT "Charnel House" THEN
                        CalcFields("Estate Type");
                        if "Estate Type" <> "Estate Type"::Charnelhouse then
                            Error(MSG005, FieldCaption("Estate Name"), "Estate Name");
                        // <<
                    end;
                end;
            end;
        }
        field(38; "Position Column"; Integer)
        {
            BlankZero = true;
            Caption = 'Position Column';
            DataClassification = ToBeClassified;
            MaxValue = 500;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Position Column" <> "Position Column" then begin
                    if "Position Column" <> 0 then begin
                        // >> #2106
                        // CALCFIELDS("Charnel House");
                        // IF NOT "Charnel House" THEN
                        CalcFields("Estate Type");
                        if "Estate Type" <> "Estate Type"::Charnelhouse then
                            Error(MSG005, FieldCaption("Estate Name"), "Estate Name");
                        // <<
                    end;
                end;
            end;
        }
        field(39; Stone; Boolean)
        {
            Caption = 'Stone';
            DataClassification = ToBeClassified;
        }
        field(40; "Visual Cemetery No."; Text[30])
        {
            Caption = 'Visual Cemetery No.';
            DataClassification = ToBeClassified;
        }
        field(41; "Tree Type Code"; Code[20])
        {
            Caption = 'Cemetery Option Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Estate Type" = CONST(Tree)) "DK_Tree Type";

            trigger OnValidate()
            begin
                //TESTFIELD(Status, Status::Unsold);

                if TreeType.Get("Tree Type Code") then
                    "Tree Type Name" := TreeType.Name
                else
                    "Tree Type Name" := '';
            end;
        }
        field(42; "Tree Type Name"; Text[50])
        {
            Caption = 'Cemetery Option Name';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Estate Type" = CONST(Tree)) "DK_Tree Type".Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Tree Type Code", TreeType.GetTreeTypeCode("Tree Type Name"));
            end;
        }
        field(43; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetUserSetUp;
            end;
        }
        field(4000; "Admin. Expense Method"; Option)
        {
            CalcFormula = Lookup(DK_Estate."Admin. Expense Method" WHERE(Code = FIELD("Estate Code")));
            Caption = 'Admin. Expense Method';
            Description = 'DK32';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Contract,After Corpse';
            OptionMembers = Contract,"After Corpse 10";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
            end;
        }
        field(10000; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(10001; "Group Contract Filter"; Code[20])
        {
            Caption = 'Group Contract Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Cemetery Code")
        {
            Clustered = true;
        }
        key(Key2; "Estate Code")
        {
        }
        key(Key3; "Cemetery Conf. Code")
        {
        }
        key(Key4; "Cemetery Dig. Code")
        {
        }
        key(Key5; "Cemetery No.")
        {
        }
        key(Key6; Size)
        {
        }
        key(Key7; Status)
        {
        }
        key(Key8; "Estate Name")
        {
        }
        key(Key9; "Cemetery Conf. Name")
        {
        }
        key(Key10; "Cemetery Dig. Name")
        {
        }
        key(Key11; "Landscape Architecture")
        {
        }
        key(Key12; "Visual Zone")
        {
        }
        key(Key13; "Estate Code", "Cemetery No.")
        {
        }
        key(Key14; "Tree Type Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cemetery Code", "Cemetery No.", "Estate Name", "Cemetery Conf. Name", "Estate Type", Status, "Landscape Architecture", "Cemetery Dig. Name", "Tree Type Name", "No. of Corpse")
        {
        }
    }

    trigger OnDelete()
    var
        _Contract: Record DK_Contract;
        _Picture: Record DK_Picture;
    begin

        _Contract.Reset;
        _Contract.SetRange("Cemetery Code", "Cemetery Code");
        if not _Contract.IsEmpty then
            Error(MSG003, TableCaption, "Cemetery Code", _Contract.TableCaption);

        _Picture.DeletePicture(DATABASE::DK_Cemetery, "Cemetery Code", 0);
    end;

    trigger OnInsert()
    var
        _Picture: Record DK_Picture;
    begin

        if "Cemetery Code" = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Cemetery Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Cemetery Nos.", xRec."No. Series", 0D, "Cemetery Code", "No. Series");
        end;

        TestField("Cemetery Code");

        //Picture
        _Picture.Init;
        _Picture."Table ID" := DATABASE::DK_Cemetery;
        _Picture."Source No." := "Cemetery Code";
        _Picture."Source Line No." := 0;
        _Picture.Insert(true);
        //Picture

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'The No. field is empty.';
        EstateRec: Record DK_Estate;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG002: Label 'is a value that already exists. Current value : %2';
        MSG003: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        Estate: Record DK_Estate;
        CemeteryConf: Record "DK_Cemetery Conformation";
        CemeteryOpti: Record "DK_Cemetery Option";
        UnitPriceType: Record "DK_Unit Price Type";
        CemeteryDigi: Record "DK_Cemetery Digits";
        MSG004: Label 'You must select an existing %1.';
        MSG005: Label 'You can not specify a value.';
        TreeType: Record "DK_Tree Type";
        MSG006: Label 'The %1 change has been canceled.';
        MSG007: Label '%1‹ %2 íŒ¡ %3 ˆ‡ž Š»µ—ŸŒœ„Ÿ„¾. %1 — Š»µŠ —÷Ï ÐŽÊ— ýˆ«Š±ˆª Ð‹Ó—Ÿ„’…Ñ …—Ë‹ ‘¦„Ÿ„¾. ‘ñˆ‹‡ž %1(‹)ˆª Š»µ—Ÿ“À„Ÿ€Ø? ÐŽÊ‰°˜ú : %4';
        MSG008: Label 'Œ÷‘ñ €——©œ Ž°„Ÿ„¾. ýˆ«Àí¯ ‰«——ŸŒŒÍ.';


    procedure AssistEdit(OldCemetery: Record DK_Cemetery): Boolean
    var
        _Cemetery: Record DK_Cemetery;
    begin
        with _Cemetery do begin
            _Cemetery := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Cemetery Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Cemetery Nos.", OldCemetery."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Cemetery Code");
                Rec := _Cemetery;
                exit(true);
            end;
        end;
    end;

    procedure GetCemeteryCode(pCemText: Text): Text
    begin
        exit(GetCemeteryCodeOpenCard(pCemText));
    end;

    procedure GetCemeteryCodeOpenCard(pCemText: Text): Code[20]
    var
        _Cemetery: Record DK_Cemetery;
        _CemeteryNo: Code[20];
        _CemeteryWithoutQuote: Text;
        _CemeteryFilterFromStart: Text;
        _CemeteryFilterContains: Text;
    begin
        if pCemText = '' then
            exit('');

        if StrLen(pCemText) <= MaxStrLen(_Cemetery."Cemetery Code") then
            if _Cemetery.Get(CopyStr(pCemText, 1, MaxStrLen(_Cemetery."Cemetery Code"))) then
                exit(_Cemetery."Cemetery Code");

        _Cemetery.SetRange(Blocked, false);
        _Cemetery.SetRange("Cemetery No.", pCemText);
        if _Cemetery.FindFirst then
            exit(_Cemetery."Cemetery Code");

        _Cemetery.SetCurrentKey("Cemetery No.");

        _CemeteryWithoutQuote := ConvertStr(pCemText, '''', '?');
        _Cemetery.SetFilter("Cemetery No.", '''@' + _CemeteryWithoutQuote + '''');
        if _Cemetery.FindFirst then
            exit(_Cemetery."Cemetery Code");

        _Cemetery.SetRange("Cemetery No.");

        _CemeteryFilterFromStart := '''@' + _CemeteryWithoutQuote + '*''';

        _Cemetery.FilterGroup := -1;
        _Cemetery.SetFilter("Cemetery Code", _CemeteryFilterFromStart);
        _Cemetery.SetFilter("Cemetery No.", _CemeteryFilterFromStart);

        if _Cemetery.FindFirst then
            exit(_Cemetery."Cemetery Code");

        _CemeteryFilterContains := '''@*' + _CemeteryWithoutQuote + '*''';

        _Cemetery.SetFilter("Cemetery Code", _CemeteryFilterContains);
        _Cemetery.SetFilter("Cemetery No.", _CemeteryFilterContains);

        if _Cemetery.Count = 1 then begin
            _Cemetery.FindFirst;
            exit(_Cemetery."Cemetery Code");
        end;

        if not GuiAllowed then
            Error(MSG004, _Cemetery.TableCaption);


        Error(MSG004, _Cemetery.TableCaption);
    end;

    local procedure GetUserSetUp()
    var
        _UserSetup: Record "User Setup";
    begin

        if Status <> Status::Unsold then begin
            _UserSetup.Reset;
            _UserSetup.SetRange("User ID", UserId);
            _UserSetup.SetRange("DK_Contract Rel. Cem. Admin.", true);
            if not _UserSetup.FindSet then
                Error(MSG008);
        end;
    end;
}

