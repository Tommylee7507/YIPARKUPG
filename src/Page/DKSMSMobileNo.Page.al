page 50013 "DK_SMS Mobile No."
{
    Caption = 'SMS Mobile No.';
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "DK_Report Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CODE0; Rec.CODE0)
                {
                    Caption = 'Mobile No.';

                    trigger OnValidate()
                    var
                        _CommFun: Codeunit "DK_Common Function";
                        _MobileNo: Text[20];
                    begin
                        if Rec.CODE0 <> '' then begin
                            _MobileNo := Format(Rec.CODE0);
                            if not _CommFun.CheckValidMobileNo(_MobileNo) then
                                Error(MSG001, MSG002);

                            Rec.CODE0 := _MobileNo;
                        end;
                    end;
                }
                field(TEXT1; Rec.TEXT1)
                {
                    Caption = 'Cemetery No.';
                    Editable = false;
                }
                field(CODE1; Rec.CODE1)
                {
                    Caption = 'Contract No.';
                    Editable = false;
                }
                field(TEXT0; Rec.TEXT0)
                {
                    Caption = 'Contact Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Rec.FilterGroup(2);
        Rec.SetRange("USER ID", UserId);
        Rec.SetRange("OBJECT ID", PAGE::"DK_SMS Mobile No.");
        Rec.FilterGroup(0);
    end;

    var
        MSG001: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG002: Label 'To Mobile No.';
        MSG003: Label 'There is no message to send.';
        MSG004: Label 'Not Found Contract.';
        MSG005: Label 'Not Found Mobile No.';


    procedure PreviewMessage(pMessageType: Option; pWorkMessage: Text; pMainContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
        _PreviewMSG: Text;
        _BatchSMSSending: Codeunit "DK_Batch SMS Sending";
    begin

        if pWorkMessage = '' then
            Error(MSG003);

        if Rec.CODE0 = '' then
            Error(MSG005);

        Clear(_BatchSMSSending);

        if Rec.CODE1 = '' then
            _PreviewMSG := _BatchSMSSending.SetMessageType(pMessageType, pWorkMessage, pMainContractNo)
        else
            _PreviewMSG := _BatchSMSSending.SetMessageType(pMessageType, pWorkMessage, Rec.CODE1);

        Message('%1', _PreviewMSG);
    end;
}

