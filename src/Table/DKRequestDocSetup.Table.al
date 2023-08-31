table 50051 "DK_Request Doc. Setup"
{
    Caption = 'Request Document Setup';
    DataCaptionFields = "Document Name";
    DrillDownPageID = "DK_Request Doc. Setup";
    LookupPageID = "DK_Request Doc. Setup";

    fields
    {
        field(1;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(2;"Document Name";Text[50])
        {
            Caption = 'Document Name';
            DataClassification = ToBeClassified;
        }
        field(3;Type;Option)
        {
            Caption = '»—ý';
            DataClassification = ToBeClassified;
            OptionCaption = 'Cancellation,Today';
            OptionMembers = Cancellation,Today;
        }
        field(4;Mandatory;Boolean)
        {
            Caption = '—šŒ÷ Œ¡‡õ';
            DataClassification = ToBeClassified;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Document Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Document Name");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Document Name");

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;
}

