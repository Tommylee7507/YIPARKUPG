table 50044 "DK_Project Line"
{
    Caption = 'Project Line';

    fields
    {
        field(1; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ProjectHeader: Record "DK_Project Header";
            begin
                CheckHeaderStatus("Project No.");

                if _ProjectHeader.Get("Project No.") then begin
                    if _ProjectHeader."Project Date From" > Date then
                        Error(MSG002, _ProjectHeader.FieldCaption("Project Date From"), FieldCaption(Date), _ProjectHeader."Project Date From");
                end;
            end;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckHeaderStatus("Project No.");
            end;
        }
        field(5; "Actual Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Actual Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                BudgetAmount: Decimal;
                DiffAmount: Decimal;
            begin
                CheckHeaderStatus("Project No.");
                if xRec."Actual Amount" <> "Actual Amount" then begin
                    if "Actual Amount" <> 0 then
                        //IF CheckLimitBudget(Rec) THEN
                        //    ERROR('ERROR');
                        // ELSE
                        UpdateActualAmount("Project No.", "Line No.", "Actual Amount");
                end;
            end;
        }
        field(6; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Project No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _Project: Record "DK_Project Header";
    begin
        CheckHeaderStatus("Project No.");
        //Update
        if _Project.Get("Project No.") then begin
            _Project."Actual Amount" -= "Actual Amount";
            _Project."Balance Amount" += "Actual Amount";
            _Project.Modify;
        end;

        UpdateHeader;
    end;

    trigger OnInsert()
    begin
        CheckHeaderStatus("Project No.");

        TestField(Description);
        TestField("Actual Amount");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
        UpdateHeader;
    end;

    trigger OnModify()
    begin
        TestField(Description);
        TestField("Actual Amount");

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;

        UpdateHeader;
    end;

    var
        MSG001: Label 'You can edit and delete it only if the Status is ''Released''.';
        MSG002: Label 'You can not enter %2 smaller than the %1. %3';


    procedure CheckHeaderStatus(pProjectNo: Code[20])
    var
        _ProjectHeader: Record "DK_Project Header";
    begin

        if _ProjectHeader.Get(pProjectNo) then begin
            if _ProjectHeader.Status = _ProjectHeader.Status::Open then
                Error(MSG001);
        end;
    end;

    local procedure CheckLimitBudget(pRec: Record "DK_Project Line"; var pBudget: Decimal; var pDiffAmount: Decimal): Boolean
    var
        _ProjectBudget: Record "DK_Project Budget";
    begin
    end;

    local procedure UpdateActualAmount(pProjectNo: Code[20]; pLineNo: Integer; pCurrAcutal: Decimal)
    var
        _ProjectLine: Record "DK_Project Line";
        _Project: Record "DK_Project Header";
        _TotAutual: Decimal;
    begin

        _ProjectLine.Reset;
        _ProjectLine.SetCurrentKey("Project No.", "Line No.");
        _ProjectLine.SetRange("Project No.", pProjectNo);
        _ProjectLine.SetFilter("Line No.", '<>%1', pLineNo);
        if _ProjectLine.FindFirst then begin
            _ProjectLine.CalcSums("Actual Amount");
            _TotAutual := _ProjectLine."Actual Amount";
        end;

        //Update
        if _Project.Get(pProjectNo) then begin
            _Project."Actual Amount" := _TotAutual + pCurrAcutal;
            _Project.Validate("Balance Amount", _Project."Budget Amount" - _Project."Actual Amount");
            _Project.Modify;
        end;
    end;

    local procedure UpdateHeader()
    var
        _Project: Record "DK_Project Header";
    begin

        if _Project.Get("Project No.") then begin
            _Project."Last Date Modified" := CurrentDateTime;
            _Project."Last Modified Person" := UserId;
            _Project.Modify;
        end;
    end;
}

