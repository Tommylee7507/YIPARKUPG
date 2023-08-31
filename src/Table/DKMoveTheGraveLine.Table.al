table 50102 "DK_Move The Grave Line"
{
    Caption = 'Move The Grave Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Cotract No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Corpse Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Corpse Line No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Corpse."Line No." WHERE("Contract No." = FIELD("Contract No."));

            trigger OnValidate()
            var
                _Corpse: Record DK_Corpse;
            begin
                GetHeaderStatus;

                if "Corpse Line No." <> xRec."Corpse Line No." then begin
                    _Corpse.Reset;
                    _Corpse.SetRange("Contract No.", "Contract No.");
                    _Corpse.SetRange("Line No.", "Corpse Line No.");
                    if _Corpse.FindSet then begin
                        Validate("Field Work Main Cat. Code", _Corpse."Field Work Main Cat. Code");
                        Validate("Field Work Sub Cat. Code", _Corpse."Field Work Sub Cat. Code");
                    end else begin
                        Validate("Field Work Main Cat. Code", '');
                        Validate("Field Work Sub Cat. Code", '');
                    end;
                end;

                CalcFields("Corpse Name", "Laying Date", "Death Date");
            end;
        }
        field(5; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            Editable = false;

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
        field(6; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            Editable = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", _FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(7; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            Editable = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                else
                    "Field Work Sub Cat. Name" := '';
            end;
        }
        field(8; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            Editable = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                Validate("Field Work Sub Cat. Code", _FieldWorkSubCategory.GetFieldWorkSCode("Field Work Sub Cat. Name", "Field Work Main Cat. Code"));
            end;
        }
        field(9; "Corpse Name"; Text[30])
        {
            CalcFormula = Lookup(DK_Corpse.Name WHERE("Contract No." = FIELD("Contract No."),
                                                       "Line No." = FIELD("Corpse Line No.")));
            Caption = 'Corpse Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Laying Date"; Date)
        {
            CalcFormula = Lookup(DK_Corpse."Laying Date" WHERE("Contract No." = FIELD("Contract No."),
                                                                "Line No." = FIELD("Corpse Line No.")));
            Caption = 'Laying Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Death Date"; Date)
        {
            CalcFormula = Lookup(DK_Corpse."Death Date" WHERE("Contract No." = FIELD("Contract No."),
                                                               "Line No." = FIELD("Corpse Line No.")));
            Caption = 'Death Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Desired Date"; Date)
        {
            Caption = 'Desired Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetHeaderStatus;
            end;
        }
        field(13; "Service Item"; Text[40])
        {
            Caption = 'Service Item';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetHeaderStatus;
            end;
        }
        field(14; Grappling; Option)
        {
            Caption = 'Grappling';
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Grappling,NotGrap';
            OptionMembers = "None",Grappling,NotGrraplin;

            trigger OnValidate()
            begin
                GetHeaderStatus;
                GetHeaderType;
            end;
        }
        field(15; "Total Expense Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Expense Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                GetHeaderStatus;
                GetHeaderType;
            end;
        }
        field(16; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                GetHeaderStatus;
            end;
        }
        field(17; Remarks; Text[250])
        {
            AutoFormatType = 1;
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetHeaderStatus;
            end;
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
        key(Key1; "Document No.", "Contract No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _MoveTheGrave: Record "DK_Move The Grave";
    begin
        GetHeaderStatus;
    end;

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


    procedure GetHeaderType()
    var
        _MoveTheGrave: Record "DK_Move The Grave";
    begin

        if _MoveTheGrave.Get("Document No.") then begin
            _MoveTheGrave.TestField(Type, _MoveTheGrave.Type::"Move The Grave");
        end;
    end;


    procedure GetHeaderStatus()
    var
        _MoveTheGrave: Record "DK_Move The Grave";
    begin

        if _MoveTheGrave.Get("Document No.") then begin
            _MoveTheGrave.TestField(Status, _MoveTheGrave.Status::Receipt);
        end;
    end;

    procedure CalcTotalAmount(var pMoveTheGraveLine: Record "DK_Move The Grave Line"; pLastMoveTheGraveLine: Record "DK_Move The Grave Line"; var pTotalAmount: Decimal)
    var
        _TempMoveTheGraveLine: Record "DK_Move The Grave Line";
        _MoveTheGrave: Record "DK_Move The Grave";
    begin
        _TempMoveTheGraveLine.CopyFilters(pMoveTheGraveLine);

        _TempMoveTheGraveLine.SetRange("Document No.", pMoveTheGraveLine."Document No.");
        if _TempMoveTheGraveLine.FindSet then
            _TempMoveTheGraveLine.CalcSums(Amount);

        pTotalAmount := _TempMoveTheGraveLine.Amount;

        if _MoveTheGrave.Get(pMoveTheGraveLine."Document No.") then begin
            _MoveTheGrave.TotalAmount := pTotalAmount;
            if _MoveTheGrave.TotalAmount <= 0 then begin
                _MoveTheGrave."Remaining Amount" := 0;
                _MoveTheGrave."Contract Amount" := 0;
            end else
                _MoveTheGrave."Remaining Amount" := _MoveTheGrave.TotalAmount - _MoveTheGrave."Contract Amount";
            _MoveTheGrave.Modify;
        end;
    end;
}

