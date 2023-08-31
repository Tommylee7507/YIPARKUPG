table 50027 "DK_External DB Con. Infor."
{
    Caption = 'External DB Connection Information';
    DataCaptionFields = "Code",Description;
    DrillDownPageID = "DK_External DB Con. Infor.";
    LookupPageID = "DK_External DB Con. Infor.";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3;"Server Name";Text[30])
        {
            Caption = 'Server Name';
            DataClassification = ToBeClassified;
        }
        field(4;"DB Name";Text[50])
        {
            Caption = 'DB Name';
            DataClassification = ToBeClassified;
        }
        field(5;"DB User ID";Text[50])
        {
            Caption = 'DB User ID';
            DataClassification = ToBeClassified;
        }
        field(6;"DB User PW";Text[50])
        {
            Caption = 'DB User PW';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(7;"DB Test Conn. Date";Date)
        {
            Caption = 'DB Test Connection Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Connection Type";Option)
        {
            Caption = 'Connection Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,E-TAX';
            OptionMembers = "None","E-TAX";
        }
        field(9;"DB Type";Option)
        {
            Caption = 'DB Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'MS-SQL,Oracle,DB2';
            OptionMembers = "MS-SQL",Oracle,DB2;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _FunctionSetup: Record "DK_Function Setup";
    begin

        _FunctionSetup.Get;

        case Code of
          _FunctionSetup."SMS DB Con. Code": begin
            if Code <> '' then
              Error(MSG001, _FunctionSetup.TableCaption, _FunctionSetup.FieldCaption("SMS DB Con. Code"));
          end;
          _FunctionSetup."Virtual Accnt. DB Con. Code": begin
            if Code <> '' then
              Error(MSG001, _FunctionSetup.TableCaption, _FunctionSetup.FieldCaption("Virtual Accnt. DB Con. Code"));
          end;
        end;
    end;

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    trigger OnModify()
    begin
        TestField(Code);
    end;

    var
        MSG001: Label 'Currently in use on %2 at %1. You can not delete it.';
}

