table 50000 "DK_Function Setup"
{
    // 
    // DK34: 20201029
    //   - Add Field: "Reagree To Provide Info Nos."
    //     : 20201104
    //   - Add Field: "Litigation Raw Progress Nos."
    //   - Add Field: "Other Service Nos.", "KPI Target Nos."
    // 
    // DK35: 20210120
    //   - Add Field: "CRM Fr. Rel. URL"
    //   - Modify Trigger: Use CRM Interface - OnValidate()

    Caption = 'Function Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Nos."; Code[20])
        {
            Caption = 'Employee Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Init. Visual Cemetery PW"; Text[20])
        {
            Caption = 'Init. Visual Cemetery PW';
            DataClassification = ToBeClassified;
            InitValue = 'YiPack!@#$%';
        }
        field(4; "Estate Nos."; Code[20])
        {
            Caption = 'Estate Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Cemetery Nos."; Code[20])
        {
            Caption = 'Cemetery Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Purchase Contract Nos."; Code[20])
        {
            Caption = 'Purchase Contract Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7; "Customer Nos."; Code[20])
        {
            Caption = 'Customer Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Item Nos."; Code[20])
        {
            Caption = 'Item Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Vehicle Nos."; Code[20])
        {
            Caption = 'Vehicle Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(10; "Vendor Nos."; Code[20])
        {
            Caption = 'Vendor Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Management Unit"; Integer)
        {
            Caption = 'Management Unit';
            DataClassification = ToBeClassified;
            InitValue = 5;
            MaxValue = 10;
            MinValue = 0;
        }
        field(12; "Vehicle Header Nos."; Code[20])
        {
            Caption = 'Vehicle Header Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "Project Nos."; Code[20])
        {
            Caption = 'Project Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(14; "Prevent Neg. Budget"; Boolean)
        {
            Caption = 'Prevent Neg. Budget';
            DataClassification = ToBeClassified;
        }
        field(15; "Customer Requests Nos."; Code[20])
        {
            Caption = 'Customer Requests Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(16; "Rece. Ship. Header Nos."; Code[20])
        {
            Caption = 'Receipt Shipment Header Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17; "SMS DB Con. Code"; Code[20])
        {
            Caption = 'SMS Service DB Connection Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_External DB Con. Infor.".Code WHERE("DB Test Conn. Date" = FILTER(<> 0D));
        }
        field(18; "Virtual Accnt. DB Con. Code"; Code[20])
        {
            Caption = 'Virtual Accnt DB Connection Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_External DB Con. Infor.".Code WHERE("DB Test Conn. Date" = FILTER(<> 0D));
        }
        field(19; "Development Nos."; Code[20])
        {
            Caption = 'Development Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Request Expesnsed Nos."; Code[20])
        {
            Caption = 'Request Expesnsed Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(21; "Expenses Due Date"; DateFormula)
        {
            Caption = 'Expenses Due Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Move The Grave Nos."; Code[20])
        {
            Caption = 'Move The Grave Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(23; "Field Work Nos."; Code[20])
        {
            Caption = 'Field Work Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(24; "Payment Receipt Nos."; Code[20])
        {
            Caption = 'Payment Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(25; "Receipt Type Code"; Code[20])
        {
            Caption = 'Receipt Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Field Work Main Category".Code WHERE(Blocked = CONST(false));
        }
        field(26; "Today Funeral Nos."; Code[20])
        {
            Caption = 'Today Funeral Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(27; "Cem. Services Nos."; Code[20])
        {
            Caption = 'Cem. Services Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(28; "Publish Admin. Expense Nos."; Code[20])
        {
            Caption = 'Publish Admin. Expense Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Contract Nos."; Code[20])
        {
            Caption = 'Contract Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "Admin. Expense Target"; DateFormula)
        {
            Caption = 'Admin. Expense Target';
            DataClassification = ToBeClassified;
            InitValue = '2M';
        }
        field(31; "Admin. Expense Due Period"; DateFormula)
        {
            Caption = 'Admin. Expense Due Period';
            DataClassification = ToBeClassified;
            InitValue = '3M+CM';
        }
        field(32; "Revocation Contract Nos."; Code[20])
        {
            Caption = 'Revocation Contract Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(33; "SMS Phone No."; Text[15])
        {
            Caption = 'SMS Phone No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."SMS Phone No." <> "SMS Phone No." then begin
                    if "SMS Phone No." <> '' then begin
                        if not _CommFun.CheckValidPhoneNo("SMS Phone No.") then
                            Error(MSG001, FieldCaption("SMS Phone No."));
                    end;
                end;
            end;
        }
        field(34; "Litigation Printing Nos."; Code[20])
        {
            Caption = 'Litigation Printing Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(35; "SMS Image Server TempFolder"; Text[30])
        {
            Caption = 'SMS Image Server TempFolder';
            DataClassification = ToBeClassified;
        }
        field(36; "Estate Group Nos."; Code[20])
        {
            Caption = 'Estate Group Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(37; "Alarm period 1"; DateFormula)
        {
            Caption = 'Remaining Expiration Alarm period 1';
            DataClassification = ToBeClassified;
            InitValue = '7D';
        }
        field(38; "Alarm period 2"; DateFormula)
        {
            Caption = 'Remaining Expiration Alarm period 2';
            DataClassification = ToBeClassified;
            InitValue = '30D';
        }
        field(39; "Alarm Alternative"; Code[20])
        {
            Caption = 'Alarm Alternative';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department.Code WHERE(Blocked = CONST(false));
        }
        field(40; "Alarm Send Period"; DateFormula)
        {
            Caption = 'Alarm Send Period';
            DataClassification = ToBeClassified;
            InitValue = '15D';
        }
        field(41; "Payment Cr. Memo Nos."; Code[20])
        {
            Caption = 'Payment Cr. Memo Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(42; "Membership Printing Nos."; Code[20])
        {
            Caption = 'Membership Printing Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(43; "Cng. Cust. In Contract Nos."; Code[20])
        {
            Caption = 'Change Customer In Contract';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(44; "Delay Interest Rate"; Decimal)
        {
            Caption = 'Delay Interest Rate(%)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(45; "NAS Contract File Folder"; Text[250])
        {
            Caption = 'NAS Contract File Folder';
            DataClassification = ToBeClassified;
        }
        field(46; "QRCode URL"; Text[100])
        {
            Caption = 'QR Code URL';
            DataClassification = ToBeClassified;
        }
        field(47; "PG URL"; Text[250])
        {
            Caption = 'PG URL';
            DataClassification = ToBeClassified;
        }
        field(48; "Pay. Expect Nos."; Code[20])
        {
            Caption = 'Payment Expect Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(49; "Payment Expect Due Period"; DateFormula)
        {
            Caption = 'Payment Expect Due Period';
            DataClassification = ToBeClassified;
        }
        field(50; "Use Virtual Account"; Boolean)
        {
            Caption = 'Use Virtual Account';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _VirtualAccount: Record "DK_Virtual Account";
                _PaymentExpect: Codeunit "DK_Payment Expect";
            begin
                if xRec."Use Virtual Account" <> "Use Virtual Account" then begin
                    if "Use Virtual Account" then begin
                        TestField("Virtual Account ID");

                        _VirtualAccount.Reset;
                        if not _VirtualAccount.FindSet then
                            Error(MSG002, _VirtualAccount.TableCaption);
                    end else begin
                        _PaymentExpect.CheckPayExpectDocInAdminExpense;
                    end;
                end;
            end;
        }
        field(51; "Virtual Account ID"; Text[30])
        {
            Caption = 'Virtual Account ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _PaymentExpect: Codeunit "DK_Payment Expect";
            begin
                if xRec."Virtual Account ID" <> "Virtual Account ID" then begin
                    TestField("Use Virtual Account", false);

                    if xRec."Virtual Account ID" <> '' then begin
                        _PaymentExpect.CheckPayExpectDocInAdminExpense;

                        if not Confirm(MSG003, false, FieldCaption("Virtual Account ID")) then
                            "Virtual Account ID" := xRec."Virtual Account ID";
                    end;
                end;

            end;
        }
        field(52; "Relationship DB Con. Code"; Code[20])
        {
            Caption = 'Relationship Infor. DB Connection Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_External DB Con. Infor.".Code WHERE("DB Test Conn. Date" = FILTER(<> 0D));
        }
        field(53; "Biz Talk ID"; Text[50])
        {
            Caption = 'Biz Talk ID';
            DataClassification = ToBeClassified;
        }
        field(54; "Use SMS"; Boolean)
        {
            Caption = 'Use SMS';
            DataClassification = ToBeClassified;
        }
        field(55; "Reagree To Provide Info Nos."; Code[20])
        {
            Caption = 'Reagree To Provide Info Nos.';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "No. Series";
        }
        field(56; "Litigation Raw Progress Nos."; Code[20])
        {
            Caption = 'Litigation Raw Progress Nos.';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "No. Series";
        }
        field(57; "Other Service Nos."; Code[20])
        {
            Caption = 'Other Service Nos.';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "No. Series";
        }
        field(58; "KPI Target Nos."; Code[20])
        {
            Caption = 'KPI Target Nos.';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            TableRelation = "No. Series";
        }
        field(1000; "Use CRM Interface"; Boolean)
        {
            Caption = 'Use CRM Interface';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _DK_CRMInterfaceMgt: Codeunit "DK_CRM Interface Mgt.";
            begin
                if Rec."Use CRM Interface" <> xRec."Use CRM Interface" then begin
                    if "Use CRM Interface" then begin
                        _DK_CRMInterfaceMgt.SendCRM_FriendsAndRelatives;
                        _DK_CRMInterfaceMgt.SendCRM_Contract;
                        //>>#DK35
                        _DK_CRMInterfaceMgt.SendCRM_FriendsAndRelatives;
                        //<<
                    end;
                end;
            end;
        }
        field(1001; "CRM Customer URL"; Text[250])
        {
            Caption = 'CRM Customer URL';
            DataClassification = ToBeClassified;
        }
        field(1002; "CRM Contract URL"; Text[250])
        {
            Caption = 'CRM Contract URL';
            DataClassification = ToBeClassified;
        }
        field(1003; "CRM Fr. Rel. URL"; Text[250])
        {
            Caption = 'CRM Friends And Relatives URL';
            DataClassification = ToBeClassified;
        }
        field(50000; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50001; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(50002; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter 2';
            FieldClass = FlowFilter;
        }
        field(60000; "No. of Open Contract"; Integer)
        {
            CalcFormula = Count(DK_Contract WHERE(Status = CONST(Open)));
            Caption = 'No. of Open Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60001; "No. of Temp. Contract"; Integer)
        {
            CalcFormula = Count(DK_Contract WHERE(Status = CONST(Contract)));
            Caption = 'No. of Temporary Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60002; "No. of Pay. Bal. Contract"; Integer)
        {
            CalcFormula = Count(DK_Contract WHERE("Pay. Remaining Amount" = FILTER(<> 0),
                                                   Status = FILTER(<> Revocation)));
            Caption = 'No. of Payment Balance Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "No. of Overdue Bal. Cont."; Integer)
        {
            CalcFormula = Count(DK_Contract WHERE("Pay. Remaining Amount" = FILTER(<> 0),
                                                   "Remaining Due Date" = FIELD("Date Filter"),
                                                   Status = CONST(Contract)));
            Caption = 'No. of Overdue Balance Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60004; "No. of Unsold Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold)));
            Caption = 'No. of Unsold Cemetery';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60005; "No. of Reserved Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Reserved)));
            Caption = 'No. of Reserved Cemetery';
            FieldClass = FlowField;
        }
        field(60006; "No. of Reserv. Contract"; Integer)
        {
            CalcFormula = Count(DK_Contract WHERE(Status = CONST(Reservation)));
            Caption = 'No. of Reservation Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60007; "No. of Unsold Cemetery Conf1"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('01')));
            Caption = 'No. of Unsold Cemetery 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60008; "No. of Unsold Cemetery Conf2"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('02')));
            Caption = 'No. of Unsold Cemetery 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60009; "No. of Unsold Cemetery Conf3"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('03')));
            Caption = 'No. of Unsold Cemetery 3';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60010; "No. of Unsold Cemetery Conf4"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('04'),
                                                   "Estate Code" = FILTER(<> 'ES0046' & <> 'ES0047' & <> 'ES0048' & <> 'ES0049' & <> 'ES0050' & <> 'ES0051' & <> 'ES0052')));
            Caption = 'No. of Unsold Cemetery 4';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60011; "No. of Unsold Cemetery Conf5"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('05')));
            Caption = 'No. of Unsold Cemetery 5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60012; "No. of Unsold Cemetery Conf6"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('06')));
            Caption = 'No. of Unsold Cemetery 6';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60013; "No. of Unsold Cemetery Conf7"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold),
                                                   "Cemetery Conf. Code" = CONST('07')));
            Caption = 'No. of Unsold Cemetery 7';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60014; "No. of Cemetery"; Integer)
        {
            CalcFormula = Count(DK_Cemetery);
            Caption = 'No. of Cemetery';
            FieldClass = FlowField;
        }
        field(60015; "No. of Transfer Litigation"; Integer)
        {
            CalcFormula = Count(DK_Contract WHERE("Transfer Litigation" = CONST(true),
                                                   Status = FILTER(<> Revocation)));
            Caption = 'No. of Transfer Litigation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60016; "No. of Unsold Cemetery Conf8"; Integer)
        {
            CalcFormula = Count(DK_Cemetery WHERE(Status = CONST(Unsold), "Estate Code" = FILTER('ES0046' | 'ES0047' | 'ES0048' | 'ES0049' | 'ES0050' | 'ES0051' | 'ES0052')));
            Caption = 'No. of Unsold Cemetery Conf8';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70000; "Field Work Incomplete"; Integer)
        {
            CalcFormula = Count("DK_Field Work Header" WHERE(Status = FILTER(Open | Release),
                                                              Date = FIELD("Date Filter")));
            Caption = 'Field Work Incomplete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70001; "Field Work Complete"; Integer)
        {
            CalcFormula = Count("DK_Field Work Header" WHERE(Date = FIELD("Date Filter"),
                                                              Status = CONST(Post)));
            Caption = 'Field Work Complete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70002; "Acc. Field Work Incomplete"; Integer)
        {
            CalcFormula = Count("DK_Field Work Header" WHERE(Status = FILTER(Open | Release)));
            Caption = 'Accumulate Field Work Incomplete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70003; "Acc. Field Work Complete"; Integer)
        {
            CalcFormula = Count("DK_Field Work Header" WHERE(Status = CONST(Post)));
            Caption = 'Accumulate Field Work Complete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70004; "Customer Request Incomplete"; Integer)
        {
            CalcFormula = Count("DK_Customer Requests" WHERE("Receipt Date" = FIELD("Date Filter"),
                                                              Status = FILTER(Post | Release)));
            Caption = 'Customer Request Incomplete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70005; "Customer Request Complete"; Integer)
        {
            CalcFormula = Count("DK_Customer Requests" WHERE("Process Date" = FIELD("Date Filter"),
                                                              Status = CONST(Complete)));
            Caption = 'Customer Request Complete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70006; "Acc. Cust. Req. Incomplete"; Integer)
        {
            CalcFormula = Count("DK_Customer Requests" WHERE(Status = FILTER(Post | Release)));
            Caption = 'Accumulate Customer Request Incomplete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70007; "Acc. Cust. Req. Complete"; Integer)
        {
            CalcFormula = Count("DK_Customer Requests" WHERE(Status = CONST(Complete)));
            Caption = 'Accumulate Customer Request Complete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70008; "Cem. Services Incomplete"; Integer)
        {
            CalcFormula = Count("DK_Cemetery Services" WHERE("Receipt Date" = FIELD("Date Filter 2"),
                                                              Status = FILTER(Release | Post)));
            Caption = 'Cemetery Services Incomplete';
            FieldClass = FlowField;
        }
        field(70009; "Cem. Services Complete"; Integer)
        {
            CalcFormula = Count("DK_Cemetery Services" WHERE("Work Date" = FIELD("Date Filter 2"),
                                                              Status = CONST(Complete)));
            Caption = 'Cemetery Services Complete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70010; "Acc. Cem. Ser. Incomplete"; Integer)
        {
            CalcFormula = Count("DK_Cemetery Services" WHERE(Status = FILTER(Release | Post)));
            Caption = 'Accumulate Cemetery Services Incomplete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70011; "Acc. Cem. Ser. Complete"; Integer)
        {
            CalcFormula = Count("DK_Cemetery Services" WHERE(Status = CONST(Complete)));
            Caption = 'Accumulate Services Complete';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70012; "TODAY PG Receipt"; Integer)
        {
            CalcFormula = Count("DK_Receipted PG Document" WHERE("Payment Date" = FIELD("Date Filter 2")));
            Caption = 'TODAY PG Receipt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70013; "TODAY PG Receipt2"; Integer)
        {
            CalcFormula = Count("DK_Receipted PG Document" WHERE("Payment Date" = FIELD("Date Filter 2"),
                                                                  "Pay. Expect Doc No." = FILTER('')));
            Caption = 'TODAY PG Receipt2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80000; "Purchase Contract"; Integer)
        {
            CalcFormula = Count("DK_Purchase Contract");
            Caption = 'Purchase Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80001; "Expiry Purchase Contract"; Integer)
        {
            CalcFormula = Count("DK_Purchase Contract" WHERE(Status = CONST(Expiration)));
            Caption = 'Expiry Purchase Contract';
            FieldClass = FlowField;
        }
        field(80002; "Hold Purchase Contract"; Integer)
        {
            CalcFormula = Count("DK_Purchase Contract" WHERE(Status = CONST(Hold)));
            Caption = 'Hold Purchase Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80003; "Cancel Purchase Contract"; Integer)
        {
            Caption = 'Cancel Purchase Contract';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80004; "Contract Purchase Contract"; Integer)
        {
            CalcFormula = Count("DK_Purchase Contract" WHERE(Status = CONST(Contract)));
            Caption = 'Contract Purchase Contract';
            FieldClass = FlowField;
        }
        field(80005; "Vehicle Operation"; Integer)
        {
            CalcFormula = Count("DK_Vehicle Oper. Led. Entry" WHERE("Departure Date" = FIELD("Date Filter")));
            Caption = 'Vehicle Operation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80006; "Vehicle Refuling"; Integer)
        {
            CalcFormula = Count("DK_Vehicle Refue. Led. Entry" WHERE("Oiling Date" = FIELD("Date Filter")));
            Caption = 'Vehicle Refuling';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80007; "Vehicle Repair"; Integer)
        {
            CalcFormula = Count("DK_Vehicle Repair Led. Entry" WHERE("Repair Date" = FIELD("Date Filter")));
            Caption = 'Vehicle Repair';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80008; "Vehicle Wash"; Integer)
        {
            CalcFormula = Count("DK_Vehicle Wash Led. Entry" WHERE("Wash Date" = FIELD("Date Filter")));
            Caption = 'Vehicle Wash';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80009; "Item Shipment"; Integer)
        {
            CalcFormula = Count("DK_Item Ledger Entry" WHERE("Entry Type" = CONST(Shipment),
                                                              Date = FIELD("Date Filter")));
            Caption = 'Item Shipment';
            FieldClass = FlowField;
        }
        field(80010; "Item Receipt"; Integer)
        {
            CalcFormula = Count("DK_Item Ledger Entry" WHERE("Entry Type" = CONST(Receipt),
                                                              Date = FIELD("Date Filter")));
            Caption = 'Item Receipt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80011; "Acc. Item Shipment"; Integer)
        {
            CalcFormula = Count("DK_Item Ledger Entry" WHERE("Entry Type" = CONST(Receipt)));
            Caption = 'Accumulated Item Shipment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80012; "Acc. Item Receipt"; Integer)
        {
            CalcFormula = Count("DK_Item Ledger Entry" WHERE("Entry Type" = CONST(Shipment)));
            Caption = 'Accumulated Item Receipt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80013; "Due to Exire Purchase Contract"; Integer)
        {
            CalcFormula = Count("DK_Purchase Contract" WHERE("Max Contract Date To" = FIELD("Date Filter 2"),
                                                              Status = CONST(Contract)));
            Caption = 'Due to Exire Purchase Contract';
            FieldClass = FlowField;
        }
        field(90000; "Post Pay. Receipt Document"; Integer)
        {
            CalcFormula = Count("DK_Payment Receipt Document" WHERE("Posting Date" = FIELD("Date Filter 2"),
                                                                     Posted = CONST(true),
                                                                     "Missing Contract" = CONST(false)));
            Caption = 'Post Payment Receipt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90001; "Request Remittance"; Integer)
        {
            CalcFormula = Count("DK_Request Remittance Ledger" WHERE("Request Payment Date" = FIELD("Date Filter"),
                                                                      Status = CONST(Open)));
            Caption = 'Request Remittance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90002; "Post Req. Expenses"; Integer)
        {
            CalcFormula = Count("DK_Request Expenses Header" WHERE("Posting Date" = FIELD("Date Filter"),
                                                                    Status = CONST(Post)));
            Caption = 'Post Request Expenses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90003; "General Admin. Expense"; Integer)
        {
            CalcFormula = Count("DK_Admin. Expense Ledger" WHERE(Date = FIELD("Date Filter 2"),
                                                                  "Ledger Type" = CONST(Receipt),
                                                                  "Admin. Expense Type" = CONST(General)));
            Caption = 'Admin. Expense';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90004; "Land. Admin. Expense"; Integer)
        {
            CalcFormula = Count("DK_Admin. Expense Ledger" WHERE(Date = FIELD("Date Filter 2"),
                                                                  "Ledger Type" = CONST(Receipt),
                                                                  "Admin. Expense Type" = CONST(Landscape)));
            Caption = 'Landscape Admin Expense';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90005; "Deposit Amount Count"; Integer)
        {
            CalcFormula = Count("DK_Contract Amount Ledger" WHERE(Date = FIELD("Date Filter"),
                                                                   "Ledger Type" = CONST(Receipt),
                                                                   Type = CONST(Deposit)));
            Caption = 'Deposit Amount Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90006; "Contract Amount Count"; Integer)
        {
            CalcFormula = Count("DK_Contract Amount Ledger" WHERE(Date = FIELD("Date Filter"),
                                                                   "Ledger Type" = CONST(Receipt),
                                                                   Type = CONST(Contract)));
            Caption = 'Contract Amount Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90007; "Remaining Amount Count"; Integer)
        {
            CalcFormula = Count("DK_Contract Amount Ledger" WHERE(Date = FIELD("Date Filter"),
                                                                   "Ledger Type" = CONST(Receipt),
                                                                   Type = CONST(Remaining)));
            Caption = 'Remaining Amount Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90008; "Service Amount Count"; Integer)
        {
            CalcFormula = Count("DK_Contract Amount Ledger" WHERE(Date = FIELD("Date Filter"),
                                                                   "Ledger Type" = CONST(Receipt),
                                                                   Type = CONST(Service)));
            Caption = 'Service Amount Count';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        MSG001: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG002: Label 'The registered %1 information does not exist.';
        MSG003: Label 'Changing the %1 will affect the virtual account process behavior. Do you want to continue?';
}

