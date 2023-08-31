codeunit 50018 "DK_Alarm Mgt."
{
    // //Ž›†ð ýˆ«


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'It can not be modified in %1 Status.';
        MSG002: Label 'There is no %1 entered.';
        MSG003: Label 'Data is generated from the %1.\Would you like to continue?';
        MSG004: Label 'The data created in the %1 is canceled.\Would you like to continue?';
        MSG005: Label 'There is no content setting to send. Check %1.';


    procedure InsertAlarm_Purch(pPurchContract: Record "DK_Purchase Contract")
    var
        _Alarm: Record DK_Alarm;
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
        _AlarmReceiver: Record "DK_Alarm Receiver";
        _SMS: Record DK_SMS;
        _SMSSending: Codeunit "DK_Batch SMS Sending";
    begin
        //Ž›†ð Tableí €ˆˆ• ÐŽÊŒ¡ Ž›†ð ‹²ŒŠ
        _AlarmReceiver.Reset;
        _AlarmReceiver.SetRange("Document No.", pPurchContract."No.");
        if _AlarmReceiver.FindSet then begin
            repeat
                _Alarm.LockTable;
                _Alarm.Init;
                _Alarm."Entry No." := 0;
                _Alarm."Source Type" := _Alarm."Source Type"::PurchaseContract;
                _Alarm."Source No." := pPurchContract."No.";
                _Alarm."Source Line No." := _AlarmReceiver."Line No.";
                _Alarm.Type := _Alarm.Type::Alarm;

                _PurchaseContractLine.Reset;
                _PurchaseContractLine.SetRange("Purchase Contract No.", pPurchContract."No.");
                if _PurchaseContractLine.FindLast then
                    _Alarm."Alarm Date" := _PurchaseContractLine."Contract Date To";

                _Alarm."Recipient Type" := _AlarmReceiver.Type;
                _Alarm.Validate("Recipient Code", _AlarmReceiver.Code);
                _Alarm.Division := _Alarm.Division::Date;
                _SMS.Reset;
                _SMS.SetRange(Type, _SMS.Type::PurchContract);
                if _SMS.FindFirst then begin
                    _Alarm.Contents := _SMSSending.SetMessageType(_SMS.Type::PurchContract, _SMS."Short Message", pPurchContract."No.");
                end;
                _Alarm.Subject := pPurchContract.TableCaption;  //SMS ‘ªˆ± Field
                _Alarm.Insert(true);
            until _AlarmReceiver.Next = 0;
        end;
    end;


    procedure InsertExtension(pPurchContract: Record "DK_Purchase Contract")
    var
        _Alarm: Record DK_Alarm;
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
    begin
        //Ž›†ð Tableí À…¼Î ‹²ŒŠ
        _PurchaseContractLine.Reset;
        _PurchaseContractLine.SetRange("Purchase Contract No.", pPurchContract."No.");
        if _PurchaseContractLine.FindLast then begin
            _Alarm.LockTable;
            _Alarm.Init;
            _Alarm."Entry No." := 0;
            _Alarm."Source Type" := _Alarm."Source Type"::PurchaseContract;
            _Alarm."Source No." := pPurchContract."No.";
            _Alarm."Source Line No." := 0;
            _Alarm.Type := _Alarm.Type::Extension;
            _Alarm."Alarm Date" := _PurchaseContractLine."Contract Date To";
            _Alarm.Division := _Alarm.Division::Date;
            _Alarm.Insert(true);
        end;
    end;


    procedure InsertPurchContactLine(pAlarm: Record DK_Alarm)
    var
        _PurchContractLine: Record "DK_Purchase Contract Line";
        _INITPurchContractLine: Record "DK_Purchase Contract Line";
    begin
        //€ˆˆ• ÐŽÊŒ¡ À…¼Î
        _PurchContractLine.Reset;
        _PurchContractLine.SetRange("Purchase Contract No.", pAlarm."Source No.");
        if _PurchContractLine.FindLast then begin
            _INITPurchContractLine.Init;
            _INITPurchContractLine."Purchase Contract No." := pAlarm."Source No.";
            _INITPurchContractLine."Line No." := _PurchContractLine."Line No." + 10000;
            _INITPurchContractLine."Contract Amount" := _PurchContractLine."Contract Amount";

            _PurchContractLine.CalcFields(Contents);
            _INITPurchContractLine.Contents := _PurchContractLine.Contents;
            _INITPurchContractLine."Contract Date From" := _PurchContractLine."Contract Date From" + 1;
            _INITPurchContractLine."Contract Date To" := CalcDate('<+1Y-1D>', _INITPurchContractLine."Contract Date From");
            _INITPurchContractLine.Remarks := _PurchContractLine.Remarks;
            _INITPurchContractLine.Insert(true);
        end;
    end;


    procedure InsertAlarm_Vehicle(pVehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header")
    var
        _Alarm: Record DK_Alarm;
        _SMS: Record DK_SMS;
        _SMSSending: Codeunit "DK_Batch SMS Sending";
    begin
        //Ž›†ð Tableí ’ð‡« Ž›†ð ‹²ŒŠ
        _Alarm.LockTable;
        _Alarm.Init;
        _Alarm."Entry No." := 0;
        _Alarm."Source Type" := _Alarm."Source Type"::Vehicle;
        _Alarm."Source No." := pVehicleLedEntryHeader."No.";
        _Alarm."Source Line No." := 0;
        _Alarm.Validate("Vehicle Document No.", pVehicleLedEntryHeader."Vehicle Document No.");
        _Alarm.Subject := pVehicleLedEntryHeader.TableCaption;
        _Alarm.Division := pVehicleLedEntryHeader."Alarm Division";
        _Alarm.Type := _Alarm.Type::Alarm;
        if pVehicleLedEntryHeader."Alarm Division" = pVehicleLedEntryHeader."Alarm Division"::Date then
            _Alarm."Alarm Date" := pVehicleLedEntryHeader."Alarm Date"
        else
            _Alarm."Alarm Km" := pVehicleLedEntryHeader."Alarm Km";

        _SMS.Reset;
        _SMS.SetRange(Type, _SMS.Type::Vehicle);
        if _SMS.FindFirst then begin
            _Alarm.Contents := _SMSSending.SetMessageType(_SMS.Type::Vehicle, _SMS."Short Message", pVehicleLedEntryHeader."No.");
        end;
        _Alarm."Recipient Type" := pVehicleLedEntryHeader."Recipient Type";
        _Alarm.Validate("Recipient Code", pVehicleLedEntryHeader."Recipient Code");
        _Alarm.Insert(true);
    end;

    local procedure ">>"()
    begin
    end;

    local procedure Check_Purch_Validate(pPurchContract: Record "DK_Purchase Contract")
    var
        _PurchaseContractLine: Record "DK_Purchase Contract Line";
        _AlarmReceiver: Record "DK_Alarm Receiver";
    begin
        //€ˆˆ• ÐŽÊŒ¡ Table Validate
        with pPurchContract do begin
            if Status <> Status::Contract then begin
                Error(MSG001, Status);
            end;

            TestField(Title);
            TestField("Contract Date");
            TestField("Vendor No.");

            _PurchaseContractLine.Reset;
            _PurchaseContractLine.SetRange("Purchase Contract No.", "No.");
            if not _PurchaseContractLine.FindSet then
                Error(MSG002, _PurchaseContractLine.TableCaption);
        end;
    end;

    local procedure Check_Purch_AlarmLine(pPurchContract: Record "DK_Purchase Contract")
    var
        _AlarmReceiver: Record "DK_Alarm Receiver";
    begin
        //€ˆˆ• ÐŽÊŒ¡ Tableí Ž›†ð †Ýž Validate
        with pPurchContract do begin
            _AlarmReceiver.Reset;
            _AlarmReceiver.SetRange("Document No.", "No.");
            if not _AlarmReceiver.FindSet then
                Error(MSG002, _AlarmReceiver.TableCaption);
        end;
    end;


    procedure InsertCancelAlarm_Purch(pPurchContract: Record "DK_Purchase Contract")
    var
        _Alarm: Record DK_Alarm;
        _SMS: Record DK_SMS;
    begin
        //Ž›†ð Tableí €ˆˆ• ÐŽÊŒ¡ Ž›†ð ‹²ŒŠ †—„’ ‹Ð‘ª
        Check_Purch_Validate(pPurchContract);
        Check_Purch_AlarmLine(pPurchContract);
        _SMS.Reset;
        _SMS.SetRange(Type, _SMS.Type::PurchContract);
        if not _SMS.FindFirst then
            Error(MSG005, _SMS.TableCaption);

        with pPurchContract do begin
            if Notice = true then begin
                if not Confirm(MSG003, false, _Alarm.TableCaption) then
                    Error('')
                else
                    InsertAlarm_Purch(pPurchContract);
            end else begin
                if not Confirm(MSG004, false, _Alarm.TableCaption) then
                    Error('')
                else
                    CancelAlarm_Purch(pPurchContract);
            end;
        end;
    end;


    procedure CancelAlarm_Purch(pPurchContract: Record "DK_Purchase Contract")
    var
        _Alarm: Record DK_Alarm;
    begin
        //Ž›†ð •¸œŠ× ‰ÈŒÁ Ž˜…˜ ˆ±‡Ÿ ‹Ð‘ª
        with pPurchContract do begin
            _Alarm.Reset;
            _Alarm.SetRange("Source Type", _Alarm."Source Type"::PurchaseContract);
            _Alarm.SetRange("Source No.", "No.");
            _Alarm.SetRange(Type, _Alarm.Type::Alarm);
            _Alarm.CalcFields("Sending Date");
            _Alarm.SetRange("Sending Date", 0D);
            if _Alarm.FindSet then
                _Alarm.DeleteAll;
        end;
    end;


    procedure InsertCancelExtension_Purch(pPurchContract: Record "DK_Purchase Contract")
    var
        _Alarm: Record DK_Alarm;
    begin
        //Ž›†ð •¸œŠ×í À…¼Î ‹²ŒŠ †—„’ ‹Ð‘ª
        Check_Purch_Validate(pPurchContract);

        with pPurchContract do begin
            if "Automatic Extension" = true then begin
                if not Confirm(MSG003, false, _Alarm.TableCaption) then begin
                    Error('')
                end else begin
                    InsertExtension(pPurchContract);
                end;
            end else begin
                if not Confirm(MSG004, false, _Alarm.TableCaption) then begin
                    Error('')
                end else begin
                    CancelExtension_Purch(pPurchContract);
                end;
            end;
        end;
    end;


    procedure CancelExtension_Purch(pPurchContract: Record "DK_Purchase Contract")
    var
        _Alarm: Record DK_Alarm;
    begin
        //Ž›†ð •¸œŠ× À…¼Î Ž˜…˜ ˆ±‡Ÿ ‹Ð‘ª
        with pPurchContract do begin
            _Alarm.Reset;
            _Alarm.SetRange("Source Type", _Alarm."Source Type"::PurchaseContract);
            _Alarm.SetRange("Source No.", "No.");
            _Alarm.SetRange("Source Line No.", 0);
            _Alarm.SetRange(Type, _Alarm.Type::Extension);

            _Alarm.CalcFields("Sending Date");
            _Alarm.SetRange("Sending Date", 0D);
            if _Alarm.FindSet then
                _Alarm.DeleteAll;
        end;
    end;
}

