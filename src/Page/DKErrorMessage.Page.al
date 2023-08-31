page 50168 "DK_Error Message"
{
    Caption = 'Error Message';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Error Message";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Additional Information"; Rec."Additional Information")
                {
                    Caption = 'Additional Information';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }


    procedure SetErrorData(pErrorIndex: Integer; pErrorList: array[60000] of Text[250])
    var
        _LineNo: Integer;
    begin

        //Insert to the page SourceTableTemporary
        while _LineNo <= pErrorIndex do begin

            _LineNo += 1;
            if pErrorList[_LineNo] <> '' then begin
                Rec.Init;
                Rec.ID := _LineNo;
                Rec.Description := pErrorList[_LineNo];
                Rec.Insert;

            end;
        end;

        CurrPage.Update;
    end;
}

