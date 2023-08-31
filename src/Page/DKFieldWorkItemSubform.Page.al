page 50116 "DK_Field Work Item Subform"
{
    AutoSplitKey = true;
    Caption = 'Field Work Item Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "DK_Field Work Line Item";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Used Assets Code"; Rec."Used Assets Code")
                {
                }
                field("Used Assets"; Rec."Used Assets")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                }
                field(Amount; Rec.Amount)
                {

                    trigger OnValidate()
                    begin
                        UpdateAmount;
                    end;
                }
            }
            group(Control7)
            {
                ShowCaption = false;
                fixed(Control8)
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

    trigger OnAfterGetCurrRecord()
    begin
        UpdateAmount;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage.Update(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        if _FieldWorkHeader.Get(rec."Document No.") then begin
            rec."Field Work Sub Cat. Code" := _FieldWorkHeader."Field Work Sub Cat. Code";
            rec."Field Work Sub Cat. Name" := _FieldWorkHeader."Field Work Sub Cat. Name";
        end;
    end;

    var
        TotalLineAmt: Decimal;


    procedure GetFieldWorkHeader(pSubCatCode: Code[20]; pSubCatName: Text)
    begin
        rec.Init;
        rec."Field Work Sub Cat. Code" := pSubCatCode;
        rec."Field Work Sub Cat. Name" := pSubCatName;
    end;

    local procedure UpdateAmount()
    begin
        rec.CalcTotalAmount(Rec, xRec, TotalLineAmt);
    end;
}

