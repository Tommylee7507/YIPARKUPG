table 60009 Temp_Vendor
{
    DataPerCompany = false;

    fields
    {
        field(1;a_idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;a_name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;a_num;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;a_tel;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;a_hp;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;a_fax;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;a_post;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8;a_add1;Text[75])
        {
            DataClassification = ToBeClassified;
        }
        field(9;a_add2;Text[75])
        {
            DataClassification = ToBeClassified;
        }
        field(10;a_email;Text[75])
        {
            DataClassification = ToBeClassified;
        }
        field(11;a_charge;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12;a_bank;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13;a_account;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14;a_aname;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15;a_bigo;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16;a_date;DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;a_idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

