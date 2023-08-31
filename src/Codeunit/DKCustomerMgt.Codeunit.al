codeunit 50042 "DK_Customer Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';


    procedure InsertDeleteCustomerLog(Rec: Record DK_Customer)
    var
        _CustomerDeleteLog: Record "DK_Customer Delete Log";
    begin

        with _CustomerDeleteLog do begin
            Init;

            "Entry No." := 0;
            "No." := Rec."No.";
            Name := Rec.Name;
            "Post Code" := Rec."Post Code";
            Address := Rec.Address;
            "Address 2" := Rec."Address 2";
            "Phone No." := Rec."Phone No.";
            "Encrypted ID No." := Rec."Encrypted ID No.";
            Type := Rec.Type;
            "E-mail" := Rec."E-mail";
            Birthday := Rec.Birthday;
            "Social Security No." := Rec."Social Security No.";
            Gender := Rec.Gender;
            "Company Post Code" := Rec."Company Post Code";
            "Company Address" := Rec."Company Address";
            "Company Address 2" := Rec."Company Address 2";
            "No. Series" := Rec."No. Series";
            "Mobile No." := Rec."Mobile No.";

            "Creation Date" := Rec."Creation Date";
            "Creation Person" := Rec."Creation Person";
            "Last Date Modified" := Rec."Last Date Modified";
            "Last Modified Person" := Rec."Last Modified Person";
            Status := Rec.Status;
            "Create Organizer" := Rec."Create Organizer";
            Description := Rec.Description;
            "VAT Registration No." := Rec."VAT Registration No.";
            Memo := Rec.Memo;
            "SSN Encyption" := Rec."SSN Encyption";

            "Personal Data" := Rec."Personal Data";
            "Marketing SMS" := Rec."Marketing SMS";
            "Marketing Phone" := Rec."Marketing Phone";
            "Marketing E-Mail" := Rec."Marketing E-Mail";
            "Personal Data Third Party" := Rec."Personal Data Third Party";
            "Personal Data Referral" := Rec."Personal Data Referral";
            "Personal Data Concu. Date" := Rec."Personal Data Concu. Date";

            //"Address Unkonwn" := Rec."Address Unknown";

            if Rec."Request DateTime" <> CreateDateTime(0D, 0T) then
                "Request DateTime" := Rec."Request DateTime"
            else
                "Request DateTime" := CreateDateTime(Today, Time);

            if "Request Person" <> '' then
                "Request Person" := Rec."Request Person"
            else
                "Request Person" := UserId;

            "Delete DateTime" := CreateDateTime(Today, Time);          // ‹Ð‘ª—© ‚»’Ñ/“ú
            "Delete Person" := UserId;                                // ‹Ð‘ªÀ

            m_id := Rec.m_id;
            t_id := Rec.t_id;
            Idx := Rec.Idx;
            "joint Tenancy" := Rec."joint Tenancy";
            "Before Customer No." := Rec."Before Customer No.";

            Insert(true);
        end;
    end;


    procedure CheckCustomerWithRelate(Rec: Record DK_Customer)
    var
        _ReqRemLedger: Record "DK_Request Remittance Ledger";
        _Contract: Record DK_Contract;
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
        _RevocationContract: Record "DK_Revocation Contract";
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
    begin

        with Rec do begin

            _ReqRemLedger.Reset;
            _ReqRemLedger.SetRange("Account Type", _ReqRemLedger."Account Type"::Customer);
            _ReqRemLedger.SetRange("Account No.", "No.");
            if not _ReqRemLedger.IsEmpty then
                Error(MSG001, TableCaption, "No.", _ReqRemLedger.TableCaption);

            _Contract.Reset;
            _Contract.SetRange("Main Customer No.", "No.");
            if not _Contract.IsEmpty then
                Error(MSG001, TableCaption, "No.", _Contract.TableCaption);

            _Contract.Reset;
            _Contract.SetRange("Customer No. 2", "No.");
            if not _Contract.IsEmpty then
                Error(MSG001, TableCaption, "No.", _Contract.TableCaption);

            _Contract.Reset;
            _Contract.SetRange("Customer No. 3", "No.");
            if not _Contract.IsEmpty then
                Error(MSG001, TableCaption, "No.", _Contract.TableCaption);

            _Contract.Reset;
            _Contract.SetRange("Main Associate No.", "No.");
            if not _Contract.IsEmpty then
                Error(MSG001, TableCaption, "No.", _Contract.TableCaption);

            _Contract.Reset;
            _Contract.SetRange("Sub Associate No.", "No.");
            if not _Contract.IsEmpty then
                Error(MSG001, TableCaption, "No.", _Contract.TableCaption);

            _RevocationContract.Reset;
            _RevocationContract.SetRange("Customer No.", "No.");
            if not _RevocationContract.IsEmpty then
                Error(MSG001, TableCaption, "No.", _RevocationContract.TableCaption);

            _ReagreeToProvideInfo.Reset;
            _ReagreeToProvideInfo.SetRange("Source No.", "No.");
            _ReagreeToProvideInfo.SetRange(Type, _ReagreeToProvideInfo.Type::Customer);
            _ReagreeToProvideInfo.SetRange("Send Type", false);
            if not _ReagreeToProvideInfo.IsEmpty then
                Error(MSG001, TableCaption, "No.", _ReagreeToProvideInfo.TableCaption);
        end;
    end;
}

