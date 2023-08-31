codeunit 50028 "DK_CRM Data Interlink"
{
    // *DK32 : 20200715
    //   - Add Function : InboundContract
    // 
    // #2130 : 20200831
    //   - Modify Function: OutboundContract
    // 
    // DK34 : 20201019
    //   - Modify Function: InboundContract, OutboundContract
    // 
    // DK35: 20210120
    //   - Add Function: InboundFriendsAndRelatives, CheckFriendsRelModified, OutboundFriendsRel
    //   - Modify Function: InboundContract


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'Only open contracts can be deleted. Current Status:%1';
        MSG002: Label 'This contract document is %2 %1 in ERP. CRM cannot change %1 in this contract to %3.';
        MSG003: Label 'The current contract %1 is %2. The %4 %3 in the contract cannot be changed to %5.';


    procedure InboundCustomer(var pRec: Record "DK_Interlink Cus. with CRM Log"; SocialSecurityNo: Text[20]): Boolean
    var
        _Customer: Record DK_Customer;
        _ChangedCustomerHistory: Record "DK_Changed Customer History";
    begin

        if pRec."Record Del" then begin
            if _Customer.Get(pRec."Customer No.") then
                _Customer.Status := _Customer.Status::Open;
            _Customer.Modify;

            _Customer.Delete(true);
        end else begin

            if _Customer.Get(pRec."Customer No.") then begin

                _Customer.Status := _Customer.Status::Open;
                _Customer.Modify;

                _Customer.Validate(Name, pRec.Name);
                _Customer."Post Code" := pRec."Post Code";
                _Customer.Address := pRec.Address;
                _Customer."Address 2" := pRec."Address 2";
                _Customer."Phone No." := pRec."Phone No.";
                _Customer.Type := pRec.Type;
                _Customer."E-mail" := pRec."E-mail";
                _Customer.Birthday := pRec.Birthday;
                _Customer.Gender := pRec.Gender;
                _Customer."Company Post Code" := pRec."Company Post Code";
                _Customer."Company Address" := pRec."Company Address";
                _Customer."Company Address 2" := pRec."Company Address 2";
                _Customer."Mobile No." := pRec."Mobile No.";
                _Customer."VAT Registration No." := pRec."VAT Registration No.";
                _Customer.Memo := pRec.Memo;
                _Customer."Personal Data" := pRec."Personal Data";
                _Customer."Marketing SMS" := pRec."Marketing SMS";
                _Customer."Marketing Phone" := pRec."Marketing Phone";
                _Customer."Marketing E-Mail" := pRec."Marketing E-Mail";
                _Customer."Personal Data Third Party" := pRec."Personal Data Third Party";
                _Customer."Personal Data Referral" := pRec."Personal Data Referral";
                _Customer."Personal Data Concu. Date" := pRec."Personal Data Concu. Date";


            end else begin
                _Customer.Init;
                _Customer."No." := pRec."Customer No.";
                _Customer.Name := pRec.Name;
                _Customer."Post Code" := pRec."Post Code";
                _Customer.Address := pRec.Address;
                _Customer."Address 2" := pRec."Address 2";
                _Customer."Phone No." := pRec."Phone No.";
                _Customer.Type := pRec.Type;
                _Customer."E-mail" := pRec."E-mail";
                _Customer.Birthday := pRec.Birthday;
                _Customer.Gender := pRec.Gender;
                _Customer."Company Post Code" := pRec."Company Post Code";
                _Customer."Company Address" := pRec."Company Address";
                _Customer."Company Address 2" := pRec."Company Address 2";
                _Customer."Mobile No." := pRec."Mobile No.";
                _Customer."VAT Registration No." := pRec."VAT Registration No.";
                _Customer.Memo := pRec.Memo;
                _Customer."Personal Data" := pRec."Personal Data";
                _Customer."Marketing SMS" := pRec."Marketing SMS";
                _Customer."Marketing Phone" := pRec."Marketing Phone";
                _Customer."Marketing E-Mail" := pRec."Marketing E-Mail";
                _Customer."Personal Data Third Party" := pRec."Personal Data Third Party";
                _Customer."Personal Data Referral" := pRec."Personal Data Referral";
                _Customer."Personal Data Concu. Date" := pRec."Personal Data Concu. Date";
                _Customer.Insert(true);
            end;

            _ChangedCustomerHistory.CheckChange(_Customer);

            _Customer.SetSSN(SocialSecurityNo);
            _Customer.Status := _Customer.Status::Released;
            _Customer.Modify;

            if SocialSecurityNo <> '' then begin
                _Customer.CalcFields("SSN Encyption");
                pRec."SSN Encyption" := _Customer."SSN Encyption";
            end;
        end;

        exit(true);
    end;


    procedure InboundContract(var pRec: Record "DK_Interlink Con. with CRM Log"): Boolean
    var
        _Contract: Record DK_Contract;
        _ContractType: Option;
        _AdminExpOption: Option;
        _ContractMgt: Codeunit "DK_Contract Mgt.";
    begin

        if pRec."Record Del" then begin
            if _Contract.Get(pRec."Contract No.") then begin
                if _Contract.Status = _Contract.Status::Open then begin
                    _Contract.Delete(true)
                end else begin
                    Error(MSG001, _Contract.Status::Open);
                end;
            end;
        end else begin
            if not _Contract.Get(pRec."Contract No.") then begin
                _Contract.Init;
                _Contract."No." := pRec."Contract No.";
                _Contract.Validate("Contract Date", DT2Date(pRec."Contract Date"));

                if pRec."CRM Contract Type" <> '' then begin
                    ConvertCRMContractTypeToERP(pRec."CRM Contract Type", _ContractType);
                    _Contract.Validate("Contract Type", _ContractType);
                end;
                _Contract.Validate("Group Contract No.", pRec."Group Contract No.");

                _Contract.Validate("Cemetery Code", pRec."Cemetery Code");

                Clear(_ContractMgt);
                _ContractMgt.ChangeCemeteryCode(_Contract."No.", _Contract.Status, '', pRec."Cemetery Code");

                _Contract.Validate("Main Customer No.", pRec."Main Customer No.");
                _Contract.Validate("Customer No. 2", pRec."Customer No. 2");
                _Contract.Validate("Customer No. 3", pRec."Customer No. 3");

                if pRec."CRM Admin. Expense Option" <> '' then begin
                    ConvertCRMAdminExpenseOptionToERP(pRec."CRM Admin. Expense Option", _AdminExpOption);
                    _Contract.Validate("Admin. Expense Option", _AdminExpOption);
                end;
                _Contract."Supervise No." := pRec."Supervise No.";
                _Contract."Management Unit" := pRec."Management Unit";



                _Contract."Cemetery Amount" := pRec."Cemetery Amount";
                _Contract."Cemetery Class Dis. Rate" := pRec."Cemetery Class Dis. Rate";
                _Contract."Cemetery Class Discount" := pRec."Cemetery Class Discount";
                _Contract."Cemetery Discount" := pRec."Cemetery Discount";
                _Contract."Bury Amount" := pRec."Bury Amount";
                _Contract."General Amount" := pRec."General Amount";
                _Contract."Landscape Arc. Amount" := pRec."Landscape Arc. Amount";
                _Contract."Sales Amount" := pRec."Sales Amount";
                _Contract."Etc. Amount" := pRec."Etc. Amount";
                _Contract."Etc. Discount" := pRec."Etc. Discount";
                _Contract."Allow Ston" := pRec."Etc. Amount" <> 0;

                _Contract."Remaining Due Date" := DT2Date(pRec."Remaining Due Date");
                _Contract."Alarm Period 1" := DT2Date(pRec."Alarm Period 1");
                _Contract."Alarm Period 2" := DT2Date(pRec."Alarm Period 2");
                _Contract."Man. Fee hike Exemption Date" := DT2Date(pRec."Man. Fee hike Exemption Date");
                _Contract."Man. Fee Exemption Date" := DT2Date(pRec."Man. Fee Exemption Date");

                _Contract."Before Cemetery Code" := pRec."Before Cemetery No.";

                _Contract."Associate Relationship" := pRec."Associate Relationship";
                _Contract."Main Associate Name" := pRec."Associate Name";
                _Contract."Main Associate Mobile No." := pRec."Associate Mobile No.";
                _Contract."Main Associate Phone No." := pRec."Associate Phone No.";
                _Contract."Main Associate E-Mail" := pRec."Associate E-Mail";
                _Contract."Main Associate Post Code" := pRec."Associate Post Code";
                _Contract."Main Associate Address" := pRec."Associate Address";
                _Contract."Main Associate Address 2" := pRec."Associate Address 2";

                // >> DK34
                /*
                _Contract."Main Kinsman Name" := pRec."Main Kinsman Name";
                _Contract."Main Kinsman Mobile No." := pRec."Main Kinsman Mobile No.";
                _Contract."Main Kinsman Phone No." := pRec."Main Kinsman Phone No.";
                _Contract."Main Kinsman E-Mail" := pRec."Main Kinsman E-Mail";
                _Contract."Main Kinsman Post Code" := pRec."Main Kinsman Post Code";
                _Contract."Main Kinsman Address" := pRec."Main Kinsman Address";
                _Contract."Main Kinsman Address 2" := pRec."Main Kinsman Address 2";
                _Contract."Main Kinsman Relationship" := pRec."Main Kinsman Relationship";

                _Contract."Sub Kinsman Name" := pRec."Sub Kinsman Name";
                _Contract."Sub Kinsman Mobile No." := pRec."Sub Kinsman Mobile No.";
                _Contract."Sub Kinsman Phone No." := pRec."Sub Kinsman Phone No.";
                _Contract."Sub Kinsman E-Mail" := pRec."Sub Kinsman E-Mail";
                _Contract."Sub Kinsman Post Code" := pRec."Sub Kinsman Post Code";
                _Contract."Sub Kinsman Address" := pRec."Sub Kinsman Address";
                _Contract."Sub Kinsman Address 2" := pRec."Sub Kinsman Address 2";
                _Contract."Sub Kinsman Relationship" := pRec."Sub Kinsman Relationship";
                */
                // <<

                _Contract.Validate("CRM SalesPerson Code", pRec."CRM SalesPerson Code");
                _Contract.Validate("CRM External Sales Code", pRec."CRM External Sales Code");
                _Contract.Validate("CRM Funeral Hall Code", pRec."CRM Funeral Hall Code");
                _Contract.Validate("CRM Funeral Service Code", pRec."CRM Funeral Service Code");
                _Contract.Validate("CRM Channel Vendor No.", pRec."CRM Channel Vendor No.");
                _Contract."CRM Sales Type Seq" := pRec."CRM Sales Type Seq";
                _Contract."CRM Key" := pRec."CRM Key";

                _Contract.SetWorkMemo(pRec.Memo);
                _Contract.CalcAmount;

                _Contract.Status := pRec.Status;
                _Contract.Insert;
            end else begin

                if _Contract.Status <> pRec.Status then begin
                    case _Contract.Status of
                        _Contract.Status::Open,
                        _Contract.Status::FullPayment,
                        _Contract.Status::Revocation:
                            begin
                                Error(MSG002, _Contract.FieldCaption(Status),
                                              _Contract.Status,
                                              pRec.Status);
                            end;
                        _Contract.Status::Reservation:
                            begin
                                if (pRec.Status in [pRec.Status::Contract, pRec.Status::Revocation]) then
                                    Error(MSG002, _Contract.FieldCaption(Status),
                                                  _Contract.Status,
                                                  pRec.Status);
                            end;
                        _Contract.Status::Contract:
                            begin
                                if (pRec.Status in [pRec.Status::Open, pRec.Status::Contract, pRec.Status::Revocation]) then
                                    Error(MSG002, _Contract.FieldCaption(Status),
                                                  _Contract.Status,
                                                  pRec.Status);
                            end;
                    end;
                end;


                if _Contract.Status in [_Contract.Status::Open, _Contract.Status::Reservation] then begin

                    _Contract.Validate("Contract Date", DT2Date(pRec."Contract Date"));

                    if _Contract."Cemetery Code" <> pRec."Cemetery Code" then begin
                        //CLEAR(_ContractMgt);
                        //_ContractMgt.ChangeCemeteryCode(_Contract."No.",_Contract.Status,_Contract."Cemetery Code", pRec."Cemetery Code");

                        _Contract.Validate("Cemetery Code", pRec."Cemetery Code");
                        UpdatePaymentReceiptCemeteryCode(_Contract."No.", _Contract."Cemetery Code", _Contract."Cemetery No.");
                    end;

                    _Contract.Validate("Main Customer No.", pRec."Main Customer No.");
                    _Contract.Validate("Customer No. 2", pRec."Customer No. 2");
                    _Contract.Validate("Customer No. 3", pRec."Customer No. 3");


                    if pRec."CRM Contract Type" <> '' then begin
                        ConvertCRMContractTypeToERP(pRec."CRM Contract Type", _ContractType);
                        _Contract.Validate("Contract Type", _ContractType);
                    end;
                    _Contract.Validate("Group Contract No.", pRec."Group Contract No.");

                    if pRec."CRM Admin. Expense Option" <> '' then begin
                        ConvertCRMAdminExpenseOptionToERP(pRec."CRM Admin. Expense Option", _AdminExpOption);
                        _Contract.Validate("Admin. Expense Option", _AdminExpOption);
                    end;

                    _Contract."Supervise No." := pRec."Supervise No.";
                    _Contract."Management Unit" := pRec."Management Unit";

                    _Contract."Cemetery Amount" := pRec."Cemetery Amount";
                    _Contract."Cemetery Class Dis. Rate" := pRec."Cemetery Class Dis. Rate";
                    _Contract."Cemetery Class Discount" := pRec."Cemetery Class Discount";
                    _Contract."Cemetery Discount" := pRec."Cemetery Discount";
                    _Contract."Bury Amount" := pRec."Bury Amount";
                    _Contract."General Amount" := pRec."General Amount";
                    _Contract."Landscape Arc. Amount" := pRec."Landscape Arc. Amount";
                    _Contract."Sales Amount" := pRec."Sales Amount";
                    _Contract."Etc. Amount" := pRec."Etc. Amount";
                    _Contract."Etc. Discount" := pRec."Etc. Discount";
                    _Contract."Allow Ston" := pRec."Etc. Amount" <> 0;

                    _Contract."Remaining Due Date" := DT2Date(pRec."Remaining Due Date");
                    _Contract."Alarm Period 1" := DT2Date(pRec."Alarm Period 1");
                    _Contract."Alarm Period 2" := DT2Date(pRec."Alarm Period 2");
                    _Contract."Man. Fee hike Exemption Date" := DT2Date(pRec."Man. Fee hike Exemption Date");
                    _Contract."Man. Fee Exemption Date" := DT2Date(pRec."Man. Fee Exemption Date");

                    _Contract."Before Cemetery Code" := pRec."Before Cemetery No.";
                    _Contract."Associate Relationship" := pRec."Associate Relationship";
                    _Contract."Associate Name" := pRec."Associate Name";
                    _Contract."Associate Mobile No." := pRec."Associate Mobile No.";
                    _Contract."Associate Phone No." := pRec."Associate Phone No.";
                    _Contract."Associate E-Mail" := pRec."Associate E-Mail";
                    _Contract."Associate Post Code" := pRec."Associate Post Code";
                    _Contract."Associate Address" := pRec."Associate Address";
                    _Contract."Associate Address 2" := pRec."Associate Address 2";

                    // >>DK34
                    /*
                    _Contract."Main Kinsman Name" := pRec."Main Kinsman Name";
                    _Contract."Main Kinsman Mobile No." := pRec."Main Kinsman Mobile No.";
                    _Contract."Main Kinsman Phone No." := pRec."Main Kinsman Phone No.";
                    _Contract."Main Kinsman E-Mail" := pRec."Main Kinsman E-Mail";
                    _Contract."Main Kinsman Post Code" := pRec."Main Kinsman Post Code";
                    _Contract."Main Kinsman Address" := pRec."Main Kinsman Address";
                    _Contract."Main Kinsman Address 2" := pRec."Main Kinsman Address 2";
                    _Contract."Main Kinsman Relationship" := pRec."Main Kinsman Relationship";

                    _Contract."Sub Kinsman Name" := pRec."Sub Kinsman Name";
                    _Contract."Sub Kinsman Mobile No." := pRec."Sub Kinsman Mobile No.";
                    _Contract."Sub Kinsman Phone No." := pRec."Sub Kinsman Phone No.";
                    _Contract."Sub Kinsman E-Mail" := pRec."Sub Kinsman E-Mail";
                    _Contract."Sub Kinsman Post Code" := pRec."Sub Kinsman Post Code";
                    _Contract."Sub Kinsman Address" := pRec."Sub Kinsman Address";
                    _Contract."Sub Kinsman Address 2" := pRec."Sub Kinsman Address 2";
                    _Contract."Sub Kinsman Relationship" := pRec."Sub Kinsman Relationship";
                    */
                    // <<

                    _Contract.Validate("CRM SalesPerson Code", pRec."CRM SalesPerson Code");
                    _Contract.Validate("CRM External Sales Code", pRec."CRM External Sales Code");
                    _Contract.Validate("CRM Funeral Hall Code", pRec."CRM Funeral Hall Code");
                    _Contract.Validate("CRM Funeral Service Code", pRec."CRM Funeral Service Code");
                    _Contract.Validate("CRM Channel Vendor No.", pRec."CRM Channel Vendor No.");
                    _Contract."CRM Sales Type Seq" := pRec."CRM Sales Type Seq";
                    _Contract."CRM Key" := pRec."CRM Key";

                    _Contract.SetWorkMemo(pRec.Memo);

                    _Contract.CalcAmount;

                    _Contract.Status := pRec.Status;
                    _Contract."Last Date Modified" := CurrentDateTime;
                    _Contract."Last Modified Person" := UserId;
                    _Contract.Modify(false);
                end else begin

                    _Contract.Validate("Main Customer No.", pRec."Main Customer No.");
                    _Contract.Validate("Customer No. 2", pRec."Customer No. 2");
                    _Contract.Validate("Customer No. 3", pRec."Customer No. 3");

                    _Contract."Supervise No." := pRec."Supervise No.";
                    _Contract."Management Unit" := pRec."Management Unit";

                    _Contract."Remaining Due Date" := DT2Date(pRec."Remaining Due Date");
                    _Contract."Alarm Period 1" := DT2Date(pRec."Alarm Period 1");
                    _Contract."Alarm Period 2" := DT2Date(pRec."Alarm Period 2");
                    _Contract."Man. Fee hike Exemption Date" := DT2Date(pRec."Man. Fee hike Exemption Date");
                    _Contract."Man. Fee Exemption Date" := DT2Date(pRec."Man. Fee Exemption Date");

                    if _Contract.Status <> _Contract.Status::FullPayment then begin

                        if _Contract."Cemetery Code" <> pRec."Cemetery Code" then begin
                            //CLEAR(_ContractMgt);
                            //_ContractMgt.ChangeCemeteryCode(_Contract."No.",_Contract.Status,_Contract."Cemetery Code", pRec."Cemetery Code");
                            _Contract.Validate("Cemetery Code", pRec."Cemetery Code");
                            UpdatePaymentReceiptCemeteryCode(_Contract."No.", _Contract."Cemetery Code", _Contract."Cemetery No.");
                        end;
                        _Contract."Cemetery Amount" := pRec."Cemetery Amount";
                        _Contract."Cemetery Class Dis. Rate" := pRec."Cemetery Class Dis. Rate";
                        _Contract."Cemetery Class Discount" := pRec."Cemetery Class Discount";
                        _Contract."Cemetery Discount" := pRec."Cemetery Discount";
                        _Contract."Bury Amount" := pRec."Bury Amount";
                        _Contract."General Amount" := pRec."General Amount";
                        _Contract."Landscape Arc. Amount" := pRec."Landscape Arc. Amount";
                        _Contract."Sales Amount" := pRec."Sales Amount";
                        _Contract."Etc. Amount" := pRec."Etc. Amount";
                        _Contract."Etc. Discount" := pRec."Etc. Discount";
                        _Contract."Allow Ston" := pRec."Etc. Amount" <> 0;
                        _Contract.CalcAmount;
                    end else begin
                        pRec.CalcFields("Cemetery No.");
                        if _Contract."Cemetery Code" <> pRec."Cemetery Code" then
                            Error(MSG003, _Contract.FieldCaption(Status),
                                          _Contract.Status,
                                          _Contract."Cemetery No.",
                                          pRec.FieldCaption("Cemetery No."),
                                          pRec."Cemetery No.");
                    end;

                    _Contract."Associate Name" := pRec."Associate Name";
                    _Contract."Associate Mobile No." := pRec."Associate Mobile No.";
                    _Contract."Associate Phone No." := pRec."Associate Phone No.";
                    _Contract."Associate E-Mail" := pRec."Associate E-Mail";
                    _Contract."Associate Post Code" := pRec."Associate Post Code";
                    _Contract."Associate Address" := pRec."Associate Address";
                    _Contract."Associate Address 2" := pRec."Associate Address 2";

                    // >>DK34
                    /*
                    _Contract."Main Kinsman Name" := pRec."Main Kinsman Name";
                    _Contract."Main Kinsman Mobile No." := pRec."Main Kinsman Mobile No.";
                    _Contract."Main Kinsman Phone No." := pRec."Main Kinsman Phone No.";
                    _Contract."Main Kinsman E-Mail" := pRec."Main Kinsman E-Mail";
                    _Contract."Main Kinsman Post Code" := pRec."Main Kinsman Post Code";
                    _Contract."Main Kinsman Address" := pRec."Main Kinsman Address";
                    _Contract."Main Kinsman Address 2" := pRec."Main Kinsman Address 2";
                    _Contract."Main Kinsman Relationship" := pRec."Main Kinsman Relationship";

                    _Contract."Sub Kinsman Name" := pRec."Sub Kinsman Name";
                    _Contract."Sub Kinsman Mobile No." := pRec."Sub Kinsman Mobile No.";
                    _Contract."Sub Kinsman Phone No." := pRec."Sub Kinsman Phone No.";
                    _Contract."Sub Kinsman E-Mail" := pRec."Sub Kinsman E-Mail";
                    _Contract."Sub Kinsman Post Code" := pRec."Sub Kinsman Post Code";
                    _Contract."Sub Kinsman Address" := pRec."Sub Kinsman Address";
                    _Contract."Sub Kinsman Address 2" := pRec."Sub Kinsman Address 2";
                    _Contract."Sub Kinsman Relationship" := pRec."Sub Kinsman Relationship";
                    */
                    // <<

                    _Contract.Validate("CRM SalesPerson Code", pRec."CRM SalesPerson Code");
                    _Contract.Validate("CRM External Sales Code", pRec."CRM External Sales Code");
                    _Contract.Validate("CRM Funeral Hall Code", pRec."CRM Funeral Hall Code");
                    _Contract.Validate("CRM Funeral Service Code", pRec."CRM Funeral Service Code");
                    _Contract.Validate("CRM Channel Vendor No.", pRec."CRM Channel Vendor No.");
                    _Contract."CRM Sales Type Seq" := pRec."CRM Sales Type Seq";
                    _Contract."CRM Key" := pRec."CRM Key";

                    _Contract.SetWorkMemo(pRec.Memo);
                    _Contract.Status := pRec.Status;

                    _Contract."Last Date Modified" := CurrentDateTime;
                    _Contract."Last Modified Person" := UserId;
                    _Contract.Modify(false);
                end;
            end;
        end;

        pRec."Contract Type" := _Contract."Contract Type";
        pRec."Admin. Expense Option" := _Contract."Admin. Expense Option";

        exit(true);

    end;


    procedure InboundFriendsAndRelatives(var pRec: Record "DK_Interlink Fr. with CRM Log"): Boolean
    var
        _FriendsAndRelatives: Record "DK_Friends And Relatives";
        _LastFrAndRel: Record "DK_Friends And Relatives";
    begin

        if pRec."Record Del" then begin
            _FriendsAndRelatives.Reset;
            _FriendsAndRelatives.SetRange("Contract No.", pRec."Contract No.");
            _FriendsAndRelatives.SetRange("Relation No.", pRec."Relation No.");
            if _FriendsAndRelatives.FindSet then begin
                _FriendsAndRelatives.Status := _FriendsAndRelatives.Status::Open;
                _FriendsAndRelatives.Modify;

                _FriendsAndRelatives.Delete;

            end;
        end else begin
            _FriendsAndRelatives.Reset;
            _FriendsAndRelatives.SetRange("Contract No.", pRec."Contract No.");
            _FriendsAndRelatives.SetRange("Relation No.", pRec."Relation No.");
            if _FriendsAndRelatives.FindSet then begin
                _FriendsAndRelatives.Status := _FriendsAndRelatives.Status::Open;
                _FriendsAndRelatives.Modify;

                _FriendsAndRelatives.Validate("Customer No.", pRec."Customer No.");
                _FriendsAndRelatives.Relationship := pRec.Relation;
                _FriendsAndRelatives.Modify(true);
            end else begin
                _FriendsAndRelatives.Init;
                _FriendsAndRelatives.Validate("Contract No.", pRec."Contract No.");

                _LastFrAndRel.Reset;
                _LastFrAndRel.SetRange("Contract No.", pRec."Contract No.");
                if _LastFrAndRel.FindLast then
                    _FriendsAndRelatives."Line No." := _LastFrAndRel."Line No." + 10000
                else
                    _FriendsAndRelatives."Line No." := 10000;

                _FriendsAndRelatives."Relation No." := pRec."Relation No.";
                _FriendsAndRelatives.Validate("Customer No.", pRec."Customer No.");
                _FriendsAndRelatives.Relationship := pRec.Relation;
                _FriendsAndRelatives."Creation Date" := CurrentDateTime;
                _FriendsAndRelatives."Creation Person" := UserId;
                _FriendsAndRelatives."Last Date Modified" := CurrentDateTime;
                _FriendsAndRelatives."Last Modified Person" := UserId;

                _FriendsAndRelatives."Create Organizer" := _FriendsAndRelatives."Create Organizer"::CRM;

                _FriendsAndRelatives.Insert;
            end;

            _FriendsAndRelatives.Status := _FriendsAndRelatives.Status::Release;
            _FriendsAndRelatives.Modify;
        end;

        exit(true);
    end;


    procedure InboundFriendsAndRelatives_Delete(var pRec: Record "DK_Interlink Fr. with CRM Log"): Boolean
    var
        _FriendsAndRelatives: Record "DK_Friends And Relatives";
        _LastFrAndRel: Record "DK_Friends And Relatives";
    begin

        if pRec."Record Del" then begin

            _FriendsAndRelatives.Reset;
            _FriendsAndRelatives.SetRange("Contract No.", pRec."Contract No.");
            _FriendsAndRelatives.SetRange("Relation No.", pRec."Relation No.");
            if _FriendsAndRelatives.FindSet then begin
                _FriendsAndRelatives.Status := _FriendsAndRelatives.Status::Open;
                _FriendsAndRelatives.Modify;

                _FriendsAndRelatives.Delete;

            end;

        end;
        exit(true);
    end;


    procedure CheckContractModified(pxRec: Record DK_Contract; pRec: Record DK_Contract)
    begin

        if (pxRec."Short Memo" <> pRec."Short Memo") or
           (pxRec."Before Cemetery Code" <> pRec."Before Cemetery Code") or
           (pxRec."Sended Alarm 1" <> pRec."Sended Alarm 1") or
           (pxRec."Sended Alarm 2" <> pRec."Sended Alarm 2") or
           (pxRec."Short Memo" <> pRec."Short Memo")

          then begin
            //CRM

            OutboundContract(pRec);
            //CRM
        end;
    end;


    procedure OutboundContract(var pRec: Record DK_Contract): Boolean
    var
        _ContractType: Option;
        _AdminExpOption: Option;
        _InterlinkConwithCRMLog: Record "DK_Interlink Con. with CRM Log";
        _CRMInterfaceMgt: Codeunit "DK_CRM Interface Mgt.";
        _memo: Text;
    begin

        if (CopyStr(pRec."No.", 1, 1) <> 'C') and
           (pRec."No." <> '') then begin

            //CRMí ÐŽÊœ ´„’ …Ñœ• €Ë‘¹
            with _InterlinkConwithCRMLog do begin

                "Entry No." := 0;
                "Data Type" := "Data Type"::Outbound;
                "Data Date" := Today;
                "Contract No." := pRec."No.";
                "Main Customer No." := pRec."Main Customer No.";
                "Main Customer Name" := pRec."Main Customer Name";
                "Customer No. 2" := pRec."Customer No. 2";
                "Customer Name 2" := pRec."Customer Name 2";
                "Customer No. 3" := pRec."Customer No. 3";
                "Customer Name 3" := pRec."Customer Name 3";

                //BlobField
                _memo := pRec.GetWorkMemo;
                Memo := CopyStr(_memo, 1, 1024);

                Status := pRec.Status;
                "Cemetery Code" := pRec."Cemetery Code";
                "Cemetery No." := pRec."Cemetery No.";
                "Cemetery Amount" := pRec."Cemetery Amount";
                "Deposit Amount" := pRec."Deposit Amount";
                "Contract Amount" := pRec."Contract Amount";
                "Total Contract Amount" := pRec."Total Contract Amount";
                "Rece. Remaining Amount" := pRec."Rece. Remaining Amount";
                "Deposit Receipt Date" := pRec."Deposit Receipt Date";
                "Pay. Contract Rece. Date" := pRec."Pay. Contract Rece. Date";
                "Remaining Receipt Date" := pRec."Remaining Receipt Date";

                "Contract Publish" := pRec."Contract Publish";
                "Remaining Publish" := pRec."Remaining Publish";

                "Send Alarm Date/Time 1" := pRec."Sended Alarm 1";
                "Send Alarm Date/Time 2" := pRec."Sended Alarm 2";
                "General Expiration Date" := pRec."General Expiration Date";
                "Land. Arc. Expiration Date" := pRec."Land. Arc. Expiration Date";

                //>>#2130
                pRec.CalcFields("Revocation Register");
                //<<
                "Revocation Register" := pRec."Revocation Register";
                "Revocation Date" := pRec."Revocation Date";
                "Revocation Amount" := pRec."Revocation Amount";
                "Close Amount" := pRec."Close Amount";
                /*
                "Associate Relationship" := pRec."Associate Relationship";
                "Associate Name" := pRec."Main Associate Name";
                "Associate Mobile No." := pRec."Main Associate Mobile No.";
                "Associate Phone No." := pRec."Main Associate Phone No.";
                "Associate E-Mail" := pRec."Main Associate E-Mail";
                "Associate Post Code" := pRec."Main Associate Post Code";
                "Associate Address" := pRec."Main Associate Address";
                "Associate Address 2" := pRec."Main Associate Address 2";
                */

                // >> DK34
                "Main Kinsman Name" := pRec."Main Kinsman Name";
                "Main Kinsman Mobile No." := pRec."Main Kinsman Mobile No.";
                "Main Kinsman Phone No." := pRec."Main Kinsman Phone No.";
                "Main Kinsman E-Mail" := pRec."Main Kinsman E-Mail";
                "Main Kinsman Post Code" := pRec."Main Kinsman Post Code";
                "Main Kinsman Address" := pRec."Main Kinsman Address";
                "Main Kinsman Address 2" := pRec."Main Kinsman Address 2";

                "Sub Kinsman Name" := pRec."Sub Kinsman Name";
                "Sub Kinsman Mobile No." := pRec."Sub Kinsman Mobile No.";
                "Sub Kinsman Phone No." := pRec."Sub Kinsman Phone No.";
                "Sub Kinsman E-Mail" := pRec."Sub Kinsman E-Mail";
                "Sub Kinsman Post Code" := pRec."Sub Kinsman Post Code";
                "Sub Kinsman Address" := pRec."Sub Kinsman Address";
                "Sub Kinsman Address 2" := pRec."Sub Kinsman Address 2";
                // <<

                "Before Cemetery No." := pRec."Before Cemetery Code";
                Insert(true);

            end;

            //Run Contract
            _CRMInterfaceMgt.SendCRM_Contract;
        end;

    end;


    procedure ConvertCRMContractTypeToERP(pCRMContractType: Text[30]; var pContractType: Option)
    var
        _Contract: Record DK_Contract;
    begin

        case pCRMContractType of
            '100000000':
                pContractType := _Contract."Contract Type"::General;
            '100000001':
                pContractType := _Contract."Contract Type"::Group;
            '100000002':
                pContractType := _Contract."Contract Type"::Sub;
        end;
    end;


    procedure ConvertCRMAdminExpenseOptionToERP(pCRMAdminExpenseOption: Text[30]; var pAdminExpenseOption: Option)
    var
        _Contract: Record DK_Contract;
    begin

        case pCRMAdminExpenseOption of
            '100000000':
                pAdminExpenseOption := _Contract."Admin. Expense Option"::"Per Contract";
            '100000001':
                pAdminExpenseOption := _Contract."Admin. Expense Option"::"Per Group";
        end;
    end;


    procedure ConvertERPContractTypeToCRM(pContractType: Option): Text[30]
    var
        _Contract: Record DK_Contract;
    begin

        case pContractType of
            _Contract."Contract Type"::General:
                exit('100000000');
            _Contract."Contract Type"::Group:
                exit('100000001');
            _Contract."Contract Type"::Sub:
                exit('100000002');
        end;
    end;


    procedure ConvertERPAdminExpenseOptionToCRM(pAdminExpenseOption: Option): Text[30]
    var
        _Contract: Record DK_Contract;
    begin

        case pAdminExpenseOption of
            _Contract."Admin. Expense Option"::"Per Contract":
                exit('100000000');
            _Contract."Admin. Expense Option"::"Per Group":
                exit('100000001');
        end;
    end;


    procedure ConvertERPStatusToCRM(pStatus: Option): Text[30]
    var
        _Contract: Record DK_Contract;
    begin

        case pStatus of
            _Contract.Status::Open:
                exit('100000000');
            _Contract.Status::Reservation:
                exit('100000001');
            _Contract.Status::Contract:
                exit('100000002');
            _Contract.Status::FullPayment:
                exit('100000003');
            _Contract.Status::Revocation:
                exit('100000004');

        end;
    end;

    local procedure UpdatePaymentReceiptCemeteryCode(pContractNo: Code[20]; pCemeteryCode: Code[20]; pCemeteryName: Text[20])
    var
        _PayRecDoc: Record "DK_Payment Receipt Document";
    begin

        if pContractNo <> '' then begin
            _PayRecDoc.Reset;
            _PayRecDoc.SetRange("Contract No.", pContractNo);
            if _PayRecDoc.FindSet then begin
                _PayRecDoc.ModifyAll("Cemetery Code", pCemeteryCode, false);
                _PayRecDoc.ModifyAll("Cemetery No.", pCemeteryName, false);
            end;
        end;
    end;


    procedure CheckFriendsRelModified(pxRec: Record "DK_Friends And Relatives"; pRec: Record "DK_Friends And Relatives"; pDel: Boolean)
    begin

        if (pxRec."Customer No." <> pRec."Customer No.") or
          (pxRec.Relationship <> pRec.Relationship) then begin
            //CRM

            OutboundFriendsRel(pRec, pDel);
            //CRM
        end;
    end;


    procedure OutboundFriendsRel(var pRec: Record "DK_Friends And Relatives"; pDel: Boolean): Boolean
    var
        _CRMInterfaceMgt: Codeunit "DK_CRM Interface Mgt.";
    begin

        //CRMí ÐŽÊœ ´„’ ˆˆ
        if (CopyStr(pRec."Contract No.", 1, 1) <> 'C') and
           (pRec."Contract No." <> '') then begin


            //Run Contract
            _CRMInterfaceMgt.InterlinkFrwithCRMLogRecord(pRec, pDel);
        end;
    end;
}

