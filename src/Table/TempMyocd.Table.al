table 60012 Temp_Myocd
{
    DataPerCompany = false;

    fields
    {
        field(1;idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;dan_cd;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;m_id;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;m_cad;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5;m_state;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6;m_type;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7;m_opt1;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8;m_opt2;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9;m_stone;Text[5])
        {
            DataClassification = ToBeClassified;
        }
        field(10;m_yard;Decimal)
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

