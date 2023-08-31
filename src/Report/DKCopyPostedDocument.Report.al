report 50000 "DK_Copy Posted Document"
{
    Caption = 'Copy Posted Document';
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
                field(DocumentNo; DocumentNo)
                {
                    Caption = 'Document No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _PayReceiptDoc: Record "DK_Payment Receipt Document";
                        _PostPayReceiptDocList: Page "DK_Post Pay. Receipt Doc. List";
                    begin

                        _PayReceiptDoc.Reset;
                        _PayReceiptDoc.FilterGroup(2);
                        _PayReceiptDoc.SetRange("Contract No.", '');
                        _PayReceiptDoc.SetRange("Missing Contract", true);
                        _PayReceiptDoc.SetRange("Before Document No.", '');
                        _PayReceiptDoc.SetRange("After Document No.", '');
                        _PayReceiptDoc.FilterGroup(0);

                        Clear(_PostPayReceiptDocList);
                        _PostPayReceiptDocList.LookupMode(true);
                        _PostPayReceiptDocList.SetTableView(_PayReceiptDoc);
                        _PostPayReceiptDocList.SetRecord(_PayReceiptDoc);
                        if _PostPayReceiptDocList.RunModal = ACTION::LookupOK then begin

                            _PostPayReceiptDocList.GetRecord(_PayReceiptDoc);
                            DocumentNo := _PayReceiptDoc."Document No.";

                            PaymentDate := _PayReceiptDoc."Payment Date";
                            PaymentAmount := _PayReceiptDoc.Amount;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if DocumentNo = '' then begin
                            PaymentDate := 0D;
                            PaymentAmount := 0;
                        end;
                    end;
                }
                field(PaymentDate; PaymentDate)
                {
                    Caption = 'Payment Date';
                    Editable = false;
                }
                field(PaymentAmount; PaymentAmount)
                {
                    Caption = 'Payment Amount';
                    Editable = false;
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
        FromPayReceiptDoc: Record "DK_Payment Receipt Document";
        ToPayReceiptDoc: Record "DK_Payment Receipt Document";
    begin

        if NewDocumentNo = '' then exit;

        FromPayReceiptDoc.Reset;
        FromPayReceiptDoc.SetRange("Document No.", DocumentNo);
        FromPayReceiptDoc.SetRange("Missing Contract", true);
        FromPayReceiptDoc.SetRange("Contract No.", '');
        FromPayReceiptDoc.SetFilter("Before Document No.", '');
        FromPayReceiptDoc.SetFilter("After Document No.", '');
        if FromPayReceiptDoc.FindFirst then begin

            ToPayReceiptDoc.Reset;
            ToPayReceiptDoc.SetRange("Document No.", NewDocumentNo);
            if ToPayReceiptDoc.FindFirst then begin

                ToPayReceiptDoc."Posting Date" := WorkDate;
                ToPayReceiptDoc."Document Time" := Time;
                ToPayReceiptDoc."Payment Date" := FromPayReceiptDoc."Payment Date";
                ToPayReceiptDoc."Payment Type" := FromPayReceiptDoc."Payment Type";
                ToPayReceiptDoc.Validate(Amount, FromPayReceiptDoc.Amount);
                ToPayReceiptDoc."Issued Cash Receipts" := FromPayReceiptDoc."Issued Cash Receipts";
                //// ToPayReceiptDoc."Issued Cash  Date" := FromPayReceiptDoc."Issued Cash  Date";
                ToPayReceiptDoc."Payment Method Code" := FromPayReceiptDoc."Payment Method Code";
                ToPayReceiptDoc."Payment Method Name" := FromPayReceiptDoc."Payment Method Name";
                ToPayReceiptDoc."Bank Account Code" := FromPayReceiptDoc."Bank Account Code";
                ToPayReceiptDoc."Bank Account Name" := FromPayReceiptDoc."Bank Account Name";
                ToPayReceiptDoc."Bank Account No." := FromPayReceiptDoc."Bank Account No.";
                ToPayReceiptDoc."Virtual Account No." := FromPayReceiptDoc."Virtual Account No.";
                ToPayReceiptDoc."Pay. Expect Doc. No." := FromPayReceiptDoc."Pay. Expect Doc. No.";
                ToPayReceiptDoc.Description := FromPayReceiptDoc.Description;
                ToPayReceiptDoc."Missing Contract" := false;
                ToPayReceiptDoc."Before Document No." := FromPayReceiptDoc."Document No.";
                ToPayReceiptDoc.Validate("Contract No.", '');
                ToPayReceiptDoc.Modify(true);
            end;

            //UPDATE
            FromPayReceiptDoc."After Document No." := NewDocumentNo;
            FromPayReceiptDoc.Modify;
        end else begin
            Error(MSG001);
        end;
    end;

    var
        DocumentNo: Code[20];
        PaymentDate: Date;
        PaymentAmount: Decimal;
        NewDocumentNo: Code[20];
        MSG001: Label 'Failed to copy Posted Documents';


    procedure SetDocumentNo(pDocumentNo: Code[20])
    begin

        NewDocumentNo := pDocumentNo;
    end;
}

