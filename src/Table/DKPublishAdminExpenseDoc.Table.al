table 50087 "DK_Publish Admin. Expense Doc."
{
    Caption = 'Publish Administrative Expense Document';
    DataCaptionFields = "Document No.", "From Date", "To Date";
    DrillDownPageID = "DK_Publish Admin. Exp. List";
    LookupPageID = "DK_Publish Admin. Exp. List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    //TESTFIELD(Status, Status::Open);
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Publish Admin. Expense Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(7; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Publish Admin. Exp. Doc. Li"."Total Amount" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "General Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Publish Admin. Exp. Doc. Li"."General Amount" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'General Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Landscape Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Publish Admin. Exp. Doc. Li"."Landscape Arc. Amount" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Landscape Architecture Amount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(10; "No. of Line"; Integer)
        {
            CalcFormula = Count("DK_Publish Admin. Exp. Doc. Li" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'No. of Line';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(12; "Non-Pay. General Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Publish Admin. Exp. Doc. Li"."Non-Pay. General Amount" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Non-Payment General Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Non-Pay. Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Publish Admin. Exp. Doc. Li"."Non-Pay. Land. Arc. Amount" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Non-Payment Landscape Arc. Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "No. of Check Cust. Infor."; Integer)
        {
            CalcFormula = Count("DK_Publish Admin. Exp. Doc. Li" WHERE("Document No." = FIELD("Document No."),
                                                                        "Check Customer Infor." = CONST(true)));
            Caption = 'No. of Check Cust. Infor.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "No. of UnCheck Cust. Infor."; Integer)
        {
            CalcFormula = Count("DK_Publish Admin. Exp. Doc. Li" WHERE("Document No." = FIELD("Document No."),
                                                                        "Check Customer Infor." = CONST(false)));
            Caption = 'No. of UnCheck Cust. Infor.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';

            end;
        }
        field(17; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Date")
        {
        }
        key(Key3; "From Date")
        {
        }
        key(Key4; "To Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
    begin
        TestField(Status, Status::Open);

        _PublishAdminExpDocLine.Reset;
        _PublishAdminExpDocLine.SetRange("Document No.", "Document No.");
        _PublishAdminExpDocLine.SetRange("Check Customer Infor.", true);
        if _PublishAdminExpDocLine.FindSet then
            if not Confirm(MSG001, false, _PublishAdminExpDocLine.Count) then
                Error(MSG002);

        _PublishAdminExpDocLine.SetRange("Document No.", "Document No.");
        _PublishAdminExpDocLine.SetRange("Check Customer Infor.");
        if _PublishAdminExpDocLine.FindSet then
            _PublishAdminExpDocLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin

        if "Document No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Publish Admin. Expense Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Publish Admin. Expense Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
        end;

        TestField("Document No.");
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Document No.");
        TestField(Status, Status::Open);

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
        MSG001: Label 'Do you really want to delete it?';
        MSG002: Label 'The delete operation has been canceled.';


    procedure AssistEdit(OldPublishAdminExpenseDoc: Record "DK_Publish Admin. Expense Doc."): Boolean
    var
        _RecPublishAdminExpenseDoc: Record "DK_Publish Admin. Expense Doc.";
    begin
        with _RecPublishAdminExpenseDoc do begin
            _RecPublishAdminExpenseDoc := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Publish Admin. Expense Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Publish Admin. Expense Nos.", OldPublishAdminExpenseDoc."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                Rec := _RecPublishAdminExpenseDoc;
                exit(true);
            end;
        end;
    end;


    procedure SetReleased()
    var
        _PublishAdminExpense: Codeunit "DK_Publish Admin. Expense";
    begin

        if _PublishAdminExpense.CheckReleased(Rec) then begin

            Status := Rec.Status::Released;
            Modify;
        end;
    end;


    procedure SetReOpen()
    var
        _PublishAdminExpense: Codeunit "DK_Publish Admin. Expense";
    begin

        _PublishAdminExpense.CheckOpen(Rec);

        Status := Rec.Status::Open;
        Modify;
    end;
}

