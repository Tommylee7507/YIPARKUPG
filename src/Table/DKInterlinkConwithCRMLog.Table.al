table 50119 "DK_Interlink Con. with CRM Log"
{
    // 
    // *DK34 : 20201019
    //   - Add Field : "Main Kinsman Name","Main Kinsman Mobile No.","Main Kinsman Phone No.","Main Kinsman E-Mail"
    //                 "Main Kinsman Post Code","Main Kinsman Address","Main Kinsman Address 2"
    //                 "Sub Kinsman Name","Sub Kinsman Mobile No.","Sub Kinsman Phone No.","Sub Kinsman E-Mail"
    //                 "Sub Kinsman Post Code","Sub Kinsman Address","Sub Kinsman Address 2"

    Caption = 'Interlink Contract with CRM Log';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Data Date';
            DataClassification = ToBeClassified;
        }
        field(2; "Data Type"; Option)
        {
            Caption = 'Data Type';
            DataClassification = ToBeClassified;
            InitValue = Inbound;
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
        }
        field(3; "Data Date"; Date)
        {
            Caption = 'Data Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Contract Date"; DateTime)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer."No.";
        }
        field(8; "Main Customer Name"; Text[50])
        {
            Caption = 'Main Customer Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
            ValidateTableRelation = false;
        }
        field(9; "Customer No. 2"; Code[20])
        {
            Caption = 'Customer No. 2';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer."No.";
        }
        field(10; "Customer Name 2"; Text[50])
        {
            Caption = 'Customer Name 2';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
            ValidateTableRelation = false;
        }
        field(11; "Customer No. 3"; Code[20])
        {
            Caption = 'Customer No. 3';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer."No.";
        }
        field(12; "Customer Name 3"; Text[50])
        {
            Caption = 'Customer Name 3';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
            ValidateTableRelation = false;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Temporary Contract,Contract,Revocation of Contract,Reservation';
            OptionMembers = Open,TempContract,Contract,Revocation,Reservation;

            trigger OnValidate()
            var
                _ContractMgt: Codeunit "DK_Contract Mgt.";
            begin
            end;
        }
        field(14; "Cemetery Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cemetery Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(15; "Cemetery Class Dis. Rate"; Decimal)
        {
            Caption = 'Cemetery Class Discount(%)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(16; "Cemetery Class Discount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cemetery Class Dis. Amount (-)';
            DataClassification = ToBeClassified;
        }
        field(17; "General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'General Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(18; "Landscape Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Landscape Architecture Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(19; "Bury Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bury Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(20; "Cemetery Discount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cemetery Discount (-)';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(22; "Deposit Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Deposit Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(23; "Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Contract Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(24; "Rece. Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rece. Remaining Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Deposit Receipt Date"; Date)
        {
            Caption = 'Deposit Receipt Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Pay. Contract Rece. Date"; Date)
        {
            Caption = 'Payment Contract Receipt Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Remaining Due Date"; DateTime)
        {
            Caption = 'Remaining Due Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _FunctionSetup: Record "DK_Function Setup";
            begin
            end;
        }
        field(28; "Remaining Receipt Date"; Date)
        {
            Caption = 'Remaining Receipt Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Alarm Period 1"; DateTime)
        {
            Caption = 'Alarm Period 1';
            DataClassification = ToBeClassified;
        }
        field(30; "Send Alarm Date/Time 1"; DateTime)
        {
            Caption = 'Alarm Period 1';
            DataClassification = ToBeClassified;
        }
        field(31; "Alarm Period 2"; DateTime)
        {
            Caption = 'Alarm Period 2';
            DataClassification = ToBeClassified;
        }
        field(32; "Send Alarm Date/Time 2"; DateTime)
        {
            Caption = 'Alarm Period 2';
            DataClassification = ToBeClassified;
        }
        field(33; "CRM SalesPerson Code"; Code[20])
        {
            Caption = 'CRM SalesPerson Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM SalesPerson";

            trigger OnValidate()
            var
                _CRMSalesPerson: Record "DK_CRM SalesPerson";
            begin
            end;
        }
        field(34; "CRM SalesPerson"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM SalesPerson".Name WHERE(Code = FIELD("CRM SalesPerson Code")));
            Caption = 'CRM SalesPerson';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _CRMSalesPerson: Record "DK_CRM SalesPerson";
            begin
            end;
        }
        field(35; "CRM External Sales Code"; Code[20])
        {
            Caption = 'CRM External Sales Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM External Sales";
        }
        field(36; "CRM External Sales"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM External Sales".Name WHERE(Code = FIELD("CRM External Sales Code")));
            Caption = 'CRM External Sales';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "CRM Funeral Hall Code"; Code[20])
        {
            Caption = 'CRM Funeral Hall Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM Funeral Hall";
        }
        field(38; "CRM Funeral Hall"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Funeral Hall".Name WHERE("No." = FIELD("CRM Funeral Hall Code")));
            Caption = 'CRM Funeral Hall';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "CRM Funeral Service Code"; Code[20])
        {
            Caption = 'CRM Funeral Service Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM Funeral Service";
        }
        field(40; "CRM Funeral Service"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Funeral Service".Name WHERE("No." = FIELD("CRM Funeral Service Code")));
            Caption = 'CRM Funeral Service';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "CRM Key"; Text[50])
        {
            Caption = 'CRM Key';
            DataClassification = ToBeClassified;
        }
        field(42; "CRM Channel Vendor No."; Code[20])
        {
            Caption = 'CRM Channel Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_CRM Channel Vendor";
        }
        field(43; "CRM Channel Vendor"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Channel Vendor".Name WHERE("No." = FIELD("CRM Channel Vendor No.")));
            Caption = 'CRM Channel Vendor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Revocation Register"; Boolean)
        {
            Caption = 'Revocation Register';
        }
        field(45; "Revocation Date"; Date)
        {
            Caption = 'Revocation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "General Expiration Date"; Date)
        {
            Caption = 'General Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(47; "Land. Arc. Expiration Date"; Date)
        {
            Caption = 'Land. Arc. Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(48; "Before Cemetery No."; Code[20])
        {
            Caption = 'Before Cemetery No.';
            DataClassification = ToBeClassified;
        }
        field(49; "Associate Name"; Text[50])
        {
            Caption = 'Associate Name';
            DataClassification = ToBeClassified;
        }
        field(50; "Associate Mobile No."; Text[30])
        {
            Caption = 'Associate Mobile No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(51; "Associate Phone No."; Text[30])
        {
            Caption = 'Associate Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(52; "Associate E-Mail"; Text[80])
        {
            Caption = 'Associate E-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(53; "Associate Post Code"; Code[10])
        {
            Caption = 'Associate Post Code';
            DataClassification = ToBeClassified;
        }
        field(54; "Associate Address"; Text[50])
        {
            Caption = 'Associate Address';
            DataClassification = ToBeClassified;
        }
        field(55; "Associate Address 2"; Text[50])
        {
            Caption = 'Associate Address 2';
            DataClassification = ToBeClassified;
        }
        field(56; "Applied Date"; Date)
        {
            Caption = 'Applied Date';
            DataClassification = ToBeClassified;
        }
        field(57; Memo; Text[1024])
        {
            Caption = 'Memo';
            DataClassification = ToBeClassified;
        }
        field(58; "Record Del"; Boolean)
        {
            Caption = 'Record Del';
            DataClassification = ToBeClassified;
        }
        field(59; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery Code";

            trigger OnValidate()
            var
                _Cemetery: Record DK_Cemetery;
                _ContractMgt: Codeunit "DK_Contract Mgt.";
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
                _UnitPrice: Decimal;
            begin
            end;
        }
        field(60; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Man. Fee hike Exemption Date"; DateTime)
        {
            Caption = 'Man. Fee hike Exemption Date';
            DataClassification = ToBeClassified;
        }
        field(62; "Management Unit"; Integer)
        {
            Caption = 'Management Unit';
            DataClassification = ToBeClassified;
            MaxValue = 10;
            MinValue = 0;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
            end;
        }
        field(63; "Man. Fee Exemption Date"; DateTime)
        {
            Caption = 'Man. Fee Exemption Date';
            DataClassification = ToBeClassified;
        }
        field(64; "Contract Type"; Option)
        {
            Caption = 'Contract Tpye';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Group,Group Sub';
            OptionMembers = General,Group,Sub;
        }
        field(65; "Group Contract No."; Code[20])
        {
            Caption = 'Group Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Contract Type" = CONST(Sub)) DK_Contract WHERE("Contract Type" = CONST(Group),
                                                                               Status = CONST(FullPayment));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
            end;
        }
        field(66; "Admin. Expense Option"; Option)
        {
            Caption = 'Admin. Expense Option';
            DataClassification = ToBeClassified;
            OptionCaption = 'Per Contract,Per Group';
            OptionMembers = "Per Contract","Per Group";
        }
        field(67; "CRM Contract Type"; Text[30])
        {
            Caption = 'CRM Contract Type';
            DataClassification = ToBeClassified;
        }
        field(68; "CRM Admin. Expense Option"; Text[30])
        {
            Caption = 'CRM Admin. Expense Option';
            DataClassification = ToBeClassified;
        }
        field(69; "Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount';
            DataClassification = ToBeClassified;
        }
        field(70; "Revocation Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Revocation Amount';
            DataClassification = ToBeClassified;
        }
        field(71; "Associate Relationship"; Text[10])
        {
            Caption = 'Associate Relationship';
            DataClassification = ToBeClassified;
        }
        field(72; "Deposit Publish"; Option)
        {
            Caption = 'Deposit Publish';
            DataClassification = ToBeClassified;
            OptionCaption = 'Unpublished,Cash Receipt,Card Receipt,CashandCard';
            OptionMembers = Unpublished,Cash,Card,CashandCard;
        }
        field(73; "Contract Publish"; Option)
        {
            Caption = 'Contract Publish';
            DataClassification = ToBeClassified;
            OptionCaption = 'Unpublished,Cash Receipt,Card Receipt,CashandCard';
            OptionMembers = Unpublished,Cash,Card,CashandCard;
        }
        field(74; "Remaining Publish"; Option)
        {
            Caption = 'Remaining Publish';
            DataClassification = ToBeClassified;
            OptionCaption = 'Unpublished,Cash Receipt,Card Receipt,CashandCard';
            OptionMembers = Unpublished,Cash,Card,CashandCard;
        }
        field(75; "CRM Sales Type Seq"; Integer)
        {
            Caption = 'CRM Sales Type Seq';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("CRM Sales Type");
            end;
        }
        field(76; "CRM Sales Type"; Text[50])
        {
            CalcFormula = Lookup("DK_CRM Sales Type".Name WHERE(Seq = FIELD("CRM Sales Type Seq")));
            Caption = 'CRM Sales Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Etc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Etc. Amount';
            DataClassification = ToBeClassified;
        }
        field(78; "Etc. Discount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Etc. Discount';
            DataClassification = ToBeClassified;
        }
        field(79; "Total Contract Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Contract Amount';
            DataClassification = ToBeClassified;
        }
        field(80; "Close Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Close Amount';
            DataClassification = ToBeClassified;
        }
        field(3000; "Main Kinsman Name"; Text[50])
        {
            Caption = 'Main Kinsman Name';
            Description = 'DK34';
        }
        field(3001; "Main Kinsman Mobile No."; Text[30])
        {
            Caption = 'Main Kinsman Mobile No.';
            Description = 'DK34';
        }
        field(3002; "Main Kinsman Phone No."; Text[30])
        {
            Caption = 'Main Kinsman Phone No.';
            Description = 'DK34';
        }
        field(3003; "Main Kinsman E-Mail"; Text[80])
        {
            Caption = 'Main Kinsman E-Mail';
            Description = 'DK34';
        }
        field(3004; "Main Kinsman Post Code"; Code[10])
        {
            Caption = 'Main Kinsman Post Code';
            Description = 'DK34';
        }
        field(3005; "Main Kinsman Address"; Text[50])
        {
            Caption = 'Main Kinsman Address';
            Description = 'DK34';
        }
        field(3006; "Main Kinsman Address 2"; Text[50])
        {
            Caption = 'Main Kinsman Address 2';
            Description = 'DK34';
        }
        field(3007; "Main Kinsman Relationship"; Text[30])
        {
            Caption = 'Main Kinsman Relationship';
            DataClassification = ToBeClassified;
            Description = 'DK34';
        }
        field(3008; "Sub Kinsman Name"; Text[50])
        {
            Caption = 'Sub Kinsman Name';
            Description = 'DK34';
        }
        field(3009; "Sub Kinsman Mobile No."; Text[30])
        {
            Caption = 'Sub Kinsman Mobile No.';
            Description = 'DK34';
        }
        field(3010; "Sub Kinsman Phone No."; Text[30])
        {
            Caption = 'Sub Kinsman Phone No.';
            Description = 'DK34';
        }
        field(3011; "Sub Kinsman E-Mail"; Text[80])
        {
            Caption = 'Sub Kinsman E-Mail';
            Description = 'DK34';
        }
        field(3012; "Sub Kinsman Post Code"; Code[10])
        {
            Caption = 'Sub Kinsman Post Code';
            Description = 'DK34';
        }
        field(3013; "Sub Kinsman Address"; Text[50])
        {
            Caption = 'Sub Kinsman Address';
            Description = 'DK34';
        }
        field(3014; "Sub Kinsman Address 2"; Text[50])
        {
            Caption = 'Sub Kinsman Address 2';
            Description = 'DK34';
        }
        field(3015; "Sub Kinsman Relationship"; Text[30])
        {
            Caption = 'Sub Kinsman Relationship';
            DataClassification = ToBeClassified;
            Description = 'DK34';
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
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Data Type")
        {
        }
        key(Key3; "Contract No.")
        {
        }
        key(Key4; "Contract Date")
        {
        }
        key(Key5; "Main Customer Name")
        {
        }
        key(Key6; "Customer Name 2")
        {
        }
        key(Key7; "Customer Name 3")
        {
        }
        key(Key8; "Cemetery Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Entry No." = 0 then
            Rec."Entry No." := GetNextEntryNo;

        "Data Date" := Today;
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
    end;

    local procedure GetNextEntryNo(): BigInteger
    var
        _InterlinkContractwithCRMLog: Record "DK_Interlink Con. with CRM Log";
    begin
        _InterlinkContractwithCRMLog.SetCurrentKey("Entry No.");
        if _InterlinkContractwithCRMLog.FindLast then
            exit(_InterlinkContractwithCRMLog."Entry No." + 1);

        exit(1);
    end;
}

