page 50147 "DK_Posted Attched Files Facbox"
{
    Caption = 'Posted Attched Files Facbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Attched Files";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field(Attached; Rec.Attached)
                {
                }
                field("Attached Name"; Rec."Attached Name")
                {
                }
                field("Attached Date"; Rec."Attached Date")
                {
                }
                field("Attached User ID"; Rec."Attached User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Export File")
            {
                Caption = 'Export File';
                Image = Export;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _NameFile: Text[100];
                begin
                    //Export
                    Rec.CalcFields(Attached);

                    if Rec.Attached.HasValue then begin
                        TempBlob.Blob := Rec.Attached;
                        if Rec."Attached Name" = '' then
                            _NameFile := '*.*'
                        else
                            _NameFile := Rec."Attached Name";

                        FileMgt.BLOBExport(TempBlob, _NameFile, true);
                    end;
                    //<<DKDEV01
                end;
            }
        }
    }

    var
        FileMgt: Codeunit "File Management";
        TempBlob: Record TempBlob temporary;
}

