page 50029 "DK_Vehicle Operation Ledger"
{
    Caption = 'Vehicle Operation Ledger';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Oper. Led. Entry";
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
                field("Departure Date"; Rec."Departure Date")
                {
                }
                field("Departure Time"; Rec."Departure Time")
                {
                }
                field("Arrival Date"; Rec."Arrival Date")
                {
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Km Cumulative"; Rec."Km Cumulative")
                {
                }
                field("Km Difference"; Rec."Km Difference")
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
            systempart(Control13; Notes)
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
                    _VehicleOperLedEntry: Record "DK_Vehicle Oper. Led. Entry";
                    _VehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Vehicle Ledger Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;

                    _VehicleOperLedEntry.Reset;
                    _VehicleOperLedEntry.SetRange("Vehicle Document No.", Rec."Vehicle Document No.");
                    if _VehicleOperLedEntry.FindLast then begin
                        if _VehicleOperLedEntry."Entry No." <> Rec."Entry No." then
                            Error(MSG001, Rec.FieldCaption("Entry No."), _VehicleOperLedEntry."Entry No.");

                        if not Confirm(MSG002, false, _VehicleLedEntryHeader.Status::Open) then exit;

                        _VehicleLedEntryHeader.Reset;
                        _VehicleLedEntryHeader.SetRange("No.", _VehicleOperLedEntry."Document No.");
                        _VehicleLedEntryHeader.SetRange("Document Type", _VehicleLedEntryHeader."Document Type"::Operation);
                        if _VehicleLedEntryHeader.FindSet then begin
                            _VehicleLedEntryHeader.Status := _VehicleLedEntryHeader.Status::Open;
                            _VehicleLedEntryHeader.Modify(true);
                        end;

                        _VehicleOperLedEntry.Delete;
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

        //Delete Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Vehicle Ledger Admin.", true);
        if _UserSetup.FindSet then
            DelAdmin := true
        else
            DelAdmin := false;

    end;

    var
        DelAdmin: Boolean;
        MSG001: Label 'You can delete it from the last recording. %1 : %2';
        MSG002: Label 'The record is deleted and the document changes to the %1 state. Are you sure you want to?';
}

