table 60005 Temp_Request1
{

    fields
    {
        field(1;IDX;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;m_id;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;r_date;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(4;r_gb;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5;r_tag;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;r_memo;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7;r_resultyn;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(8;r_respon;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9;r_ressueyn;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(10;writer;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11;sysdate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(12;modifier;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13;altdate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;IDX)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

