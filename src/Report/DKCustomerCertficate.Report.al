report 50014 "DK_Customer Certficate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCustomerCertficate.rdl';
    Caption = 'CustomerCertficate';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DK_SelectedCont; "DK_Selected Contract")
        {
            DataItemTableView = SORTING("USER ID", "Contract No.");
            dataitem(DK_Contract; DK_Contract)
            {
                DataItemLink = "No." = FIELD("Contract No.");
                DataItemTableView = SORTING("No.");
                column(EstateName; DK_Contract."Estate Name")
                {
                }
                column(CemNo; DK_Contract."Cemetery No.")
                {
                }
                column(CemSize; DK_Contract."Cemetery Size")
                {
                }
                column(MainCusName; DK_Contract."Main Customer Name")
                {
                }
                column(SSN; gSocialSecurityNo)
                {
                }
                column(Picture; CompanyInfo.Picture)
                {
                }
                column(Address; CompanyInfo.Address)
                {
                }
                column(Today; Format(Today, 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ'))
                {
                }
                column(DocNo; DocumentNo)
                {
                }
                column(CorpseName; CorpseName)
                {
                }
                column(CorpseGender; CorpseGender)
                {
                }
                column(CorpseRelationShip; CorpseRelationShip)
                {
                }
                column(Gender; Gender)
                {
                }
                column(Year; YearFormat)
                {
                }
                column(Month; MonthFormat)
                {
                }
                column(Day; DayFormat)
                {
                }
                column(LayingYear; LayingYear)
                {
                }
                column(LayingMonth; LayingMonth)
                {
                }
                column(LayingDay; LayingDay)
                {
                }
                column(CustomerAddress; CustomerAddress)
                {
                }
                column(CemeterySize; CemeterySize)
                {
                }
                column(CemeteryOption; CemeteryOption)
                {
                }
                column(CemeteryDigit; CemeteryDigit)
                {
                }
                column(EstateText; EstateText)
                {
                }
                column(CemeteryNoText; CemeteryNoText)
                {
                }

                trigger OnAfterGetRecord()
                var
                    _ReportPrtHisLitigation: Codeunit "DK_Report Printing";
                    _NoSeries: Code[20];
                    _NoSeriesMgt: Codeunit NoSeriesManagement;
                    _Corpse: Record DK_Corpse;
                    _Year: Integer;
                    _Month: Integer;
                    _Day: Integer;
                    _Gender: Integer;
                    _CustomerCertficateHistory: Record "DK_Customer Certficate History";
                    _Cemetery: Record DK_Cemetery;
                    _ComFun: Codeunit "DK_Common Function";
                begin
                    Clear(DocumentNo);
                    Clear(CorpseName);
                    Clear(LayingYear);
                    Clear(LayingMonth);
                    Clear(LayingDay);
                    Clear(CorpseGender);
                    Clear(CorpseRelationShip);

                    _Corpse.Reset;
                    _Corpse.SetCurrentKey("Laying Date");
                    _Corpse.SetRange("Contract No.", DK_Contract."No.");
                    _Corpse.SetRange("Move The Grave Type", false);
                    if _Corpse.FindFirst then begin
                        CorpseName := _Corpse.Name;
                        if _Corpse."Laying Date" <> 0D then begin
                            LayingYear := Date2DMY(_Corpse."Laying Date", 3);
                            LayingMonth := Date2DMY(_Corpse."Laying Date", 2);
                            LayingDay := Date2DMY(_Corpse."Laying Date", 1);
                        end;
                        if _Corpse.Gender = _Corpse.Gender::Male then
                            CorpseGender := ManMSG;

                        if _Corpse.Gender = _Corpse.Gender::Female then
                            CorpseGender := WomanMSG;

                        CorpseRelationShip := _Corpse.Relationship;
                    end;

                    Clear(gSocialSecurityNo);
                    Clear(Gender);
                    Clear(CustomerAddress);
                    if DK_Customer.Get(DK_Contract."Main Customer No.") then begin
                        gSocialSecurityNo := DK_Customer.GetSSNSSNCalculated;

                        if gSocialSecurityNo <> '' then
                            gSocialSecurityNo := CopyStr(gSocialSecurityNo, 1, 6);

                        if DK_Customer.Gender = DK_Customer.Gender::Male then
                            Gender := ManMSG;

                        if DK_Customer.Gender = DK_Customer.Gender::Female then
                            Gender := WomanMSG;

                        CustomerAddress := DK_Customer.Address + DK_Customer."Address 2";
                    end;
                    /*
                    CLEAR(gSocialSecurityNo);
                    
                      gSocialSecurityNo := UPPERCASE(gSocialSecurityNo);
                    
                      EVALUATE(_Year, COPYSTR(gSocialSecurityNo,1,2));
                      EVALUATE(_Month, COPYSTR(gSocialSecurityNo,3,2));
                      EVALUATE(_Day, COPYSTR(gSocialSecurityNo,5,2));
                    
                      EVALUATE(_Gender, COPYSTR(gSocialSecurityNo,8,1));
                    
                     //Gender
                        CASE _Gender OF
                          1,3,5,7: GenderTxt := FORMAT(DK_Customer.Gender::Male);
                          2,4,6,8: GenderTxt := FORMAT(DK_Customer.Gender::Female);
                        END;
                    */

                    //CLEAR(_NoSeriesMgt);
                    Clear(_ReportPrtHisLitigation);
                    Clear(DocumentNo);
                    //_NoSeriesMgt.InitSeries(FunctionSetup."Membership Printing Nos.",_NoSeries,WORKDATE, DocumentNo,_NoSeries);
                    _CustomerCertficateHistory.Reset;
                    _CustomerCertficateHistory.SetRange("Contract No.", DK_Contract."No.");
                    if _CustomerCertficateHistory.FindSet then
                        DocumentNo := _CustomerCertficateHistory."Document No.";
                    //IF DocumentNo = '' THEN
                    //  ERROR(MSG001);

                    _ReportPrtHisLitigation.InsertPrintingHistory(DK_Contract, DocumentNo, REPORT::"DK_Customer Certficate",
                                                                  EmployeeNo, EmployeeName, '', 0D);
                    Clear(YearFormat);
                    Clear(MonthFormat);
                    Clear(DayFormat);

                    YearFormat := Date2DMY(Today, 3);
                    MonthFormat := Date2DMY(Today, 2);
                    DayFormat := Date2DMY(Today, 1);

                    Clear(_ComFun);
                    Clear(CemeterySize);
                    Clear(CemeteryOption);
                    Clear(CemeteryDigit);
                    if _Cemetery.Get(DK_Contract."Cemetery Code") then begin
                        if _Cemetery.Size <> 0 then
                            CemeterySize := Round(_Cemetery.Size * 3.3, 0.1, '=');

                        CemeteryOption := _Cemetery."Cemetery Conf. Name";
                        CemeteryDigit := _Cemetery."Cemetery Dig. Name";
                        _ComFun.GetCemeteryNoSplit(_Cemetery."Cemetery No.", EstateText, CemeteryNoText);
                    end;

                end;

                trigger OnPreDataItem()
                var
                    _Year: Integer;
                    _Month: Integer;
                    _Day: Integer;
                    _Gender: Integer;
                begin
                end;
            }

            trigger OnPreDataItem()
            begin

                DK_SelectedCont.SetRange("USER ID", UserId);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
        SadanLbl = 'Sadan';
        CustomerCertLbl = 'CustomerCert';
        BalHaengNoLbl = 'BalHaeng';
        CemNoLbl = 'CemNo';
        JaeLbl = 'Jae';
        JiguLbl = 'Jigu';
        HoLbl = 'Ho';
        M2Lbl = 'º‚';
        SamangJalbl = 'SaMangJa';
        NameLbl = 'Name';
        GenderLbl = 'Gender';
        LayDateLbl = 'LayDate';
        ContractorLbl = 'Contractor';
        SSNlbl = 'SSN';
        AddressLbl = 'Address';
        RelatoDeadLb = 'Relationship';
        ReferenceLbl = 'Reference';
        GyuJungLbl = 'GyuJung';
        GyuJungLbl2 = 'GyuJUng2';
        JaedanLbl = 'Jaedan';
        BobInLbl = 'BobIn';
        YongInParkLbl = 'YongInPark';
        SajangLbl = 'Sajang';
        KimDongGyunLbl = 'KimDogGyun';
        CautionLbl = 'Caution';
        Sentence1Lbl = 'Sentence1';
        Sentence2Lbl = 'Sentence2';
        Sentence3Lbl = 'Sentence3';
        Sentence3Lbl2 = 'Sentence3';
        Sentence4Lbl = 'Sentence4';
        Sentence4Lbl2 = 'Sentence4';
        Sentence5Lbl = 'Sentence5';
        Sentence5Lbl2 = 'Sentence5';
        Sentence6Lbl = 'Sentence6';
        Sentence6Lbl2 = 'Sentence6';
    }

    trigger OnInitReport()
    begin
        FunctionSetup.Get;
        FunctionSetup.TestField("Membership Printing Nos.");

        Employee.GetERPUserIDEmployee(UserId, EmployeeNo, EmployeeName);

        if EmployeeNo = '' then
            Error(MSG001);
    end;

    trigger OnPreReport()
    var
        _Employee: Record DK_Employee;
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        DK_Customer: Record DK_Customer;
        CompanyInfo: Record "Company Information";
        Employee: Record DK_Employee;
        MSG001: Label 'We can not verify your employee information. Please contact your administrator to verify your employee information.';
        EmployeeNo: Code[20];
        EmployeeName: Text[50];
        DocumentNo: Code[20];
        FunctionSetup: Record "DK_Function Setup";
        CorpseName: Text;
        CorpseLayingDate: Date;
        CorpseGender: Text;
        CorpseRelationShip: Text;
        ManMSG: Label 'Man';
        WomanMSG: Label 'Woman';
        gSocialSecurityNo: Text[30];
        Gender: Text[10];
        YearFormat: Integer;
        MonthFormat: Integer;
        DayFormat: Integer;
        LayingYear: Integer;
        LayingMonth: Integer;
        LayingDay: Integer;
        CustomerAddress: Text;
        CemeterySize: Decimal;
        CemeteryOption: Text;
        CemeteryDigit: Text;
        EstateText: Text;
        CemeteryNoText: Text;
}

