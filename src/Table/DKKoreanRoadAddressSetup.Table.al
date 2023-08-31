table 50100 "DK_Korean Road Address Setup"
{
    // DK_KRADDR1.0
    //   - Create New

    Caption = 'Korean Road Address Setup';
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Count Per Page"; Integer)
        {
            Caption = 'Count Per Page';
            InitValue = 20;
            MaxValue = 100;
            MinValue = 1;
        }
        field(5; Activated; Boolean)
        {
            Caption = 'Activated';
        }
        field(7; "Default Language"; Option)
        {
            Caption = 'Default Language';
            OptionCaption = 'Korean,English';
            OptionMembers = KOR,ENG;
        }
        field(8; "Default Country/Region Code"; Code[10])
        {
            Caption = 'Default Country/Region Code';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetAPIKey(pLanguage: Option KOR,ENG): Text
    begin
        case pLanguage of
            pLanguage::KOR:
                exit('U01TX0FVVEgyMDE3MTAyNDE0MTgyMzEwNzQzNTA=');
            pLanguage::ENG:
                exit('U01TX0FVVEgyMDE3MTAyNTE2MjgxNDEwNzQzODM=');
        end;
    end;


    procedure GetAPIURL(pLanguage: Option KOR,ENG): Text
    begin
        case pLanguage of
            pLanguage::KOR:
                exit('http://www.juso.go.kr/addrlink/addrLinkApi.do?');
            pLanguage::ENG:
                exit('http://www.juso.go.kr/addrlink/addrEngApi.do?');
        end;
    end;


    procedure InsertIfNotExists()
    begin
        Rec.Reset;
        if not Get then begin
            Init;
            Rec.Insert;
            ;
        end;
    end;
}

