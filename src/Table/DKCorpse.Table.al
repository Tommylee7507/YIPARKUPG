table 50032 DK_Corpse
{
    // //ŠŽ˜À …Ñœ•
    //   *Field Work Main Cat. Code : —÷Î Žð‰½ „ÔŠ¨‡õ
    //     - Î‡š‡ž ×‘ñ¬ ¯‡’ : 001
    // *DK32 : 20200715
    //   - Modify Function : Laying Date - OnValidate()
    //                       OnInsert
    //                       OnDelete
    //   - Add Field : "First Corpse"
    // #2542 : 20210524
    //   - Add Field : "Cemetery Size"
    //                 "Main Customer Birthday"
    //                 "Main Customer No."

    Caption = 'Corpse';
    DataCaptionFields = "Contract No.", "Supervise No.", "Cemetery No.", Name;
    DrillDownPageID = "DK_Corpse List";
    LookupPageID = "DK_Corpse List";

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No.";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin

                if _Contract.Get("Contract No.") then begin
                    Validate("Cemetery Code", _Contract."Cemetery Code");
                    Validate("Supervise No.", _Contract."Supervise No.");
                end else begin
                    Validate("Cemetery Code", '');
                    Validate("Supervise No.", '');
                end;
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                if _Cemetery.Get("Cemetery Code") then
                    "Cemetery No." := _Cemetery."Cemetery No."
                else
                    "Cemetery No." := '';
            end;
        }
        field(5; "Cemetery No."; Text[50])
        {
            Caption = 'Cemetery No.';
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Cemetery Code", _Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(6; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = ToBeClassified;
        }
        field(8; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(9; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(10; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(11; "Death Date"; Date)
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Laying Date"; Date)
        {
            Caption = 'Laying Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _Contract: Record DK_Contract;
            begin
                if xRec."Laying Date" <> "Laying Date" then begin
                    //>>DK32
                    if "Laying Date" <> 0D then begin
                        if _Contract.Get("Contract No.") then begin
                            if _Contract."Contract Date" > "Laying Date" then
                                Error(MSG005, _Contract.FieldCaption("Contract Date"), _Contract."Contract Date",
                                              FieldCaption("Laying Date"), "Laying Date");
                        end;
                    end;
                    //<<DK32

                    if ("Laying Date" = 0D) or ("Laying Date" < 20010113D) then  //Œ‚‰ªŸÀ 2001-01-13Ÿ œ˜” ŠŽ˜À —¹„Ï
                        "Due Date 1st" := 0D
                    else begin

                        _Cemetery.Reset;
                        _Cemetery.SetRange("Cemetery No.", "Cemetery No.");
                        _Cemetery.SetRange("Cemetery Conf. Code", '001');//ˆ•Î ×‘ñ¬
                        if _Cemetery.FindSet then
                            "Due Date 1st" := CalcDate('<+30Y>', "Laying Date") - 1
                        else
                            "Due Date 1st" := 0D;//<<DK32
                    end;
                end;
            end;
        }
        field(13; "Death Cause"; Text[100])
        {
            Caption = 'Death Cause';
            DataClassification = ToBeClassified;
        }
        field(14; "Death Place"; Text[100])
        {
            Caption = 'Death Place';
            DataClassification = ToBeClassified;
        }
        field(15; Location; Text[20])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }
        field(16; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(17; "Temporary Grave Place Code"; Code[20])
        {
            Caption = 'Temporary Grave Place';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false),
                                                               Status = CONST(Unsold));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _ContractMgt: Codeunit "DK_Contract Mgt.";
            begin
                if _Cemetery.Get("Temporary Grave Place Code") then
                    "Temporary Grave Place" := _Cemetery."Cemetery No."
                else
                    "Temporary Grave Place" := '';

                Laying_TemporaryGrave;
            end;
        }
        field(18; "Temporary Grave Date"; Date)
        {
            Caption = 'Temporary Grave Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ContractMgt: Codeunit "DK_Contract Mgt.";
            begin
                Laying_TemporaryGrave;
            end;
        }
        field(19; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Move The Grave Type"; Boolean)
        {
            Caption = 'Move The Grave Type';
            DataClassification = ToBeClassified;
        }
        field(24; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Today Funeral';
            OptionMembers = "None",Today;
        }
        field(25; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            begin

                ShowDocument;
            end;
        }
        field(26; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Move The Grave Date"; Date)
        {
            Caption = 'Move The Grave Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name
                else
                    "Field Work Main Cat. Name" := '';
            end;
        }
        field(29; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", _FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(30; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then begin
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                end else begin
                    "Field Work Sub Cat. Name" := '';
                end;
            end;
        }
        field(31; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                Validate("Field Work Sub Cat. Code", _FieldWorkSubCategory.GetFieldWorkSCode("Field Work Sub Cat. Name", "Field Work Main Cat. Code"));
            end;
        }
        field(32; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = "None",Male,Female;
        }
        field(33; Relationship; Text[30])
        {
            Caption = 'Relationship';
            DataClassification = ToBeClassified;
        }
        field(34; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            DataClassification = ToBeClassified;
        }
        field(35; "Solar Lunar Calendar"; Option)
        {
            Caption = 'Solar Lunar Calendar';
            DataClassification = ToBeClassified;
            OptionCaption = 'Solar Calendar,Lunar Calendar';
            OptionMembers = Sola,Lunar;
        }
        field(36; "Invalid data"; Text[250])
        {
            Caption = 'Invalid data';
            DataClassification = ToBeClassified;
        }
        field(37; "Contract Status"; Option)
        {
            CalcFormula = Lookup(DK_Contract.Status WHERE("No." = FIELD("Contract No.")));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Contract,Full Payment,Revocation of Contract,Reservation';
            OptionMembers = Open,Contract,FullPayment,Revocation,Reservation;

            trigger OnValidate()
            var
                _ContractMgt: Codeunit "DK_Contract Mgt.";
            begin
            end;
        }
        field(38; "Temporary Grave Place"; Text[30])
        {
            Caption = 'Temporary Grave Place';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false),
                                                               Status = CONST(Unsold));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Temporary Grave Place Code", _Cemetery.GetCemeteryCode("Temporary Grave Place"));
            end;
        }
        field(39; "Due Date 1st"; Date)
        {
            Caption = 'Due Date 1st';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Due Date 2nd"; Date)
        {
            Caption = 'Due Date 2nd';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CalcDueDate: Date;
            begin
                if xRec."Due Date 2nd" <> "Due Date 2nd" then begin
                    if "Due Date 2nd" <> 0D then begin

                        if "Due Date 1st" = 0D then
                            Error(MSG002, FieldCaption("Due Date 1st"), FieldCaption("Due Date 2nd"));

                        if "Due Date 1st" > "Due Date 2nd" then
                            Error(MSG003, FieldCaption("Due Date 1st"), "Due Date 1st");

                        //Check Period
                        _CalcDueDate := CalcDate('<+60Y>', "Due Date 1st") - 1;
                        if _CalcDueDate < "Due Date 2nd" then
                            Error(MSG004, FieldCaption("Due Date 2nd"), _CalcDueDate);
                    end;
                end;
            end;
        }
        field(2000; "Cemetery Size"; Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery.Size WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Size';
            DecimalPlaces = 0 : 2;
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(2001; "Main Customer Birthday"; Date)
        {
            CalcFormula = Lookup(DK_Customer.Birthday WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Birthday';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2002; "Main Customer No."; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."Main Customer No." WHERE("No." = FIELD("Contract No.")));
            Caption = 'Main Customer No.';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4000; "First Corpse"; Boolean)
        {
            Caption = 'First Corpse';
            DataClassification = ToBeClassified;
            Description = 'DK32';
        }
        field(50000; "Sorce Creation Date"; DateTime)
        {
            CalcFormula = Lookup("DK_Today Funeral"."Creation Date" WHERE("No." = FIELD("Source No.")));
            Caption = 'Sorce Creation Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Sorce Creation Person"; Code[50])
        {
            CalcFormula = Lookup("DK_Today Funeral"."Creation Person" WHERE("No." = FIELD("Source No.")));
            Caption = 'Sorce Creation Person';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59000; Idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Contract No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Laying Date")
        {
        }
        key(Key3; "Contract No.", "Laying Date")
        {
        }
        key(Key4; "Move The Grave Type", Name, "Contract No.")
        {
        }
        key(Key5; Name)
        {
        }
        key(Key6; "Death Date")
        {
        }
        key(Key7; "Field Work Main Cat. Name")
        {
        }
        key(Key8; "Field Work Sub Cat. Name")
        {
        }
        key(Key9; Gender)
        {
        }
        key(Key10; Relationship)
        {
        }
        key(Key11; "Due Date 1st")
        {
        }
        key(Key12; "Due Date 2nd")
        {
        }
        key(Key13; "Temporary Grave Place")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _CorpseMgt: Codeunit "DK_Corpse Mgt.";
    begin
        //>>DK32
        Clear(_CorpseMgt);
        //// if "First Corpse" then
        ////     _CorpseMgt.DelFirstCorpse(Rec);
        //<<DK32

        Clear(ContractMgt);
        //// ContractMgt.UpdateCorpsetoChangeCemeteryStatus(Rec, true);
    end;

    trigger OnInsert()
    var
        _Corpse: Record DK_Corpse;
        _LastLineNo: Integer;
        _Contract: Record DK_Contract;
    begin
        //>>DK32
        TestField("Contract No.");

        _Corpse.Reset;
        _Corpse.SetRange("Contract No.", "Contract No.");
        if _Corpse.FindLast then
            _LastLineNo := _Corpse."Line No."
        else begin

            if _Contract.Get("Contract No.") then begin
                _Contract.CalcFields("Admin. Expense Method", "Landscape Architecture");

                //“´“š ŠŽ˜À Šž
                if _Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract then
                    "First Corpse" := true;

                if "Laying Date" <> 0D then begin

                    if _Contract."Admin. Expense Option" <> _Contract."Admin. Expense Option"::"Per Group" then begin
                        if _Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract then begin
                            _Contract."General Expiration Date" := "Laying Date" - 1;

                            if _Contract."Landscape Architecture" then
                                _Contract."Land. Arc. Expiration Date" := "Laying Date" - 1;
                            _Contract.Modify(false);
                        end;
                    end else begin
                        _Contract."General Expiration Date" := 0D;
                        _Contract."Land. Arc. Expiration Date" := 0D;
                        _Contract.Modify(false);
                    end;
                end;
            end;
        end;

        "Line No." := _LastLineNo + 10000;
        //<<DK32

        Clear(ContractMgt);
        //// ContractMgt.UpdateCorpsetoChangeCemeteryStatus(Rec, false);

        if "Field Work Main Cat. Code" <> '' then
            "Field Work Main Cat. Code" := '001';

        "Sorce Creation Date" := CurrentDateTime;
        "Sorce Creation Person" := UserId;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        // >>#2553
        Clear(ContractMgt);
        //// ContractMgt.UpdateCorpsetoChangeCemeteryStatus(Rec, false);
        // <<

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        ContractMgt: Codeunit "DK_Contract Mgt.";
        MSG001: Label 'The target Document can not be found. %1 %2:%3';
        MSG002: Label 'The value does not exist in %1. You cannot specify a value for %2.';
        MSG003: Label 'You cannot specify a value less than the specified %2 of %1.';
        MSG004: Label 'The maximum value you can specify for %1 is %2. Please specify a value within %2.';
        MSG005: Label '%3 cannot be less than %1. %1:%2, %3:%4';


    procedure ShowDocument()
    var
        _TodayFuneral: Record "DK_Today Funeral";
        _TodayFuneralCard: Page "DK_Today Funeral Card";
    begin

        case "Source Type" of
            "Source Type"::Today:
                begin

                    if _TodayFuneral.Get("Source No.") then begin

                        Clear(_TodayFuneralCard);
                        _TodayFuneralCard.LookupMode(true);
                        _TodayFuneralCard.SetTableView(_TodayFuneral);
                        _TodayFuneralCard.SetRecord(_TodayFuneral);
                        _TodayFuneralCard.Editable(false);
                        _TodayFuneralCard.RunModal;
                    end else begin
                        Error(MSG001, "Source Type"::None, _TodayFuneral.FieldCaption("No."), "Source No.");
                    end;
                end;
        end;
    end;

    local procedure Laying_TemporaryGrave()
    var
        _ContractMgt: Codeunit "DK_Contract Mgt.";
    begin

        //// if ("Temporary Grave Place Code" <> '') and
        ////   ("Temporary Grave Date" <> 0D) then
        ////     _ContractMgt.UpdateCorpseTemporayPlaceLaying(Rec, true);
    end;
}

