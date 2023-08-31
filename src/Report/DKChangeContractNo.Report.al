report 50015 "DK_Change Contract No."
{
    Caption = 'Change Contract No.';
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
                    field(PayReceiptDocNo; PayReceiptDocNo)
                    {
                        Caption = 'Payment Receipt Document No.';
                        Editable = false;
                    }
                    field(CurrContractNo; CurrContractNo)
                    {
                        Caption = 'Current Contract No.';
                        Editable = false;
                    }
                    field(NewContractNo; NewContractNo)
                    {
                        Caption = 'New Contract No.';
                        TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        _PayReceiptPost: Codeunit "DK_Payment Receipt - Post";
    begin
        if PayReceiptDocNo = '' then Error(MSG004);
        if CurrContractNo = '' then Error(MSG001);
        if NewContractNo = '' then Error(MSG002);
        if CurrContractNo = NewContractNo then Error(MSG003, CurrContractNo);

        if not Confirm(MSG005, false, CurrContractNo, NewContractNo) then
            exit;

        _PayReceiptPost.ChangeContractNo(PayReceiptDocNo, NewContractNo);
    end;

    var
        NewContractNo: Code[20];
        CurrContractNo: Code[20];
        MSG001: Label 'The Current Contract No. does not exist. Please check.';
        MSG002: Label 'No New Contract No. has been specified.';
        MSG003: Label 'The new contract No. is the same as the current contract No. A new contract No. must be assigned a different contract No. Current Contract No.:%1';
        PayReceiptDocNo: Code[20];
        MSG004: Label 'The Payment Receipt Document No. does not exist. Please check.';
        MSG005: Label 'Would you like to change your current Contract No. to a New Contract No.? %1 -> %2';


    procedure SetParameter(pContractNo: Code[20])
    begin

        CurrContractNo := pContractNo;
    end;
}

