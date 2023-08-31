table 60006 Temp_unpaid_request
{

    fields
    {
        field(1;idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;r_mid;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;r_opt;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(4;r_comm;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(5;r_Customer;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(6;r_txt;Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(7;r_indate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8;r_insert;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;r_insertDate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10;r_deit;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;r_editdate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(12;r_txt2;Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(13;r_txt3;Text[1024])
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

