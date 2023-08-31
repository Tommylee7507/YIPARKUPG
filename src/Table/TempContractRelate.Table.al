table 60004 Temp_Contract_Relate
{

    fields
    {
        field(1;idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;mr_relate;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;mr_name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;mr_post;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;mr_addr;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;mr_address;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;mr_phone;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8;mr_tel;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;mr_email;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10;mr_useyn;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;mr_lastaccess;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;mr_id;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13;altdate;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14;modifier;Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

