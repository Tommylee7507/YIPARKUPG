report 50012 DK_CemetryLedger
{
    RDLCLayout = './src/layout/DKCemetryLedger.rdl';
    WordLayout = './src/layout/DKCemetryLedger.docx';
    Caption = 'CemetryLedger';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; DK_Corpse)
        {
            DataItemTableView = SORTING("Contract No.", "Line No.");
            column(CemNo; Header."Cemetery No.")
            {
            }
            column(LayCatName; Header."Field Work Sub Cat. Name")
            {
            }
            column(LayDate; Header."Laying Date")
            {
            }
            column(Address; Header.Address)
            {
            }
            column(Adress2; Header."Address 2")
            {
            }
            column(SSN; Header."Social Security No.")
            {
            }
            column(Name; Header.Name)
            {
            }
            column(Birthday; Format(Birthday, 0, '<Year4> - <Month,2> - <Day,2>'))
            {
            }
            column(DeathPlace; Header."Death Place")
            {
            }
            column(DeathDate; Header."Death Date")
            {
            }
            column(DeathCause; Header."Death Cause")
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(SNameValue; SName)
            {
            }
            column(SJuminNo; SJumin)
            {
            }
            column(SAddr; SAddress)
            {
            }
            column(SType; SType)
            {
            }
            column(SContactNo; SContact)
            {
            }

            trigger OnAfterGetRecord()
            var
                _SocialSecurityNo: Text[20];
                _Year: Integer;
                _Month: Integer;
                _Day: Integer;
                _Gender: Integer;
            begin
                Clear(Birthday);

                if Header."Social Security No." <> '' then begin
                    _SocialSecurityNo := Header."Social Security No.";

                    _SocialSecurityNo := UpperCase(_SocialSecurityNo);

                    Evaluate(_Year, CopyStr(_SocialSecurityNo, 1, 2));
                    Evaluate(_Month, CopyStr(_SocialSecurityNo, 3, 2));
                    Evaluate(_Day, CopyStr(_SocialSecurityNo, 5, 2));

                    Evaluate(_Gender, CopyStr(_SocialSecurityNo, 8, 1));
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

                        Birthday := DMY2Date(_Day, _Month, _Year);
                    end;
                end;


                if DK_Contract.Get(Header."Contract No.") then begin
                    if DK_Customer.Get(DK_Contract."Main Customer No.") then begin
                        SName := DK_Customer.Name;
                        SJumin := DK_Customer.GetSSNSSNCalculated();
                        SAddress := DK_Customer.Address + '' + DK_Customer."Address 2";
                        SType := Header.Relationship;
                        SContact := DK_Customer."Mobile No.";
                    end else begin
                        SName := '';
                        SJumin := '';
                        SAddress := '';
                        SType := '';
                        SContact := '';
                    end;

                end else begin
                    SName := '';
                    SJumin := '';
                    SAddress := '';
                    SType := '';
                    SContact := '';
                end;
            end;

            trigger OnPreDataItem()
            begin
                if gContractNo <> '' then
                    SetRange("Contract No.", gContractNo);
                if gLineNo <> 0 then
                    SetRange("Line No.", gLineNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(gContractNo; gContractNo)
                {
                    Caption = 'Contract No.';
                }
                field(gLineNo; gLineNo)
                {
                    Caption = 'Line No.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        CemLedgerLb = 'Cemetry Ledger';
        OrderNumLb = 'Order No.';
        BunLbl = 'Bun';
        MyoLbl = 'Myo';
        MaeJangJangLbl = 'Graveyard';
        JangSoLbl = 'Place';
        MyoJiNumLbl = 'Cemetry No.';
        MaeJangLbl = 'MaeJang';
        JongRyuLbl = 'JongRyu';
        ReportNumLbl = 'Report No.';
        LayDateLbl = 'LayDateLbl';
        LayDateLbl2 = 'LayDateLbl2';
        SaLbl = 'Sa';
        MangLbl = 'Mang';
        JaLbl = 'Ja';
        AddressLb = 'Address';
        SSNLb1 = 'SSN1';
        SSNLb2 = 'SSN2';
        NameLb = 'Name';
        BirthDateLb = 'Date of Birth';
        BirthDate2Lb = 'Date of Birth';
        DeathPlaceLb = 'Death Place';
        DeaDateLb1 = 'DDate';
        DeaDateLb2 = 'DDate2';
        DeathCauseLb1 = 'Death Cause';
        DeathCauseLb2 = 'Death Cause 2';
        SinLbl = 'Sin';
        CheongLbl = 'Cheong';
        ReltoDLb1 = 'RelationToDead';
        ReltoDLb2 = 'RelationToDead';
        ContactLb = 'Contact';
        DeadPersonPicLb = 'DeadPersonPicture';
        OtherIssueLb = 'Other Issues';
        JaeDanBobInLb = 'JaeDanBobInLb';
        YongInParkLb = 'YongInPark';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
    end;

    var
        Birthday: Date;
        CompanyInfo: Record "Company Information";
        gContractNo: Code[20];
        gLineNo: Integer;
        DK_Contract: Record DK_Contract;
        DK_Customer: Record DK_Customer;
        SName: Text;
        SJumin: Text;
        SAddress: Text;
        SType: Text;
        SContact: Text;


    procedure SetParam(pContractNo: Code[20]; pLineNo: Integer)
    begin

        gContractNo := pContractNo;
        gLineNo := pLineNo;
    end;
}

