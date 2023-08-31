report 50036 "DK_Change Contract Cemetery"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKChangeContractCemetery.rdl';
    Caption = 'Cahnge Contract Cemetery';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Contract; DK_Contract)
        {

            trigger OnAfterGetRecord()
            var
                _ContractMgt: Codeunit "DK_Contract Mgt.";
            begin
                Contract."Before Cemetery Code" := Contract."Cemetery Code";
                Contract."Before Cemetery No." := Contract."Cemetery No.";

                Clear(_ContractMgt);
                _ContractMgt.ChangeCemeteryCode(Contract."No.", Contract.Status, Contract."Cemetery Code", CemeteryCode);

                Contract."Cemetery Code" := CemeteryCode;
                Contract."Cemetery No." := CemeteryNo;
                Contract.Modify;
            end;

            trigger OnPreDataItem()
            begin
                if CemeteryCode = '' then
                    Error(MSG001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field(CemeteryCode; CemeteryCode)
                    {
                        Caption = 'Cemetery Code';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            _Cemetery: Record DK_Cemetery;
                            _CemeteryList: Page "DK_Cemetery List";
                        begin

                            _Cemetery.FilterGroup(2);
                            _Cemetery.Reset;
                            _Cemetery.SetRange(Status, _Cemetery.Status::Unsold);
                            _Cemetery.FilterGroup(0);

                            Clear(_CemeteryList);
                            _CemeteryList.LookupMode(true);
                            _CemeteryList.SetTableView(_Cemetery);
                            _CemeteryList.SetRecord(_Cemetery);
                            if _CemeteryList.RunModal = ACTION::LookupOK then begin
                                _CemeteryList.GetRecord(_Cemetery);
                                CemeteryCode := _Cemetery."Cemetery Code";
                                CemeteryNo := _Cemetery."Cemetery No.";
                            end else begin
                                CemeteryCode := '';
                                CemeteryNo := '';
                            end;
                        end;

                        trigger OnValidate()
                        begin

                            if CemeteryCode = '' then
                                CemeteryNo := '';
                        end;
                    }
                    field(CemeteryNo; CemeteryNo)
                    {
                        Caption = 'Cemetery No.';
                        Editable = false;
                    }
                    label("Changing the cemtery will change the amount of maintenance amount. Please choose carefully.")
                    {
                        Caption = 'Changing the cemtery will change the amount of maintenance amount. Please choose carefully.';
                        Style = Attention;
                        StyleExpr = TRUE;
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

    var
        CemeteryCode: Code[20];
        CemeteryNo: Text;
        MSG001: Label 'The cemetery code cannot be empty.';
}

