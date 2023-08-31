table 50121 "DK_Customer Certficate History"
{
    Caption = 'Customer Certficate History';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; Apprval; Boolean)
        {
            Caption = 'Apprval';
            DataClassification = ToBeClassified;
        }
        field(4; "Allow Employee No."; Code[20])
        {
            Caption = 'Allow Employee No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Allow Employee Name"; Text[30])
        {
            Caption = 'Allow Employee Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Req. Employee No."; Code[20])
        {
            Caption = 'Request Employee No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Req. Employee Name"; Text[30])
        {
            Caption = 'Request Employee Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Allow Mem. Printing DateTime"; DateTime)
        {
            Caption = 'Allow Memember Printing DateTime';
            DataClassification = ToBeClassified;
        }
        field(9; "Member. Request Date"; Date)
        {
            Caption = 'Membership Request Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                CalcFields("Payment Amount", "Pay. Remaining Amount");
            end;
        }
        field(11; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Customer: Record DK_Customer;
            begin
                CalcFields("Main Customer Name");
            end;
        }
        field(12; "Main Customer Name"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                CalcFields("Cemetery No.", "Cemetery Size");
            end;
        }
        field(14; "Cemetery No."; Text[30])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Cemetery Size"; Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery.Size WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Size';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Contract Status"; Option)
        {
            CalcFormula = Lookup(DK_Contract.Status WHERE("No." = FIELD("Contract No.")));
            Caption = 'Contract Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Contract,Full Payment,Revocation of Contract,Reservation';
            OptionMembers = Open,Contract,FullPayment,Revocation,Reservation;
        }
        field(17; "Contract Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."Contract Date" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Contract Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Supervise No."; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."Supervise No." WHERE("No." = FIELD("Contract No.")));
            Caption = 'Supervise No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Payment Amount"; Decimal)
        {
            CalcFormula = Lookup(DK_Contract."Payment Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Payment Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Pay. Remaining Amount"; Decimal)
        {
            CalcFormula = Lookup(DK_Contract."Pay. Remaining Amount" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Payment  Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin

        if "Document No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Membership Printing Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Membership Printing Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
        end;
    end;

    var
        FunctionSetup: Record "DK_Function Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

