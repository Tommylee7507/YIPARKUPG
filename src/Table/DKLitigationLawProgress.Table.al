table 50129 "DK_Litigation Law Progress"
{
    // 
    // DK34: 20201104
    //   - Create

    Caption = 'Litigation Law Progress';
    DrillDownPageID = "DK_Litigation Law Progress";
    LookupPageID = "DK_Litigation Law Progress";

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
                    NoSeriesMgt.TestManual(FunctionSetup."Litigation Raw Progress Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'lawsuit to request the recovery of inheritance,foreclosure of deposit,insurance seizure,corporeal movables seizure,default of obligation';
            OptionMembers = Lawsuit,Deposit,Insurance,Corporeal,Obligation;
        }
        field(3; "Progress Status"; Option)
        {
            Caption = 'Progress Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,Progress,Complete';
            OptionMembers = Blank,Progress,Complete;
        }
        field(4; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin

                if "Contract No." <> xRec."Contract No." then
                    if _Contract.Get("Contract No.") then begin
                        "Contract Date" := _Contract."Contract Date";

                        Validate("Main Customer No.", _Contract."Main Customer No.");
                        Validate("Cemetery Code", _Contract."Cemetery Code");
                    end else begin
                        "Contract Date" := 0D;

                        Validate("Main Customer No.", '');
                        Validate("Cemetery Code", '');
                    end;

                CalcFields("General Expiration Date", "Land. Arc. Expiration Date", "Litigation Evaluation");
            end;
        }
        field(5; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Customer;

            trigger OnValidate()
            var
                _Customer: Record DK_Customer;
            begin
                CalcFields("Main Customer Name");
            end;
        }
        field(7; "Main Customer Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin

                if "Cemetery Code" <> xRec."Cemetery Code" then
                    if _Cemetery.Get("Cemetery Code") then begin
                        "Cemetery No." := _Cemetery."Cemetery No.";
                        "Cemetery Size" := _Cemetery.Size;
                    end else begin
                        "Cemetery No." := '';
                        "Cemetery Size" := 0;
                    end;

                CalcFields("Cemetery Status");
            end;
        }
        field(9; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            Editable = false;
            TableRelation = DK_Cemetery;
            ValidateTableRelation = false;
        }
        field(10; "Cemetery Status"; Option)
        {
            CalcFormula = Lookup(DK_Cemetery.Status WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Unsold,Reserved Tomb,Contracted Tomb,Laying Tomb,Been Transported Tomb';
            OptionMembers = Unsold,Reserved,Contracted,Laying,BeenTransported;
        }
        field(11; "Cemetery Size"; Decimal)
        {
            Caption = 'Cemetery Size';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Litigation Evaluation"; Option)
        {
            CalcFormula = Lookup(DK_Contract."Litigation Evaluation" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Litigation Evaluation';
            Description = '#3202';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(13; "General Expiration Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."General Expiration Date" WHERE("No." = FIELD("Contract No.")));
            Caption = 'General Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Land. Arc. Expiration Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."Land. Arc. Expiration Date" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Land. Arc. Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; "Lawsuit Reception Date"; Date)
        {
            Caption = 'Lawsuit Reception date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("General Expiration Date", "Land. Arc. Expiration Date");

                if "Lawsuit Reception Date" <> 0D then begin
                    if "General Expiration Date" > "Lawsuit Reception Date" then begin
                        "Lawsuit Value" := 0;
                        "General Lawsuit Value" := 0;

                        if "Land. Arc. Expiration Date" > "Lawsuit Reception Date" then
                            "Land. Arc. Lawsuit Value" := 0;
                    end else
                        CalcAdminExpense;
                end else begin
                    "Lawsuit Value" := 0;
                    "General Lawsuit Value" := 0;
                    if "Land. Arc. Expiration Date" <> 0D then
                        "Land. Arc. Lawsuit Value" := 0;
                end;

                "Lawsuit Val. Manual" := false;
            end;
        }
        field(17; "Lawsuit Party"; Text[30])
        {
            Caption = 'Lawsuit party';
            DataClassification = ToBeClassified;
        }
        field(18; "Lawsuit Case No."; Text[50])
        {
            Caption = 'Lawsuit Case No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Lawsuit Value"; Decimal)
        {
            Caption = 'Lawsuit Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _LawsuitVal: Decimal;
            begin
                CalcFields("General Expiration Date", "Land. Arc. Expiration Date");
                if "Lawsuit Value" <> 0 then begin
                    if "Land. Arc. Expiration Date" <> 0D then begin
                        _LawsuitVal := Round("Lawsuit Value" / 2, 1, '=');

                        "General Lawsuit Value" := _LawsuitVal;
                        "Land. Arc. Lawsuit Value" := _LawsuitVal;
                    end else begin
                        "General Lawsuit Value" := "Lawsuit Value";
                        "Land. Arc. Lawsuit Value" := 0;
                    end;
                end else begin
                    "General Lawsuit Value" := 0;
                    "Land. Arc. Lawsuit Value" := 0;
                end;

                "Lawsuit Val. Manual" := true;
            end;
        }
        field(20; "Fixed Date Time"; Date)
        {
            Caption = 'Fixed Date Time';
            DataClassification = ToBeClassified;
        }
        field(21; "Fixed Date Type"; Option)
        {
            Caption = 'Fixed Date Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,Oral Agument,Mediation,Adjudication';
            OptionMembers = Blank,OralAgument,Mediation,Adjudication;
        }
        field(22; "Winning Type"; Option)
        {
            Caption = 'Winning Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,Winning,Loss,Rejection,Dismissal';
            OptionMembers = Blank,Winning,Loss,Rejection,Dismissal;
        }
        field(23; "Loss Reasons"; Text[255])
        {
            Caption = 'Loss Reasons';
            DataClassification = ToBeClassified;
        }
        field(24; "Lawsuit Future Dir. Code"; Code[20])
        {
            Caption = 'Lawsuit Future dir. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                if _LawFudirofprogress.Get("Lawsuit Future Dir. Code") then
                    "Lawsuit Future Dir. Name" := _LawFudirofprogress.Name
                else
                    "Lawsuit Future Dir. Name" := '';
            end;
        }
        field(25; "Lawsuit Future Dir. Name"; Text[30])
        {
            Caption = 'Lawsuit Future direction to Progress Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                Validate("Lawsuit Future Dir. Code", _LawFudirofprogress.GetLawFuDirCode("Lawsuit Future Dir. Code"));
            end;
        }
        field(26; "Deposit Reception Date"; Date)
        {
            Caption = 'Deposit Reception Date';
            DataClassification = ToBeClassified;
        }
        field(27; "Deposit Party"; Text[30])
        {
            Caption = 'Deposit Party';
            DataClassification = ToBeClassified;
        }
        field(28; "Deposit Case No."; Text[50])
        {
            Caption = 'Deposit Case No.';
            DataClassification = ToBeClassified;
        }
        field(29; "Deposit Quotation Code"; Code[20])
        {
            Caption = 'Deposit Quotation Type';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                if _Quotation.Get("Deposit Quotation Code") then
                    "Deposit Quotation Name" := _Quotation.Name
                else
                    "Deposit Quotation Name" := '';
            end;
        }
        field(30; "Deposit Quotation Name"; Text[30])
        {
            Caption = 'Deposit Quotation Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                Validate("Deposit Quotation Code", _Quotation.GetQuotationCode("Deposit Quotation Name"));
            end;
        }
        field(31; "Deposit Future Dir. Code"; Code[20])
        {
            Caption = 'Deposit Future Direction of Progress Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                if _LawFudirofprogress.Get("Deposit Future Dir. Code") then
                    "Deposit Future Dir. Name" := _LawFudirofprogress.Name
                else
                    "Deposit Future Dir. Name" := '';
            end;
        }
        field(32; "Deposit Future Dir. Name"; Text[30])
        {
            Caption = 'Deposit Future Direction of Progress Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                Validate("Deposit Future Dir. Code", _LawFudirofprogress.GetLawFuDirCode("Deposit Future Dir. Name"));
            end;
        }
        field(33; "Insurance Reception Date"; Date)
        {
            Caption = 'Insurance Reception Date';
            DataClassification = ToBeClassified;
        }
        field(34; "Insurance Party"; Text[30])
        {
            Caption = 'Insurance Party';
            DataClassification = ToBeClassified;
        }
        field(35; "Insurance Case No."; Text[50])
        {
            Caption = 'Insurance Case No.';
            DataClassification = ToBeClassified;
        }
        field(36; "Insurance Quotation Code"; Code[20])
        {
            Caption = 'Insurance Quotation Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                if _Quotation.Get("Insurance Quotation Code") then
                    "Insurance Future Dir. Name" := _Quotation.Name
                else
                    "Insurance Future Dir. Name" := '';
            end;
        }
        field(37; "Insurance Quotation Name"; Text[30])
        {
            Caption = 'Insurance Quotation Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                Validate("Insurance Quotation Code", _Quotation.GetQuotationCode("Insurance Quotation Name"));
            end;
        }
        field(38; "Insurance Future Dir. Code"; Code[20])
        {
            Caption = 'Insurance Future Direction of Progress Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                if _LawFudirofprogress.Get("Insurance Future Dir. Code") then
                    "Insurance Future Dir. Name" := _LawFudirofprogress.Name
                else
                    "Insurance Future Dir. Name" := '';
            end;
        }
        field(39; "Insurance Future Dir. Name"; Text[30])
        {
            Caption = 'Insurance Future Direction of Progress Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                Validate("Insurance Future Dir. Code", _LawFudirofprogress.GetLawFuDirCode("Insurance Future Dir. Name"));
            end;
        }
        field(40; "Corporeal Reception Date"; Date)
        {
            Caption = 'Corporeal Reception Date';
            DataClassification = ToBeClassified;
        }
        field(41; "Corporeal Party"; Text[30])
        {
            Caption = 'Corporeal Party';
            DataClassification = ToBeClassified;
        }
        field(42; "Corporeal Case No."; Text[50])
        {
            Caption = 'Corporeal Case No.';
            DataClassification = ToBeClassified;
        }
        field(43; "Corporeal Quotation Code"; Code[20])
        {
            Caption = 'Corporeal Quotation Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                if _Quotation.Get("Corporeal Quotation Code") then
                    "Corporeal Quotation Name" := _Quotation.Name
                else
                    "Corporeal Quotation Name" := '';
            end;
        }
        field(44; "Corporeal Quotation Name"; Text[30])
        {
            Caption = 'Corporeal Quotation Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                Validate("Corporeal Quotation Code", _Quotation.GetQuotationCode("Corporeal Quotation Name"));
            end;
        }
        field(45; "Corporeal Future Dir. Code"; Code[20])
        {
            Caption = 'Corporeal Future Dir. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                if _LawFudirofprogress.Get("Corporeal Future Dir. Code") then
                    "Corporeal Future Dir. Name" := _LawFudirofprogress.Name
                else
                    "Corporeal Future Dir. Name" := '';
            end;
        }
        field(46; "Corporeal Future Dir. Name"; Text[30])
        {
            Caption = 'Corporeal Future Dir. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                Validate("Corporeal Future Dir. Code", _LawFudirofprogress.GetLawFuDirCode("Corporeal Future Dir. Name"));
            end;
        }
        field(47; "Obligation Reception Date"; Date)
        {
            Caption = 'Obligation Reception Date';
            DataClassification = ToBeClassified;
        }
        field(48; "Obligation Party"; Text[30])
        {
            Caption = 'Obligation Party';
            DataClassification = ToBeClassified;
        }
        field(49; "Obligation Case No."; Text[50])
        {
            Caption = 'Obligation Case No.';
            DataClassification = ToBeClassified;
        }
        field(50; "Obligation Quotation Code"; Code[20])
        {
            Caption = 'Obligation Quotation Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                if _Quotation.Get("Obligation Quotation Code") then
                    "Obligation Quotation Name" := _Quotation.Name
                else
                    "Obligation Quotation Name" := '';
            end;
        }
        field(51; "Obligation Quotation Name"; Text[30])
        {
            Caption = 'Obligation Quotation Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Quotation.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Quotation: Record DK_Quotation;
            begin
                Validate("Obligation Quotation Code", _Quotation.GetQuotationCode("Obligation Quotation Name"));
            end;
        }
        field(52; "Obligation Future Dir. Code"; Code[20])
        {
            Caption = 'Obligation Future Dir. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                if _LawFudirofprogress.Get("Obligation Future Dir. Code") then
                    "Obligation Future Dir. Name" := _LawFudirofprogress.Name
                else
                    "Obligation Future Dir. Name" := '';
            end;
        }
        field(53; "Obligation Future Dir. Name"; Text[30])
        {
            Caption = 'Obligation Future Dir. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Law Fu. dir. of progress".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _LawFudirofprogress: Record "DK_Law Fu. dir. of progress";
            begin
                Validate("Obligation Future Dir. Code", _LawFudirofprogress.GetLawFuDirCode("Obligation Future Dir. Name"));
            end;
        }
        field(54; "Completion Status"; Option)
        {
            Caption = 'Completion Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,Non-Pay,DebtExemption,DebtRelief';
            OptionMembers = Blank,"Non-Pay","",DebtRelief;
        }
        field(55; Remark; Option)
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
            OptionCaption = 'Parties not specific,Agreement insufficient,Inherit Give up,Inherit,Bankruptcy Indemnify,Individual regeneration,Draft Number';
            OptionMembers = Parties,Agreement,InheritGiveup,Inherit,Indemnify,Regeneration,DraftNo;
        }
        field(56; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(200; "General Lawsuit Value"; Decimal)
        {
            Caption = 'General Lawsuit Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(201; "Land. Arc. Lawsuit Value"; Decimal)
        {
            Caption = 'Landscapre Arc Lawsuit Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(202; "Lawsuit Val. Manual"; Boolean)
        {
            Caption = 'Lawsuit Val. Manual';
            DataClassification = ToBeClassified;
            Editable = false;
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
    begin
        TestField(Status, Status::Open);
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Contract Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Litigation Raw Progress Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;

        TestField("Contract No.");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("No.");
        TestField("Contract No.");
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
        MSG001: Label 'You can not have a date that is less than or equal to the current %1. %1:%2';
        MSG002: Label 'Admin. Expense cannot be calculated!';
        MSG003: Label 'Do you really want to calculate?';


    procedure SetRelease()
    begin

        TestField("No.");
        TestField("Contract No.");

        Status := Rec.Status::Release;
        Modify;
    end;


    procedure SetReOpen()
    begin

        TestField("No.");
        TestField("Contract No.");

        Status := Rec.Status::Open;
        Modify;
    end;

    local procedure CalcAdminExpense()
    var
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        _GenStartDate: Date;
        _LanStartDate: Date;
    begin
        Clear(_GenStartDate);
        Clear(_LanStartDate);
        CalcFields("General Expiration Date", "Land. Arc. Expiration Date");

        if ("General Expiration Date" = 0D) and ("Land. Arc. Expiration Date" = 0D) then
            Error(MSG002);

        _GenStartDate := "General Expiration Date" + 1;

        if "Lawsuit Reception Date" <> 0D then
            if "Lawsuit Reception Date" > CalcDate('<+30Y>', Today) then
                if not Confirm(MSG003, false, "Lawsuit Reception Date") then
                    exit;

        "General Lawsuit Value" := _AdminExpenseMgt.GetCalcAdminExpenseAmountForPeriod("Contract No.", 0, _GenStartDate, "Lawsuit Reception Date");

        if "Land. Arc. Expiration Date" <> 0D then begin
            _LanStartDate := "Land. Arc. Expiration Date" + 1;
            "Land. Arc. Lawsuit Value" := _AdminExpenseMgt.GetCalcAdminExpenseAmountForPeriod("Contract No.", 1, _LanStartDate, "Lawsuit Reception Date");
        end;

        "Lawsuit Value" := "General Lawsuit Value" + "Land. Arc. Lawsuit Value";
    end;
}

