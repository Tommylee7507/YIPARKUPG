page 50079 "DK_Posted Picture Factbox"
{
    Caption = 'Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = DK_Picture;

    layout
    {
        area(content)
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the customer, for example, a logo.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("Table ID");
                    Rec.TestField("Source No.");

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);

                    if ToFile = '' then
                        ToFile := Rec."Attached Name";

                    ////zzz++
                    // ExportPath := TemporaryPath + Rec."Source No." + Format(Rec.Image.MediaId);
                    // Image.ExportFile(ExportPath);

                    // FileManagement.ExportImage(ExportPath, ToFile);
                    ////zzz--
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Image.HasValue;
    end;
}

