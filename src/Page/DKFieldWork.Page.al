page 50118 "DK_Field Work"
{
    Caption = 'Field Work';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Work Before,Work After';
    SourceTable = "DK_Field Work Header";
    SourceTableView = WHERE(Status = FILTER(<> Post));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control35)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {

                        trigger OnAssistEdit()
                        begin
                            Rec.AssistEdit(Rec);
                        end;
                    }
                    field(Date; Rec.Date)
                    {
                    }
                    field("Work Time Spent"; Rec."Work Time Spent")
                    {
                    }
                    field(Type; Rec.Type)
                    {

                        trigger OnValidate()
                        begin

                            // Type_Onvalidate;////zzz
                        end;
                    }
                    field("Field Work Main Cat. Code"; Rec."Field Work Main Cat. Code")
                    {
                        Importance = Additional;
                    }
                    field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                    {
                    }
                    field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                    {
                        Importance = Additional;

                        trigger OnValidate()
                        begin
                            // SubCat_Onvalidate;////zzz
                        end;
                    }
                    field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                    {
                    }
                    field("Corpse Name"; Rec."Corpse Name")
                    {
                    }
                    field("Corpse Quantity"; Rec."Corpse Quantity")
                    {
                    }
                    field("Funeral Type Code"; Rec."Funeral Type Code")
                    {
                        Importance = Additional;
                    }
                    field("Funeral Type Name"; Rec."Funeral Type Name")
                    {
                    }
                    field("Work Manager Code"; Rec."Work Manager Code")
                    {
                        Importance = Additional;
                    }
                    field("Work Manager Name"; Rec."Work Manager Name")
                    {
                    }
                    field("Work Division"; Rec."Work Division")
                    {
                    }
                    field(TotalAmount; rec.TotalAmount)
                    {
                        Importance = Additional;
                        Visible = false;
                    }
                    field("SMS Not Sent"; Rec."SMS Not Sent")
                    {
                    }
                    field("Picture Send"; Rec."Picture Send")
                    {
                        Enabled = Rec."SMS Not Sent" = FALSE;
                    }
                    field(Status; Rec.Status)
                    {
                    }
                    field("Process Content"; Rec."Process Content")
                    {
                        MultiLine = true;
                    }
                }
                group(Memo)
                {
                    Caption = 'Memo';
                    // field(WorkMemo; WorkMemo)////zzz
                    // {
                    //     MultiLine = true;

                    //     trigger OnValidate()
                    //     begin
                    //         SetWorkMemo(WorkMemo);
                    //     end;
                    // }
                }
            }
            group("Work Picture")
            {
                Caption = 'Work Picture';
                group("Work Before Picture")
                {
                    Caption = 'Work Before Picture';
                    field(Control19; Rec."Work Before Picture")
                    {
                        Enabled = false;
                        ShowCaption = false;

                        trigger OnValidate()
                        var
                            _TempBlob: Record TempBlob temporary;
                            _CommFun: Codeunit "DK_Common Function";
                        begin
                        end;
                    }
                }
                // group("Work After Picture")////zzz
                // {
                //     Caption = 'Work After Picture';
                //     field("Work after Picture"; Rec."Work after Picture")
                //     {
                //         ApplicationArea = All;
                //         Enabled = false;
                //         ShowCaption = false;
                //     }
                // }
            }
            part(FieldWorkItem; "DK_Field Work Item Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            part(FieldWorkCemetery; "DK_Field Work Cem. Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
            }
        }
        area(factboxes)
        {
            // part(Control47;"DK_Today Funeral Detail")////zzz
            // {
            //     SubPageLink = "No."=FIELD("Source No.");
            //     Visible = "Source Type" = "Source Type"::Today;
            // }
            // part(Control45;"DK_Customer Requests Factbox")
            // {
            //     SubPageLink = "No."=FIELD("Source No.");
            //     Visible = "Source Type" = "Source Type"::Request;
            // }
            // part(Control48;"DK_Cem. Services Factbox")
            // {
            //     SubPageLink = "No."=FIELD("Source No.");
            //     Visible = "Source Type" = "Source Type"::Service;
            // }
            systempart(Control29; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReOpen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'ReOpen';
                Enabled = Rec.Status <> Rec.Status::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    rec.SetOpen;
                end;
            }
            action(Release)
            {
                ApplicationArea = Suite;
                Caption = 'Release';
                Enabled = Rec.Status <> rec.Status::Release;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                begin
                    rec.SetRelease;
                end;
            }
            action(Impossible)
            {
                ApplicationArea = Suite;
                Caption = 'Impossible';
                Enabled = Rec.Status <> rec.Status::Impossible;
                Image = CloseDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _FieldWorkPost: Codeunit "DK_Field Work - Post";
                begin

                    if _FieldWorkPost.CustomerReqImpossible(Rec) then
                        Message(MSG002, rec.FieldCaption(Status), rec.Status::Impossible);
                end;
            }
            action(Post)
            {
                ApplicationArea = Suite;
                Caption = 'Post';
                Enabled = Rec.Status <> rec.Status::Post;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    _FieldWorkHeader: Record "DK_Field Work Header";
                    _FieldWorkPost: Codeunit "DK_Field Work - Post";
                begin
                    CurrPage.SetSelectionFilter(_FieldWorkHeader);
                    if _FieldWorkPost.Post(_FieldWorkHeader) then
                        Message(MSG002, rec.FieldCaption(Status), rec.Status::Post);
                end;
            }
            separator(Action53)
            {
            }
            action(WorkBeforeTakePicture)
            {
                Caption = 'Take';
                Ellipsis = true;
                Image = Camera;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    CameraNo := 0;
                    TakeNewPicture;
                end;
            }
            action(WorkBeforeImportPicture)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                    _CommFun: Codeunit "DK_Common Function";
                begin

                    if rec."Work Before Image".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    // FileName := FileManagement.UploadFile(SelectPictureTxt,ClientFileName);////zzz
                    if FileName = '' then
                        exit;

                    //Picture
                    // FileManagement.BLOBImportFromServerFile(TempBlob,FileName);////zzz


                    Clear(_CommFun);
                    // _CommFun.ResizeImage(TempBlob, true, true, 200, 200);////zzz

                    rec."Work Before Picture" := TempBlob.Blob;
                    //Picture
                    rec."Work Before Attached Name" := FileManagement.GetFileName(FileName);

                    Clear(rec."Work Before Image");
                    // rec."Work Before Image".ImportFile(FileName,ClientFileName);////zzz
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    // if FileManagement.DeleteServerFile(FileName) then;////zzz
                end;
            }
            action(WorkBeforeExportFile)
            {
                Caption = 'Export';
                Enabled = DeleteExportBeforeEnabled;
                Image = Export;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);

                    if ToFile = '' then
                        ToFile := rec."Work Before Attached Name";

                    // ExportPath := TemporaryPath + rec."Source No." + Format(rec."Work Before Image".MediaId);////zzz

                    Rec.CalcFields("Work Before Picture");
                    if rec."Work Before Picture".HasValue then begin
                        TempBlob.Blob := rec."Work Before Picture";
                        //IF "Attached Name" = '' THEN
                        //    _NameFile := '*.*'
                        //ELSE
                        //_NameFile := "Attached Name";

                        FileManagement.BLOBExport(TempBlob, ToFile, true);
                    end;


                    //Image.EXPORTFILE(ExportPath);
                    //FileManagement.ExportImage(ExportPath,ToFile);
                end;
            }
            action(WorkBeforeDeletePicture)
            {
                Caption = 'Delete';
                Ellipsis = true;
                Enabled = DeleteExportBeforeEnabled;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin

                    if not Confirm(DeleteImageQst) then
                        exit;
                    //Picture
                    Clear(rec."Work Before Picture");
                    //Picture
                    Clear(rec."Work Before Image");
                    Rec.Modify(true);
                end;
            }
            separator(Action16)
            {
            }
            action(WorkAfterTakePicture)
            {
                Caption = 'Take';
                Ellipsis = true;
                Image = Camera;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    CameraNo := 1;
                    TakeNewPicture;
                end;
            }
            action(WorkAfteImportPicture)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                    _CommFun: Codeunit "DK_Common Function";
                begin

                    if rec."Work after Picture".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    // FileName := FileManagement.UploadFile(SelectPictureTxt,ClientFileName);////zzz
                    if FileName = '' then
                        exit;

                    //Picture
                    // FileManagement.BLOBImportFromServerFile(TempBlob,FileName);////zzz


                    Clear(_CommFun);
                    // _CommFun.ResizeImage(TempBlob, true, true, 200, 200);////zzz

                    rec."Work after Picture" := TempBlob.Blob;
                    //Picture
                    rec."Work After Attached Name" := FileManagement.GetFileName(FileName);

                    Clear(rec."Work after Image");
                    // rec."Work after Image".ImportFile(FileName,ClientFileName);////zzz
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    // if FileManagement.DeleteServerFile(FileName) then;////zzz
                end;
            }
            action(WorkAfteExportFile)
            {
                Caption = 'Export';
                Enabled = DeleteExportAfterEnabled;
                Image = Export;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);

                    if ToFile = '' then
                        ToFile := rec."Work After Attached Name";

                    // ExportPath := TemporaryPath + rec."Source No." + Format(rec."Work after Image".MediaId);////zzz

                    Rec.CalcFields("Work after Picture");
                    if rec."Work after Picture".HasValue then begin
                        TempBlob.Blob := rec."Work after Picture";
                        //IF "Attached Name" = '' THEN
                        //    _NameFile := '*.*'
                        //ELSE
                        //_NameFile := "Attached Name";

                        FileManagement.BLOBExport(TempBlob, ToFile, true);
                    end;


                    //Image.EXPORTFILE(ExportPath);
                    //FileManagement.ExportImage(ExportPath,ToFile);
                end;
            }
            action(WorkAfteDeletePicture)
            {
                Caption = 'Delete';
                Ellipsis = true;
                Enabled = DeleteExportAfterEnabled;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin

                    if not Confirm(DeleteImageQst) then
                        exit;
                    //Picture
                    Clear(rec."Work after Picture");
                    //Picture
                    Clear(rec."Work after Image");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WorkMemo := rec.GetWorkMemo;
        SetEditableOnPictureActions;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        rec.Date := WorkDate;
    end;

    trigger OnOpenPage()
    begin
        // CameraAvailable := CameraProvider.IsAvailable;////zzz
        // if CameraAvailable then////zzz
        //   CameraProvider := CameraProvider.Create;////zzz
    end;

    var
        WorkMemo: Text;
        MSG001: Label 'The result is complete.';
        MSG002: Label 'The %1 has been Rec. Modify to a %2.';
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        //// [RunOnClient]
        //// [WithEvents]
        //// CameraProvider: DotNet CameraProvider;
        CameraNo: Integer;
        TempBlob: Record TempBlob temporary;
        DeleteExportBeforeEnabled: Boolean;
        DeleteExportAfterEnabled: Boolean;

    local procedure Type_Onvalidate()
    begin
        CurrPage.FieldWorkCemetery.PAGE.GetFieldWorkHeader(rec.Type);
        CurrPage.Update;
    end;

    local procedure SubCat_Onvalidate()
    begin

        CurrPage.FieldWorkItem.PAGE.GetFieldWorkHeader(rec."Field Work Sub Cat. Code", rec."Field Work Sub Cat. Name");
        CurrPage.Update;
    end;

    procedure TakeNewPicture()
    var
    // CameraOptions: DotNet CameraOptions;////zzz
    begin
        rec.Find;
        //TESTFIELD("Table ID");
        //TESTFIELD("Source No.");

        if not CameraAvailable then
            exit;

        case CameraNo of
            0:
                begin
                    if rec."Work Before Picture".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;
                end;
            1:
                begin
                    if rec."Work after Picture".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;
                end;
        end;

        // CameraOptions := CameraOptions.CameraOptions;////zzz
        // CameraOptions.Quality := 50;////zzz
        // CameraProvider.RequestPictureAsync(CameraOptions);////zzz
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        // exit(CameraProvider.IsAvailable);////zzz
    end;

    local procedure SetEditableOnPictureActions()
    begin

        DeleteExportBeforeEnabled := rec."Work Before Picture".HasValue;
        DeleteExportAfterEnabled := rec."Work after Picture".HasValue;
    end;

    // trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text) ////zzz
    // var
    //     File: File;
    //     Instream: InStream;
    //     _CommFun: Codeunit "DK_Common Function";
    //     FileName: Text;
    // begin
    //     if (PictureName = '') or (PictureFilePath = '') then
    //         exit;

    //     FileName := PictureFilePath;
    //     case CameraNo of
    //         0:
    //             begin
    //                 Rec."Work Before Picture".Import(PictureFilePath);
    //                 Clear(TempBlob);

    //                 TempBlob.Init;
    //                 TempBlob.Blob := rec."Work Before Picture";
    //                 TempBlob.Insert;

    //                 Clear(_CommFun);
    //                 _CommFun.ResizeImage(TempBlob, true, true, 200, 200);

    //                 rec."Work Before Picture" := TempBlob.Blob;

    //                 //Picture
    //                 rec."Work Before Attached Name" := PictureName;

    //                 // File.Open(PictureFilePath);////zzz
    //                 // File.CreateInStream(Instream);////zzz

    //                 Clear(rec."Work Before Image");
    //                 Rec."Work Before Image".ImportStream(Instream, PictureName);
    //             end;
    //         1:
    //             begin
    //                 Rec."Work after Picture".Import(PictureFilePath);
    //                 Clear(TempBlob);

    //                 TempBlob.Init;
    //                 TempBlob.Blob := rec."Work after Picture";
    //                 TempBlob.Insert;

    //                 Clear(_CommFun);
    //                 _CommFun.ResizeImage(TempBlob, true, true, 200, 200);

    //                 rec."Work after Picture" := TempBlob.Blob;

    //                 //Picture
    //                 rec."Work After Attached Name" := PictureName;

    //                 // File.Open(PictureFilePath);////zzz
    //                 // File.CreateInStream(Instream);////zzz

    //                 Clear(Rec."Work after Image");
    //                 Rec."Work after Image".ImportStream(Instream, PictureName);
    //             end;
    //     end;


    //     if not Rec. Modify(true) then
    //         Rec.Insert(true);

    //     // File.Close;////zzz
    //     // if Erase(PictureFilePath) then;////zzz
    // end;
}

