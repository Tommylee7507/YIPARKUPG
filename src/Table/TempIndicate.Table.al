table 60007 Temp_Indicate
{

    fields
    {
        field(1;Idx;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;cdate;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(3;cname;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4;ctel;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;cphone;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;cemail;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7;ctid;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;cgb;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9;ctype;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10;cpart;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11;cintendant;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12;cchair;Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13;cmemo1;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14;cmemo2;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15;cmemo3;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16;ctag;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(17;cprocess;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(18;cresult1;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19;cresult2;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20;cresult3;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21;cpdate;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(22;cpdate2;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(23;cpdate3;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(24;writer;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(25;modifier;Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(26;altdate;DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(27;creturndt;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(28;backdt;Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(29;job_time;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30;worker_cnt;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31;crm_voc_guid;Text[50])
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

