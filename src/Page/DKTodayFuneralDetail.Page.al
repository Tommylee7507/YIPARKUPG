page 50098 "DK_Today Funeral Detail"
{
    Caption = 'Today Funeral Factbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "DK_Today Funeral";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {

                trigger OnDrillDown()
                var
                    _TodayFuneral: Record "DK_Today Funeral";
                    _TodayFuneralCard: Page "DK_Today Funeral Card";
                begin


                    if _TodayFuneral.Get(Rec."No.") then begin

                        Clear(_TodayFuneralCard);
                        _TodayFuneralCard.LookupMode(true);
                        _TodayFuneralCard.SetTableView(_TodayFuneral);
                        _TodayFuneralCard.SetRecord(_TodayFuneral);
                        _TodayFuneralCard.Run;
                    end;
                end;
            }
            field(Date; Rec.Date)
            {
            }
            field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
            {
            }
            field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
            {
            }
            field("Arrival Time"; Rec."Arrival Time")
            {
            }
            field("Opening Time"; Rec."Opening Time")
            {
            }
            field(Address; Rec.Address)
            {
            }
            field("Address 2"; Rec."Address 2")
            {
            }
            field("Post Code"; Rec."Post Code")
            {
            }
            field(Applicant; Rec.Applicant)
            {
            }
            field("Phone No."; Rec."Phone No.")
            {
            }
            field("Mobile No."; Rec."Mobile No.")
            {
            }
            field("Cemetery No."; Rec."Cemetery No.")
            {
            }
            field("Cemetery Digits"; Rec."Cemetery Digits")
            {
            }
            field(Size; Rec.Size)
            {
            }
            field(Remark; Rec.Remark)
            {
            }
        }
    }

    actions
    {
    }
}

