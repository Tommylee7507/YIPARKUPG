page 50238 "DK_Counsel General Factbox"
{
    Caption = 'Counsel General';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Type, Date, "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE(Type = CONST(General),
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
                field("Result Process"; Rec."Result Process")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Counsel Level 1"; Rec."Counsel Level 1")
                {
                }
                field("Counsel Level Name 2"; Rec."Counsel Level Name 2")
                {
                }
                field("Dev. Target Doc. No."; Rec."Dev. Target Doc. No.")
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
                    _CounselGeneral: Page "DK_Counsel General";
                begin
                    _CounselHistory.Reset;
                    _CounselHistory.FilterGroup(2);
                    _CounselHistory.SetRange("Contract No.", Rec."Contract No.");
                    _CounselHistory.SetRange(Type, Rec.Type);
                    _CounselHistory.SetRange("Line No.", Rec."Line No.");
                    _CounselHistory.FilterGroup(0);
                    if _CounselHistory.FindSet then begin
                        Clear(_CounselGeneral);
                        if _CounselHistory.Date <= Today then
                            _CounselGeneral.Editable(false);

                        _CounselGeneral.LookupMode(true);
                        _CounselGeneral.SetTableView(_CounselHistory);
                        _CounselGeneral.SetRecord(_CounselHistory);
                        _CounselGeneral.Run;
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

