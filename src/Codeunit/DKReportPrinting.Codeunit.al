codeunit 50019 "DK_Report Printing"
{

    trigger OnRun()
    begin
    end;

    var
        NewDocNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MSG001: Label 'Document No. not generated. The Document can not be printed.';
        MSG002: Label 'The selected contract does not exist.';
        MSG003: Label 'No printable report exists. Please check %1.';
        MSG004: Label '%2 is an unspecified contract. Contract No.: %1';
        MSG005: Label '%2 is not specified. Contract No. : %1';
        MSG006: Label 'It is a contract that has already been Revocation.';
        MSG007: Label '%4 is not specified. Contract No. : %1, %2:%3';
        MSG008: Label 'This is a contract with an outstanding balance of (0).  This does not correspond to the report output destination. Contract No.:%1, %2:%3';
        MSG009: Label 'The Reminder 1st Date does not exist. Contract No.:%1, %2:%3';
        MSG010: Label 'The amount of the %4 and %5 is (0). This does not correspond to the report output destination. Contract No.:%1, %2:%3';
        MSG011: Label 'Contract data not found.';


    procedure InsertPrintingHistory(pContract: Record DK_Contract; pDocNo: Code[20]; pReportID: Integer; pEmpNo: Code[20]; pEmpName: Text[50]; pContacts: Text[20]; pAddRemainingDueDate: Date)
    var
        _ReportPrtHistory: Record "DK_Report Prt. History";
    begin

        _ReportPrtHistory.Init;
        _ReportPrtHistory."Document No." := pDocNo;
        _ReportPrtHistory."Contract No." := pContract."No.";
        _ReportPrtHistory."Printing Date" := Today;
        _ReportPrtHistory."Printing Time" := Time;
        _ReportPrtHistory.Validate("Report ID", pReportID);
        _ReportPrtHistory."Employee No." := pEmpNo;
        _ReportPrtHistory."Employee Name" := pEmpName;
        _ReportPrtHistory.Contacts := pContacts;
        _ReportPrtHistory."Add.Remaining Due Date" := pAddRemainingDueDate;
        _ReportPrtHistory.Insert(true);
    end;


    procedure GetNewDocmentNo(): Code[20]
    var
        _FunctionSetup: Record "DK_Function Setup";
        _NoSeries: Code[10];
    begin

        _FunctionSetup.Get;
        _FunctionSetup.TestField("Litigation Printing Nos.");

        NoSeriesMgt.InitSeries(_FunctionSetup."Litigation Printing Nos.", _NoSeries, WorkDate, NewDocNo, _NoSeries);

        if NewDocNo = '' then
            Error(MSG001);

        exit(NewDocNo);
    end;


    procedure GetEmployeeNo(): Code[20]
    var
        _Employee: Record DK_Employee;
    begin

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then
            exit(_Employee."No.");

        exit('');
    end;


    procedure CheckSelectedContract()
    var
        _SelectedContract: Record "DK_Selected Contract";
    begin

        _SelectedContract.Reset;
        _SelectedContract.SetRange("USER ID", UserId);
        if not _SelectedContract.FindSet then
            Error(MSG002);
    end;

    local procedure Validate_Common(pContract: Record DK_Contract; var pErrorIndex: Integer; var pErrorList: array[60000] of Text[250])
    begin
        if pContract."Main Customer No." = '' then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG005, pContract."No.", pContract.FieldCaption("Main Customer No.")), pErrorList);

        if pContract."Main Customer Name" = '' then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG005, pContract."No.", pContract.FieldCaption("Main Customer Name")), pErrorList);

        pContract.CalcFields("Cust. Address", "Cust. Address 2");
        if DelChr(pContract."Cust. Address" + pContract."Cust. Address 2", '=', ' ') = '' then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG005, pContract."No.", pContract.FieldCaption("Cust. Address")), pErrorList);

        if pContract."Cemetery Code" = '' then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG005, pContract."No.", pContract.FieldCaption("Cemetery Code")), pErrorList);

        if pContract."Cemetery No." = '' then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG005, pContract."No.", pContract.FieldCaption("Cemetery Code")), pErrorList);

        if pContract."Contract Date" = 0D then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG005, pContract."No.", pContract.FieldCaption("Contract Date")), pErrorList);

        if pContract.Status = pContract.Status::Revocation then
            AddErrorMessage(pErrorIndex, StrSubstNo(MSG006, pContract."No.", pContract.FieldCaption("Contract Date"), pContract.Status::Revocation), pErrorList);
    end;

    local procedure PrintingValidate_Reminder1st(): Boolean
    var
        _Contract: Record DK_Contract;
        _ErrorIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin
        //“´×Œ¡ 1’ð
        //‰œÐŽÊ—
        //Â€¦ ‰œ‚‚— ˜«ž
        CheckSelectedContract;

        _Contract.Reset;
        _Contract.SetRange("User ID Filter", UserId);
        _Contract.SetRange("Selected Contract", true);
        if _Contract.FindSet then begin
            repeat
                //°•Ô ˜«ž‹Ï—¸
                Validate_Common(_Contract, _ErrorIndex, _ErrorList);

                //‚Š ˜«ž ‹Ï—¸
                if _Contract."Remaining Due Date" = 0D then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG007, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name",
                                                                  _Contract.FieldCaption("Remaining Due Date")), _ErrorList);

                if _Contract."Pay. Remaining Amount" = 0 then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG008, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name"), _ErrorList);

            until _Contract.Next = 0;
            exit(ShowErrorMessage(_ErrorIndex, _ErrorList));
        end else
            Error(MSG011);

    end;


    procedure Printing_Reminder1st()
    var
        _CustomReportLayout: Record "Custom Report Layout";
    begin

        if PrintingValidate_Reminder1st then begin

            _CustomReportLayout.Reset;
            _CustomReportLayout.SetRange("Report ID", REPORT::"DK_Reminder 1st");
            _CustomReportLayout.SetRange("Printing Use", true);
            if _CustomReportLayout.FindSet then
                _CustomReportLayout.RunCustomReport
            else
                Error(MSG003, _CustomReportLayout.TableCaption);

        end;
    end;

    local procedure PrintingValidate_Reminder2nd(): Boolean
    var
        _Contract: Record DK_Contract;
        _ErrorIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin
        //“´×Œ¡ 2’ð
        //‰œÐŽÊ—
        //Â€¦ ‰œ‚‚— ˜«ž
        CheckSelectedContract;

        _Contract.Reset;
        _Contract.SetRange("User ID Filter", UserId);
        _Contract.SetRange("Selected Contract", true);
        if _Contract.FindSet then begin
            repeat

                //°•Ô ˜«ž‹Ï—¸
                Validate_Common(_Contract, _ErrorIndex, _ErrorList);

                //‚Š ˜«ž ‹Ï—¸
                // 20221227 - 1’ð ‰ÈŒÁŠž ˜«ž ‡ž‘ð ‘ªÂ Í“‹ˆ‡ž Œ÷‘ñ //
                //
                //IF _Contract."Add. Remaining Due Date 1" = 0D THEN
                //  AddErrorMessage(_ErrorIndex, STRSUBSTNO(MSG009,_Contract."No.",
                //                                                _Contract.FIELDCAPTION("Main Customer Name"),
                //                                                _Contract."Main Customer Name"), _ErrorList);
                //
                // 20221227 - 1’ð ‰ÈŒÁŠž ˜«ž ‡ž‘ð ‘ªÂ Í“‹ˆ‡ž Œ÷‘ñ //
                if _Contract."Remaining Due Date" = 0D then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG007, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name",
                                                                  _Contract.FieldCaption("Remaining Due Date")), _ErrorList);

                if _Contract."Pay. Remaining Amount" = 0 then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG008, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name"), _ErrorList);

            until _Contract.Next = 0;
            exit(ShowErrorMessage(_ErrorIndex, _ErrorList));
        end else
            Error(MSG011);
    end;


    procedure Printing_Reminder2nd()
    var
        _CustomReportLayout: Record "Custom Report Layout";
        _ArrIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin

        if PrintingValidate_Reminder2nd then begin

            _CustomReportLayout.Reset;
            _CustomReportLayout.SetRange("Report ID", REPORT::"DK_Reminder 2nd");
            _CustomReportLayout.SetRange("Printing Use", true);
            if _CustomReportLayout.FindSet then
                _CustomReportLayout.RunCustomReport
            else
                Error(MSG003, _CustomReportLayout.TableCaption);

        end;
    end;

    local procedure PrintingValidate_NoticeofTermofContract(): Boolean
    var
        _Contract: Record DK_Contract;
        _ErrorIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin
        //ÐŽÊ —¹‘÷ •ÔŠˆŒ¡
        //‰œÐŽÊ—
        //Â€¦ ‰œ‚‚— ˜«ž
        CheckSelectedContract;

        _Contract.Reset;
        _Contract.SetRange("User ID Filter", UserId);
        _Contract.SetRange("Selected Contract", true);
        if _Contract.FindSet then begin
            repeat

                //°•Ô ˜«ž‹Ï—¸
                Validate_Common(_Contract, _ErrorIndex, _ErrorList);

                //‚Š ˜«ž ‹Ï—¸

                if _Contract."Remaining Due Date" = 0D then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG007, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name",
                                                                  _Contract.FieldCaption("Remaining Due Date")), _ErrorList);

                if _Contract."Pay. Remaining Amount" = 0 then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG008, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name"), _ErrorList);

            until _Contract.Next = 0;
            exit(ShowErrorMessage(_ErrorIndex, _ErrorList));
        end else
            Error(MSG011);
    end;


    procedure Printing_NoticeofTermofContract()
    var
        _CustomReportLayout: Record "Custom Report Layout";
        _ArrIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin

        if PrintingValidate_NoticeofTermofContract then begin

            _CustomReportLayout.Reset;
            _CustomReportLayout.SetRange("Report ID", REPORT::"DK_Notice of Term. of Contract");
            _CustomReportLayout.SetRange("Printing Use", true);
            if _CustomReportLayout.FindSet then
                _CustomReportLayout.RunCustomReport
            else
                Error(MSG003, _CustomReportLayout.TableCaption);

        end;
    end;

    local procedure PrintingValidate_InformationAbove(): Boolean
    var
        _Contract: Record DK_Contract;
        _ErrorIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin
        //‚‹Ô‘ãˆ×
        //ýˆ«Š± ‰œ‚‚Šž ˜«ž
        CheckSelectedContract;
        _Contract.Reset;
        _Contract.SetRange("User ID Filter", UserId);
        _Contract.SetRange("Selected Contract", true);
        _Contract.SetRange("Date Filter", 0D, WorkDate);
        if _Contract.FindSet then begin
            repeat

                //°•Ô ˜«ž‹Ï—¸
                Validate_Common(_Contract, _ErrorIndex, _ErrorList);

                //‚Š ˜«ž ‹Ï—¸
                _Contract.CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

                if (_Contract."Non-Pay. General Amount" = 0) and
                   (_Contract."Non-Pay. Land. Arc. Amount" = 0) then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG010, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name",
                                                                  _Contract.FieldCaption("Non-Pay. General Amount"),
                                                                  _Contract.FieldCaption("Non-Pay. Land. Arc. Amount")), _ErrorList);

            until _Contract.Next = 0;
            exit(ShowErrorMessage(_ErrorIndex, _ErrorList));
        end else
            Error(MSG011);
    end;


    procedure Printing_InformationAbove()
    var
        _CustomReportLayout: Record "Custom Report Layout";
        _ArrIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin

        if PrintingValidate_InformationAbove then begin

            _CustomReportLayout.Reset;
            _CustomReportLayout.SetRange("Report ID", REPORT::"DK_Information Above");
            _CustomReportLayout.SetRange("Printing Use", true);
            if _CustomReportLayout.FindSet then
                _CustomReportLayout.RunCustomReport
            else
                Error(MSG003, _CustomReportLayout.TableCaption);

        end;
    end;

    local procedure PrintingValidate_ReminderNotice(): Boolean
    var
        _Contract: Record DK_Contract;
        _ErrorIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin
        //“´×Œ¡ - —¹‘÷Ž˜‚‹
        //ýˆ«Š± ‰œ‚‚Šž ˜«ž

        CheckSelectedContract;

        _Contract.Reset;
        _Contract.SetRange("User ID Filter", UserId);
        _Contract.SetRange("Selected Contract", true);
        if _Contract.FindSet then begin
            repeat

                //°•Ô ˜«ž‹Ï—¸
                Validate_Common(_Contract, _ErrorIndex, _ErrorList);

                _Contract.CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");
                //‚Š ˜«ž ‹Ï—¸
                if (_Contract."Non-Pay. General Amount" = 0) and
                   (_Contract."Non-Pay. Land. Arc. Amount" = 0) then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG010, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name",
                                                                  _Contract.FieldCaption("Non-Pay. General Amount"),
                                                                  _Contract.FieldCaption("Non-Pay. Land. Arc. Amount")), _ErrorList);

            until _Contract.Next = 0;

            exit(ShowErrorMessage(_ErrorIndex, _ErrorList));
        end else
            Error(MSG011);
    end;


    procedure Printing_ReminderNotice()
    var
        _CustomReportLayout: Record "Custom Report Layout";
        _ArrIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin

        if PrintingValidate_ReminderNotice then begin

            _CustomReportLayout.Reset;
            _CustomReportLayout.SetRange("Report ID", REPORT::"DK_Reminder - Notice");
            _CustomReportLayout.SetRange("Printing Use", true);
            if _CustomReportLayout.FindSet then
                _CustomReportLayout.RunCustomReport
            else
                Error(MSG003, _CustomReportLayout.TableCaption);

        end;
    end;

    local procedure PrintingValidate_ReminderChangeLocation(): Boolean
    var
        _Contract: Record DK_Contract;
        _ErrorIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin
        //“´×Œ¡ - º”íŠ»µ
        //ýˆ«Š± ‰œ‚‚Šž ˜«ž
        CheckSelectedContract;

        _Contract.Reset;
        _Contract.SetRange("User ID Filter", UserId);
        _Contract.SetRange("Selected Contract", true);
        if _Contract.FindSet then begin
            repeat
                _Contract.CalcFields("Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");
                //°•Ô ˜«ž‹Ï—¸
                Validate_Common(_Contract, _ErrorIndex, _ErrorList);

                //‚Š ˜«ž ‹Ï—¸
                if (_Contract."Non-Pay. General Amount" = 0) and
                   (_Contract."Non-Pay. Land. Arc. Amount" = 0) then
                    AddErrorMessage(_ErrorIndex, StrSubstNo(MSG010, _Contract."No.",
                                                                  _Contract.FieldCaption("Main Customer Name"),
                                                                  _Contract."Main Customer Name",
                                                                  _Contract.FieldCaption("Non-Pay. General Amount"),
                                                                  _Contract.FieldCaption("Non-Pay. Land. Arc. Amount")), _ErrorList);
                if _Contract."Before Cemetery Code" = '' then
                    Error(MSG004, _Contract."No.", _Contract.FieldCaption("Before Cemetery Code"));

            until _Contract.Next = 0;

            exit(ShowErrorMessage(_ErrorIndex, _ErrorList));
        end else
            Error(MSG011);
    end;


    procedure Printing_ReminderChangeLocation()
    var
        _CustomReportLayout: Record "Custom Report Layout";
        _ArrIndex: Integer;
        _ErrorList: array[60000] of Text[250];
    begin

        if PrintingValidate_ReminderChangeLocation then begin

            _CustomReportLayout.Reset;
            _CustomReportLayout.SetRange("Report ID", REPORT::"DK_Reminder - Change Location");
            _CustomReportLayout.SetRange("Printing Use", true);
            if _CustomReportLayout.FindSet then
                _CustomReportLayout.RunCustomReport
            else
                Error(MSG003, _CustomReportLayout.TableCaption);

        end;
    end;


    procedure AddErrorMessage(var pErrorIndex: Integer; pErrorMsg: Text[250]; var pErrorList: array[60000] of Text[250])
    begin
        //Generating an error array

        if pErrorIndex < 60000 then begin
            pErrorIndex += 1;
            pErrorList[pErrorIndex] := pErrorMsg;
        end;
    end;

    local procedure ShowErrorMessage(var pErrorIndex: Integer; var pErrorList: array[60000] of Text[250]): Boolean
    var
        _ErrorMessage: Page "DK_Error Message";
    begin

        if pErrorIndex > 0 then begin
            Clear(_ErrorMessage);
            _ErrorMessage.LookupMode(true);
            _ErrorMessage.SetErrorData(pErrorIndex, pErrorList);
            _ErrorMessage.RunModal;
            exit(false);
        end;

        exit(true);
    end;
}

