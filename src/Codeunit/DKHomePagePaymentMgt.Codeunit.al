codeunit 50046 "DK_HomePage Payment Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        TextCreateReceiptDocument: Label 'Do you want Create Receipt Document?';
        TextCancel: Label 'Do you want Cancel ?';

    [EventSubscriber(ObjectType::Table, 50080, 'OnAfterDeleteEvent', '', false, false)]
    local procedure PaymentReceiptDocument_OnAfterDeleteEvent(var Rec: Record "DK_Payment Receipt Document"; RunTrigger: Boolean)
    var
        _DK_HomePagePaymentEntry: Record "DK_HomePage Payment Entry";
    begin
        //¯€¦ ‰«Œ¡ ‹Ð‘ª“ ¼ß…˜ ˜¿–Íœ‘÷ ß‘ª ˆ±‡Ÿ ‹Ý•’ Žð…Ñœ–«
        if not RunTrigger then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Receipt then
            exit;

        if Rec."Payment Type" in [Rec."Payment Type"::OnlineCard, Rec."Payment Type"::Bank] then begin
            _DK_HomePagePaymentEntry.Reset();
            _DK_HomePagePaymentEntry.SetRange("Receipt No.", Rec."Document No.");
            _DK_HomePagePaymentEntry.SetRange(Status, _DK_HomePagePaymentEntry.Status::Completed);
            if _DK_HomePagePaymentEntry.FindSet() then begin
                _DK_HomePagePaymentEntry."Receipt No." := '';
                _DK_HomePagePaymentEntry."Old Receipt No." := Rec."Document No.";
                _DK_HomePagePaymentEntry.Status := _DK_HomePagePaymentEntry.Status::Canceled;
                _DK_HomePagePaymentEntry.Modify();
            end;
        end;
    end;


    procedure CreateNewDocument(var pDK_HomePagePaymentEntry: Record "DK_HomePage Payment Entry")
    begin
        //¯€¦ ‰«Œ¡ ‹²ŒŠ
        if not Confirm(TextCreateReceiptDocument, false) then
            exit;

        with pDK_HomePagePaymentEntry do begin
            if FindSet() then
                repeat
                    //¯€¦ ‰«Œ¡ ‹²ŒŠ
                    if not CreatePaymentReceiptDocuemnt(pDK_HomePagePaymentEntry) then
                        Error('');

                    Status := Status::Completed;
                    "Last Date Modified" := CurrentDateTime;
                    "Last Modified Person" := UserId;
                    Modify();
                until Next() = 0;
        end;
    end;


    procedure CancelDocument(var pDK_HomePagePaymentEntry: Record "DK_HomePage Payment Entry")
    begin
        //“ÔŒ­
        if not Confirm(TextCancel, false) then
            exit;

        with pDK_HomePagePaymentEntry do begin
            if FindSet() then
                repeat
                    Status := Status::Canceled;
                    "Last Date Modified" := CurrentDateTime;
                    "Last Modified Person" := UserId;
                    Modify;
                until Next() = 0;
        end;
    end;

    local procedure CreatePaymentReceiptDocuemnt(var pDK_HomePagePaymentEntry: Record "DK_HomePage Payment Entry"): Boolean
    var
        _DK_PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _DK_PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _LineNo: Integer;
    begin
        _DK_PaymentReceiptDocument.Init();
        _DK_PaymentReceiptDocument."Document Type" := _DK_PaymentReceiptDocument."Document Type"::Receipt;
        _DK_PaymentReceiptDocument."Document No." := '';
        _DK_PaymentReceiptDocument.Insert(true);

        pDK_HomePagePaymentEntry."Receipt No." := _DK_PaymentReceiptDocument."Document No.";

        _DK_PaymentReceiptDocument.Validate("Payment Date", pDK_HomePagePaymentEntry."Payment Date");

        //Š—Ê
        if pDK_HomePagePaymentEntry."Payment Type" = pDK_HomePagePaymentEntry."Payment Type"::Bank then begin
            _DK_PaymentReceiptDocument.Validate("Payment Type", _DK_PaymentReceiptDocument."Payment Type"::Bank);
            _DK_PaymentReceiptDocument.Validate("Bank Account Code", pDK_HomePagePaymentEntry."Receipt Bank Account");
        end;

        //’†Ýž”½…Î
        if pDK_HomePagePaymentEntry."Payment Type" = pDK_HomePagePaymentEntry."Payment Type"::OnlineCard then begin
            _DK_PaymentReceiptDocument.Validate("Payment Type", _DK_PaymentReceiptDocument."Payment Type"::OnlineCard);
            _DK_PaymentReceiptDocument.Validate("Card Approval No.", pDK_HomePagePaymentEntry."Card Approval No.");
            _DK_PaymentReceiptDocument.Validate("Payment Method Code", pDK_HomePagePaymentEntry."Payment Method Code");
        end;

        _DK_PaymentReceiptDocument.Validate("Contract No.", pDK_HomePagePaymentEntry."Contract No.");
        _DK_PaymentReceiptDocument.Validate("Cemetery Code", pDK_HomePagePaymentEntry."Cemetery Code");
        _DK_PaymentReceiptDocument.Validate("Cemetery No.", pDK_HomePagePaymentEntry."Cemetery No.");
        _DK_PaymentReceiptDocument.Validate(Amount, pDK_HomePagePaymentEntry."General Amount" + pDK_HomePagePaymentEntry."Landscape Amount");
        _DK_PaymentReceiptDocument.Modify();

        _LineNo := 0;

        //Ÿ‰¦ ýˆ«Š±
        if pDK_HomePagePaymentEntry."General Amount" > 0 then begin
            _LineNo := 10000;
            _DK_PaymentReceiptDocLine.Init();
            _DK_PaymentReceiptDocLine."Document No." := _DK_PaymentReceiptDocument."Document No.";
            _DK_PaymentReceiptDocLine."Line No." := _LineNo;
            _DK_PaymentReceiptDocLine.Insert();
            _DK_PaymentReceiptDocLine.Validate("Payment Target", _DK_PaymentReceiptDocLine."Payment Target"::General);
            _DK_PaymentReceiptDocLine.Validate(Amount, pDK_HomePagePaymentEntry."General Amount");
            _DK_PaymentReceiptDocLine.contractNo := pDK_HomePagePaymentEntry."Contract No.";
            _DK_PaymentReceiptDocLine.PaymentDate := pDK_HomePagePaymentEntry."Payment Date";
            _DK_PaymentReceiptDocLine.Modify();
        end;

        //‘†µ ýˆ«Š±
        if pDK_HomePagePaymentEntry."Landscape Amount" > 0 then begin
            _LineNo += 10000;
            _DK_PaymentReceiptDocLine.Init();
            _DK_PaymentReceiptDocLine."Document No." := _DK_PaymentReceiptDocument."Document No.";
            _DK_PaymentReceiptDocLine."Line No." := _LineNo;
            _DK_PaymentReceiptDocLine.Insert();
            _DK_PaymentReceiptDocLine.Validate("Payment Target", _DK_PaymentReceiptDocLine."Payment Target"::Landscape);
            _DK_PaymentReceiptDocLine.Validate(Amount, pDK_HomePagePaymentEntry."Landscape Amount");
            _DK_PaymentReceiptDocLine.contractNo := pDK_HomePagePaymentEntry."Contract No.";
            _DK_PaymentReceiptDocLine.PaymentDate := pDK_HomePagePaymentEntry."Payment Date";
            _DK_PaymentReceiptDocLine.Modify();
        end;


        exit(true);
    end;
}

