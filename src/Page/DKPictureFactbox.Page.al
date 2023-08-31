page 50010 "DK_Picture Factbox" ////zzz
{
    Caption = 'Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = DK_Picture;

    // layout
    // {
    //     area(content)
    //     {
    //         field(Image; Rec.Image)
    //         {
    //             ApplicationArea = All;
    //             Editable = false;
    //             ShowCaption = false;
    //             ToolTip = 'Specifies the picture of the customer, for example, a logo.';
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(TakePicture)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Take';
    //             Image = Camera;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             ToolTip = 'Activate the camera on the device.';
    //             Visible = CameraAvailable;

    //             trigger OnAction()
    //             begin
    //                 TakeNewPicture;
    //             end;
    //         }
    //         separator(Action3)
    //         {
    //         }
    //         action(ImportPicture)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Import';
    //             Image = Import;
    //             ToolTip = 'Import a picture file.';

    //             trigger OnAction()
    //             var
    //                 FileManagement: Codeunit "File Management";
    //                 FileName: Text;
    //                 ClientFileName: Text;
    //                 _CommFun: Codeunit "DK_Common Function";
    //             begin
    //                 Rec.TestField("Table ID");
    //                 Rec.TestField("Source No.");

    //                 if Image.HasValue then
    //                     if not Confirm(OverrideImageQst) then
    //                         exit;

    //                 FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
    //                 if FileName = '' then
    //                     exit;

    //                 //Picture
    //                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);


    //                 Clear(_CommFun);
    //                 _CommFun.ResizeImage(TempBlob, true, true, 200, 200);

    //                 Rec.Picture := TempBlob.Blob;
    //                 //Picture
    //                 Rec."Attached Name" := FileManagement.GetFileName(FileName);

    //                 Clear(Rec.Image);
    //                 Image.ImportFile(FileName, ClientFileName);
    //                 if not Rec.Modify(true) then
    //                     Rec.Insert(true);

    //                 CopyLandImage;

    //                 if FileManagement.DeleteServerFile(FileName) then;
    //             end;
    //         }
    //         action(ExportFile)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Export';
    //             Enabled = DeleteExportEnabled;
    //             Image = Export;
    //             ToolTip = 'Export the picture to a file.';

    //             trigger OnAction()
    //             var
    //                 DummyPictureEntity: Record "Picture Entity";
    //                 FileManagement: Codeunit "File Management";
    //                 ToFile: Text;
    //                 ExportPath: Text;
    //             begin
    //                 Rec.TestField("Table ID");
    //                 Rec.TestField("Source No.");

    //                 ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);

    //                 if ToFile = '' then
    //                     ToFile := Rec."Attached Name";

    //                 ExportPath := TemporaryPath + Rec."Source No." + Format(Image.MediaId);

    //                 Rec.CalcFields(Picture);
    //                 if Picture.HasValue then begin
    //                     TempBlob.Blob := Rec.Picture;
    //                     //IF "Attached Name" = '' THEN
    //                     //    _NameFile := '*.*'
    //                     //ELSE
    //                     //_NameFile := "Attached Name";

    //                     FileManagement.BLOBExport(TempBlob, ToFile, true);
    //                 end;


    //                 //Image.EXPORTFILE(ExportPath);
    //                 //FileManagement.ExportImage(ExportPath,ToFile);
    //             end;
    //         }
    //         action(DeletePicture)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Delete';
    //             Enabled = DeleteExportEnabled;
    //             Image = Delete;
    //             ToolTip = 'Delete the record.';

    //             trigger OnAction()
    //             var
    //                 _DK_Picture: Record DK_Picture;
    //             begin
    //                 Rec.TestField("Table ID");
    //                 Rec.TestField("Source No.");

    //                 if not Confirm(DeleteImageQst) then
    //                     exit;
    //                 //Picture
    //                 Clear(Rec.Picture);
    //                 //Picture
    //                 Clear(Rec.Image);
    //                 Rec."Attached Name" := '';
    //                 Rec.Modify(true);

    //                 //‘†µ
    //                 if Rec."Table ID" = DATABASE::"DK_Land. Arch. Picture" then begin
    //                     _DK_Picture.Reset;
    //                     _DK_Picture.SetRange("Table ID", DATABASE::"DK_Land. Arch. Picture");
    //                     _DK_Picture.SetRange("Source No.", Rec."Source No.");
    //                     _DK_Picture.SetFilter("Attached Name", '<>%1', '');
    //                     if _DK_Picture.FindLast then begin
    //                         _DK_Picture.CalcFields(Picture);
    //                         if DK_LandArchPicture.Get(_DK_Picture."Source No.", _DK_Picture."Source Line No.") then begin
    //                             //Picture
    //                             DK_Picture.Reset;
    //                             DK_Picture.SetRange("Table ID", DATABASE::DK_Cemetery);
    //                             DK_Picture.SetRange("Source No.", DK_LandArchPicture."Cemetery Code");
    //                             if DK_Picture.FindSet then begin
    //                                 DK_Picture.Picture := _DK_Picture.Picture;
    //                                 DK_Picture.Image := _DK_Picture.Image;
    //                                 DK_Picture."Attached Name" := _DK_Picture."Attached Name";
    //                                 DK_Picture.Modify(true);
    //                             end;
    //                             //Picture
    //                         end;
    //                     end;
    //                 end;
    //             end;
    //         }
    //     }
    // }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     SetEditableOnPictureActions;
    // end;

    // trigger OnOpenPage()
    // begin
    //     CameraAvailable := CameraProvider.IsAvailable;
    //     if CameraAvailable then
    //         CameraProvider := CameraProvider.Create;
    // end;

    // var
    //     TempBlob: Record TempBlob temporary;
    //     DK_LandArchPicture: Record "DK_Land. Arch. Picture";
    //     DK_Cemetery: Record DK_Cemetery;
    //     DK_Picture: Record DK_Picture;
    //     LineNo: Integer;
    //     CameraAvailable: Boolean;
    //     OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
    //     DeleteImageQst: Label 'Are you sure you want to delete the picture?';
    //     SelectPictureTxt: Label 'Select a picture to upload';
    //     DeleteExportEnabled: Boolean;
    //     [RunOnClient]
    //     [WithEvents]
    //     CameraProvider: DotNet CameraProvider;

    // procedure TakeNewPicture()
    // var
    //     CameraOptions: DotNet CameraOptions;
    // begin
    //     Rec.Find;
    //     Rec.TestField("Table ID");
    //     Rec.TestField("Source No.");

    //     if not CameraAvailable then
    //         exit;

    //     if Rec.Picture.HasValue then
    //         if not Confirm(OverrideImageQst) then
    //             exit;

    //     CameraOptions := CameraOptions.CameraOptions;
    //     CameraOptions.Quality := 50;
    //     CameraProvider.RequestPictureAsync(CameraOptions);
    // end;

    // local procedure SetEditableOnPictureActions()
    // begin
    //     DeleteExportEnabled := Rec.Image.HasValue;
    // end;

    // procedure IsCameraAvailable(): Boolean
    // begin
    //     exit(CameraProvider.IsAvailable);
    // end;

    // local procedure CopyLandImage()
    // begin
    //     //‰ª¬
    //     if Rec."Table ID" = DATABASE::DK_Cemetery then begin
    //         if DK_Cemetery.Get(Rec."Source No.") then begin
    //             DK_Cemetery.CalcFields("Contract No.");
    //             if DK_Cemetery."Contract No." <> '' then begin
    //                 Clear(LineNo);
    //                 DK_LandArchPicture.Reset;
    //                 DK_LandArchPicture.SetRange("Contract No.", DK_Cemetery."Contract No.");
    //                 if DK_LandArchPicture.FindLast then begin
    //                     LineNo := DK_LandArchPicture."Line No." + 10000;
    //                 end else begin
    //                     LineNo := 10000;
    //                 end;
    //                 //‘†µ
    //                 DK_LandArchPicture.Reset;
    //                 DK_LandArchPicture.Init;
    //                 DK_LandArchPicture."Contract No." := DK_Cemetery."Contract No.";
    //                 DK_LandArchPicture."Line No." := LineNo;
    //                 DK_LandArchPicture."Cemetery Code" := DK_Cemetery."Cemetery Code";
    //                 DK_LandArchPicture.Remark := DK_Cemetery.TableCaption;
    //                 DK_LandArchPicture.Insert(true);
    //                 //‘†µ
    //                 //Picture
    //                 Rec.CalcFields(Picture);
    //                 DK_Picture.Init;
    //                 DK_Picture."Table ID" := DATABASE::"DK_Land. Arch. Picture";
    //                 DK_Picture."Source No." := DK_LandArchPicture."Contract No.";
    //                 DK_Picture."Source Line No." := DK_LandArchPicture."Line No.";
    //                 DK_Picture.Picture := Rec.Picture;
    //                 DK_Picture.Image := Rec.Image;
    //                 DK_Picture."Attached Name" := Rec."Attached Name";
    //                 if not DK_Picture.Modify(true) then
    //                     DK_Picture.Insert(true);
    //                 //Picture
    //             end;
    //         end;
    //     end;

    //     //‘†µ
    //     if Rec."Table ID" = DATABASE::"DK_Land. Arch. Picture" then begin
    //         if DK_LandArchPicture.Get(Rec."Source No.", Rec."Source Line No.") then begin
    //             if DK_LandArchPicture."Cemetery Code" <> '' then begin
    //                 //Picture
    //                 Rec.CalcFields(Picture);
    //                 DK_Picture.Init;
    //                 DK_Picture."Table ID" := DATABASE::DK_Cemetery;
    //                 DK_Picture."Source No." := DK_LandArchPicture."Cemetery Code";
    //                 DK_Picture.Picture := Rec.Picture;
    //                 DK_Picture.Image := Rec.Image;
    //                 DK_Picture."Attached Name" := Rec."Attached Name";
    //                 if not DK_Picture.Modify(true) then
    //                     DK_Picture.Insert(true);
    //                 //Picture
    //             end;
    //         end;
    //     end;
    // end;

    // trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    // var
    //     File: File;
    //     Instream: InStream;
    //     _CommFun: Codeunit "DK_Common Function";
    //     FileName: Text;
    // begin
    //     if (PictureName = '') or (PictureFilePath = '') then
    //         exit;

    //     FileName := PictureFilePath;

    //     Rec.Picture.Import(PictureFilePath);
    //     Clear(TempBlob);

    //     TempBlob.Init;
    //     TempBlob.Blob := Rec.Picture;
    //     TempBlob.Insert;

    //     Clear(_CommFun);
    //     _CommFun.ResizeImage(TempBlob, true, true, 200, 200);

    //     Rec.Picture := TempBlob.Blob;

    //     //Picture
    //     Rec."Attached Name" := PictureName;

    //     File.Open(PictureFilePath);
    //     File.CreateInStream(Instream);

    //     Clear(Rec.Image);
    //     Rec.Image.ImportStream(Instream, PictureName);

    //     if not Rec.Modify(true) then
    //         Rec.Insert(true);

    //     CopyLandImage;

    //     File.Close;
    //     if Erase(PictureFilePath) then;
    // end;
}

