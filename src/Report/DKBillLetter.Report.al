report 50025 "DK_Bill Letter"
{
    RDLCLayout = './src/layout/DKBillLetter.rdl';
    WordLayout = './src/layout/DKBillLetter.docx';
    Caption = 'Bill Letter';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Publish Admin. Expense Doc.")
        {
            DataItemTableView = SORTING("Document No.");
            dataitem(Line; "DK_Publish Admin. Exp. Doc. Li")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Print Select" = CONST(true));
                column(cusName; "Customer Name")
                {
                }
                column(address; Address)
                {
                }
                column(address2; "Address 2")
                {
                }
                column(postcode; "Post Code")
                {
                }
                column(NonPaymentText; NonPaymentText)
                {
                }
                column(nonpayfrom; StrSubstNo(NonpayTxt, Format("Non-Payment From Date 1", 0, '<Year4>. <Month,2>. <Day,2>.'), Format("Non-Payment From Date 1", 0, '<Year4>. <Month,2>. <Day,2>.')))
                {
                }
                column(prepayfromto; StrSubstNo(PrepayfirstTxt, Format("Prepayment From Date 1", 0, '<Year4>. <Month,2>. <Day,2>.'), Format("Prepayment To Date 1", 0, '<Year4>. <Month,2>. <Day,2>.')))
                {
                }
                column(prepayfrom; StrSubstNo(PeriodFromTxt, Format("Prepayment From Date 1", 0, '<Year4> ‚Ë <Month,2> õ<Day,2> Ÿ')))
                {
                }
                column(prepayto; StrSubstNo(PeriodToTxt, Format("Prepayment To Date 1", 0, '<Year4> ‚Ë <Month,2> õ<Day,2> Ÿ')))
                {
                }
                column(cemNo; "Cemetery No.")
                {
                }
                column(Todays; Format(Today, 0, '<Year4>   <Month,2>   <Day,2>  '))
                {
                }
                column(generalAmount; "General Amount")
                {
                }
                column(jogyungAmount; "Landscape Arc. Amount")
                {
                }
                column(MinapGeneralAmount; "Non-Pay. General Amount")
                {
                }
                column(MinapjogyungAmount; "Non-Pay. Land. Arc. Amount")
                {
                }
                column(napIpDate; StrSubstNo(SubmitTxt, Format("Payment Due Date", 0, '<Year4> ‚Ë <Month,2> õ<Day,2> Ÿ')))
                {
                }
                column(ArrPostCode1; ArrPost[1])
                {
                }
                column(ArrPostCode2; ArrPost[2])
                {
                }
                column(ArrPostCode3; ArrPost[3])
                {
                }
                column(ArrPostCode4; ArrPost[4])
                {
                }
                column(ArrPostCode5; ArrPost[5])
                {
                }
                column(bankName; "Bank Name")
                {
                }
                column(bankacountNo; "Bank Account No.")
                {
                }
                column(accountHolder; "Account Holder")
                {
                }
                column(NewDate; Format(NewDate, 0, '<Year4>. <Month,2>. <Day,2>.'))
                {
                }
                column(nonPayP; NonPaymentPeriod)
                {
                }
                column(NonPayAmount; NonPaymentAmount)
                {
                }
                column(PrePayPeriod; PrePayPeriod)
                {
                }
                column(PrePayAmount; PrePayAmount)
                {
                }
                column(TotalPeriod; TotalPeriod)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(DayTxt; Date2DMY(Today, 1))
                {
                }
                column(MonthTxt; Date2DMY(Today, 2))
                {
                }
                column(YearTxt; Date2DMY(Today, 3))
                {
                }
                dataitem(Sub; DK_Contract)
                {
                    DataItemLink = "No." = FIELD("Contract No.");
                    DataItemTableView = SORTING("No.");
                    column(PayGeneralAmount; PayGeneralAmount)
                    {
                    }
                    column(PayLandscapeAmount; PayLandscapeAmount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        PayGeneralAmount := StrSubstNo(UnitTxt, (Line."General Amount" + Line."Non-Pay. General Amount"));
                        PayLandscapeAmount := StrSubstNo(Unit2Txt, (Line."Landscape Arc. Amount" + Line."Non-Pay. Land. Arc. Amount"));
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    _PostCode: Text[10];
                    _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
                begin
                    NewDate := Line."Prepayment From Date 1" - 1;

                    _PostCode := DelChr(Line."Post Code", '=', '-');
                    Clear(ArrPost);
                    ArrPost[1] := CopyStr(_PostCode, 1, 1);
                    ArrPost[2] := CopyStr(_PostCode, 2, 1);
                    ArrPost[3] := CopyStr(_PostCode, 3, 1);
                    ArrPost[4] := CopyStr(_PostCode, 4, 1);
                    ArrPost[5] := CopyStr(_PostCode, 5, 1);

                    SetNonPaymentDate;

                    NonPaymentText := StrSubstNo(NonpayTxt, Format(NonPayStartDate, 0, '<Year4>. <Month,2>. <Day,2>.'), Format(NonPayEndDate, 0, '<Year4>. <Month,2>. <Day,2>.'));
                    NonPaymentPeriod := StrSubstNo(MonthTxt, _RevocationContractMgt.CalcContractPreiodMonth(NonPayStartDate, NonPayEndDate));
                    NonPaymentAmount := StrSubstNo(WonTxt, Line."Non-Pay. General Amount" + Line."Non-Pay. Land. Arc. Amount");
                    PrePayPeriod := StrSubstNo(MonthTxt, _RevocationContractMgt.CalcContractPreiodMonth(Line."Prepayment From Date 1", Line."Prepayment To Date 1"));
                    PrePayAmount := StrSubstNo(WonTxt, Line."General Amount" + Line."Landscape Arc. Amount");
                    TotalPeriod := StrSubstNo(MonthTxt, _RevocationContractMgt.CalcContractPreiodMonth(Line."Prepayment From Date 1", Line."Prepayment To Date 1") + _RevocationContractMgt.CalcContractPreiodMonth(NonPayStartDate, NonPayEndDate));
                    TotalAmount := StrSubstNo(WonTxt, (Line."General Amount" + Line."Landscape Arc. Amount") + (Line."Non-Pay. General Amount" + Line."Non-Pay. Land. Arc. Amount"));
                end;

                trigger OnPreDataItem()
                var
                    gContractNo: Code[20];
                    gLineNo: Integer;
                begin
                end;
            }

            trigger OnAfterGetRecord()
            var
                _PublishAdminExpense: Codeunit "DK_Publish Admin. Expense";
            begin

                _PublishAdminExpense.UpdateGeneralCounsel(Header);
            end;

            trigger OnPreDataItem()
            begin

                if gDocumentNo <> '' then
                    Header.SetRange("Document No.", gDocumentNo);
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
                    Caption = 'Document No.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        WonLbl = 'Won';
        GwanlibiLbl = 'GwanliBi';
        GaeSiLbl = 'GaeSi';
        GaeSiLbl2 = 'GaeSi2';
        GaesiLbl3 = 'GaeSi3';
        GaesiLbl4 = 'GaeSi4';
        GaesiLbl5 = 'GaeSi5';
        SixtyLbl = '60';
        TotalPayLbl1 = 'Total Amount';
    }

    var
        NonpayTxt: Label 'Nonpay: %1 ~ %2';
        PrepayfirstTxt: Label 'Prepayfirst';
        GeneralTxt: Label '%1 GeneralAmount : %2';
        JogyungTxt: Label '%1 JogyungAmount : %2';
        PeriodFromTxt: Label 'Period : From %1';
        PeriodToTxt: Label '          %1To';
        SubmitTxt: Label 'Period %1';
        UnitTxt: Label '%1 UnitTxt';
        Unit2Txt: Label '%1 Unit2Txt';
        ArrPost: array[5] of Text[1];
        gDocumentNo: Code[20];
        gLineNo: Integer;
        MSG001: Label 'There is a line where the %1 is not selected. : %2';
        NewDate: Date;
        NonPaymentText: Text;
        NonPaymentPeriod: Text;
        MSG002: Label 'The selected Print destination does not exist.';
        MonthTxt: Label '%1 ‚õ';
        WonTxt: Label '%1 °';
        NonPaymentAmount: Text;
        NonPayStartDate: Date;
        NonPayEndDate: Date;
        PrePayPeriod: Text;
        PrePayAmount: Text;
        TotalPeriod: Text;
        TotalAmount: Text;
        PayGeneralAmount: Text;
        PayLandscapeAmount: Text;


    procedure SetParam(pDocumentNo: Code[20])
    begin

        gDocumentNo := pDocumentNo;
    end;


    procedure Check_CustomerConfirm(pDocumentNo: Code[20])
    var
        _PublishAdminExpDocLi: Record "DK_Publish Admin. Exp. Doc. Li";
    begin
        _PublishAdminExpDocLi.Reset;
        _PublishAdminExpDocLi.SetCurrentKey("Line No.");
        _PublishAdminExpDocLi.SetRange("Document No.", pDocumentNo);
        _PublishAdminExpDocLi.SetRange("Print Select", true);
        if _PublishAdminExpDocLi.FindSet then begin
            repeat
                if _PublishAdminExpDocLi."Check Customer Infor." = false then begin
                    _PublishAdminExpDocLi.CalcFields("Cemetery No.");
                    Error(MSG001, _PublishAdminExpDocLi.FieldCaption("Check Customer Infor."), _PublishAdminExpDocLi.FieldCaption("Cemetery No."),
                          _PublishAdminExpDocLi."Cemetery No.");
                end;
            until _PublishAdminExpDocLi.Next = 0;
        end else begin
            Error(MSG002);
        end;
    end;

    local procedure SetNonPaymentDate()
    begin

        if (Line."Non-Payment From Date 1" <> 0D) and (Line."Non-Payment From Date 2" <> 0D) then begin
            if Line."Non-Payment From Date 1" < Line."Non-Payment From Date 2" then
                NonPayStartDate := Line."Non-Payment From Date 1"
            else
                NonPayStartDate := Line."Non-Payment From Date 2"
        end else begin
            if Line."Non-Payment From Date 1" = 0D then
                NonPayStartDate := Line."Non-Payment From Date 2";

            if Line."Non-Payment From Date 2" = 0D then
                NonPayStartDate := Line."Non-Payment From Date 1";
        end;


        if (Line."Non-Payment To Date 1" <> 0D) and (Line."Non-Payment To Date 2" <> 0D) then begin
            if Line."Non-Payment To Date 1" < Line."Non-Payment To Date 2" then
                NonPayEndDate := Line."Non-Payment To Date 2"
            else
                NonPayEndDate := Line."Non-Payment To Date 1"
        end else begin
            if Line."Non-Payment To Date 1" = 0D then
                NonPayEndDate := Line."Non-Payment To Date 2";

            if Line."Non-Payment To Date 2" = 0D then
                NonPayEndDate := Line."Non-Payment To Date 1";
        end;
    end;
}

