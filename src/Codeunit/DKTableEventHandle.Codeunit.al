codeunit 50038 "DK_Table Event Handle"
{
    // °•Ô …ÑœŠ× Œ÷‘ñ
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2020 - 2020-07-14
    //   - Add Function: T50061_OnAfterValidateEvent_OpeningTime
    //   - Add Text Constants: MSG006
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2024 - 2020-07-15
    //   - Add Function: T50032_OnAfterValidateEvent_SSN
    //   - Add Text Constants: MSG007, MSG008


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'You cannot rename a %1.';
        MSG002: Label 'Past cemetery unit price information cannot register new. %1:%2';
        MSG003: Label 'Past cemetery unit price information cannot be modified. %1:%2';
        MSG004: Label 'Past cemetery unit price information cannot be deleted. %1:%2';
        MSG005: Label 'Unable to delete because there is a linked deposit document. %1 : %2';
        MSG006: Label 'This contract has outstanding balance. %1: %2';
        MSG007: Label '%1 is not valid. Please enter in 13 digits. Ex) 123456-1234567, current number of digits:%2';
        MSG008: Label 'Birthday is not valid on the date. Value : %1';

    [EventSubscriber(ObjectType::Table, 50028, 'OnBeforeInsertEvent', '', false, false)]
    local procedure T50028_OnBeforeInsertEvent(var Rec: Record "DK_Cemetery Unit Price"; RunTrigger: Boolean)
    begin
        if not RunTrigger then exit;

        Rec.TestField("Estate Name");
        Rec.TestField("Cemetery Conf. Name");
        Rec.TestField("Cemetery Option Name");

        Rec.TestField("Estate Code");
        Rec.TestField("Cemetery Conf. Code");
        Rec.TestField("Cemetery Option Code");

        Rec.TestField("Starting Date");

        if Rec."Starting Date" <= Today then
            Error(MSG002, Rec.FieldCaption("Starting Date"), Rec."Starting Date", Today);
    end;

    [EventSubscriber(ObjectType::Table, 50028, 'OnBeforeModifyEvent', '', false, false)]
    local procedure T50028_OnModifyRecordEvent(var Rec: Record "DK_Cemetery Unit Price"; var xRec: Record "DK_Cemetery Unit Price"; RunTrigger: Boolean)
    begin
        if not RunTrigger then exit;

        if Rec."Starting Date" <= Today then
            Error(MSG003, Rec.FieldCaption("Starting Date"), Rec."Starting Date", Today);
    end;

    [EventSubscriber(ObjectType::Table, 50028, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T50028_OnBeforeDeleteEvent(var Rec: Record "DK_Cemetery Unit Price"; RunTrigger: Boolean)
    begin
        if not RunTrigger then exit;

        if Rec."Starting Date" <= Today then
            Error(MSG004, Rec.FieldCaption("Starting Date"), Rec."Starting Date", Today);
    end;

    [EventSubscriber(ObjectType::Table, 50028, 'OnBeforeRenameEvent', '', false, false)]
    local procedure T50028_OnBeforeRenameEvent(var Rec: Record "DK_Cemetery Unit Price"; var xRec: Record "DK_Cemetery Unit Price"; RunTrigger: Boolean)
    begin
        if not RunTrigger then exit;

        Error(MSG001, Rec.TableCaption);
    end;

    [EventSubscriber(ObjectType::Table, 50085, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T50085_OnBeforeDeleteEvent(var Rec: Record "DK_Cemetery Services"; RunTrigger: Boolean)
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    begin

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.CalcFields("Line Cem. Services No.");
        _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
        _PaymentReceiptDocument.SetRange("Line Cem. Services No.", Rec."No.");
        if _PaymentReceiptDocument.FindSet then begin
            Error(MSG005, _PaymentReceiptDocument.FieldCaption("Document No."), _PaymentReceiptDocument."Document No.");
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50061, 'OnAfterValidateEvent', 'Opening Time', false, false)]
    local procedure T50061_OnAfterValidateEvent_OpeningTime(var Rec: Record "DK_Today Funeral"; var xRec: Record "DK_Today Funeral"; CurrFieldNo: Integer)
    var
        _DK_Contract: Record DK_Contract;
    begin

        if Rec."Opening Time" <> xRec."Opening Time" then begin
            _DK_Contract.Reset;
            _DK_Contract.SetRange("No.", Rec."Contract No.");
            _DK_Contract.SetFilter("Pay. Remaining Amount", '<>%1', 0);
            if _DK_Contract.FindSet then
                Message(MSG006, _DK_Contract.FieldCaption("Pay. Remaining Amount"), _DK_Contract."Pay. Remaining Amount");
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50032, 'OnAfterValidateEvent', 'Social Security No.', false, false)]
    local procedure T50032_OnAfterValidateEvent_SSN(var Rec: Record DK_Corpse; var xRec: Record DK_Corpse; CurrFieldNo: Integer)
    var
        VATRegistrationNoFormat: Record "VAT Registration No. Format";
        _CommFun: Codeunit "DK_Common Function";
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Gender: Integer;
    begin
        with Rec do begin
            if ("Social Security No." <> '') then begin
                "Social Security No." := UpperCase("Social Security No.");

                //IF Type = Type::Individual THEN BEGIN
                //IF "Social Security No." <> xRec."Social Security No." THEN
                VATRegistrationNoFormat.Test("Social Security No.", 'KOR', "Contract No.", DATABASE::DK_Corpse);

                if StrLen("Social Security No.") <> 14 then
                    Error(MSG007, FieldCaption("Social Security No."), StrLen("Social Security No."));


                if _CommFun.CheckDigitSSNo("Social Security No.") then begin

                    Evaluate(_Year, CopyStr("Social Security No.", 1, 2));
                    Evaluate(_Month, CopyStr("Social Security No.", 3, 2));
                    Evaluate(_Day, CopyStr("Social Security No.", 5, 2));

                    Evaluate(_Gender, CopyStr("Social Security No.", 8, 1));
                    case _Gender of
                        1, 2, 5, 6:
                            _Year += 1900;
                        3, 4, 7, 8:
                            _Year += 2000;
                        9, 0:
                            _Year += 1800;
                    end;

                    if ((_Year >= 1800) and (_Year <= 3000)) or
                       ((_Month >= 1) and (_Year <= 12)) or
                       ((_Day >= 1) and (_Day <= Date2DMY(CalcDate('<+CM>', (DMY2Date(1, _Month, _Year))), 1))) then begin


                        "Date Of Birth" := DMY2Date(_Day, _Month, _Year);

                        case _Gender of
                            1, 3, 5, 7, 9:
                                Gender := Gender::Male;
                            2, 4, 6, 8, 0:
                                Gender := Gender::Female;
                        end;
                    end else
                        Error(MSG007, CopyStr("Social Security No.", 1, 6));
                end else
                    Error(MSG008, FieldCaption("Social Security No."));
            end;
        end;
    end;
}

