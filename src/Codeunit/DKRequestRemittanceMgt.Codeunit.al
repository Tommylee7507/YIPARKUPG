codeunit 50017 "DK_Request Remittance Mgt."
{
    // //ŒÁ€¦ ýˆ«
    // // // #4574


    trigger OnRun()
    begin
    end;


    procedure UpdateOriginalDoc(pReqRemLed: Record "DK_Request Remittance Ledger")
    var
        _ReqExpHeader: Record "DK_Request Expenses Header";
        _RevocationContract: Record "DK_Revocation Contract";
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
        _PaymentReceiptPost: Codeunit "DK_Payment Receipt - Post";
        _Contract: Record DK_Contract;
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin

        case pReqRemLed."Source Type" of
            pReqRemLed."Source Type"::Expenses:
                begin
                    _ReqExpHeader.Reset;
                    _ReqExpHeader.SetRange("No.", pReqRemLed."Source No.");
                    if _ReqExpHeader.FindSet then begin

                        case pReqRemLed.Status of
                            pReqRemLed.Status::Open:
                                begin
                                    _ReqExpHeader.Validate("Payment Completion Date", 0D);
                                    _ReqExpHeader.Validate(Status, _ReqExpHeader.Status::Released);
                                end;
                            pReqRemLed.Status::Canceled:
                                begin
                                    _ReqExpHeader.Validate("Payment Completion Date", 0D);
                                    _ReqExpHeader.Validate(Status, _ReqExpHeader.Status::Canceled);
                                end;
                            pReqRemLed.Status::Completed:
                                begin
                                    _ReqExpHeader.Validate("Payment Completion Date", pReqRemLed."Complate Date");
                                    _ReqExpHeader.Validate(Status, _ReqExpHeader.Status::Completed);
                                end;
                        end;
                        _ReqExpHeader.Modify;

                    end;
                end;
            pReqRemLed."Source Type"::Revocation:
                begin
                    _RevocationContract.Reset;
                    _RevocationContract.SetRange("Document No.", pReqRemLed."Source No.");
                    if _RevocationContract.FindSet then begin

                        case pReqRemLed.Status of
                            pReqRemLed.Status::Open:
                                begin
                                    _RevocationContract.Validate("Payment Completion Date", 0D);
                                    _RevocationContract.Validate(Status, _RevocationContract.Status::Released);
                                end;
                            pReqRemLed.Status::Canceled:
                                begin
                                    _RevocationContract.Validate("Payment Completion Date", 0D);
                                    _RevocationContract.Validate(Status, _RevocationContract.Status::Released);
                                end;
                            pReqRemLed.Status::Completed:
                                begin
                                    _RevocationContract.Validate("Payment Completion Date", pReqRemLed."Complate Date");
                                    _RevocationContract.Validate(Status, _RevocationContract.Status::Complate);

                                    // #4574
                                    if _Contract.Get(_RevocationContract."Contract No.") then // ÐŽÊ‘ñŠˆ— —¹ŽÊŸÀˆª Žð…Ñœ–« —³„Ÿ„¾.
                                    begin
                                        _Contract."Revocation Date" := pReqRemLed."Complate Date";
                                        _Contract."CRM SEDN ISSUE" := true;
                                        _Contract.Modify;

                                        // _CRMDataInterlink.OutboundContract(_Contract); // CRM ˆ‡ž …Ñœ• ýŒÁ
                                    end;


                                end;
                        end;
                        _RevocationContract.Modify;
                    end;
                end;
            pReqRemLed."Source Type"::RefundAdminExp:
                begin
                    _PayReceiptDoc.Reset;
                    _PayReceiptDoc.SetRange("Document No.", pReqRemLed."Source No.");
                    _PayReceiptDoc.SetRange("Document Type", _PayReceiptDoc."Document Type"::Refund);
                    if _PayReceiptDoc.FindSet then begin

                        case pReqRemLed.Status of
                            pReqRemLed.Status::Open:
                                begin
                                    _PayReceiptDoc.Validate("Payment Completion Date", 0D);
                                    _PayReceiptDoc.Validate("Refund Status", _PayReceiptDoc."Refund Status"::Request);
                                    _PayReceiptDoc.Modify;
                                end;
                            pReqRemLed.Status::Canceled:
                                begin
                                    _PayReceiptDoc.Validate("Payment Completion Date", 0D);
                                    _PayReceiptDoc.Validate("Payment Request Date", 0D);
                                    _PayReceiptDoc.Validate("Refund Status", _PayReceiptDoc."Refund Status"::Open);
                                    _PayReceiptDoc.Modify;
                                end;
                            pReqRemLed.Status::Completed:
                                begin
                                    _PaymentReceiptPost.RefundPost2(_PayReceiptDoc);
                                end;
                        end;

                    end;
                end;
        end;
    end;
}

