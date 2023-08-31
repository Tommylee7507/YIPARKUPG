report 50027 "DK_Payment Refund Bill"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKPaymentRefundBill.rdl';
    Caption = 'Payment Refund Bill';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(RefundBill; "DK_Revocation Contract")
        {
            DataItemTableView = SORTING("Document No.");
            column(RevocationDate; "Revocation Date")
            {
            }
            column(RequestDate; "Payment Request Date")
            {
            }
            column(CompletionDate; "Payment Completion Date")
            {
            }
            column(BankAccountNoText; BankAccountNoText)
            {
            }
            column(RevocationDateText; RevocationDateText)
            {
            }
            column(RefCemeteryAmount; RefundBill."Refund Cemetery Amount")
            {
            }
            column(RefGeneralAmount; RefundBill."Refund General Amount")
            {
            }
            column(RefLandArcAmount; RefundBill."Refund Land. Arc. Amount")
            {
            }
            column(RefBuryAmount; RefundBill."Refund Bury Amount")
            {
            }
            column(TotalRefundAmount; RefundBill."Apply Refund Amount")
            {
            }
            column(GeneralRefundText; GeneralRefundText)
            {
            }
            column(LandRefundText; LandRefundText)
            {
            }
            dataitem(Contract; DK_Contract)
            {
                DataItemLink = "No." = FIELD("Contract No.");
                DataItemTableView = SORTING("No.");
                column(CemeteryNo; "Cemetery No.")
                {
                }
                column(MainCustName; "Main Customer Name")
                {
                    IncludeCaption = true;
                }
                column(CustSSN; "Cust. Social Security No.")
                {
                }
                column(CemeterySzie; "Cemetery Size")
                {
                }
                column(SSNText; SSNText)
                {
                }
                column(AddressText; AddressText)
                {
                }
                column(CustMobileNo; "Cust. Mobile No.")
                {
                }
                column(ContractDate; "Contract Date")
                {
                }
                column(CemeteryAmount; "Cemetery Amount")
                {
                }
                column(BuryAmount; "Bury Amount")
                {
                }
                column(GeneralAmount; "General Amount")
                {
                }
                column(LandscapeAmount; "Landscape Arc. Amount")
                {
                }

                trigger OnAfterGetRecord()
                var
                    _Customer: Record DK_Customer;
                begin

                    Clear(AddressText);
                    Clear(SSNText);

                    Contract.CalcFields("Cust. Address", "Cust. Address 2");
                    AddressText := StrSubstNo(AddressMSG, "Cust. Address", "Cust. Address 2");
                    if _Customer.Get(Contract."Main Customer No.") then begin
                        SSNText := _Customer.GetSSNSSNCalculated;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                BankAccountNoText := StrSubstNo(BankAccountMSG, "Bank Name", "Account Holder", "Bank Account No.");
                RevocationDateText := StrSubstNo(RevocationMSG, "Revocation Date");
                if ("General Refund Term" <> 0) and ("General Starting Date" <> 0D) and ("General Expiration Date" <> 0D) then
                    GeneralRefundText := StrSubstNo(AdminRefundMSG, "General Refund Term", "General Starting Date", "General Expiration Date");
                if ("Landscape Refund Term" <> 0) and ("Landscape Starting Date" <> 0D) and ("Land. Arc. Expiration Date" <> 0D) then
                    LandRefundText := StrSubstNo(AdminRefundMSG, "Landscape Refund Term", "Landscape Starting Date", "Land. Arc. Expiration Date");
            end;

            trigger OnPreDataItem()
            begin

                RefundBill.SetRange("Document No.", gDocumentNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(gDocumentNo; gDocumentNo)
                {
                    Caption = 'Document No';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TitleLb = 'Payment Refund Bill';
        Approval1Lb = 'gyul';
        Approval2Lb = 'jae';
        EmployeeLb = 'Employee';
        ManagerLb = 'Manager';
        DeputyGenManagerLb = 'Deputy General Manager';
        SiteManagerLb = 'Site Manager';
        PresidentLb = 'President';
        CemeteryNoLb = 'Cemetery No.';
        CemeterySizeLb = 'Cemetery Size';
        MainCustNameLb = 'Main Customer Name';
        SSNLb = 'Social Security No.';
        AddressLb = 'Address';
        MobileNoLb = 'Mobile No.';
        ContractDateLb = 'Contract Date';
        RevodaitonDateLb = 'Revocation Request Date';
        PaymentRequestDateLb = 'Payment Request Date';
        ContractAmountLb = 'Contract Amount';
        RefundAmountLb = 'Refund Amount';
        CementeryAmountLb = 'Cemetery Amount';
        BuryAmountLb = 'Bury Amount';
        GeneralAdminAmountLb = 'General Admin Amount';
        LandAdminAmountLb = 'Land Admin Amount';
        TotalLb = 'TotalLb';
        BankAccontLb = 'Bank Account No';
        CompletionDateLb = 'Refund payment and settlement completion date';
        CorporationLb = 'Corporation';
        YoinParkLb = 'YonginPark';
        RequestDateLb = 'Request Date';
    }

    var
        gDocumentNo: Code[10];
        AddressMSG: Label '%1 %2';
        AddressText: Text;
        SSNText: Text;
        BankAccountNoText: Text;
        BankAccountMSG: Label '%1(%2): %3';
        RevocationDateText: Text;
        RevocationMSG: Label 'Request Date : %1';
        AdminRefundMSG: Label '%1Day Refund (%2 ~ %3)';
        GeneralRefundText: Text;
        LandRefundText: Text;


    procedure SetParam(pDocumentNo: Code[10])
    begin

        gDocumentNo := pDocumentNo;
    end;
}

