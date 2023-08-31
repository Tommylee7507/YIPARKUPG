page 50152 "DK_Counsel Litigation List"
{
    // 
    // #2044 : 2020-07-23
    //   - Rec. Modify Page Caption: ŒÁ‰½ ‹Ý„Ì ˆ±‡Ÿ -> ×„ ‹Ý„Ì ˆ±‡Ÿ
    // 
    // Error01: 20201006
    //   - Rec. Modify Action: Action28
    // 
    // DK34: 20201201
    //   - Add Field: "Department Code", "Department Name", "Last Payment Date", "General Expiration Date", "Land. Arc. Expiration Date"

    Caption = 'Counsel Litigation List';
    CardPageID = "DK_Counsel Litigation";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Date, "Counsel Time", "Contract No.", "Line No.") ORDER(Descending) WHERE(Type = CONST(Litigation), "Delete Row" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Counsel Time"; Rec."Counsel Time")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Deposit Plan Date"; Rec."Deposit Plan Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Litigation Type"; Rec."Litigation Type")
                {
                }
                field("Contact Method"; Rec."Contact Method")
                {
                }
                field("Counsel Target"; Rec."Counsel Target")
                {
                }
                field("Counsel Content"; Rec."Counsel Content")
                {
                }
                field("Request Del"; Rec."Request Del")
                {
                }
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                    Visible = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                }
                field("General Expiration Date"; Rec."General Expiration Date")
                {
                }
                field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
                {
                }
                field("Cemetery Class"; Rec."Cemetery Class")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control29; "DK_Counsel Contents Factbox")
            {
                SubPageLink = "Contract No." = FIELD("Contract No."),
                              Type = FIELD(Type),
                              "Dev. Target Doc. No." = FIELD("Dev. Target Doc. No."),
                              "Dev. Target Doc. Line No." = FIELD("Dev. Target Doc. Line No."),
                              "Line No." = FIELD("Line No.");
            }
            part(Control6; "DK_Counsel Litigation Factbox")
            {
                SubPageLink = "Contract No." = FIELD("Contract No."),
                              Type = FIELD(Type),
                              "Delete Row" = CONST(false);
                Visible = false;
            }
            part(Control5; "DK_Selected Contract Facbox")
            {
            }
            systempart(Control27; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Litigation Counsel Statics")
            {
                Caption = 'Litigation Counsel Statics';
                Image = StatisticsDocument;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Litigation Counsel Statics";
            }
            action("Request Delete All")
            {
                Caption = 'Request Delete All';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _CounselHistory: Record "DK_Counsel History";
                    _UserSetup: Record "User Setup";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Litigation Counsel Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;


                    _CounselHistory.Reset;
                    _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
                    _CounselHistory.SetRange("Request Del", true);
                    if _CounselHistory.FindSet then begin

                        //>>Error01
                        if not Confirm(MSG001, false) then
                            exit;

                        repeat
                            _CounselHistory.Validate("Delete Row", true);
                            _CounselHistory.Modify(true);
                        until _CounselHistory.Next = 0;
                        //<<
                    end;
                end;
            }
            action("Litigation Info")
            {
                Caption = 'Litigation Info';
                Ellipsis = true;
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                    _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
                begin

                    _Contract.Reset;
                    _Contract.SetRange("No.", Rec."Contract No.");
                    _Contract.SetRange("Date Filter", 0D, Today);
                    if _Contract.FindSet then begin
                        _Contract.CalcFields("Cemetery Size", "Non-Pay. General Amount", "Non-Pay. Land. Arc. Amount");

                        Message(MSG002,
                        _Contract."General Expiration Date", // Ÿ‰¦ ýˆ« ‘Ž‡ßŸ
                        _Contract."Land. Arc. Expiration Date", // ‘†µ ýˆ« ‘Ž‡ßŸ
                        _RevocationContractMgt.CalcContractYearPreiod(_Contract."General Expiration Date", Today), // Ÿ‰¦ ‰œ‚‚ €Ëú
                        _RevocationContractMgt.CalcContractYearPreiod(_Contract."Land. Arc. Expiration Date", Today), // ‘†µ ‰œ‚‚ €Ëú
                        _Contract."Non-Pay. General Amount", // Ÿ‰¦ ‰œ‚‚Ž¸
                        _Contract."Non-Pay. Land. Arc. Amount", // ‘†µ ‰œ‚‚Ž¸
                        _Contract."Cemetery Size"); // –ÛŒ÷
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin
        //IF FINDFIRST THEN;

        //Delete All Action
        /*
        _UserSetup.RESET;
        _UserSetup.SETRANGE("User ID", USERID);
        _UserSetup.SETRANGE("DK_Litigation Counsel Admin.", TRUE);
        IF _UserSetup.FINDSET THEN
          DelAll := TRUE
        ELSE
          DelAll := FALSE;
          */

    end;

    var
        MSG001: Label 'Do you really want to delete it?';
        MSG002: Label 'Ÿ‰¦ ýˆ« ‘Ž‡ßŸ: %1\‘†µýˆ« ‘Ž‡ßŸ: %2\Ÿ‰¦ ýˆ«Š± ‰œ‚‚ €Ëú(‚Ë): %3\‘†µ ýˆ«Š± ‰œ‚‚ €Ëú(‚Ë): %4\Ÿ‰¦ ýˆ«Š± ‰œ‚‚ €¦Ž¸: %5\‘†µ ýˆ«Š± ‰œ‚‚ €¦Ž¸: %6\–ÛŒ÷: %7';
}

