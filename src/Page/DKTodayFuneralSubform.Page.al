page 50103 "DK_Today Funeral Subform"
{
    AutoSplitKey = true;
    Caption = 'Today Funeral Subform';
    CardPageID = "DK_Today Funeral Subform Card";
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Today Funeral Line";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Corpse Line No."; Rec."Corpse Line No.")
                {
                    ToolTip = 'If you are a move the grave, you can select a registered corpse.';
                }
                field(Name; Rec.Name)
                {
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field("Solar Lunar Calendar"; Rec."Solar Lunar Calendar")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Death Date"; Rec."Death Date")
                {
                }
                field("Death Cause"; Rec."Death Cause")
                {
                }
                field("Death Place"; Rec."Death Place")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field("Temporary Grave Place Name"; Rec."Temporary Grave Place Name")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _TodayFuneral: Record "DK_Today Funeral";
    begin
    end;

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;



    procedure GetTodayHeader(pContract: Code[20]; pFieldWorkMCode: Code[20])
    begin
        Rec.Init;
        Rec."Contract No." := pContract;
        Rec."Field Work Main Cat. Code" := pFieldWorkMCode;
    end;
}

