report 50013 "DK_Cemetery Amount Unpaid"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCemeteryAmountUnpaid.rdl';
    Caption = 'Cemetery Amount Unpaid';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DK_Contract; DK_Contract)
        {
            DataItemTableView = SORTING("No.");
            column(ContractDate; DK_Contract."Contract Date")
            {
            }
            column(MainCustName; DK_Contract."Main Customer Name")
            {
            }
            column(CemteryNo; DK_Contract."Cemetery No.")
            {
            }
            column(RemainingAmount; DK_Contract."Remaining Amount")
            {
            }
            column(RemainingDueDate; DK_Contract."Remaining Due Date")
            {
            }
            column(PaymentAmount; DK_Contract."Payment Amount")
            {
            }
            column(PayRemainingAmount; DK_Contract."Pay. Remaining Amount")
            {
            }
            column(CRMSalesPerson; DK_Contract."CRM SalesPerson")
            {
            }
            column(DepositAmount; DK_Contract."Deposit Amount")
            {
            }
            column(ContractAmount; DK_Contract."Contract Amount")
            {
            }
            column(ReferenceDateFrom; ReferenceDateFrom)
            {
            }
            column(ReferenceDateTo; ReferenceDateTo)
            {
            }

            trigger OnPreDataItem()
            begin

                GetReferenceDate(ReferenceDateFrom, ReferenceDateTo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ReferenceDateFrom; ReferenceDateFrom)
                {
                    Caption = 'Reference Date From';
                }
                field(ReferenceDateTo; ReferenceDateTo)
                {
                    Caption = 'ReferenceDateTo';
                }
            }
        }

        actions
        {
        }

        trigger OnAfterGetRecord()
        begin

            ReferenceDateFrom := CalcDate('<-CM>', Today);
            ReferenceDateTo := CalcDate('<CM>', Today);
        end;

        trigger OnOpenPage()
        begin

            ReferenceDateFrom := CalcDate('<-CM>', Today);
            ReferenceDateTo := CalcDate('<CM>', Today);
        end;
    }

    labels
    {
        TotalLb = 'Total';
        TitleLb = 'Cemtery Amount Unpaid';
        ContractLb = 'Contract Date';
        MainCustNameLb = 'Main Customer Name';
        CemeteryNoLb = 'Cemetery No.';
        RemainingAmLb = 'Remaining Amount';
        RemainingDuDateLb = 'Remaining Due Date';
        PayRemainingAmLb = 'Payment Remaining Amount';
        SalesPersonLb = 'Sales Person';
        ReferenceLb = 'Reference :';
    }

    var
        ReferenceDateFrom: Date;
        ReferenceDateTo: Date;


    procedure GetReferenceDate(pReferDateFrom: Date; pReferDateTo: Date)
    begin

        DK_Contract.SetCurrentKey("CRM SalesPerson");
        DK_Contract.SetFilter("Contract Date", '%1..%2', pReferDateFrom, pReferDateTo);
        DK_Contract.SetFilter("Pay. Remaining Amount", '<>%1', 0);
        DK_Contract.SetFilter("Remaining Amount", '>%1', 0);
    end;
}

