page 50316 "DK_Cust Contract factBox"
{
    Caption = '¼×À ÐŽÊ ˆ«Š–«';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "DK_Friends And Relatives";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("Contract No."; Rec."Contract No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if RecContract.Get(Rec."Contract No.") then begin
                            PAGE.Run(PAGE::"DK_Contract Card", RecContract);
                        end;
                    end;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if RecCemetery.Get(Rec."Cemetery Code") then begin
                            PAGE.Run(PAGE::"DK_Cemetery Card", RecCemetery);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        RecContract: Record DK_Contract;
        RecCemetery: Record DK_Cemetery;
}

