table 50043 "DK_Project Header"
{
    Caption = 'Project Header';
    DataCaptionFields = "No.", "Project Name";
    DrillDownPageID = "DK_Project List";
    LookupPageID = "DK_Project List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Project Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Project Name"; Text[250])
        {
            Caption = 'Project Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Project Date From"; Date)
        {
            Caption = 'Project Date (From)';
            DataClassification = ToBeClassified;
        }
        field(4; "Project Date To"; Date)
        {
            Caption = 'Project Date (To)';
            DataClassification = ToBeClassified;
        }
        field(5; Memo; BLOB)
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(6; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then
                    "Employee Name" := Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(7; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Employee No.", Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(8; "Budget Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Budget Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Budget Amount" <> Rec."Budget Amount" then begin
                    UpdateBudget("Budget Amount");
                    CalcBalance("Budget Amount", "Actual Amount");
                end;
            end;
        }
        field(9; "Actual Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Actual Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Actual Amount" <> Rec."Actual Amount" then begin
                    CalcBalance("Budget Amount", "Actual Amount");
                end;
            end;
        }
        field(10; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(15; "Balance Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Available Balance';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _FunctionSetup: Record "DK_Function Setup";
            begin
                if xRec."Balance Amount" <> "Balance Amount" then begin
                    _FunctionSetup.Get;
                    if ("Balance Amount" < 0) and
                       (not _FunctionSetup."Prevent Neg. Budget") then begin
                        Error(MSG003, FieldCaption("Actual Amount"), FieldCaption("Budget Amount"));
                    end;
                end;
            end;
        }
        field(16; "Short Memo"; Text[250])
        {
            Caption = 'Short Memo';
            DataClassification = ToBeClassified;
        }
        field(17; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Released;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _ProjectLine: Record "DK_Project Line";
        _ProjectBudget: Record "DK_Project Budget";
    begin
        TestField(Status, Status::Open);

        _ProjectLine.Reset;
        _ProjectLine.SetRange("Project No.", "No.");
        if _ProjectLine.FindFirst then
            _ProjectLine.DeleteAll;

        _ProjectBudget.Reset;
        _ProjectBudget.SetRange("Project No.", "No.");
        if _ProjectBudget.FindFirst then
            _ProjectBudget.DeleteAll;
    end;

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Project Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Project Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        TestField("No.");
        //<<No

        _DepartmentBoard.Check_EmployeeUserID(UserId);

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("No.");
        //<<No

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'Positive Adjmt.';
        MSG002: Label 'Negative Adjmt.';
        MSG003: Label 'Total %1 exceeds %2. You can not enter %1 that exceeds %2.';
        Employee: Record DK_Employee;


    procedure AssistEdit(OldProjectHeader: Record "DK_Project Header"): Boolean
    var
        _ProjectHeader: Record "DK_Project Header";
    begin
        with _ProjectHeader do begin
            _ProjectHeader := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Project Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Project Nos.", OldProjectHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _ProjectHeader;
                exit(true);
            end;
        end;
    end;

    local procedure UpdateBudget(pChangeBudget: Decimal)
    var
        _ProjectBudget: Record "DK_Project Budget";
        _DiffAmount: Decimal;
        _NewLineNo: Integer;
    begin
        _DiffAmount := pChangeBudget;

        _ProjectBudget.Reset;
        _ProjectBudget.SetCurrentKey("Project No.", "Line No.");
        _ProjectBudget.SetRange("Project No.", "No.");
        if _ProjectBudget.FindLast then begin
            _ProjectBudget.CalcSums("Budget Amount");
            _DiffAmount := pChangeBudget - _ProjectBudget."Budget Amount";

            _NewLineNo := _ProjectBudget."Line No.";
        end;

        _NewLineNo += 10000;

        if _DiffAmount <> 0 then begin
            _ProjectBudget.Init;
            _ProjectBudget."Project No." := "No.";
            _ProjectBudget."Line No." := _NewLineNo;
            _ProjectBudget.Date := WorkDate;
            _ProjectBudget."Budget Amount" := _DiffAmount;
            if _DiffAmount > 0 then
                _ProjectBudget.Description := MSG001
            else
                _ProjectBudget.Description := MSG002;
            _ProjectBudget.Insert(true);
        end;
    end;

    local procedure CalcBalance(pBudetAmount: Decimal; pActualAmount: Decimal)
    begin

        "Balance Amount" := pBudetAmount - pActualAmount;
    end;


    procedure SetReleased()
    begin
        Status := Rec.Status::Released;
        Modify;
    end;


    procedure SetReOpen()
    begin
        Status := Rec.Status::Open;
        Modify;
    end;

    procedure SetWorkMemo(pNewWorkMemo: Text)
    var
        _TempBlob: Record TempBlob temporary;
    begin
        Clear(Memo);
        if pNewWorkMemo = '' then
            exit;


        _TempBlob.Blob := Memo;
        _TempBlob.WriteAsText(pNewWorkMemo, TEXTENCODING::Windows);
        "Short Memo" := CopyStr(pNewWorkMemo, 1, 200);
        Memo := _TempBlob.Blob;
        Modify;
    end;

    procedure GetWorkMemo(): Text
    begin
        CalcFields(Memo);
        exit(GetWorkMemoCalculated);
    end;

    procedure GetWorkMemoCalculated(): Text
    var
        _TempBlob: Record TempBlob temporary;
        _CR: Text[1];
    begin
        if not Memo.HasValue then
            exit('');

        _CR[1] := 10;
        _TempBlob.Blob := Memo;
        exit(_TempBlob.ReadAsText(_CR, TEXTENCODING::Windows));
    end;
}

