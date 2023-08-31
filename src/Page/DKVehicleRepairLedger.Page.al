page 50031 "DK_Vehicle Repair Ledger"
{
    Caption = 'Vehicle Repair List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Vehicle Repair Led. Entry";
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
                field(Type; Rec.Type)
                {
                }
                field("Vehicle Document No."; Rec."Vehicle Document No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Repair Date"; Rec."Repair Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Repair Item Type"; Rec."Repair Item Type")
                {
                }
                field("Repair Item"; Rec."Repair Item")
                {
                }
                field(Quantity; Rec.Quantity)
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
            part(Control14; "DK_Alarm Factbox")
            {
                SubPageLink = "Source No." = FIELD("Vehicle Document No."),
                              "Source Type" = CONST(Vehicle),
                              "Source Line No." = CONST(0);
            }
            systempart(Control17; Notes)
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
                    _VehicleRepairLedEntry: Record "DK_Vehicle Repair Led. Entry";
                    _VehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header";
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Vehicle Ledger Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;

                    _VehicleRepairLedEntry.Reset;
                    _VehicleRepairLedEntry.SetRange("Vehicle Document No.", Rec."Vehicle Document No.");
                    if _VehicleRepairLedEntry.FindLast then begin
                        if _VehicleRepairLedEntry."Entry No." <> Rec."Entry No." then
                            Error(MSG001, Rec.FieldCaption("Entry No."), _VehicleRepairLedEntry."Entry No.");

                        if not Confirm(MSG002, false, _VehicleLedEntryHeader.Status::Open) then exit;

                        _VehicleLedEntryHeader.Reset;
                        _VehicleLedEntryHeader.SetRange("No.", _VehicleRepairLedEntry."Document No.");
                        _VehicleLedEntryHeader.SetRange("Document Type", _VehicleLedEntryHeader."Document Type"::Repair);
                        if _VehicleLedEntryHeader.FindSet then begin
                            _VehicleLedEntryHeader.Status := _VehicleLedEntryHeader.Status::Open;
                            _VehicleLedEntryHeader.Modify(true);
                        end;

                        _VehicleRepairLedEntry.Delete;
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

