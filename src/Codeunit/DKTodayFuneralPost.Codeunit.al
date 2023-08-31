codeunit 50010 "DK_Today Funeral - Post"
{
    // *DK32 : 20200715
    //   - Modify Function : Insert_Corpse
    // 


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'The document is sent to the %1.\Do you want to continue?';
        MSG002: Label 'There is no %1 entered.';
        MSG003: Label 'If there is no %1, transfer will not be possible.';
        MSG004: Label '%1 is not valid. Please enter in 13 digits. Ex) 123456-1234567, current number of digits:%2';
        MSG005: Label 'Birthday is not valid on the date. Value : %1';
        MSG006: Label 'The specified value %1 is not valid. Please check again.';
        DK_TodayFuneral: Record "DK_Today Funeral";
        MSG007: Label 'Do you want to insert the selected information?';
        MSG008: Label 'œ‰œ ‘°—Ê‘Èž ‰«Œ¡¯„Ÿ„¾.';
        MSG009: Label '%1 ‰«Œ¡í ‹Ð‘ª…—ŽØ …—…‰Ž–™„Ÿ„¾. ÐŒ® —Ÿ“À„Ÿ€Ø?';
        DK_Corpse: Record DK_Corpse;


    procedure CheckValue(pTodayFuneral: Record "DK_Today Funeral"): Boolean
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin

        pTodayFuneral.TestField("Field Work Main Cat. Code");
        pTodayFuneral.TestField("Contract No.");
        pTodayFuneral.TestField(Date);
        pTodayFuneral.TestField("Arrival Time");
        //pTodayFuneral.TESTFIELD("Opening Time");
        //pTodayFuneral.TESTFIELD(Address);
        //pTodayFuneral.TESTFIELD("Address 2");
        pTodayFuneral.TestField(Applicant);
        //pTodayFuneral.TESTFIELD("Cemetery Code");
        //pTodayFuneral.TESTFIELD(Size);

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.IsEmpty then
            Error(MSG002, _TodayFuneralLine.TableCaption);

        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.FindSet then begin
            repeat
                //_TodayFuneralLine.TESTFIELD("Field Work Sub Cat. Code");
                //_TodayFuneralLine.TESTFIELD("Cemetery Code");
                _TodayFuneralLine.TestField(Name);
            //_TodayFuneralLine.TESTFIELD("Social Security No.");
            //_TodayFuneralLine.TESTFIELD(Address);
            //_TodayFuneralLine.TESTFIELD("Address 2");
            //_TodayFuneralLine.TESTFIELD("Death Date");
            //_TodayFuneralLine.TESTFIELD(Location);
            //_TodayFuneralLine.TESTFIELD("Date Of Birth");
            until _TodayFuneralLine.Next = 0;
        end;


        exit(true);
    end;


    procedure CheckValue_Release(pTodayFuneral: Record "DK_Today Funeral"): Boolean
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin

        pTodayFuneral.TestField("Field Work Main Cat. Code");
        //pTodayFuneral.TESTFIELD("Contract No.");
        pTodayFuneral.TestField(Date);
        pTodayFuneral.TestField("Arrival Time");
        //pTodayFuneral.TESTFIELD("Opening Time");
        //pTodayFuneral.TESTFIELD(Address);
        //pTodayFuneral.TESTFIELD("Address 2");
        pTodayFuneral.TestField(Applicant);
        //pTodayFuneral.TESTFIELD("Cemetery Code");
        //pTodayFuneral.TESTFIELD(Size);

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.IsEmpty then
            Error(MSG002, _TodayFuneralLine.TableCaption);

        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.FindSet then begin
            repeat
                //_TodayFuneralLine.TESTFIELD("Field Work Sub Cat. Code");
                //_TodayFuneralLine.TESTFIELD("Cemetery Code");
                _TodayFuneralLine.TestField(Name);
            //_TodayFuneralLine.TESTFIELD("Social Security No.");
            //_TodayFuneralLine.TESTFIELD(Address);
            //_TodayFuneralLine.TESTFIELD("Address 2");
            //_TodayFuneralLine.TESTFIELD("Death Date");
            //_TodayFuneralLine.TESTFIELD(Location);
            //_TodayFuneralLine.TESTFIELD("Date Of Birth");
            until _TodayFuneralLine.Next = 0;
        end;


        exit(true);
    end;


    procedure Post(pTodayFuneral: Record "DK_Today Funeral"): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _Corpse: Record DK_Corpse;
        _FieldWorkPost: Codeunit "DK_Field Work - Post";
    begin

        if not CheckValue(pTodayFuneral) then exit;

        if pTodayFuneral.Status <> pTodayFuneral.Status::Release then
            Error(MSG003, pTodayFuneral.Status::Release);

        if not Confirm(MSG001, false, _FieldWorkHeader.TableCaption) then exit;

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        _TodayFuneralLine.SetCurrentKey("Document No.", "Line No.");
        if _TodayFuneralLine.FindFirst then begin
            with _FieldWorkHeader do begin
                LockTable;
                Init;
                "No." := '';
                Status := Status::Open;
                Type := Type::Cemetery;
                "Time From" := pTodayFuneral."Arrival Time";
                "Field Work Main Cat. Code" := pTodayFuneral."Field Work Main Cat. Code";
                "Field Work Main Cat. Name" := pTodayFuneral."Field Work Main Cat. Name";
                "Field Work Sub Cat. Code" := _TodayFuneralLine."Field Work Sub Cat. Code";
                "Field Work Sub Cat. Name" := _TodayFuneralLine."Field Work Sub Cat. Name";
                Date := pTodayFuneral.Date;
                "Source No." := pTodayFuneral."No.";
                "Source Type" := "Source Type"::Today;
                "Source Line No." := _TodayFuneralLine."Line No.";
                Insert(true);
            end;

            _FieldWorkPost.InsertItemLine(_FieldWorkHeader);

            with _FieldWorkLineCemetery do begin
                LockTable;
                Init;
                "Document No." := _FieldWorkHeader."No.";
                "Line No." := _TodayFuneralLine."Line No.";
                Type := _FieldWorkHeader.Type;
                if _TodayFuneralLine."Temporary Grave Place Code" <> '' then begin
                    Validate("Use Area Code", _TodayFuneralLine."Temporary Grave Place Code");
                    "Temporary Grave" := true;
                end else
                    Validate("Use Area Code", pTodayFuneral."Cemetery Code");
                Insert(true);
            end;
        end;

        pTodayFuneral.Status := pTodayFuneral.Status::Post;
        pTodayFuneral.Modify(true);

        exit(true);
    end;


    procedure Insert_Corpse(pTodayFuneral: Record "DK_Today Funeral")
    var
        _Corpse: Record DK_Corpse;
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _LineNo: Integer;
        _Cemetery: Record DK_Cemetery;
    begin
        //>>DK32
        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.FindSet then begin
            repeat
                //—šŒ÷ ¬!
                _TodayFuneralLine.TestField("Laying Date");
                with _Corpse do begin
                    Init;
                    "Source Type" := "Source Type"::Today;
                    "Contract No." := pTodayFuneral."Contract No.";
                    "Line No." := 0;
                    Insert(true);

                    //=====================================================//
                    //"Laying Date" Š Modifyˆ‡ž “‚ˆ«…—ŽØŽÈ—¯.!
                    //=====================================================//
                    "Supervise No." := pTodayFuneral."Supervise No.";
                    Validate("Cemetery Code", pTodayFuneral."Cemetery Code");
                    Name := _TodayFuneralLine.Name;
                    "Social Security No." := _TodayFuneralLine."Social Security No.";
                    "Post Code" := _TodayFuneralLine."Post Code";
                    Address := _TodayFuneralLine.Address;
                    "Address 2" := _TodayFuneralLine."Address 2";
                    "Death Date" := _TodayFuneralLine."Death Date";
                    "Death Cause" := _TodayFuneralLine."Death Cause";
                    "Death Place" := _TodayFuneralLine."Death Place";
                    Location := _TodayFuneralLine.Location;
                    Relationship := _TodayFuneralLine.Relationship;
                    "Date Of Birth" := _TodayFuneralLine."Date Of Birth";
                    Validate("Laying Date", _TodayFuneralLine."Laying Date");//Œ‚‰ªŸÀ
                    "Solar Lunar Calendar" := _TodayFuneralLine."Solar Lunar Calendar";
                    if _TodayFuneralLine."Temporary Grave Place Code" <> '' then begin
                        Validate("Temporary Grave Place Code", _TodayFuneralLine."Temporary Grave Place Code");
                        "Temporary Grave Date" := _TodayFuneralLine."Temporary Grave Date";
                    end;
                    Validate("Field Work Main Cat. Code", pTodayFuneral."Field Work Main Cat. Code");
                    Validate("Field Work Sub Cat. Code", _TodayFuneralLine."Field Work Sub Cat. Code");
                    "Source No." := pTodayFuneral."No.";
                    "Source Line No." := _TodayFuneralLine."Line No.";
                    Remark := _TodayFuneralLine.Remark;
                    // DK #3322
                    Gender := _TodayFuneralLine.Gender;
                    // DK #3322
                    Modify(true);
                end;
            until _TodayFuneralLine.Next = 0;
        end;
        //<<DK32
    end;


    procedure Modify_Corpse(pTodayFuneral: Record "DK_Today Funeral")
    var
        _Corpse: Record DK_Corpse;
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin
        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.FindSet then begin
            _Corpse.Reset;
            _Corpse.SetRange("Contract No.", pTodayFuneral."Contract No.");
            repeat
                _Corpse.SetRange("Line No.", _TodayFuneralLine."Corpse Line No.");

                if _Corpse.FindSet then begin
                    _Corpse."Move The Grave Type" := true;
                    _Corpse."Move The Grave Date" := _TodayFuneralLine."Move The Grave Date";
                    _Corpse.Modify;
                end;
            until _TodayFuneralLine.Next = 0;
        end;
    end;


    procedure Delete_Corpse(pTodayFuneral: Record "DK_Today Funeral")
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _Corpse: Record DK_Corpse;
    begin
        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", pTodayFuneral."No.");
        if _TodayFuneralLine.FindSet then begin
            _Corpse.Reset;
            _Corpse.SetRange("Contract No.", pTodayFuneral."Contract No.");
            repeat
                _Corpse.SetRange("Line No.", _TodayFuneralLine."Line No.");

                if _Corpse.FindSet then begin
                    _Corpse.Delete(true);
                end;
            until _TodayFuneralLine.Next = 0;
        end;
    end;


    procedure Insert_MoveInfo(var pTodayFuneralLine: Record "DK_Today Funeral Line")
    var
        _Corpse: Record DK_Corpse;
    begin
        with pTodayFuneralLine do begin
            if not Confirm(MSG007, false) then begin
                "Corpse Line No." := 0;
                exit;
            end;

            _Corpse.Reset;
            _Corpse.SetRange("Contract No.", "Contract No.");
            _Corpse.SetRange("Line No.", "Corpse Line No.");
            if _Corpse.FindSet then begin
                //VALIDATE("Cemetery Code",_Corpse."Cemetery Code");
                Name := _Corpse.Name;
                "Social Security No." := _Corpse."Social Security No.";
                "Post Code" := _Corpse."Post Code";
                Address := _Corpse.Address;
                "Address 2" := _Corpse."Address 2";
                "Death Date" := _Corpse."Death Date";
                "Death Cause" := _Corpse."Death Cause";
                "Death Place" := _Corpse."Death Place";
                Location := _Corpse.Location;
                Remark := _Corpse.Remark;
                Relationship := _Corpse.Relationship;
                "Date Of Birth" := _Corpse."Date Of Birth";
                "Solar Lunar Calendar" := _Corpse."Solar Lunar Calendar";
            end else begin
                //VALIDATE("Cemetery Code",'');
                Name := '';
                "Social Security No." := '';
                "Post Code" := '';
                Address := '';
                "Address 2" := '';
                "Death Date" := 0D;
                "Death Cause" := '';
                "Death Place" := '';
                Location := '';
                Remark := '';
                "Date Of Birth" := 0D;
                "Solar Lunar Calendar" := 0;
            end;
        end;
    end;


    procedure Insert_CustomerInfo(var pTodayFuneral: Record "DK_Today Funeral")
    var
        _Customer: Record DK_Customer;
    begin

        with pTodayFuneral do begin
            if not Confirm(MSG007, false) then exit;

            if _Customer.Get("Main Customer No.") then begin
                Applicant := _Customer.Name;
                Address := _Customer.Address;
                "Address 2" := _Customer."Address 2";
                "Post Code" := _Customer."Post Code";
                "Phone No." := _Customer."Phone No.";
                "Mobile No." := _Customer."Mobile No.";
            end else begin
                Applicant := '';
                Address := '';
                "Address 2" := '';
                "Post Code" := '';
                "Phone No." := '';
                "Mobile No." := '';
            end;
        end;
    end;

    procedure SSN_Onvalidate(var pTodayFuneralLine: Record "DK_Today Funeral Line")
    var
        _Year: Integer;
        _Month: Integer;
        _Day: Integer;
        _Gender: Integer;
        _CommFun: Codeunit "DK_Common Function";
    begin
        with pTodayFuneralLine do begin
            if ("Social Security No." <> '') then begin
                "Social Security No." := UpperCase("Social Security No.");

                //IF Type = Type::Individual THEN BEGIN
                //IF "Social Security No." <> xRec."Social Security No." THEN
                SocialSecurityValidation("Social Security No.", "Document No.");

                if StrLen("Social Security No.") <> 14 then
                    Error(MSG004, FieldCaption("Social Security No."), StrLen("Social Security No."));


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
                        Error(MSG004, CopyStr("Social Security No.", 1, 6));
                end else
                    Error(MSG005, FieldCaption("Social Security No."));
            end;
        end;
    end;


    procedure SocialSecurityValidation(pSocialSecNo: Text[15]; pNo: Code[20])
    var
        VATRegistrationNoFormat: Record "VAT Registration No. Format";
    begin
        if not VATRegistrationNoFormat.Test(pSocialSecNo, 'KOR', pNo, DATABASE::"DK_Today Funeral Line") then
            exit;
    end;


    procedure SetOpen(var pDK_TodayFuneral: Record "DK_Today Funeral")
    begin
        DK_TodayFuneral := pDK_TodayFuneral;
        with DK_TodayFuneral do begin
            if Status = Status::Open then
                exit;
            Check_FieldWork;
            Status := Status::Open;
            Modify;
            Check_Status(DK_TodayFuneral);

        end;
        pDK_TodayFuneral := DK_TodayFuneral;
    end;


    procedure SetRelease(var pDK_TodayFuneral: Record "DK_Today Funeral")
    begin
        DK_TodayFuneral := pDK_TodayFuneral;
        with DK_TodayFuneral do begin
            if Status = Status::Release then
                exit;
            Check_FieldWork;
            if not CheckValue_Release(pDK_TodayFuneral) then exit;
            Status := Status::Release;
            Modify;
            Check_Status(DK_TodayFuneral);

        end;
        pDK_TodayFuneral := DK_TodayFuneral;
    end;


    procedure SetComplete(var pDK_TodayFuneral: Record "DK_Today Funeral"; Option: Integer)
    begin
        DK_TodayFuneral := pDK_TodayFuneral;
        with DK_TodayFuneral do begin
            if Status = Status::Complete then
                exit;
            if Option = 0 then
                Check_FieldWork;
            if not CheckValue(DK_TodayFuneral) then exit;
            Status := Status::Complete;
            Modify;
            Check_Status(DK_TodayFuneral);

        end;
        pDK_TodayFuneral := DK_TodayFuneral;
    end;


    procedure Check_Status(pDK_TodayFuneral: Record "DK_Today Funeral")
    var
        _Cemetery: Record DK_Cemetery;
    begin
        with pDK_TodayFuneral do begin
            if _Cemetery.Get("Cemetery Code") then begin
                if "Funeral Type" = "Funeral Type"::Funeral then begin
                    case Status of
                        Status::Release:
                            begin

                                // DK #2588 210705
                                DK_Corpse.Reset;
                                DK_Corpse.SetRange("Contract No.", pDK_TodayFuneral."Contract No.");
                                if DK_Corpse.FindSet then
                                    _Cemetery.Validate(Status, _Cemetery.Status::Laying)
                                else
                                    _Cemetery.Validate(Status, _Cemetery.Status::Reserved);

                                _Cemetery.Modify(true);
                                // DK #2588 210705


                                //  _Cemetery.Status := _Cemetery.Status::Reserved;
                                //  _Cemetery.MODIFY;
                            end;
                        Status::Post:
                            begin
                                Delete_Corpse(pDK_TodayFuneral);

                                _Cemetery.Status := _Cemetery.Status::Contracted;
                                _Cemetery.Modify;
                            end;
                        Status::Complete:
                            begin
                                Insert_Corpse(pDK_TodayFuneral);
                            end;
                    end;
                end else begin
                    if Status = Status::Complete then begin
                        Modify_Corpse(pDK_TodayFuneral);
                    end;
                end;
            end;
        end;
    end;


    procedure Change_CemeteryStatus(pTemporayPlaceCode: Code[20])
    var
        _Cemetery: Record DK_Cemetery;
    begin

        if pTemporayPlaceCode <> '' then begin
            _Cemetery.Reset;
            _Cemetery.SetRange("Cemetery Code", pTemporayPlaceCode);
            if _Cemetery.FindFirst then begin
                _Cemetery.Status := _Cemetery.Status::Laying;
                _Cemetery.Modify;
            end;
        end else begin

        end;
    end;


    procedure Delete_FieldWork(pSourceNo: Code[20]): Boolean
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        if not Confirm(MSG009, false, _FieldWorkHeader.TableCaption) then exit(false);

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Source No.", pSourceNo);
        if _FieldWorkHeader.FindSet then begin

            if _FieldWorkHeader.Status <> _FieldWorkHeader.Status::Open then
                Error(MSG008);

            _FieldWorkHeader.DeleteAll(true);

            exit(true);
        end;
    end;


    procedure Change_TodayHeaderWorkGroup(pTodayFuneralLine: Record "DK_Today Funeral Line")
    var
        _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        _TodayFuneral: Record "DK_Today Funeral";
    begin

        _FieldWorkSubCategory.Reset;
        _FieldWorkSubCategory.SetRange(Code, pTodayFuneralLine."Field Work Sub Cat. Code");
        _FieldWorkSubCategory.SetFilter("Work Group Code", '<>%1', '');
        if _FieldWorkSubCategory.FindSet then begin
            _TodayFuneral.Reset;
            _TodayFuneral.SetRange("No.", pTodayFuneralLine."Document No.");
            if _TodayFuneral.FindSet then begin
                _TodayFuneral.Validate("Working Group Code", _FieldWorkSubCategory."Work Group Code");
                _TodayFuneral.Modify;
            end;
        end;
    end;
}

