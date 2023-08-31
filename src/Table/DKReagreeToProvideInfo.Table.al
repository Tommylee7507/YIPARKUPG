table 50125 "DK_Reagree To Provide Info"
{
    // 
    // DK34 : 20201023
    //   - Create

    Caption = 'Reagree To Provide Informaiton';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Customer Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Relation Family';
            OptionMembers = Customer,ReleationFam;
        }
        field(3; "Send Type"; Boolean)
        {
            Caption = 'Send Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF (Type = CONST(Customer)) DK_Customer
            ELSE
            IF (Type = CONST(ReleationFam)) "DK_Relationship Family"."Contract No.";
        }
        field(5; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF (Type = CONST(ReleationFam)) "DK_Relationship Family"."Line No.";
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(10; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(11; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;
        }
        field(12; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Customer: Record DK_Customer;
                _ChangedCustomerHistory: Record "DK_Changed Customer History";
                _RelationshipFamily: Record "DK_Relationship Family";
                _CommFun: Codeunit "DK_Common Function";
            begin

                if "Mobile No." <> xRec."Mobile No." then begin
                    if "Mobile No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Mobile No.") then
                            Error(MSG002, FieldCaption("Mobile No."));

                    if not Confirm(MSG001) then Error('');

                    if Type = Type::Customer then begin
                        _Customer.Reset;
                        _Customer.SetRange("No.", "Source No.");
                        if _Customer.FindSet then begin
                            _Customer."Mobile No." := "Mobile No.";
                            _Customer."Last Date Modified" := CurrentDateTime;
                            _Customer."Last Modified Person" := UserId;
                            _Customer.Modify;

                            _ChangedCustomerHistory.CheckChange(_Customer);
                        end
                    end else begin
                        _RelationshipFamily.Reset;
                        _RelationshipFamily.SetRange("Contract No.", "Source No.");
                        _RelationshipFamily.SetRange("Line No.", "Source Line No.");
                        if _RelationshipFamily.FindSet then begin
                            _RelationshipFamily.Validate("Mobile No.", Rec."Mobile No.");
                            _RelationshipFamily."Last Date Modified" := CurrentDateTime;
                            _RelationshipFamily."Last Modified Person" := UserId;
                            _RelationshipFamily.Modify;
                        end;
                    end;
                end;
            end;
        }
        field(13; "Personal Data"; Boolean)
        {
            Caption = 'Personal Data';
            DataClassification = ToBeClassified;
        }
        field(14; "Marketing SMS"; Boolean)
        {
            Caption = 'Marketing SMS';
            DataClassification = ToBeClassified;
        }
        field(15; "Marketing Phone"; Boolean)
        {
            Caption = 'Marketing Phone';
            DataClassification = ToBeClassified;
        }
        field(16; "Markeing E-mail"; Boolean)
        {
            Caption = 'Markeing E-mail';
            DataClassification = ToBeClassified;
        }
        field(17; "Personal Data Third Party"; Boolean)
        {
            Caption = 'Personal Data Third Party';
            DataClassification = ToBeClassified;
        }
        field(18; "Personal Data Referral"; Boolean)
        {
            Caption = 'Personal Data Referral';
            DataClassification = ToBeClassified;
        }
        field(19; "Personal Data Concu. Date"; Date)
        {
            Caption = 'Personal Data Concu. Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Send Date"; Date)
        {
            Caption = 'Send Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Send Person"; Code[50])
        {
            Caption = 'Send Person';
            DataClassification = ToBeClassified;
        }
        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(1000; "Creation Base Date"; Date)
        {
            Caption = 'Creation Base Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Reagree To Provide Info Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Reagree To Provide Info Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;

        TestField("No.");

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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'The associated source data will be modified. Are you sure you want to modify it?';
        MSG002: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';


    procedure AssistEdit(OldReagree: Record "DK_Reagree To Provide Info"): Boolean
    var
        _ReagreeToProvinfo: Record "DK_Reagree To Provide Info";
    begin
        with _ReagreeToProvinfo do begin
            _ReagreeToProvinfo := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Reagree To Provide Info Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Reagree To Provide Info Nos.", OldReagree."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _ReagreeToProvinfo;
                exit(true);
            end;
        end;
    end;
}

