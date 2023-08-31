page 50030 "DK_Vehicle Refueling Ledger"
{
    Caption = 'Vehicle Refueling Ledger';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Refue. Led. Entry";
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
                field("Oiling Date"; Rec."Oiling Date")
                {
                }
                field("Oiling Machine"; Rec."Oiling Machine")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Liter; rEC.Liter)
                {
                }
                field("Km Cumulative"; Rec."Km Cumulative")
                {
                }
                field("Km Difference"; Rec."Km Difference")
                {
                }
                field(Mileage; Rec.Mileage)
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
            systempart(Control18; Notes)
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
                    _VehicleRefueLedEntry: Record "DK_Vehicle Refue. Led. Entry";
                    _VehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Vehicle Ledger Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;

                    _VehicleRefueLedEntry.Reset;
                    _VehicleRefueLedEntry.SetRange("Vehicle Document No.", Rec."Vehicle Document No.");
                    if _VehicleRefueLedEntry.FindLast then begin
                        if _VehicleRefueLedEntry."Entry No." <> Rec."Entry No." then
                            Error(MSG001, Rec.FieldCaption("Entry No."), _VehicleRefueLedEntry."Entry No.");

                        if not Confirm(MSG002, false, _VehicleLedEntryHeader.Status::Open) then exit;

                        _VehicleLedEntryHeader.Reset;
                        _VehicleLedEntryHeader.SetRange("No.", _VehicleRefueLedEntry."Document No.");
                        _VehicleLedEntryHeader.SetRange("Document Type", _VehicleLedEntryHeader."Document Type"::Refueling);
                        if _VehicleLedEntryHeader.FindSet then begin
                            _VehicleLedEntryHeader.Status := _VehicleLedEntryHeader.Status::Open;
                            _VehicleLedEntryHeader.Modify(true);
                        end;

                        _VehicleRefueLedEntry.Delete;
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

