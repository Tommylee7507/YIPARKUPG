page 50159 "DK_Move The Grave Subform"
{
    AutoSplitKey = true;
    Caption = 'Move The Grave Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Move The Grave Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Corpse Line No."; Rec."Corpse Line No.")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                    Enabled = Rec."Field Work Main Cat. Code" <> '';
                }
                field("Corpse Name"; Rec."Corpse Name")
                {
                }
                field("Laying Date"; Rec."Laying Date")
                {
                }
                field("Death Date"; Rec."Death Date")
                {
                }
                field("Desired Date"; Rec."Desired Date")
                {
                }
                field("Service Item"; Rec."Service Item")
                {
                }
                field(Grappling; Rec.Grappling)
                {
                }
                field("Total Expense Amount"; Rec."Total Expense Amount")
                {
                }
                field(Amount; Rec.Amount)
                {

                    trigger OnValidate()
                    begin
                        UpdateAmount;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
            group(Control18)
            {
                ShowCaption = false;
                fixed(Control17)
                {
                    ShowCaption = false;
                    group("Total Line Amount")
                    {
                        Caption = 'Total Line Amount';
                        field("TotalLineAmt + Amount - xRec.Amount"; TotalLineAmt + Rec.Amount - xRec.Amount)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        UpdateAmount;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UpdateAmount;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateAmount;
    end;

    var
        TotalLineAmt: Decimal;

    local procedure UpdateAmount()
    begin
        Rec.CalcTotalAmount(Rec, xRec, TotalLineAmt);
    end;
}

