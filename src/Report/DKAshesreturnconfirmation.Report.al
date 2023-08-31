report 50003 "DK_Ashes return confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAshesreturnconfirmation.rdl';
    Caption = 'Ashes return confirmation';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DK_Corpse; DK_Corpse)
        {
            DataItemTableView = SORTING("Contract No.", "Line No.");
            PrintOnlyIfDetail = false;
            column(ComPicture; CompanyInformation.Picture)
            {
            }
            column(ComName; CompanyInformation.Name)
            {
            }
            column(JobTitle; CompanyInformation."DK_Job Title")
            {
            }
            column(OwnerName; CompanyInformation."DK_Owner Name")
            {
            }
            column(CemeteryNo; "Cemetery No.")
            {
            }
            column(LayingDate; Format("Laying Date", 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ'))
            {
            }
            column(Name; Name)
            {
            }
            column(SocialSecurityNo; "Social Security No.")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(Todays; Format(Today, 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ'))
            {
            }
            column(Gender; Format(Gender))
            {
            }
            column(Subjectlbl; Subjectlbl)
            {
            }
            column(CemeteryNolbl; CemeteryNolbl)
            {
            }
            column(LayingDatelbl; LayingDatelbl)
            {
            }
            column(Corpselbl; Corpselbl)
            {
            }
            column(Corpselbl2; Corpselbl2)
            {
            }
            column(Namelbl; Namelbl)
            {
            }
            column(Sexlbl; Sexlbl)
            {
            }
            column(SocialSecurityNolbl; SocialSecurityNolbl)
            {
            }
            column(Addresslbl; Addresslbl)
            {
            }
            column(Contactlbl; Contactlbl)
            {
            }
            column(ReturnReasonlbl; ReturnReasonlbl)
            {
            }
            column(Applicantlbl; Applicantlbl)
            {
            }
            column(Applicantlbl2; Applicantlbl2)
            {
            }
            column(Yearlbl; Yearlbl)
            {
            }
            column(Monthlbl; Monthlbl)
            {
            }
            column(Dayslbl; Dayslbl)
            {
            }
            column(OfficialSeallbl; OfficialSeallbl)
            {
            }
            column(Relationlbl; Relationlbl)
            {
            }
            column(TextMessage; TextMessage)
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

                if DK_Contract.Get(DK_Corpse."Contract No.") then begin
                    if DK_Customer.Get(DK_Contract."Main Customer No.") then begin
                        SName := DK_Customer.Name;
                        SJumin := DK_Customer.GetSSNSSNCalculated();
                        SAddress := DK_Customer.Address + '' + DK_Customer."Address 2";
                        SType := DK_Corpse.Relationship;
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
                if gCemeteryCode <> '' then
                    SetRange("Cemetery Code", gCemeteryCode);
                if gCemeteryNo <> '' then
                    SetRange("Cemetery No.", gCemeteryNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(cContractNo; gContractNo)
                    {
                        Caption = 'Contract No.';
                        Editable = false;
                    }
                    field(cCemeteryCode; gCemeteryCode)
                    {
                        Caption = 'Cemetery Code';
                        TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        begin
                            cCemeteryCode_OnValidate;
                        end;
                    }
                    field(cCemeteryNo; gCemeteryNo)
                    {
                        Caption = 'Cemetery No.';
                        TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        begin
                            cCemeteryNo_OnValidate;
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Subjectlbl: Label 'Ashes return confirmation';
        CemeteryNolbl: Label 'Cemetery No.';
        LayingDatelbl: Label 'Laying Date';
        Corpselbl: Label 'Corpse';
        Corpselbl2: Label 'Corpse Name';
        Namelbl: Label 'Name';
        Sexlbl: Label 'Sex';
        SocialSecurityNolbl: Label 'Social Security No.';
        Addresslbl: Label 'Address';
        Contactlbl: Label 'Contact';
        ReturnReasonlbl: Label 'Retrun Reason';
        Applicantlbl: Label 'Applicant    (Delegate)';
        Applicantlbl2: Label 'Delegate';
        Yearlbl: Label 'Year';
        Monthlbl: Label 'Month';
        Dayslbl: Label 'Day';
        OfficialSeallbl: Label '(Official Seal)';
        Relationlbl: Label 'Relation';
        TextMessage: Label 'Return the remains enshrined in the tomb above to the applicant.';
        gContractNo: Code[20];
        gCemeteryCode: Code[20];
        gCemeteryNo: Text[50];
        DK_Contract: Record DK_Contract;
        DK_Customer: Record DK_Customer;
        SName: Text;
        SJumin: Text;
        SAddress: Text;
        SType: Text;
        SContact: Text;


    procedure SetParam(pContractNo: Code[20]; pCemeteryCode: Code[20]; pCemeteryNo: Text[50])
    begin
        gContractNo := pContractNo;
        gCemeteryCode := pCemeteryCode;
        gCemeteryNo := pCemeteryNo;
    end;

    local procedure cCemeteryCode_OnValidate()
    var
        _Cemetery: Record DK_Cemetery;
    begin
        if _Cemetery.Get(gCemeteryCode) then
            gCemeteryNo := _Cemetery."Cemetery No."
        else
            gCemeteryNo := '';
    end;

    local procedure cCemeteryNo_OnValidate()
    var
        _Cemetery: Record DK_Cemetery;
    begin
        gCemeteryCode := _Cemetery.GetCemeteryCode(gCemeteryNo);
        cCemeteryCode_OnValidate;
    end;
}

