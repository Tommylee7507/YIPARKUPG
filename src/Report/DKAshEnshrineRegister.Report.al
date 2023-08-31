report 50019 DK_AshEnshrineRegister
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAshEnshrineRegister.rdl';
    Caption = 'AshEnshrineReport';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; DK_Corpse)
        {
            DataItemTableView = SORTING("Laying Date");
            RequestFilterFields = "Contract No.", "Line No.", "Laying Date";
            column(CemNo; "Cemetery No.")
            {
            }
            column(CateName; "Field Work Main Cat. Name")
            {
            }
            column(LayDate; "Laying Date")
            {
            }
            column(DeathPlace; "Death Place")
            {
            }
            column(DeathDate; "Death Date")
            {
            }
            column(DeathCause; "Death Cause")
            {
            }
            column(Name; Name)
            {
            }
            column(SSN; "Social Security No.")
            {
            }
            column(Gender; Format(Gender))
            {
            }
            column(Address; Address)
            {
            }
            column(Todays; Format(Today, 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ'))
            {
            }
            column(Birthday; Format(Birthday, 0, '<Year4> - <Month,2> - <Day,2>'))
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
                Clear(GenderTxt);

                if Header."Social Security No." <> '' then begin
                    _SocialSecurityNo := Header."Social Security No.";

                    _SocialSecurityNo := UpperCase(_SocialSecurityNo);

                    Evaluate(_Year, CopyStr(_SocialSecurityNo, 1, 2));
                    Evaluate(_Month, CopyStr(_SocialSecurityNo, 3, 2));
                    Evaluate(_Day, CopyStr(_SocialSecurityNo, 5, 2));

                    Evaluate(_Gender, CopyStr(_SocialSecurityNo, 8, 1));
                    //Birthday
                    case _Gender of
                        1, 2, 5, 6:
                            _Year += 1900;
                        3, 4, 7, 8:
                            _Year += 2000;
                    end;

                    Birthday := DMY2Date(_Day, _Month, _Year);

                    //Gender
                    case _Gender of
                        1, 3, 5, 7:
                            GenderTxt := Format(Header.Gender::None);
                        2, 4, 6, 8:
                            GenderTxt := Format(Header.Gender::Male);
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

                CompanyInfo.Get;
                /*
                IF gContractNo <> '' THEN
                 SetRange("Contract No.",gContractNo);
                IF gLineNo <> 0 THEN
                 SetRange("Line No.",gLineNo);
                  */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        NapgolLb = 'NapGol';
        CemNoLb = 'CemNo';
        CemTypeLb = 'CemType';
        AnchiLb = 'Anchi';
        DeathPlaceLb = 'DeathPlace';
        DeathDateLb = 'DeathDate';
        DeathCauseLb = 'DeathCause';
        SaLb = 'Sa';
        MangLb = 'Mang';
        InLb = 'In';
        NameLb = 'Name';
        SSNLb = 'SSN';
        GenderLb = 'Gender';
        BirthdayLb = 'Bithday';
        AddressLb = 'Address';
        SinLb = 'Sin';
        CheongLb = '“‹';
        RelationLb = 'relation';
        ContactLb = 'Contact';
        SetennceLb = 'Sentence';
        SeogiLb = 'Seogi';
        GuiJoongLb = 'GuiJoong';
    }

    var
        GenderTxt: Text[10];
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

