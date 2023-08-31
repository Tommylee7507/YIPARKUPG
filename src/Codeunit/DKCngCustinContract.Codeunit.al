codeunit 50029 "DK_Cng. Cust. in Contract"
{
    // //CRM ¼…


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The changed information will be reflected in the %1. Would you like to continue?';
        MSG002: Label 'The release is complete.';
        MSG003: Label 'ÐŽÊ— “ú‘÷ ˆ°—È„Ÿ„¾. %1 : %2';


    procedure Check_Values(pCngCustinContract: Record "DK_Cng. Cust. in Contract")
    begin

        pCngCustinContract.TestField("Document Date");
        pCngCustinContract.TestField("Contract No.");
        pCngCustinContract.TestField("Cng. Main Customer No.");
    end;


    procedure SetRelease(var pCngCustinContract: Record "DK_Cng. Cust. in Contract")
    var
        _Contract: Record DK_Contract;
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin

        Check_Values(pCngCustinContract);

        //IF NOT CONFIRM(MSG001,FALSE,_Contract.TABLECAPTION) THEN EXIT;

        _Contract.Reset;
        _Contract.SetRange("No.", pCngCustinContract."Contract No.");
        if _Contract.FindSet then begin
            _Contract.Validate("Main Customer No.", pCngCustinContract."Cng. Main Customer No.");
            _Contract.Validate("Customer No. 2", pCngCustinContract."Cng. Customer No. 2");
            _Contract.Validate("Customer No. 3", pCngCustinContract."Cng. Customer No. 3");
            _Contract.Modify;

            //CRM
            Clear(_CRMDataInterlink);
            _CRMDataInterlink.OutboundContract(_Contract);
            //CRM

            pCngCustinContract.Status := pCngCustinContract.Status::Released;

            //MESSAGE(MSG002);
        end else
            Message(MSG003, pCngCustinContract.FieldCaption("Contract No."), pCngCustinContract."Contract No.");
    end;
}

