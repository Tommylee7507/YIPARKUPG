codeunit 50036 "DK_Batch Daily Closing"
{

    trigger OnRun()
    begin

        UpdateClosingDate;
    end;

    local procedure UpdateClosingDate()
    var
        GenSetup: Record "General Ledger Setup";
    begin
        //ˆ†¿ŸÀ À… Š»µ!!
        GenSetup.Get;

        if GenSetup."Allow Posting From" <> Today then begin
            GenSetup."Allow Posting From" := Today;
            GenSetup."Allow Posting To" := Today + 1;
            GenSetup.Modify;
        end;
    end;
}

