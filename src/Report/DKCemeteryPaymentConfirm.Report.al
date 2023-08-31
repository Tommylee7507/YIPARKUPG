report 50026 "DK_Cemetery Payment Confirm"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCemeteryPaymentConfirm.rdl';
    Caption = 'Cemetery Payment Confirm';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DK_Contract; DK_Contract)
        {
            DataItemTableView = SORTING("No.");
            column(MainCustomerName; DK_Contract."Main Customer Name")
            {
            }
            column(CemeteryNo; DK_Contract."Cemetery No.")
            {
            }
            column(CemeterySize; DK_Contract."Cemetery Size")
            {
            }
            column(CemeteryNoText; CemeteryNoText)
            {
            }
            column(AmountText; AmountText)
            {
            }
            column(BodyLineText; BodyLineText)
            {
            }
            column(CompanyInfoText; CompanyInfoText)
            {
            }
            column(Today; Format(Today, 0, '<Year4>. <Month,2>. <Day,2>.'))
            {
            }
            column(PaymentDateText; PaymentDateText)
            {
            }

            trigger OnAfterGetRecord()
            var
                _CompanyInfo: Record "Company Information";
            begin

                if DK_Contract.Status <> DK_Contract.Status::FullPayment then begin
                    Error(MSG002, DK_Contract.Status::FullPayment);
                end;

                if DK_Contract."Cemetery Amount" = 0 then begin
                    Error(MSG003, DK_Contract.FieldCaption("Cemetery Amount"));
                end;

                if "Pay. Remaining Amount" > 0 then
                    Error(MSG001, FieldCaption("Pay. Remaining Amount"));

                DK_Contract.CalcFields("Cemetery Size");
                CemeteryNoText := StrSubstNo(CemeteryNoMSG, DK_Contract."Cemetery No.", DK_Contract."Cemetery Size");

                AmountText := StrSubstNo(AmountMSG, DK_Contract."Payment Amount");

                if DK_Contract."Remaining Receipt Date" <> 0D then begin
                    BodyLineText := StrSubstNo(BodyMSG, DK_Contract."Cemetery Amount",
                                Format(DK_Contract."Remaining Receipt Date", 0, DateFomatMSG));
                    PaymentDateText := Format(DK_Contract."Remaining Receipt Date", 0, DateFomatMSG);
                end else begin
                    BodyLineText := StrSubstNo(BodyMSG, DK_Contract."Cemetery Amount",
                                Format(DK_Contract."Pay. Contract Rece. Date", 0, DateFomatMSG));
                    PaymentDateText := Format(DK_Contract."Pay. Contract Rece. Date", 0, DateFomatMSG);
                end;

                _CompanyInfo.Get;
                CompanyInfoText := _CompanyInfo.Name;
            end;

            trigger OnPreDataItem()
            begin

                DK_Contract.SetRange("No.", DocumentNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DocumentNo; DocumentNo)
                {
                    Caption = 'Document No.';
                    TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));

                    trigger OnValidate()
                    var
                        _Contract: Record DK_Contract;
                    begin
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TitleLb = 'Cemetery Payment Confirm';
        PaymentDateLb = 'Payment Date';
        MainCustNameLb = 'Main Customer Name';
        CemeteryNoLb = 'Cemetery No.';
        AmountLb = 'Amount';
    }

    var
        DocumentNo: Code[20];
        CemeteryNoMSG: Label '%1(%2 Size)';
        CemeteryNoText: Text;
        AmountMSG: Label '%1Won';
        BodyMSG: Label 'We will confirm the %2 standard payment of %1 won for the park cemetery fee of the approved park.';
        AmountText: Text;
        BodyLineText: Text;
        DateFomatMSG: Label '<Year4>-<Month,2>-<Day,2>';
        CompanyInfoText: Text;
        PaymentDateText: Text;
        MSG001: Label 'You have a %1 remaining.';
        MSG002: Label '—¹„Ï ÐŽÊŠ %1 ‹Ý•’í Ž–„³„Ÿ„¾.';
        MSG003: Label '%1œ(í) 0ž ÐŽÊ ¯„Ÿ„¾.';


    procedure SetParm(pNo: Code[20])
    begin

        DocumentNo := pNo;
    end;
}

