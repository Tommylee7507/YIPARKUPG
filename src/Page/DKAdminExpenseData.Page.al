page 50142 "DK_Admin. Expense Data"
{
    // *DK33 : 20200730
    //   - Add Field : "Estate Type"

    Caption = 'Admin. Expense Data';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Admin. Expense Data";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Admin. Expense Type"; Rec."Admin. Expense Type")
                {
                }
                field("Non-Payment"; Rec."Non-Payment")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Year Contract Starting Date"; Rec."Year Contract Starting Date")
                {
                }
                field("Year Contract Ending Date"; Rec."Year Contract Ending Date")
                {
                }
                field("Admin. Expense Starting Date"; Rec."Admin. Expense Starting Date")
                {
                }
                field("Admin. Expense Ending Date"; Rec."Admin. Expense Ending Date")
                {
                }
                field("Year Admin. Expense Price"; Rec."Year Admin. Expense Price")
                {
                }
                field("Contract Size"; Rec."Contract Size")
                {
                }
                field("Year Admin. Expense Amount"; Rec."Year Admin. Expense Amount")
                {
                }
                field("Year Days"; Rec."Year Days")
                {
                }
                field("Daily Admin. Expense Amt"; Rec."Daily Admin. Expense Amt")
                {
                }
                field("Diff. Admin. Expense Amt"; Rec."Diff. Admin. Expense Amt")
                {
                }
                field("Admin. Expense Period"; Rec."Admin. Expense Period")
                {
                }
                field("Include Diff. Amount"; Rec."Include Diff. Amount")
                {
                }
                field("Pay. Admin. Expense Amt"; Rec."Pay. Admin. Expense Amt")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";


    procedure SetData(pPublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li"; pPriceType: Option; pStartingDate: Date; pEndingDate: Date)
    begin
        /*
        IF pPublishAdminExpDocLine."Contract No." = '' THEN EXIT;
        
        CLEAR(AdminExpenseMgt);
        AdminExpenseMgt.ResponseAdminExpenseData(Rec,pPublishAdminExpDocLine."Contract No.",pPriceType,pStartingDate,pEndingDate);
        
        CurrPage.UPDATE;
        */

    end;
}

