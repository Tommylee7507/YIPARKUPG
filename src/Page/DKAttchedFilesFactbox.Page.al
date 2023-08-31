page 50023 "DK_Attched Files Factbox"
{
    Caption = 'Attched Files';
    DelayedInsert = true;
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
                    Visible = false;
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
            action("Import File")
            {
                Caption = 'Import File';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _NameFile: Text[1024];
                    _NewLineNo: Integer;
                    _AttchedFile: Record "DK_Attched Files";
                begin
                    //Import
                    // Clear(FileMgt);////zzz
                    Rec.CalcFields(Attached);

                    //// _NameFile := FileMgt.BLOBImport(TempBlob, '*.*');
                    //// _NameFile := FileMgt.GetFileName(_NameFile);

                    if _NameFile = '' then
                        exit;

                    _AttchedFile.Reset;
                    _AttchedFile.SetCurrentKey("Table ID", "Source No.", "Source Line No.", "Line No.");
                    _AttchedFile.SetRange("Table ID", Rec."Table ID");
                    _AttchedFile.SetRange("Source No.", Rec."Source No.");
                    _AttchedFile.SetRange("Source Line No.", Rec."Source Line No.");
                    if _AttchedFile.FindLast then
                        _NewLineNo := _AttchedFile."Line No.";


                    _NewLineNo += 10000;
                    _AttchedFile.Init;
                    _AttchedFile."Table ID" := Rec."Table ID";
                    _AttchedFile."Source No." := Rec."Source No.";
                    _AttchedFile."Source Line No." := Rec."Source Line No.";
                    _AttchedFile."Line No." := _NewLineNo;
                    _AttchedFile.Attached := TempBlob.Blob;
                    _AttchedFile.Validate("Attached Name", _NameFile);
                    _AttchedFile."Attached Date" := Today;
                    _AttchedFile."Attached User ID" := UserId;
                    _AttchedFile.Insert;

                    CurrPage.Update;
                end;
            }
            // action("Export File")////zzz
            // {
            //     Caption = 'Export File';
            //     Image = Export;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;

            //     trigger OnAction()
            //     var
            //         _NameFile: Text[100];
            //     begin
            //         //Export
            //         Rec.CalcFields(Attached);

            //         if Rec.Attached.HasValue then begin
            //             TempBlob.Blob := Rec.Attached;
            //             if Rec."Attached Name" = '' then
            //                 _NameFile := '*.*'
            //             else
            //                 _NameFile := Rec."Attached Name";

            //             FileMgt.BLOBExport(TempBlob, _NameFile, true);
            //         end;
            //         //<<DKDEV01
            //     end;
            // }
        }
    }

    var
        // FileMgt: Codeunit "File Management";////zzz
        TempBlob: Record TempBlob temporary;
}

