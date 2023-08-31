page 50094 "DK_Change Cemetery Status"
{
    Caption = 'Change Cemetery Status';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = DK_Cemetery;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("No. of Corpse"; Rec."No. of Corpse")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Status; Rec.Status)
                {
                }
                field(ChangeStatus; ChangeStatus)
                {
                    Caption = 'Change Status';
                    // OptionCaptionML = 'Unsold,Reserved Tomb,Contracted Tomb,Laying Tomb,Been Transported Tomb';
                    OptionCaption = 'Unsold,Reserved Tomb,Contracted Tomb,Laying Tomb,Been Transported Tomb';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
            part(Control6; "DK_Contract List")
            {
                Editable = false;
                // SubPageLink = "Cemetery Code" = FIELD("Cemetery Code"); ////zzz
            }
            part(Control7; "DK_Corpse List")
            {
                Editable = false;
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Update)
            {
                Caption = 'Update';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Rec.Status = ChangeStatus then
                        Error(MSG007);

                    CheckStatus;

                    Rec.Status := ChangeStatus;
                    Rec.Modify;

                    Message(MSG004, Rec.Status);
                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if FirstSet = false then
            DefaultStatus;
    end;

    var
        MSG001: Label 'Information of the cemetery could not be found.';
        ChangeStatus: Option Unsold,Reserved,Contracted,Laying,BeenTransported;
        MSG002: Label '%1  contracts are currently associated with the cemetery. Please check the incorrect contract and update the contract information first.';
        MSG003: Label 'The current Status of the cemetery is confirmed to be incorrect. The Status of this cemetery is determined to be %1. Please check and update the Status of the cemetery.';
        FirstSet: Boolean;
        MSG004: Label 'The Status of this cemetery has been changed to %1.';
        MSG005: Label 'The Status of this cemetery must be %1. Please check the information in the relevant Contract. Contract No.: %2, Contract Status: %3';
        MSG006: Label 'The Status of this cemetery must be %1 or %2. Please check the information in the relevant Contract. Contract No.: %3, Contract Status: %4';
        MSG007: Label 'The Status of the current Cemetery is the same as the value of the specified change Status.';

    local procedure DefaultStatus()
    var
        _Contract: Record DK_Contract;
        _Corpse: Record DK_Corpse;
    begin

        _Contract.Reset;
        _Contract.SetRange("Cemetery Code", rEC."Cemetery Code");
        _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
        if _Contract.FindSet then begin
            if _Contract.Count > 1 then begin
                Message(MSG002, _Contract.Count, REC."Cemetery No.");
            end else begin

                _Corpse.Reset;
                _Corpse.SetRange("Contract No.", _Contract."No.");
                _Corpse.SetRange("Cemetery Code", REC."Cemetery Code");
                if _Corpse.FindSet then begin
                    ChangeStatus := Rec.Status::Laying;
                end else begin
                    case _Contract.Status of
                        _Contract.Status::Open:
                            begin
                                ChangeStatus := Rec.Status::Reserved;
                            end;
                        _Contract.Status::Reservation:
                            begin
                                if Rec.Status = Rec.Status::Contracted then
                                    ChangeStatus := Rec.Status::Contracted
                                else
                                    ChangeStatus := Rec.Status::Reserved;
                            end;
                        _Contract.Status::Contract:
                            begin
                                ChangeStatus := Rec.Status::Contracted;
                            end;
                        _Contract.Status::FullPayment:
                            begin
                                ChangeStatus := Rec.Status::Contracted;
                            end;
                    end;
                end;
            end;
        end else begin
            if not (Rec.Status in [Rec.Status::Unsold, Rec.Status::BeenTransported]) then begin
                _Corpse.Reset;
                _Corpse.SetRange("Cemetery Code", Rec."Cemetery Code");
                if _Corpse.FindSet then begin
                    ChangeStatus := Rec.Status::BeenTransported;
                end else begin
                    ChangeStatus := Rec.Status::Unsold;
                end;
            end;
        end;

        FirstSet := true;

        if Rec.Status <> ChangeStatus then begin
            case ChangeStatus of
                ChangeStatus::Unsold:
                    Message(MSG003, Rec.Status::Unsold);
                ChangeStatus::Reserved:
                    Message(MSG003, Rec.Status::Reserved);
                ChangeStatus::Contracted:
                    Message(MSG003, Rec.Status::Contracted);
                ChangeStatus::Laying:
                    Message(MSG003, Rec.Status::Laying);
                ChangeStatus::BeenTransported:
                    Message(MSG003, Rec.Status::BeenTransported);
            end;
        end;
    end;

    local procedure CheckStatus()
    var
        _Contract: Record DK_Contract;
        _Corpse: Record DK_Corpse;
    begin

        _Contract.Reset;
        _Contract.SetRange("Cemetery Code", Rec."Cemetery Code");
        _Contract.SetFilter(Status, '<>%1', _Contract.Status::Revocation);
        if _Contract.FindSet then begin
            if _Contract.Count > 1 then begin
                Error(MSG002, _Contract.Count, Rec."Cemetery No.");
            end else begin

                //‹Ý•’
                _Corpse.Reset;
                _Corpse.SetRange("Contract No.", _Contract."No.");
                _Corpse.SetRange("Cemetery Code", Rec."Cemetery Code");
                if _Corpse.FindSet then begin
                    if ChangeStatus <> Rec.Status::Laying then
                        Error(MSG005, Rec.Status::Laying, _Contract."No.", _Contract.Status);
                end else begin
                    case _Contract.Status of
                        _Contract.Status::Open,
                        _Contract.Status::Reservation:
                            begin
                                if ChangeStatus <> Rec.Status::Reserved then
                                    Error(MSG005, Rec.Status::Reserved, _Contract."No.", _Contract.Status);
                            end;
                        _Contract.Status::Contract,
                        _Contract.Status::FullPayment:
                            begin
                                if ChangeStatus <> Rec.Status::Contracted then
                                    Error(MSG005, Rec.Status::Contracted, _Contract."No.", _Contract.Status);
                            end;
                    end;
                end;
            end;
        end else begin

            if not (ChangeStatus in [Rec.Status::Unsold, Rec.Status::BeenTransported]) then begin
                Error(MSG006, Rec.Status::Unsold, Rec.Status::BeenTransported, _Contract."No.", _Contract.Status);
            end;
        end;
    end;
}

