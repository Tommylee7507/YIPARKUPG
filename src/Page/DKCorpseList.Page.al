page 50045 "DK_Corpse List"
{
    // *DK32 : 20200715
    //   - Add Field : "First Corpse"
    // 
    // DK34: 20201130
    //   - Add Field : Relationship, "Move The Grave Type", "Move The Grave Date"

    Caption = 'Corpse List';
    CardPageID = DK_Corpse;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Relation Infomation';
    SourceTable = DK_Corpse;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("First Corpse"; Rec."First Corpse")
                {
                }
                field(Name; Rec.Name)
                {
                    ShowMandatory = true;
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ShowMandatory = true;
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                    ShowMandatory = true;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ShowMandatory = true;
                }
                field("Death Date"; Rec."Death Date")
                {
                    ShowMandatory = true;
                }
                field("Laying Date"; Rec."Laying Date")
                {
                    ShowMandatory = true;
                }
                field("Death Cause"; Rec."Death Cause")
                {
                    ShowMandatory = true;
                }
                field("Death Place"; Rec."Death Place")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field("Move The Grave Type"; Rec."Move The Grave Type")
                {
                }
                field("Move The Grave Date"; Rec."Move The Grave Date")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field("Due Date 1st"; Rec."Due Date 1st")
                {
                }
                field("Due Date 2nd"; Rec."Due Date 2nd")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    BlankZero = true;
                }
                field("Temporary Grave Place"; Rec."Temporary Grave Place")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Temporary Grave Date"; Rec."Temporary Grave Date")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
                field("Invalid data"; Rec."Invalid data")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control46; "DK_Cemetery Detail Factbox")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Government Office Report")
            {
                Caption = 'Government Office Report';
                Image = TestReport;
                group(Action42)
                {
                    Caption = 'Government Office Report';
                    Image = TestReport;
                    action(CorpseBuryReport)
                    {
                        Caption = 'CorpseBuryReport';
                        Image = "Report";

                        trigger OnAction()
                        var
                            _CorpseBuryReport: Report "DK_Corpse Bury Report";
                            _Corpse: Record DK_Corpse;
                        begin

                            _Corpse.Reset;
                            _Corpse.SetRange("Contract No.", Rec."Contract No.");
                            _Corpse.SetRange("Line No.", Rec."Line No.");

                            Clear(_CorpseBuryReport);
                            _CorpseBuryReport.SetTableView(_Corpse);
                            _CorpseBuryReport.RunModal;
                        end;
                    }
                    action(CemetryRegister)
                    {
                        Caption = 'CemetryRegister';
                        Image = "Report";

                        trigger OnAction()
                        begin
                            CemetryRegisterRun;
                        end;
                    }
                    action("Cemetry Ledger")
                    {
                        Caption = 'Cemetry Ledger';
                        Image = "Report";

                        trigger OnAction()
                        begin
                            CemeteryLedgerRun;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group(Action44)
            {
                action("Ashes return applicaton")
                {
                    Caption = 'Ashes return applicaton';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        AshesreturnapplicationRun;
                    end;
                }
                action("Ashes return confirmation")
                {
                    Caption = 'Ashes return confirmation';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        AshesreturnconfirmationRun;
                    end;
                }
                action("Lay Ash Document")
                {
                    Caption = 'Lay Ash Document';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LayAshDocumentRun;
                    end;
                }
                action(AshEnshrineRegister)
                {
                    Caption = 'AshEnshrineRegister';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _Corpse: Record DK_Corpse;
                        _AshEnshrineRegister: Report DK_AshEnshrineRegister;
                    begin

                        _Corpse.Reset;
                        _Corpse.SetRange("Contract No.", Rec."Contract No.");
                        _Corpse.SetRange("Line No.", Rec."Line No.");
                        _Corpse.SetRange("Laying Date", Rec."Laying Date");

                        Clear(_AshEnshrineRegister);
                        _AshEnshrineRegister.SetTableView(_Corpse);
                        _AshEnshrineRegister.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Contract No.", ContractNo);
        Rec.Validate("Supervise No.", SuperviseNo);
        Rec.Validate("Cemetery Code", CemeteryNo);
    end;

    var
        ContractNo: Code[20];
        SuperviseNo: Code[20];
        CemeteryNo: Code[20];


    procedure SetParameter(var pContractNo: Code[20]; var pSuperviseNo: Code[20]; var pCemeteryNo: Code[20])
    begin
        ContractNo := pContractNo;
        SuperviseNo := pSuperviseNo;
        CemeteryNo := pCemeteryNo;
    end;

    local procedure AshesreturnconfirmationRun()
    var
        _DK_Ashesreturnconfirmation: Report "DK_Ashes return confirmation";
    begin
        _DK_Ashesreturnconfirmation.SetParam(Rec."Contract No.", Rec."Cemetery Code", Rec."Cemetery No.");
        _DK_Ashesreturnconfirmation.RunModal;
    end;

    local procedure AshesreturnapplicationRun()
    var
        _DK_Ashesreturnapplication: Report "DK_Ashes return application";
    begin
        _DK_Ashesreturnapplication.SetParam(Rec."Contract No.", Rec."Cemetery Code", Rec."Cemetery No.");
        _DK_Ashesreturnapplication.RunModal;
    end;

    local procedure LayAshDocumentRun()
    var
        _LayAshDocument: Report DK_LayAshDocument;
    begin
        _LayAshDocument.SetParam(Rec."Contract No.", Rec."Line No.");
        _LayAshDocument.RunModal;
    end;

    local procedure AshEnshrineRegisterRun()
    var
        _AshEnshrineRegister: Report DK_AshEnshrineRegister;
    begin
        _AshEnshrineRegister.SetParam(Rec."Contract No.", Rec."Line No.");
        _AshEnshrineRegister.RunModal;
    end;

    local procedure CemetryRegisterRun()
    var
        _CemetryRegister: Report DK_CemetryRegister;
    begin
        _CemetryRegister.SetParam(Rec."Contract No.", Rec."Line No.");
        _CemetryRegister.RunModal;
    end;

    local procedure CemeteryLedgerRun()
    var
        _CemetryLedger: Report DK_CemetryLedger;
    begin
        _CemetryLedger.SetParam(Rec."Contract No.", Rec."Line No.");
        _CemetryLedger.RunModal;
    end;
}

