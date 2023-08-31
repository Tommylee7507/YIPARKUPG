table 50071 "DK_Admin. Expense Ledger"
{
    // *DK32 : 20200715
    //   - Add Field : "Max Line No."

    Caption = 'Admin. Expense Ledger';
    DataCaptionFields = "Contract No.", Date, "Admin. Expense Type", "Ledger Type";
    DrillDownPageID = "DK_Admin. Expense Ledger";
    LookupPageID = "DK_Admin. Expense Ledger";

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Admin. Expense Type"; Option)
        {
            Caption = 'Admin. Expense  Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Landscape Architecture';
            OptionMembers = General,Landscape;
        }
        field(5; "Ledger Type"; Option)
        {
            Caption = 'Ledger Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Cash Receipt,Daily,Refund';
            OptionMembers = Receipt,Daily,Refund;
        }
        field(6; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("DK_Detail Admin. Exp. Ledger".Amount WHERE("Contract No." = FIELD("Contract No."),
                                                                           "Apply Date" = FIELD(Date),
                                                                           "Apply Line No." = FIELD("Line No.")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Cancel; Boolean)
        {
            Caption = 'Cancel';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Payment Receipt Document"."Document No.";
        }
        field(10; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(11; "First Contract"; Boolean)
        {
            Caption = 'First Contract';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Low Balance"; Boolean)
        {
            Caption = 'Low Balance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Exempt Target"; Boolean)
        {
            Caption = 'Exempt Target';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Hike Exemption"; Boolean)
        {
            Caption = 'Hike Exemption';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Man. Fee hike Exemption Date"; Date)
        {
            Caption = 'Man. Fee hike Exemption Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Man. Fee hike Exemption Date" <> "Man. Fee hike Exemption Date" then
                    "Hike Exemption" := "Man. Fee hike Exemption Date" <> 0D;
            end;
        }
        field(16; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            Editable = false;
            OptionCaption = ' ,Bank Transfer,Credit Card,Cash,Giro,Onlie Credit Card,Virtual Account,Debt Relief';
            OptionMembers = "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount,DebtRelief;
        }
        field(17; "Bank Account Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Bank Account Code" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Bank Account Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Bank Account Name"; Text[50])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Bank Account Name" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Bank Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Credit Card Comp. Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Payment Method Code" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Credit Card Company Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Credit Card Comp. Name"; Text[50])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Payment Method Name" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Credi Card Company Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Document Datetime"; DateTime)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Document Datetime" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Document Datetime';
            FieldClass = FlowField;
        }
        field(22; "Credit Card Comp. Type"; Option)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Payment Mothed Type" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Credit Card Comp. Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Online Card,Card,Giro';
            OptionMembers = Online,Card,Giro;
        }
        field(24; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(25; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = ToBeClassified;
        }
        field(26; "Aproval No."; Text[30])
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Aproval No." WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Aproval No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Posting Date"; Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Posting Date" WHERE("Document No." = FIELD("Source No.")));
            Caption = 'Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Add. Period"; Boolean)
        {
            Caption = 'Add. Period';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Cemetery No."; Text[30])
        {
            CalcFormula = Lookup(DK_Contract."Cemetery No." WHERE("No." = FIELD("Contract No.")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; Open; Boolean)
        {
            Caption = 'Open';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Detail Max Seq."; Integer)
        {
            CalcFormula = Max("DK_Detail Admin. Exp. Ledger".Sequence WHERE("Contract No." = FIELD("Contract No."),
                                                                             Date = FIELD(Date),
                                                                             "Line No." = FIELD("Line No.")));
            Caption = 'Detail Max Seq.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Max Line No."; Integer)
        {
            CalcFormula = Max("DK_Admin. Expense Ledger"."Line No." WHERE("Contract No." = FIELD("Contract No."),
                                                                           Date = FIELD(Date)));
            Caption = 'Max Line No.';
            Description = 'DK32';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Contract No.", Date, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
        key(Key3; "Admin. Expense Type")
        {
        }
        key(Key4; "Ledger Type")
        {
        }
        key(Key5; "Source No.")
        {
        }
        key(Key6; "Source Line No.")
        {
        }
        key(Key7; "Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.")
        {
        }
        key(Key8; "Contract No.", Date, "Admin. Expense Type", "Ledger Type", "Source No.", "Source Line No.", "Payment Type")
        {
        }
        key(Key9; "First Contract")
        {
        }
        key(Key10; "Payment Type")
        {
        }
        key(Key11; "Add. Period")
        {
        }
        key(Key12; Date, "Admin. Expense Type", "Ledger Type", "First Contract", "Payment Type")
        {
        }
        key(Key13; "Contract No.", Date, "Admin. Expense Type", "Ledger Type")
        {
        }
        key(Key14; "Contract No.", "Admin. Expense Type", "Ledger Type", Date)
        {
        }
        key(Key15; "Contract No.", Date, "Admin. Expense Type")
        {
        }
        key(Key16; Open)
        {
        }
        key(Key17; "Contract No.", "Source No.")
        {
        }
        key(Key18; "Contract No.", "Admin. Expense Type", "Ledger Type", Date, Open)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DeleteDetail;
    end;

    trigger OnInsert()
    begin

        "Creation Date" := CurrentDateTime;
        Open := true;

        InsertDetail;
    end;

    local procedure InsertDetail()
    var
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
        _NewSeq: Integer;
    begin
        if Amount <> 0 then begin
            CalcFields("Detail Max Seq.");
            _NewSeq := "Detail Max Seq." + 1;

            _DetailAdminExpLedger.Init;
            _DetailAdminExpLedger."Contract No." := "Contract No.";
            _DetailAdminExpLedger.Date := Date;
            _DetailAdminExpLedger."Line No." := "Line No.";
            _DetailAdminExpLedger.Sequence := _NewSeq;
            _DetailAdminExpLedger."Admin. Expense Type" := "Admin. Expense Type";
            _DetailAdminExpLedger."Ledger Type" := "Ledger Type";
            //_DetailAdminExpLedger."Original Amount" := Amount;
            _DetailAdminExpLedger.Amount := Amount;
            _DetailAdminExpLedger."Source No." := "Source No.";
            _DetailAdminExpLedger."Source Line No." := "Source Line No.";
            _DetailAdminExpLedger."Apply Date" := Date;
            _DetailAdminExpLedger."Apply Line No." := "Line No.";
            _DetailAdminExpLedger.Insert(true);
        end;
    end;

    local procedure DeleteDetail()
    var
        _DetailAdminExpLedger: Record "DK_Detail Admin. Exp. Ledger";
    begin

        case "Ledger Type" of
            "Ledger Type"::Receipt:
                begin
                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetRange("Contract No.", "Contract No.");
                    _DetailAdminExpLedger.SetRange("Source No.", "Source No.");
                    _DetailAdminExpLedger.SetRange("Source Line No.", "Source Line No.");
                    if _DetailAdminExpLedger.FindSet then
                        _DetailAdminExpLedger.DeleteAll(true);

                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetRange("Contract No.", "Contract No.");
                    _DetailAdminExpLedger.SetRange("Apply Date", Date);
                    _DetailAdminExpLedger.SetRange("Apply Line No.", "Line No.");
                    if _DetailAdminExpLedger.FindSet then
                        _DetailAdminExpLedger.DeleteAll(true);
                end;
            "Ledger Type"::Daily:
                begin

                    _DetailAdminExpLedger.Reset;
                    _DetailAdminExpLedger.SetRange("Contract No.", "Contract No.");
                    _DetailAdminExpLedger.SetRange(Date, Date);
                    _DetailAdminExpLedger.SetRange("Line No.", "Line No.");
                    if _DetailAdminExpLedger.FindSet then
                        _DetailAdminExpLedger.DeleteAll(true);

                end;
            "Ledger Type"::Refund:
                begin
                end;
        end;
    end;


    procedure GetNewLineNo(pContractNo: Code[20]; pDate: Date): Integer
    var
        _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
    begin

        _AdminExpenseLedger.Reset;
        _AdminExpenseLedger.SetCurrentKey("Contract No.", Date, "Line No.");
        _AdminExpenseLedger.SetRange("Contract No.", pContractNo);
        _AdminExpenseLedger.SetRange(Date, pDate);
        if _AdminExpenseLedger.FindLast then
            exit(_AdminExpenseLedger."Line No." + 1);


        exit(1);
    end;
}

