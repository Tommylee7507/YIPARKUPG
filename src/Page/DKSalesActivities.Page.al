page 50193 "DK_Sales Activities"
{
    // 
    // DK34: 20201130
    //   - Add Field: "No. of Unsold Cemetery Conf8"

    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            cuegroup("No. of Unsold Cemetery1")
            {
                Caption = 'No. of Unsold Cemetery1';
                field("No. of Unsold Cemetery Conf1"; Rec."No. of Unsold Cemetery Conf1")
                {
                }
                field("No. of Unsold Cemetery Conf2"; Rec."No. of Unsold Cemetery Conf2")
                {
                }
                field("No. of Unsold Cemetery Conf3"; Rec."No. of Unsold Cemetery Conf3")
                {
                }
            }
            cuegroup("No. of Unsold Cemetery2")
            {
                Caption = 'No. of Unsold Cemetery2';
                field("No. of Unsold Cemetery Conf4"; Rec."No. of Unsold Cemetery Conf4")
                {
                }
                field("No. of Unsold Cemetery Conf5"; Rec."No. of Unsold Cemetery Conf5")
                {
                }
                field("No. of Unsold Cemetery Conf6"; Rec."No. of Unsold Cemetery Conf6")
                {
                }
                field("No. of Unsold Cemetery Conf7"; Rec."No. of Unsold Cemetery Conf7")
                {
                }
                field("No. of Unsold Cemetery Conf8"; Rec."No. of Unsold Cemetery Conf8")
                {
                }
            }
            cuegroup(Contract)
            {
                Caption = 'Contract';
                field("No. of Open Contract"; Rec."No. of Open Contract")
                {
                }
                field("No. of Reserv. Contract"; Rec."No. of Reserv. Contract")
                {
                    Caption = 'No. of Reservation Contract';
                }
                field("No. of Temp. Contract"; Rec."No. of Temp. Contract")
                {
                    Caption = 'No. of Temporary Contract';
                }
                field("No. of Overdue Bal. Cont."; Rec."No. of Overdue Bal. Cont.")
                {
                }
                field("No. of Transfer Litigation"; Rec."No. of Transfer Litigation")
                {
                }
            }
            cuegroup("TODAY PG Payment")
            {
                Caption = 'TODAY PG Payment';
                field("TODAY PG Receipt"; Rec."TODAY PG Receipt")
                {
                }
                field("TODAY PG Receipt2"; Rec."TODAY PG Receipt2")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Date Filter", '<%1', WorkDate);
        Rec.SetFilter("Date Filter 2", '%1', WorkDate);
        Rec.FilterGroup(0);
    end;
}

