table 50074 "DK_Field Work Header"
{
    Caption = 'Field Work Header';
    DataCaptionFields = "No.", "Field Work Main Cat. Name", "Field Work Sub Cat. Name", "Work Division";
    DrillDownPageID = "DK_Field Work List";
    LookupPageID = "DK_Field Work List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatus_Open;
                Connect_Check;
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Field Work Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release,Post,Impossible';
            OptionMembers = Open,Release,Post,Impossible;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatus_Open;

                if xRec.Date <> Rec.Date then begin
                    if "Source Type" = "Source Type"::Today then
                        Connect_Check;
                end;
            end;
        }
        field(4; "Time From"; Time)
        {
            Caption = 'Time From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatus_Impossible;
                if Rec."Time From" <> xRec."Time From" then begin
                    CalcTime("Time From", "Time to");
                end;
            end;
        }
        field(5; "Time to"; Time)
        {
            Caption = 'Time to';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckStatus_Impossible;

                if Rec."Time to" <> xRec."Time to" then begin
                    CalcTime("Time From", "Time to");
                end;
            end;
        }
        field(6; "Time Spent"; Text[30])
        {
            Caption = 'Time Spent';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; TotalAmount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'TotalAmount';
            Editable = false;
            MinValue = 0;
        }
        field(8; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                CheckStatus_Open;
                Connect_Check;

                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then begin
                    if _FieldWorkMainCategory."Connect Work" then
                        Error(MSG005, _FieldWorkMainCategory.TableCaption, _FieldWorkMainCategory.FieldCaption("Connect Work"));
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name
                end else
                    "Field Work Main Cat. Name" := '';

                Validate("Field Work Sub Cat. Code", '');
            end;
        }
        field(9; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category" WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(10; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
                _FieldWorkPost: Codeunit "DK_Field Work - Post";
            begin
                CheckStatus_Open;
                //Connect_Check;

                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name
                else
                    "Field Work Sub Cat. Name" := '';

                if "Field Work Sub Cat. Code" <> xRec."Field Work Sub Cat. Code" then
                    _FieldWorkPost.InsertItemLine(Rec);
            end;
        }
        field(11; "Field Work Sub Cat. Name"; Text[30])
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
        field(12; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkGroup: Record "DK_Work Group";
            begin
                CheckStatus_Impossible;

                if _WorkGroup.Get("Work Group Code") then
                    "Work Group Name" := _WorkGroup.Name
                else
                    "Work Group Name" := '';
            end;
        }
        field(13; "Work Group Name"; Text[30])
        {
            Caption = 'Work Group Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Work Group Code", WorkGroup.GetWorkGroupCode("Work Group Name"));
            end;
        }
        field(14; "Work Personnel"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Work Personnel';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(15; "Work Manager Code"; Code[20])
        {
            Caption = 'Work Manager Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Manager".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _WorkManager: Record "DK_Work Manager";
            begin
                CheckStatus_Impossible;

                if _WorkManager.Get("Work Manager Code") then
                    "Work Manager Name" := _WorkManager.Name
                else
                    "Work Manager Name" := '';
            end;
        }
        field(16; "Work Manager Name"; Text[30])
        {
            Caption = 'Work Manager Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Work Manager".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin

                Validate("Work Manager Code", WorkManager.GetWorkManagerCode("Work Manager Name"));
            end;
        }
        field(17; "Work Before Picture"; BLOB)
        {
            Caption = 'Work Before Picture';
            DataClassification = ToBeClassified;
            SubType = Bitmap;

            trigger OnValidate()
            var
                _TempBlob: Record TempBlob temporary;
                _CommFun: Codeunit "DK_Common Function";
            begin
                /*CALCFIELDS("Work Before Picture");
                IF "Work Before Picture".HASVALUE THEN BEGIN
                  CheckStatus_Impossible;
                
                  _TempBlob.Blob := "Work Before Picture";
                  CLEAR(_CommFun);
                  _CommFun.ResizeImage(_TempBlob,TRUE,TRUE,300,300);
                  "Work Before Picture" := _TempBlob.Blob;
                END;*/

            end;
        }
        field(18; "Work after Picture"; BLOB)
        {
            Caption = 'Work after Picture';
            Compressed = false;
            DataClassification = ToBeClassified;
            SubType = Bitmap;

            trigger OnValidate()
            var
                _TempBlob: Record TempBlob temporary;
                _CommFun: Codeunit "DK_Common Function";
            begin
                /*CALCFIELDS("Work after Picture");
                IF "Work after Picture".HASVALUE THEN BEGIN
                  CheckStatus_Impossible;
                
                  _TempBlob.Blob := "Work after Picture";
                  CLEAR(_CommFun);
                  _CommFun.ResizeImage(_TempBlob,TRUE,TRUE,300,300);
                  "Work after Picture" := _TempBlob.Blob;
                END ELSE BEGIN
                  CLEAR("Work after Picture");
                END;
                */

            end;
        }
        field(19; Memo; BLOB)
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields(Memo);
                if Memo.HasValue then
                    CheckStatus_Impossible;
            end;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(21; "Short Memo"; Text[250])
        {
            Caption = 'Short Memo';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Short Memo" <> Rec."Short Memo" then
                    CheckStatus_Impossible;
            end;
        }
        field(22; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Estate,Cemetery';
            OptionMembers = Estate,Cemetery;

            trigger OnValidate()
            var
                _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
            begin
                if Rec.Type <> xRec.Type then begin
                    CheckStatus_Open;
                    Connect_Check;
                    _FieldWorkLineCemetery.Reset;
                    _FieldWorkLineCemetery.SetRange("Document No.", "No.");
                    if _FieldWorkLineCemetery.FindSet then begin
                        if not Confirm(MSG003, false, FieldCaption(Type), _FieldWorkLineCemetery.TableCaption) then begin
                            Type := xRec.Type;
                            exit;
                        end;
                        _FieldWorkLineCemetery.DeleteAll;
                    end;
                end;
            end;
        }
        field(23; "Work Division"; Option)
        {
            Caption = 'Work Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Urgency';
            OptionMembers = Normal,Urgency;

            trigger OnValidate()
            begin

                if xRec."Work Division" <> Rec."Work Division" then begin
                    CheckStatus_Open;
                    Connect_Check;
                end
            end;
        }
        field(24; "Customer Rec. Contents"; Text[250])
        {
            Caption = 'Customer Receipt Contents';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CustomerRequests: Record "DK_Customer Requests";
            begin

                if xRec."Customer Rec. Contents" <> Rec."Customer Rec. Contents" then begin
                    CheckStatus_Open;
                    Connect_Check;
                end;
            end;
        }
        field(25; "Customer Rec. Date"; Date)
        {
            Caption = 'Customer Rec. Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _CustomerRequests: Record "DK_Customer Requests";
            begin

                if xRec."Customer Rec. Date" <> Rec."Customer Rec. Date" then begin
                    CheckStatus_Open;
                    Connect_Check;
                end;
            end;
        }
        field(26; "Process Content"; Text[250])
        {
            Caption = 'Process Content';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Process Content" <> Rec."Process Content" then begin
                    CheckStatus_Impossible;
                end;
            end;
        }
        field(27; "Appl. Name"; Text[30])
        {
            Caption = 'Appl. Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Appl. Name" <> Rec."Appl. Name" then begin
                    CheckStatus_Open;
                    Connect_Check;
                end;
            end;
        }
        field(28; "Appl. Mobile No."; Text[30])
        {
            Caption = 'Appl. Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Appl. Mobile No." <> Rec."Appl. Mobile No." then begin
                    CheckStatus_Open;
                    Connect_Check;
                end;
            end;
        }
        field(29; "Appl. Phone No."; Text[30])
        {
            Caption = 'Appl. Phone No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Appl. Phone No." <> Rec."Appl. Phone No." then begin
                    CheckStatus_Open;
                    Connect_Check;
                end;
            end;
        }
        field(30; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Today,Request,Service';
            OptionMembers = Blank,Today,Request,Service;
        }
        field(32; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(33; "Work Time Spent"; Integer)
        {
            Caption = 'Work Time Spent';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FieldWorkPost: Codeunit "DK_Field Work - Post";
            begin
                if "Work Time Spent" <> xRec."Work Time Spent" then begin
                    if "Work Time Spent" <> 0 then
                        _FieldWorkPost.SetWorkCostAmount(Rec);
                end;
            end;
        }
        field(34; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(35; "Corpse Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Today Funeral Line".Name WHERE("Document No." = FIELD("Source No."),
                                                                     "Line No." = FIELD("Source Line No.")));
            Caption = 'Corpse Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Picture Send"; Boolean)
        {
            Caption = 'Picture Send';
            DataClassification = ToBeClassified;
        }
        field(37; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Field Work Line Item".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'TotalAmount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Work Before Image"; Media)
        {
            Caption = 'Work Before Image';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Person;
        }
        field(39; "Work after Image"; Media)
        {
            Caption = 'Work after Image';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Person;
        }
        field(40; "Work Before Attached Name"; Text[100])
        {
            Caption = 'Work Before Attached Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41; "Work After Attached Name"; Text[100])
        {
            Caption = 'Work After Attached Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; "Source Cemetery No."; Text[30])
        {
            CalcFormula = Max("DK_Field Work Line Cemetery"."Use Area" WHERE("Document No." = FIELD("No.")));
            Caption = 'Source Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Funeral Type Code"; Code[20])
        {
            Caption = 'Funeral Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Funeral Type".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _FuneralType: Record "DK_Funeral Type";
            begin
                if _FuneralType.Get("Funeral Type Code") then
                    "Funeral Type Name" := _FuneralType.Name
                else
                    "Funeral Type Name" := '';
            end;
        }
        field(44; "Funeral Type Name"; Text[30])
        {
            Caption = 'Funeral Type Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Funeral Type".Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FuneralType: Record "DK_Funeral Type";
            begin
                Validate("Funeral Type Code", _FuneralType.GetFuneralTypeCode("Funeral Type Name"));
            end;
        }
        field(45; "SMS Not Sent"; Boolean)
        {
            Caption = 'SMS Not Sent';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "SMS Not Sent" <> xRec."SMS Not Sent" then begin
                    if "SMS Not Sent" then
                        "Picture Send" := true
                    else
                        "Picture Send" := false;
                end;
            end;
        }
        field(46; "Corpse Quantity"; Integer)
        {
            CalcFormula = Count("DK_Today Funeral Line" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Corpse Quantity';
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
        field(5004; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5005; "Full Name"; Text[80])
        {
            Caption = 'Full Name';
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
        key(Key2; Type)
        {
        }
        key(Key3; Status)
        {
        }
        key(Key4; Date)
        {
        }
        key(Key5; "Field Work Main Cat. Code")
        {
        }
        key(Key6; "Field Work Main Cat. Name")
        {
        }
        key(Key7; "Field Work Sub Cat. Code")
        {
        }
        key(Key8; "Field Work Sub Cat. Name")
        {
        }
        key(Key9; "Work Time Spent")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Status, Date, "Field Work Sub Cat. Name", TotalAmount, "Work Time Spent")
        {
        }
    }

    trigger OnDelete()
    var
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _CustomerRequests: Record "DK_Customer Requests";
    begin

        TestField(Status, Status::Open);

        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Document No.", "No.");
        if _FieldWorkLineItem.FindSet then
            _FieldWorkLineItem.DeleteAll(true);

        _FieldWorkLineCemetery.Reset;
        _FieldWorkLineCemetery.SetRange("Document No.", "No.");
        if _FieldWorkLineCemetery.FindSet then
            _FieldWorkLineCemetery.DeleteAll(true);

        Connect_OnDelete;
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Field Work Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Field Work Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        Employee: Record DK_Employee;
        FieldWorkMainCategory: Record "DK_Field Work Main Category";
        FieldWorkSubCategory: Record "DK_Field Work Sub Category";
        MSG001: Label 'If the %1 is %2, it can not be Modify.';
        WorkGroup: Record "DK_Work Group";
        WorkManager: Record "DK_Work Manager";
        MSG002: Label 'The %2 can not be greater than the %1.';
        MSG003: Label 'If you change the %1, the %2 will be initialized. Do you want to continue?';
        MSG004: Label 'It can not be corrected because it is a document accepted by the %1.';
        MSG005: Label 'You can not select this because %1 is set to %2.';
        MSG006: Label 'No %1 is entered.';


    procedure AssistEdit(OldReqFieldWorkHeader: Record "DK_Field Work Header"): Boolean
    begin
        with OldReqFieldWorkHeader do begin
            OldReqFieldWorkHeader := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Field Work Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Field Work Nos.", OldReqFieldWorkHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldReqFieldWorkHeader;
                exit(true);
            end;
        end;
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


    procedure CalcTime(pTimeFrom: Time; pTimeTo: Time)
    var
        _Duration: Duration;
    begin
        if (pTimeTo < pTimeFrom) and
          (pTimeTo <> 0T) then
            Error(MSG002, FieldCaption("Time From"), FieldCaption("Time to"));

        if (pTimeFrom = 0T) or
          (pTimeTo = 0T) then begin
            "Time Spent" := '';
            Modify;
        end else begin
            _Duration := pTimeTo - pTimeFrom;
            "Time Spent" := Format(_Duration);
            Modify;
        end;
    end;


    procedure SetOpen()
    begin

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetRelease()
    var
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _DK_FieldWorkLineItem: Record "DK_Field Work Line Item";
    begin
        TestField("No.");
        TestField(Date);
        TestField("Field Work Main Cat. Code");
        TestField("Field Work Sub Cat. Code");

        _FieldWorkLineCemetery.Reset;
        _FieldWorkLineCemetery.SetCurrentKey("Line No.");
        _FieldWorkLineCemetery.SetRange("Document No.", "No.");
        if not _FieldWorkLineCemetery.FindSet then
            Error(MSG006, _FieldWorkLineCemetery.TableCaption);

        _DK_FieldWorkLineItem.Reset;
        _DK_FieldWorkLineItem.SetRange("Document No.", "No.");
        _DK_FieldWorkLineItem.CalcSums(Amount);

        TotalAmount := _DK_FieldWorkLineItem.Amount;
        Status := Rec.Status::Release;
        Modify;
    end;


    procedure Connect_Check()
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _TodayFuneral: Record "DK_Today Funeral";
        _CemeteryServices: Record "DK_Cemetery Services";
    begin
        if "Source No." = '' then exit;
        case "Source Type" of
            "Source Type"::Request:
                begin
                    _CustomerRequests.Reset;
                    _CustomerRequests.SetRange("No.", "Source No.");
                    if _CustomerRequests.FindSet then
                        Error(MSG004, _CustomerRequests.TableCaption);
                end;
            "Source Type"::Today:
                begin
                    _TodayFuneral.Reset;
                    _TodayFuneral.SetRange("No.", "Source No.");
                    if _TodayFuneral.FindSet then
                        Error(MSG004, _TodayFuneral.TableCaption);
                end;
            "Source Type"::Service:
                begin
                    _CemeteryServices.Reset;
                    _CemeteryServices.SetRange("No.", "Source No.");
                    if _CemeteryServices.FindSet then
                        Error(MSG004, _CemeteryServices.TableCaption);
                end;
        end;
    end;


    procedure Connect_OnDelete()
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _TodayFuneral: Record "DK_Today Funeral";
        _CemeteryServices: Record "DK_Cemetery Services";
    begin
        if "Source Type" = "Source Type"::Blank then exit;
        case "Source Type" of
            "Source Type"::Today:
                begin
                    _TodayFuneral.Reset;
                    _TodayFuneral.SetRange("No.", "Source No.");
                    _TodayFuneral.SetRange("Field Work Main Cat. Code", "Field Work Main Cat. Code");
                    _TodayFuneral.SetRange("Field Work Sub Cat. Code", "Field Work Sub Cat. Code");
                    if _TodayFuneral.FindSet then begin
                        _TodayFuneral.Status := _TodayFuneral.Status::Release;
                        _TodayFuneral.Modify;
                    end;
                end;
            "Source Type"::Request:
                begin
                    _CustomerRequests.Reset;
                    _CustomerRequests.SetRange("No.", "Source No.");
                    _CustomerRequests.SetRange("Field Work Header No.", "No.");
                    _CustomerRequests.SetRange("Field Work Main Cat. Code", "Field Work Main Cat. Code");
                    _CustomerRequests.SetRange("Field Work Sub Cat. Code", "Field Work Sub Cat. Code");
                    if _CustomerRequests.FindSet then begin
                        _CustomerRequests.Status := _CustomerRequests.Status::Post;
                        _CustomerRequests.Modify;
                    end;
                end;
            "Source Type"::Service:
                begin
                    _CemeteryServices.Reset;
                    _CemeteryServices.SetRange("No.", "Source No.");
                    _CemeteryServices.SetRange("Field Work Main Cat. Code", "Field Work Main Cat. Code");
                    _CemeteryServices.SetRange("Field Work Sub Cat. Code", "Field Work Sub Cat. Code");
                    if _CemeteryServices.FindSet then begin
                        _CemeteryServices.Status := _CemeteryServices.Status::Release;
                        _CemeteryServices.Modify;
                    end;
                end;
        end;
    end;


    procedure CheckStatus_Open()
    begin

        if Status <> Status::Open then begin
            Error(MSG001, FieldCaption(Status), Status);
        end;
    end;


    procedure CheckStatus_Impossible()
    begin

        if Status = Rec.Status::Impossible then begin
            Error(MSG001, FieldCaption(Status), Status);
        end;
    end;
}

