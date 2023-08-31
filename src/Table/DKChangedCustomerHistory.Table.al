table 50009 "DK_Changed Customer History"
{
    Caption = 'Changed Customer History';
    DataCaptionFields = "Version No.", Name;
    DrillDownPageID = "DK_Changed Customer History";
    LookupPageID = "DK_Changed Customer History";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(4; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;
        }
        field(7; "Encrypted ID No."; Boolean)
        {
            Caption = 'Encrypted ID No.';
            DataClassification = ToBeClassified;
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Individual,Corporation';
            OptionMembers = Individual,Corporation;
        }
        field(9; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;
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
            OptionCaption = 'CRM,ERP';
            OptionMembers = CRM,ERP;
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
        }
        field(28; Memo; Text[250])
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(30; "Personal Data"; Boolean)
        {
            Caption = 'Personal Data';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Marketing SMS"; Boolean)
        {
            Caption = 'Marketing SMS';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Marketing Phone"; Boolean)
        {
            Caption = 'Marketing Phone';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Marketing E-Mail"; Boolean)
        {
            Caption = 'Marketing E-Mail';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Personal Data Third Party"; Boolean)
        {
            Caption = 'Personal Data Third Party';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Personal Data Referral"; Boolean)
        {
            Caption = 'Personal Data Referral';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Personal Data Concu. Date"; Date)
        {
            Caption = 'Personal Data Concurrence Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50000; "Version No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Version No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Date Modified"; DateTime)
        {
            Caption = 'Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Modified Person"; Code[50])
        {
            Caption = 'Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "Version No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date Modified" := CurrentDateTime;
        "Modified Person" := UserId;
    end;

    var
        _CommonFunc: Codeunit "DK_Common Function";


    procedure InsertChangeCustomer(pCustomer: Record DK_Customer)
    var
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
    begin

        _ChangedCustomerHistory.Init;
        _ChangedCustomerHistory.TransferFields(pCustomer);
        _ChangedCustomerHistory.Insert(true);
    end;


    procedure CheckChange(pCustomer: Record DK_Customer): Boolean
    var
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
        _OrgRecRef: RecordRef;
        _RevRecRef: RecordRef;
    begin

        _ChangedCustomerHistory.Reset;
        _ChangedCustomerHistory.SetCurrentKey("No.", "Version No.");
        _ChangedCustomerHistory.SetRange("No.", pCustomer."No.");
        if _ChangedCustomerHistory.FindLast then begin

            _OrgRecRef.GetTable(pCustomer);
            _RevRecRef.GetTable(_ChangedCustomerHistory);

            Clear(_CommonFunc);
            if _CommonFunc.GetCompareRecordValue(_OrgRecRef, _RevRecRef) then
                InsertChangeCustomer(pCustomer);
        end else begin
            InsertChangeCustomer(pCustomer);
        end;
    end;
}

