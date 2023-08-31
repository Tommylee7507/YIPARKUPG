table 60020 Temp_MemberShipCard
{

    fields
    {
        field(1;idx;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Card_No;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Create_Dt;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4;Create_Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Create_gb;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Create_ID;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;m_id;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8;m_name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;t_id;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;t_Name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;t_bdate;Text[30])
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

