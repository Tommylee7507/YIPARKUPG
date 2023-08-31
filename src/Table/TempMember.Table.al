table 60000 Temp_Member
{

    fields
    {
        field(1;IDX;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;m_id;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;m_name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;m_reg;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;m_post;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;m_addr1;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;m_address1;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8;m_phone1;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;m_tel1;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;m_email1;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11;m_ck;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;altdate;DateTime)
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

