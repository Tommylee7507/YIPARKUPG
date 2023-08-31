table 50008 DK_Customer
{
    // * Same Table
    //   > DK_Customer
    //   > DK_Changed Customer History
    // 
    // DK34 : 20201021
    //   - Add Function: CheckUserPermission
    //   - Modify Trigger: OnDelete()
    //   - Add Field: "Request Del", "Request DateTime", "Request Person"
    //      : 20201026
    //   - Modify Trigger: OnModify()

    Caption = 'Customer';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "DK_Customer List";
    LookupPageID = "DK_Customer List";

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
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                TestField(Status, Status::Open);

                if (xRec.Name <> Name) and (Name <> '') then
                    _ChangeMasterName.UpdateCustomer("No.", Name, xRec.Name);
            end;
        }
        field(3; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(4; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin

                if xRec."Phone No." <> "Phone No." then begin
                    TestField(Status, Status::Open);

                    //  IF "Phone No." <>'' THEN
                    //    IF NOT _CommFun.CheckValidPhoneNo("Phone No.") THEN
                    //      ERROR(MSG005, FIELDCAPTION("Phone No."));
                end;
            end;
        }
        field(7; "Encrypted ID No."; Boolean)
        {
            Caption = 'Encrypted ID No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Individual,Corporation';
            OptionMembers = Individual,Corporation;

            trigger OnValidate()
            begin
                if xRec.Type = Type then begin
                    TestField(Status, Status::Open);

                    if Type = Type::Individual then begin
                        "VAT Registration No." := '';
                    end else begin
                        Clear("Social Security No.");
                        Birthday := 0D;
                        Gender := 0;
                    end;
                end;
            end;
        }
        field(9; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."E-mail" <> "E-mail" then begin
                    TestField(Status, Status::Open);

                    _MailMgt.ValidateEmailAddressField("E-mail");

                end;
            end;
        }
        field(11; Birthday; Date)
        {
            Caption = 'Birthday';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(12; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(13; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(14; "Company Post Code"; Code[10])
        {
            Caption = 'Company Post Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(15; "Company Address"; Text[50])
        {
            Caption = 'Company Address';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(16; "Company Address 2"; Text[50])
        {
            Caption = 'Company Address 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
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
                if xRec."Mobile No." <> "Mobile No." then begin
                    TestField(Status, Status::Open);
                    //  IF "Mobile No." <> '' THEN BEGIN
                    //    IF NOT _CommFun.CheckValidMobileNo("Mobile No.") THEN
                    //      ERROR(MSG005, FIELDCAPTION("Mobile No."));
                    //  END;
                end;
            end;
        }
        field(20; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(25; "Create Organizer"; Option)
        {
            Caption = 'Create Organizer';
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = ERP;
            OptionCaption = 'CRM,ERP,Openning';
            OptionMembers = CRM,ERP,Openning;
        }
        field(26; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(27; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(28; Memo; Text[250])
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(29; "SSN Encyption"; BLOB)
        {
            Caption = 'Social Security No Encyption';
            DataClassification = ToBeClassified;
        }
        field(30; "Personal Data"; Boolean)
        {
            Caption = 'Personal Data';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(31; "Marketing SMS"; Boolean)
        {
            Caption = 'Marketing SMS';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(32; "Marketing Phone"; Boolean)
        {
            Caption = 'Marketing Phone';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(33; "Marketing E-Mail"; Boolean)
        {
            Caption = 'Marketing E-Mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(34; "Personal Data Third Party"; Boolean)
        {
            Caption = 'Personal Data Third Party';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(35; "Personal Data Referral"; Boolean)
        {
            Caption = 'Personal Data Referral';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(36; "Personal Data Concu. Date"; Date)
        {
            Caption = 'Personal Data Concurrence Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(37; "Reagree Prov. Info Send Date"; Date)
        {
            Caption = 'Reagree Provide To Information Send Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5000; "Request Del"; Boolean)
        {
            Caption = 'Request Del';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Request Del" <> "Request Del" then begin
                    if "Request Del" then begin
                        "Request DateTime" := CurrentDateTime;
                        "Request Person" := UserId;
                    end else begin
                        "Request DateTime" := DaTi2Variant(0D, 0T);
                        "Request Person" := '';
                    end;
                end;
            end;
        }
        field(5001; "Request DateTime"; DateTime)
        {
            Caption = 'Request DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Request Person"; Code[50])
        {
            Caption = 'Request Person';
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Idx)
        {
        }
        key(Key3; Name)
        {
        }
        key(Key4; "E-mail")
        {
        }
        key(Key5; "Mobile No.")
        {
        }
        key(Key6; "Phone No.")
        {
        }
        key(Key7; Status)
        {
        }
        key(Key8; "Social Security No.")
        {
        }
        key(Key9; "VAT Registration No.")
        {
        }
        key(Key10; Address)
        {
        }
        key(Key11; "Address 2")
        {
        }
        key(Key12; "Create Organizer")
        {
        }
        key(Key13; "Personal Data")
        {
        }
        key(Key14; "Marketing SMS")
        {
        }
        key(Key15; "Marketing Phone")
        {
        }
        key(Key16; "Personal Data Referral")
        {
        }
        key(Key17; "Personal Data Third Party")
        {
        }
        key(Key18; "Personal Data Concu. Date")
        {
        }
        key(Key19; "Marketing E-Mail")
        {
        }
        key(Key20; "Personal Data", "Personal Data Concu. Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, Birthday, "E-mail", "Mobile No.", "Phone No.")
        {
        }
    }

    trigger OnDelete()
    var
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
        _Contract: Record DK_Contract;
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
        _RevocationContract: Record "DK_Revocation Contract";
        _DK_CRMInterfaceMgt: Codeunit "DK_CRM Interface Mgt.";
        _CustomerMgt: Codeunit "DK_Customer Mgt.";
    begin
        // >> DK34 €——©
        //TESTFIELD(Status, Status::Open);

        if not CheckUserPermission then
            Error(MSG006);
        // <<

        //Check
        // >> DK34
        _CustomerMgt.CheckCustomerWithRelate(Rec);

        _CustomerMgt.InsertDeleteCustomerLog(Rec);
        // <<

        //Delete
        _ChangedCustomerHistory.Reset;
        _ChangedCustomerHistory.SetRange("No.", "No.");
        if _ChangedCustomerHistory.Find then
            _ChangedCustomerHistory.DeleteAll(true);


        //CRM Interface
        _DK_CRMInterfaceMgt.InterlinkCuswithCRMLogRecord(Rec, true);
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Customer Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Customer Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        TestField("No.");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    var
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
    begin
        TestField(Status, Status::Open);
        TestField("No.");
        TestField(Name);

        //DK34
        _ReagreeToProvideInfo.Reset;
        _ReagreeToProvideInfo.SetRange("Source No.", "No.");
        _ReagreeToProvideInfo.SetRange(Type, _ReagreeToProvideInfo.Type::Customer);
        _ReagreeToProvideInfo.SetRange("Send Type", false);
        if _ReagreeToProvideInfo.FindSet then begin
            Error(MSG007, _ReagreeToProvideInfo.FieldCaption("No."), _ReagreeToProvideInfo."No.");
        end;
        //

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
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'The contract does not exist.';
        MSG003: Label 'You must select an existing %1.';
        EncryptionManagement: Codeunit "Encryption Management";
        MSG004: Label 'Data Encryption Management has not been enabled. %1 : %2';
        SSNEncrypt: Text;
        MSG005: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG006: Label 'The permission to delete does not exist. Please contact your administrator.';
        MSG007: Label 'A non-transmitted document exists for information re-operation. Please send it first and correct it. %1: %2';


    procedure AssistEdit(OldCustomer: Record DK_Customer): Boolean
    var
        _Customer: Record DK_Customer;
    begin
        with _Customer do begin
            _Customer := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Customer Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Customer Nos.", OldCustomer."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _Customer;
                exit(true);
            end;
        end;
    end;


    procedure SetReOpen()
    begin
        if Status = Rec.Status::Open then
            exit;

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetReleased()
    var
        _DK_CRMInterfaceMgt: Codeunit "DK_CRM Interface Mgt.";
    begin
        TestField("No.");
        TestField(Name);
        if Status = Rec.Status::Released then
            exit;

        //CRM Interface
        _DK_CRMInterfaceMgt.InterlinkCuswithCRMLogRecord(Rec, false);

        Status := Rec.Status::Released;
        Modify;
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

    procedure GetCustomerNo(pCustomerText: Text): Text
    begin
        exit(GetCustomerNoOpenCard(pCustomerText));
    end;

    procedure GetCustomerNoOpenCard(pCustomerText: Text): Code[20]
    var
        _Customer: Record DK_Customer;
        _CustomerNo: Code[20];
        _NoFiltersApplied: Boolean;
        _CustomerWithoutQuote: Text;
        _CustomerFilterFromStart: Text;
        _CustomerFilterContains: Text;
    begin
        if pCustomerText = '' then
            exit('');

        if StrLen(pCustomerText) <= MaxStrLen(_Customer."No.") then
            if _Customer.Get(CopyStr(pCustomerText, 1, MaxStrLen(_Customer."No."))) then
                exit(_Customer."No.");

        //_Customer.SETRANGE(Blocked,FALSE);
        _Customer.SetRange(Name, pCustomerText);
        if _Customer.FindFirst then
            exit(_Customer."No.");

        _Customer.SetCurrentKey(Name);

        _CustomerWithoutQuote := ConvertStr(pCustomerText, '''', '?');
        _Customer.SetFilter(Name, '''@' + _CustomerWithoutQuote + '''');
        if _Customer.FindFirst then
            exit(_Customer."No.");

        _Customer.SetRange(Name);

        _CustomerFilterFromStart := '''@' + _CustomerWithoutQuote + '*''';

        _Customer.FilterGroup := -1;
        _Customer.SetFilter("No.", _CustomerFilterFromStart);
        _Customer.SetFilter(Name, _CustomerFilterFromStart);

        if _Customer.FindFirst then
            exit(_Customer."No.");

        _CustomerFilterContains := '''@*' + _CustomerWithoutQuote + '*''';

        _Customer.SetFilter("No.", _CustomerFilterContains);
        _Customer.SetFilter(Name, _CustomerFilterContains);

        if _Customer.Count = 1 then begin
            _Customer.FindFirst;
            exit(_Customer."No.");
        end;

        if not GuiAllowed then
            Error(MSG003, _Customer.TableCaption);


        Error(MSG003, _Customer.TableCaption);
    end;


    procedure ShowContractList(pCustomerNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _ContractList: Page "DK_Contract List";
    begin

        if pCustomerNo <> '' then begin
            _Contract.SetFilter("Contract Customers", '%1', '*' + pCustomerNo + '*');

            Clear(_ContractList);
            _ContractList.LookupMode(true);
            _ContractList.SetTableView(_Contract);
            _ContractList.SetRecord(_Contract);
            _ContractList.RunModal;
        end else
            Error(MSG002);
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

    local procedure CheckUserPermission(): Boolean
    var
        _UserSetup: Record "User Setup";
    begin

        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Customer Admin.", true);
        if _UserSetup.FindSet then
            exit(true);
    end;
}

