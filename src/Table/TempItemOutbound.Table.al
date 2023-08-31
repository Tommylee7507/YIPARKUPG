table 60015 Temp_ItemOutbound
{

    fields
    {
        field(1;g_num;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;g_date;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3;g_time;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4;g_goods;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5;g_qty;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;g_name;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;g_out3;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;g_out1;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9;g_out2;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10;g_bigo;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11;g_code;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12;idx;Integer)
        {
            AutoIncrement = true;
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

