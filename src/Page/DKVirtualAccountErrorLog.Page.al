page 50179 "DK_Virtual Account Error Log"
{
    Caption = 'Virtual Account Error Log';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Company Code';
                }
                field(CODE3; Rec.CODE3)
                {
                    Caption = 'Virtual Account No.';
                }
                field(DATE0; Rec.DATE0)
                {
                    Caption = 'Transaction Date';
                }
                field(CODE5; Rec.CODE5)
                {
                    Caption = 'Transaction Time';
                }
                field(CODE1; Rec.CODE1)
                {
                    Caption = 'Transatin No.';
                }
                field(CODE4; Rec.CODE4)
                {
                    Caption = 'Error Code';
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Error';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Amount';
                }
                field(CODE2; Rec.CODE2)
                {
                    Caption = 'Bank Code';
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Bank Name';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        _ExtDBPro: Codeunit "DK_External DB Process";
    begin

        //‘†˜ˆ
        if VirtualAccountNo <> '' then begin
            Clear(_ExtDBPro);
            // _ExtDBPro.VirtualAccountErrorLog(Rec, VirtualAccountNo, AssginDate); ////zzz
        end;
    end;

    var
        AssginDate: Date;
        VirtualAccountNo: Code[20];


    procedure SetParameter(pAssginDate: Date; pVirtualAccountNo: Code[20])
    begin

        AssginDate := pAssginDate;
        VirtualAccountNo := pVirtualAccountNo;
    end;
}

