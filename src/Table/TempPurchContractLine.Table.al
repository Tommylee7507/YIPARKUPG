table 60011 Temp_PurchContractLine
{
    DataPerCompany = false;

    fields
    {
        field(1;ci_idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;ci_number;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;ci_sdate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4;ci_edate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5;ci_money;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;ci_text;Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(7;ci_bigo;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8;ci_charge;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;ci_insert;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;ci_insertDate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11;ci_state;Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;ci_idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

