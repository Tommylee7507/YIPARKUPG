table 50124 "DK_Customer Delete Log"
{
    // 
    // *DK34 : 20201021
    //   - Create

    Caption = 'Customer Delete Log';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "DK_Customer Delete List";
    LookupPageID = "DK_Customer Delete List";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
            end;
        }
        field(4; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(8; "Encrypted ID No."; Boolean)
        {
            Caption = 'Encrypted ID No.';
            DataClassification = ToBeClassified;
        }
        field(9; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Individual,Corporation';
            OptionMembers = Individual,Corporation;
        }
        field(10; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(11; Birthday; Date)
        {
            Caption = 'Birthday';
            DataClassification = ToBeClassified;
        }
        field(12; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
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
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(19; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(24; "Create Organizer"; Option)
        {
            Caption = 'Create Organizer';
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = ERP;
            OptionCaption = 'CRM,ERP,Openning';
            OptionMembers = CRM,ERP,Openning;
        }
        field(25; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(26; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
        }
        field(27; Memo; Text[250])
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(28; "SSN Encyption"; BLOB)
        {
            Caption = 'Social Security No Encyption';
            DataClassification = ToBeClassified;
        }
        field(29; "Personal Data"; Boolean)
        {
            Caption = 'Personal Data';
            DataClassification = ToBeClassified;
        }
        field(30; "Marketing SMS"; Boolean)
        {
            Caption = 'Marketing SMS';
            DataClassification = ToBeClassified;
        }
        field(31; "Marketing Phone"; Boolean)
        {
            Caption = 'Marketing Phone';
            DataClassification = ToBeClassified;
        }
        field(32; "Marketing E-Mail"; Boolean)
        {
            Caption = 'Marketing E-Mail';
            DataClassification = ToBeClassified;
        }
        field(33; "Personal Data Third Party"; Boolean)
        {
            Caption = 'Personal Data Third Party';
            DataClassification = ToBeClassified;
        }
        field(34; "Personal Data Referral"; Boolean)
        {
            Caption = 'Personal Data Referral';
            DataClassification = ToBeClassified;
        }
        field(35; "Personal Data Concu. Date"; Date)
        {
            Caption = 'Personal Data Concurrence Date';
            DataClassification = ToBeClassified;
        }
        field(200; "Address Unkonwn"; Boolean)
        {
            Caption = 'Address Unkonwn';
            DataClassification = ToBeClassified;
        }
        field(5000; "Request DateTime"; DateTime)
        {
            Caption = 'Request DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Request Person"; Code[50])
        {
            Caption = 'Request Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Delete DateTime"; DateTime)
        {
            Caption = 'Delete DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Delete Person"; Code[50])
        {
            Caption = 'Delete Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59000; m_id; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(59001; t_id; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(59002; Idx; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(59003; "joint Tenancy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59004; "Before Customer No."; Code[20])
        {
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

    trigger OnInsert()
    begin

        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;
    end;

    var
        EncryptionManagement: Codeunit "Encryption Management";
        SSNEncrypt: Text;

    local procedure GetNextEntryNo(): BigInteger
    var
        _CustomerDeleteLog: Record "DK_Customer Delete Log";
    begin
        _CustomerDeleteLog.SetCurrentKey("Entry No.");
        if _CustomerDeleteLog.FindLast then
            exit(_CustomerDeleteLog."Entry No." + 1);

        exit(1);
    end;


    procedure SocialSecurityValidation(pSocialSecNo: Text[15])
    var
        VATRegistrationNoFormat: Record "VAT Registration No. Format";
        VATRegistrationLog: Record "VAT Registration Log";
        VATRegNoSrvConfig: Record "VAT Reg. No. Srv Config";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
        ResultRecordRef: RecordRef;
        ApplicableCountryCode: Code[10];
    begin
        if not VATRegistrationNoFormat.Test(pSocialSecNo, 'KOR', "No.", DATABASE::DK_Customer) then
            exit;
    end;

    procedure SetSSN(NewSSN: Text) ReturnSSN: Text
    var
        TempBlob: Record TempBlob;
    begin
        if NewSSN = '******-*******' then
            exit;

        Clear("SSN Encyption");
        SocialSecurityValidation("Social Security No.");
        if NewSSN = '' then
            exit;
        TempBlob.Blob := "SSN Encyption";
        if EncryptionManagement.IsEncryptionEnabled then
            SSNEncrypt := EncryptionManagement.Encrypt(NewSSN)
        else
            SSNEncrypt := NewSSN;

        TempBlob.WriteAsText(SSNEncrypt, TEXTENCODING::Windows);
        "SSN Encyption" := TempBlob.Blob;
        Modify;

        if Rec."SSN Encyption".HasValue then
            ReturnSSN := '******-*******';

        exit(ReturnSSN);
    end;

    procedure GetSSN(): Text
    begin

        Rec.CalcFields("SSN Encyption");
        //EXIT(GetSSNSSNCalculated);
        if not Rec."SSN Encyption".HasValue then
            exit('')
        else
            exit('******-*******');
    end;

    procedure GetSSNSSNCalculated(): Text
    var
        TempBlob: Record TempBlob;
        CR: Text[1];
    begin
        if not "SSN Encyption".HasValue then
            exit('');

        CR[1] := 10;
        CalcFields("SSN Encyption");
        TempBlob.Blob := "SSN Encyption";

        if EncryptionManagement.IsEncryptionEnabled then
            exit(EncryptionManagement.Decrypt((TempBlob.ReadAsText(CR, TEXTENCODING::Windows))))
        else
            exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;
}

