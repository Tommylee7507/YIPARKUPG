table 50140 "DK_HomePage Payment Entry"
{
    Caption = 'HomePage Payment Entry';

    fields
    {
        field(1;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(3;Status;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Canceled,Completed';
            OptionMembers = Open,Canceled,Completed;
        }
        field(4;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;
        }
        field(5;"Cemetery Code";Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Cemetery;
        }
        field(6;"Cemetery No.";Text[20])
        {
            Caption = 'Cemetery No.';
            DataClassification = ToBeClassified;
        }
        field(7;"General Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'General Amount';
            DataClassification = ToBeClassified;
        }
        field(8;"Landscape Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Landscape Amount';
            DataClassification = ToBeClassified;
        }
        field(9;"Payment Method Code";Code[20])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Payment Method";
        }
        field(10;"Payment Method Name";Text[50])
        {
            Caption = 'Payment Method Name';
            FieldClass = Normal;
        }
        field(11;"Card Approval No.";Text[20])
        {
            Caption = 'Card Approval No.';
            DataClassification = ToBeClassified;
        }
        field(12;"Payment Date";Date)
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
        }
        field(13;"Payment Type";Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,OnlineCard';
            OptionMembers = Bank,OnlineCard;
        }
        field(14;"Receipt Bank Account";Code[20])
        {
            Caption = 'Receipt Bank Account';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Receipt Bank Account";
        }
        field(15;"Receipt Bank Account Desc.";Text[50])
        {
            Caption = 'Receipt Bank Account Desc.';
            DataClassification = ToBeClassified;
        }
        field(100;"Receipt No.";Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
        }
        field(101;"Old Receipt No.";Code[20])
        {
            Caption = 'Old Receipt No.';
            DataClassification = ToBeClassified;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

