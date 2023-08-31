table 60010 Temp_PurchContrct
{
    DataPerCompany = false;

    fields
    {
        field(1;c_idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;c_date;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(3;c_number;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;c_title;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;c_one;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;c_agency;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7;c_sms;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8;c_auto;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;c_file;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10;c_state;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;c_insert;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;c_insertDate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13;c_edit;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14;c_editDate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;c_idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

