table 50110 "DK_Virtual Account"
{
    Caption = 'Virtual Account';
    DataCaptionFields = "Virtual Account No.";
    DrillDownPageID = "DK_Virtual Account";
    LookupPageID = "DK_Virtual Account";

    fields
    {
        field(1;"Virtual Account No.";Code[20])
        {
            Caption = 'Virtual Account No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                if xRec."Virtual Account No." <> "Virtual Account No." then begin
                  if xRec."Virtual Account No." <> '' then begin

                    CalcFields("Pay. Expect Doc. No.");
                    if "Pay. Expect Doc. No." <> '' then
                      Error(MSG001, FieldCaption("Pay. Expect Doc. No."),"Pay. Expect Doc. No.");
                  end;
                end;
            end;
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if xRec.Blocked <> Blocked then begin
                  if Blocked then begin
                    CalcFields("Pay. Expect Doc. No.");
                    if "Pay. Expect Doc. No." <> '' then
                      Error(MSG002, FieldCaption("Virtual Account No."),
                                FieldCaption("Pay. Expect Doc. No."),
                                "Pay. Expect Doc. No.",
                                FieldCaption(Blocked));
                  end;
                end;
            end;
        }
        field(4;"Pay. Expect Doc. No.";Code[20])
        {
            CalcFormula = Lookup("DK_Pay. Expect Doc. Header"."Document No." WHERE ("Virtual Account No."=FIELD("Virtual Account No."),
                                                                                    "UnAssgin Date"=FILTER(0D)));
            Caption = 'Payment Expect Document No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5;"Bank Code";Code[5])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Bank;

            trigger OnValidate()
            begin
                if Bank.Get("Bank Code") then
                  "Bank Name" := Bank.Name
                else
                  "Bank Name" := '';
            end;
        }
        field(6;"Bank Name";Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Bank.Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Bank Code",Bank.GetBankCode("Bank Name"));
            end;
        }
        field(7;"Account Holder";Text[30])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(8;"Assgin Expiration Date";Date)
        {
            CalcFormula = Lookup("DK_Pay. Expect Doc. Header"."Expiration Date" WHERE ("Document No."=FIELD("Pay. Expect Doc. No.")));
            Caption = 'Assgin Expiration Date';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(9;"Last UnAssgin Date";Date)
        {
            Caption = 'Last UnAssgin Date';
            DataClassification = ToBeClassified;
            Editable = false;
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
        key(Key1;"Virtual Account No.")
        {
            Clustered = true;
        }
        key(Key2;"Last UnAssgin Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Virtual Account No.","Bank Name","Account Holder")
        {
        }
    }

    trigger OnDelete()
    var
        _PayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
    begin
        CalcFields("Pay. Expect Doc. No.");

        if "Pay. Expect Doc. No." <> '' then
          Error(MSG001, FieldCaption("Pay. Expect Doc. No."),"Pay. Expect Doc. No.");
    end;

    trigger OnInsert()
    begin
        TestField("Virtual Account No.");
        TestField("Bank Name");
        TestField("Account Holder");

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("Virtual Account No.");
        TestField("Bank Name");
        TestField("Account Holder");

        CalcFields("Pay. Expect Doc. No.");
        if "Pay. Expect Doc. No." <> '' then
          Error(MSG001, FieldCaption("Pay. Expect Doc. No."),"Pay. Expect Doc. No.");

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'Currently assigned Virtual Account No. cannot be edited or deleted. %1:%2';
        Bank: Record DK_Bank;
        MSG002: Label 'This %1 is currently assigned and cannot be %4. %2:%3';
}

