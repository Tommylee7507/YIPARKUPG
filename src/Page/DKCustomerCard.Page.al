page 50009 "DK_Customer Card"
{
    // 
    // #2194: 20201005
    //   - Add Action: Change Loge Entry
    // 
    // DK34: 20201021
    //   - Add Field: "Request Del", "Request DateTime", "Request Person"
    //   - Add Action: Action56, Action57
    //     : 20201026
    //   - Add Field: "Reagree Prov. Info Send Date"
    //     : 20201027
    //   - Add Action: <Page DK_Rea. Prov. Send List>
    //     : 20201130
    //   - Add Field: "Address Unknown"

    Caption = 'Customer Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control51)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                        Importance = Additional;

                        trigger OnAssistEdit()
                        begin
                            if Rec.AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field(Name; Rec.Name)
                    {
                    }
                    field(Type; Rec.Type)
                    {

                        trigger OnValidate()
                        begin
                            if xRec.Type <> Rec.Type then begin
                                if not CheckCompInforData then
                                    ActivateFields;
                            end;
                        end;
                    }
                }
                group(Control50)
                {
                    ShowCaption = false;
                    field(Memo; Rec.Memo)
                    {
                        MultiLine = true;
                    }
                    field(Status; Rec.Status)
                    {
                    }
                }
            }
            group(Contact)
            {
                Caption = 'Contact';
                field("Mobile No."; Rec."Mobile No.")
                {
                    ExtendedDatatype = PhoneNo;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ExtendedDatatype = PhoneNo;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ExtendedDatatype = EMail;
                }
                group(Control14)
                {
                    ShowCaption = false;
                    field("Post Code"; Rec."Post Code")
                    {

                        trigger OnAssistEdit()
                        begin
                            AddressLookup;
                        end;
                    }
                    field(Address; Rec.Address)
                    {
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                    }
                }
            }
            group("Individual Information")
            {
                Caption = 'Individual Information';
                Editable = Rec.Type = Rec.type::Individual;
                Visible = Rec.Type = Rec.type::Individual;
                field(SSN; SSN)
                {
                    Caption = 'Social Security No.';

                    trigger OnDrillDown()
                    begin
                        SSN := Rec.GetSSNSSNCalculated;
                    end;

                    trigger OnValidate()
                    var
                        _Year: Integer;
                        _Month: Integer;
                        _Day: Integer;
                        _Gender: Integer;
                        _CommFun: Codeunit "DK_Common Function";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        if (SSN <> '') then begin
                            SSN := UpperCase(SSN);

                            if Rec.Type = Rec.Type::Individual then begin
                                //IF "Social Security No." <> xRec."Social Security No." THEN
                                Rec.SocialSecurityValidation(SSN);

                                if StrLen(SSN) <> 14 then
                                    Error(MSG002, Rec.FieldCaption("Social Security No."), StrLen(SSN));


                                if _CommFun.CheckDigitSSNo(SSN) then begin

                                    Evaluate(_Year, CopyStr(SSN, 1, 2));
                                    Evaluate(_Month, CopyStr(SSN, 3, 2));
                                    Evaluate(_Day, CopyStr(SSN, 5, 2));

                                    Evaluate(_Gender, CopyStr(SSN, 8, 1));
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


                                        Rec.Birthday := DMY2Date(_Day, _Month, _Year);

                                        case _Gender of
                                            1, 3, 5, 7, 9:
                                                Rec.Gender := Rec.Gender::Male;
                                            2, 4, 6, 8, 0:
                                                Rec.Gender := Rec.Gender::Female;
                                        end;
                                    end else
                                        Error(MSG004, CopyStr(SSN, 1, 6));
                                end else
                                    Error(MSG005, Rec.FieldCaption("Social Security No."));

                                //Encryption
                                SSN := Rec.SetSSN(SSN);
                            end;
                        end else begin
                            Clear(Rec."SSN Encyption");
                        end;
                    end;
                }
                field(Birthday; Rec.Birthday)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
            }
            group("Agreement on Personal Information")
            {
                Caption = 'Agreement on Personal Information';
                field("Personal Data"; Rec."Personal Data")
                {
                }
                field("Marketing SMS"; Rec."Marketing SMS")
                {
                }
                field("Marketing Phone"; Rec."Marketing Phone")
                {
                }
                field("Marketing E-Mail"; Rec."Marketing E-Mail")
                {
                }
                field("Personal Data Third Party"; Rec."Personal Data Third Party")
                {
                }
                field("Personal Data Referral"; Rec."Personal Data Referral")
                {
                }
                field("Personal Data Concu. Date"; Rec."Personal Data Concu. Date")
                {
                }
                field("Reagree Prov. Info Send Date"; Rec."Reagree Prov. Info Send Date")
                {
                }
            }
            group("Corporation Information")
            {
                Caption = 'Corporation Information';
                Editable = Rec.Type <> Rec.type::Individual;
                Visible = Rec.Type <> Rec.type::Individual;
                field("VAT Registration No."; Rec."VAT Registration No.")
                {

                    trigger OnValidate()
                    var
                        _Year: Integer;
                        _Month: Integer;
                        _Day: Integer;
                        _Gender: Integer;
                    begin
                    end;
                }
            }
            group("Company Information")
            {
                Caption = 'Company Information';
                Visible = CompVisible;
                group(Control21)
                {
                    ShowCaption = false;
                    field("Company Post Code"; Rec."Company Post Code")
                    {

                        trigger OnAssistEdit()
                        begin
                            CompAddressLookup;
                        end;
                    }
                    field("Company Address"; Rec."Company Address")
                    {
                    }
                    field("Company Address 2"; Rec."Company Address 2")
                    {
                    }
                }
            }
            group(Control57)
            {
                Caption = 'Request Delete';
                field("Request Del"; Rec."Request Del")
                {
                }
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
                {
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Create Organizer"; Rec."Create Organizer")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control20; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action36)
            {
                action(Released)
                {
                    Caption = 'Released';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _ChangedCustomerHistory: Record "DK_Changed Customer History";
                    begin

                        _ChangedCustomerHistory.CheckChange(Rec);

                        Rec.SetReleased;
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.SetReOpen;
                    end;
                }
            }
            group(Action40)
            {
                action("Change History")
                {
                    Caption = 'Change History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DK_Changed Customer History";
                    RunPageLink = "No." = FIELD("No.");
                }
                action(Contracts)
                {
                    Caption = 'Contracts';
                    Image = OpportunitiesList;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.ShowContractList(rec."No.");
                    end;
                }
                separator("#2194")
                {
                    Caption = '#2194';
                }
                action("Change Loge Entry")
                {
                    Caption = 'Change Loge Entry';
                    Image = ChangeLog;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _ChangeLogEntry: Record "Change Log Entry";
                        _DK_ChangeLogEntry: Page "DK_Change Log Entry";
                    begin

                        _ChangeLogEntry.Reset;
                        _ChangeLogEntry.FilterGroup(2);
                        _ChangeLogEntry.SetRange("Table No.", 50008);
                        _ChangeLogEntry.SetRange("Type of Change", _ChangeLogEntry."Type of Change"::Modification);
                        _ChangeLogEntry.FilterGroup(0);
                        _ChangeLogEntry.SetRange("Primary Key Field 1 Value", Rec."No.");
                        _ChangeLogEntry.SetRange("Field No.", 2);

                        Clear(_DK_ChangeLogEntry);
                        _DK_ChangeLogEntry.SetRecord(_ChangeLogEntry);
                        _DK_ChangeLogEntry.SetTableView(_ChangeLogEntry);
                        _DK_ChangeLogEntry.Run;
                    end;
                }
                action("Reagree Provide To Information List")
                {
                    Caption = 'Reagree Provide To Information List';
                    Ellipsis = true;
                    Image = ShowList;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "DK_Rea. Prov. Send List";
                    RunPageLink = "Source No." = FIELD("No.");
                }
            }
            group(Action54)
            {
                action("Request Delete")
                {
                    Caption = 'Request Delete';
                    Image = DeleteAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        _CustomerMgt: Codeunit "DK_Customer Mgt.";
                    begin
                        if Rec."No." <> '' then begin
                            _CustomerMgt.CheckCustomerWithRelate(Rec);

                            Rec.Validate("Request Del", true);
                            Rec.Modify;
                        end;
                    end;
                }
                action("Cancel Request Delete")
                {
                    Caption = 'Cancel Request Delete';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."No." <> '' then begin
                            Rec.Validate("Request Del", false);
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields;
    end;

    trigger OnAfterGetRecord()
    begin
        ActivateFields;
        SSN := Rec.GetSSN;
    end;

    trigger OnClosePage()
    begin
        //IF "Social Security No." <> '' THEN
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        RecDel := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Rec."No." <> '' then
            if (not RecDel) then
                if Rec.Status = Rec.Status::Open then begin
                    Error(MSG003, Rec.FieldCaption(Status), Rec.Status::Open, Rec.Status::Released);
                end;
    end;

    var
        SocialSecurityNo: Text[20];
        CompVisible: Boolean;
        MSG001: Label 'Company information exists. If you change to Personal, your company information will be initialized.\\Would you like to change it anyway?';
        MSG002: Label '%1 is not valid. Please enter in 13 digits. Ex) 123456-1234567, current number of digits:%2';
        MSG003: Label 'If %1 is %2, the window can not be closed. First change %1 to %3.';
        SSN: Text;
        MSG004: Label 'Birthday is not valid on the date. Value : %1';
        MSG005: Label 'The specified value %1 is not valid. Please check again.';
        RecDel: Boolean;

    local procedure ActivateFields()
    begin
        CompVisible := (Rec.Type = Rec.Type::Corporation);
    end;

    local procedure CheckCompInforData(): Boolean
    begin

        if (Rec."Company Post Code" <> '') or
           (Rec."Company Address" <> '') or
           (Rec."Company Address 2" <> '') then begin

            if not Confirm(MSG001, false) then begin
                Rec.Type := xRec.Type;
                exit(true);
            end else begin
                Rec."Company Post Code" := '';
                Rec."Company Address" := '';
                Rec."Company Address 2" := '';
            end;
        end;
    end;

    local procedure AddressLookup()
    var
        _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin

        Clear(_DK_KoreanRoadAddrMgt);
        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Rec.Address, Rec."Address 2", Rec."Post Code", _TmpText, _TmpCode);////zzz
    end;

    local procedure CompAddressLookup()
    var
        _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin

        Clear(_DK_KoreanRoadAddrMgt);
        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Rec."Company Address", Rec."Company Address 2", Rec."Company Post Code", _TmpText, _TmpCode);////zzz
    end;

    local procedure SetChangeLog()
    begin
    end;
}

