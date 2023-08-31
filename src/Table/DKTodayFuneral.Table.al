table 50061 "DK_Today Funeral"
{
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #1997: 2020-07-08
    //   - Modify Validate: Field Work Main Cat. Code - OnValidate()
    // 
    // DK34: 20201130
    //   - Add Field: "Move The Grave Type"

    Caption = 'Today Funeral';
    DataCaptionFields = "Funeral Type", Date, "Cemetery No.", Applicant, "Mobile No.";
    DrillDownPageID = "DK_Today Funeral List";
    LookupPageID = "DK_Today Funeral List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_FieldWork;
                TestField(Status, Status::Open);
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Today Funeral Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Funeral Type"; Option)
        {
            Caption = 'Funeral Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Funeral,Move The Grave';
            OptionMembers = Funeral,Move;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                TestField(Status, Status::Open);
                Check_FieldWork;
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork;
            end;
        }
        field(4; "Arrival Time"; Time)
        {
            Caption = 'Arrival Time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                Check_FieldWork;
            end;
        }
        field(5; "Opening Time"; Time)
        {
            Caption = 'Opening Time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //TESTFIELD(Status,Status::Open);
                //Check_FieldWork;
            end;
        }
        field(6; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(7; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(8; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(9; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //TESTFIELD(Status,Status::Open);
            end;
        }
        field(10; Applicant; Text[30])
        {
            Caption = 'Applicant';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                TestField(Status, Status::Open);

                if xRec."Phone No." <> "Phone No." then begin
                    if "Phone No." <> '' then
                        if not _CommFun.CheckValidPhoneNo("Phone No.") then
                            Error(MSG004, FieldCaption("Phone No."));
                end;
            end;
        }
        field(12; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                TestField(Status, Status::Open);

                if "Mobile No." <> xRec."Mobile No." then begin
                    if "Mobile No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Mobile No.") then
                            Error(MSG004, FieldCaption("Mobile No."));
                end;
            end;
        }
        field(13; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
            begin
                Check_FieldWork;
                TestField(Status, Status::Open);
                if _Cemetery.Get("Cemetery Code") then begin
                    "Cemetery No." := _Cemetery."Cemetery No.";
                    Size := _Cemetery.Size;
                    "Cemetery Digits" := _Cemetery."Cemetery Dig. Name";
                end else begin
                    "Cemetery No." := '';
                    Size := 0;
                    "Cemetery Digits" := '';
                end
            end;
        }
        field(14; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            Editable = false;

            trigger OnValidate()
            begin
                Validate("Cemetery Code", Cemetery.GetCemeteryCode("Cemetery No."));
            end;
        }
        field(15; Size; Decimal)
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(16; "Working Group Code"; Code[20])
        {
            Caption = 'Working Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                //Check_FieldWork;
                //TESTFIELD(Status,Status::Open);
                if WorkGroup.Get("Working Group Code") then
                    "Working Group Name" := WorkGroup.Name
                else
                    "Working Group Name" := '';
            end;
        }
        field(17; "Working Group Name"; Text[50])
        {
            Caption = 'Working Group Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Working Group Code", WorkGroup.GetWorkGroupCode("Working Group Name"));
            end;
        }
        field(18; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release,Post,Complete';
            OptionMembers = Open,Release,Post,Complete;

            trigger OnValidate()
            begin
                //IF Status <> xRec.Status THEN
                //  Check_Status;
            end;
        }
        field(19; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(20; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false),
                                                                      "Funeral Type" = FILTER(<> Blank));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Check_FieldWork;
                TestField(Status, Status::Open);
                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then begin
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name
                end else
                    "Field Work Main Cat. Name" := '';

                Validate("Field Work Sub Cat. Code", '');

                //>> #1997
                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then begin
                    if _FieldWorkMainCategory."Funeral Type" = _FieldWorkMainCategory."Funeral Type"::Move then
                        Validate("Funeral Type", "Funeral Type"::Move)
                    else
                        Validate("Funeral Type", "Funeral Type"::Funeral);
                end else
                    Validate("Funeral Type", "Funeral Type"::Funeral);
                //<<

                SetTodayFuneralLine;
            end;
        }
        field(21; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false),
                                                                      "Funeral Type" = FILTER(<> Blank));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Field Work Main Cat. Code", FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(22; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                Check_FieldWork;
                TestField(Status, Status::Open);
                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then begin
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name;
                end else begin
                    "Field Work Sub Cat. Name" := '';
                end
            end;
        }
        field(23; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Field Work Sub Cat. Code", FieldWorkSubCategory.GetFieldWorkSCode("Field Work Sub Cat. Name", "Field Work Main Cat. Code"));
            end;
        }
        field(24; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No." WHERE(Status = FILTER(<> Revocation));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _TodayFuneralLine: Record "DK_Today Funeral Line";
            begin
                TestField(Status, Status::Open);
                if _Contract.Get("Contract No.") then begin
                    Validate("Supervise No.", _Contract."Supervise No.");
                    Validate("Cemetery Code", _Contract."Cemetery Code");
                    Validate("Main Customer No.", _Contract."Main Customer No.");
                end else begin
                    Validate("Supervise No.", '');
                    Validate("Cemetery Code", '');
                    Validate("Main Customer No.", '');
                end;

                SetTodayFuneralLine;
            end;
        }
        field(25; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
            begin
                _TodayFuneralPost.Insert_CustomerInfo(Rec);
            end;
        }
        field(27; "Cemetery Digits"; Text[30])
        {
            Caption = 'Cemetery Digits';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(100; "Document 1"; Boolean)
        {
            Caption = 'Document 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(101; "Document 2"; Boolean)
        {
            Caption = 'Document 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(102; "Document 3"; Boolean)
        {
            Caption = 'Document 3';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(103; "Document 4"; Boolean)
        {
            Caption = 'Document 4';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(104; "Document 5"; Boolean)
        {
            Caption = 'Document 5';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(105; "Document 6"; Boolean)
        {
            Caption = 'Document 6';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(106; "Document 7"; Boolean)
        {
            Caption = 'Document 7';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(107; "Document 8"; Boolean)
        {
            Caption = 'Document 8';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(108; "Document 9"; Boolean)
        {
            Caption = 'Document 9';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(200; "Move The Grave Type"; Option)
        {
            Caption = 'Move The Grave Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Blank,NotGiveUp,GiveUp';
            OptionMembers = Blank,NotGiveUp,GiveUp;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
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
        field(59000; Idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Field Work Main Cat. Name")
        {
        }
        key(Key3; Applicant)
        {
        }
        key(Key4; Date)
        {
        }
        key(Key5; "Arrival Time")
        {
        }
        key(Key6; "Opening Time")
        {
        }
        key(Key7; Status, Date, "Working Group Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Field Work Main Cat. Name", Applicant, Date, "Arrival Time", "Opening Time")
        {
        }
    }

    trigger OnDelete()
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin
        TestField(Status, Status::Open);

        DelRequestDocumentRec("No.");

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", "No.");
        if _TodayFuneralLine.FindSet then
            _TodayFuneralLine.DeleteAll(true);
    end;

    trigger OnInsert()
    var
        _TodayFuneral: Record "DK_Today Funeral";
        _NewEntryNo: Integer;
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Today Funeral Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Today Funeral Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;


        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;


        InsertRequestDocument("No.");
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        WorkGroup: Record "DK_Work Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        FieldWorkMainCategory: Record "DK_Field Work Main Category";
        FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        MSG001: Label 'If the %1 is %2, you can not modify it.';
        Cemetery: Record DK_Cemetery;
        MSG002: Label 'Do you want to put the %2 information on the %1?';
        MSG003: Label 'It is a document transferred to the %1.';
        MSG004: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';


    procedure InsertRequestDocument(pDocNo: Code[20])
    var
        _ReqDocSetup: Record "DK_Request Doc. Setup";
        _ReqDocRec: Record "DK_Request Document Rec.";
        _NewLineNo: Integer;
    begin

        _ReqDocSetup.Reset;
        _ReqDocSetup.SetRange(Type, _ReqDocSetup.Type::Today);
        if _ReqDocSetup.FindFirst then begin
            DelRequestDocumentRec(pDocNo);
            repeat
                _NewLineNo += 1;

                _ReqDocRec.Reset;
                _ReqDocRec."Table ID" := DATABASE::"DK_Today Funeral";
                _ReqDocRec."Source No." := pDocNo;
                _ReqDocRec."Source Line No." := 0;
                _ReqDocRec."Line No." := _NewLineNo;
                _ReqDocRec."Document Name" := _ReqDocSetup."Document Name";
                _ReqDocRec.Insert;
            until _ReqDocSetup.Next = 0;
        end;
    end;

    local procedure DelRequestDocumentRec(pDocNo: Code[20])
    var
        _ReqDocRec: Record "DK_Request Document Rec.";
    begin
        _ReqDocRec.Reset;
        _ReqDocRec.SetRange("Table ID", DATABASE::"DK_Today Funeral");
        _ReqDocRec.SetRange("Source No.", pDocNo);
        _ReqDocRec.SetRange("Source Line No.", 0);
        if _ReqDocRec.FindFirst then
            _ReqDocRec.DeleteAll(true);
    end;


    procedure SetOpen()
    begin
        Check_FieldWork;

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetRelease()
    var
        _ToadyFuneralPost: Codeunit "DK_Today Funeral - Post";
    begin
        Check_FieldWork;
        if not _ToadyFuneralPost.CheckValue(Rec) then exit;

        Status := Rec.Status::Release;
        Modify;
    end;


    procedure SetComplete()
    var
        _ToadyFuneralPost: Codeunit "DK_Today Funeral - Post";
    begin
        Check_FieldWork;
        if not _ToadyFuneralPost.CheckValue(Rec) then exit;

        Status := Rec.Status::Complete;
        Modify;
    end;


    procedure AssistEdit(OldTodayFuneral: Record "DK_Today Funeral"): Boolean
    var
        _TodayFuneral: Record "DK_Today Funeral";
    begin
        with _TodayFuneral do begin
            _TodayFuneral := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Today Funeral Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Today Funeral Nos.", OldTodayFuneral."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _TodayFuneral;
                exit(true);
            end;
        end;
    end;


    procedure Check_FieldWork()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        if "No." <> '' then begin
            _FieldWorkHeader.Reset;
            _FieldWorkHeader.SetRange("Source No.", "No.");
            if _FieldWorkHeader.FindSet then begin
                Error(MSG003, _FieldWorkHeader.TableCaption);
            end;
        end;
    end;


    procedure SetTodayFuneralLine()
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetCurrentKey("Line No.");
        _TodayFuneralLine.SetRange("Document No.", "No.");
        if _TodayFuneralLine.FindSet then begin
            repeat
                _TodayFuneralLine."Corpse Line No." := 0;
                _TodayFuneralLine."Contract No." := "Contract No.";
                _TodayFuneralLine.Validate("Field Work Main Cat. Code", "Field Work Main Cat. Code");
                _TodayFuneralLine."Document Type" := "Funeral Type";
                _TodayFuneralLine.Modify;
            until _TodayFuneralLine.Next = 0;
        end;
    end;


    procedure Check_Status_BK()
    var
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _Cemetery: Record DK_Cemetery;
        _TodayFuneralPost: Codeunit "DK_Today Funeral - Post";
        _Corpse: Record DK_Corpse;
    begin
        if _Cemetery.Get("Cemetery Code") then begin
            if "Funeral Type" = "Funeral Type"::Funeral then begin
                case Status of
                    Status::Release:
                        begin
                            _Cemetery.Status := _Cemetery.Status::Reserved;
                            _Cemetery.Modify;
                        end;
                    Status::Post:
                        begin
                            _TodayFuneralPost.Delete_Corpse(Rec);

                            _Cemetery.Status := _Cemetery.Status::Contracted;
                            _Cemetery.Modify;
                        end;
                    Status::Complete:
                        begin
                            _TodayFuneralPost.Insert_Corpse(Rec);

                            _Cemetery.Status := _Cemetery.Status::Laying;
                            _Cemetery.Modify;
                        end;
                end;
            end else begin
                if Status = Rec.Status::Complete then begin
                    _TodayFuneralPost.Modify_Corpse(Rec);
                end;
            end;
        end;
    end;
}

