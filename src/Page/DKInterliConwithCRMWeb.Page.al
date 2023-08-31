page 50291 "DK_Interli. Con. with CRM(Web)"
{
    // 
    // *DK34 : 20201019
    //   - Add Field : "Main Kinsman Name","Main Kinsman Mobile No.","Main Kinsman Phone No.","Main Kinsman E-Mail"
    //                 "Main Kinsman Post Code","Main Kinsman Address","Main Kinsman Address 2"
    //                 "Sub Kinsman Name","Sub Kinsman Mobile No.","Sub Kinsman Phone No.","Sub Kinsman E-Mail"
    //                 "Sub Kinsman Post Code","Sub Kinsman Address","Sub Kinsman Address 2"
    //    - Rec. Modify Trigger : Main Kinsman Mobile No. - OnValidate()
    //                       Main Kinsman Phone No. - OnValidate()
    //                       Main Kinsman E-Mail - OnValidate()
    //                       Sub Kinsman Mobile No. - OnValidate()
    //                       Sub Kinsman Phone No. - OnValidate()
    //                       Sub Kinsman E-Mail - OnValidate()
    // 
    // DK35: 20210121
    //   - Delete Field: Kinsman Field...

    Caption = 'Interli. Contract with CRM(Web)';
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interlink Con. with CRM Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No.")
                {
                }
                field(ContractNo; Rec."Contract No.")
                {
                }
                field(SuperviseNo; Rec."Supervise No.")
                {
                }
                field(ContractDate; Rec."Contract Date")
                {
                }
                field(MainCustomerNo; Rec."Main Customer No.")
                {
                }
                field(CustomerNo2; Rec."Customer No. 2")
                {
                }
                field(CustomerNo3; Rec."Customer No. 3")
                {
                }
                field(CRMContractType; Rec."CRM Contract Type")
                {
                }
                field(GroupContractNo; Rec."Group Contract No.")
                {
                }
                field(CRMAdminExpenseOption; Rec."CRM Admin. Expense Option")
                {
                }
                field(CemeteryCode; Rec."Cemetery Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(ManaUnit; Rec."Management Unit")
                {
                }
                field(CemeteryAmount; Rec."Cemetery Amount")
                {
                }
                field(CemClassDisRate; Rec."Cemetery Class Dis. Rate")
                {
                }
                field(CemClassDiscount; Rec."Cemetery Class Discount")
                {
                }
                field(EtcAmount; Rec."Etc. Amount")
                {
                }
                field(EtcDiscount; Rec."Etc. Discount")
                {
                }
                field(GeneralAmount; Rec."General Amount")
                {
                }
                field("Landscape ArcAmount"; Rec."Landscape Arc. Amount")
                {
                }
                field(BuryAmount; Rec."Bury Amount")
                {
                }
                field(CemeteryDiscount; Rec."Cemetery Discount")
                {
                }
                field(SalesAmount; Rec."Sales Amount")
                {
                }
                field(DepositAmount; Rec."Deposit Amount")
                {
                }
                field(ContractAmount; Rec."Contract Amount")
                {
                }
                field(TotContractAmt; Rec."Total Contract Amount")
                {
                }
                field(ReceRemainingAmount; Rec."Rece. Remaining Amount")
                {
                }
                field(DepositReceiptDate; Rec."Deposit Receipt Date")
                {
                }
                field(PayContractReceDate; Rec."Pay. Contract Rece. Date")
                {
                }
                field(RemainingDueDate; Rec."Remaining Due Date")
                {
                }
                field(RemainingReceiptDate; Rec."Remaining Receipt Date")
                {
                }
                field(AlarmPeriod1; Rec."Alarm Period 1")
                {
                }
                field(SendAlarmDateTime1; Rec."Send Alarm Date/Time 1")
                {
                }
                field(AlarmPeriod2; Rec."Alarm Period 2")
                {
                }
                field(SendAlarmDateTime2; Rec."Send Alarm Date/Time 2")
                {
                }
                field(ManFeehikeExeDate; Rec."Man. Fee hike Exemption Date")
                {
                }
                field(ManFeeExeDate; Rec."Man. Fee Exemption Date")
                {
                }
                field(CRMSalesPersonCode; Rec."CRM SalesPerson Code")
                {
                }
                field(CRMExternalSalesCode; Rec."CRM External Sales Code")
                {
                }
                field(CRMFuneralHallCode; Rec."CRM Funeral Hall Code")
                {
                }
                field(CRMFuneralServiceCode; Rec."CRM Funeral Service Code")
                {
                }
                field(CRMChannelVendorNo; Rec."CRM Channel Vendor No.")
                {
                }
                field(CRMSalesTypeSeq; Rec."CRM Sales Type Seq")
                {
                }
                field(RevocationRegister; Rec."Revocation Register")
                {
                }
                field(RevocationDate; Rec."Revocation Date")
                {
                }
                field(RevocationAmount; Rec."Revocation Amount")
                {
                }
                field(CloseAmount; Rec."Close Amount")
                {
                }
                field(GeneralExpirationDate; Rec."General Expiration Date")
                {
                }
                field(LandArcExpirationDate; Rec."Land. Arc. Expiration Date")
                {
                }
                field(BeforeCemeteryNo; Rec."Before Cemetery No.")
                {
                }
                field(DepositPublish; Rec."Deposit Publish")
                {
                }
                field(ContractPublish; Rec."Contract Publish")
                {
                }
                field(RemainingPublish; Rec."Remaining Publish")
                {
                }
                field(AssociateRela; Rec."Associate Relationship")
                {
                }
                field("Associate Name"; Rec."Associate Name")
                {
                }
                field(AssociateMobileNo; Rec."Associate Mobile No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Associate Mobile No." <> '' then begin
                            //  IF NOT CommFun.CheckValidMobileNo("Associate Mobile No.") THEN
                            //    ERROR(MSG004, FIELDCAPTION("Associate Mobile No."));
                        end;
                    end;
                }
                field(AssociatePhoneNo; Rec."Associate Phone No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Associate Phone No." <> '' then begin
                            //  IF NOT CommFun.CheckValidPhoneNo("Associate Phone No.") THEN
                            //    ERROR(MSG004, FIELDCAPTION("Associate Phone No."));
                        end;
                    end;
                }
                field(AssociateEMail; Rec."Associate E-Mail")
                {

                    trigger OnValidate()
                    var
                        _MailMgt: Codeunit "Mail Management";
                    begin
                        if Rec."Associate E-Mail" <> '' then
                            _MailMgt.ValidateEmailAddressField(Rec."Associate E-Mail");
                    end;
                }
                field(AssociatePostCode; Rec."Associate Post Code")
                {
                }
                field(AssociateAddress; Rec."Associate Address")
                {
                }
                field(AssociateAddress2; Rec."Associate Address 2")
                {
                }
                field(Memo; Rec.Memo)
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
            if _CRMDataInterlink.InboundContract(Rec) then
                Rec."Applied Date" := Today;
    end;

    var
        CommFun: Codeunit "DK_Common Function";
        MSG001: Label '%1 is not valid. Please enter in 13 digits. Ex) 123456-1234567, current number of digits:%2';
        MSG002: Label 'The specified value %1 is not valid. Please check again.';
        MSG004: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG005: Label '%1œ %2ž µÕíˆˆ ¯‡’œ í„™—³„Ÿ„¾. —÷Ï ¬ :%3';
}

