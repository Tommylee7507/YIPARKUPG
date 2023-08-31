table 50115 "DK_Pay. Expect Process History"
{
    Caption = 'Payment Expect Process History';

    fields
    {
        field(1;"Entry No.";BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Entry Date";Date)
        {
            Caption = 'Entry Date';
            DataClassification = ToBeClassified;
        }
        field(3;"Entry Time";Time)
        {
            Caption = 'Entry Time';
            DataClassification = ToBeClassified;
        }
        field(4;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;
        }
        field(5;"Cemetery Code";Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
        }
        field(6;"Cemetery No.";Code[20])
        {
            Caption = 'Cemetery No';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                _Cemetery: Record DK_Cemetery;
                _CemeteryCard: Page "DK_Cemetery Card";
            begin

                _Cemetery.Reset;
                _Cemetery.SetRange("Cemetery No.", "Cemetery No.");
                if _Cemetery.FindSet then begin
                    Clear(_CemeteryCard);
                    _CemeteryCard.LookupMode(true);
                    _CemeteryCard.SetTableView(_Cemetery);
                    _CemeteryCard.SetRecord(_Cemetery);
                    _CemeteryCard.Editable(false);
                    _CemeteryCard.RunModal;
                end;
            end;
        }
        field(7;"Pay. Expect Doc. No.";Code[20])
        {
            Caption = 'Payment Expect Document No.';
            DataClassification = ToBeClassified;
        }
        field(8;"Pay. Receipt Doc. No.";Code[20])
        {
            Caption = 'Payment Receipt Document No.';
            DataClassification = ToBeClassified;
        }
        field(9;Status;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Assgin,Send SMS,Change Expiration Date,UnAssgin,Customer Payment,Create Payment Receipt Document,Posted Payment Receipt Document,Error Posting Payment Receipt Document';
            OptionMembers = "None",Assgin,SendSMS,ChangeExpirationDate,UnAssgin,CustomerPayment,CreatePayReceiptDoc,PostedPayReceiptDoc,ErrorPostingPayReceiptDoc;
        }
        field(5001;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
        key(Key2;"Entry Date")
        {
        }
        key(Key3;"Entry Time")
        {
        }
        key(Key4;"Contract No.")
        {
        }
        key(Key5;"Cemetery Code")
        {
        }
        key(Key6;"Cemetery No.")
        {
        }
        key(Key7;"Pay. Expect Doc. No.")
        {
        }
        key(Key8;"Pay. Receipt Doc. No.")
        {
        }
        key(Key9;Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Creation Person" := UserId;
    end;
}

