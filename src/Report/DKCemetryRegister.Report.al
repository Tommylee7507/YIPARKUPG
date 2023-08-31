report 50011 DK_CemetryRegister
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCemetryRegister.rdl';
    Caption = 'CemetryRegister';
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
            column(LayDate; Header."Laying Date")
            {
            }
            column(DeathDate; Header."Death Date")
            {
            }
            column(Name; Header.Name)
            {
            }
            column(Address; Header.Address)
            {
            }
            column(Address2; Header."Address 2")
            {
            }
            column(LayCatName; Header."Field Work Sub Cat. Name")
            {
            }
            column(DeathPlace; Header."Death Place")
            {
            }
            column(DeathCause; Header."Death Cause")
            {
            }
            column(SSN; Header."Social Security No.")
            {
            }
            column(Todays; Format(Today, 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ'))
            {
            }
            column(Gender; Format(Header.Gender))
            {
            }
            column(Birthday; Format(Birthday, 0, '<Year4> - <Month,2> - <Day,2>'))
            {
            }
            dataitem(Line; DK_Contract)
            {
                DataItemLink = "No." = FIELD("Contract No.");
                DataItemTableView = SORTING("No.");
                column(ContractDate; Line."Contract Date")
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
                Clear(GenderTxt);

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
                        SType := Format(DK_Customer.Gender);
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
        CemRegisterLb = 'Cemetry Register Form';
        RegisterLb = 'Register as the following above';
        SeogiLb = 'A.D';
        JaeDanLb = 'Juridical';
        YongInParkLb = 'YongInPark';
        GuiJoongLb = 'Messrs';
        BobInLb = 'Foundation';
        MyeoJiNumLb = 'Cemetry No.';
        LayDateLb = 'Lay Date';
        DeathDateLb = 'Death Date';
        SaLb = 'Sa';
        InLb = 'In';
        MangLb = 'Mang';
        NameLb = 'Name';
        GenderLb = 'Gender';
        AddressLb = 'Address';
        SinLb = 'Sin';
        ChungLb = 'Chung';
        LayCatLb = 'Lay Category';
        DeathPlaceLb = 'Death Place';
        DeathCauseLb = 'Death Cause';
        SSNLb = 'SSN';
        BirthDateLb = 'Date of Birth';
        ContactLb = 'Contact';
    }

    var
        DK_Customer: Record DK_Customer;
        DK_Contract: Record DK_Contract;
        GenderTxt: Text[10];
        Birthday: Date;
        gContractNo: Code[20];
        gLineNo: Integer;
        ManMSG: Label 'Man';
        WomanMSG: Label 'Woman';
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

