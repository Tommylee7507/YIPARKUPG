table 50033 "DK_Counsel History"
{
    // //—¹ŽÊ…˜ ÐŽÊŠ ˜¡ˆÒí —Ñ“Ž˜…—……‡Ÿ Í“‹—Ÿ Œ÷‘ñ—¯.
    // 
    // #2113 - 2020-08-21
    //   - Add Filed Option String: Litigation Type - Legal complaint(‰²‰½‰ž°)
    // 
    // #2156: 2020-09-08
    //   - Modify Caption: Litigation Type - ŒÁ‰½ ‹Ý„Ì ‘Ž‡õ -> ×„ ‹Ý„Ì ‘Ž‡õ
    // 
    // DK34: 20201201
    //   - Add Field: "Department Code", "Department Name", "Last Payment Date", "General Expiration Date", "Land. Arc. Expiration Date"

    Caption = 'Counsel History';
    DataCaptionFields = "Contract No.", Date, "Supervise No.", Type;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No." WHERE(Status = FILTER(<> Revocation));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                TestField("Result Process", "Result Process"::Receipt);

                if _Contract.Get("Contract No.") then begin
                    Validate("Cemetery Code", _Contract."Cemetery Code");
                    Validate("Supervise No.", _Contract."Supervise No.");
                end else begin
                    Validate("Cemetery Code", '');
                    Validate("Supervise No.", '');
                end;
            end;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                TestField("Result Process", "Result Process"::Receipt);

                if _Cemetery.Get("Cemetery Code") then
                    "Cemetery No." := _Cemetery."Cemetery No."
                else
                    "Cemetery No." := '';
            end;
        }
        field(5; "Cemetery No."; Text[50])
        {
            Caption = 'Cemetery No.';
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Validate("Cemetery Code", _Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(6; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(7; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                TestField("Result Process", "Result Process"::Receipt);

                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(8; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                TestField("Result Process", "Result Process"::Receipt);

                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(9; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'General,Litigation';
            OptionMembers = General,Litigation;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(11; "Counsel Content"; Text[2000])
        {
            Caption = 'Counsel Content';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(13; "Process Content"; Text[2000])
        {
            Caption = 'Process Content';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Result Process" = "Result Process"::Completed then
                    Error(MSG002, FieldCaption("Result Process"), FieldCaption("Process Content"));
            end;
        }
        field(14; "Result Process"; Option)
        {
            Caption = 'Result Process';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Receipt,Processing,Completed';
            OptionMembers = Receipt,Processing,Completed;
        }
        field(15; "Deposit Plan Date"; Date)
        {
            Caption = 'Deposit Plan Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
                if xRec."Deposit Plan Date" <> "Deposit Plan Date" then begin

                    if Type = Type::Litigation then begin
                        UpdateContractDepositPlanDate("Contract No.", "Line No.", "Deposit Plan Date");
                    end;
                end;
            end;
        }
        field(16; "Litigation Type"; Option)
        {
            Caption = 'Litigation Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Reception,Sending,Talk,SMS,Etc.,Mail,Law,Visit,Agree,Open Request,Legal complaint';
            OptionMembers = Blank,Reception,Sending,Talk,SMS,Etc,Mail,Law,Visit,Agree,OpenRequest,Legalcomplaint;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(17; "Contact Method"; Option)
        {
            Caption = 'Contact Method';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mobile,Home,Work,Etc.,Certification of Contents';
            OptionMembers = Blank,Mobile,Home,Work,Etc,CoC;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(18; "Counsel Target"; Option)
        {
            Caption = 'Counsel Target';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Principal,Spouse,Children,Mother,Father,Brother,Relatives,Friend,Others,Etc.';
            OptionMembers = Blank,Principal,Spouse,Children,Mother,Father,Brother,Relatives,Friend,Others,Etc;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(19; "Counsel Level 1"; Option)
        {
            Caption = 'Counsel Level 1';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,General,Funeral,Dispatch,1:1 Care,Etc.';
            OptionMembers = Blank,General,Funeral,Dispatch,Care,Etc;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(20; "Counsel Level Code 2"; Code[20])
        {
            Caption = 'Counsel Level Code 2';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Counsel Level 2" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);

                if CounselLevel2.Get("Counsel Level Code 2") then
                    "Counsel Level Name 2" := CounselLevel2.Name
                else
                    "Counsel Level Name 2" := '';
            end;
        }
        field(21; "Counsel Level Name 2"; Text[50])
        {
            Caption = 'Counsel Level 2';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Counsel Level 2" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);

                Validate("Counsel Level Code 2", CounselLevel2.GetCode("Counsel Level Name 2"));
            end;
        }
        field(22; "Issue of membership"; Boolean)
        {
            Caption = 'Issue of membership';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(23; "Litigation Content"; BLOB)
        {
            Caption = 'Litigation Content';
            DataClassification = ToBeClassified;
            SubType = Memo;

            trigger OnValidate()
            begin
                TestField("Result Process", "Result Process"::Receipt);
            end;
        }
        field(24; "Dev. Target Doc. No."; Code[20])
        {
            Caption = 'Dev. Target Doc. No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Dev. Target Header"."No.";
        }
        field(25; "Dev. Target Doc. Line No."; Integer)
        {
            Caption = 'Dev. Target Doc. No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Counsel Time"; Time)
        {
            Caption = 'Counsel Time';
            DataClassification = ToBeClassified;
        }
        field(30; "Request Del"; Boolean)
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
        field(31; "Request DateTime"; DateTime)
        {
            Caption = 'Request DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Request Person"; Code[50])
        {
            Caption = 'Request Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Delete Row"; Boolean)
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
        field(34; "Delete DateTime"; DateTime)
        {
            Caption = 'Delete Date/Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Delete Person"; Code[50])
        {
            Caption = 'Delete Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(200; "Last Payment Date"; Date)
        {
            CalcFormula = Max("DK_Payment Receipt Document"."Payment Date" WHERE("Document Type" = CONST(Receipt),
                                                                                  Posted = CONST(true),
                                                                                  "Contract No." = FIELD("Contract No.")));
            Caption = 'Last Payment Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(201; "General Expiration Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."General Expiration Date" WHERE("No." = FIELD("Contract No.")));
            Caption = 'General Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(202; "Land. Arc. Expiration Date"; Date)
        {
            CalcFormula = Lookup(DK_Contract."Land. Arc. Expiration Date" WHERE("Supervise No." = FIELD("Contract No.")));
            Caption = 'Land. Arc. Expiration Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(203; "Cemetery Class"; Option)
        {
            CalcFormula = Lookup(DK_Cemetery.Class WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Class';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'A,B,C,D';
            OptionMembers = A,B,C,D;
        }
        field(204; "Department Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Contract."Department Code" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Department Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(205; "Department Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Contract."Department Name" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Department Name';
            Editable = false;
            FieldClass = FlowField;
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
        field(59000; idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Contract No.", Type, "Dev. Target Doc. No.", "Dev. Target Doc. Line No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Cemetery Code")
        {
        }
        key(Key3; "Employee Name")
        {
        }
        key(Key4; "Employee No.")
        {
        }
        key(Key5; Date)
        {
        }
        key(Key6; Type)
        {
        }
        key(Key7; "Result Process")
        {
        }
        key(Key8; Type, Date, "Contract No.", "Line No.")
        {
        }
        key(Key9; Date, "Counsel Time", "Contract No.", "Line No.")
        {
        }
        key(Key10; "Request Del")
        {
        }
        key(Key11; "Request DateTime")
        {
        }
        key(Key12; "Request Person")
        {
        }
        key(Key13; "Delete Row")
        {
        }
        key(Key14; "Delete DateTime")
        {
        }
        key(Key15; "Delete Person")
        {
        }
        key(Key16; "Deposit Plan Date")
        {
        }
        key(Key17; "Litigation Type")
        {
        }
        key(Key18; "Contact Method")
        {
        }
        key(Key19; "Counsel Target")
        {
        }
        key(Key20; "Dev. Target Doc. No.")
        {
        }
        key(Key21; "Counsel Time")
        {
        }
        key(Key22; "Cemetery No.")
        {
        }
        key(Key23; Type, "Employee No.", Date, "Litigation Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //€——©
        if not CheckUserPermission then
            Error(MSG003);

        //¯€¦ ŽÊŒ®ŸÀ ÐŽ¸í Žð…Ñœ
        if Type = Type::Litigation then begin
            UpdateContractDepositPlanDate("Contract No.", "Line No.", 0D);
        end;
    end;

    trigger OnInsert()
    var
        _Employee: Record DK_Employee;
    begin
        TestField("Contract No.");

        //Check_EmployeeUserID;

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Contract No.");

        if Date < Today then begin
            if not CheckUserPermission then
                Error(MSG004);
        end;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        CounselLevel2: Record "DK_Counsel Level 2";
        MSG001: Label 'An unregistered %1. Please check the %2 information.';
        MSG002: Label 'The value can not be modified.';
        UserSetup: Record "User Setup";
        MSG003: Label 'The permission to delete does not exist. Please contact your administrator.';
        MSG004: Label 'Today records do not have permission to edit. Please contact your administrator.';


    procedure Check_EmployeeUserID()
    var
        _Employee: Record DK_Employee;
    begin
        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.IsEmpty then begin
            Error(MSG001, _Employee.FieldCaption("ERP User ID"), _Employee.TableCaption);
        end;
    end;


    procedure Check_Values()
    begin
        TestField("Contract No.");
        TestField("Employee No.");
        TestField("Counsel Content");
        if Type = Type::General then begin
            TestField("Counsel Level 1");
            TestField("Counsel Level Code 2");
        end else begin
            TestField("Litigation Type");
            TestField("Contact Method");
            TestField("Counsel Target");
        end;
    end;


    procedure SetReceipt()
    begin

        "Result Process" := "Result Process"::Receipt;
        Modify;
    end;


    procedure SetProcessig()
    begin

        Check_Values;

        "Result Process" := "Result Process"::Processing;
        Modify;
    end;


    procedure SetCompleted()
    begin
        if Type = Type::General then
            TestField("Process Content");

        "Result Process" := "Result Process"::Completed;
        Modify;
    end;

    procedure SetWorkLitigationContent(pNewLitigationContent: Text)
    var
        _TempBlob: Record TempBlob temporary;
    begin

        Clear("Litigation Content");
        if pNewLitigationContent = '' then
            exit;

        _TempBlob.Blob := "Litigation Content";
        _TempBlob.WriteAsText(pNewLitigationContent, TEXTENCODING::Windows);
        "Counsel Content" := CopyStr(pNewLitigationContent, 1, 200);
        "Litigation Content" := _TempBlob.Blob;
        Modify;
    end;

    procedure GetWorkLitigationContent(): Text
    begin

        CalcFields("Litigation Content");
        exit(GetWorkLitigationContentCalculated);
    end;

    procedure GetWorkLitigationContentCalculated(): Text
    var
        _TempBlob: Record TempBlob temporary;
        _CR: Text[1];
    begin

        if not "Litigation Content".HasValue then
            exit('');

        _CR[1] := 10;
        _TempBlob.Blob := "Litigation Content";
        exit(_TempBlob.ReadAsText(_CR, TEXTENCODING::Windows));
    end;

    local procedure CheckUserPermission(): Boolean
    begin

        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if Type = Type::General then
            UserSetup.SetRange("DK_General Counsel Admin.", true)
        else
            UserSetup.SetRange("DK_Litigation Counsel Admin.", true);
        if UserSetup.FindSet then
            exit(true);
    end;

    local procedure UpdateContractDepositPlanDate(pContractNo: Code[20]; pLineNo: Integer; pDepositPlanDate: Date)
    var
        _Contract: Record DK_Contract;
        _CounselHistory: Record "DK_Counsel History";
    begin

        _Contract.Reset;
        _Contract.SetRange("No.", pContractNo);
        if _Contract.FindSet then begin

            if pDepositPlanDate = 0D then begin

                _CounselHistory.Reset;
                _CounselHistory.SetCurrentKey("Deposit Plan Date");
                _CounselHistory.SetRange("Contract No.", pContractNo);
                _CounselHistory.SetFilter("Deposit Plan Date", '<>%1', 0D);
                if _CounselHistory.FindLast then begin
                    _Contract."Last Deposit Plan Date" := pDepositPlanDate;
                    _Contract."Counsel Line No." := pLineNo;
                end else begin
                    _Contract."Last Deposit Plan Date" := 0D;
                    _Contract."Counsel Line No." := 0;
                end;
            end else begin
                if _Contract."Counsel Line No." = pLineNo then begin
                    _Contract."Last Deposit Plan Date" := pDepositPlanDate;
                end else begin
                    if _Contract."Last Deposit Plan Date" <> 0D then begin
                        if _Contract."Last Deposit Plan Date" < pDepositPlanDate then begin
                            _Contract."Last Deposit Plan Date" := pDepositPlanDate;
                            _Contract."Counsel Line No." := pLineNo;

                        end;
                    end else begin
                        _Contract."Last Deposit Plan Date" := pDepositPlanDate;
                        _Contract."Counsel Line No." := pLineNo;
                    end;
                end;
            end;

            _Contract.Modify;
        end;
    end;
}

