table 50118 "DK_Interlink Cus. with CRM Log"
{
    Caption = 'Interlink Customer with CRM Log';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Data Date';
            DataClassification = ToBeClassified;
        }
        field(2; "Data Type"; Option)
        {
            Caption = 'Data Type';
            DataClassification = ToBeClassified;
            InitValue = Inbound;
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
        }
        field(3; "Data Date"; Date)
        {
            Caption = 'Data Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(7; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(8; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Individual,Corporation';
            OptionMembers = Individual,Corporation;
        }
        field(11; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(12; Birthday; Date)
        {
            Caption = 'Birthday';
            DataClassification = ToBeClassified;
        }
        field(13; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(14; "Company Post Code"; Code[10])
        {
            Caption = 'Company Post Code';
            DataClassification = ToBeClassified;
        }
        field(15; "Company Address"; Text[50])
        {
            Caption = 'Company Address';
            DataClassification = ToBeClassified;
        }
        field(16; "Company Address 2"; Text[50])
        {
            Caption = 'Company Address 2';
            DataClassification = ToBeClassified;
        }
        field(17; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(18; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(19; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
        }
        field(20; Memo; Text[250])
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(21; "SSN Encyption"; BLOB)
        {
            Caption = 'Social Security No Encyption';
            DataClassification = ToBeClassified;
        }
        field(22; "Record Del"; Boolean)
        {
            Caption = 'Record Del';
            DataClassification = ToBeClassified;
        }
        field(23; "Applied Date"; Date)
        {
            Caption = 'Applied Date';
            DataClassification = ToBeClassified;
        }
        field(30; "Personal Data"; Boolean)
        {
            Caption = 'Personal Data';
            DataClassification = ToBeClassified;
        }
        field(31; "Marketing SMS"; Boolean)
        {
            Caption = 'Marketing SMS';
            DataClassification = ToBeClassified;
        }
        field(32; "Marketing Phone"; Boolean)
        {
            Caption = 'Marketing Phone';
            DataClassification = ToBeClassified;
        }
        field(33; "Marketing E-Mail"; Boolean)
        {
            Caption = 'Marketing E-Mail';
            DataClassification = ToBeClassified;
        }
        field(34; "Personal Data Third Party"; Boolean)
        {
            Caption = 'Personal Data Third Party';
            DataClassification = ToBeClassified;
        }
        field(35; "Personal Data Referral"; Boolean)
        {
            Caption = 'Personal Data Referral';
            DataClassification = ToBeClassified;
        }
        field(36; "Personal Data Concu. Date"; Date)
        {
            Caption = 'Personal Data Concurrence Date';
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
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Data Type")
        {
        }
        key(Key3; "Customer No.")
        {
        }
        key(Key4; Name)
        {
        }
        key(Key5; "E-mail")
        {
        }
        key(Key6; "Phone No.")
        {
        }
        key(Key7; "Mobile No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;


        "Data Date" := Today;
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    local procedure GetNextEntryNo(): BigInteger
    var
        _InterlinkCuswithCRMLog: Record "DK_Interlink Cus. with CRM Log";
    begin
        _InterlinkCuswithCRMLog.SetCurrentKey("Entry No.");
        if _InterlinkCuswithCRMLog.FindLast then
            exit(_InterlinkCuswithCRMLog."Entry No." + 1);

        exit(1);
    end;
}

