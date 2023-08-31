table 60014 Temp_ItemInbound
{

    fields
    {
        field(1;g_num;Text[20])
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
        field(5;g_name;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;gl_position;Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(7;g_qty;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;g_code;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;Idx;Integer)
        {
            AutoIncrement = true;
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

