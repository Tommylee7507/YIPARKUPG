table 50028 "DK_Cemetery Unit Price"
{
    Caption = 'Cemetery Unit Price';
    DataCaptionFields = "Estate Name","Cemetery Conf. Name","Cemetery Option Name","Starting Date";
    DrillDownPageID = "DK_Cemetery Unit Price";
    LookupPageID = "DK_Cemetery Unit Price";

    fields
    {
        field(1;"Estate Code";Code[20])
        {
            Caption = 'Estate Code';
            DataClassification = ToBeClassified;
            TableRelation = DK_Estate;

            trigger OnValidate()
            begin
                if Estate.Get("Estate Code") then
                  "Estate Name" := Estate.Name
                else
                  "Estate Name" := '';
            end;
        }
        field(2;"Estate Name";Text[50])
        {
            Caption = 'Estate Name';
            TableRelation = DK_Estate;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Estate Code",Estate.GetEstateCode("Estate Name"));
            end;
        }
        field(3;"Cemetery Conf. Code";Code[20])
        {
            Caption = 'Cemetery Conformation Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Cemetery Conformation";

            trigger OnValidate()
            begin
                if CemeteryConf.Get("Cemetery Conf. Code") then
                  "Cemetery Conf. Name" := CemeteryConf.Name
                else
                  "Cemetery Conf. Name" := '';
            end;
        }
        field(4;"Cemetery Conf. Name";Text[50])
        {
            Caption = 'Cemetery Conformation Name';
            TableRelation = "DK_Cemetery Conformation";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Cemetery Conf. Code",CemeteryConf.GetCemeteryConfCode("Cemetery Conf. Name"));
            end;
        }
        field(5;"Cemetery Option Code";Code[20])
        {
            Caption = 'Cemetery Option Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Cemetery Option";

            trigger OnValidate()
            begin
                if CemeteryOpti.Get("Cemetery Option Code") then
                  "Cemetery Option Name" := CemeteryOpti.Name
                else
                  "Cemetery Option Name" := '';
            end;
        }
        field(6;"Cemetery Option Name";Text[50])
        {
            Caption = 'Cemetery Option Name';
            TableRelation = "DK_Cemetery Option";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Cemetery Option Code",CemeteryOpti.GetCemeteryOptionCode("Cemetery Option Name"));
            end;
        }
        field(7;"Starting Date";Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(8;"Unit Price";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(9;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Estate Code","Cemetery Conf. Code","Cemetery Option Code","Starting Date")
        {
            Clustered = true;
        }
        key(Key2;"Starting Date")
        {
        }
        key(Key3;"Estate Name","Cemetery Conf. Name","Cemetery Option Name","Starting Date")
        {
        }
        key(Key4;"Estate Name")
        {
        }
        key(Key5;"Cemetery Conf. Name")
        {
        }
        key(Key6;"Cemetery Option Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin


        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        Estate: Record DK_Estate;
        CemeteryConf: Record "DK_Cemetery Conformation";
        CemeteryOpti: Record "DK_Cemetery Option";
}

