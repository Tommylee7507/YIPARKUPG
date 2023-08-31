table 50093 "DK_Litigation Lawsuit History"
{
    // 
    // # 2107 - 2020-08-18
    //   -  Modify Trigger: Contract No. - OnValidate, Cemetery Code - OnValidate, Cemetery No. - OnValidate

    Caption = 'Litigation Lawsuit History';
    DataCaptionFields = "Lawsuit Method", "Lawsuit Status";

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No.";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _LitigationLawsuitHistory: Record "DK_Litigation Lawsuit History";
            begin
                TestField(Status, Status::Open);

                if _Contract.Get("Contract No.") then begin
                    Validate("Cemetery Code", _Contract."Cemetery Code");
                    Validate("Supervise No.", _Contract."Supervise No.");
                end else begin
                    Validate("Cemetery Code", '');
                    Validate("Supervise No.", '');
                end;

                // >> #2107
                _LitigationLawsuitHistory.Reset;
                _LitigationLawsuitHistory.SetRange("Contract No.", "Contract No.");
                if _LitigationLawsuitHistory.FindLast then
                    "Line No." := _LitigationLawsuitHistory."Line No." + 10000
                else
                    "Line No." := 10000;
                // <<
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(4; "Lawsuit Status"; Option)
        {
            Caption = 'Lawsuit Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Apply,Correction,Proceeding,adjudicated';
            OptionMembers = Apply,Correction,Proceeding,adjudicated;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(5; "Lawsuit Method"; Option)
        {
            Caption = 'Lawsuit Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'Electronic,General';
            OptionMembers = Electronic,General;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(6; "Lawsuit Type"; Text[50])
        {
            Caption = 'Lawsuit Type';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(7; "Process Content"; Text[250])
        {
            Caption = 'Process Content';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(9; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(10; "Employee No."; Code[20])
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
        field(11; "Employee Name"; Text[30])
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
        field(12; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin

                // >> #2107
                if _Cemetery.Get("Cemetery Code") then
                    "Cemetery No." := _Cemetery."Cemetery No."
                else
                    "Cemetery No." := '';
                // <<
            end;
        }
        field(14; "Cemetery No."; Text[50])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                // >> #2107
                Validate("Cemetery Code", _Cemetery.GetCemeteryCode("Cemetery No."));
                // <<
            end;
        }
        field(15; "Request Del"; Boolean)
        {
            Caption = 'Request Del';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Request Del" <> "Request Del" then begin
                    if "Request Del" then begin
                        "Request DateTime" := CurrentDateTime;
                        "Request Person" := UserId;
                    end else begin
                        "Request DateTime" := DaTi2Variant(0D, 0T);
                        "Request Person" := '';
                    end;
                end;
            end;
        }
        field(16; "Request DateTime"; DateTime)
        {
            Caption = 'Request DateTime';
            DataClassification = ToBeClassified;
        }
        field(17; "Request Person"; Code[50])
        {
            Caption = 'Request Person';
            DataClassification = ToBeClassified;
        }
        field(18; "Delete Row"; Boolean)
        {
            Caption = 'Delete Row';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Delete Row" <> "Delete Row" then begin
                    if "Delete Row" then begin
                        "Delete DateTime" := CreateDateTime(Today, Time);
                        "Delete Person" := UserId;
                    end else begin
                        "Delete DateTime" := CreateDateTime(0D, 0T);
                        "Delete Person" := '';
                    end;
                end;
            end;
        }
        field(19; "Delete DateTime"; DateTime)
        {
            Caption = 'Delete Date/Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Delete Person"; Code[50])
        {
            Caption = 'Delete Person';
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
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Contract No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Lawsuit Status")
        {
        }
        key(Key3; "Lawsuit Method")
        {
        }
        key(Key4; "Lawsuit Type")
        {
        }
        key(Key5; Date)
        {
        }
        key(Key6; "Request Del")
        {
        }
        key(Key7; "Request DateTime")
        {
        }
        key(Key8; "Request Person")
        {
        }
        key(Key9; "Delete Row")
        {
        }
        key(Key10; "Delete DateTime")
        {
        }
        key(Key11; "Delete Person")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);

        if not CheckUserPermission then
            Error(MSG001);
    end;

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin
        TestField(Date);
        //_DepartmentBoard.Check_EmployeeUserID(USERID);

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField(Date);
        TestField(Status, Status::Open);

        if Date < Today then begin
            if not CheckUserPermission then
                Error(MSG002);
        end;


        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'The permission to delete does not exist. Please contact your administrator.';
        MSG002: Label 'Today records do not have permission to edit. Please contact your administrator.';


    procedure SetReOpen()
    begin

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetRelease()
    begin

        TestField("Lawsuit Type");
        TestField("Process Content");

        Status := Rec.Status::Release;
        Modify;
    end;

    local procedure CheckUserPermission(): Boolean
    var
        _UserSetup: Record "User Setup";
    begin
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Law History Admin.", true);
        if _UserSetup.FindSet then
            exit(true);
    end;
}

