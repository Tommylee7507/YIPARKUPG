table 50084 "DK_Today Funeral Line"
{
    Caption = 'Today Funeral Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Corpse Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Corpse Line No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Type" = CONST("Move The Grave")) DK_Corpse."Line No." WHERE("Contract No." = FIELD("Contract No."));

            trigger OnValidate()
            var
                _Corpse: Record DK_Corpse;
                _TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
            begin

                _TodayFuneralPost.Insert_MoveInfo(Rec);
            end;
        }
        field(6; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false),
                                                               Status = CONST(Unsold));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Check_MoveTheGrave;

                if _Cemetery.Get("Cemetery Code") then
                    "Cemetery No." := _Cemetery."Cemetery No."
                else
                    "Cemetery No." := '';
            end;
        }
        field(7; "Cemetery No."; Text[50])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Cemetery Code", _Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(8; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(9; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
            begin
                Check_MoveTheGrave;

                _TodayFuneralPost.SSN_Onvalidate(Rec);
            end;
        }
        field(10; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(11; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(12; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(13; "Death Date"; Date)
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(14; "Laying Date"; Date)
        {
            Caption = 'Laying Date';
            DataClassification = ToBeClassified;
        }
        field(15; "Death Cause"; Text[100])
        {
            Caption = 'Death Cause';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(16; "Death Place"; Text[100])
        {
            Caption = 'Death Place';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(17; Location; Text[20])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(18; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_MoveTheGrave;
            end;
        }
        field(19; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Catgory Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category" WHERE(Blocked = CONST(false));

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
        field(20; "Field Work Main Cat. Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Field Work Main Category".Name WHERE(Code = FIELD("Field Work Main Cat. Code")));
            Caption = 'Field Work Main Cat. Name';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", _FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(21; "Move The Grave Date"; Date)
        {
            Caption = 'Move The Grave Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Funeral,Move The Grave';
            OptionMembers = Funeral,"Move The Grave";
        }
        field(23; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
                _TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
            begin

                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then begin
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                end else begin
                    "Field Work Sub Cat. Name" := '';
                end;

                _TodayFuneralPost.Change_TodayHeaderWorkGroup(Rec);
            end;
        }
        field(24; "Field Work Sub Cat. Name"; Text[30])
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
        field(25; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = "None",Male,Female;
        }
        field(26; Relationship; Text[30])
        {
            Caption = 'Relationship';
            DataClassification = ToBeClassified;
        }
        field(27; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            DataClassification = ToBeClassified;
        }
        field(28; "Solar Lunar Calendar"; Option)
        {
            Caption = 'Solar Lunar Calendar';
            DataClassification = ToBeClassified;
            OptionCaption = 'Solar Calendar,Lunar Calendar';
            OptionMembers = Solar,Lunar;
        }
        field(29; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Complete';
            OptionMembers = Open,Complete;
        }
        field(30; "Temporary Grave Place Code"; Code[20])
        {
            Caption = 'Temporary Grave Place Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false),
                                                               Status = CONST(Unsold));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin

                if _Cemetery.Get("Temporary Grave Place Code") then
                    "Temporary Grave Place Name" := _Cemetery."Cemetery No."
                else
                    "Temporary Grave Place Name" := '';
            end;
        }
        field(31; "Temporary Grave Place Name"; Text[30])
        {
            Caption = 'Temporary Grave Place Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false),
                                                               Status = CONST(Unsold));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Temporary Grave Place Code", _Cemetery.GetCemeteryCode("Temporary Grave Place Name"));
            end;
        }
        field(32; "Temporary Grave Date"; Date)
        {
            Caption = 'Temporary Grave Date';
            DataClassification = ToBeClassified;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Contract No.")
        {
        }
        key(Key3; Name)
        {
        }
        key(Key4; "Death Date")
        {
        }
        key(Key5; "Laying Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Line No.", Name, "Death Date")
        {
        }
    }

    trigger OnInsert()
    begin


        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'Do you want to insert the selected information?';
        MSG002: Label 'If it is a %1, you can not enter it.';


    procedure Check_MoveTheGrave()
    var
        _TodayFuneral: Record "DK_Today Funeral";
    begin
        if _TodayFuneral.Get("Document No.") then
            if (_TodayFuneral."Contract No." <> '') and
              (_TodayFuneral."Funeral Type" = _TodayFuneral."Funeral Type"::Move) then begin
                Error(MSG002, _TodayFuneral."Funeral Type"::Move);
            end;
    end;


    procedure GetTodayFuneralHeader()
    var
        _TodayFuneral: Record "DK_Today Funeral";
    begin
        if _TodayFuneral.Get("Document No.") then begin
            _TodayFuneral.TestField(Status, _TodayFuneral.Status::Open);
        end;
    end;
}

