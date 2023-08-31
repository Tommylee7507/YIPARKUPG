table 50029 "DK_Cemetery Class Discount"
{
    Caption = 'Cemetery Class Discount';
    DrillDownPageID = "DK_Cemetery Class Discount";
    LookupPageID = "DK_Cemetery Class Discount";

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
        field(7;Class;Option)
        {
            Caption = 'Class';
            DataClassification = ToBeClassified;
            OptionCaption = 'A,B,C,D';
            OptionMembers = A,B,C,D;
        }
        field(8;"Starting Date";Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(9;Discount;Decimal)
        {
            Caption = 'Discount(%)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:1;
            MaxValue = 100;
            MinValue = 0;
        }
        field(10;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Estate Code","Cemetery Conf. Code","Cemetery Option Code",Class)
        {
            Clustered = true;
        }
        key(Key2;"Starting Date")
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

