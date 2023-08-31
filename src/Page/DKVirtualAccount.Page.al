page 50170 "DK_Virtual Account"
{
    Caption = 'Virtual Account';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Virtual Account";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Virtual Account No."; Rec."Virtual Account No.")
                {
                    ShowMandatory = true;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    Visible = false;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ShowMandatory = true;
                }
                field("Account Holder"; Rec."Account Holder")
                {
                    ShowMandatory = true;
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
                {
                }
                field("Assgin Expiration Date"; Rec."Assgin Expiration Date")
                {
                }
                field("Last UnAssgin Date"; Rec."Last UnAssgin Date")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
            }
            group(Control22)
            {
                ShowCaption = false;
                fixed(Control21)
                {
                    ShowCaption = false;
                    group(Quantity)
                    {
                        Caption = 'Quantity';
                        field(RowCount; RowCount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            DecimalPlaces = 0 : 0;
                            Editable = false;
                            ShowCaption = false;
                            Style = Standard;
                            StyleExpr = TRUE;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Assigined Virtual Aoount Log")
            {
                Caption = 'Assigined Virtual Aoount Log';
                Image = Log;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "DK_Pay. Expect Document List";
                RunPageLink = "Virtual Account No." = FIELD("Virtual Account No."),
                              "Payment Type" = CONST(VA);
                RunPageMode = View;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //New Line
        Rec."Bank Code" := xRec."Bank Code";
        Rec."Bank Name" := xRec."Bank Name";
        Rec."Account Holder" := xRec."Account Holder";
    end;

    trigger OnOpenPage()
    begin
        RowCount := Rec.Count;
    end;

    var
        RowCount: Decimal;
}

