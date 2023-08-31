page 50185 "DK_Liti. Law. History List"
{
    Caption = 'Liti. Law. History List';
    CardPageID = "DK_Liti. Law. History";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Litigation Lawsuit History";
    SourceTableView = SORTING(Date)
                      ORDER(Descending)
                      WHERE("Delete Row" = CONST(false));

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
                field("Supervise No."; Rec."Supervise No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Importance = Additional;
                    Lookup = false;
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    ShowMandatory = true;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Lawsuit Status"; Rec."Lawsuit Status")
                {
                }
                field("Lawsuit Method"; Rec."Lawsuit Method")
                {
                }
                field("Lawsuit Type"; Rec."Lawsuit Type")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field(Remarks; Rec.Remarks)
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
            systempart(Control16; Notes)
            {
            }
            part(Control17; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
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
                    _LitigationLawsuitHistory: Record "DK_Litigation Lawsuit History";
                    _UserSetup: Record "User Setup";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Law History Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;


                    _LitigationLawsuitHistory.Reset;
                    _LitigationLawsuitHistory.SetRange("Request Del", true);
                    if _LitigationLawsuitHistory.FindSet then begin

                        if Confirm(MSG001, false) then
                            _LitigationLawsuitHistory.ModifyAll("Delete Row", true, true);

                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        if Rec.FindFirst then;
    end;

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin

        //Delete All Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Law History Admin.", true);
        if _UserSetup.FindSet then
            DelAll := true
        else
            DelAll := false;
    end;

    var
        MSG001: Label 'Do you really want to delete it?';
        DelAll: Boolean;
}

