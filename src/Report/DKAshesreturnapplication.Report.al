report 50010 "DK_Ashes return application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAshesreturnapplication.rdl';
    Caption = 'Ashes return application';
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
            column(SContractDate; SContractDate)
            {
            }
            column(SEndDate; SEndDate)
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
            column(Relationlbl; Relationlbl)
            {
            }
            column(bonganClasslbl; bonganClasslbl)
            {
            }
            column(RetrunDatelbl; RetrunDatelbl)
            {
            }
            column(ContractDatelbl; ContractDatelbl)
            {
            }
            column(UseYnlbl; UseYnlbl)
            {
            }
            column(Giveuplbl; Giveuplbl)
            {
            }
            column(AdminExpenselbl; AdminExpenselbl)
            {
            }
            column(AdminExpDatelble; AdminExpDatelble)
            {
            }
            column(ApplicationUserlbl; ApplicationUserlbl)
            {
            }
            column(FromDatelbl; FromDatelbl)
            {
            }
            column(ToDatelbl; ToDatelbl)
            {
            }
            column(TextMessage; TextMessage)
            {
            }
            column(TextLeft01; TextLeft01)
            {
            }
            column(TextLeft02; TextLeft02)
            {
            }
            column(TextLeft03; TextLeft03)
            {
            }
            column(TextLeft04; TextLeft04)
            {
            }
            column(TextLeft05; TextLeft05)
            {
            }
            column(TextLeft06; TextLeft06)
            {
            }
            column(TextRight01; TextRight01)
            {
            }
            column(TextRight02; TextRight02)
            {
            }
            column(TextRight03; TextRight03)
            {
            }
            column(TextRight04; TextRight04)
            {
            }
            column(TextRight05; TextRight05)
            {
            }
            column(TextRight06; TextRight06)
            {
            }
            column(TextRight07; TextRight07)
            {
            }
            column(TextRight08; TextRight08)
            {
            }
            column(TextRight09; TextRight09)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if DK_Contract.Get("Contract No.") then begin
                    if DK_Customer.Get(DK_Contract."Main Customer No.") then begin
                        SName := DK_Customer.Name;
                        SJumin := DK_Customer.GetSSNSSNCalculated();
                        SAddress := DK_Customer.Address + '' + DK_Customer."Address 2";
                        SType := Relationship;
                        SContact := DK_Customer."Mobile No.";
                        SContractDate := Format(DK_Contract."Contract Date", 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ');
                        if DK_Contract."General Expiration Date" <> 0D then begin
                            SEndDate := Format(DK_Contract."General Expiration Date", 0, '<Year4> ‚Ë <Month,2> õ <Day,2> Ÿ');
                        end else begin
                            SEndDate := ToDatelbl;

                        end;
                    end else begin
                        SName := '';
                        SJumin := '';
                        SAddress := '';
                        SType := '';
                        SContact := '';
                        SContractDate := '';
                        SEndDate := ToDatelbl;
                    end;

                end else begin
                    SName := '';
                    SJumin := '';
                    SAddress := '';
                    SType := '';
                    SContact := '';
                    SContractDate := '';
                    SEndDate := ToDatelbl;
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
        Subjectlbl: Label 'Ashes return application';
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
        bonganClasslbl: Label 'Class';
        RetrunDatelbl: Label 'Return Date';
        ContractDatelbl: Label 'Contract Date';
        UseYnlbl: Label 'Use YN';
        Giveuplbl: Label '( Yes / No )';
        AdminExpenselbl: Label 'Admin Expense';
        AdminExpDatelble: Label 'Period';
        ApplicationUserlbl: Label 'Application User                                 (Sign)';
        FromDatelbl: Label '   Year Month Day ~';
        ToDatelbl: Label '   Year Month Day';
        TextMessage: Label 'The remains enshrined in the tomb of Bongan have been acquired and confirmed.';
        gContractNo: Code[20];
        gCemeteryCode: Code[20];
        gCemeteryNo: Text[50];
        TextLeft01: Label '[Purchasing Documents - Contractor = Same as Application Date]';
        TextLeft02: Label '1. Contractor (applicant) seal certificate 1 copy';
        TextLeft03: Label '2. One resident registration copy';
        TextLeft04: Label '3. (Abandonment) Cemetery License Agreement 1 copy or';
        TextLeft05: Label '    (When not giving up) Cemetery Commercial use certificate Not to give one pledge';
        TextLeft06: Label '4. Cemetery use contract and membership card return';
        TextRight01: Label '[ €ˆŠ±Œ¡‡õ - º®À (–ð€Ë“/‰œ–ð€Ë“) ]';
        TextRight02: Label '1. º®À ž¿‘ãˆ×Œ¡ 1Šž';
        TextRight03: Label '2. º®À ‘´‰ž…Ø‡Ÿ…ØŠ‹ 1Šž';
        TextRight04: Label '3. º®À ÐŽÊÀ— í‘‡ýÐ‘ãˆ×Œ¡ 1Šž or ‘ªø…ØŠ‹ 1Šž (í‘‡®‹ ˜«ž—­Œ÷ ´„’';
        TextRight05: Label ' Œ¡‡õ)  (‹Ïˆ‘“:‹Ïˆ‘˜«žŒ¡‡õ _ex) €ËŠ‹‘ãˆ×Œ¡(…‹Ï‰½Œ­‰È€Ã),‹Ïˆ‘‘°„ÂŒ¡(Š„°))';
        TextRight06: Label '4. (–ð€Ë“) ‰ª‘÷‹ÏÔ€— –ð€Ë Œ¡ŽÊŒ¡ 1Šž or';
        TextRight07: Label '    (‰œ–ð€Ë“) ‰ª‘÷‹ÏÔ€— ‰œ–ð€Ë Œ¡ŽÊŒ¡ 1Šž';
        TextRight08: Label '5. “Ñ® Œ¡ŽÊŒ¡ 1Šž';
        TextRight09: Label '6. ‰ª‘÷‹ÏÔ ÐŽÊŒ¡ ‰¸ ˜ˆ°‘ã ‰¦‚‚';
        DK_Contract: Record DK_Contract;
        DK_Customer: Record DK_Customer;
        SName: Text;
        SJumin: Text;
        SAddress: Text;
        SType: Text;
        SContact: Text;
        SContractDate: Text;
        SEndDate: Text;


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

