codeunit 50025 "DK_ValidatePostingDate Mgt."
{
    trigger OnRun()
    var
        _CurrTime: Time;
        _PostingDate: Date;
    begin

        _PostingDate := 20190714D;
        _CurrTime := 170000T;

        ValidatePostingDate(_PostingDate);
    end;

    var
        currDate: Date;
        rstDate: Date;
        MSG001: Label 'Allow Posting Time :% 1, Current Time:% 2';
        MSG002: Label 'Allow Posting Time :% 1, Current Time:% 2';
        MSG003: Label 'is not within your range of allowed posting dates.\\Posting Date : %1';


    procedure ValidatePostingDate(pPostingDate: Date)
    var
        _SetupRecID: RecordID;
        _GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
    begin

        //_GenJnlCheckLine.IsDateNotAllowed(pPostingDate, _SetupRecID);

        if _GenJnlCheckLine.DateNotAllowed(pPostingDate) then
            Error(MSG003, pPostingDate);
    end;

    [EventSubscriber(ObjectType::Codeunit, 11, 'OnAfterDateNoAllowed', '', false, false)]

    procedure ValidateTodayTime1(PostingDate: Date; var DateIsNotAllowed: Boolean)
    var
        _GenSetup: Record "General Ledger Setup";
    begin

        _GenSetup.Get;

        if _GenSetup."DK_Allow Posting Time" <> 0T then begin

            if PostingDate < Today then begin
                if Time > _GenSetup."DK_Allow Posting Time" then
                    Error(MSG002, Today + 1)
                else
                    Error(MSG002, Today);

            end else
                if PostingDate = Today then begin
                    if Time > _GenSetup."DK_Allow Posting Time" then
                        Error(MSG001, _GenSetup."DK_Allow Posting Time", Time);
                end

        end;
    end;
}

