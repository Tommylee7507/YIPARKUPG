page 50294 "DK_Interli. Cus. with CRM(Web)"
{
    Caption = 'Interli. Cus. with CRM(Web)';
    DelayedInsert = true;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interlink Cus. with CRM Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No.")
                {
                }
                field(No; Rec."Customer No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(PostCode; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(Address2; Rec."Address 2")
                {
                }
                field(MobileNo; Rec."Mobile No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Mobile No." <> '' then begin
                            if not CommFun.CheckValidMobileNo(Rec."Mobile No.") then
                                Error(MSG004, Rec.FieldCaption("Mobile No."));
                        end;
                    end;
                }
                field(PhoneNo; Rec."Phone No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Phone No." <> '' then begin
                            if not CommFun.CheckValidPhoneNo(Rec."Phone No.") then
                                Error(MSG004, Rec.FieldCaption("Phone No."));
                        end;
                    end;
                }
                field(Type; Rec.Type)
                {
                }
                field(SSNo; SSN)
                {
                    Caption = 'SocialSecurityNo';

                    trigger OnValidate()
                    begin
                        if (SSN <> '') then begin

                            if Rec.Type <> Rec.Type::Individual then
                                Error(MSG005, Rec.FieldCaption(Type), Rec.Type::Individual, Rec.Type);

                            SSN := UpperCase(SSN);

                            if Rec.Type = Rec.Type::Individual then begin
                                Customer.SocialSecurityValidation(SSN);

                                if StrLen(SSN) <> 14 then
                                    Error(MSG001, MSG003, StrLen(SSN));

                                if not CommFun.CheckDigitSSNo(SSN) then begin
                                    Error(MSG002, MSG003);
                                end;
                            end;
                        end;
                    end;
                }
                field(VATRegNo; Rec."VAT Registration No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."VAT Registration No." <> '' then
                            if Rec.Type <> Rec.Type::Corporation then
                                Error(MSG005, Rec.FieldCaption(Type), Rec.Type::Corporation, Rec.Type);
                    end;
                }
                field(EMail; Rec."E-mail")
                {

                    trigger OnValidate()
                    var
                        _MailMgt: Codeunit "Mail Management";
                    begin
                        if Rec."E-mail" <> '' then
                            _MailMgt.ValidateEmailAddressField(Rec."E-mail");
                    end;
                }
                field(Birthday; Rec.Birthday)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(CompanyPostCode; Rec."Company Post Code")
                {
                }
                field(CompanyAddress; Rec."Company Address")
                {
                }
                field(CompanyAddress2; Rec."Company Address 2")
                {
                }
                field(Memo; Rec.Memo)
                {
                }
                field(PersonalDataYN; Rec."Personal Data")
                {
                }
                field(MarketingSMSYN; Rec."Marketing SMS")
                {
                }
                field(MarketingPhoneYN; Rec."Marketing Phone")
                {
                }
                field(MarketingEMailYN; Rec."Marketing E-Mail")
                {
                }
                field(PersonalDataThirdPartyYN; Rec."Personal Data Third Party")
                {
                }
                field(PersonalDataReferralYN; Rec."Personal Data Referral")
                {
                }
                field(PersonalDataConcurrenceDate; Rec."Personal Data Concu. Date")
                {
                }
                field(RecordDel; Rec."Record Del")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        if Rec."Data Type" = Rec."Data Type"::Inbound then
            if _CRMDataInterlink.InboundCustomer(Rec, SSN) then
                Rec."Applied Date" := Today;
    end;

    trigger OnModifyRecord(): Boolean
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        /*IF "Data Type" = "Data Type"::Inbound THEN
          IF _CRMDataInterlink.InboundCustomer(Rec,SSN) THEN
          "Applied Date" := TODAY;
        */

    end;

    var
        SSN: Text[20];
        Customer: Record DK_Customer;
        MSG001: Label '%1 is not valid. Please enter in 13 digits. Ex) 123456-1234567, current number of digits:%2';
        MSG002: Label 'The specified value %1 is not valid. Please check again.';
        CommFun: Codeunit "DK_Common Function";
        MSG003: Label 'Social Security No.';
        MSG004: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG005: Label '%1œ %2ž µÕíˆˆ ¯‡’œ í„™—³„Ÿ„¾. —÷Ï ¬ :%3';
}

