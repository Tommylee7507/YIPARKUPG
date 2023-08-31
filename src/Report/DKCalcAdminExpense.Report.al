report 50028 "DK_Calc. Admin. Expense"
{
    Caption = 'Calc. Admin. Expense';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    Caption = 'General';
                    field(ContractNo; ContractNo)
                    {
                        Caption = 'Contract No.';
                        Editable = false;
                    }
                    field(CemeteryNo; CemeteryNo)
                    {
                        Caption = 'Cemetery No';
                        Editable = false;
                    }
                    field(GenExpDate; GenExpDate)
                    {
                        Caption = 'General Expiration Date';
                        Editable = false;
                    }
                    field(LandArcExpDate; LandArcExpDate)
                    {
                        Caption = 'Land. Arc. Expiration Date';
                        Editable = false;
                    }
                    field(CalcType; CalcType)
                    {
                        Caption = 'Calculation Type';
                        OptionCaption = 'Date,Amount';

                        trigger OnValidate()
                        begin

                            Clear(InputAmount);
                            Clear(InputDate);
                            Clear(ApplyAmount);
                            Clear(DiffAmount);
                        end;
                    }
                    field(AdminExpenseType; AdminExpenseType)
                    {
                        Caption = 'Admin. Expense Type';
                        OptionCaption = 'General,Landscape Architecture';
                    }
                }
                group(Data)
                {
                    Caption = 'Data';
                    group(Control9)
                    {
                        ShowCaption = false;
                        field(InputDate; InputDate)
                        {
                            Caption = 'Input Date';
                        }
                        field(InputAmount; InputAmount)
                        {
                            Caption = 'Result Amount';
                            Editable = false;
                        }
                    }
                    group(Control7)
                    {
                        ShowCaption = false;
                        field("Input Amount"; InputAmount)
                        {
                            Caption = 'Input Amount';
                        }
                        field("Result Date"; InputDate)
                        {
                            Caption = 'Result Date';
                            Editable = false;
                        }
                        field(ApplyAmount; ApplyAmount)
                        {
                            AutoFormatType = 1;
                            Caption = 'Applied Amount';
                            Editable = false;
                        }
                        field(DiffAmount; DiffAmount)
                        {
                            AutoFormatType = 1;
                            Caption = 'Remaining Amount';
                            Editable = false;
                        }
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(Calculation)
                {
                    Caption = 'Calculation';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                    begin
                        //Calc
                        Clear(ApplyAmount);
                        Clear(DiffAmount);

                        if CalcType = CalcType::Date then begin
                            Clear(InputDate);
                            InputDate := _AdminExpenseMgt.GetCalcAdminExpenseEndingDateForAmount(ContractNo, AdminExpenseType, InputAmount, ApplyAmount, DiffAmount, 0D, false);

                        end else begin
                            Clear(InputAmount);

                            InputAmount := _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate(ContractNo, AdminExpenseType, InputDate, 0D, false);
                        end;

                        Message(MSG002);
                    end;
                }
            }
        }

        trigger OnOpenPage()
        begin

            if Contract.Get(ContractNo) then begin
                CemeteryNo := Contract."Cemetery No.";
                GenExpDate := Contract."General Expiration Date";
                LandArcExpDate := Contract."Land. Arc. Expiration Date";
            end else
                Error(MSG001);
        end;
    }

    labels
    {
    }

    var
        InputAmount: Decimal;
        InputDate: Date;
        ApplyAmount: Decimal;
        DiffAmount: Decimal;
        CalcType: Option Date,Amount;
        AdminExpenseType: Option General,Landscape;
        Contract: Record DK_Contract;
        ContractNo: Code[20];
        CemeteryNo: Code[20];
        MSG001: Label 'No contract information found.';
        GenExpDate: Date;
        LandArcExpDate: Date;
        MSG002: Label 'Calculation is complete.';


    procedure SetParameter(pContractNo: Code[20])
    begin

        ContractNo := pContractNo;
    end;
}

