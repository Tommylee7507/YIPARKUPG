report 50018 DK_LayAshDocument
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKLayAshDocument.rdl';
    Caption = 'buried';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; DK_Corpse)
        {
            DataItemTableView = SORTING("Contract No.", "Line No.");
            column(CemeteryNo; "Cemetery No.")
            {
            }
            column(Location; Location)
            {
            }
            column(FieldSubCatgory; "Field Work Sub Cat. Name")
            {
            }
            column(LayingDate; "Laying Date")
            {
            }
            column(Name; Name)
            {
            }
            column(SSN; "Social Security No.")
            {
            }
            column(DeathDate; "Death Date")
            {
            }
            column(Remark; Remark)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(Birthday; Format(Birthday, 0, '<Year4> - <Month,2> - <Day,2>'))
            {
            }
            column(Gender; Format(Gender))
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

                if TitleOption = TitleOption::Urn then
                    TitleText := StrSubstNo(MSG001, UrnMSG)
                else
                    TitleText := StrSubstNo(MSG001, SkyMSG);

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
                field(TitleOption; TitleOption)
                {
                    Caption = 'Title';
                    OptionCaption = 'Urn,Sky';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TitleLb = 'Urn buried';
        JaeLb = 'Jae';
        HoLb = 'Ho';
        CemeteryNoLb = 'Cemtery No.';
        LocationLb = 'Location';
        UrnTypeLb = 'Urn Type';
        LayingDateLb = 'Laying Date';
        LayingDate2Lb = 'LayingDate';
        Corpse1Lb = 'Corpse1';
        Corpse2Lb = 'Corpse2';
        Corpse3Lb = 'Corpse3';
        NameLb = 'Name';
        BirthDateLb = 'Birth Date';
        GenderLb = 'Gender';
        DeathDateLb = 'Death Date';
        RemarkLb = 'Remark';
        SinLb = 'Sin';
        CheongLb = 'Cheong';
        InLb = 'In';
        PhoneLb = 'Phone';
        SSNLb = 'SSN';
        SSN2LB = 'SSN2';
        RelationLB = 'Relation';
        AddressLb = 'Address';
        AnchiInLb = 'AnchiIn';
        TeukKiLb = 'TeukKi';
    }

    var
        gContractNo: Code[20];
        gLineNo: Integer;
        TitleOption: Option Urn,Sky;
        TitleText: Text;
        MSG001: Label '%1 buried';
        UrnMSG: Label 'Urn';
        SkyMSG: Label 'Sky';
        GenderTxt: Text[10];
        Birthday: Date;
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

