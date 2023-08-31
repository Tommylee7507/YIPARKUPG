table 50079 "DK_Sended SMS History"
{
    // 
    // DK34: 20201026
    //   - Modify Field: "Source Type" Add Option String(ReagreeInfo)

    Caption = 'Sended SMS History';
    DataCaptionFields = "Entry No.", "From Phone No.", "To Phone No.", Subject;
    DrillDownPageID = "DK_Sended SMS History";
    LookupPageID = "DK_Sended SMS History";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Sending Date"; Date)
        {
            Caption = 'Sending Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Sending Time"; Time)
        {
            Caption = 'Sending Time';
            DataClassification = ToBeClassified;
        }
        field(4; "From Phone No."; Text[15])
        {
            Caption = 'From Phone No.';
            DataClassification = ToBeClassified;
        }
        field(5; "To Phone No."; Text[15])
        {
            Caption = 'To Phone No.';
            DataClassification = ToBeClassified;
        }
        field(6; Subject; Text[100])
        {
            Caption = 'Subject';
            DataClassification = ToBeClassified;
        }
        field(7; "SMS Message"; BLOB)
        {
            Caption = 'Message2';
            DataClassification = ToBeClassified;
        }
        field(8; "Short Message"; Text[2000])
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;
        }
        field(9; Image1; BLOB)
        {
            Caption = 'Image1';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(10; "Image Name 1"; Text[100])
        {
            Caption = 'Image Name 1';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Image2; BLOB)
        {
            Caption = 'Image2';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(12; "Image Name 2"; Text[100])
        {
            Caption = 'Image Name 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; Image3; BLOB)
        {
            Caption = 'Image3';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(14; "Image Name 3"; Text[100])
        {
            Caption = 'Image Name 3';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Auto Sending"; Boolean)
        {
            Caption = 'Auto Sending';
            DataClassification = ToBeClassified;
        }
        field(16; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Purchase Contract,Remaining Amount,Vehicle,Field Work,Customer Request,Cemetry Service,Receipt,Payment Expect PG,Payment Expect VA,Reagree Provide To Information';
            OptionMembers = General,PurchContract,RemAmount,Vehicle,FieldWork,CustRequest,Service,Receipt,PaymentExpectPG,PaymentExpectVA,ReagreeInfo;
        }
        field(17; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Source Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Waiting,Seding,Waiting for Completion,Complete,Exchange Sending';
            OptionMembers = Waiting,Send,WaitingCompletion,Complete,ExchangeSending;
        }
        field(20; "Report Date"; DateTime)
        {
            Caption = 'Report Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Result Status Code"; Code[20])
        {
            Caption = 'Result Status Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Biz Talk Template No."; Text[30])
        {
            Caption = 'Biz Talk Template No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Result Status"; Text[50])
        {
            CalcFormula = Lookup("DK_Result Status".Name WHERE(Type = CONST(SMS),
                                                                Code = FIELD("Result Status Code")));
            Caption = 'Result Status';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Contract;
        }
        field(25; "Change Send"; Option)
        {
            Caption = 'Change Send';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Default Send,Change Send';
            OptionMembers = DefaultSend,ChangeSend;
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
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Source No.", "Source Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;
}

