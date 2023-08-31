table 50086 "DK_Detail Admin. Exp. Ledger"
{
    Caption = 'Detail Admin. Expense Ledger';
    DataCaptionFields = "Contract No.",Date,"Line No.",Sequence;
    DrillDownPageID = "DK_Detail Admin. Exp. Ledger";
    LookupPageID = "DK_Detail Admin. Exp. Ledger";

    fields
    {
        field(1;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(2;Date;Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;Sequence;Integer)
        {
            Caption = 'Sequence';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Admin. Expense Type";Option)
        {
            Caption = 'Admin. Expense  Type';
            OptionCaption = 'General,Landscape Architecture';
            OptionMembers = General,Landscape;
        }
        field(6;"Ledger Type";Option)
        {
            Caption = 'Ledger Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Cash Receipt,Daily,Refund';
            OptionMembers = Receipt,Daily,Refund;
        }
        field(7;"Original Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Amount';
            DataClassification = ToBeClassified;
        }
        field(8;Amount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(9;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Payment Receipt Document"."Document No.";
        }
        field(10;"Source Line No.";Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(11;"Apply Date";Date)
        {
            Caption = 'Apply Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Apply Line No.";Integer)
        {
            Caption = 'Apply Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;Applied;Boolean)
        {
            Caption = 'Applied';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Contract No.",Date,"Line No.",Sequence)
        {
            Clustered = true;
        }
        key(Key2;"Contract No.","Admin. Expense Type","Ledger Type",Date,"Line No.",Sequence)
        {
        }
        key(Key3;"Contract No.",Date,"Admin. Expense Type","Ledger Type","Source No.","Source Line No.","Apply Date")
        {
        }
        key(Key4;"Contract No.",Date,"Admin. Expense Type","Ledger Type","Source No.","Source Line No.")
        {
        }
        key(Key5;"Contract No.","Admin. Expense Type","Ledger Type","Source No.","Source Line No.")
        {
        }
        key(Key6;"Contract No.","Apply Date","Apply Line No.")
        {
            SumIndexFields = Amount;
        }
        key(Key7;"Contract No.","Source No.")
        {
        }
        key(Key8;"Source No.")
        {
        }
        key(Key9;"Apply Date")
        {
        }
        key(Key10;Date)
        {
        }
        key(Key11;"Admin. Expense Type")
        {
        }
        key(Key12;"Ledger Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Creation Date" := CurrentDateTime;
    end;
}

