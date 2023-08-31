report 50044 "DK_Change Posted Rev. Contract"
{
    // 
    // #2092 - 2020-08-12
    //   - Create

    Caption = 'Change Posted Revocation Conatact';
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
                group(Current)
                {
                    Caption = 'Current';
                    Editable = false;
                    field(Curr_GiveUpType; Curr_GiveUpType)
                    {
                        Caption = 'Give Up';
                    }
                    field(Curr_PayCompletionDate; Curr_PayCompletionDate)
                    {
                        Caption = 'Payment Completion Date';
                    }
                }
                group(Change)
                {
                    Caption = 'Change';
                    field(Ch_GiveUpType; Ch_GiveUpType)
                    {
                        Caption = 'Give Up';
                    }
                    field(Ch_PayCompletionDate; Ch_PayCompletionDate)
                    {
                        Caption = 'Payment Completion Date';

                        trigger OnValidate()
                        begin

                            if Curr_PayCompletionDate = 0D then
                                if Ch_PayCompletionDate <> 0D then
                                    Error(MSG004)
                                else
                                    if Ch_PayCompletionDate = 0D then
                                        Error(MSG001);

                            if DK_RevocationContract."Revocation Date" > Ch_PayCompletionDate then
                                Error(MSG005, DK_RevocationContract.FieldCaption("Revocation Date"), DK_RevocationContract."Revocation Date");
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            SetData;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        _RequestRemittanceLedger: Record "DK_Request Remittance Ledger";
    begin

        if Curr_PayCompletionDate <> Ch_PayCompletionDate then begin
            _RequestRemittanceLedger.Reset;
            _RequestRemittanceLedger.SetRange("Source Type", _RequestRemittanceLedger."Source Type"::Revocation);
            _RequestRemittanceLedger.SetRange("Source No.", DK_RevocationContract."Document No.");
            if _RequestRemittanceLedger.FindSet then begin
                _RequestRemittanceLedger."Complate Date" := Ch_PayCompletionDate;
                _RequestRemittanceLedger.Modify(true);
            end;
        end;

        DK_RevocationContract."Giving Up" := Ch_GiveUpType;
        DK_RevocationContract."Payment Completion Date" := Ch_PayCompletionDate;
        DK_RevocationContract.Modify(true);
    end;

    trigger OnPreReport()
    begin

        if (Curr_GiveUpType = Ch_GiveUpType) and (Curr_PayCompletionDate = Ch_PayCompletionDate) then
            Error(MSG002);

        if not Confirm(MSG003) then
            Error('');
    end;

    var
        DK_RevocationContract: Record "DK_Revocation Contract";
        Curr_GiveUpType: Boolean;
        Curr_PayCompletionDate: Date;
        Ch_GiveUpType: Boolean;
        Ch_PayCompletionDate: Date;
        MSG001: Label 'Payment complete date cannot be empty.';
        MSG002: Label 'No value has been changed.';
        MSG003: Label 'This is an inherited document. Do you want to continue with the modification?';
        MSG004: Label 'The current value is empty, so it cannot be modified.';
        MSG005: Label 'The date before %1 cannot be entered : %2';


    procedure SetRevContract(pDK_RevocationContract: Record "DK_Revocation Contract")
    begin

        DK_RevocationContract := pDK_RevocationContract;
    end;

    local procedure SetData()
    begin

        Curr_GiveUpType := DK_RevocationContract."Giving Up";
        Curr_PayCompletionDate := DK_RevocationContract."Payment Completion Date";

        Ch_GiveUpType := DK_RevocationContract."Giving Up";
        Ch_PayCompletionDate := DK_RevocationContract."Payment Completion Date";
    end;
}

