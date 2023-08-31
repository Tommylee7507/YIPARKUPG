report 50017 "DK_Corpse Bury Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCorpseBuryReport.rdl';
    Caption = 'CorpseBuryReport';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; DK_Corpse)
        {
            column(Name; Name)
            {
            }
            column(SSN; "Social Security No.")
            {
            }
            column(Address; Address)
            {
            }
            column(Place; "Death Place")
            {
            }
            column(Cause; "Death Cause")
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CemNo; "Cemetery No.")
            {
            }
            column(DeathDate; "Death Date")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(TodayText; TodayText)
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
            begin

                TodayText := Format(Today, 0, '<Year4>. <Month,2>.     .');

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
        CorpseTitleLbl = 'CorpseTitle';
        MaeJangLbl = 'MaeJang';
        HwaJangLbl = 'HwaJang';
        ReportLbl = 'Report';
        ProcessDateLbl = 'ProcessDate';
        ImmediateLbl = 'Immediate';
        SaLbl = 'Sa';
        MangLbl = 'Mang';
        JaLbl = 'À';
        NameLbl = 'Name';
        SSNLbl = 'SSN';
        AddressLbl = 'Address';
        DeathPlaceLbl = 'DeathPlace';
        DeathCauseLbl = 'Death Cause';
        LayPlaceLbl = 'LayPlace';
        DeathDateLbl = 'Death Date';
        CreationDateLbl = 'CreationDate';
        SinLbl = 'Sin';
        GoLbl = 'Go';
        InLbl = 'In';
        RelationLbl = 'Relation';
        ContactLbl = 'Contact';
        JangsaLbl = 'JangSa';
        SinGoInLbl = 'SingoIn';
        SignLbl = 'Sign';
        GuiHaLbl = 'Guiha';
        DocumentLbl = 'Document';
        EuiRyoLbl = 'EuiRyo';
        EupLbl = 'Eup';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
        DK_Contract: Record DK_Contract;
        DK_Customer: Record DK_Customer;
        TodayText: Text;
        SName: Text;
        SJumin: Text;
        SAddress: Text;
        SType: Text;
        SContact: Text;
}

