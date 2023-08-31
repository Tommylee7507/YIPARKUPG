codeunit 50002 "DK_Vehicle Management"
{

    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'There is no Km Cumulative for this vehicle.';
        MSG002: Label 'It is smaller than the previous km Cumulative';
        MSG003: Label 'The vehicle is %2 Status in %1, so it can not be confirmed.';
        MSG004: Label 'There is no content setting to send. Check %1.';


    procedure VehicleCheck(pRec: Record "DK_Vehicle Led. Entry Header"): Boolean
    var
        _VehicleHeader: Record "DK_Vehicle Led. Entry Header";
        _VehicleOper: Record "DK_Vehicle Oper. Led. Entry";
        MSG001: Label 'Test';////
        _VehicleRefue: Record "DK_Vehicle Refue. Led. Entry";
        _Vehicle: Record DK_Vehicle;
    begin
        //>Vehicle Sale,Exclusion Check
        _Vehicle.Reset;
        _Vehicle.SetRange("No.", pRec."Vehicle Document No.");
        _Vehicle.SetFilter(Status, '%1|%2', _Vehicle.Status::Sale, _Vehicle.Status::Exclusion);
        if _Vehicle.FindFirst then
            Error(MSG003, _Vehicle.TableCaption, _Vehicle.Status);

        case pRec."Document Type" of
            pRec."Document Type"::Operation:
                begin
                    //pRec.TESTFIELD("Vehicle Document No.");
                    pRec.TestField("Employee No.");
                    pRec.TestField("Departure Date");
                    pRec.TestField("Departure Time");
                    pRec.TestField("Arrival Date");
                    pRec.TestField("Arrival Time");
                    pRec.TestField("Km Cumulative");

                    //>>Km Cumulative Cal
                    _VehicleOper.Reset;
                    _VehicleOper.SetCurrentKey("Entry No.");
                    _VehicleOper.SetRange("Vehicle Document No.", pRec."Vehicle Document No.");
                    if _VehicleOper.FindLast then begin
                        if _VehicleOper."Km Cumulative" > pRec."Km Cumulative" then
                            Error(MSG002)
                    end
                    //<<Km Cumulative Cal
                end;
            pRec."Document Type"::Refueling:
                begin
                    pRec.TestField("Vehicle Document No.");
                    pRec.TestField("Employee No.");
                    pRec.TestField("Oiling Date");
                    pRec.TestField("Unit Price");
                    pRec.TestField(Amount);
                    pRec.TestField(Liter);
                    _VehicleRefue.Reset;
                    _VehicleRefue.SetCurrentKey("Entry No.");
                    _VehicleRefue.SetRange("Vehicle Document No.", pRec."Vehicle Document No.");
                    if _VehicleRefue.FindLast then begin
                        if _VehicleRefue."Km Cumulative" > pRec."Km Cumulative" then
                            Error(MSG002);
                    end
                end;
            pRec."Document Type"::Repair:
                begin
                    pRec.TestField("Vehicle Document No.");
                    pRec.TestField("Employee No.");
                    pRec.TestField("Repair Item");
                    pRec.TestField(Amount);
                end;
            pRec."Document Type"::Wash:
                begin
                    pRec.TestField("Vehicle Document No.");
                    pRec.TestField("Employee No.");
                    pRec.TestField(Amount);
                end;
        end;

        exit(true);
    end;


    procedure VehiclePost(pRec: Record "DK_Vehicle Led. Entry Header"): Boolean
    var
        _VehicleOper: Record "DK_Vehicle Oper. Led. Entry";
        _VehicleRefue: Record "DK_Vehicle Refue. Led. Entry";
        _VehicleRepair: Record "DK_Vehicle Repair Led. Entry";
        _KmDifference: Decimal;
        _VehicleWash: Record "DK_Vehicle Wash Led. Entry";
        _VehicleOper2: Record "DK_Vehicle Oper. Led. Entry";
        _VehicleRefue2: Record "DK_Vehicle Refue. Led. Entry";
        _Mileage: Decimal;
    begin
        if not VehicleCheck(pRec) then exit;

        case pRec."Document Type" of
            pRec."Document Type"::Operation:
                begin
                    _VehicleOper.Init;
                    _VehicleOper."Document No." := pRec."No.";
                    _VehicleOper.Validate("Vehicle Document No.", pRec."Vehicle Document No.");
                    _VehicleOper.Validate("Departure Date", pRec."Departure Date");
                    _VehicleOper.Validate("Departure Time", pRec."Departure Time");
                    _VehicleOper.Validate("Arrival Date", pRec."Arrival Date");
                    _VehicleOper.Validate("Arrival Time", pRec."Arrival Time");
                    _VehicleOper.Validate("Employee No.", pRec."Employee No.");
                    _VehicleOper.Validate("Km Cumulative", pRec."Km Cumulative");
                    _VehicleOper.Validate(Remarks, pRec.Remarks);
                    //>>Km Cumulative Cal
                    _VehicleOper2.Reset;
                    _VehicleOper2.SetCurrentKey("Entry No.");
                    _VehicleOper2.SetRange("Vehicle Document No.", pRec."Vehicle Document No.");
                    if _VehicleOper2.FindLast then
                        _KmDifference := pRec."Km Cumulative" - _VehicleOper2."Km Cumulative"
                    else
                        _KmDifference := 0;
                    _VehicleOper.Validate("Km Difference", _KmDifference);
                    //<<Km Cumulative Cal
                    _VehicleOper.Validate("Creation Date", CurrentDateTime);
                    _VehicleOper.Validate("Creation Person", UserId);

                    _VehicleOper.Insert;

                    Check_VehicleAlram(pRec);
                end;
            pRec."Document Type"::Refueling:
                begin
                    _VehicleRefue.Init;
                    _VehicleRefue."Document No." := pRec."No.";
                    _VehicleRefue.Validate("Vehicle Document No.", pRec."Vehicle Document No.");
                    _VehicleRefue.Validate("Oiling Date", pRec."Oiling Date");
                    _VehicleRefue.Validate("Oiling Machine", pRec."Oiling Machine");
                    _VehicleRefue.Validate("Employee No.", pRec."Employee No.");
                    _VehicleRefue.Validate("Unit Price", pRec."Unit Price");
                    _VehicleRefue.Validate(Amount, pRec.Amount);
                    _VehicleRefue.Validate(Liter, pRec.Liter);
                    _VehicleRefue.Validate("Km Cumulative", pRec."Km Cumulative");
                    _VehicleRefue.Validate(Remarks, pRec.Remarks);
                    //>>Km Cumulative Cal
                    _VehicleRefue2.Reset;
                    _VehicleRefue2.SetCurrentKey("Entry No.");
                    _VehicleRefue2.SetRange("Vehicle Document No.", pRec."Vehicle Document No.");
                    if _VehicleRefue2.FindLast then begin
                        _KmDifference := pRec."Km Cumulative" - _VehicleRefue2."Km Cumulative";
                        if pRec.Liter <> 0 then
                            _Mileage := _KmDifference / pRec.Liter
                        else
                            _Mileage := 0;
                    end
                    else begin
                        _KmDifference := 0;
                        _Mileage := 0;
                    end;
                    _VehicleRefue.Validate("Km Difference", _KmDifference);
                    _VehicleRefue.Validate(Mileage, _Mileage);
                    //<<Km Cumulative Cal
                    _VehicleRefue.Validate("Creation Date", CurrentDateTime);
                    _VehicleRefue.Validate("Creation Person", UserId);
                    _VehicleRefue.Insert
                end;
            pRec."Document Type"::Repair:
                begin
                    _VehicleRepair.Init;
                    _VehicleRepair."Document No." := pRec."No.";
                    _VehicleRepair.Validate("Vehicle Document No.", pRec."Vehicle Document No.");
                    _VehicleRepair.Validate("Repair Date", pRec."Repair Date");
                    _VehicleRepair.Validate("Repair Item Type", pRec."Repair Item Type");
                    _VehicleRepair.Validate("Repair Item", pRec."Repair Item");
                    _VehicleRepair.Validate(Type, pRec."Repair Type");
                    _VehicleRepair.Validate(Quantity, pRec.Quantity);
                    _VehicleRepair.Validate("Employee No.", pRec."Employee No.");
                    _VehicleRepair.Validate(Amount, pRec.Amount);
                    _VehicleRepair.Validate(Remarks, pRec.Remarks);
                    _VehicleRepair.Validate("Creation Date", CurrentDateTime);
                    _VehicleRepair.Validate("Creation Person", UserId);
                    _VehicleRepair.Insert;
                end;
            pRec."Document Type"::Wash:
                begin
                    _VehicleWash.Init;
                    _VehicleWash."Document No." := pRec."No.";
                    _VehicleWash.Validate("Vehicle Document No.", pRec."Vehicle Document No.");
                    _VehicleWash.Validate("Employee No.", pRec."Employee No.");
                    _VehicleWash.Validate("Wash Date", pRec."Wash Date");
                    _VehicleWash.Validate(Amount, pRec.Amount);
                    _VehicleWash.Validate(Remarks, pRec.Remarks);
                    _VehicleWash.Validate("Creation Date", CurrentDateTime);
                    _VehicleWash.Validate("Creation Person", UserId);
                    _VehicleWash.Insert;
                end;
        end;

        pRec.Status := pRec.Status::Complete;
        pRec.Modify;

        exit(true);
    end;


    procedure Check_VehicleAlram(pVehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header")
    var
        _Alarm: Record DK_Alarm;
        _SMSSending: Codeunit "DK_Batch SMS Sending";
        _FunctionSetup: Record "DK_Function Setup";
        _SMS: Record DK_SMS;
        _Employee: Record DK_Employee;
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _SMSMessage: Text;
        _CompanyInformation: Record "Company Information";
    begin
        _Alarm.Reset;
        _Alarm.CalcFields("Sending Date");
        _Alarm.SetRange("Source Type", _Alarm."Source Type"::Vehicle);
        _Alarm.SetRange(Type, _Alarm.Type::Alarm);
        _Alarm.SetRange(Division, _Alarm.Division::Km);
        _Alarm.SetFilter("Sending Date", '%1', 0D);
        _Alarm.SetRange("Vehicle Document No.", pVehicleLedEntryHeader."Vehicle Document No.");
        _Alarm.SetFilter("Alarm Km", '<=%1', pVehicleLedEntryHeader."Km Cumulative");
        if _Alarm.FindSet then begin
            _FunctionSetup.Get;
            _CompanyInformation.Get;
            _SMS.Reset;
            _SMS.SetRange(Type, _SMS.Type::Vehicle);
            if _SMS.FindSet then begin
                _SMSMessage := _SMSSending.SetMessageType(_SMS.Type::Vehicle, _SMS."Short Message", pVehicleLedEntryHeader."No.");
                repeat
                    if _Alarm."Recipient Type" = _Alarm."Recipient Type"::Department then begin
                        _Employee.Reset;
                        _Employee.SetRange("Department Code", _Alarm."Recipient Code");
                        if _Employee.FindSet then begin
                            repeat
                                _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", _Employee."Mobile No.", _CompanyInformation.Name, _SMSMessage,
                                                      '', '', '', true, _SendedSMSHistory."Source Type"::Vehicle, pVehicleLedEntryHeader."No.", 0, _SMS."Biz Talk Tamplate No.", '');
                            until _Employee.Next = 0;
                        end;
                    end else begin
                        _Employee.Reset;
                        _Employee.SetRange("No.", _Alarm."Recipient Code");
                        if _Employee.FindSet then begin
                            _SMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.", _Employee."Mobile No.", _CompanyInformation.Name, _SMSMessage,
                                                  '', '', '', true, _SendedSMSHistory."Source Type"::Vehicle, pVehicleLedEntryHeader."No.", 0, _SMS."Biz Talk Tamplate No.", '');
                        end;
                    end;
                until _Alarm.Next = 0;
            end;
        end else
            exit;
    end;
}

