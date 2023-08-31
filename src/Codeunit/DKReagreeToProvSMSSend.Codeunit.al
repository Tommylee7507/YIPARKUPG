codeunit 50044 "DK_Reagree To Prov. SMS Send"
{
    // 
    // // „ÏŸ ˜” ‰ÈŒÁ
    // 
    // DK34: 20201026
    //   - Create


    trigger OnRun()
    begin

        BatchDailyReagreeToProvSMSsend('');
    end;

    var
        MSG001: Label '%2 is not set on %1.';
        MSG002: Label 'The sentence is not set.';


    procedure BatchDailyReagreeToProvSMSsend(pNo: Code[20])
    var
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
        _SMS: Record DK_SMS;
        _FunctionSetup: Record "DK_Function Setup";
        _SendedSMSHistory: Record "DK_Sended SMS History";
        _Contract: Record DK_Contract;
        _BatchSMSSending: Codeunit "DK_Batch SMS Sending";
        _SMSMessage: Text;
        _ContractNo: Code[20];
    begin

        _FunctionSetup.Reset;
        if _FunctionSetup.Get then
            if _FunctionSetup."SMS Phone No." = '' then
                Error(MSG001);

        _SMS.Reset;
        _SMS.SetRange(Type, _SMS.Type::ReagreeInfo);
        if not _SMS.FindSet then
            Error(MSG002);

        _ReagreeToProvideInfo.Reset;
        _ReagreeToProvideInfo.SetFilter("No.", '<>%1', '');

        if pNo <> '' then
            _ReagreeToProvideInfo.SetRange("No.", pNo);

        _ReagreeToProvideInfo.SetFilter("Mobile No.", '<>%1', '');
        _ReagreeToProvideInfo.SetRange("Send Type", false);

        if _ReagreeToProvideInfo.FindSet then begin
            _SMS.Reset;
            _SMS.SetRange(Type, _SMS.Type::ReagreeInfo);
            repeat
                if _SMS.FindSet then begin
                    _SMSMessage := _BatchSMSSending.SetMessageType(_SMS.Type::ReagreeInfo, _SMS."Short Message", _ReagreeToProvideInfo."No.");

                    _Contract.Reset;
                    if _ReagreeToProvideInfo.Type = _ReagreeToProvideInfo.Type::Customer then
                        _Contract.SetRange("Main Customer No.", _ReagreeToProvideInfo."Source No.")
                    else
                        _Contract.SetRange("No.", _ReagreeToProvideInfo."Source No.");

                    if _Contract.FindSet then
                        _ContractNo := _Contract."No.";

                    _BatchSMSSending.SingleSendingSMS(_FunctionSetup."SMS Phone No.",
                                                      _ReagreeToProvideInfo."Mobile No.",
                                                      Format(_SMS.Type::ReagreeInfo),
                                                      _SMSMessage,
                                                      '',
                                                      '',
                                                      '',
                                                      true,
                                                      _SendedSMSHistory."Source Type"::ReagreeInfo,
                                                      _ReagreeToProvideInfo."No.",
                                                      0,
                                                      _SMS."Biz Talk Tamplate No.",
                                                      _ContractNo);


                    if _ReagreeToProvideInfo.Type = _ReagreeToProvideInfo.Type::Customer then
                        UpdatePersonalDataWithCustomer(_ReagreeToProvideInfo."Source No.")
                    else
                        UpdatePersonalDataWithRelationshipFam(_ReagreeToProvideInfo."Source No.", _ReagreeToProvideInfo."Source Line No.");

                    _ReagreeToProvideInfo."Send Date" := Today;
                    _ReagreeToProvideInfo."Send Person" := UserId;
                    _ReagreeToProvideInfo."Send Type" := true;

                    _ReagreeToProvideInfo.Modify(false);
                end;
            until _ReagreeToProvideInfo.Next = 0;
        end;
    end;

    local procedure UpdatePersonalDataWithCustomer(pSourceNo: Code[20])
    var
        _Customer: Record DK_Customer;
    begin

        _Customer.Reset;
        _Customer.SetRange("No.", pSourceNo);
        if _Customer.FindSet then begin
            // _Customer."Personal Data Concu. Date" := TODAY;
            _Customer."Reagree Prov. Info Send Date" := Today;
            _Customer."Last Date Modified" := CurrentDateTime;
            _Customer."Last Modified Person" := UserId;
            _Customer.Modify(false);
        end
    end;

    local procedure UpdatePersonalDataWithRelationshipFam(pSourceNo: Code[20]; pSourceLineNo: Integer)
    var
        _RelationshipFamily: Record "DK_Relationship Family";
    begin

        _RelationshipFamily.Reset;
        _RelationshipFamily.SetRange("Contract No.", pSourceNo);
        _RelationshipFamily.SetRange("Line No.", pSourceLineNo);
        if _RelationshipFamily.FindSet then begin
            // _RelationshipFamily."Personal Data Concu. Date" := TODAY;
            _RelationshipFamily."Reagree Prov. Info Send Date" := Today;
            _RelationshipFamily."Last Date Modified" := CurrentDateTime;
            _RelationshipFamily."Last Modified Person" := UserId;
            _RelationshipFamily.Modify(false);
        end;
    end;
}

