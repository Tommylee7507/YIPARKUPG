page 50267 "DK_Change Laying Date"////zzz
{
    // *DK32 : 20200715
    //   - Create

    Caption = 'Change Laying Date';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Corpse;

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             field("Laying Date"; Rec."Laying Date")
    //             {
    //                 Caption = 'Current Laying Date';
    //             }
    //             field(ChangeLayingDate; Rec.ChangeLayingDate)
    //             {
    //                 Caption = 'Change Laying Date';
    //                 Style = Attention;
    //                 StyleExpr = TRUE;

    //                 trigger OnValidate()
    //                 var
    //                     _Contract: Record DK_Contract;
    //                 begin
    //                     if ChangeLayingDate = 0D then
    //                         Error(MSG001, Rec.FieldCaption("Laying Date"));

    //                     if _Contract.Get(Rec."Contract No.") then begin
    //                         if _Contract."Contract Date" > ChangeLayingDate then
    //                             Error(MSG002, _Contract.FieldCaption("Contract Date"), _Contract."Contract Date",
    //                                           Rec.FieldCaption("Laying Date"), ChangeLayingDate);
    //                     end;
    //                 end;
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control5; Rec."DK_Contract Detail Factbox")
    //         {
    //             SubPageLink = "No." = FIELD("Contract No.");
    //         }
    //     }
    // }

    // actions
    // {
    // }

    // var
    //     ChangeLayingDate: Date;
    //     MSG001: Label 'The %1 cannot be empty.';
    //     MSG002: Label '%3 cannot be less than %1. %1:%2, %3:%4';


    // procedure GetChangeLayingDate(): Date
    // begin

    //     exit(ChangeLayingDate);
    // end;
}

