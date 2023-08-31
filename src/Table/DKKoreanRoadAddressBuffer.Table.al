table 50101 "DK_Korean Road Address Buffer"
{
    // DK_KRADDR1.0
    //   - Create New

    Caption = 'Korean Road Address Buffer';
    DataPerCompany = false;

    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2;juso;Text[250])
        {
            Caption = 'juso';
        }
        field(3;roadAddr;Text[250])
        {
            Caption = 'Road Address';
        }
        field(4;roadAddrPart1;Text[250])
        {
            Caption = 'roadAddrPart1';
        }
        field(5;roadAddrPart2;Text[250])
        {
            Caption = 'roadAddrPart2';
        }
        field(6;jibunAddr;Text[250])
        {
            Caption = 'Jibu Address';
        }
        field(7;engkorAddr;Text[250])
        {
            Caption = 'Korean/English Address';
        }
        field(8;zipNo;Text[50])
        {
            Caption = 'Zip Code';
        }
        field(9;admCd;Text[50])
        {
            Caption = 'admCd';
        }
        field(10;rnMgtSn;Text[250])
        {
            Caption = 'rnMgtSn';
        }
        field(11;bdMgtSn;Text[250])
        {
            Caption = 'bdMgtSn';
        }
        field(12;detBdNmList;Text[250])
        {
            Caption = 'detBdNmList';
        }
        field(13;bdNm;Text[250])
        {
            Caption = 'bdNm';
        }
        field(14;bdKdcd;Text[50])
        {
            Caption = 'bdKdcd';
        }
        field(15;siNm;Text[50])
        {
            Caption = 'siNm';
        }
        field(16;sggNm;Text[50])
        {
            Caption = 'sggNm';
        }
        field(17;emdNm;Text[50])
        {
            Caption = 'emdNm';
        }
        field(18;liNm;Text[50])
        {
            Caption = 'liNm';
        }
        field(19;rn;Text[250])
        {
            Caption = 'rn';
        }
        field(20;udrtYn;Text[50])
        {
            Caption = 'udrtYn';
        }
        field(21;buldMnnm;Text[50])
        {
            Caption = 'buldMnnm';
        }
        field(22;buldSlno;Text[50])
        {
            Caption = 'buldSlno';
        }
        field(23;mtYn;Text[50])
        {
            Caption = 'mtYn';
        }
        field(24;lnbrMnnm;Text[50])
        {
            Caption = 'lnbrMnnm';
        }
        field(25;lnbrSlno;Text[50])
        {
            Caption = 'lnbrSlno';
        }
        field(26;emdNo;Text[50])
        {
            Caption = 'emdNo';
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

