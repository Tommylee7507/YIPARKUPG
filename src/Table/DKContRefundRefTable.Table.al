table 50047 "DK_Cont. Refund Ref. Table"
{
    // *DK33 : 20200730
    //   - Add Field : Type
    //   - Add Key : "Starting Date" -> "Starting Date",Type
    //   - Modify Function : OnDelete
    //                       SetReOpen

    Caption = 'Contract Refund Reference Table';
    DrillDownPageID = "DK_Cont. Ref. Ref. Table List";
    LookupPageID = "DK_Cont. Ref. Ref. Table List";

    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Starting Date" <> "Starting Date" then
                    TestField(Status, Status::Open);
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(4; "No. of Details"; Integer)
        {
            CalcFormula = Count("DK_Cont. Refund Ref. Detail" WHERE("Starting Date" = FIELD("Starting Date")));
            Caption = 'No. of Details';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Estate Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            Description = 'DK33';
            OptionCaption = 'Common,Stairs,Funeral Urn,Tree,Nature,Charnel house';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature,Charnelhouse;
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
        key(Key1; "Starting Date", "Estate Type")
        {
            Clustered = true;
        }
        key(Key2; Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _ContRefundRefDetail: Record "DK_Cont. Refund Ref. Detail";
        _RevocationContract: Record "DK_Revocation Contract";
    begin

        _RevocationContract.Reset;
        _RevocationContract.SetRange("Refund Starting Date", "Starting Date");
        _RevocationContract.SetRange("Estate Type", "Estate Type");//DK33
        if _RevocationContract.FindSet then
            Error(MSG002, TableCaption, "Starting Date", "Estate Type", _RevocationContract.TableCaption);//DK33

        //Delete Detail
        _ContRefundRefDetail.Reset;
        _ContRefundRefDetail.SetRange("Starting Date", "Starting Date");
        _ContRefundRefDetail.SetRange("Estate Type", "Estate Type"); //DK33
        if _ContRefundRefDetail.FindSet then
            _ContRefundRefDetail.DeleteAll(false);
    end;

    trigger OnInsert()
    begin
        TestField("Starting Date");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);
        TestField("Starting Date");

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'No Detail Record exist.';
        MSG002: Label 'The %1 %2 %3 is being use by its %4 and can not be deleted.';
        MSG003: Label 'The %1 %2 %3 is being use by %4. The Status cannot be changed.';


    procedure SetReleased()
    var
        _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
    begin
        CalcFields("No. of Details");

        if "No. of Details" = 0 then
            Error(MSG001);

        Status := Rec.Status::Released;
        Modify;
    end;


    procedure SetReOpen()
    var
        _RevocationContract: Record "DK_Revocation Contract";
    begin

        //>>DK33
        _RevocationContract.Reset;
        _RevocationContract.SetRange("Refund Starting Date", "Starting Date");
        _RevocationContract.SetRange("Estate Type", "Estate Type");//DK32
        if _RevocationContract.FindSet then
            Error(MSG003, TableCaption, "Starting Date", "Estate Type", _RevocationContract.TableCaption);//DK32
        //<<DK33

        Status := Rec.Status::Open;
        Modify;
    end;
}

