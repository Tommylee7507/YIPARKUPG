table 50007 "DK_Admin. Expense Price"
{
    Caption = 'Administrative Expense Price';
    DataCaptionFields = "Price Type","Starting Date","Unit Price Type Name";
    DrillDownPageID = "DK_Admin. Expense Setup";
    LookupPageID = "DK_Admin. Expense Setup";

    fields
    {
        field(1;"Price Type";Option)
        {
            Caption = 'Price Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Landscape Architecture';
            OptionMembers = General,Landscape;
        }
        field(2;"Starting Date";Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(3;"Unit Price Type Code";Code[20])
        {
            Caption = 'Unit Price Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Unit Price Type";

            trigger OnValidate()
            begin
                if UnitPriceType.Get("Unit Price Type Code") then
                  "Unit Price Type Name" := UnitPriceType.Name
                else
                  "Unit Price Type Name" := '';
            end;
        }
        field(4;"Unit Price Type Name";Text[50])
        {
            Caption = 'Unit Price Type Name';
            TableRelation = "DK_Unit Price Type";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Unit Price Type Code",UnitPriceType.GetUnitPriceTypeCode("Unit Price Type Name"));
            end;
        }
        field(5;"Unit Price";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(6;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Price Type","Starting Date","Unit Price Type Code")
        {
            Clustered = true;
        }
        key(Key2;"Price Type","Unit Price Type Code","Starting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Starting Date" <= Today then
          Error(MSG003,Today);
    end;

    trigger OnInsert()
    begin

        if "Starting Date" <= Today then
          Error(MSG001,Today);

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        if "Starting Date" <= Today then
          Error(MSG002,Today);

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin

        if "Starting Date" <= Today then
          Error(MSG004,Today);
    end;

    var
        UnitPriceType: Record "DK_Unit Price Type";
        MSG001: Label 'Can not be Insert.';
        MSG002: Label 'Can not be Modify.';
        MSG003: Label 'Can not be Delete.';
        MSG004: Label 'Can not be Rename.';
}

