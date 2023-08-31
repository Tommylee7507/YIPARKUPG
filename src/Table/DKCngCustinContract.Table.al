table 50117 "DK_Cng. Cust. in Contract"
{
    Caption = 'Change Custoemr in Contract';
    DrillDownPageID = "DK_Cng. Cust. in Contract List";
    LookupPageID = "DK_Cng. Cust. in Contract List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document No." <> "Document No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Cng. Cust. In Contract Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                GetContract("Contract No.");
            end;
        }
        field(4; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Cemetery Code"; Code[20])
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
        field(6; "Cemetery No."; Text[50])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Cemetery Code", _Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Applied';
            OptionMembers = Open,Released;
        }
        field(100; "Cur. Main Customer No."; Code[20])
        {
            Caption = 'Current Main Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                CalcFields("Cur. Main Name", "Cur. Main Address", "Cur. Main Address 2", "Cur. Main Phone No.",
                        "Cur. Main Mobile No.", "Cur. Main E-mail");
            end;
        }
        field(101; "Cur. Main Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Cur. Main Customer No.")));
            Caption = 'Current Main Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Cur. Main Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Cur. Main Customer No.")));
            Caption = 'current Main Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Cur. Main Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cur. Main Customer No.")));
            Caption = 'Current Main Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(104; "Cur. Main Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Cur. Main Customer No.")));
            Caption = 'Current Main Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(105; "Cur. Main Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Cur. Main Customer No.")));
            Caption = 'Current Main Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(106; "Cur. Main E-mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Cur. Main Customer No.")));
            Caption = 'Current. Main E-mail';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(200; "Cur. Customer No. 2"; Code[20])
        {
            Caption = 'Current Customer 2 No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                CalcFields("Cur. Customer Name 2", "Cur. Customer Address 2", "Cur. Customer Address 2 2", "Cur. Customer Phone No. 2",
                        "Cur. Customer Mobile No. 2", "Cur. Customer E-mail 2");
            end;
        }
        field(201; "Cur. Customer Name 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Cur. Customer No. 2")));
            Caption = 'Current Customer 2 Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(202; "Cur. Customer Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cur. Customer No. 2")));
            Caption = 'Current Customer 2 Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(203; "Cur. Customer Address 2 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cur. Customer No. 2")));
            Caption = 'Current Customer 2 Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(204; "Cur. Customer Phone No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Cur. Customer No. 2")));
            Caption = 'Current Customer 2 Phoe No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(205; "Cur. Customer Mobile No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Cur. Customer No. 2")));
            Caption = 'Current Customer 2 Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(206; "Cur. Customer E-mail 2"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Cur. Customer No. 2")));
            Caption = 'Current Customer 2 E-mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(300; "Cur. Customer No. 3"; Code[20])
        {
            Caption = 'Current Customer 3 No.';
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                CalcFields("Cur. Customer Name 3", "Cur. Customer Address 3", "Cur. Customer Address 2 3", "Cur. Customer Phone No. 3",
                        "Cur. Customer Mobile No. 3", "Cur. Customer E-mail 3");
            end;
        }
        field(301; "Cur. Customer Name 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Cur. Customer No. 3")));
            Caption = 'Current Customer 3 Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(302; "Cur. Customer Address 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Cur. Customer No. 3")));
            Caption = 'Current Customer 3 Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(303; "Cur. Customer Address 2 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cur. Customer No. 3")));
            Caption = 'Current Customer 3 Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(304; "Cur. Customer Phone No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Cur. Customer No. 3")));
            Caption = 'Current Customer 3 Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(305; "Cur. Customer Mobile No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Cur. Customer No. 3")));
            Caption = 'Current Customer 3 Mobile No.';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(306; "Cur. Customer E-mail 3"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Cur. Customer No. 3")));
            Caption = 'Current Custoemr 3 E-mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(1000; "Cng. Main Customer No."; Code[20])
        {
            Caption = 'Chang Main Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                CalcFields("Cng. Main Name", "Cng. Main Address", "Cng. Main Address 2", "Cng. Main Phone No.",
                        "Cng. Main Mobile No.", "Cng. Main E-mail");
            end;
        }
        field(1001; "Cng. Main Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Cng. Main Customer No.")));
            Caption = 'Change Main Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1002; "Cng. Main Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Cng. Main Customer No.")));
            Caption = 'Change Main Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1003; "Cng. Main Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cng. Main Customer No.")));
            Caption = 'Change Main Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1004; "Cng. Main Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Cng. Main Customer No.")));
            Caption = 'Change Main Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(1006; "Cng. Main E-mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Cng. Main Customer No.")));
            Caption = 'Change Main Customr E-mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(1007; "Cng. Main Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Cng. Main Customer No.")));
            Caption = 'Change Main Customer Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(2000; "Cng. Customer No. 2"; Code[20])
        {
            Caption = 'Change Customer 2 No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                CalcFields("Cng. Customer Name 2", "Cng. Customer Address 2", "Cng. Customer Address 2 2", "Cng. Customer Phone No. 2",
                        "Cng. Customer Mobile No. 2", "Cng. Customer E-mail 2");
            end;
        }
        field(2001; "Cng. Customer Name 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Cng. Customer No. 2")));
            Caption = 'Change Custoer 2 Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2002; "Cng. Customer Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Cng. Customer No. 2")));
            Caption = 'Change Customer 2 Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2003; "Cng. Customer Address 2 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cng. Customer No. 2")));
            Caption = 'Change Customer 2 Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2004; "Cng. Customer Phone No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Cng. Customer No. 2")));
            Caption = 'Change Customer 2 Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(2005; "Cng. Customer Mobile No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Cng. Customer No. 2")));
            Caption = 'Change Customer 2 Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(2006; "Cng. Customer E-mail 2"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Cng. Customer No. 2")));
            Caption = 'Change Customer 2 E-mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(3000; "Cng. Customer No. 3"; Code[20])
        {
            Caption = 'Change Customer 3 No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                CalcFields("Cng. Customer Name 3", "Cng. Customer Address 3", "Cng. Customer Address 2 3", "Cng. Customer Phone No. 3",
                        "Cng. Customer Mobile No. 3", "Cng. Customer E-mail 3");
            end;
        }
        field(3001; "Cng. Customer Name 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Cng. Customer No. 3")));
            Caption = 'Change Customer 3 Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3002; "Cng. Customer Address 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Cng. Customer No. 3")));
            Caption = 'Change Customer 3 Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3003; "Cng. Customer Address 2 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Cng. Customer No. 3")));
            Caption = 'Change Customer 3 Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3004; "Cng. Customer Phone No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Cng. Customer No. 3")));
            Caption = 'Change Customer 3 Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(3005; "Cng. Customer Mobile No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Cng. Customer No. 3")));
            Caption = 'Change Customer 3 Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(3006; "Cng. Customer E-mail 3"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Cng. Customer No. 3")));
            Caption = 'Change Customer 3 E-mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
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
        field(5004; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        TestField(Status, Status::Open);
    end;

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Cng. Cust. In Contract Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Cng. Cust. In Contract Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
        end;

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

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";


    procedure GetContract(pContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
    begin

        if _Contract.Get(pContractNo) then begin
            Validate("Cemetery Code", _Contract."Cemetery Code");
            Validate("Supervise No.", _Contract."Supervise No.");
            Validate("Cur. Main Customer No.", _Contract."Main Customer No.");
            Validate("Cur. Customer No. 2", _Contract."Customer No. 2");
            Validate("Cur. Customer No. 3", _Contract."Customer No. 3");
            Validate("Cng. Main Customer No.", _Contract."Main Customer No.");
            Validate("Cng. Customer No. 2", _Contract."Customer No. 2");
            Validate("Cng. Customer No. 3", _Contract."Customer No. 3");
        end else begin
            Validate("Cemetery Code", '');
            Validate("Supervise No.", '');
            Validate("Cur. Main Customer No.", '');
            Validate("Cur. Customer No. 2", '');
            Validate("Cur. Customer No. 3", '');
            Validate("Cng. Main Customer No.", '');
            Validate("Cng. Customer No. 2", '');
            Validate("Cng. Customer No. 3", '');
        end;
    end;


    procedure AssistEdit(OldCngCustinContract: Record "DK_Cng. Cust. in Contract"): Boolean
    begin
        with OldCngCustinContract do begin
            OldCngCustinContract := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Cng. Cust. In Contract Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Cng. Cust. In Contract Nos.", OldCngCustinContract."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                Rec := OldCngCustinContract;
                exit(true);
            end;
        end;
    end;
}

