codeunit 50033 "DK_Upload Cemetery"
{
    // #1981 : 20200626
    //   - Modify Function : DataValidation


    trigger OnRun()
    begin
    end;

    var
        _UploadCemetery: Record "DK_Upload Cemetery Buffer";
        MSG001: Label 'The target does not exist.';
        MSG002: Label 'The required values are missing a ''%1''.';
        MSG003: Label '%1 %2 already exists on %3.';
        MSG004: Label '%1 %2 does not exist on %3. Register %1 %2 in %3 first.';
        MSG005: Label '%1 %2 is locked on %3.';
        MSG006: Label '%1 %2, %3 %4 does not exist on %5. Register %1 %2, %3 %4 in %5 first.';
        MSG007: Label 'Duplicate %1 %2 is entered in %5. Check %3:%4.';
        MSG008: Label 'No price found.';
        MSG009: Label 'New cemetery data contains an error. Please check the contents with [Check Error] and proceed with the update.';
        MSG010: Label '%1 new cemetery data exists. Do you want to create a new cemetery?';


    procedure DataValidation(): Boolean
    begin
        //>>#1981
        /*
        _UploadCemetery.RESET;
        _UploadCemetery.SETRANGE("Data Validation", _UploadCemetery."Data Validation"::Error);
        //_UploadCemetery.SETFILTER("Cemetery No.", '<>%1','');
        IF _UploadCemetery.FINDSET THEN
          EXIT(FALSE);
        */

        _UploadCemetery.Reset;
        if _UploadCemetery.FindSet then begin
            repeat
                if CheckError(_UploadCemetery) then
                    exit(false);
            until _UploadCemetery.Next = 0;
        end;
        //<<#1981
        exit(true);

    end;


    procedure CreateCemetery(): Boolean
    var
        _Cemetery: Record DK_Cemetery;
    begin

        if DataValidation then begin

            _UploadCemetery.Reset;
            if _UploadCemetery.FindSet then begin

                if not Confirm(MSG010, false, _UploadCemetery.Count) then
                    exit(false);

                repeat
                    if _UploadCemetery."Cemetery No." <> '' then begin
                        _Cemetery.Init;
                        _Cemetery."Cemetery Code" := '';
                        _Cemetery."Cemetery No." := _UploadCemetery."Cemetery No.";
                        _Cemetery.Validate("Estate Name", _UploadCemetery."Estate Name");
                        _Cemetery.Validate("Cemetery Conf. Name", _UploadCemetery."Cemetery Conf. Name");
                        _Cemetery.Validate("Cemetery Option Name", _UploadCemetery."Cemetery Option Name");
                        _Cemetery.Validate("Unit Price Type Name", _UploadCemetery."Unit Price Type Name");
                        _Cemetery.Class := _UploadCemetery.Class;
                        _Cemetery.Size := _UploadCemetery.Size;
                        _Cemetery."Size 2" := _UploadCemetery."Size 2";
                        _Cemetery."Corpse Size" := _UploadCemetery."Corpse Size";
                        _Cemetery."Landscape Architecture" := _UploadCemetery."Landscape Architecture";
                        _Cemetery.Validate("Cemetery Dig. Name", _UploadCemetery."Cemetery Dig. Name");
                        _Cemetery.Stone := _UploadCemetery.Stone;
                        _Cemetery.Validate("Tree Type Name", _UploadCemetery."Tree Type Name");
                        _Cemetery."Position Row" := _UploadCemetery."Position Row";
                        _Cemetery."Position Column" := _UploadCemetery."Position Column";
                        _Cemetery.Insert(true);

                        _UploadCemetery.Delete;
                    end;
                until _UploadCemetery.Next = 0;
                exit(true);
            end else
                Error(MSG001);

        end else
            Error(MSG009);
    end;


    procedure ErrorList(pRec: Record "DK_Upload Cemetery Buffer"; var pErrorList: array[100] of Text[250]) Rtn_ErrorIndex: Integer
    var
        _ErrorIndex: Integer;
        _Cemetery: Record DK_Cemetery;
        _Estate: Record DK_Estate;
        _UploadCemetery: Record "DK_Upload Cemetery Buffer";
        _CemeteryConfor: Record "DK_Cemetery Conformation";
        _CemeteryOp: Record "DK_Cemetery Option";
        _UnitPriceType: Record "DK_Unit Price Type";
        _CemeteryDigits: Record "DK_Cemetery Digits";
        _TreeType: Record "DK_Tree Type";
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _EstateCode: Code[20];
        _CemeteryConforCode: Code[20];
        _CemeteryOpCode: Code[20];
        _UnitPriceTypeCode: Code[20];
    begin


        if pRec."Cemetery No." = '' then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Cemetery No.")), pErrorList);

        _UploadCemetery.Reset;
        _UploadCemetery.SetFilter("Entry No.", '<>%1', pRec."Entry No.");
        _UploadCemetery.SetRange("Cemetery No.", pRec."Cemetery No.");
        if _UploadCemetery.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG007, pRec.FieldCaption("Cemetery No."),
                                                            pRec."Cemetery No.",
                                                            _UploadCemetery.FieldCaption("Entry No."),
                                                            _UploadCemetery."Entry No.",
                                                            _UploadCemetery.TableCaption), pErrorList);

        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery No.", pRec."Cemetery No.");
        if _Cemetery.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG003, pRec.FieldCaption("Cemetery No."),
                                                            pRec."Cemetery No.",
                                                            _Cemetery.TableCaption), pErrorList);

        if pRec."Estate Name" = '' then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Estate Name")), pErrorList);

        _Estate.Reset;
        _Estate.SetRange(Name, pRec."Estate Name");
        if not _Estate.FindSet then begin
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG004, pRec.FieldCaption("Estate Name"),
                                                            pRec."Estate Name",
                                                            _Estate.TableCaption), pErrorList);
        end else begin
            if _Estate.Blocked = true then
                NewAddErrorList(_ErrorIndex, StrSubstNo(MSG005, pRec.FieldCaption("Estate Name"),
                                                                pRec."Estate Name",
                                                                _Estate.TableCaption), pErrorList);

            _EstateCode := _Estate.Code;
        end;

        if pRec."Cemetery Conf. Name" = '' then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Cemetery Conf. Name")), pErrorList);

        _CemeteryConfor.Reset;
        _CemeteryConfor.SetRange(Name, pRec."Cemetery Conf. Name");
        if not _CemeteryConfor.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG004, pRec.FieldCaption("Cemetery Conf. Name"),
                                                            pRec."Cemetery Conf. Name",
                                                            _CemeteryConfor.TableCaption), pErrorList);

        if pRec."Cemetery Option Name" = '' then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Cemetery Option Name")), pErrorList);

        _CemeteryOp.Reset;
        _CemeteryOp.SetRange(Name, pRec."Cemetery Option Name");
        if not _CemeteryOp.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG004, pRec.FieldCaption("Cemetery Option Name"),
                                                            pRec."Cemetery Option Name",
                                                            _CemeteryOp.TableCaption), pErrorList)

        else
            _CemeteryOpCode := _CemeteryOp.Code;

        if pRec."Unit Price Type Name" = '' then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Unit Price Type Name")), pErrorList);

        _UnitPriceType.Reset;
        _UnitPriceType.SetRange(Name, pRec."Unit Price Type Name");
        if not _UnitPriceType.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG004, pRec.FieldCaption("Unit Price Type Name"),
                                                            pRec."Unit Price Type Name",
                                                            _UnitPriceType.TableCaption), pErrorList)
        else
            _UnitPriceTypeCode := _UnitPriceType.Code;

        if pRec."Cemetery Dig. Name" = '' then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Cemetery Dig. Name")), pErrorList);

        _CemeteryDigits.Reset;
        _CemeteryDigits.SetRange("Cemetery Conf. Name", pRec."Cemetery Conf. Name");
        _CemeteryDigits.SetRange(Name, pRec."Cemetery Dig. Name");
        if not _CemeteryDigits.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG006, pRec.FieldCaption("Cemetery Conf. Name"),
                                                            pRec."Cemetery Conf. Name",
                                                            pRec.FieldCaption("Cemetery Dig. Name"),
                                                            pRec."Cemetery Dig. Name",
                                                            _CemeteryDigits.TableCaption), pErrorList);


        if pRec."Tree Type Name" <> '' then begin

            _TreeType.Reset;
            _TreeType.SetRange(Name, pRec."Tree Type Name");
            if not _TreeType.FindSet then
                NewAddErrorList(_ErrorIndex, StrSubstNo(MSG004, pRec.FieldCaption("Tree Type Name"),
                                                                pRec."Tree Type Name",
                                                                _TreeType.TableCaption), pErrorList);
        end;

        if pRec.Size = 0 then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption(Size)), pErrorList);
        if pRec."Size 2" = 0 then NewAddErrorList(_ErrorIndex, StrSubstNo(MSG002, pRec.FieldCaption("Size 2")), pErrorList);

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetRange("Estate Name", pRec."Estate Name");
        _CemeteryUnitPrice.SetRange("Cemetery Conf. Name", pRec."Cemetery Conf. Name");
        _CemeteryUnitPrice.SetRange("Cemetery Option Name", pRec."Cemetery Option Name");
        _CemeteryUnitPrice.SetFilter("Starting Date", '<=%1', Today);
        if not _CemeteryUnitPrice.FindSet then
            NewAddErrorList(_ErrorIndex, StrSubstNo(MSG008, _CemeteryUnitPrice.TableCaption), pErrorList);

        exit(_ErrorIndex);
    end;


    procedure CheckError(pRec: Record "DK_Upload Cemetery Buffer"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _Estate: Record DK_Estate;
        _UploadCemetery: Record "DK_Upload Cemetery Buffer";
        _CemeteryConfor: Record "DK_Cemetery Conformation";
        _CemeteryOp: Record "DK_Cemetery Option";
        _UnitPriceType: Record "DK_Unit Price Type";
        _CemeteryDigits: Record "DK_Cemetery Digits";
        _TreeType: Record "DK_Tree Type";
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _EstateCode: Code[20];
        _CemeteryConforCode: Code[20];
        _CemeteryOpCode: Code[20];
        _UnitPriceTypeCode: Code[20];
    begin

        if pRec."Cemetery No." = '' then exit(true);

        _UploadCemetery.Reset;
        _UploadCemetery.SetFilter("Entry No.", '<>%1', pRec."Entry No.");
        _UploadCemetery.SetRange("Cemetery No.", pRec."Cemetery No.");
        if _UploadCemetery.FindSet then
            exit(true);

        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery No.", pRec."Cemetery No.");
        if _Cemetery.FindSet then
            exit(true);

        if pRec."Estate Name" = '' then exit(true);

        _Estate.Reset;
        _Estate.SetRange(Name, pRec."Estate Name");
        if not _Estate.FindSet then begin
            exit(true);
        end else begin
            if _Estate.Blocked = true then
                exit(true)
            else
                _EstateCode := _Estate.Code;
        end;

        if pRec."Cemetery Conf. Name" = '' then exit(true);

        _CemeteryConfor.Reset;
        _CemeteryConfor.SetRange(Name, pRec."Cemetery Conf. Name");
        if not _CemeteryConfor.FindSet then
            exit(true)
        else
            _CemeteryConforCode := _CemeteryConfor.Code;

        if pRec."Cemetery Option Name" = '' then exit(true);

        _CemeteryOp.Reset;
        _CemeteryOp.SetRange(Name, pRec."Cemetery Option Name");
        if not _CemeteryOp.FindSet then
            exit(true)
        else
            _CemeteryOpCode := _CemeteryOp.Code;

        if pRec."Unit Price Type Name" = '' then exit(true);

        _UnitPriceType.Reset;
        _UnitPriceType.SetRange(Name, pRec."Unit Price Type Name");
        if not _UnitPriceType.FindSet then
            exit(true)
        else
            _UnitPriceTypeCode := _UnitPriceType.Code;

        if pRec."Cemetery Dig. Name" = '' then exit(true);

        _CemeteryDigits.Reset;
        _CemeteryDigits.SetRange("Cemetery Conf. Name", pRec."Cemetery Conf. Name");
        _CemeteryDigits.SetRange(Name, pRec."Cemetery Dig. Name");
        if not _CemeteryDigits.FindSet then
            exit(true);


        if pRec."Tree Type Name" <> '' then begin

            _TreeType.Reset;
            _TreeType.SetRange(Name, pRec."Tree Type Name");
            if not _TreeType.FindSet then
                exit(true);
        end;

        if pRec.Size = 0 then exit(true);
        if pRec."Size 2" = 0 then exit(true);

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetRange("Estate Name", pRec."Estate Name");
        _CemeteryUnitPrice.SetRange("Cemetery Conf. Name", pRec."Cemetery Conf. Name");
        _CemeteryUnitPrice.SetRange("Cemetery Option Name", pRec."Cemetery Option Name");
        _CemeteryUnitPrice.SetFilter("Starting Date", '<=%1', Today);
        if not _CemeteryUnitPrice.FindSet then
            exit(true);

        //pRec."Position Row"
        //pRec."Position Column"
    end;


    procedure NewAddErrorList(var pArrIndex: Integer; pErrorMsg: Text[250]; var pErrorList: array[100] of Text[250])
    begin
        //Generating an error array

        pArrIndex += 1;
        pErrorList[pArrIndex] := pErrorMsg;
    end;
}

