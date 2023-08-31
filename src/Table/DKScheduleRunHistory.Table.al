table 50120 "DK_Schedule Run History"
{
    // 
    // DK34: 20201201
    //   - Modify Field: "Run Type"

    Caption = 'Schedule Run History';

    fields
    {
        field(1;"Run Date";Date)
        {
            Caption = 'Run Date';
            DataClassification = ToBeClassified;
        }
        field(2;"Run Type";Option)
        {
            Caption = 'Run Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Admin. Expense,Sending Sales SMS,Litigation Evaluation,Purchase Contract,Vehicle Alams,Reagree Create,Reagree SMS Send';
            OptionMembers = AdminExpense,SalesSMS,LitigationEvaluation,PurchContract,VehicleAlams,ReagreeCreate,ReagreeSMS;
        }
        field(3;Message;Text[250])
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;
        }
        field(4;"Run Date/Time";DateTime)
        {
            Caption = 'Run Date/Time';
            DataClassification = ToBeClassified;
        }
        field(5;"No. of Run";Integer)
        {
            Caption = 'No. of Run';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Run Date","Run Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

