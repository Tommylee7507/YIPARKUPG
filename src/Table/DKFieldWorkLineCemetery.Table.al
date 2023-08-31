table 50076 "DK_Field Work Line Cemetery"
{
    Caption = 'Field Work Line Cemetery';
    DrillDownPageID = "DK_Field Work Cem. Subform";
    LookupPageID = "DK_Field Work Cem. Subform";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Estate,Cemetery';
            OptionMembers = Estate,Cemetery;
        }
        field(4; "Use Area Code"; Code[20])
        {
            Caption = 'Use Area Code';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Estate)) DK_Estate.Code WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Cemetery)) DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
                _Estate: Record DK_Estate;
                _Cemetery: Record DK_Cemetery;
            begin
                if Type = Type::Estate then begin
                    if _Estate.Get("Use Area Code") then begin
                        "Use Area" := _Estate.Name;
                        "Estate Type" := _Estate.Type;
                    end else begin
                        "Use Area" := '';
                        "Estate Type" := "Estate Type"::Blank;
                    end
                end else begin
                    if _Cemetery.Get("Use Area Code") then begin
                        "Use Area" := _Cemetery."Cemetery No.";
                        _Cemetery.CalcFields("Estate Type");
                        "Estate Type" := _Cemetery."Estate Type";
                        "Cemetery Estate Code" := _Cemetery."Estate Code";
                        "Cemetery Estate Name" := _Cemetery."Estate Name";
                    end else begin
                        "Use Area" := '';
                        "Estate Type" := "Estate Type"::Blank;
                        "Cemetery Estate Code" := '';
                        "Cemetery Estate Name" := '';
                    end
                end;
            end;
        }
        field(5; "Use Area"; Text[30])
        {
            Caption = 'Use Area Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Estate Type"; Option)
        {
            Caption = 'Estate Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Stairs,Funeral Urn,Tree,Nature';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature;
        }
        field(7; "Cemetery Estate Code"; Code[20])
        {
            Caption = 'Cemetery Estate Code';
            DataClassification = ToBeClassified;
        }
        field(8; "Cemetery Estate Name"; Text[30])
        {
            Caption = 'Cemetery Estate Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Temporary Grave"; Boolean)
        {
            Caption = 'Temporary Grave';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("No.", "Document No.");
        if _FieldWorkHeader.Status = _FieldWorkHeader.Status::Post then
            Error(MSG001, _FieldWorkHeader.FieldCaption(Status), _FieldWorkHeader.Status::Post);
    end;

    trigger OnInsert()
    begin

        EstateCheck(Rec);
    end;

    trigger OnModify()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("No.", "Document No.");
        if _FieldWorkHeader.Status = _FieldWorkHeader.Status::Post then
            Error(MSG001, _FieldWorkHeader.FieldCaption(Status), _FieldWorkHeader.Status::Post);

        EstateCheck(Rec);
    end;

    var
        MSG001: Label 'If the %1 is %2, it can not be Modify or deleted.';
        MSG002: Label 'There is the same %1. Check the %2.';
        MSG003: Label 'You can not include the %2 contained in %1. Check the %3.';
        MSG004: Label 'There are lines that have the same %2 as the %1. Check the %3.';

    local procedure EstateCheck(pFieldWorkLine: Record "DK_Field Work Line Cemetery"): Boolean
    var
        _Cemetery: Record DK_Cemetery;
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _Estate: Record DK_Estate;
    begin

        _FieldWorkLineCemetery.Reset;
        _FieldWorkLineCemetery.SetRange("Document No.", pFieldWorkLine."Document No.");
        _FieldWorkLineCemetery.SetRange("Estate Type", pFieldWorkLine."Estate Type");
        if _FieldWorkLineCemetery.FindSet then begin
            repeat
                if _FieldWorkLineCemetery."Use Area Code" = pFieldWorkLine."Use Area Code" then
                    Error(MSG002, FieldCaption("Use Area"), _FieldWorkLineCemetery."Line No.");

                if (pFieldWorkLine.Type = pFieldWorkLine.Type::Cemetery) and
                   (_FieldWorkLineCemetery."Use Area Code" = pFieldWorkLine."Cemetery Estate Code") then
                    Error(MSG003, _FieldWorkLineCemetery."Use Area", FieldCaption("Use Area"), _FieldWorkLineCemetery."Line No.");

                if (pFieldWorkLine.Type = pFieldWorkLine.Type::Estate) and
                  (pFieldWorkLine."Use Area Code" = _FieldWorkLineCemetery."Cemetery Estate Code") then
                    Error(MSG004, pFieldWorkLine."Use Area", FieldCaption("Use Area"), _FieldWorkLineCemetery."Line No.");
            until _FieldWorkLineCemetery.Next = 0;
        end;
    end;
}

