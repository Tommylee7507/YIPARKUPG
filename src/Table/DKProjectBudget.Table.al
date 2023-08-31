table 50045 "DK_Project Budget"
{
    Caption = 'Project Budget';
    DataCaptionFields = "Project No.",Date;

    fields
    {
        field(1;"Project No.";Code[20])
        {
            Caption = 'Project No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3;Date;Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4;"Budget Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Budget Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Budget Amount" <> "Budget Amount" then
                  UpdateBudgetAmount("Project No.","Line No.","Budget Amount");
            end;
        }
        field(5;Description;Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Project No.","Line No.")
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
        //Update
        if _Project.Get("Project No.") then begin
           _Project."Budget Amount" -= "Budget Amount";
           _Project."Balance Amount" -= "Budget Amount";
           _Project.Modify;
        end;
    end;

    trigger OnInsert()
    begin
        TestField("Budget Amount");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Budget Amount");

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    local procedure UpdateBudgetAmount(pProjectNo: Code[20];pLineNo: Integer;pCurrBudget: Decimal)
    var
        _ProjectBudget: Record "DK_Project Budget";
        _Project: Record "DK_Project Header";
        _TotBudget: Decimal;
    begin

        _ProjectBudget.Reset;
        _ProjectBudget.SetCurrentKey("Project No.","Line No.");
        _ProjectBudget.SetRange("Project No.", pProjectNo);
        _ProjectBudget.SetFilter("Line No.",'<>%1',pLineNo);
        if _ProjectBudget.FindFirst then begin
          _ProjectBudget.CalcSums("Budget Amount");
          _TotBudget := _ProjectBudget."Budget Amount";
        end;

        //Update
        if _Project.Get(pProjectNo) then begin
           _Project."Budget Amount" := _TotBudget + pCurrBudget;
           _Project.Validate("Balance Amount", _Project."Budget Amount" - _Project."Actual Amount");
           _Project.Modify;
        end;
    end;
}

