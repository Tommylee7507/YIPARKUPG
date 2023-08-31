page 50054 DK_Corpse  ////zzz
{
    // *DK32 : 20200715
    //   - Rec. Modify Function : OnModifyRecord
    //                       OnDeleteRecord
    //                       OnAfterGetRecord
    //   - Add C/AL Globals(Variable) : ChangeLayingDate
    //   - Add C/AL Globals(Text Contents) : MSG001
    //                                       MSG002
    //   - Add Field : "First Corpse"
    //   - Add Action : ChangeLayingDate

    Caption = 'Corpse';
    DelayedInsert = true;
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = DK_Corpse;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                    Importance = Additional;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field(Location; Rec.Location)
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
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field("Solar Lunar Calendar"; Rec."Solar Lunar Calendar")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Post Code"; Rec."Post Code")
                {

                    trigger OnAssistEdit()
                    begin
                        AddressLookup;
                    end;
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Death Date"; Rec."Death Date")
                {
                }
                field("Laying Date"; Rec."Laying Date")
                {
                    Editable = ChangeLayingDate;
                    ShowMandatory = true;
                }
                field("Death Cause"; Rec."Death Cause")
                {
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
                field(Remark; Rec.Remark)
                {
                    MultiLine = true;
                }
                field("First Corpse"; Rec."First Corpse")
                {
                    Editable = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Importance = Additional;
                }
                field("Source No."; Rec."Source No.")
                {
                    Importance = Additional;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    Importance = Additional;
                }
            }
            group("Due Date")
            {
                Caption = 'Due Date';
                field("Due Date 1st"; Rec."Due Date 1st")
                {
                }
                field("Due Date 2nd"; Rec."Due Date 2nd")
                {
                }
            }
            group("Temporary Grave")
            {
                Caption = 'Temporary Grave';
                field("Temporary Grave Place Code"; Rec."Temporary Grave Place Code")
                {
                    Editable = TemporaryVisible;
                    Importance = Additional;
                }
                field("Temporary Grave Place"; Rec."Temporary Grave Place")
                {
                    Editable = TemporaryVisible;
                }
                field("Temporary Grave Date"; Rec."Temporary Grave Date")
                {
                    Editable = TemporaryVisible;
                }
            }
            group(Information)
            {
                Caption = 'Information';
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
            part(Control52; "DK_Cemetery Detail Factbox")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            systempart(Control26; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Temporary Undo")
            {
                Caption = 'Temporary Undo';
                Image = Undo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = TemporaryVisible = FALSE;

                trigger OnAction()
                var
                    _ContractMgt: Codeunit "DK_Contract Mgt.";
                begin
                    _ContractMgt.UpdateCorpseTemporayPlaceLaying(Rec, false);
                end;
            }
            separator(Action46)
            {
            }
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
            action(Buried)
            {
                Caption = 'Buried';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    buriedRun;
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
            action(CorpseBuryReport)
            {
                Caption = 'CorpseBuryReport';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

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
            separator(Action54)
            {
            }
            action(ChangeLayingDate)
            {
                Caption = 'Change Laying Date';
                Enabled = NOT ChangeLayingDate;
                Image = Change;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _CorpseMgt: Codeunit "DK_Corpse Mgt.";
                begin
                    //>>DK32

                    Clear(_CorpseMgt);
                    _CorpseMgt.ChangeLayingDateLookup(Rec);
                    CurrPage.Update;
                    //<<DK32
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Check_TemporaryVisible;

        //>>DK32
        if Rec."Line No." = 0 then
            ChangeLayingDate := true
        else
            ChangeLayingDate := false;
        //<<DK32
    end;

    trigger OnDeleteRecord(): Boolean
    var
        _Contract: Record DK_Contract;
        _Corpse: Record DK_Corpse;
    begin
        //>>DK32

        if Rec."First Corpse" then begin

            if _Contract.Get(Rec."Contract No.") then begin
                _Contract.CalcFields("Admin. Expense Method", "Daily Admin. Exp. Ledger Exis.");

                _Corpse.Reset;
                _Corpse.SetRange("Contract No.", Rec."Contract No.");
                _Corpse.SetFilter("Line No.", '<>%1', Rec."Line No.");
                if _Corpse.FindSet then begin
                    if (_Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract) and (_Contract."Daily Admin. Exp. Ledger Exis.") then
                        Error(MSG001, Rec.FieldCaption("Laying Date"), Rec."Laying Date", Rec."Contract No.", _Contract."Cemetery No.");
                end;
            end;
        end;
        //<<DK32
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Contract No.");
        Rec.TestField("Laying Date");
    end;

    trigger OnModifyRecord(): Boolean
    begin

        //>>DK32
        Rec.TestField("Contract No.");
        Rec.TestField("Laying Date");
        //>>DK32
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Contract: Record DK_Contract;
    begin

        //>>DK32
        if _Contract.Get(Rec."Contract No.") then begin
            _Contract.CalcFields("Daily Admin. Exp. Ledger Exis.", "Admin. Expense Method");
            if (_Contract."Admin. Expense Method" <> _Contract."Admin. Expense Method"::Contract) and (_Contract.Status <> _Contract.Status::FullPayment) then
                Error(MSG002, _Contract."No.",
                              _Contract.FieldCaption("Cemetery No."),
                              _Contract."Cemetery No.",
                              _Contract.FieldCaption(Status),
                              _Contract.Status,
                              _Contract.Status::FullPayment);
        end;

        ChangeLayingDate := true;
        Rec."Field Work Main Cat. Code" := '001'; //FIXED VALUE
        //<<DK32
    end;

    trigger OnOpenPage()
    begin
        Check_TemporaryVisible;
    end;

    var
        TemporaryVisible: Boolean;
        ContractMgt: Codeunit "DK_Contract Mgt.";
        MSG001: Label 'In addition to the first Corpse, there are additional registered Corpse. Currently, we cannot delete the Corpse.\\ Please delete all other Corpse and then delete the first Corpse!. %1:%2 Contract No.:%3, Cemetery No.:%4';
        ChangeLayingDate: Boolean;
        MSG002: Label 'Only when %4(%6) of the contract is (%6), you can register the Corpse. Contract No.: %1, %2: %3, current %4: %5';

    local procedure AddressLookup()
    var
        _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin

        Clear(_DK_KoreanRoadAddrMgt);

        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Rec.Address, Rec."Address 2", Rec."Post Code", _TmpText, _TmpCode);////zzz
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

    local procedure buriedRun()
    var
        _buried: Report DK_LayAshDocument;
    begin
        _buried.SetParam(Rec."Contract No.", Rec."Line No.");
        _buried.RunModal;
    end;


    procedure Check_TemporaryVisible()
    begin
        if (Rec."Temporary Grave Place Code" <> '') or
          (Rec."Temporary Grave Date" <> 0D) then
            TemporaryVisible := false
        else
            TemporaryVisible := true;
    end;
}

