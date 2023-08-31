page 50155 "DK_Counsel Litigation Subform"
{
    // 
    // #2044 : 2020-07-23
    //   - Rec. Modify Page Caption : ŒÁ‰½ ‹Ý„Ì €Ë‡Ÿ -> ×„ ‹Ý„Ì €Ë‡Ÿ
    // 
    // #2156 : 2020-09-08
    //   - Rec. Modify Action Caption : <Page DK_Litigation Counsel Stat> - ŒÁ‰½ ‹Ý„Ì •ÔÐ -> ×„ ‹Ý„Ì •ÔÐ

    Caption = 'Counsel Litigation';
    CardPageID = "DK_Counsel Litigation";
    Editable = false;
    PageType = ListPart;
    SourceTable = "DK_Counsel History";
    SourceTableView = SORTING(Type, Date, "Contract No.", "Line No.")
                      ORDER(Descending)
                      WHERE("Delete Row" = CONST(false));

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
                field("Employee No."; Rec."Employee No.")
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
                field("Deposit Plan Date"; Rec."Deposit Plan Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Litigation Counsel Statics")
            {
                Caption = 'Litigation Counsel Statics';
                Image = StatisticsDocument;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Litigation Counsel Statics";
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

