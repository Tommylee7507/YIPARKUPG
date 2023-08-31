table 50099 "DK_Event Product Sales Status"
{
    Caption = 'Event Product Sales Status';
    DrillDownPageID = "DK_Event Product Sales Status";
    LookupPageID = "DK_Event Product Sales Status";

    fields
    {
        field(1; "Sequence No."; Code[30])
        {
            Caption = 'Sequence No.';
            DataClassification = ToBeClassified;
        }
        field(2; Division; Option)
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;
            OptionCaption = 'individual,Corporation';
            OptionMembers = individual,Corporation;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name(Group Name)';
            DataClassification = ToBeClassified;
        }
        field(4; "Date of Birth"; Text[30])
        {
            Caption = 'Date of Birth(Business No.)';
            DataClassification = ToBeClassified;
        }
        field(5; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = ToBeClassified;
        }
        field(6; Grecway; Text[10])
        {
            Caption = 'Grecway';
            DataClassification = ToBeClassified;
        }
        field(7; Contact; Text[50])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
        field(8; Email; Text[50])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(9; "Post Code"; Text[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(10; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(11; Address2; Text[50])
        {
            Caption = 'Address2';
            DataClassification = ToBeClassified;
        }
        field(12; "Banking Comany"; Text[10])
        {
            Caption = 'Banking Comany';
            DataClassification = ToBeClassified;
        }
        field(13; "Account Holder"; Text[10])
        {
            Caption = 'Account Holder';
            DataClassification = ToBeClassified;
        }
        field(14; "Bank Acount"; Text[30])
        {
            Caption = 'Bank Acount';
            DataClassification = ToBeClassified;
        }
        field(15; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit card,Bank Transfer';
            OptionMembers = Blank,"Credit card","Bank Transfer";
        }
        field(16; "Payment Type"; Text[10])
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
        }
        field(17; "Card Company"; Text[10])
        {
            Caption = 'Card Company';
            DataClassification = ToBeClassified;
        }
        field(18; "Card No."; Text[30])
        {
            Caption = 'Card No.';
            DataClassification = ToBeClassified;
        }
        field(19; Gcardterm; Text[15])
        {
            Caption = 'Gcardterm';
            DataClassification = ToBeClassified;
        }
        field(20; Gconfdt; Text[10])
        {
            Caption = 'Gconfdt';
            DataClassification = ToBeClassified;
        }
        field(21; Gconfno; Text[20])
        {
            Caption = 'Gconfno';
            DataClassification = ToBeClassified;
        }
        field(22; "Sales Category"; Option)
        {
            Caption = 'Sales Category';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Visit,electronic commerce';
            OptionMembers = Blank,Visit,"electronic commerce";
        }
        field(23; Gcardju; Text[20])
        {
            Caption = 'Gcardju';
            DataClassification = ToBeClassified;
        }
        field(24; Gconfyn; Text[10])
        {
            Caption = 'Gconfyn';
            DataClassification = ToBeClassified;
        }
        field(25; Gdept; Text[30])
        {
            Caption = 'Gdept';
            DataClassification = ToBeClassified;
        }
        field(26; Gdamd; Text[10])
        {
            Caption = 'Gdamd';
            DataClassification = ToBeClassified;
        }
        field(27; Gdphone; Text[20])
        {
            Caption = 'Gdphone';
            DataClassification = ToBeClassified;
        }
        field(28; Ginway; Text[10])
        {
            Caption = 'Ginway';
            DataClassification = ToBeClassified;
        }
        field(29; Gbackway; Text[50])
        {
            Caption = 'Gbackway';
            DataClassification = ToBeClassified;
        }
        field(30; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            DataClassification = ToBeClassified;
        }
        field(31; Optioncd; Text[20])
        {
            Caption = 'Optioncd';
            DataClassification = ToBeClassified;
        }
        field(32; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(33; "Paymnet Amount"; Decimal)
        {
            Caption = 'Paymnet Amount';
            DataClassification = ToBeClassified;
        }
        field(34; Gmeno; Text[250])
        {
            Caption = 'Gmeno';
            DataClassification = ToBeClassified;
        }
        field(35; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Y,N,C';
            OptionMembers = Y,N,C;
        }
        field(36; "Serial No."; Code[10])
        {
            Caption = 'Serial No.';
            DataClassification = ToBeClassified;
        }
        field(37; Gchangedt; Text[10])
        {
            Caption = 'Gchangedt';
            DataClassification = ToBeClassified;
        }
        field(38; Gmodelno; Text[30])
        {
            Caption = 'Gmodelno';
            DataClassification = ToBeClassified;
        }
        field(39; Gbranch; Text[30])
        {
            Caption = 'Gbranch';
            DataClassification = ToBeClassified;
        }
        field(40; "Gbranch Sawon"; Text[20])
        {
            Caption = 'Gbranch Sawon';
            DataClassification = ToBeClassified;
        }
        field(41; "Gbranch Phone"; Text[20])
        {
            Caption = 'Gbranch Phone';
            DataClassification = ToBeClassified;
        }
        field(42; Gtid; Text[20])
        {
            Caption = 'Gtid';
            DataClassification = ToBeClassified;
        }
        field(43; Gtdate; Date)
        {
            Caption = 'Gtdate';
            DataClassification = ToBeClassified;
        }
        field(44; Comnum; Text[30])
        {
            Caption = 'Comnum';
            DataClassification = ToBeClassified;
        }
        field(45; Altdate; Date)
        {
            Caption = 'Altdate';
            DataClassification = ToBeClassified;
        }
        field(46; Writer; Text[10])
        {
            Caption = 'Writer';
            DataClassification = ToBeClassified;
        }
        field(47; Modidate; Date)
        {
            Caption = 'Modidate';
            DataClassification = ToBeClassified;
        }
        field(48; Modifier; Text[10])
        {
            Caption = 'Modifier';
            DataClassification = ToBeClassified;
        }
        field(49; "Remote Addr"; Text[30])
        {
            Caption = 'Remote Addr';
            DataClassification = ToBeClassified;
        }
        field(50; Uid; Text[20])
        {
            Caption = 'Uid';
            DataClassification = ToBeClassified;
        }
        field(51; Gkyulyn; Text[10])
        {
            Caption = 'Gkyulyn';
            DataClassification = ToBeClassified;
        }
        field(52; Gcallyn; Text[10])
        {
            Caption = 'Gcallyn';
            DataClassification = ToBeClassified;
        }
        field(53; Gcalldt; Text[10])
        {
            Caption = 'Gcalldt';
            DataClassification = ToBeClassified;
        }
        field(54; Gcallmemo; Text[250])
        {
            Caption = 'Gcallmemo';
            DataClassification = ToBeClassified;
        }
        field(55; Gcallynre; Text[10])
        {
            Caption = 'Gcallynre';
            DataClassification = ToBeClassified;
        }
        field(56; Gcalldtre; Text[10])
        {
            Caption = 'Gcalldtre';
            DataClassification = ToBeClassified;
        }
        field(57; Gcallmemore; Text[50])
        {
            Caption = 'Gcallmemore';
            DataClassification = ToBeClassified;
        }
        field(58; Gbackdt; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sequence No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

