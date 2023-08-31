page 50117 "DK_Field Work Cem. Subform"
{
    AutoSplitKey = true;
    Caption = 'Field Work Cem. Subform';
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "DK_Field Work Line Cemetery";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Use Area Code"; Rec."Use Area Code")
                {
                }
                field("Use Area"; Rec."Use Area")
                {
                }
                field("Estate Type"; Rec."Estate Type")
                {
                }
                field("Temporary Grave"; Rec."Temporary Grave")
                {
                    Visible = TemporaryGraveVisible;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetTemporaryGraveVisible;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        if _FieldWorkHeader.Get(rec."Document No.") then begin
            rec.Type := _FieldWorkHeader.Type;
        end;
    end;

    trigger OnOpenPage()
    begin
        SetTemporaryGraveVisible;
    end;

    var
        TemporaryGraveVisible: Boolean;


    procedure GetFieldWorkHeader(pType: Integer)
    begin
        rec.Init;
        rec.Type := pType;
    end;

    local procedure SetTemporaryGraveVisible()
    begin

        if rec."Temporary Grave" then
            TemporaryGraveVisible := true
        else
            TemporaryGraveVisible := false;
    end;
}

