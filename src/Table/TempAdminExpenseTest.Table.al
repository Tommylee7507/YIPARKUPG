table 60016 Temp_AdminExpenseTest
{

    fields
    {
        field(1;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

