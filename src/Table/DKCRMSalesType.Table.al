table 50108 "DK_CRM Sales Type"
{
    Caption = 'CRM Sales Type';
    DrillDownPageID = "DK_CRM Sales Type";
    LookupPageID = "DK_CRM Sales Type";

    fields
    {
        field(1;Seq;Integer)
        {
            Caption = 'Seq';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3;Item;Option)
        {
            Caption = 'Item';
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Sales,Job,Purchase,Project,PDS,IT,Director Support,Budget,CS,Design,Licensing,Cemetery,Landscape,Architecture,Etc';
            OptionMembers = "None",Sales,Job,Purchase,Project,PDS,IT,Director,Budget,CS,Design,Licensing,Cemetery,Landscape,Architecture,Etc;
        }
        field(4;Indicator;Text[50])
        {
            Caption = 'Indicator';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Seq)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField(Seq);
        TestField(Name);
    end;

    trigger OnModify()
    begin
        TestField(Seq);
        TestField(Name);
    end;
}

