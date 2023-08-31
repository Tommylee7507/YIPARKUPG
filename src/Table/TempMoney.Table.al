table 60003 Temp_Money
{

    fields
    {
        field(1;idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;a_sdate;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(3;a_edate;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(4;a_indate;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(5;a_type;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6;a_itype;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7;a_iway;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;a_cmoney;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;a_ipkmnm;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10;a_memo;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11;a_confirm;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12;m_id;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13;altdate;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14;modifier;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15;u_ck;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16;u_reduce;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17;u_low;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18;u_interest;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19;u_prepay;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20;u_move;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21;u_move_ck;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22;u_rtype;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23;u_bigo;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24;Unpaid;Decimal)
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

