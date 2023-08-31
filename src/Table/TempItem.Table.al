table 60013 Temp_Item
{
    DataPerCompany = false;

    fields
    {
        field(1;idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;g_big;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(3;g_mid;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(4;g_name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;g_qrcode;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(6;g_alamck;Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(7;g_alam;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;g_member;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;g_bigo;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;g_insertDate;DateTime)
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

