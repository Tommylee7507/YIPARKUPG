table 50048 "DK_Cont. Refund Ref. Detail"
{
    // *DK33 : 20200730
    //   - Add Field : Type
    //   - Add Key : "Starting Date","Line No." -> "Starting Date","Line No.",Type
    // 
    // DK34 : 20201130
    //   - Modify Field : "Contract Type"

    Caption = 'Contract refund Reference Table';

    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Deposit,Non-Payment,Non-Payment(Change Location),Full Payment,Full Payment(Change Location)';
            OptionMembers = Deposit,"Non-Payment","Change Location","Full Payment","Full Pay Change Location";
        }
        field(4; "Period From"; DateFormula)
        {
            Caption = 'Preiod From';
            DataClassification = ToBeClassified;
        }
        field(5; "Period To"; DateFormula)
        {
            Caption = 'Period To';
            DataClassification = ToBeClassified;
        }
        field(6; "Refund Rate"; Decimal)
        {
            Caption = 'Refund Rate(%)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MaxValue = 100;
            MinValue = 0;
        }
        field(7; "From Date"; Date)
        {
            Caption = 'From Data';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "To Date"; Date)
        {
            Caption = 'To Data';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Estate Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            Description = 'DK33';
            OptionCaption = 'Common,Stairs,Funeral Urn,Tree,Nature,Charnel house';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature,Charnelhouse;
        }
    }

    keys
    {
        key(Key1; "Starting Date", "Estate Type", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Contract Type", "From Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckHeaderStatus("Starting Date");
        UpdateHeaderModifiedDate;
    end;

    trigger OnInsert()
    begin

        TestField("Starting Date");
        CheckHeaderStatus("Starting Date");
        UpdateHeaderModifiedDate;
    end;

    trigger OnModify()
    begin
        TestField("Starting Date");
        CheckHeaderStatus("Starting Date");
        UpdateHeaderModifiedDate;
    end;

    var
        MSG001: Label 'You can edit and delete it only if the Status is ''Released''.';

    local procedure UpdateHeaderModifiedDate()
    var
        _ContRefundRefTable: Record "DK_Cont. Refund Ref. Table";
    begin

        if _ContRefundRefTable.Get("Starting Date", "Estate Type") then begin
            _ContRefundRefTable."Last Date Modified" := CurrentDateTime;
            _ContRefundRefTable."Last Modified Person" := UserId;
            _ContRefundRefTable.Modify;
        end;
    end;


    procedure CheckHeaderStatus(pStartingDate: Date)
    var
        _ContRefundRefTable: Record "DK_Cont. Refund Ref. Table";
    begin

        if _ContRefundRefTable.Get(pStartingDate, "Estate Type") then begin
            if _ContRefundRefTable.Status <> _ContRefundRefTable.Status::Open then
                Error(MSG001);
        end;
    end;
}

