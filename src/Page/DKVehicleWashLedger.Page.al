page 50035 "DK_Vehicle Wash Ledger"
{
    Caption = 'Vehicle Wash Ledger';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Wash Led. Entry";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Vehicle Document No."; Rec."Vehicle Document No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Wash Date"; Rec."Wash Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Delete)
            {
                Caption = 'Delete';
                Enabled = DelAdmin;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = DelAdmin;

                trigger OnAction()
                var
                    _UserSetup: Record "User Setup";
                    _VehicleWashLedEntry: Record "DK_Vehicle Wash Led. Entry";
                    _VehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Vehicle Ledger Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;

                    _VehicleWashLedEntry.Reset;
                    _VehicleWashLedEntry.SetRange("Vehicle Document No.", Rec."Vehicle Document No.");
                    if _VehicleWashLedEntry.FindLast then begin
                        if _VehicleWashLedEntry."Entry No." <> Rec."Entry No." then
                            Error(MSG001, Rec.FieldCaption("Entry No."), _VehicleWashLedEntry."Entry No.");

                        if not Confirm(MSG002, false, _VehicleLedEntryHeader.Status::Open) then exit;

                        _VehicleLedEntryHeader.Reset;
                        _VehicleLedEntryHeader.SetRange("No.", _VehicleWashLedEntry."Document No.");
                        _VehicleLedEntryHeader.SetRange("Document Type", _VehicleLedEntryHeader."Document Type"::Wash);
                        if _VehicleLedEntryHeader.FindSet then begin
                            _VehicleLedEntryHeader.Status := _VehicleLedEntryHeader.Status::Open;
                            _VehicleLedEntryHeader.Modify(true);
                        end;

                        _VehicleWashLedEntry.Delete;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;

        SetDeleteAction;
    end;

    var
        DelAdmin: Boolean;
        MSG001: Label 'You can delete it from the last recording. %1 : %2';
        MSG002: Label 'The record is deleted and the document changes to the %1 state. Are you sure you want to?';

    local procedure SetDeleteAction()
    var
        _UserSetup: Record "User Setup";
    begin

        //Delete Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Vehicle Ledger Admin.", true);
        if _UserSetup.FindSet then
            DelAdmin := true
        else
            DelAdmin := false;
    end;
}

