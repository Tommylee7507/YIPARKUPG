table 50026 "DK_Auto. Noti. Entry"
{
    Caption = 'Auto. Noti. Entry';
    DrillDownPageID = "DK_Auto. Noti. Entry";
    LookupPageID = "DK_Auto. Noti. Entry";

    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Table ID";Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(3;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(4;"Source Line No.";Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(5;Message;Text[250])
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;
        }
        field(6;Remark;Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(7;"Sending DateTime";DateTime)
        {
            Caption = 'Sending DateTime';
            DataClassification = ToBeClassified;
        }
        field(8;Seceiver;Text[50])
        {
            Caption = 'Seceiver';
            DataClassification = ToBeClassified;
        }
        field(9;"Mobile No.";Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;
        }
        field(10;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
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

