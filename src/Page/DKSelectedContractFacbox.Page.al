page 50166 "DK_Selected Contract Facbox"
{
    // 
    // #2116: 20200825
    //   - Rec. Modify Action: Action18
    // 
    // *DK34 : 20201020
    //   - Rec. Modify Action: Action18

    Caption = 'Selected Contract';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Selected Contract";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Contact Name"; Rec."Contact Name")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                    Caption = 'Customer Mobile No.';
                }
                field("Allow Membership Printing"; Rec."Allow Membership Printing")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Delete All")
            {
                Caption = 'Delete All';
                Image = CancelAllLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _SelectedContract: Record "DK_Selected Contract";
                begin

                    _SelectedContract.Reset;
                    _SelectedContract.SetRange("USER ID", UserId);
                    if _SelectedContract.FindSet then
                        _SelectedContract.DeleteAll;
                end;
            }
            group(Reports)
            {
                Caption = 'Reports';
                Image = "Report";
                action("Reminder - Change Location")
                {
                    Caption = 'Reminder - Change Location';
                    Image = PrintReport;

                    trigger OnAction()
                    var
                        _CustomerCertficate: Report "DK_Customer Certficate";
                        _Contract: Record DK_Contract;
                        MSG001: Label 'The report can not be printed.';
                        _CustomerCertficateHistory: Record "DK_Customer Certficate History";
                        DK_NewCustCertificate: Report "DK_New Cust. Certificate";
                        DK_HonorCustCertificate: Report "DK_Honor Cust. Certificate";
                        _CustCertHistoryMgt: Codeunit "DK_Customer Certficate History";
                    begin

                        //˜ˆ°‘ã
                        // >> DK34
                        /*
                        _Contract.RESET;
                        _Contract.SETRANGE("User ID Filter", USERID);
                        _Contract.SETRANGE("Selected Contract", TRUE);
                        IF _Contract.FINDSET THEN BEGIN
                          REPEAT
                            _CustomerCertficateHistory.RESET;
                            _CustomerCertficateHistory.SETRANGE("Contract No.",_Contract."No.");
                            _CustomerCertficateHistory.SETRANGE(Apprval,TRUE);
                            IF NOT _CustomerCertficateHistory.FINDSET THEN
                              ERROR(MSG002,_CustomerCertficateHistory.FIELDCAPTION("Cemetery No."),_Contract."Cemetery No.");
                          UNTIL _Contract.NEXT = 0;
                        END;
                        */

                        // >> #2116
                        _Contract.Reset;
                        _Contract.SetRange("User ID Filter", UserId);
                        _Contract.SetRange("Selected Contract", true);
                        if _Contract.FindSet then
                            repeat
                                _CustCertHistoryMgt.InsertCertificateHistory(_Contract);
                            until _Contract.Next = 0
                        else
                            Error(MSG001);

                        Commit;

                        _Contract.CalcFields("Estate Type");
                        _Contract.SetFilter("Estate Type", '<>%1', _Contract."Estate Type"::Charnelhouse);
                        if _Contract.FindSet then begin
                            //CLEAR(_CustomerCertficate);
                            //_CustomerCertficate.SETTABLEVIEW(_Contract);
                            //_CustomerCertficate.RUNMODAL;
                            Clear(DK_NewCustCertificate);
                            DK_NewCustCertificate.SetTableView(_Contract);
                            DK_NewCustCertificate.RunModal;
                        end;

                        _Contract.SetRange("Estate Type");
                        _Contract.SetRange("Estate Type", _Contract."Estate Type"::Charnelhouse);
                        if _Contract.FindSet then begin
                            Clear(DK_HonorCustCertificate);
                            DK_HonorCustCertificate.SetTableView(_Contract);
                            DK_HonorCustCertificate.RunModal;
                        end;
                        // <<

                    end;
                }
            }
            group(Action8)
            {
                Caption = 'Reports';
                Image = "Report";
                action(cProcessingHistory)
                {
                    Caption = 'Processing History';
                    Image = Relatives;

                    trigger OnAction()
                    begin
                        ProcessingHistory;
                    end;
                }
                action("Address label")
                {
                    Caption = 'Address label';
                    Image = PrintDocument;

                    trigger OnAction()
                    begin
                        RunAddressReport;
                    end;
                }
                separator(Action19)
                {
                }
                action("Reminder 1st")
                {
                    Caption = 'Reminder 1st';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //“´×Œ¡ 1’ð

                        Clear(_ReportPrinting);
                        _ReportPrinting.Printing_Reminder1st;
                    end;
                }
                action("Reminder 2nd")
                {
                    Caption = 'Reminder 2nd';

                    trigger OnAction()
                    begin
                        //“´×Œ¡ 2’ð

                        Clear(_ReportPrinting);
                        _ReportPrinting.Printing_Reminder2nd;
                    end;
                }
                action("Notice of Term. of Contract")
                {
                    Caption = 'Notice of Term. of Contract';

                    trigger OnAction()
                    begin

                        //ÐŽÊ —¹‘÷ •ÔŠˆŒ¡

                        Clear(_ReportPrinting);
                        _ReportPrinting.Printing_NoticeofTermofContract;
                    end;
                }
                separator(Action15)
                {
                }
                action("Information Above")
                {
                    Caption = 'Information Above';

                    trigger OnAction()
                    begin
                        //‚‹Ô‘ãˆ×

                        Clear(_ReportPrinting);
                        _ReportPrinting.Printing_InformationAbove;
                    end;
                }
                action("Reminder - Notice")
                {
                    Caption = 'Reminder - Notice';

                    trigger OnAction()
                    begin

                        //“´×Œ¡ - —¹‘÷Ž˜‚‹

                        Clear(_ReportPrinting);
                        _ReportPrinting.Printing_ReminderNotice;
                    end;
                }
                action(Action14)
                {
                    Caption = 'Reminder - Change Location';

                    trigger OnAction()
                    begin

                        //“´×Œ¡ - º”íŠ»µ

                        Clear(_ReportPrinting);
                        _ReportPrinting.Printing_ReminderChangeLocation;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("USER ID", UserId);
        Rec.FilterGroup(0);
    end;

    var
        _ReportPrinting: Codeunit "DK_Report Printing";
        MSG001: Label 'Contract data not found.';
        MSG002: Label 'The contract is not approved. %1 : %2';

    local procedure ProcessingHistory()
    var
        _DK_SelectedContractMatrix: Page "DK_Selected Contract Matrix";
    begin
        _DK_SelectedContractMatrix.Run;
    end;


    procedure RunAddressReport()
    var
        _AddressLabel: Report "DK_Address Label";
    begin
        //_AddressLabel.SetParam("Contract No.","Cemetery Code","Cemetery No.");
        //_AddressLabel.USEREQUESTPAGE(FALSE);
        _AddressLabel.RunModal;
    end;
}

