page 50239 "DK_Counsel Litigation Factbox"
{
    // 
    // #2044 : 2020-07-23
    //   - Rec. Modify Page Caption : ŒÁ‰½ ‹Ý„Ì €Ë‡Ÿ -> ×„ ‹Ý„Ì €Ë‡Ÿ

    Caption = 'Counsel Litigation';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Type, Date, "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE(Type = CONST(Litigation),
                            "Delete Row" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Counsel Time"; Rec."Counsel Time")
                {
                }
                field("Litigation Type"; Rec."Litigation Type")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Contact Method"; Rec."Contact Method")
                {
                }
                field("Counsel Target"; Rec."Counsel Target")
                {
                }
                field("Counsel Content"; Rec."Counsel Content")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Detail")
            {
                Caption = 'Show Detail';
                Image = Card;
                Promoted = true;

                trigger OnAction()
                var
                    _CounselHistory: Record "DK_Counsel History";
                    _CounselLitigation: Page "DK_Counsel Litigation";
                begin
                    _CounselHistory.Reset;
                    _CounselHistory.FilterGroup(2);
                    _CounselHistory.SetRange("Contract No.", Rec."Contract No.");
                    _CounselHistory.SetRange(Type, Rec.Type);
                    _CounselHistory.SetRange("Line No.", Rec."Line No.");
                    _CounselHistory.FilterGroup(0);
                    if _CounselHistory.FindSet then begin
                        Clear(_CounselLitigation);

                        if _CounselHistory.Date <= Today then
                            _CounselLitigation.Editable(false);

                        _CounselLitigation.LookupMode(true);
                        _CounselLitigation.SetTableView(_CounselHistory);
                        _CounselLitigation.SetRecord(_CounselHistory);
                        _CounselLitigation.Run;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

