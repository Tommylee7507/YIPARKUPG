table 50021 "DK_Purchase Contract Line"
{
    Caption = 'Purchase Contract Line';
    DataCaptionFields = "Purchase Contract No.";
    DrillDownPageID = "DK_Purchase Contract Line List";
    LookupPageID = "DK_Purchase Contract Line List";

    fields
    {
        field(1; "Purchase Contract No."; Code[20])
        {
            Caption = 'Purchase Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Purchase Contract";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                GetPurchContractHeader;
            end;
        }
        field(3; "Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Contract Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetPurchContractHeader;
            end;
        }
        field(4; Contents; BLOB)
        {
            Caption = 'Contents';
            DataClassification = ToBeClassified;
            SubType = UserDefined;

            trigger OnValidate()
            begin
                GetPurchContractHeader;
            end;
        }
        field(5; "Contract Date From"; Date)
        {
            Caption = 'Contract Date From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetPurchContractHeader;
            end;
        }
        field(6; "Contract Date To"; Date)
        {
            Caption = 'Contract Date To';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetPurchContractHeader;
            end;
        }
        field(7; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GetPurchContractHeader;
            end;
        }
        field(8; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                if _Department.Get("Department Code") then
                    "Department Name" := _Department.Name
                else
                    "Department Name" := '';
            end;
        }
        field(9; "Department Name"; Text[30])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code", _Department.GetDeptCode("Department Name"));
            end;
        }
        field(10; "Short Contents"; Text[100])
        {
            Caption = 'ShotContents';
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(59000; idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Purchase Contract No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Contract Date From")
        {
        }
        key(Key3; "Contract Date To")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Contract Date From", "Contract Date To", "Contract Amount", Contents, Remarks, "Department Code", "Department Name", "Short Contents")
        {
        }
    }

    trigger OnInsert()
    begin

        TestField("Line No.");
        TestField("Purchase Contract No.");
        TestField("Contract Date From");
        TestField("Contract Date To");
        //TESTFIELD("Contract Amount");

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId
    end;

    trigger OnModify()
    begin

        TestField("Contract Date From");
        TestField("Contract Date To");
        //TESTFIELD("Contract Amount");

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId
    end;

    var
        MSG001: Label 'If the %1 is %2, you can not enter it.';

    procedure GetContents(): Text
    var
        TempBlob: Record TempBlob temporary;
        CR: Text[1];
    begin
        CalcFields(Contents);
        if not Contents.HasValue then
            exit('');
        CR[1] := 10;
        TempBlob.Blob := Contents;
        exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;

    procedure SetContents(NewContents: Text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        Clear(Contents);
        if NewContents = '' then
            exit;
        TempBlob.Blob := Contents;
        TempBlob.WriteAsText(NewContents, TEXTENCODING::Windows);
        "Short Contents" := CopyStr(NewContents, 1, 100);
        Contents := TempBlob.Blob;
        Modify;
    end;


    procedure GetPurchContractHeader()
    var
        _PurchaseContract: Record "DK_Purchase Contract";
    begin

        if _PurchaseContract.Get("Purchase Contract No.") then begin
            if (_PurchaseContract.Status = _PurchaseContract.Status::Contract) or
              (_PurchaseContract.Status = _PurchaseContract.Status::Expiration) then begin
                Error(MSG001, _PurchaseContract.FieldCaption(Status), _PurchaseContract.Status);
            end;
        end;
    end;
}

