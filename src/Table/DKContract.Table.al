table 50030 DK_Contract
{
    // //CRM ¼…
    // #1974 :20200623
    //   - Modify Field : "Estate Type".OptionString
    //                   Original : Blank,Stairs,Funeral Urn,Tree,Nature
    //                   Modify : Blank,Stairs,Funeral Urn,Tree,Nature,Charnelhouse
    // 
    // #HO005 :20200714
    //   - Add Field : Honorstone Fir. Cor. Ex. Date : Date
    // *DK32 : 20200716
    //   - Add Field : "Admin. Expense Method"
    //                 "Admin. Exp. Start Date"
    //                 "Daily Admin. Exp. Ledger Exis."
    //                 "First Corpse Exists"
    //                 "Receipt Admin. Exp. Led. Exis."
    //   - Modify Function : "Cemetery Code" - OnValidate()
    //                       "Contract Date" - OnValidate()
    // #2026 : 20200721
    //   - Add Field : Temp Litigation Evaluation
    // 
    // #2087 : 20200832
    //   - Add Field : VIP Reason Content
    //   - Add Text Constants: MSG021
    // 
    // DK34 : 20201015
    //   - Add Field : "Counsel History Op. Count"
    //      : 20201019
    //   - Add Field : "Main Kinsman Name","Main Kinsman Mobile No.","Main Kinsman Phone No.","Main Kinsman E-Mail"
    //                 "Main Kinsman Post Code","Main Kinsman Address","Main Kinsman Address 2"
    //                 "Sub Kinsman Name","Sub Kinsman Mobile No.","Sub Kinsman Phone No.","Sub Kinsman E-Mail"
    //                 "Sub Kinsman Post Code","Sub Kinsman Address","Sub Kinsman Address 2"
    //      : 20201030
    //   - Modify Field Caption : "Last Deposit Plan Date"(¯€¦ ŽÊŒ® ŸÀ -> Šˆ‘ñ ˆ†¿ €Ë—©)
    //                            "Reminder Date 1"(“´×Î 1’ð -> Š»‡¨ €ËŸ), "Reminder Date 2"(“´×Î 2’ð -> Œ€× €ËŸ)
    //   - Add Field : "Fur. Main Cat. Code", "Fur. Main Cat. Name", "Fur. Sub Cat. Code", "Fur. Sub Cat. Name"
    // 
    // #2294: 20201215
    //   - Modify Field : "Counsel History Op. Count"
    // 
    // #2542 : 20210418
    //   - Add Field : "Main Customer Birthday"
    //                 "Custmer Birthday 2"
    //                 "Custmer Birthday 3"
    //                 "Main Customer Address"
    //                 "Main Customer Address 2"
    //                 "Custmer Address 2"
    //                 "Custmer Address 2 2"
    //                 "Custmer Address 3"
    //                 "Custmer Address 2 3"
    //                 "Main Custmer E-mail"
    //                 "Custmer E-mail 2"
    //                 "Custmer E-mail 3"
    //                 "Main Custmer Phone No."
    //                 "Custmer Phone No. 2"
    //                 "Custmer Phone No. 3"
    //                 "Main Custmer Mobile No."
    //                 "Custmer Mobile No. 2"
    //                 "Custmer Mobile No. 3"

    Caption = 'Contract';
    DataCaptionFields = "No.", "Supervise No.", "Cemetery No.", "Main Customer Name";
    DrillDownPageID = "DK_Contract List";
    LookupPageID = "DK_Contract List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                FunctionSetup: Record "DK_Function Setup";
            begin
                if "No." <> xRec."No." then begin
                    TestField(Status, Status::Open);
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Contract Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status = Rec.Status::Revocation then Error(MSG009);
            end;
        }
        field(3; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                if xRec."Main Customer No." <> "Main Customer No." then begin
                    //  TESTFIELD(Status, Status::Open);

                    if Customer.Get("Main Customer No.") then
                        "Main Customer Name" := Customer.Name
                    else
                        "Main Customer Name" := '';


                    CalcFields("Cust. Mobile No.", "Cust. Phone No.", "Cust. E-Mail");
                    CalcFields("Cust. Post Code", "Cust. Address", "Cust. Address 2", "Cust. Social Security No.");

                    if xRec."Main Customer No." <> "Main Customer No." then begin
                        if "Main Customer No." <> '' then begin
                            if "Main Customer No." = "Customer No. 2" then
                                Error(MSG001, FieldCaption("Customer No. 2"), "Customer No. 2");
                            if "Main Customer No." = "Customer No. 3" then
                                Error(MSG001, FieldCaption("Customer No. 3"), "Customer No. 3");
                        end;
                    end;

                    UpdateCustomers;
                end;
            end;
        }
        field(4; "Customer No. 2"; Code[20])
        {
            Caption = 'Customer No. 2';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                if xRec."Customer No. 2" <> "Customer No. 2" then begin
                    //  TESTFIELD(Status, Status::Open);

                    if Customer.Get("Customer No. 2") then
                        "Customer Name 2" := Customer.Name
                    else
                        "Customer Name 2" := '';

                    CalcFields("Cust. Mobile No. 2");

                    if xRec."Customer No. 2" <> "Customer No. 2" then begin
                        if "Customer No. 2" <> '' then begin
                            if "Customer No. 2" = "Main Customer No." then
                                Error(MSG001, FieldCaption("Main Customer No."), "Main Customer No.");
                            if "Customer No. 2" = "Customer No. 3" then
                                Error(MSG001, FieldCaption("Customer No. 3"), "Customer No. 3");
                        end;
                    end;

                    UpdateCustomers;
                end;
            end;
        }
        field(5; "Customer No. 3"; Code[20])
        {
            Caption = 'Customer No. 3';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin

                if xRec."Customer No. 3" <> "Customer No. 3" then begin
                    //  TESTFIELD(Status, Status::Open);

                    if Customer.Get("Customer No. 3") then
                        "Customer Name 3" := Customer.Name
                    else
                        "Customer Name 3" := '';

                    CalcFields("Cust. Mobile No. 3");

                    if xRec."Customer No. 3" <> "Customer No. 3" then begin
                        if "Customer No. 3" <> '' then begin
                            if "Customer No. 3" = "Main Customer No." then
                                Error(MSG001, FieldCaption("Main Customer No."), "Main Customer No.");
                            if "Customer No. 3" = "Customer No. 2" then
                                Error(MSG001, FieldCaption("Customer No. 2"), "Customer No. 2");
                        end;
                    end;

                    UpdateCustomers;
                end;
            end;
        }
        field(6; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Contract Type" = CONST(General)) DK_Cemetery WHERE(Status = CONST(Unsold),
                                                                                   "Group Contract" = CONST(false))
            ELSE
            IF ("Contract Type" = CONST(Group)) DK_Cemetery WHERE(Status = CONST(Unsold),
                                                                                                                                             "Group Contract" = CONST(true))
            ELSE
            IF ("Contract Type" = CONST(Sub)) DK_Cemetery WHERE(Status = CONST(Unsold),
                                                                                                                                                                                                     "Group Contract" = CONST(true),
                                                                                                                                                                                                     "Estate Code" = FIELD("Group Estate Code"));

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _ContractMgt: Codeunit "DK_Contract Mgt.";
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
                _UnitPrice: Decimal;
            begin
                if xRec."Cemetery Code" <> "Cemetery Code" then begin
                    TestField("Contract Date");

                    if "Contract Type" = "Contract Type"::Sub then
                        TestField("Group Contract No.");

                    case Status of
                        Status::FullPayment, Status::Revocation:
                            begin
                                Error(MSG008, FieldCaption(Status), Status, FieldCaption("Cemetery Code"));
                            end;
                    end;

                    Clear(_ContractMgt);
                    //// _ContractMgt.ChangeCemeteryCode("No.", Status, xRec."Cemetery Code", "Cemetery Code");

                    if _Cemetery.Get("Cemetery Code") then begin
                        "Cemetery No." := _Cemetery."Cemetery No.";
                    end else begin
                        "Cemetery No." := '';
                    end;

                    "Admin. Exp. Start Date" := GetAdminExpStartDate("Contract Date");

                    CalcFields("Cemetery Size", "Cemetery Size 2", "Cemetery Class", "Landscape Architecture");
                    CalcFields("Cemetery Dig. Code", "Cemetery Conf. Code", "Cemetery Dig. Name", "Cemetery Conf. Name");
                    CalcFields("Cemetery Landscape Archit.", "Cemetery Status");
                    CalcFields("Admin. Expense Method");// DK32



                end;
            end;
        }
        field(7; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            Editable = false;
        }
        field(8; "Main Customer Name"; Text[50])
        {
            Caption = 'Main Customer Name';
            TableRelation = DK_Customer;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Main Customer No.", Customer.GetCustomerNo("Main Customer Name"));
            end;
        }
        field(9; "Customer Name 2"; Text[50])
        {
            Caption = 'Customer Name 2';
            TableRelation = DK_Customer;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Customer No. 2", Customer.GetCustomerNo("Customer Name 2"));
            end;
        }
        field(10; "Customer Name 3"; Text[50])
        {
            Caption = 'Customer Name 3';
            TableRelation = DK_Customer;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Customer No. 3", Customer.GetCustomerNo("Customer Name 2"));
            end;
        }
        field(11; "Cust. Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Mobile No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(12; "Cust. Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Phone No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(13; "Cust. E-Mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer E-Mail';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(14; "Cust. Post Code"; Code[10])
        {
            CalcFormula = Lookup(DK_Customer."Post Code" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Post Code';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(15; "Cust. Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Address';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(16; "Cust. Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Address 2';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(17; "Cust. Social Security No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Social Security No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Customer Social Security No.';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(18; "Cemetery Size"; Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery.Size WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Size';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(19; "Cemetery Size 2"; Decimal)
        {
            CalcFormula = Lookup(DK_Cemetery."Size 2" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Size 2';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(20; "Short Memo"; Text[250])
        {
            Caption = 'Short Memo';
            DataClassification = ToBeClassified;
        }
        field(21; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Contract,Full Payment,Revocation of Contract,Reservation';
            OptionMembers = Open,Contract,FullPayment,Revocation,Reservation;

            trigger OnValidate()
            var
                _ContractMgt: Codeunit "DK_Contract Mgt.";
            begin
                if xRec.Status <> Status then begin

                    //—šŒ÷ “Œ•¬
                    if Status = Rec.Status::FullPayment then begin
                        TestField("Contract Date");
                    end;

                    Clear(_ContractMgt);
                    //// _ContractMgt.ChangeStatus("No.", Status);
                end;
            end;
        }
        field(22; "Cemetery Class"; Option)
        {
            CalcFormula = Lookup(DK_Cemetery.Class WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Class';
            FieldClass = FlowField;
            OptionCaption = 'A,B,C,D';
            OptionMembers = A,B,C,D;
        }
        field(23; "Cemetery Dig. Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Dig. Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Digits Code';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(24; "Cemetery Dig. Name"; Code[20])
        {
            CalcFormula = Lookup("DK_Cemetery Digits".Name WHERE(Code = FIELD("Cemetery Dig. Code")));
            Caption = 'Digits Name';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(25; "Cemetery Conf. Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery Conf. Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Conformation Code';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(26; "Cemetery Conf. Name"; Code[20])
        {
            CalcFormula = Lookup("DK_Cemetery Conformation".Name WHERE(Code = FIELD("Cemetery Conf. Code")));
            Caption = 'Cemetery Conformation Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Cemetery Landscape Archit."; Boolean)
        {
            CalcFormula = Lookup(DK_Cemetery."Landscape Architecture" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Landscape Architecture';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(28; "Before Cemetery Code"; Code[20])
        {
            Caption = 'Before Cemetery No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code";
        }
        field(29; "Cust. Mobile No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Customer Mobile No. 2';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(30; "Cust. Mobile No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Customer Mobile No. 3';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(31; "Associate Name"; Text[50])
        {
            Caption = 'Associate Name';
            DataClassification = ToBeClassified;
        }
        field(32; "Associate Mobile No."; Text[30])
        {
            Caption = 'Associate Mobile No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Associate Mobile No." <> "Associate Mobile No." then begin
                    /*
                      IF "Associate Mobile No." <> '' THEN BEGIN
                        IF NOT _CommFun.CheckValidMobileNo("Associate Mobile No.") THEN
                          ERROR(MSG020, FIELDCAPTION("Associate Mobile No."));
                      END;
                    */
                end;

            end;
        }
        field(33; "Associate Phone No."; Text[30])
        {
            Caption = 'Associate Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."Associate Phone No." <> "Associate Phone No." then begin
                    /*
                      IF "Associate Phone No." <>'' THEN
                        IF NOT _CommFun.CheckValidPhoneNo("Associate Phone No.") THEN
                          ERROR(MSG020, FIELDCAPTION("Associate Phone No."));
                    */
                end;

            end;
        }
        field(34; "Associate E-Mail"; Text[80])
        {
            Caption = 'Associate E-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnLookup()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
                if xRec."Associate E-Mail" <> "Associate E-Mail" then begin

                    _MailMgt.ValidateEmailAddressField("Associate E-Mail");

                end;
            end;
        }
        field(35; "Associate Post Code"; Code[10])
        {
            Caption = 'Associate Post Code';
            DataClassification = ToBeClassified;
        }
        field(36; "Associate Address"; Text[50])
        {
            Caption = 'Associate Address';
            DataClassification = ToBeClassified;
        }
        field(37; "Associate Address 2"; Text[50])
        {
            Caption = 'Associate Address 2';
            DataClassification = ToBeClassified;
        }
        field(38; "Landscape Architecture"; Boolean)
        {
            CalcFormula = Lookup(DK_Cemetery."Landscape Architecture" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Landscape Architecture';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Overdue Sticker"; Boolean)
        {
            Caption = 'Overdue Sticker';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Overdue Sticker" <> "Overdue Sticker" then
                    if "Overdue Sticker" then
                        "Overdue Sticker Date" := WorkDate
                    else
                        "Overdue Sticker Date" := 0D
            end;
        }
        field(41; "Overdue Sticker Date"; Date)
        {
            Caption = 'Overdue Sticker Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Overdue Sticker Date" <> "Overdue Sticker Date" then begin
                    if "Overdue Sticker Date" <> 0D then
                        TestField("Overdue Sticker", true);
                end;
            end;
        }
        field(42; "Litigation Status Code"; Code[20])
        {
            Caption = 'Litigation Status Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Litigation Status".Code WHERE(Blocked = CONST(false),
                                                               Type = CONST(LitigationStatus));

            trigger OnValidate()
            begin
                if LitigationStatus.Get(LitigationStatus.Type::LitigationStatus, "Litigation Status Code") then
                    "Litigation Status Name" := LitigationStatus.Name
                else
                    "Litigation Status Name" := ''
            end;
        }
        field(43; "Litigation Status Name"; Text[50])
        {
            Caption = 'Litigation Status Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Litigation Status".Code WHERE(Blocked = CONST(false),
                                                               Type = CONST(LitigationStatus));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Litigation Status Code", LitigationStatus.GetCode(LitigationStatus.Type::LitigationStatus, "Litigation Status Name"));
            end;
        }
        field(44; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //>>DK32
                if xRec."Contract Date" <> "Contract Date" then begin
                    "Admin. Exp. Start Date" := GetAdminExpStartDate("Contract Date");
                end;
                //<<DK32
            end;
        }
        field(45; "General Expiration Date"; Date)
        {
            Caption = 'General Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(46; "Land. Arc. Expiration Date"; Date)
        {
            Caption = 'Land. Arc. Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Land. Arc. Expiration Date" <> "Land. Arc. Expiration Date" then begin
                    CalcFields("Cemetery Landscape Archit.");

                    if "Land. Arc. Expiration Date" <> 0D then
                        if not "Cemetery Landscape Archit." then
                            Error(MSG005);
                end;
            end;
        }
        field(47; "Contract Type"; Option)
        {
            Caption = 'Contract Tpye';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Group,Group Sub';
            OptionMembers = General,Group,Sub;

            trigger OnValidate()
            begin
                if xRec."Contract Type" <> "Contract Type" then begin
                    TestField(Status, Status::Open);


                    if xRec."Contract Type" = xRec."Contract Type"::Group then
                        CheckSubContract("Group Contract No.");


                    Validate("Group Contract No.", '');

                end;
            end;
        }
        field(48; "Group Contract No."; Code[20])
        {
            Caption = 'Group Contract No.';
            TableRelation = IF ("Contract Type" = CONST(Sub)) DK_Contract WHERE("Contract Type" = CONST(Group),
                                                                               Status = CONST(FullPayment));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Group Contract No." <> "Group Contract No." then begin
                    TestField(Status, Status::Open);
                    if "Group Contract No." <> '' then
                        TestField("Contract Type", "Contract Type"::Sub);

                    FunctionSetup.Get;
                    if _Contract.Get("Group Contract No.") then begin
                        _Contract.CalcFields("Estate Code");
                        "Admin. Expense Option" := _Contract."Admin. Expense Option";
                        "Management Unit" := _Contract."Management Unit";
                        "Man. Fee hike Exemption Date" := _Contract."Man. Fee hike Exemption Date";
                        "Man. Fee Exemption Date" := _Contract."Man. Fee Exemption Date";
                        Validate("Group Estate Code", _Contract."Estate Code");
                    end else begin
                        "Admin. Expense Option" := _Contract."Admin. Expense Option"::"Per Contract";
                        "Management Unit" := FunctionSetup."Management Unit";
                        "Man. Fee hike Exemption Date" := 0D;
                        "Man. Fee Exemption Date" := 0D;
                        Validate("Group Estate Code", '');
                    end;
                end;
            end;
        }
        field(49; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(50; "Estate Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Estate Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Estate Code';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Estate Type");
                CalcFields("Estate Report Type");
            end;
        }
        field(51; "Estate Type"; Option)
        {
            CalcFormula = Lookup(DK_Estate.Type WHERE(Code = FIELD("Estate Code")));
            Caption = 'Estate Code';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Stairs,Funeral Urn,Tree,Nature,Charnel house';
            OptionMembers = Blank,Stairs,"Funeral Urn",Tree,Nature,Charnelhouse;
        }
        field(52; "Estate Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Estate.Name WHERE(Code = FIELD("Estate Code")));
            Caption = 'Estate Name';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = DK_Estate;
            ValidateTableRelation = false;
        }
        field(53; "Revocation Register"; Boolean)
        {
            CalcFormula = Exist("DK_Revocation Contract" WHERE("Contract No." = FIELD("No.")));
            Caption = 'Revocation Register';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Revocation Date"; Date)
        {
            Caption = 'Revocation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55; "Revocation Document No."; Code[20])
        {
            Caption = 'Revocation Document No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            var
                _RevocationContract: Record "DK_Revocation Contract";
                _PostedRevContractList: Page "DK_Posted Rev. Contract List";
            begin

                if "Revocation Document No." <> '' then begin

                    if _RevocationContract.Get("Revocation Document No.") then begin
                        Clear(_PostedRevContractList);
                        _PostedRevContractList.LookupMode(true);
                        _PostedRevContractList.SetTableView(_RevocationContract);
                        _PostedRevContractList.SetRecord(_RevocationContract);
                        _PostedRevContractList.Editable(false);
                        _PostedRevContractList.RunModal;
                    end;
                end;
            end;
        }
        field(56; "Admin. Expense Option"; Option)
        {
            Caption = 'Admin. Expense Option';
            DataClassification = ToBeClassified;
            OptionCaption = 'Per Contract,Per Group';
            OptionMembers = "Per Contract","Per Group";

            trigger OnValidate()
            begin
                if xRec."Man. Fee Exemption Date" <> "Man. Fee Exemption Date" then begin
                    TestField(Status, Status::Open);
                    if Rec."Contract Type" = Rec."Contract Type"::Group then
                        CheckSubContract("Group Contract No.");
                end;
            end;
        }
        field(57; "Man. Fee hike Exemption Date"; Date)
        {
            Caption = 'Man. Fee hike Exemption Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Man. Fee Exemption Date" <> "Man. Fee Exemption Date" then begin
                    TestField(Status, Status::Open);
                    if Rec."Contract Type" = Rec."Contract Type"::Group then
                        CheckSubContract("Group Contract No.");
                end;
            end;
        }
        field(58; "Management Unit"; Integer)
        {
            Caption = 'Management Unit';
            DataClassification = ToBeClassified;
            MaxValue = 10;
            MinValue = 0;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Management Unit" <> "Management Unit" then begin
                    FunctionSetup.Get;
                    FunctionSetup.TestField("Management Unit");

                    if "Management Unit" = 0 then
                        Error(MSG010, FieldCaption("Management Unit"), FunctionSetup."Management Unit");

                    case "Contract Type" of
                        "Contract Type"::General, "Contract Type"::Group:
                            begin
                                if "Management Unit" <> FunctionSetup."Management Unit" then
                                    if not Confirm(MSG011, false, FieldCaption("Management Unit"), FunctionSetup."Management Unit") then
                                        "Management Unit" := FunctionSetup."Management Unit";
                            end;
                        "Contract Type"::Sub:
                            begin
                                TestField("Group Contract No.");
                                if _Contract.Get("Group Contract No.") then begin
                                    if "Management Unit" <> _Contract."Management Unit" then
                                        if not Confirm(MSG012, false, "Group Contract No.", _Contract."Management Unit") then
                                            "Management Unit" := _Contract."Management Unit";

                                end else begin
                                    Error(MSG013, _Contract.TableCaption, "Group Contract No.");
                                end;
                            end;
                    end;
                end;
            end;
        }
        field(59; "Man. Fee Exemption Date"; Date)
        {
            Caption = 'Man. Fee Exemption Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Man. Fee Exemption Date" <> "Man. Fee Exemption Date" then begin
                    TestField(Status, Status::Open);
                    if Rec."Contract Type" = Rec."Contract Type"::Group then
                        CheckSubContract("Group Contract No.");
                end;
            end;
        }
        field(60; "Group Estate Code"; Code[20])
        {
            Caption = 'Group Estate Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Estate;

            trigger OnValidate()
            begin
                CalcFields("Group Estate Name");
            end;
        }
        field(61; "Group Estate Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Estate.Name WHERE(Code = FIELD("Group Estate Code")));
            Caption = 'Group Estate Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Litigation Employee No."; Code[20])
        {
            Caption = 'Litigation Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                _Employee.Reset;
                _Employee.SetRange("No.", "Litigation Employee No.");
                //_Employee.SETRANGE(Litigation, TRUE);
                if _Employee.FindSet then
                    "Litigation Employee Name" := _Employee.Name
                else
                    "Litigation Employee Name" := '';
            end;
        }
        field(63; "Litigation Employee Name"; Text[30])
        {
            Caption = 'Litigation Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                Validate("Litigation Employee No.", _Employee.GetEmployeeNo("Litigation Employee Name"));
            end;
        }
        field(64; "Litigation Evaluation"; Option)
        {
            Caption = 'Litigation Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;

            trigger OnValidate()
            begin
                if Rec."Litigation Evaluation" <> xRec."Litigation Evaluation" then
                    Evaluation_Onvalidate;
            end;
        }
        field(65; "General Litigation Date"; Text[30])
        {
            Caption = 'General Litigation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Land. Arc. Litigation Date"; Text[30])
        {
            Caption = 'Land. Arc. Litigation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(67; "Recently Pay. Receipt Date"; Date)
        {
            CalcFormula = Max("DK_Payment Receipt Document"."Payment Date" WHERE("Contract No." = FIELD(UPPERLIMIT("No.")),
                                                                                  Posted = CONST(true),
                                                                                  Refund = CONST(false)));
            Caption = 'Recently Pay. Receipt Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68; "Deposit Plan Date"; Date)
        {
            CalcFormula = Lookup("DK_Counsel History"."Deposit Plan Date" WHERE("Contract No." = FIELD(UPPERLIMIT("No.")),
                                                                                 Type = CONST(Litigation)));
            Caption = 'Deposit Plan Date';
            FieldClass = FlowField;
        }
        field(69; "Counsel Date"; Date)
        {
            CalcFormula = Max("DK_Counsel History".Date WHERE("Contract No." = FIELD("No."),
                                                               Type = CONST(Litigation)));
            Caption = 'Counsel Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Address Confirmation"; Option)
        {
            Caption = 'Address Confirmation';
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes,No';
            OptionMembers = Y,N;
        }
        field(71; "Cemetery Status"; Option)
        {
            CalcFormula = Lookup(DK_Cemetery.Status WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery Size';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Unsold,Reserved Tomb,Contracted Tomb,Landscaped Tomb,Been Transported Tomb';
            OptionMembers = Option0,Option1,Option2,Option3,Option4;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(72; "Reminder Date 1"; Date)
        {
            Caption = 'Reminder 1st';
            DataClassification = ToBeClassified;
        }
        field(73; "Reminder Date 2"; Date)
        {
            Caption = 'Reminder 2nd';
            DataClassification = ToBeClassified;
        }
        field(74; "Add. Remaining Due Date 1"; Date)
        {
            Caption = 'Add. Remaining Due Date 1st';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75; "Add. Remaining Due Date 2"; Date)
        {
            Caption = 'Add. Remaining Due Date 2nd';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(76; "Unit Price Type Code"; Code[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Unit Price Type Code" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Unit Price Type Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "DK_Unit Price Type";
            ValidateTableRelation = false;
        }
        field(80; "Contract Date Check"; Boolean)
        {
            Caption = 'Contract Date Check Request';
            DataClassification = ToBeClassified;
        }
        field(81; "Revocation Employee No."; Code[20])
        {
            Caption = 'Revocation Employee No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false),
                                                     Litigation = CONST(true));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
            end;
        }
        field(82; "Revocation Employee Name"; Text[30])
        {
            Caption = 'Revocation Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Employee."No." WHERE(Blocked = CONST(false),
                                                     Litigation = CONST(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
            end;
        }
        field(83; "General Start Date"; Date)
        {
            Caption = 'General Starting Date';
            DataClassification = ToBeClassified;
        }
        field(84; "Land. Arc. Start Date"; Date)
        {
            Caption = 'Land. Arc. Starting Date';
            DataClassification = ToBeClassified;
        }
        field(85; Memo; BLOB)
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(86; "Estate Report Type"; Option)
        {
            CalcFormula = Lookup(DK_Estate."Report Type" WHERE(Code = FIELD("Estate Code")));
            Caption = 'Estate Report Type';
            FieldClass = FlowField;
            OptionCaption = 'Other,Jungmyung,Sky,Three';
            OptionMembers = Other,Jung,Sky,Three;
        }
        field(87; "Allow Membership Printing"; Boolean)
        {
            Caption = 'Allow Membership Printing';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Allow Membership Printing" <> "Allow Membership Printing" then begin
                    if "Allow Membership Printing" then begin
                        _Employee.GetERPUserIDEmployee(UserId, "Allow Employee No.", "Allow Employee Name");
                        "Allow Mem. Printing DateTime" := CurrentDateTime;
                    end else begin
                        "Allow Employee No." := '';
                        "Allow Employee Name" := '';
                        Clear("Allow Mem. Printing DateTime");
                    end;
                end;
            end;
        }
        field(88; "Allow Employee No."; Code[20])
        {
            Caption = 'Allow Employee No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(89; "Allow Employee Name"; Text[50])
        {
            Caption = 'Allow Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(90; "Allow Mem. Printing DateTime"; DateTime)
        {
            Caption = 'Allow Membership Printing Date/Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(91; "First Laying Date"; Date)
        {
            CalcFormula = Min(DK_Corpse."Laying Date" WHERE("Contract No." = FIELD("No."),
                                                             "Laying Date" = FILTER(<> 0D)));
            Caption = 'First Laying Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(92; "Member. Request Date"; Date)
        {
            Caption = 'Member. Request Date';
            DataClassification = ToBeClassified;
        }
        field(93; "Req. Employee No."; Code[20])
        {
            Caption = 'Request Employee No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(94; "Req. Employee Name"; Text[50])
        {
            Caption = 'Request Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(95; "Unit Price Type Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Cemetery."Unit Price Type Name" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Unit Price Type Name';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "DK_Unit Price Type";
            ValidateTableRelation = false;
        }
        field(96; "Law Status Code"; Code[20])
        {
            Caption = 'Law Status Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Litigation Status".Code WHERE(Blocked = CONST(false),
                                                               Type = CONST(LawStatus));

            trigger OnValidate()
            begin
                if LitigationStatus.Get(LitigationStatus.Type::LawStatus, "Law Status Code") then
                    "Law Status Name" := LitigationStatus.Name
                else
                    "Law Status Name" := ''
            end;
        }
        field(97; "Law Status Name"; Text[50])
        {
            Caption = 'Law Status Name';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Litigation Status".Code WHERE(Blocked = CONST(false),
                                                               Type = CONST(LawStatus));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Law Status Code", LitigationStatus.GetCode(LitigationStatus.Type::LawStatus, "Law Status Name"));
            end;
        }
        field(98; "Revocation Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Revocation Amount';
            DataClassification = ToBeClassified;
        }
        field(99; "Associate Relationship"; Text[10])
        {
            Caption = 'Associate Relationship';
            DataClassification = ToBeClassified;
        }
        field(100; "Been Transp. Type"; Option)
        {
            Caption = 'Been Transp. Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Give up,Non-Give up';
            OptionMembers = "None",Giveup,NonGiveup;
        }
        field(101; "Cemetery Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cemetery Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Cemetery Amount" <> "Cemetery Amount" then begin
                    TestField(Status, Status::Open);

                    CalcAmount;
                end;
            end;
        }
        field(102; "Cemetery Class Dis. Rate"; Decimal)
        {
            Caption = 'Cemetery Class Discount(%)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
            MinValue = 0;
        }
        field(103; "Cemetery Class Discount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cemetery Class Dis. Amount (-)';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Cemetery Class Discount" <> "Cemetery Class Discount" then begin
                    TestField(Status, Status::Open);

                    CalcAmount;
                end;
            end;
        }
        field(104; "General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'General Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."General Amount" <> "General Amount" then begin
                    TestField(Status, Status::Open);

                    CalcAmount;
                end;
            end;
        }
        field(105; "Landscape Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Landscape Architecture Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Landscape Arc. Amount" <> "Landscape Arc. Amount" then begin
                    TestField(Status, Status::Open);
                    CalcFields("Cemetery Landscape Archit.");

                    if "Landscape Arc. Amount" <> 0 then
                        if not "Cemetery Landscape Archit." then
                            Error(MSG005);

                    CalcAmount;
                end;
            end;
        }
        field(106; "Bury Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bury Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Bury Amount" <> "Bury Amount" then begin
                    TestField(Status, Status::Open);
                    CalcAmount;
                end;
            end;
        }
        field(107; "Cemetery Discount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cemetery Discount (-)';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Cemetery Discount" <> "Cemetery Discount" then begin
                    TestField(Status, Status::Open);
                    CalcAmount;
                end;
            end;
        }
        field(130; "Deposit Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Deposit Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Deposit Amount" <> "Deposit Amount" then begin
                    CalcAmount;
                    "Total Contract Amount" := "Deposit Amount" + "Contract Amount";
                end;
            end;
        }
        field(131; "Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Contract Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Contract Amount" <> "Contract Amount" then begin
                    CalcAmount;
                    "Total Contract Amount" := "Deposit Amount" + "Contract Amount";
                end;
            end;
        }
        field(132; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if xRec."Remaining Amount" <> "Remaining Amount" then begin
                    TestField(Status, Status::Open);
                end;
            end;
        }
        field(133; "Payment Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Payment Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(134; "Pay. Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pay. Remaining Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                _ContAmtLedger: Record "DK_Contract Amount Ledger";
            begin
            end;
        }
        field(135; "Non-Pay. General Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("DK_Detail Admin. Exp. Ledger".Amount WHERE("Contract No." = FIELD("No."),
                                                                            "Admin. Expense Type" = CONST(General),
                                                                            Date = FIELD("Date Filter"),
                                                                            "Ledger Type" = CONST(Daily)));
            Caption = 'Non-Payment General Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(136; "Non-Pay. Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("DK_Detail Admin. Exp. Ledger".Amount WHERE("Contract No." = FIELD("No."),
                                                                            "Admin. Expense Type" = CONST(Landscape),
                                                                            Date = FIELD("Date Filter"),
                                                                            "Ledger Type" = CONST(Daily)));
            Caption = 'Non-Payment Landscape Arc. Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(137; "Total Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Contract Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; "Etc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Etc. Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(151; "Etc. Discount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Etc. Discount (-)';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(152; "Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(153; "Rece. Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rece. Remaining Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Rece. Remaining Amount" <> "Rece. Remaining Amount" then begin
                    CalcPayRemainingAmount;
                end;
            end;
        }
        field(200; "Deposit Receipt Date"; Date)
        {
            Caption = 'Deposit Receipt Date';
            Editable = false;
        }
        field(201; "Pay. Contract Rece. Date"; Date)
        {
            Caption = 'Payment Contract Receipt Date';
            Editable = false;
        }
        field(202; "Remaining Due Date"; Date)
        {
            Caption = 'Remaining Due Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FunctionSetup: Record "DK_Function Setup";
            begin
                if xRec."Remaining Due Date" <> "Remaining Due Date" then begin
                    TestField("Contract Date");

                    if "Remaining Due Date" <> 0D then begin
                        //IF "Contract Date" > "Remaining Due Date" THEN
                        //  ERROR(MSG003, FIELDCAPTION("Remaining Due Date"), FIELDCAPTION("Contract Date"));
                        if WorkDate > "Remaining Due Date" then
                            Error(MSG003, FieldCaption("Remaining Due Date"), StrSubstNo(MSG006, WorkDate));

                        _FunctionSetup.Get;
                        "Alarm Period 1" := CalcDate(_FunctionSetup."Alarm period 1", "Remaining Due Date");
                        "Alarm Period 2" := CalcDate(_FunctionSetup."Alarm period 2", "Remaining Due Date");
                    end else begin
                        "Alarm Period 1" := 0D;
                        "Alarm Period 2" := 0D;
                    end;
                end;
            end;
        }
        field(203; "Remaining Receipt Date"; Date)
        {
            Caption = 'Remaining Receipt Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(204; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(205; "Admin. Exp. Type Filter"; Option)
        {
            Caption = 'Admin. Expense Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'General,Landscape Architecture';
            OptionMembers = General,Landscape;
        }
        field(206; "Balance Admin. Expense"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Admin. Expense Ledger".Amount WHERE("Contract No." = FIELD("No."),
                                                                       Date = FIELD("Date Filter"),
                                                                       "Admin. Expense Type" = FIELD("Admin. Exp. Type Filter"),
                                                                       "Ledger Type" = CONST(Daily)));
            Caption = 'Balance Admin. Expense';
            Editable = false;
            FieldClass = FlowField;
        }
        field(207; "Last Daily Batch Run Date"; Date)
        {
            CalcFormula = Max("DK_Admin. Expense Ledger".Date WHERE("Contract No." = FIELD("No."),
                                                                     "Ledger Type" = CONST(Daily),
                                                                     "Admin. Expense Type" = CONST(General)));
            Caption = 'Last Daily Batch Run Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(208; "Contract Customers"; Text[60])
        {
            Caption = 'Contract Customers';
            DataClassification = ToBeClassified;
        }
        field(209; "Alarm Period 1"; Date)
        {
            Caption = 'Alarm Period 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Alarm Period 1" <> "Alarm Period 1" then begin
                    if "Alarm Period 1" <> 0D then begin
                        if "Alarm Period 1" < Today then
                            Error(MSG015, FieldCaption("Alarm Period 1"));
                    end;

                end;
            end;
        }
        field(210; "Alarm Period 2"; Date)
        {
            Caption = 'Alarm Period 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Alarm Period 2" <> "Alarm Period 2" then begin
                    if "Alarm Period 2" <> 0D then begin
                        if "Alarm Period 2" < Today then
                            Error(MSG015, FieldCaption("Alarm Period 2"));
                    end;

                end;
            end;
        }
        field(211; "Allow Ston"; Boolean)
        {
            Caption = 'Allow Ston';
            DataClassification = ToBeClassified;
        }
        field(212; "Sended Alarm 1"; DateTime)
        {
            Caption = 'Sended Alarm 1';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Alarm Period 1" <> "Alarm Period 1" then begin
                    if "Alarm Period 1" <> 0D then begin
                        if "Alarm Period 1" < Today then
                            Error(MSG015, FieldCaption("Alarm Period 1"));
                    end;

                end;
            end;
        }
        field(213; "Sended Alarm 2"; DateTime)
        {
            Caption = 'Sended Alarm 2';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Alarm Period 2" <> "Alarm Period 2" then begin
                    if "Alarm Period 2" <> 0D then begin
                        if "Alarm Period 2" < Today then
                            Error(MSG015, FieldCaption("Alarm Period 2"));
                    end;

                end;
            end;
        }
        field(214; "Last Daily Batch Run Date 2"; Date)
        {
            CalcFormula = Max("DK_Admin. Expense Ledger".Date WHERE("Contract No." = FIELD("No."),
                                                                     "Ledger Type" = CONST(Daily),
                                                                     "Admin. Expense Type" = CONST(Landscape)));
            Caption = 'Last Daily Batch Run Date 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(215; "Transfer Litigation"; Boolean)
        {
            Caption = 'Transfer Litigation';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Transfer Litigation" <> "Transfer Litigation" then begin
                    if "Transfer Litigation" then begin
                        "Transfer Date" := Today;

                        if "Pay. Remaining Amount" = 0 then
                            Error(MSG018, FieldCaption("Pay. Remaining Amount"));

                        if ("Remaining Due Date" <> 0D) and ("Remaining Due Date" > Today) then
                            Error(MSG019, FieldCaption("Remaining Due Date"), "Remaining Due Date");
                    end else begin
                        "Transfer Date" := 0D;
                    end;
                end;
            end;
        }
        field(216; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(217; "Contract Publish"; Option)
        {
            Caption = 'Contract Publish';
            DataClassification = ToBeClassified;
            OptionCaption = 'Unpublished,Cash Receipt,Card Receipt,CashandCard';
            OptionMembers = Unpublished,Cash,Card,CashandCard;
        }
        field(218; "Remaining Publish"; Option)
        {
            Caption = 'Remaining Publish';
            DataClassification = ToBeClassified;
            OptionCaption = 'Unpublished,Cash Receipt,Card Receipt,CashandCard';
            OptionMembers = Unpublished,Cash,Card,CashandCard;
        }
        field(219; "Close Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Close Amount';
            DataClassification = ToBeClassified;
        }
        field(300; "CRM SalesPerson Code"; Code[20])
        {
            Caption = 'CRM SalesPerson Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM SalesPerson";

            trigger OnValidate()
            var
                _CRMSalesPerson: Record "DK_CRM SalesPerson";
            begin
                if _CRMSalesPerson.Get("CRM SalesPerson Code") then
                    "CRM SalesPerson" := _CRMSalesPerson.Name
                else
                    "CRM SalesPerson" := '';
            end;
        }
        field(301; "CRM SalesPerson"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM SalesPerson".Name WHERE(Code = FIELD("CRM SalesPerson Code")));
            Caption = 'CRM SalesPerson';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CRMSalesPerson: Record "DK_CRM SalesPerson";
            begin
                Validate("CRM SalesPerson Code", _CRMSalesPerson.GetSalesPersonCode("CRM SalesPerson"));
            end;
        }
        field(302; "CRM External Sales Code"; Code[20])
        {
            Caption = 'CRM External Sales Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM External Sales";
        }
        field(303; "CRM External Sales"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM External Sales".Name WHERE(Code = FIELD("CRM External Sales Code")));
            Caption = 'CRM External Sales';
            Editable = false;
            FieldClass = FlowField;
        }
        field(304; "CRM Funeral Hall Code"; Code[20])
        {
            Caption = 'CRM Funeral Hall Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM Funeral Hall";
        }
        field(305; "CRM Funeral Hall"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Funeral Hall".Name WHERE("No." = FIELD("CRM Funeral Hall Code")));
            Caption = 'CRM Funeral Hall';
            Editable = false;
            FieldClass = FlowField;
        }
        field(306; "CRM Funeral Service Code"; Code[20])
        {
            Caption = 'CRM Funeral Service Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM Funeral Service";
        }
        field(307; "CRM Funeral Service"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Funeral Service".Name WHERE("No." = FIELD("CRM Funeral Service Code")));
            Caption = 'CRM Funeral Service';
            Editable = false;
            FieldClass = FlowField;
        }
        field(308; "CRM Key"; Text[50])
        {
            Caption = 'CRM Key';
            DataClassification = ToBeClassified;
        }
        field(309; "CRM Channel Vendor No."; Code[20])
        {
            Caption = 'CRM Channel Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM Channel Vendor";
        }
        field(310; "CRM Channel Vendor"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Channel Vendor".Name WHERE("No." = FIELD("CRM Channel Vendor No.")));
            Caption = 'CRM Channel Vendor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(311; "CRM Sales Type Seq"; Integer)
        {
            Caption = 'CRM Sales Type Seq';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("CRM Sales Type");
            end;
        }
        field(312; "CRM Sales Type"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Sales Type".Name WHERE(Seq = FIELD("CRM Sales Type Seq")));
            Caption = 'CRM Sales Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(500; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(501; "Selected Contract"; Boolean)
        {
            CalcFormula = Exist("DK_Selected Contract" WHERE("USER ID" = FIELD("User ID Filter"),
                                                              "Contract No." = FIELD("No.")));
            Caption = 'Selected Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(502; "Corpse Name Filter"; Text[30])
        {
            Caption = 'Corpse Name Filter';
            FieldClass = FlowFilter;
        }
        field(503; "Corpse Exists"; Boolean)
        {
            CalcFormula = Exist(DK_Corpse WHERE("Move The Grave Type" = CONST(false),
                                                 Name = FIELD("Corpse Name Filter"),
                                                 "Contract No." = FIELD("No.")));
            Caption = 'Corpse Exists';
            FieldClass = FlowField;
        }
        field(504; "Before Cemetery No."; Text[30])
        {
            Caption = 'Before Cemetery No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code";
            ValidateTableRelation = false;
        }
        field(505; "Contact Target"; Option)
        {
            Caption = 'Contact Target';
            DataClassification = ToBeClassified;
            OptionCaption = 'Main Customer,Main Associate,Sub Associate';
            OptionMembers = MainCustomer,MainAssociate,SubAssociate;

            trigger OnValidate()
            begin
                if xRec."Contact Target" <> "Contact Target" then begin
                    case "Contact Target" of
                        "Contact Target"::MainCustomer:
                            TestField("Main Customer No.");
                        "Contact Target"::MainAssociate:
                            TestField("Main Associate No.");
                        "Contact Target"::SubAssociate:
                            TestField("Sub Associate No.");
                    end;
                end;
            end;
        }
        field(506; "Main Associate No."; Code[20])
        {
            Caption = 'Main Associate No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                CalcFields("Main Associate Name", "Main Associate Mobile No.", "Main Associate Phone No.", "Main Associate E-Mail");
                CalcFields("Main Associate Post Code", "Main Associate Address", "Main Associate Address 2");
            end;
        }
        field(507; "Sub Associate No."; Code[20])
        {
            Caption = 'Sub Associate No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;

            trigger OnValidate()
            begin
                CalcFields("Sub Associate Name", "Sub Associate Mobile No.", "Sub Associate Phone No.", "Sub Associate E-Mail");
                CalcFields("Sub Associate Post Code", "Sub Associate Address", "Sub Associate Address 2");
            end;
        }
        field(508; "Sub Associate Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(509; "Sub Associate Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate Mobile No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;
        }
        field(510; "Sub Associate Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate Phone No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;
        }
        field(511; "Sub Associate E-Mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate E-Mail';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;
        }
        field(512; "Sub Associate Post Code"; Code[10])
        {
            CalcFormula = Lookup(DK_Customer."Post Code" WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate Post Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(513; "Sub Associate Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(514; "Sub Associate Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Sub Associate No.")));
            Caption = 'Sub Associate Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(515; "Main Associate Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Name WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(516; "Main Associate Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate Mobile No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(517; "Main Associate Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate Phone No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
            end;
        }
        field(518; "Main Associate E-Mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate E-Mail';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                _MailMgt: Codeunit "Mail Management";
            begin
            end;
        }
        field(519; "Main Associate Post Code"; Code[10])
        {
            CalcFormula = Lookup(DK_Customer."Post Code" WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate Post Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(520; "Main Associate Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(521; "Main Associate Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Main Associate No.")));
            Caption = 'Main Associate Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(522; "Associate Remark"; Text[200])
        {
            Caption = 'Associate Remark';
            DataClassification = ToBeClassified;
        }
        field(523; "Revocation Remark"; Text[200])
        {
            Caption = 'Revocation Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(601; "First General Expiration Date"; Date)
        {
            Caption = 'First General Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(602; "First Land. Arc. Exp. Date"; Date)
        {
            Caption = 'First Land. Arc. Exp. Date';
            DataClassification = ToBeClassified;
        }
        field(603; "Rem. Amount Posting Date"; Date)
        {
            Caption = 'Rem. Amount Posting Date';
            DataClassification = ToBeClassified;
        }
        field(604; "Last Deposit Plan Date"; Date)
        {
            Caption = 'Deposit Plan Date';
            DataClassification = ToBeClassified;
        }
        field(605; "Counsel Line No."; Integer)
        {
            Caption = 'Counsel Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(701; "VIP Exists"; Boolean)
        {
            Caption = 'VIP';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "VIP Exists" <> xRec."VIP Exists" then
                    if "VIP Exists" = false then
                        "VIP Reason Content" := '';
            end;
        }
        field(702; Caution; Boolean)
        {
            Caption = 'Caution';
            DataClassification = ToBeClassified;
        }
        field(703; "Last Date Cust. Request"; Date)
        {
            CalcFormula = Max("DK_Customer Requests"."Process Date" WHERE("Contract No." = FIELD("No."),
                                                                           Status = CONST(Complete)));
            Caption = 'Last Date Customer Request';
            Editable = false;
            FieldClass = FlowField;
        }
        field(704; "Customer Request Count"; Integer)
        {
            CalcFormula = Count("DK_Customer Requests" WHERE(Status = FILTER(Open | Post | Release | Cancel),
                                                              "Contract No." = FIELD("No.")));
            Caption = 'Customer Request Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(705; "VIP Reason Content"; Text[255])
        {
            Caption = 'VIP Reason Content';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "VIP Reason Content" <> xRec."VIP Reason Content" then
                    if not "VIP Exists" then
                        Error(MSG021);
            end;
        }
        field(706; "Fur. Main Cat. Code"; Code[20])
        {
            Caption = 'Further action Main Catory code';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "DK_Further action Main Cat.".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _FurtheractionMainCat: Record "DK_Further action Main Cat.";
            begin

                if _FurtheractionMainCat.Get("Fur. Main Cat. Code") then
                    "Fur. Main Cat. Name" := _FurtheractionMainCat.Name
                else
                    "Fur. Main Cat. Code" := '';

                Validate("Fur. Sub Cat. Code", '');
            end;
        }
        field(707; "Fur. Main Cat. Name"; Text[30])
        {
            Caption = 'Further action Main Catory Name';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "DK_Further action Main Cat.".Name WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FurtheractionMainCat: Record "DK_Further action Main Cat.";
            begin
                Validate("Fur. Main Cat. Code", _FurtheractionMainCat.GetFutheractionMCode("Fur. Main Cat. Name"));
            end;
        }
        field(708; "Fur. Sub Cat. Code"; Code[20])
        {
            Caption = 'Further action Category Code';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "DK_Further action Sub Cat.".Code WHERE("Further action Main Cat. Code" = FIELD("Fur. Main Cat. Code"),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                _FurtheractionSubCat: Record "DK_Further action Sub Cat.";
            begin

                if _FurtheractionSubCat.Get("Fur. Main Cat. Code", "Fur. Sub Cat. Code") then
                    "Fur. Sub Cat. Name" := _FurtheractionSubCat.Name
                else
                    "Fur. Sub Cat. Name" := '';
            end;
        }
        field(709; "Fur. Sub Cat. Name"; Text[30])
        {
            Caption = 'Further action Sub Catrgor Name';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "DK_Further action Sub Cat.".Name WHERE("Further action Main Cat. Code" = FIELD("Fur. Main Cat. Code"),
                                                                     Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FurtheractionSubCat: Record "DK_Further action Sub Cat.";
            begin
                Validate("Fur. Sub Cat. Code", _FurtheractionSubCat.GetFurtheractionSubCode("Fur. Sub Cat. Name", "Fur. Main Cat. Code"));
            end;
        }
        field(710; "Litigation Progress Code"; Code[20])
        {
            Caption = 'Litigation Progress Code';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "DK_Litigation Cont. Progress".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _LitigationProgress: Record "DK_Litigation Cont. Progress";
            begin

                if _LitigationProgress.Get("Litigation Progress Code") then
                    "Litigation Progress Name" := _LitigationProgress.Name
                else
                    "Litigation Progress Name" := '';
            end;
        }
        field(711; "Litigation Progress Name"; Text[30])
        {
            Caption = 'Litigation Progress Name';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "DK_Litigation Cont. Progress".Name WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _LitigationProgress: Record "DK_Litigation Cont. Progress";
            begin
                Validate("Litigation Progress Code", _LitigationProgress.GetLitigationProgressCode("Litigation Progress Name"));
            end;
        }
        field(712; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin

                if _Department.Get("Department Code") then
                    "Department Name" := _Department.Name
                else
                    "Department Name" := '';
            end;
        }
        field(713; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Department: Record DK_Department;
            begin
                Validate("Department Code", _Department.GetDeptCode("Department Name"));
            end;
        }
        field(714; "Main Customer Birthday"; Date)
        {
            CalcFormula = Lookup(DK_Customer.Birthday WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Birthday';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(715; "Custmer Birthday 2"; Date)
        {
            CalcFormula = Lookup(DK_Customer.Birthday WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Custmer Birthday 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(716; "Custmer Birthday 3"; Date)
        {
            CalcFormula = Lookup(DK_Customer.Birthday WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Custmer Birthday 3';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(717; "Main Customer Address"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Address';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(718; "Main Customer Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Customer Address 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(719; "Custmer Address 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Custmer Address 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(720; "Custmer Address 2 2"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Custmer Address 2 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(721; "Custmer Address 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer.Address WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Custmer Address 3';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(722; "Custmer Address 2 3"; Text[50])
        {
            CalcFormula = Lookup(DK_Customer."Address 2" WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Custmer Address 2 3';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(723; "Main Custmer E-mail"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Custmer E-mail';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(724; "Custmer E-mail 2"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Custmer E-mail 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(725; "Custmer E-mail 3"; Text[80])
        {
            CalcFormula = Lookup(DK_Customer."E-mail" WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Custmer E-mail 3';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(726; "Main Custmer Phone No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Custmer Phone No';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(727; "Custmer Phone No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Custmer Phone No. 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(728; "Custmer Phone No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Phone No." WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Custmer Phone No. 3';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(729; "Main Custmer Mobile No."; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Main Customer No.")));
            Caption = 'Main Custmer Mobile No.';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(730; "Custmer Mobile No. 2"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Customer No. 2")));
            Caption = 'Custmer Mobile No. 2';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(731; "Custmer Mobile No. 3"; Text[30])
        {
            CalcFormula = Lookup(DK_Customer."Mobile No." WHERE("No." = FIELD("Customer No. 3")));
            Caption = 'Custmer Mobile No. 3';
            Description = '#2542';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "Temp Litigation Evaluation"; Option)
        {
            Caption = 'Temp Litigation Evaluation';
            DataClassification = ToBeClassified;
            Description = '#2026,#3202';
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(3002; "Main Kinsman Name"; Text[50])
        {
            Caption = 'Main Kinsman Name';
            Description = 'DK34';

            trigger OnValidate()
            begin

                if "Main Kinsman Name" <> xRec."Main Kinsman Name" then
                    CRMOutbound();
            end;
        }
        field(3003; "Main Kinsman Mobile No."; Text[30])
        {
            Caption = 'Main Kinsman Mobile No.';
            Description = 'DK34';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                if "Main Kinsman Mobile No." <> xRec."Main Kinsman Mobile No." then
                    CRMOutbound();
            end;
        }
        field(3004; "Main Kinsman Phone No."; Text[30])
        {
            Caption = 'Main Kinsman Phone No.';
            Description = 'DK34';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                if "Main Kinsman Phone No." <> xRec."Main Kinsman Phone No." then
                    CRMOutbound();
            end;
        }
        field(3005; "Main Kinsman E-Mail"; Text[80])
        {
            Caption = 'Main Kinsman E-Mail';
            Description = 'DK34';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin

                if "Main Kinsman E-Mail" <> xRec."Main Kinsman E-Mail" then begin
                    _MailMgt.ValidateEmailAddressField("Main Kinsman E-Mail");

                    CRMOutbound();
                end;
            end;
        }
        field(3006; "Main Kinsman Post Code"; Code[10])
        {
            Caption = 'Main Kinsman Post Code';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Main Kinsman Post Code" <> xRec."Main Kinsman Post Code" then
                    CRMOutbound();
            end;
        }
        field(3007; "Main Kinsman Address"; Text[50])
        {
            Caption = 'Main Kinsman Address';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Main Kinsman Address" <> xRec."Main Kinsman Address" then
                    CRMOutbound();
            end;
        }
        field(3008; "Main Kinsman Address 2"; Text[50])
        {
            Caption = 'Main Kinsman Address 2';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Main Kinsman Address 2" <> xRec."Main Kinsman Address 2" then
                    CRMOutbound();
            end;
        }
        field(3009; "Main Kinsman Relationship"; Text[30])
        {
            Caption = 'Main Kinsman Relationship';
            DataClassification = ToBeClassified;
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Main Kinsman Relationship" <> xRec."Main Kinsman Relationship" then
                    CRMOutbound();
            end;
        }
        field(3010; "Sub Kinsman Name"; Text[50])
        {
            Caption = 'Sub Kinsman Name';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Sub Kinsman Name" <> xRec."Sub Kinsman Name" then
                    CRMOutbound();
            end;
        }
        field(3011; "Sub Kinsman Mobile No."; Text[30])
        {
            Caption = 'Sub Kinsman Mobile No.';
            Description = 'DK34';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                if "Sub Kinsman Mobile No." <> xRec."Sub Kinsman Mobile No." then
                    CRMOutbound();
            end;
        }
        field(3012; "Sub Kinsman Phone No."; Text[30])
        {
            Caption = 'Sub Kinsman Phone No.';
            Description = 'DK34';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                if "Sub Kinsman Phone No." <> xRec."Sub Kinsman Phone No." then
                    CRMOutbound();
            end;
        }
        field(3013; "Sub Kinsman E-Mail"; Text[80])
        {
            Caption = 'Sub Kinsman E-Mail';
            Description = 'DK34';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                _MailMgt: Codeunit "Mail Management";
            begin

                if "Sub Kinsman E-Mail" <> xRec."Sub Kinsman E-Mail" then begin
                    _MailMgt.ValidateEmailAddressField("Sub Kinsman E-Mail");

                    CRMOutbound();
                end;
            end;
        }
        field(3014; "Sub Kinsman Post Code"; Code[10])
        {
            Caption = 'Sub Kinsman Post Code';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Sub Kinsman Post Code" <> xRec."Sub Kinsman Post Code" then
                    CRMOutbound();
            end;
        }
        field(3015; "Sub Kinsman Address"; Text[50])
        {
            Caption = 'Sub Kinsman Address';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Sub Kinsman Address" <> xRec."Sub Kinsman Address" then
                    CRMOutbound();
            end;
        }
        field(3016; "Sub Kinsman Address 2"; Text[50])
        {
            Caption = 'Sub Kinsman Address 2';
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Sub Kinsman Address 2" <> xRec."Sub Kinsman Address 2" then
                    CRMOutbound();
            end;
        }
        field(3017; "Sub Kinsman Relationship"; Text[30])
        {
            Caption = 'Sub Kinsman Relationship';
            DataClassification = ToBeClassified;
            Description = 'DK34';

            trigger OnValidate()
            begin
                if "Sub Kinsman Relationship" <> xRec."Sub Kinsman Relationship" then
                    CRMOutbound();
            end;
        }
        field(4000; "Admin. Expense Method"; Option)
        {
            CalcFormula = Lookup(DK_Estate."Admin. Expense Method" WHERE(Code = FIELD("Estate Code")));
            Caption = 'Admin. Expense Method';
            Description = 'DK32';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Contract,After Corpse';
            OptionMembers = Contract,"After Corpse 10";

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
            end;
        }
        field(4001; "Admin. Exp. Start Date"; Date)
        {
            Caption = 'Admin. Exp. Start Date';
            DataClassification = ToBeClassified;
            Description = 'DK32';
        }
        field(4002; "Daily Admin. Exp. Ledger Exis."; Boolean)
        {
            CalcFormula = Exist("DK_Admin. Expense Ledger" WHERE("Contract No." = FIELD("No."),
                                                                  "Ledger Type" = CONST(Daily)));
            Caption = 'Daily Admin. Exp. Ledger Exists';
            Description = 'DK32';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4003; "First Corpse Exists"; Boolean)
        {
            CalcFormula = Exist(DK_Corpse WHERE("Contract No." = FIELD("No."),
                                                 "First Corpse" = CONST(true)));
            Caption = 'First Corpse Exists';
            Description = 'DK32';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4004; "Receipt Admin. Exp. Led. Exis."; Boolean)
        {
            CalcFormula = Exist("DK_Admin. Expense Ledger" WHERE("Contract No." = FIELD("No."),
                                                                  "Ledger Type" = CONST(Receipt)));
            Caption = 'Receipt Admin. Exp. Ledger Exists';
            Description = 'DK32';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4005; "Counsel History Op. Count"; Integer)
        {
            CalcFormula = Count("DK_Counsel History" WHERE("Contract No." = FIELD("No."),
                                                            Type = CONST(Litigation),
                                                            "Litigation Type" = CONST(OpenRequest),
                                                            Date = FIELD("Date Filter 2"),
                                                            "Result Process" = CONST(Completed)));
            Caption = 'Counsel History Open Request Count';
            Description = 'DK34';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                _CounselHistory: Record "DK_Counsel History";
                _CounselLitigationList: Page "DK_Counsel Litigation List";
            begin

                _CounselHistory.Reset;
                _CounselHistory.SetRange("Contract No.", "No.");
                _CounselHistory.SetRange(Type, _CounselHistory.Type::Litigation);
                _CounselHistory.SetRange("Litigation Type", _CounselHistory."Litigation Type"::OpenRequest);

                Clear(_CounselLitigationList);
                _CounselLitigationList.SetRecord(_CounselHistory);
                _CounselLitigationList.SetTableView(_CounselHistory);
                _CounselLitigationList.Run;
            end;
        }
        field(4006; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter 2';
            FieldClass = FlowFilter;
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
        field(50000; "No. of Corpse"; Integer)
        {
            CalcFormula = Count(DK_Corpse WHERE("Contract No." = FIELD("No."),
                                                 "Contract Status" = FILTER(<> Revocation),
                                                 "Move The Grave Type" = CONST(false)));
            Caption = 'No. of Corpse';
            Description = 'DK3439';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51000; "CRM SEDN ISSUE"; Boolean)
        {
            Caption = 'CRM ýŒÁ œ„';
            DataClassification = ToBeClassified;
            Description = 'DK2302';
        }
        field(59000; IDX; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59001; "Gen Opening"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59002; "Lan Opening"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59003; "Before Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59004; "CRM ISSUE USER"; Code[30])
        {
            Caption = 'CRM ýŒÁ ‹ÏÔÀ';
            DataClassification = ToBeClassified;
            Description = 'DK2302';
        }
        field(59005; "CRM ISSUE DATE"; Date)
        {
            Caption = 'CRM ýŒÁ ŸÀ';
            DataClassification = ToBeClassified;
            Description = 'DK2302';
        }
        field(59006; "CRM ISSUE TIME"; Time)
        {
            Caption = 'CRM ýŒÁ “ú';
            DataClassification = ToBeClassified;
            Description = 'DK2302';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Supervise No.")
        {
        }
        key(Key3; "Cemetery No.")
        {
        }
        key(Key4; "Cemetery Code")
        {
        }
        key(Key5; Status)
        {
        }
        key(Key6; "Contract Type")
        {
        }
        key(Key7; "Group Contract No.")
        {
        }
        key(Key8; "Contract Date")
        {
        }
        key(Key9; "Main Customer Name")
        {
        }
        key(Key10; "Customer Name 2")
        {
        }
        key(Key11; "Customer Name 3")
        {
        }
        key(Key12; "Contract Customers")
        {
        }
        key(Key13; "Contract Date Check")
        {
        }
        key(Key14; "Contract Date", "Pay. Remaining Amount", Status)
        {
        }
        key(Key15; Status, "Rem. Amount Posting Date")
        {
        }
        key(Key16; "Contract Date", Status, "CRM Sales Type Seq")
        {
        }
        key(Key17; Status, "Contract Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Supervise No.", "Contract Date", Status, "Cemetery No.", "Main Customer Name", "Customer Name 2", "Customer Name 3", "Contract Type", "Group Contract No.")
        {
        }
    }

    trigger OnDelete()
    var
        _Corpse: Record DK_Corpse;
        _RelationshipFamily: Record "DK_Relationship Family";
        _LandArchPicture: Record "DK_Land. Arch. Picture";
        _ContractAmountLedger: Record "DK_Contract Amount Ledger";
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
        _RevocationContract: Record "DK_Revocation Contract";
        _ContractMgt: Codeunit "DK_Contract Mgt.";
    begin
        TestField(Status, Status::Open);

        _ContractAmountLedger.Reset;
        _ContractAmountLedger.SetRange("Contract No.", "No.");
        if not _ContractAmountLedger.IsEmpty then
            Error(MSG007, TableCaption, "No.", _ContractAmountLedger.TableCaption);

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetRange("Contract No.", "No.");
        if not _AdminExpenseLedger.IsEmpty then
            Error(MSG007, TableCaption, "No.", _AdminExpenseLedger.TableCaption);

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.SetRange("Contract No.", "No.");
        if not _PaymentReceiptDocument.IsEmpty then
            Error(MSG007, TableCaption, "No.", _PaymentReceiptDocument.TableCaption);

        _PublishAdminExpDocLine.Reset;
        _PublishAdminExpDocLine.SetRange("Contract No.", "No.");
        if not _PublishAdminExpDocLine.IsEmpty then
            Error(MSG007, TableCaption, "No.", _PublishAdminExpDocLine.TableCaption);

        _RevocationContract.Reset;
        _RevocationContract.SetRange("Contract No.", "No.");
        if not _RevocationContract.IsEmpty then
            Error(MSG007, TableCaption, "No.", _RevocationContract.TableCaption);

        _Corpse.Reset;
        _Corpse.SetRange("Contract No.", "No.");
        if _Corpse.FindFirst then
            _Corpse.DeleteAll;

        _RelationshipFamily.Reset;
        _RelationshipFamily.SetRange("Contract No.", "No.");
        if _RelationshipFamily.FindFirst then
            _RelationshipFamily.DeleteAll;

        _LandArchPicture.Reset;
        _LandArchPicture.SetRange("Contract No.", "No.");
        if _LandArchPicture.FindFirst then
            _LandArchPicture.DeleteAll;


        //ÐŽÊ ‹Ð‘ª“ ‰ŽÊ‘÷ —¹‘ª
        Clear(_ContractMgt);
        //// _ContractMgt.ChangeCemeteryCode("No.", Status, xRec."Cemetery Code", '');
    end;

    trigger OnInsert()
    begin

        //>>No
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Contract Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Contract Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        TestField("No.");
        //<<No


        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        TestField("No.");

        _CRMDataInterlink.CheckContractModified(xRec, Rec);

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'The same value exists in the %1. Current Value : %2';
        LitigationStatus: Record "DK_Litigation Status";
        MSG002: Label 'This contract has been canceled, so the Status can not be changed.';
        MSG003: Label 'The %1 can not be earlier than the %2.';
        MSG004: Label 'A %1 must be present in order to change Status to a Temporary Contract.';
        MSG005: Label 'The cemetery is not eligible for landscaping.';
        MSG006: Label 'ToDay';
        Customer: Record DK_Customer;
        MSG007: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG008: Label 'In the current %1, you can not change the %3. Current %1:%2';
        MSG009: Label 'This contract has been canceled, so the can''t be changed.';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG010: Label 'The value of %1 can not be (0). Default value:%2';
        MSG011: Label 'The default value for %1 is %2. Change the default value. Do you want to continue?';
        MSG012: Label 'The contracted value for group contract %1 is %2. Changes to group agreements and other values. Do you want to continue?';
        MSG013: Label 'Could not find information for %1. Contract No.: %2';
        MSG014: Label 'There is% 1 subcontract associated with the current group contract. Could not modify %2. %3:% 4';
        MSG015: Label 'You can not specify a %1 before today.';
        _Employee: Record DK_Employee;
        MSG016: Label 'A %1 must be present in order to change Status to a Reservation.';
        MSG017: Label 'To change the Status to a contract, the %1 must be (0).';
        MSG018: Label 'The %1 is (0).';
        MSG019: Label 'The %1 has not been exceeded. %1:%2';
        MSG020: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG021: Label '%1 is not selected.';


    procedure SetReservation()
    begin
        if Status = Rec.Status::Revocation then Error(MSG002);

        if "Deposit Amount" = 0 then
            Error(MSG016, FieldCaption("Deposit Amount"));

        Validate(Status, Status::Reservation);
        Modify;
    end;


    procedure SetTempContract()
    begin
        if Status = Rec.Status::Revocation then Error(MSG002);

        if "Contract Amount" = 0 then
            Error(MSG004, FieldCaption("Contract Amount"));

        Validate(Status, Status::Contract);
        Modify;
    end;


    procedure SetContract()
    begin
        if Status = Rec.Status::Revocation then Error(MSG002);
        TestField("Supervise No.");

        if "Contract Type" = "Contract Type"::Sub then
            TestField("Group Contract No.");

        TestField("Cemetery Code");

        if "Pay. Remaining Amount" <> 0 then
            Error(MSG017, FieldCaption("Pay. Remaining Amount"));

        Validate(Status, Status::FullPayment);
        Modify;
    end;


    procedure SetRevocation()
    begin
        Validate(Status, Status::Revocation);
        Modify;
    end;


    procedure SetReOpen()
    begin
        if Status = Rec.Status::Revocation then Error(MSG002);

        Validate(Status, Status::Open);
        Modify;
    end;


    procedure CalcAmount()
    var
        _ContAmtLedger: Record "DK_Contract Amount Ledger";
    begin

        "Remaining Amount" := "Cemetery Amount" - "Cemetery Class Discount" +
                              ("General Amount" + "Landscape Arc. Amount" + "Bury Amount") -
                              "Cemetery Discount" - "Deposit Amount" - "Contract Amount";

        Validate("Payment Amount", "Deposit Amount" + "Contract Amount" + "Remaining Amount");

        CalcPayRemainingAmount;
    end;


    procedure UpdateStatusUp(pContractNo: Code[20]; pStatus: Option)
    var
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("No.", pContractNo);
        if _Contract.FindFirst then begin
            if _Contract.Status < pStatus then begin
                _Contract.Status := pStatus;
                _Contract.Modify
            end;
        end;
    end;


    procedure UpdateStatusDown(pContractNo: Code[20]; pStatus: Option)
    var
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("No.", pContractNo);
        if _Contract.FindFirst then begin

            if _Contract.Status < pStatus then begin
                _Contract.Status := pStatus;
                _Contract.Modify
            end;
        end;
    end;

    local procedure CalcPayRemainingAmount()
    begin

        //‚‚¯ ÂŽ¸ = ‚‚Šž—­ €¦Ž¸ - (‰ŽÊ€¦+ÐŽÊ€¦+‚‚Šž Â€¦)
        Validate("Pay. Remaining Amount", "Payment Amount" - ("Deposit Amount" + "Contract Amount" + "Rece. Remaining Amount"));
    end;

    local procedure LastRemainingReceiptDate(pContractNo: Code[20]): Date
    var
        _ContractAmountLedger: Record "DK_Contract Amount Ledger";
    begin
        //ˆ†‘÷€¦ ¯€¦ …˜ ŸÀ:‰ŽÊ€¦,Èø,ÂŽ¸…Ò ˆÚ…ž –ð—¯
        _ContractAmountLedger.Reset;
        _ContractAmountLedger.SetCurrentKey("Contract No.", Date);
        _ContractAmountLedger.SetRange("Contract No.", pContractNo);
        _ContractAmountLedger.SetFilter(Type, '<>%1', _ContractAmountLedger.Type::Service);
        _ContractAmountLedger.SetRange("Ledger Type", _ContractAmountLedger."Ledger Type"::Receipt);
        if _ContractAmountLedger.FindLast then
            exit(_ContractAmountLedger.Date);
    end;


    procedure AssistEdit(OldContract: Record DK_Contract): Boolean
    var
        _RecContract: Record DK_Contract;
    begin
        with _RecContract do begin
            _RecContract := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Contract Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Contract Nos.", OldContract."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _RecContract;
                exit(true);
            end;
        end;
    end;

    local procedure CheckSubContract(pGroupContractNo: Code[20])
    var
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Sub);
        _Contract.SetRange("Group Contract No.", pGroupContractNo);
        if _Contract.FindSet then
            Error(MSG014, _Contract.Count, FieldCaption("Contract Type"), FieldCaption("Group Contract No."), "Group Contract No.");
    end;


    procedure Evaluation_Onvalidate()
    begin

        case "Litigation Evaluation" of
            "Litigation Evaluation"::D:
                begin
                    "Address Confirmation" := "Address Confirmation"::N;
                end;
        end;
    end;


    procedure UpdateCustomers()
    begin

        "Contract Customers" := "Main Customer No.";

        if "Customer No. 2" <> '' then begin
            if "Contract Customers" <> '' then
                "Contract Customers" := "Contract Customers" + '|' + "Customer No. 2"
            else
                "Contract Customers" := "Customer No. 2";
        end;

        if "Customer No. 3" <> '' then begin
            if "Contract Customers" <> '' then
                "Contract Customers" := "Contract Customers" + '|' + "Customer No. 3"
            else
                "Contract Customers" := "Customer No. 3";
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
        Validate("Short Memo", CopyStr(pNewWorkMemo, 1, 250));
        Memo := _TempBlob.Blob;
        Modify(true);
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


    procedure OpenAdminExpeseLedger(pAdminExpenseType: Option)
    var
        _AdminExLedgerRec: Record "DK_Admin. Expense Ledger";
        _AdminExLedger: Page "DK_Admin. Expense Ledger";
    begin

        _AdminExLedgerRec.SetRange("Contract No.", "No.");
        _AdminExLedgerRec.SetRange("Admin. Expense Type", pAdminExpenseType);
        _AdminExLedgerRec.SetRange("Ledger Type", _AdminExLedgerRec."Ledger Type"::Daily);
        if GetFilter("Date Filter") <> '' then
            _AdminExLedgerRec.SetRange(Date, GetRangeMin("Date Filter"), GetRangeMax("Date Filter"));
        _AdminExLedgerRec.SetFilter("Remaining Amount", '<>0');

        PAGE.Run(0, _AdminExLedgerRec);

        /*
        CLEAR(_AdminExLedger);
        _AdminExLedger.LOOKUPMODE(TRUE);
        _AdminExLedger.SETTABLEVIEW(_AdminExLedgerRec);
        _AdminExLedger.SETRECORD(_AdminExLedgerRec);
        _AdminExLedger.RUNMODAL;
        */

    end;


    procedure GetAdminExpStartDate(pContractDate: Date): Date
    begin

        if pContractDate = 0D then
            exit(0D)
        else begin
            CalcFields("Admin. Expense Method");
            case "Admin. Expense Method" of
                "Admin. Expense Method"::"After Corpse 10":
                    exit(CalcDate('<+10Y>', pContractDate));
                else
                    exit(0D);
            end;
        end;
    end;


    procedure CRMOutbound()
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin

        _CRMDataInterlink.OutboundContract(Rec);

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;
}

