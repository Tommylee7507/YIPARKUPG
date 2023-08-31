table 50054 DK_SMS
{
    // 
    // DK34: 20201026
    //   - Modify Field: Type(Add Option String: ReagreeInfo)

    Caption = 'SMS Message';
    DataCaptionFields = Type;
    DrillDownPageID = "DK_SMS List";
    LookupPageID = "DK_SMS List";

    fields
    {
        field(1; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Department;

            trigger OnValidate()
            begin
                CalcFields("Department Name");
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Department Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Department.Name WHERE(Code = FIELD("Department Code")));
            Caption = 'Department Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "SMS Message"; BLOB)
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;
        }
        field(6; "Short Message"; Text[2000])
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommonFunction: Codeunit "DK_Common Function";
            begin
                if xRec."Short Message" <> "Short Message" then begin
                    if "Short Message" <> '' then begin
                        Clear(_CommonFunction);
                        "SMS Length" := _CommonFunction.GetKoreanCharLen("Short Message");

                        if "SMS Length" > 1500 then
                            Error(MSG001);
                    end else begin
                        "SMS Length" := 0;
                    end;
                end;
            end;
        }
        field(7; "SMS Length"; Decimal)
        {
            Caption = 'SMS Length';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
            MinValue = 0;
        }
        field(8; Image1; BLOB)
        {
            Caption = 'Image1';
            Compressed = false;
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(9; Image2; BLOB)
        {
            Caption = 'Image2';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(10; Image3; BLOB)
        {
            Caption = 'Image3';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(11; "From Contact"; Text[20])
        {
            Caption = 'From Contact';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _CommFun: Codeunit "DK_Common Function";
            begin
                if xRec."From Contact" <> "From Contact" then begin

                    if "From Contact" <> '' then begin
                        if not _CommFun.CheckValidMobileNo("From Contact") then
                            Error(MSG001, FieldCaption("From Contact"));
                    end;
                end;
            end;
        }
        field(12; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Contract No." <> "Contract No." then begin
                    if _Contract.Get("Contract No.") then begin
                        "Cemetery No." := _Contract."Cemetery No.";
                        "Cemetery Code" := _Contract."Cemetery Code";

                        _Contract.CalcFields("Main Associate Name", "Sub Associate Name");
                        case _Contract."Contact Target" of
                            _Contract."Contact Target"::MainCustomer:
                                "Contact Name" := _Contract."Main Customer Name";
                            _Contract."Contact Target"::MainAssociate:
                                "Contact Name" := _Contract."Main Associate Name";
                            _Contract."Contact Target"::SubAssociate:
                                "Contact Name" := _Contract."Sub Associate Name";
                        end;
                    end else begin
                        "Cemetery No." := '';
                        "Cemetery Code" := '';
                        "Contact Name" := '';
                    end;
                    CalcFields("Main Customer Name");
                end;
            end;
        }
        field(13; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;

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
        field(14; "Cemetery No."; Text[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Main Customer Name"; Text[50])
        {
            CalcFormula = Lookup(DK_Contract."Main Customer Name" WHERE("No." = FIELD("Contract No.")));
            Caption = 'Main Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Purchase Contract,Remaining Amount,Vehicle,Field Work,Customer Request,Cemetry Service,Receipt,Payment Expect PG,Payment Expect VA,Reagree Provide To Information';
            OptionMembers = General,PurchContract,RemAmount,Vehicle,FieldWork,CustRequest,Service,Receipt,PaymentExpectPG,PaymentExpectVA,ReagreeInfo;

            trigger OnValidate()
            begin
                Type_Onvalidate(Type);
            end;
        }
        field(17; "Biz Talk Tamplate No."; Text[30])
        {
            Caption = 'Biz Talk Tamplate No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _SMS: Record DK_SMS;
            begin
                if xRec."Biz Talk Tamplate No." <> "Biz Talk Tamplate No." then begin
                    if "Biz Talk Tamplate No." <> '' then begin
                        _SMS.Reset;
                        _SMS.SetRange("Department Code", "Department Code");
                        _SMS.SetFilter("Line No.", '<>%1', "Line No.");
                        _SMS.SetRange("Biz Talk Tamplate No.", "Biz Talk Tamplate No.");
                        if _SMS.FindSet then begin
                            Error(MSG003, _SMS.Type, FieldCaption("Biz Talk Tamplate No."), "Biz Talk Tamplate No.");
                        end;
                    end;
                end;
            end;
        }
        field(18; "Contact Name"; Text[30])
        {
            Caption = 'Contact Name';
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
        key(Key1; "Department Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
        _SMS: Record DK_SMS;
        _NewLineNo: Integer;
    begin
        //_DepartmentBoard.Check_EmployeeUserID(USERID);

        if "Line No." = 0 then begin
            _SMS.Reset;
            _SMS.SetCurrentKey("Department Code", "Line No.");
            _SMS.SetRange("Department Code", '');
            if _SMS.FindLast then
                _NewLineNo := _SMS."Line No.";

            _NewLineNo += 10000;

            "Line No." := _NewLineNo;
        end;

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        //ERROR('');
    end;

    var
        MSG001: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
        MSG002: Label 'Cannot generate the same %1.';
        MSG003: Label 'The %3 value of %2 you specified is already in use. %1';


    procedure Type_Onvalidate(pType: Integer)
    var
        _SMS: Record DK_SMS;
    begin
        if pType = Type::General then
            exit;

        _SMS.Reset;
        _SMS.SetCurrentKey("Line No.");
        _SMS.SetRange("Department Code", Rec."Department Code");
        _SMS.SetRange(Type, pType);
        if _SMS.FindSet then
            Error(MSG002, Format(Type));
    end;
}

