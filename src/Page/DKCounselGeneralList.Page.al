page 50150 "DK_Counsel General List"
{
    Caption = 'Counsel General List';
    CardPageID = "DK_Counsel General";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Date, "Counsel Time", "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE(Type = CONST(General),
                            "Delete Row" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Result Process"; Rec."Result Process")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Counsel Level 1"; Rec."Counsel Level 1")
                {
                }
                field("Counsel Level Code 2"; Rec."Counsel Level Code 2")
                {
                }
                field("Counsel Level Name 2"; Rec."Counsel Level Name 2")
                {
                }
                field("Counsel Content"; Rec."Counsel Content")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field("Issue of membership"; Rec."Issue of membership")
                {
                }
                field("Dev. Target Doc. No."; Rec."Dev. Target Doc. No.")
                {
                }
                field("Dev. Target Doc. Line No."; Rec."Dev. Target Doc. Line No.")
                {
                    BlankZero = true;
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
            part(Control31; "DK_Counsel Contents Factbox")
            {
                SubPageLink = "Contract No." = FIELD("Contract No."),
                              Type = FIELD(Type),
                              "Dev. Target Doc. No." = FIELD("Dev. Target Doc. No."),
                              "Dev. Target Doc. Line No." = FIELD("Dev. Target Doc. Line No."),
                              "Line No." = FIELD("Line No.");
            }
            part("Customer Request"; "DK_Customer Request Fact. List")
            {
                Caption = 'Customer Request';
                SubPageLink = "Contract No." = FIELD("Contract No.");
            }
            part(Control12; "DK_Counsel General Factbox")
            {
                SubPageLink = "Contract No." = FIELD("Contract No."),
                              Type = FIELD(Type),
                              "Delete Row" = CONST(false);
                Visible = false;
            }
            systempart(Control29; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Request Delete All")
            {
                Caption = 'Request Delete All';
                Enabled = DelAll;
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = DelAll;

                trigger OnAction()
                var
                    _CounselHistory: Record "DK_Counsel History";
                    _UserSetup: Record "User Setup";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_General Counsel Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;


                    _CounselHistory.Reset;
                    _CounselHistory.SetRange(Type, _CounselHistory.Type::General);
                    _CounselHistory.SetRange("Request Del", true);
                    if _CounselHistory.FindSet then begin

                        if Confirm(MSG001, false) then
                            _CounselHistory.ModifyAll("Delete Row", true, true);

                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin
        if Rec.FindFirst then;

        //Delete All Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_General Counsel Admin.", true);
        if _UserSetup.FindSet then
            DelAll := true
        else
            DelAll := false;
    end;

    var
        MSG001: Label 'Do you really want to delete it?';
        DelAll: Boolean;
}

