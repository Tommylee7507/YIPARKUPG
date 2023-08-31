table 50016 "DK_Request Remittance Ledger"
{
    Caption = 'Request Remittance Ledger';
    DataCaptionFields = "Account Type", "Account No.", "Account Name", "Request Payment Date", Status;
    DrillDownPageID = "DK_Request Remittance Ledger";
    LookupPageID = "DK_Request Remittance Ledger";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Vendor,Employee,Customer';
            OptionMembers = Vendor,Employee,Customer;
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Vendor)) DK_Vendor
            ELSE
            IF ("Account Type" = CONST(Employee)) DK_Employee
            ELSE
            IF ("Account Type" = CONST(Customer)) DK_Customer;
        }
        field(4; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Request Payment Date"; Date)
        {
            Caption = 'Request Payment Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Bank Code"; Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(7; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(10; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Expenses,Revocation Contract,Refund Admin. Expense';
            OptionMembers = Expenses,Revocation,RefundAdminExp;
        }
        field(11; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                ShowDocument;
            end;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Canceled,Completed';
            OptionMembers = Open,Canceled,Completed;

            trigger OnValidate()
            var
                _ReqRemittanceMgt: Codeunit "DK_Request Remittance Mgt.";
            begin
                if xRec.Status <> Status then begin
                    Clear(_ReqRemittanceMgt);
                    _ReqRemittanceMgt.UpdateOriginalDoc(Rec);
                end;
            end;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(14; "Complate Date"; Date)
        {
            Caption = 'Complate Date';
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(16; "GroupWare Doc. No."; Code[30])
        {
            Caption = 'GroupWare Document No.';
            DataClassification = ToBeClassified;
        }
        field(17; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;
        }
        field(18; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery;

            trigger OnValidate()
            begin
                CalcFields("Cemetery No.");
            end;
        }
        field(20; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(21; "Payment Card Infor."; Text[30])
        {
            Caption = 'Payment Card Infor.';
            DataClassification = ToBeClassified;
        }
        field(22; "Cancel Pay. Card Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cancel Pay. Card Amount';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        _ReqRemLed: Record "DK_Request Remittance Ledger";
        _NewEntryNo: Integer;
    begin
        if "Entry No." = 0 then begin

            _ReqRemLed.Reset;
            _ReqRemLed.SetCurrentKey("Entry No.");
            if _ReqRemLed.FindLast then
                _NewEntryNo := _ReqRemLed."Entry No.";

            _NewEntryNo += 1;

            Rec."Entry No." := _NewEntryNo;
        end;
    end;

    var
        MSG001: Label 'The target Document can not be found. %1 %2:%3';


    procedure SetCompleted()
    begin
        Validate("Complate Date", WorkDate);
        Validate(Status, Status::Completed);
        Modify;
    end;


    procedure SetCanceled()
    begin
        Validate("Complate Date", WorkDate);
        Validate(Status, Status::Canceled);
        Modify;
    end;


    procedure SetReOpen()
    begin
        Validate("Complate Date", 0D);
        Validate(Status, Status::Open);
        Modify;
    end;


    procedure ShowDocument()
    var
        _RequestExpensesHeader: Record "DK_Request Expenses Header";
        _RequestExpensesList: Page "DK_Request Expenses List";
        _PostedReqExpensesList: Page "DK_Posted Req. Expenses List";
        _RevocationContract: Record "DK_Revocation Contract";
        _RevocationContractList: Page "DK_Revocation Contract List";
        _PostedRevContractList: Page "DK_Posted Rev. Contract List";
        _PatReceiptDoc: Record "DK_Payment Receipt Document";
    begin

        case "Source Type" of
            "Source Type"::Expenses:
                begin
                    if _RequestExpensesHeader.Get("Source No.") then begin
                        if _RequestExpensesHeader.Status in [_RequestExpensesHeader.Status::Open,
                                                             _RequestExpensesHeader.Status::Released] then begin
                            Clear(_RequestExpensesList);
                            _RequestExpensesList.LookupMode(true);
                            _RequestExpensesList.SetTableView(_RequestExpensesHeader);
                            _RequestExpensesList.SetRecord(_RequestExpensesHeader);
                            _RequestExpensesList.Editable(false);
                            _RequestExpensesList.RunModal;
                        end else begin
                            Clear(_PostedReqExpensesList);
                            _PostedReqExpensesList.LookupMode(true);
                            _PostedReqExpensesList.SetTableView(_RequestExpensesHeader);
                            _PostedReqExpensesList.SetRecord(_RequestExpensesHeader);
                            _PostedReqExpensesList.Editable(false);
                            _PostedReqExpensesList.RunModal;
                        end;
                    end else begin
                        Error(MSG001, "Source Type"::Expenses, _RequestExpensesHeader.FieldCaption("No."), "Source No.");
                    end;
                end;
            "Source Type"::Revocation:
                begin
                    if _RevocationContract.Get("Source No.") then begin
                        if _RevocationContract.Status in [_RevocationContract.Status::Complate] then begin

                            Clear(_PostedRevContractList);
                            _PostedRevContractList.LookupMode(true);
                            _PostedRevContractList.SetTableView(_RevocationContract);
                            _PostedRevContractList.SetRecord(_RevocationContract);
                            _PostedRevContractList.Editable(false);
                            _PostedRevContractList.RunModal;
                        end else begin
                            Clear(_RevocationContractList);
                            _RevocationContractList.LookupMode(true);
                            _RevocationContractList.SetTableView(_RevocationContract);
                            _RevocationContractList.SetRecord(_RevocationContract);
                            _RevocationContractList.Editable(false);
                            _RevocationContractList.RunModal;
                        end;
                    end else begin
                        Error(MSG001, "Source Type"::Revocation, _RevocationContract.FieldCaption("Document No."), "Source No.");
                    end;
                end;

            "Source Type"::RefundAdminExp:
                begin
                    _PatReceiptDoc.Reset;
                    _PatReceiptDoc.SetRange("Document Type", _PatReceiptDoc."Document Type"::Refund);
                    _PatReceiptDoc.SetRange("Document No.", "Source No.");
                    if _PatReceiptDoc.FindSet then begin
                        _PatReceiptDoc.ShowPostedPaymentDocument("Source No.");
                    end else begin
                        Error(MSG001, "Source Type"::RefundAdminExp, _RevocationContract.FieldCaption("Document No."), "Source No.");
                    end;
                end;
        end;
    end;
}

