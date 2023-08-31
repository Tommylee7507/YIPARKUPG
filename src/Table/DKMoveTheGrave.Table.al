table 50069 "DK_Move The Grave"
{
    // 
    // DK34: 20201130
    //   - Add Field: "Conversion Agency"

    Caption = 'Move The Grave';
    DrillDownPageID = "DK_Move The Grave List";
    LookupPageID = "DK_Move The Grave List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);

                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Move The Grave Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Move The Grave,Remodeling';
            OptionMembers = "Move The Grave",Remodeling;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
                if Rec.Type <> xRec.Type then begin
                    if Type = Type::Remodeling then begin
                        Service := Service::Blank;
                        Validate("Field Work Sub Cat. Code", '');
                    end else begin
                        "Ston Type" := "Ston Type"::Blank;
                    end;
                end;
            end;
        }
        field(3; Service; Option)
        {
            Caption = 'Service';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,Stead,Comfort,Sincerity';
            OptionMembers = Blank,Stead,Comfort,Sincerity;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
                if Rec.Service <> xRec.Service then begin
                    if (Type = Type::"Move The Grave") and
                       (Service = Service::Blank) then
                        Error(MSG002, FieldCaption(Type), Type::"Move The Grave", FieldCaption(Service));
                end;
            end;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Receipt,Completion';
            OptionMembers = Receipt,Completion;
        }
        field(5; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
            end;
        }
        field(6; TotalAmount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'TotalAmount';
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin

                TestField(Status, Status::Receipt);
                if Rec.TotalAmount <> xRec.TotalAmount then
                    CalAmount("Contract Amount", TotalAmount);
            end;
        }
        field(7; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
            end;
        }
        field(8; "Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Contract Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
                if Rec."Contract Amount" <> xRec."Contract Amount" then begin

                    if "Contract Amount" > TotalAmount then
                        Error(MSG004, FieldCaption(TotalAmount));

                    CalAmount("Contract Amount", TotalAmount);
                end
            end;
        }
        field(9; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
            end;
        }
        field(10; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No.";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                TestField(Status, Status::Receipt);
                if Rec."Contract No." <> xRec."Contract No." then begin
                    Delete_MoveLine;

                    if _Contract.Get("Contract No.") then begin
                        Validate("Supervise No.", _Contract."Supervise No.");
                        Validate("Cemetery Code", _Contract."Cemetery Code");
                        Validate("Main Customer No.", _Contract."Main Customer No.");
                    end else begin
                        Validate("Supervise No.", '');
                        Validate("Cemetery Code", '');
                        Validate("Main Customer No.", '');
                    end;
                end;

                CalcFields("Main Customer Name");
                CalcFields("Cust. Contact");
                CalcFields("Cust. E-mail");
                CalcFields("Cemetery No.");
                CalcFields("Cemetery Digits");
                CalcFields("Cust. Mobile No.");
            end;
        }
        field(11; "Main Customer Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Cust. Contact"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Contact';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Cust. Contact" <> "Cust. Contact" then begin
                    if "Cust. Contact" <> '' then
                        if not _CommFun.CheckValidPhoneNo("Cust. Contact") then
                            Error(MSG006, FieldCaption("Cust. Contact"));
                end;
            end;
        }
        field(13; "Cust. E-mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'E-mail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."Cust. E-mail" <> "Cust. E-mail" then begin

                    _MailMgt.ValidateEmailAddressField("Cust. E-mail");

                end;
            end;
        }
        field(14; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
            end;
        }
        field(15; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
            end;
        }
        field(16; "Cemetery Digits"; Text[50])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Dig. Name" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Digits';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                TestField(Status, Status::Receipt);
                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(18; "Employee Name"; Text[50])
        {
            Caption = 'Employee';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Employee No.", Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(19; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Cash,Card,Remittance';
            OptionMembers = Cash,Card,Remittance;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
            end;
        }
        field(20; Religion; Option)
        {
            Caption = 'Religion';
            DataClassification = ToBeClassified;
            OptionCaption = 'No Religion,Christian,Catholic,Buddhism';
            OptionMembers = "No Religion",Christian,Catholic,Buddhism;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
            end;
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(22; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(23; "Supervise No."; Code[20])
        {
            Caption = 'Contract Supervise No.';
            Editable = false;
        }
        field(24; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Cust. Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Cust. Mobile No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Cust. Mobile No." <> "Cust. Mobile No." then begin
                    if "Cust. Mobile No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Cust. Mobile No.") then
                            Error(MSG006, FieldCaption("Cust. Mobile No."));
                end;
            end;
        }
        field(26; "Ston Type"; Option)
        {
            Caption = 'Ston Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,A,B';
            OptionMembers = Blank,A,B;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
                if Rec."Ston Type" <> xRec."Ston Type" then begin
                    if (Type = Type::Remodeling) and
                      ("Ston Type" = "Ston Type"::Blank) then
                        Error(MSG002, FieldCaption(Type), Type::Remodeling, FieldCaption("Ston Type"));
                end;
            end;
        }
        field(27; "Contract Amount Date"; Date)
        {
            Caption = 'Contract Amount Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Remaining Amount Date"; Date)
        {
            Caption = 'Remaining Amount Date';
            DataClassification = ToBeClassified;
        }
        field(29; "Move Type"; Option)
        {
            Caption = 'Move Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Not Giving Up,Giving Up';
            OptionMembers = "None",NotGivingUp,GivingUp;
        }
        field(30; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then begin
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name
                end else
                    "Field Work Main Cat. Name" := '';
            end;
        }
        field(31; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Category Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", _FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(32; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                else
                    "Field Work Sub Cat. Name" := '';
            end;
        }
        field(33; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Category Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                Validate("Field Work Sub Cat. Code", _FieldWorkSubCategory.GetFieldWorkSCode("Field Work Sub Cat. Name", "Field Work Main Cat. Code"));
            end;
        }
        field(200; "Conversion Agency"; Option)
        {
            Caption = 'Conversion Agency';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,Necessary,Not Necessary,Complete';
            OptionMembers = Blank,Necessary,NotNecessary,Complete;

            trigger OnValidate()
            begin
                TestField(Status, Status::Receipt);
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
        _MoveTheGraveLine: Record "DK_Move The Grave Line";
    begin

        TestField(Status, Status::Receipt);

        _MoveTheGraveLine.Reset;
        _MoveTheGraveLine.SetRange("Document No.", "No.");
        if _MoveTheGraveLine.FindSet then
            _MoveTheGraveLine.DeleteAll(true);
    end;

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Move The Grave Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Move The Grave Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        _DepartmentBoard.Check_EmployeeUserID(UserId);

        if (Type = Type::"Move The Grave") and
             (Service = Service::Blank) then
            Message(MSG002, FieldCaption(Type), Type::"Move The Grave", FieldCaption(Service));

        //œÎ ‹Ý—
        Validate("Field Work Main Cat. Code", '002');

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        Employee: Record DK_Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'If the %1 is %2, it can not be modify or deleted.';
        MSG002: Label 'If the %1 is a %2, you must put in the %3.';
        MSG003: Label '%1 information is initialized. Would you like to continue?';
        MSG004: Label 'Please enter an amount less than the %1.';
        MSG005: Label 'Do you want to change the %1 Status?';
        MSG006: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';


    procedure AssistEdit(OldMoveTheGrave: Record "DK_Move The Grave"): Boolean
    var
        _MoveTheGrave: Record "DK_Move The Grave";
    begin
        with _MoveTheGrave do begin
            _MoveTheGrave := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Move The Grave Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Move The Grave Nos.", OldMoveTheGrave."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _MoveTheGrave;
                exit(true);
            end;
        end;
    end;


    procedure CalAmount(pContractAmount: Decimal; pTotalAmount: Decimal)
    begin

        if pTotalAmount = 0 then begin
            "Contract Amount" := 0;
            "Remaining Amount" := 0;
            exit;
        end;

        "Remaining Amount" := pTotalAmount - pContractAmount;
    end;


    procedure SetReceipt()
    begin

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;

        Status := Rec.Status::Receipt;
        Modify;
    end;


    procedure SetCompletion()
    begin
        CheckFiled;
        TestField("Completion Date");

        if not Confirm(MSG005, false, Status::Completion) then exit;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
        Status := Rec.Status::Completion;
        Modify;
    end;


    procedure CheckFiled()
    var
        _MoveTheGraveLine: Record "DK_Move The Grave Line";
    begin

        TestField("Contract No.");
        TestField("Receipt Date");
        TestField(TotalAmount);
        //TESTFIELD("Contract Amount");
        TestField("Employee Name");
        //TESTFIELD("Contract Amount Date");
        TestField("Remaining Amount Date");

        _MoveTheGraveLine.Reset;
        _MoveTheGraveLine.SetRange("Document No.", "No.");
        _MoveTheGraveLine.SetRange("Contract No.", "Contract No.");
        if _MoveTheGraveLine.FindSet then begin
            repeat
                _MoveTheGraveLine.TestField("Corpse Line No.");
            until _MoveTheGraveLine.Next = 0;
        end;

        if (Type = Type::"Move The Grave") and
             (Service = Service::Blank) then
            Error(MSG002, FieldCaption(Type), Type::"Move The Grave", FieldCaption(Service));

        if (Type = Type::Remodeling) and
             ("Ston Type" = "Ston Type"::Blank) then
            Error(MSG002, FieldCaption(Type), Type::Remodeling, FieldCaption("Ston Type"));
    end;


    procedure Delete_MoveLine()
    var
        _MoveTheGraveLine: Record "DK_Move The Grave Line";
    begin

        _MoveTheGraveLine.Reset;
        _MoveTheGraveLine.SetRange("Document No.", "No.");
        _MoveTheGraveLine.SetRange("Contract No.", "Contract No.");
        if _MoveTheGraveLine.FindSet then
            Rec.DeleteAll;
    end;
}

