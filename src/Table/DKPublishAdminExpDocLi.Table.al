table 50088 "DK_Publish Admin. Exp. Doc. Li"
{
    // 
    // #2134: 20200902
    //   - Modify Trigger: Check Customer Infor. - OnValidate

    Caption = 'Publish Administrative Expense Document Line';
    DataCaptionFields = "Document No.", "Contract No.", "Cemetery No.", "Customer Name";
    DrillDownPageID = "DK_Detail Publish Ad. Ex. List";
    LookupPageID = "DK_Detail Publish Ad. Ex. List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("Document Date");
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract WHERE(Status = FILTER(<> Revocation));

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _Customer: Record DK_Customer;
                _PublishAdminExpense: Codeunit "DK_Publish Admin. Expense";
            begin
                if xRec."Contract No." <> "Contract No." then begin
                    CheckHeaderStatusReleased;

                    Clear(_PublishAdminExpense);
                    _PublishAdminExpense.ChangeContract(Rec);

                end;
            end;
        }
        field(4; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Cemetery."Cemetery Code" WHERE("Contract No." = FIELD("Contract No."));

            trigger OnValidate()
            begin
                CalcFields("Cemetery No.");
            end;
        }
        field(6; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Customer;
        }
        field(8; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(9; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(10; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(11; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Payment Due Date"; Date)
        {
            Caption = 'Payment Due Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (xRec."Payment Due Date" <> "Payment Due Date") then
                    if "Payment Due Date" <= WorkDate then
                        Error(MSG002, FieldCaption("Payment Due Date"), WorkDate);
            end;
        }
        field(14; "Non-Payment From Date 1"; Date)
        {
            Caption = 'Non-Payment From Date 1';
            DataClassification = ToBeClassified;
        }
        field(15; "Non-Payment To Date 1"; Date)
        {
            Caption = 'Non-Payment To Date 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Non-Payment To Date 1" <> "Non-Payment To Date 1" then begin

                    if ("Non-Payment From Date 1" = 0D) or ("Non-Payment To Date 1" = 0D) then
                        Validate("Non-Pay. General Amount", 0)
                    else begin
                        Contract.Get("Contract No.");
                        Clear(AdminExpenseMgt);
                        Validate("Non-Pay. General Amount", AmountRoundUp(AdminExpenseMgt.GetPeriodAdminExpense(Contract,
                                                      AdminExpenseLedger."Admin. Expense Type"::General,
                                                      "Non-Payment From Date 1",
                                                      "Non-Payment To Date 1",
                                                      "Document No.",
                                                      "Line No.",
                                                      true)));
                    end;
                end;
            end;
        }
        field(16; "Prepayment From Date 1"; Date)
        {
            Caption = 'Prepayment From Date 1';
            DataClassification = ToBeClassified;
        }
        field(17; "Prepayment To Date 1"; Date)
        {
            Caption = 'Prepayment To Date 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Prepayment To Date 1" <> "Prepayment To Date 1" then begin
                    if ("Prepayment To Date 1" <> 0D) and ("Prepayment From Date 1" = 0D) then
                        Error(MSG004, FieldCaption("Prepayment From Date 1"), FieldCaption("Prepayment To Date 1"));

                    if "Prepayment From Date 1" > "Prepayment To Date 1" then
                        Error(MSG003, FieldCaption("Prepayment From Date 1"), FieldCaption("Prepayment To Date 1"));

                    if "Prepayment To Date 1" = 0D then
                        Validate("General Amount", 0)
                    else begin
                        Contract.Get("Contract No.");
                        Clear(AdminExpenseMgt);
                        Validate("General Amount", AmountRoundUp(AdminExpenseMgt.GetPeriodAdminExpense2(Contract,
                                                      AdminExpenseLedger."Admin. Expense Type"::General,
                                                      "Prepayment From Date 1",
                                                      "Prepayment To Date 1",
                                                      "Document No.",
                                                      "Line No.",
                                                      false)));
                    end;
                end;
            end;
        }
        field(18; "General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'General Amount';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                /*
                IF "General Amount" <> 0 THEN BEGIN
                  CLEAR(AdminExpenseMgt);
                  AdminExpenseMgt.LookupAdminExpenseLowData(Rec,AdminExpenseLedger."Admin. Expense Type"::General,FALSE);
                END;
                */

            end;

            trigger OnValidate()
            begin
                if xRec."General Amount" <> "General Amount" then
                    CalcTotalAmount;
            end;
        }
        field(19; "Landscape Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Landscape Architecture Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnLookup()
            begin
                /*
                IF "Landscape Arc. Amount" <> 0 THEN BEGIN
                  CLEAR(AdminExpenseMgt);
                  AdminExpenseMgt.LookupAdminExpenseLowData(Rec,AdminExpenseLedger."Admin. Expense Type"::Landscape,FALSE);
                END;
                */

            end;

            trigger OnValidate()
            begin

                if xRec."Landscape Arc. Amount" <> "Landscape Arc. Amount" then
                    CalcTotalAmount;
            end;
        }
        field(20; "Non-Pay. General Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Non-Payment General Amount';
            Editable = false;

            trigger OnLookup()
            begin
                /*
                IF "Non-Pay. General Amount" <> 0 THEN BEGIN
                  CLEAR(AdminExpenseMgt);
                  AdminExpenseMgt.LookupAdminExpenseLowData(Rec,AdminExpenseLedger."Admin. Expense Type"::General,TRUE);
                END;
                */

            end;

            trigger OnValidate()
            begin
                if xRec."Non-Pay. General Amount" <> "Non-Pay. General Amount" then
                    CalcTotalAmount;
            end;
        }
        field(21; "Non-Pay. Land. Arc. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Non-Payment Landscape Arc. Amount';
            Editable = false;

            trigger OnLookup()
            begin
                /*
                IF "Non-Pay. Land. Arc. Amount" <> 0 THEN BEGIN
                  CLEAR(AdminExpenseMgt);
                  AdminExpenseMgt.LookupAdminExpenseLowData(Rec,AdminExpenseLedger."Admin. Expense Type"::Landscape,TRUE);
                END;
                */

            end;

            trigger OnValidate()
            begin
                if xRec."Non-Pay. Land. Arc. Amount" <> "Non-Pay. Land. Arc. Amount" then
                    CalcTotalAmount;
            end;
        }
        field(22; "Phone No."; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;
        }
        field(23; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;
        }
        field(24; "Non-Payment From Date 2"; Date)
        {
            Caption = 'Non-Payment From Date 2';
            DataClassification = ToBeClassified;
        }
        field(25; "Non-Payment To Date 2"; Date)
        {
            Caption = 'Non-Payment To Date 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec."Non-Payment To Date 2" <> "Non-Payment To Date 2" then begin

                    if ("Non-Payment From Date 2" = 0D) or ("Non-Payment To Date 2" = 0D) then
                        Validate("Non-Pay. Land. Arc. Amount", 0)
                    else begin
                        Contract.Get("Contract No.");
                        Clear(AdminExpenseMgt);
                        Validate("Non-Pay. Land. Arc. Amount", AmountRoundUp(AdminExpenseMgt.GetPeriodAdminExpense(Contract,
                                                                              AdminExpenseLedger."Admin. Expense Type"::Landscape,
                                                                              "Non-Payment From Date 2",
                                                                              "Non-Payment To Date 2",
                                                                              "Document No.",
                                                                              "Line No.",
                                                                              true)));
                    end;
                end;
            end;
        }
        field(26; "Prepayment From Date 2"; Date)
        {
            Caption = 'Prepayment From Date 2';
            DataClassification = ToBeClassified;
        }
        field(27; "Prepayment To Date 2"; Date)
        {
            Caption = 'Prepayment To Date 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DK_Cemetery: Record DK_Cemetery;
            begin
                if xRec."Prepayment To Date 2" <> "Prepayment To Date 2" then begin

                    if "Prepayment To Date 2" = 0D then begin
                        CalcFields("Landscape Architecture");
                        if not "Landscape Architecture" then
                            Error(MSG001, DK_Cemetery.TableCaption);
                    end;

                    if ("Prepayment To Date 2" <> 0D) and ("Prepayment From Date 2" = 0D) then
                        Error(MSG004, FieldCaption("Prepayment From Date 2"), FieldCaption("Prepayment To Date 2"));

                    if "Prepayment From Date 2" > "Prepayment To Date 2" then
                        Error(MSG003, FieldCaption("Prepayment From Date 2"), FieldCaption("Prepayment To Date 2"));

                    if "Prepayment To Date 2" = 0D then
                        Validate("Landscape Arc. Amount", 0)
                    else begin
                        Contract.Get("Contract No.");
                        Clear(AdminExpenseMgt);
                        Validate("Landscape Arc. Amount", AmountRoundUp(AdminExpenseMgt.GetPeriodAdminExpense2(Contract,
                                                                              AdminExpenseLedger."Admin. Expense Type"::Landscape,
                                                                              "Prepayment From Date 2",
                                                                              "Prepayment To Date 2",
                                                                              "Document No.",
                                                                              "Line No.",
                                                                              false)));
                    end;
                end;
            end;
        }
        field(28; "Check Customer Infor."; Boolean)
        {
            Caption = 'Check Customer Information';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Customer: Record DK_Customer;
                _ChangedCustomerHistory: Record "DK_Changed Customer History";
                MSG001: Label 'The %1 is (0). Check the contents!';
                _FunSetup: Record "DK_Function Setup";
                _PaymentExpect: Codeunit "DK_Payment Expect";
                _PayExpectDocHdr: Record "DK_Pay. Expect Doc. Header";
            begin
                if xRec."Check Customer Infor." <> "Check Customer Infor." then
                    _FunSetup.Get;

                if "Check Customer Infor." then begin
                    //Assgin
                    //>> #2134
                    TestField(Address);
                    //<<

                    if "Total Amount" = 0 then
                        Error(MSG001, FieldCaption("Total Amount"));

                    if _Customer.Get("Customer No.") then begin

                        if (_Customer.Address <> Address) or
                           (_Customer."Address 2" <> "Address 2") or
                           (_Customer."Post Code" <> "Post Code") or
                           (_Customer."Phone No." <> "Phone No.") or
                           (_Customer."Mobile No." <> "Mobile No.") then begin

                            _Customer.Address := Address;
                            _Customer."Address 2" := "Address 2";
                            _Customer."Post Code" := "Post Code";
                            _Customer."Phone No." := "Phone No.";
                            _Customer."Mobile No." := "Mobile No.";
                            _Customer.Status := _Customer.Status::Open;
                            _Customer."Last Date Modified" := CurrentDateTime;
                            _Customer."Last Modified Person" := UserId;
                            _Customer.Modify;

                            _ChangedCustomerHistory.CheckChange(_Customer);
                        end;
                    end;
                    "Check Cust. User ID" := UserId;
                    "Check Cust. DateTime" := CurrentDateTime;

                    if _FunSetup."Use Virtual Account" then begin
                        Validate("Pay. Expect Doc. No.", _PaymentExpect.CreateFromPublichAdminExpense(Rec));

                        if "Pay. Expect Doc. No." = '' then
                            Validate("Account Type", "Account Type"::General); //Ÿ‰¦ Ð‘’‰°˜ú ‘÷‘ñ

                    end else begin
                        Validate("Account Type", "Account Type"::General); //Ÿ‰¦ Ð‘’‰°˜ú ‘÷‘ñ
                    end;
                end else begin
                    "Check Cust. User ID" := '';
                    Clear("Check Cust. DateTime");

                    "Print Select" := false;

                    if _FunSetup."Use Virtual Account" then begin
                        if _PayExpectDocHdr.Get("Pay. Expect Doc. No.") then begin
                            if not _PaymentExpect.UnAssginVirtualAccnt(_PayExpectDocHdr) then
                                exit;

                            "Pay. Expect Doc. No." := '';
                            Message(MSG007);
                        end;

                    end;
                    Validate("Account Type", "Account Type"::General); //Ÿ‰¦ Ð‘’‰°˜ú ‘÷‘ñ
                end;
            end;
        }
        field(29; "Check Cust. User ID"; Code[50])
        {
            Caption = 'Check Customer User ID';
            DataClassification = ToBeClassified;
            DateFormula = false;
        }
        field(30; "Check Cust. DateTime"; DateTime)
        {
            Caption = 'Check Customer Date/Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; System; Boolean)
        {
            Caption = 'System';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Landscape Architecture"; Boolean)
        {
            CalcFormula = Lookup(DK_Cemetery."Landscape Architecture" WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Landscape Architecture';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Document Date"; Date)
        {
            CalcFormula = Lookup("DK_Publish Admin. Expense Doc."."Document Date" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Document Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Estate Code"; Code[20])
        {
            Caption = 'Estate Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Estate;
        }
        field(35; "Estate Name"; Text[50])
        {
            Caption = 'Estate Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Unit Price Type Code"; Code[20])
        {
            Caption = 'Unit Price Type Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Unit Price Type";
        }
        field(37; "Unit Price Type Name"; Text[50])
        {
            Caption = 'Unit Price Type Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'General Account,Virtual Account';
            OptionMembers = General,VA;

            trigger OnValidate()
            var
                _ReceiptBankAcct: Record "DK_Receipt Bank Account";
            begin
                if xRec."Account Type" <> "Account Type" then begin

                    "Account Code" := '';
                    "Bank Code" := '';
                    "Bank Name" := '';
                    "Bank Account No." := '';
                    "Account Holder" := '';

                    if "Account Type" = "Account Type"::General then begin
                        _ReceiptBankAcct.Reset;
                        _ReceiptBankAcct.SetRange("Admin. Expense", true);
                        _ReceiptBankAcct.SetRange(Blocked, false);
                        if _ReceiptBankAcct.FindSet then begin
                            "Account Code" := _ReceiptBankAcct.Code;
                            "Bank Code" := _ReceiptBankAcct."Bank Code";
                            "Bank Name" := _ReceiptBankAcct."Bank Name";
                            "Bank Account No." := _ReceiptBankAcct."Bank Account No.";
                            "Account Holder" := _ReceiptBankAcct."Account Holder";
                        end;
                    end;
                end;
            end;
        }
        field(39; "Account Code"; Code[30])
        {
            Caption = 'Account Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(General)) "DK_Receipt Bank Account".Code WHERE("Admin. Expense" = CONST(true),
                                                                                                     Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(VA)) "DK_Virtual Account"."Virtual Account No." WHERE(Blocked = CONST(false),
                                                                                                                                                                                          "Pay. Expect Doc. No." = CONST(''));

            trigger OnValidate()
            var
                _ReceiptBankAccount: Record "DK_Receipt Bank Account";
            begin
                if xRec."Account Code" <> "Account Code" then begin
                    if "Account Code" <> '' then begin
                        _ReceiptBankAccount.Reset;
                        _ReceiptBankAccount.SetRange(Code, "Account Code");
                        if _ReceiptBankAccount.FindSet then begin
                            "Bank Code" := _ReceiptBankAccount."Bank Code";
                            "Bank Name" := _ReceiptBankAccount."Bank Name";
                            "Bank Account No." := _ReceiptBankAccount."Bank Account No.";
                            "Account Holder" := _ReceiptBankAccount."Account Holder";
                        end else begin
                            "Bank Code" := '';
                            "Bank Name" := '';
                            "Bank Account No." := '';
                            "Account Holder" := '';
                        end;
                    end else begin
                        "Bank Code" := '';
                        "Bank Name" := '';
                        "Bank Account No." := '';
                        "Account Holder" := '';
                    end;
                end;
            end;
        }
        field(40; "Bank Code"; Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Bank;
        }
        field(41; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Bank;
            ValidateTableRelation = false;
        }
        field(42; "Bank Account No."; Code[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(43; "Account Holder"; Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44; "Print Select"; Boolean)
        {
            Caption = '“Ë‡’ Œ€•“';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (xRec."Print Select" <> "Print Select") and ("Print Select") then begin
                    if not "Check Customer Infor." then
                        Error(MSG005, FieldCaption("Check Customer Infor."));

                end;
            end;
        }
        field(45; "Pay. Expect Doc. No."; Code[20])
        {
            Caption = 'Pay. Expect Doc. No.';
            Editable = false;
            TableRelation = "DK_Pay. Expect Doc. Header";
        }
        field(46; "Contact Target"; Option)
        {
            Caption = 'Contact Target';
            DataClassification = ToBeClassified;
            OptionCaption = 'Main Customer,Main Associate,Sub Associate';
            OptionMembers = MainCustomer,MainAssociate,SubAssociate;
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
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Contract No.")
        {
        }
        key(Key3; "Supervise No.")
        {
        }
        key(Key4; "Cemetery Code")
        {
        }
        key(Key5; "Customer No.")
        {
        }
        key(Key6; "Customer Name")
        {
        }
        key(Key7; Address)
        {
        }
        key(Key8; "Address 2")
        {
        }
        key(Key9; "Phone No.")
        {
        }
        key(Key10; "Mobile No.")
        {
        }
        key(Key11; "Document No.", "Check Customer Infor.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _AdminExpenseBuffer: Record "DK_Admin. Expense Data";
    begin
        CheckHeaderStatusReleased;

        _AdminExpenseBuffer.Reset;
        _AdminExpenseBuffer.SetRange("Source No.", "Document No.");
        _AdminExpenseBuffer.SetRange("Source Line No.", "Line No.");
        if _AdminExpenseBuffer.FindSet then
            _AdminExpenseBuffer.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        //CheckHeaderStatusReleased;

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

    var
        MSG001: Label 'It can not be edited.';
        AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
        Contract: Record DK_Contract;
        AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
        MSG002: Label 'The %1 can not be earlier than the working Date. Working Date: %2';
        MSG003: Label 'The %2 can not be earlier than the %1.';
        MSG004: Label '%1 and %2 must be specified.';
        MSG005: Label 'cannot select.';
        MSG006: Label 'Documents with a Status of Released cannot be modified.';
        MSG007: Label 'Unassign Virtual Account.';

    local procedure CalcTotalAmount()
    begin

        "Total Amount" := "General Amount" + "Landscape Arc. Amount" +
                          "Non-Pay. General Amount" + "Non-Pay. Land. Arc. Amount";
    end;


    procedure CheckHeaderStatusReleased()
    var
        _PublishAdminExpDoc: Record "DK_Publish Admin. Expense Doc.";
    begin

        _PublishAdminExpDoc.Reset;
        _PublishAdminExpDoc.SetRange("Document No.", "Document No.");
        _PublishAdminExpDoc.SetRange(Status, _PublishAdminExpDoc.Status::Released);
        if _PublishAdminExpDoc.FindSet then
            Error(MSG006);
    end;

    local procedure AmountRoundUp(pAmount: Decimal): Decimal
    begin
        if pAmount <> 0 then
            exit(Round(pAmount, 100, '>'));
    end;
}

