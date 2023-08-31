tableextension 50003 CustomReportLayoutExt extends "Custom Report Layout"
{
    fields
    {
        field(50000; Standard; Boolean)
        {
            Caption = 'Standard';
            DataClassification = ToBeClassified;
        }
        field(50001; "Printing Use"; Boolean)
        {
            Caption = 'Printing Use';
            DataClassification = ToBeClassified;
        }
    }
}
