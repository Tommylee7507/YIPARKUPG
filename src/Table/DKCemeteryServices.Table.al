table 50085 "DK_Cemetery Services"
{
    Caption = 'Cemetery Services';
    DataCaptionFields = "No.";
    DrillDownPageID = "DK_Cem. Services List";
    LookupPageID = "DK_Cem. Services List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "No." <> xRec."No." then begin

                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Cem. Services Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release,Post,Complete';
            OptionMembers = Open,Release,Post,Complete;
        }
        field(3; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(4; "Work Date"; Date)
        {
            Caption = 'Work Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CemServicesPost: Codeunit "DK_Cem. Services - Post";
            begin
                //TESTFIELD(Status,Status::Open);
                _CemServicesPost.Check_ConnectWork(Rec);
            end;
        }
        field(5; "Desired Date"; Date)
        {
            Caption = 'Desired Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(6; "SMS Send Date"; Date)
        {
            Caption = 'SMS Send Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(7; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                TestField(Status, Status::Open);

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
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(9; Religion; Option)
        {
            Caption = 'Religion';
            DataClassification = ToBeClassified;
            OptionCaption = 'No Religion,Christian,Catholic,Buddhism';
            OptionMembers = "No Religion",Christian,Catholic,Buddhism;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(11; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Bank Transfer,Credit Card,Cash,Giro,Onlie Credit Card,Virtual Account';
            OptionMembers = "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(12; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _CemServicesPost: Codeunit "DK_Cem. Services - Post";
            begin
                TestField(Status, Status::Open);

                if "Contract No." <> xRec."Contract No." then begin
                    "Corpse Line No." := 0;
                    "Corpse Name" := '';
                end;

                if _Contract.Get("Contract No.") then begin
                    Validate("Supervise No.", _Contract."Supervise No.");
                    Validate("Cemetery Code", _Contract."Cemetery Code");
                    Validate("Main Customer No.", _Contract."Main Customer No.");
                end else begin
                    Validate("Supervise No.", '');
                    Validate("Cemetery Code", '');
                    Validate("Main Customer No.", '');
                end;
                CalcFields("Main Customer Name", "Cust. Mobile No.", "Cust. Phone No.", "Cust. E-mail"); //Customer
                CalcFields("Cemetery No.");

                _CemServicesPost.SetConnectSize(Rec);
            end;
        }
        field(13; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Customer;
        }
        field(15; "Main Customer Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Cust. Mobile No."; Text[30])
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
                            Error(MSG007, FieldCaption("Cust. Mobile No."));
                end;
            end;
        }
        field(17; "Cust. Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Cust. Phone No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if "Cust. Phone No." <> '' then begin
                    if not _CommFun.CheckValidPhoneNo("Cust. Phone No.") then
                        Error(MSG007, FieldCaption("Cust. Phone No."));
                end;
            end;
        }
        field(18; "Cust. E-mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Cust. E-mail';
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
        field(19; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields(Size);
            end;
        }
        field(20; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            FieldClass = FlowField;
        }
        field(21; "Corpse Name"; Text[30])
        {
            Caption = 'Corpse Name';

            trigger OnLookup()
            var
                _Corpse: Record DK_Corpse;
                _CorpseList: Page "DK_Corpse List";
            begin
                _Corpse.Reset;
                _Corpse.FilterGroup(2);
                _Corpse.SetRange("Contract No.", Rec."Contract No.");
                _Corpse.FilterGroup(0);

                Clear(_CorpseList);
                _CorpseList.LookupMode(true);
                _CorpseList.SetTableView(_Corpse);
                _CorpseList.SetRecord(_Corpse);
                if _CorpseList.RunModal = ACTION::LookupOK then begin
                    _CorpseList.GetRecord(_Corpse);
                    "Corpse Line No." := _Corpse."Line No.";
                    "Corpse Name" := _Corpse.Name;
                    "Date Of Birth" := _Corpse."Date Of Birth";
                    "Death Date" := _Corpse."Death Date";
                end;
            end;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(22; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(24; "Work Division"; Option)
        {
            Caption = 'Work Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Urgency';
            OptionMembers = Normal,Urgency;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(25; "Field Work Main Cat. Code"; Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false),
                                                                      "Cemetery Services" = CONST(true));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
                _CemServicesPost: Codeunit "DK_Cem. Services - Post";
            begin
                TestField(Status, Status::Open);

                if _FieldWorkMainCategory.Get("Field Work Main Cat. Code") then
                    "Field Work Main Cat. Name" := _FieldWorkMainCategory.Name
                else
                    "Field Work Main Cat. Name" := '';

                Validate("Field Work Sub Cat. Code", '');
                Amount := 0;
            end;
        }
        field(26; "Field Work Main Cat. Name"; Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false),
                                                                      "Cemetery Services" = CONST(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
                Validate("Field Work Main Cat. Code", _FieldWorkMainCategory.GetFieldWorkMCode("Field Work Main Cat. Name"));
            end;
        }
        field(27; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Sub Category".Code WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
                _CemServicesPost: Codeunit "DK_Cem. Services - Post";
            begin
                TestField(Status, Status::Open);

                if _FieldWorkSubCategory.Get("Field Work Main Cat. Code", "Field Work Sub Cat. Code") then begin
                    "Field Work Sub Cat. Name" := _FieldWorkSubCategory.Name;
                    "Cost Amount" := _FieldWorkSubCategory."Cost Amount"
                end else begin
                    "Field Work Sub Cat. Name" := '';
                    "Cost Amount" := 0;
                end;

                _CemServicesPost.SetConnectSize(Rec);
                CalcFields(Unit, Description);
            end;
        }
        field(28; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
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
        field(29; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            MinValue = 0;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                TestField(Status, Status::Open);

                _FieldWorkSubCategory.Reset;
                _FieldWorkSubCategory.SetRange(Code, "Field Work Sub Cat. Code");
                _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", Rec."Field Work Main Cat. Code");
                _FieldWorkSubCategory.SetFilter("Cost Amount", '<>%1', 0);
                if _FieldWorkSubCategory.FindSet then
                    Error(MSG001, FieldCaption("Cost Amount"), _FieldWorkSubCategory.TableCaption);

                CalcAmount(Quantity, "Cost Amount");
            end;
        }
        field(30; Unit; Text[30])
        {
            CalcFormula = Lookup("DK_Field Work Sub Category".Unit WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                          Code = FIELD("Field Work Sub Cat. Code"),
                                                                          Blocked = CONST(false)));
            Caption = 'Unit';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; Description; Text[50])
        {
            CalcFormula = Lookup("DK_Field Work Sub Category".Remarks WHERE("Field Work Main Cat. Code" = FIELD("Field Work Main Cat. Code"),
                                                                             Code = FIELD("Field Work Sub Cat. Code"),
                                                                             Blocked = CONST(false)));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; Quantity; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
                TestField(Status, Status::Open);
                if Quantity <> 0 then begin
                    _FieldWorkSubCategory.Reset;
                    _FieldWorkSubCategory.SetRange(Code, Rec."Field Work Sub Cat. Code");
                    _FieldWorkSubCategory.SetRange("Field Work Main Cat. Code", Rec."Field Work Main Cat. Code");
                    _FieldWorkSubCategory.SetFilter("Min Unit", '<>%1', 0);
                    if _FieldWorkSubCategory.FindSet then begin
                        if _FieldWorkSubCategory."Min Unit" >= Quantity then begin
                            Amount := _FieldWorkSubCategory."Min Amount" - "Discount Amount";
                            exit;
                        end;
                    end;
                end;

                CalcAmount(Quantity, "Cost Amount");
            end;
        }
        field(33; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(34; "Corpse Line No."; Integer)
        {
            Caption = 'Corpse Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Process Content"; Text[250])
        {
            Caption = 'Process Content';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Receipt Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Receipt Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(37; "Receipt Amount Date"; Date)
        {
            Caption = 'Receipt Amount Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            var
                _PayRecDoc: Record "DK_Payment Receipt Document";
            begin
            end;
        }
        field(39; "Appl. Name"; Text[30])
        {
            Caption = 'Appl. Name';
            DataClassification = ToBeClassified;
        }
        field(40; "Appl. Mobile No."; Text[30])
        {
            Caption = 'Appl. Mobile No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Appl. Mobile No." <> "Appl. Mobile No." then begin
                    if "Appl. Mobile No." <> '' then
                        if not _CommFun.CheckValidMobileNo("Appl. Mobile No.") then
                            Error(MSG007, FieldCaption("Appl. Mobile No."));
                end;
            end;
        }
        field(41; "Appl. Phone No."; Text[30])
        {
            Caption = 'Appl. Phone No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Appl. Phone No." <> "Appl. Phone No." then begin
                    if "Appl. Phone No." <> '' then
                        if not _CommFun.CheckValidPhoneNo("Appl. Phone No.") then
                            Error(MSG007, FieldCaption("Appl. Phone No."));
                end;
            end;
        }
        field(42; "Appl. E-mail"; Text[80])
        {
            Caption = 'Appl. E-mail';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."Appl. E-mail" <> "Appl. E-mail" then begin
                    _MailMgt.ValidateEmailAddressField("Appl. E-mail");
                end;
            end;
        }
        field(43; "Work Time Spent"; Integer)
        {
            Caption = 'Work Time Spent';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Death Date"; Date)
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Payment Rec. Doc. No."; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Doc. Line"."Document No." WHERE("Payment Target" = CONST(Service),
                                                                                      "Cem. Services No." = FIELD("No.")));
            Caption = 'Payment Receipt Document No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Relationship With Cust."; Text[30])
        {
            Caption = 'Relationship With Customer';
            DataClassification = ToBeClassified;
        }
        field(48; "Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Discount Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "Discount Amount" = 0 then
                    Amount += xRec."Discount Amount"
                else
                    Amount -= "Discount Amount";
            end;
        }
        field(49; "Email Status"; Boolean)
        {
            Caption = 'Email Status';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "Email Status" then begin
                    "Appl. E-mail" := '';
                end;
            end;
        }
        field(50; "Pay. Expect Doc. No."; Code[20])
        {
            CalcFormula = Lookup("DK_Pay. Expect Doc. Line"."Document No." WHERE("Payment Target" = CONST(Service),
                                                                                  "Cem. Services No." = FIELD("No."),
                                                                                  "Assgin Date" = FILTER(<> 0D),
                                                                                  "UnAssgin Date" = FILTER(0D)));
            Caption = 'Payment Expect Document No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; Size; Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery.Size WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Size';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            MinValue = 0;
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Field Work Main Cat. Name")
        {
        }
        key(Key3; "Field Work Sub Cat. Name")
        {
        }
        key(Key4; Amount)
        {
        }
        key(Key5; "Contract No.")
        {
        }
        key(Key6; "Field Work Main Cat. Code", "Receipt Amount", "Receipt Amount Date")
        {
        }
        key(Key7; "Field Work Main Cat. Code", Status, "Receipt Amount Date")
        {
        }
        key(Key8; "Field Work Main Cat. Code", "Field Work Sub Cat. Code", Status, "Receipt Amount Date")
        {
        }
        key(Key9; Status, "Employee No.", "Receipt Date", "Field Work Main Cat. Code", "Field Work Sub Cat. Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Field Work Main Cat. Name", "Field Work Sub Cat. Name", Amount, "Contract No.", "Main Customer Name", "Cemetery No.")
        {
        }
    }

    trigger OnDelete()
    begin

        TestField(Status, Status::Open);
    end;

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Cem. Services Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Cem. Services Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if UserId <> 'ADMIN' then
            _DepartmentBoard.Check_EmployeeUserID(UserId);

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
        MSG001: Label 'The %1 is already specified and can not be changed.\Please check the %2.';
        MSG002: Label 'If the %1 is %2, you can not modify or delete it.';
        MSG003: Label 'It is a document transferred to the %1. %2';
        MSG004: Label 'The %2 has been set in %1.';
        MSG005: Label 'This is a deposited document.. %1 : %2';
        MSG006: Label 'Please put a %1.';
        MSG007: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';


    procedure AssistEdit(OldCemServices: Record "DK_Cemetery Services"): Boolean
    var
        _CemServicesHeader: Record "DK_Cemetery Services";
    begin
        with _CemServicesHeader do begin
            _CemServicesHeader := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Cem. Services Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Cem. Services Nos.", OldCemServices."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _CemServicesHeader;
                exit(true);
            end;
        end;
    end;


    procedure CalcAmount(pQuantity: Decimal; pCostAmount: Decimal)
    begin
        Amount := 0;
        if pQuantity <> 0 then
            Amount := pQuantity * pCostAmount - "Discount Amount";
    end;


    procedure ShowCemeteryServiceCard(pRec: Record "DK_Cemetery Services")
    var
        _CemServices: Page "DK_Cem. Services";
        _PostedCemServices: Page "DK_Posted Cem. Services";
    begin

        if pRec.Status = Rec.Status::Complete then begin
            Clear(_CemServices);
            _CemServices.LookupMode(true);
            _CemServices.SetTableView(pRec);
            _CemServices.SetRecord(pRec);
            _CemServices.RunModal;
        end else begin
            Clear(_PostedCemServices);
            _PostedCemServices.LookupMode(true);
            _PostedCemServices.SetTableView(pRec);
            _PostedCemServices.SetRecord(pRec);
            _PostedCemServices.RunModal;
        end;
    end;


    procedure ShowCemeteryServiceList(pRec: Record "DK_Cemetery Services")
    var
        _CemServicesList: Page "DK_Cem. Services List";
        _PostedCemServicesList: Page "DK_Posted Cem. Services List";
    begin

        if pRec.Status = Rec.Status::Complete then begin
            Clear(_CemServicesList);
            _CemServicesList.LookupMode(true);
            _CemServicesList.SetTableView(pRec);
            _CemServicesList.SetRecord(pRec);
            _CemServicesList.RunModal;
        end else begin
            Clear(_PostedCemServicesList);
            _PostedCemServicesList.LookupMode(true);
            _PostedCemServicesList.SetTableView(pRec);
            _PostedCemServicesList.SetRecord(pRec);
            _PostedCemServicesList.RunModal;
        end;
    end;
}

