table 60018 Temp_Myocd_Status
{
    DataPerCompany = false;

    fields
    {
        field(1;t_id;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;myo_type;Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;t_id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

