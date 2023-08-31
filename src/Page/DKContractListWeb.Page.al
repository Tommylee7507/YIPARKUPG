page 50289 "DK_Contract List (Web)"
{
    Caption = 'Contract List (Web)';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Contract;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ContractNo; Rec."No.")
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
                field(ContractType; Rec."Contract Type")
                {
                }
                field(GroupContractNo; Rec."Group Contract No.")
                {
                }
                field(AdminExpenseOption; Rec."Admin. Expense Option")
                {
                }
                field(CemeteryCode; Rec."Cemetery Code")
                {
                }
                field(CemeteryNo; Rec."Cemetery No.")
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
                field(EtcAmount; Rec."Etc. Amount")
                {
                }
                field(EtcDiscount; Rec."Etc. Discount")
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
                field(TotContractAmt; Rec."Deposit Amount" + Rec."Contract Amount")
                {
                    Caption = 'Total Contract Amount';
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
                field(AlarmPeriod2; Rec."Alarm Period 2")
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
                field(GeneralExpirationDate; Rec."General Expiration Date")
                {
                }
                field(LandArcExpirationDate; Rec."Land. Arc. Expiration Date")
                {
                }
                field(BeforeCemeteryNo; Rec."Before Cemetery Code")
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
                }
                field(AssociatePhoneNo; Rec."Associate Phone No.")
                {
                }
                field(AssociateEMail; Rec."Associate E-Mail")
                {

                    trigger OnValidate()
                    var
                        _MailMgt: Codeunit "Mail Management";
                    begin
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
                field(Memo; WorkMemo)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        WorkMemo := Rec.GetWorkMemo;
    end;

    var
        WorkMemo: Text;
}

