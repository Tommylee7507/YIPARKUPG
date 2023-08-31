tableextension 50000 CompanyInfoExt extends "Company Information"
{
    fields
    {
        field(50000; "DK_Owner Name"; Text[30])
        {
            Caption = 'DK_Owner Name';
            DataClassification = ToBeClassified;
        }
        field(50001; "DK_Job Title"; Text[30])
        {
            Caption = 'DK_Job Title';
            DataClassification = ToBeClassified;
        }
    }
}
