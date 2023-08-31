query 50000 "DK_Alarm Group By SN"
{
    Caption = 'Alarm Group By Source No.';

    elements
    {
        dataitem(DK_Alarm;DK_Alarm)
        {
            filter(Source_Type_Filter;"Source Type")
            {
            }
            filter(Type_Filter;Type)
            {
            }
            filter(Alarm_Date_Filter;"Alarm Date")
            {
            }
            column(Source_Type;"Source Type")
            {
            }
            column(Type;Type)
            {
            }
            column(Alarm_Date;"Alarm Date")
            {
            }
            column(Source_No;"Source No.")
            {
            }
            column(Count_)
            {
                Method = Count;
            }
        }
    }
}

