table 60019 Temp_Today
{
    DataPerCompany = false;

    fields
    {
        field(1;Idx;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;t_gb;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3;t_id;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;t_btype;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;t_btype2;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;t_name;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7;t_name2;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8;m_name;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9;t_phone;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10;t_tel;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11;t_addr;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12;m_lentyard;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13;t_date;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(14;t_time;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(15;t_btime;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(16;memo;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17;t_team;Text[5])
        {
            DataClassification = ToBeClassified;
        }
        field(18;comnum;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(19;modifier;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(20;altdate;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21;subm_hwa;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(22;subm_gae;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(23;subm_yu;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(24;subm_je;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(25;subm_go;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(26;subm_ga;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(27;subm_kye;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(28;subm_sa;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(29;subm_gum;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(30;insertDate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

