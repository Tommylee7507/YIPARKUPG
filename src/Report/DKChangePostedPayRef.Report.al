report 50048 "DK_Change Posted Pay. Ref"
{
    // 
    // DK34: 20201111
    //   - Create

    Caption = 'Change Posted Payment Refund Document';
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
                    field(Curr_PayRequstDate; Curr_PayRequstDate)
                    {
                        Caption = 'Current Payment Request Date';
                    }
                    field(Curr_PayCompleDate; Curr_PayCompleDate)
                    {
                        Caption = 'Current Payment Complete Date';
                    }
                }
                group(Change)
                {
                    Caption = 'Change';
                    field(Ch_PayRequestDate; Ch_PayRequestDate)
                    {
                        Caption = 'Change Payment Request Date';

                        trigger OnValidate()
                        begin

                            if Curr_PayRequstDate = 0D then
                                if Ch_PayRequestDate <> 0D then
                                    Error(MSG002)
                                else
                                    if Ch_PayRequestDate = 0D then
                                        Error(MSG001);
                        end;
                    }
                    field(Ch_PayCompleDate; Ch_PayCompleDate)
                    {
                        Caption = 'Change Payment Comple Date';

                        trigger OnValidate()
                        begin

                            if Curr_PayCompleDate = 0D then
                                if Ch_PayCompleDate <> 0D then
                                    Error(MSG002)
                                else
                                    if Ch_PayCompleDate = 0D then
                                        Error(MSG001);
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

        if Curr_PayCompleDate <> Ch_PayCompleDate then begin
            _RequestRemittanceLedger.Reset;
            _RequestRemittanceLedger.SetRange("Source Type", _RequestRemittanceLedger."Source Type"::RefundAdminExp);
            _RequestRemittanceLedger.SetRange("Source No.", DK_PaymentReceiptDocument."Document No.");
            if _RequestRemittanceLedger.FindSet then begin
                _RequestRemittanceLedger."Complate Date" := Ch_PayCompleDate;
                _RequestRemittanceLedger.Modify(true);
            end;
        end;

        DK_PaymentReceiptDocument."Payment Request Date" := Ch_PayRequestDate;
        DK_PaymentReceiptDocument."Payment Completion Date" := Ch_PayCompleDate;
        DK_PaymentReceiptDocument.Modify(true);
    end;

    trigger OnPreReport()
    begin

        if (Curr_PayRequstDate = Ch_PayRequestDate) and (Curr_PayCompleDate = Ch_PayCompleDate) then
            Error(MSG003);

        if not Confirm(MSG004) then
            Error('');
    end;

    var
        DK_PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        Curr_PayRequstDate: Date;
        Curr_PayCompleDate: Date;
        Ch_PayRequestDate: Date;
        Ch_PayCompleDate: Date;
        MSG001: Label 'Payment complete date cannot be empty.';
        MSG002: Label 'The current value is empty, so it cannot be modified.';
        MSG003: Label 'No value has been changed.';
        MSG004: Label 'This is an inherited document. Do you want to continue with the modification?';


    procedure SetPayRefundDoc(pPayRecDoc: Record "DK_Payment Receipt Document")
    begin

        DK_PaymentReceiptDocument := pPayRecDoc;
    end;

    local procedure SetData()
    begin

        Curr_PayRequstDate := DK_PaymentReceiptDocument."Payment Request Date";
        Curr_PayCompleDate := DK_PaymentReceiptDocument."Payment Completion Date";

        Ch_PayRequestDate := DK_PaymentReceiptDocument."Payment Request Date";
        Ch_PayCompleDate := DK_PaymentReceiptDocument."Payment Completion Date";
    end;
}

