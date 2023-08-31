table 50023 "DK_Attched Files"
{
    Caption = 'Attched Files';

    fields
    {
        field(1;"Table ID";Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(2;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(3;"Source Line No.";Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(4;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(5;Comment;Text[250])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(6;Attached;BLOB)
        {
            Caption = 'Attached';
            DataClassification = ToBeClassified;
        }
        field(7;"Attached Name";Text[100])
        {
            Caption = 'Attached Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Attached Date";Date)
        {
            Caption = 'Attached Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Attached User ID";Text[50])
        {
            Caption = 'Attached User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Table ID","Source No.","Source Line No.","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

