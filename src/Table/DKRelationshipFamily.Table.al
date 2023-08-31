table 50035 "DK_Relationship Family"
{
    // 
    // DK34: 20201026
    //   - Modify Trigger: OnModify()
    //   - Add Field: "Reagree Prov. Info Send Date"

    Caption = 'Relationship Family';
    DataCaptionFields = "Contract No.","Supervise No.","Cemetery No.",Name;
    DrillDownPageID = "DK_Relationship Family List";
    LookupPageID = "DK_Relationship Family List";

    fields
    {
        field(1;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No.";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin

                if _Contract.Get("Contract No.") then begin
                  Validate("Cemetery Code",_Contract."Cemetery Code");
                  Validate("Supervise No.",_Contract."Supervise No.");
                end else begin
                  Validate("Cemetery Code",'');
                  Validate("Supervise No.",'');
                end;
            end;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Supervise No.";Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
        }
        field(4;"Cemetery Code";Code[20])
        {
            Caption = 'Cemetery Code';
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE (Blocked=CONST(false));

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
        field(5;"Cemetery No.";Text[50])
        {
            Caption = 'Cemetery No.';
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery No." WHERE (Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Cemetery Code",_Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(6;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(7;Relationship;Text[30])
        {
            Caption = 'Relationship';
            DataClassification = ToBeClassified;
        }
        field(8;"Post Code";Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(9;Address;Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(10;"Address 2";Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(11;"Receipt Date";Date)
        {
            Caption = 'Receipt Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Phone No.";Text[30])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Phone No." <> "Phone No." then begin
                  if "Phone No." <>'' then
                    if not _CommFun.CheckValidPhoneNo("Phone No.") then
                      Error(MSG001, FieldCaption("Phone No."));
                end;
            end;
        }
        field(13;"E-mail";Text[80])
        {
            Caption = 'E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."E-mail" <> "E-mail" then begin
                  _MailMgt.ValidateEmailAddressField("E-mail");
                end;
            end;
        }
        field(14;"Mobile No.";Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Mobile No." <> "Mobile No." then begin
                  if "Mobile No." <>'' then
                    if not _CommFun.CheckValidMobileNo("Mobile No.") then
                      Error(MSG001, FieldCaption("Mobile No."));
                end;
            end;
        }
        field(15;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19;Remark;Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(20;Used;Boolean)
        {
            Caption = 'Used';
            DataClassification = ToBeClassified;
        }
        field(21;"Last Access Date";Date)
        {
            Caption = 'Last Access Date';
            DataClassification = ToBeClassified;
        }
        field(22;"Personal Data";Boolean)
        {
            Caption = 'Personal Data';
            DataClassification = ToBeClassified;
        }
        field(23;"Marketing SMS";Boolean)
        {
            Caption = 'Marketing SMS';
            DataClassification = ToBeClassified;
        }
        field(24;"Marketing Phone";Boolean)
        {
            Caption = 'Marketing Phone';
            DataClassification = ToBeClassified;
        }
        field(25;"Marketing E-Mail";Boolean)
        {
            Caption = 'Marketing E-Mail';
            DataClassification = ToBeClassified;
        }
        field(26;"Personal Data Third Party";Boolean)
        {
            Caption = 'Personal Data Third Party';
            DataClassification = ToBeClassified;
        }
        field(27;"Personal Data Referral";Boolean)
        {
            Caption = 'Personal Data Referral';
            DataClassification = ToBeClassified;
        }
        field(28;"Personal Data Concu. Date";Date)
        {
            Caption = 'Personal Data Concurrence Date';
            DataClassification = ToBeClassified;
        }
        field(29;"Reagree Prov. Info Send Date";Date)
        {
            Caption = 'Reagree Provide To Info Send Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59000;IDX;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59001;"Missing Cemetery No.";Text[30])
        {
            Caption = 'Missing Cemetery No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Contract No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;Name)
        {
        }
        key(Key3;Relationship)
        {
        }
        key(Key4;"Receipt Date")
        {
        }
        key(Key5;"Mobile No.")
        {
        }
        key(Key6;"E-mail")
        {
        }
        key(Key7;"Personal Data")
        {
        }
        key(Key8;"Marketing SMS")
        {
        }
        key(Key9;"Marketing Phone")
        {
        }
        key(Key10;"Personal Data Referral")
        {
        }
        key(Key11;"Personal Data Third Party")
        {
        }
        key(Key12;"Personal Data Concu. Date")
        {
        }
        key(Key13;"Marketing E-Mail")
        {
        }
        key(Key14;"Personal Data","Personal Data Concu. Date")
        {
        }
        key(Key15;"Missing Cemetery No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Receipt Date" := WorkDate;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    var
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
    begin

        //DK34
        _ReagreeToProvideInfo.Reset;
        _ReagreeToProvideInfo.SetRange("Source No.","Contract No.");
        _ReagreeToProvideInfo.SetRange("Source Line No.","Line No.");
        _ReagreeToProvideInfo.SetRange(Type,_ReagreeToProvideInfo.Type::ReleationFam);
        _ReagreeToProvideInfo.SetRange("Send Type",false);
        if _ReagreeToProvideInfo.FindSet then
          Error(MSG002,_ReagreeToProvideInfo.FieldCaption("No."),_ReagreeToProvideInfo."No.");
        //

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG002: Label 'A non-transmitted document exists for information re-operation. Please send it first and correct it. %1: %2';
}

