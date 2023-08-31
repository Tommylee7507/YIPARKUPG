table 50114 "DK_Receipted PG Document"
{
    Caption = 'Receipted PG Document';
    DrillDownPageID = "DK_Receipted PG Document";
    LookupPageID = "DK_Receipted PG Document";

    fields
    {
        field(1;"Entry No.";BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Payment Type";Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Direct PG,PG';
            OptionMembers = DirectPG,PG;
        }
        field(3;"Payment Date";Date)
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
        }
        field(4;"Payment Time";Time)
        {
            Caption = 'Payment Time';
            DataClassification = ToBeClassified;
        }
        field(5;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(6;"Card Comp. Code";Code[10])
        {
            Caption = 'Card Comp. Code';
            DataClassification = ToBeClassified;
        }
        field(7;"Card Comp. Name";Text[50])
        {
            Caption = 'Card Comp. Name';
            DataClassification = ToBeClassified;
        }
        field(8;"Approval No.";Text[30])
        {
            Caption = 'Approval No.';
            DataClassification = ToBeClassified;
        }
        field(9;"Pay. Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pay. Amount';
            DataClassification = ToBeClassified;
        }
        field(10;"General Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'General Amount';
            DataClassification = ToBeClassified;
        }
        field(13;"Land. Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Land. Amount';
            DataClassification = ToBeClassified;
        }
        field(16;"Pay. Expect Doc No.";Code[20])
        {
            Caption = 'Pay. Expect Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Pay. Expect Doc. Header"."Document No.";
        }
        field(17;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract."No.";
        }
        field(18;"Cemetery No.";Text[30])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery."Cemetery No.";
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
        key(Key2;"Payment Type")
        {
        }
        key(Key3;"Payment Date")
        {
        }
        key(Key4;"Payment Time")
        {
        }
        key(Key5;"Card Comp. Code")
        {
        }
        key(Key6;"Card Comp. Name")
        {
        }
        key(Key7;"Approval No.")
        {
        }
        key(Key8;"Pay. Expect Doc No.")
        {
        }
        key(Key9;"Contract No.")
        {
        }
        key(Key10;"Cemetery No.")
        {
        }
        key(Key11;"Payment Date","Pay. Expect Doc No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Entry No.","Payment Type","Payment Date","Document No.","Card Comp. Name","Approval No.","Pay. Amount")
        {
        }
    }
}

