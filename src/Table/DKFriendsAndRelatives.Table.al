table 50138 "DK_Friends And Relatives"
{
    Caption = 'Friends and relatives';
    DataCaptionFields = "Contract No.";

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

                if _Contract.Get("Contract No.") then
                    Validate("Cemetery Code", _Contract."Cemetery Code")
                else
                    Validate("Cemetery Code", '');
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Relation No."; Code[20])
        {
            Caption = 'Relation No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer."No.";

            trigger OnValidate()
            var
                _FriendsAndRelatives: Record "DK_Friends And Relatives";
            begin
                TestField(Status, Status::Open);

                if Rec."Customer No." <> xRec."Customer No." then begin
                    _FriendsAndRelatives.Reset;
                    _FriendsAndRelatives.SetRange("Contract No.", "Contract No.");
                    _FriendsAndRelatives.SetRange("Customer No.", "Customer No.");
                    if _FriendsAndRelatives.FindSet then
                        Error(MSG002, _FriendsAndRelatives.TableCaption);
                end;

                CalcFields("Customer Name", "Cust. Post Code", "Cust. Address", "Cust. Address 2", "Cust. Phone No.",
                          "Cust. Type", "Cust. E-Mail", "Cust. Birthday", "Cust. Gender");
                CalcFields("Cust. Company Post Code", "Cust. Company Address", "Cust. Compnay Address 2", "Cust. Mobile No.");
                CalcFields("Cust. Personal Data", "Cust. Marketing SMS", "Cust. Marketing Phone", "Cust. Marketing E-Mail",
                           "Cust. Per. Data Third Party", "Cust. Per. Data Referral", "Cust. Per. Data Concu. Date", "Cust. Re. Prov. Info Send Date");
            end;
        }
        field(5; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Relationship; Text[30])
        {
            Caption = 'Relationship';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(7; "Cust. Post Code"; Code[10])
        {
            CalcFormula = Lookup(DK_Customer."Post Code" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Post Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Cust. Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Cust. Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cust. Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Phone No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cust. Type"; Option)
        {
            CalcFormula = Lookup(DK_Customer.Type WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Individual,Corporation';
            OptionMembers = Individual,Corporation;
        }
        field(12; "Cust. E-Mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer E-Mail';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cust. Birthday"; Date)
        {
            CalcFormula = Lookup(DK_Customer.Birthday WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Birthday';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Cust. Gender"; Option)
        {
            CalcFormula = Lookup(DK_Customer.Gender WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Gender';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(15; "Cust. Company Post Code"; Code[10])
        {
            CalcFormula = Lookup(DK_Customer."Company Post Code" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Compnay Post Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Cust. Company Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Company Address" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Cust. Company Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Cust. Compnay Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Company Address 2" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Company Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Cust. Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Mobile No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Cust. Personal Data"; Boolean)
        {
            CalcFormula = Lookup(DK_Customer."Personal Data" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Personal Data';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Cust. Marketing SMS"; Boolean)
        {
            CalcFormula = Lookup(DK_Customer."Marketing SMS" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Marketing SMS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Cust. Marketing Phone"; Boolean)
        {
            CalcFormula = Lookup(DK_Customer."Marketing Phone" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Marketing Phone';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Cust. Marketing E-Mail"; Boolean)
        {
            CalcFormula = Lookup(DK_Customer."Marketing E-Mail" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Marketing E-Mail';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Cust. Per. Data Third Party"; Boolean)
        {
            CalcFormula = Lookup(DK_Customer."Personal Data Third Party" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Personal Data Third Party';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Cust. Per. Data Referral"; Boolean)
        {
            CalcFormula = Lookup(DK_Customer."Personal Data Referral" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Personal Data Referral';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Cust. Per. Data Concu. Date"; Date)
        {
            CalcFormula = Lookup(DK_Customer."Personal Data Concu. Date" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Personal Data Concurrence Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; Memo; Text[250])
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(27; "Cust. Re. Prov. Info Send Date"; Date)
        {
            CalcFormula = Lookup(DK_Customer."Reagree Prov. Info Send Date" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Reagree Information Send Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Cemetery No.");
            end;
        }
        field(29; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(1000; "Create Organizer"; Option)
        {
            Caption = 'Create Organizer';
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = ERP;
            OptionCaption = 'CRM,ERP,Openning';
            OptionMembers = CRM,ERP,Openning;
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
        key(Key1; "Contract No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        TestField(Status, Status::Open);

        if Rec."Relation No." <> '' then
            _CRMDataInterlink.OutboundFriendsRel(Rec, true);
    end;

    trigger OnInsert()
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        TestField("Contract No.");

        if "Line No." = 0 then
            InitLineNo;

        //CreateRelationNo;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        TestField(Status, Status::Open);

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label '%1 - %2';
        MSG002: Label 'The same customer exists in %1.';
        MSG003: Label 'When deleted, CRM data is also deleted. Are you sure you want to?';


    procedure CreateRelationNo()
    var
        _FriendsAndRelatives: Record "DK_Friends And Relatives";
    begin

        _FriendsAndRelatives.Reset;
        _FriendsAndRelatives.SetRange("Contract No.", Rec."Contract No.");
        if _FriendsAndRelatives.FindSet then begin
            "Relation No." := StrSubstNo(MSG001, "Contract No.", _FriendsAndRelatives.Count + 1);
        end else begin
            "Relation No." := StrSubstNo(MSG001, "Contract No.", 1);
        end
    end;

    local procedure InitLineNo()
    var
        _FriendsAndRelatives: Record "DK_Friends And Relatives";
    begin

        _FriendsAndRelatives.Reset;
        _FriendsAndRelatives.SetRange("Contract No.", "Contract No.");
        if _FriendsAndRelatives.FindLast then begin
            "Line No." := _FriendsAndRelatives."Line No." + 10000
        end else begin
            "Line No." := 10000
        end;
    end;


    procedure SetOpen()
    begin

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetRelease()
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        TestField("Contract No.");
        TestField("Line No.");
        TestField("Customer No.");
        TestField(Relationship);

        Status := Rec.Status::Release;
        Modify;

        _CRMDataInterlink.OutboundFriendsRel(Rec, false);
    end;
}

