page 50123 "DK_Post Req. Doc. Rec. Factbox"
{
    Caption = 'Posted Request Document Rec.';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Request Document Rec.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Mandatory; Rec.Mandatory)
                {
                }
                field("Document Name"; Rec."Document Name")
                {
                }
                field("Attached Name"; Rec."Attached Name")
                {
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    Visible = false;
                }
                field("Attached User ID"; Rec."Attached User ID")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Import")
            {
                Caption = '&Import';
                Ellipsis = true;
                Image = Import;

                trigger OnAction()
                var
                    _NameFile: Text[1024];
                begin
                    Check_UserSetup;

                    Rec.TestField("Document Name");
                    Clear(AppTemplateExists);

                    Rec.CalcFields(Attached);
                    if Rec.Attached.HasValue then
                        if AppTemplateExists then
                            if not Confirm(MSG002, false, Rec.FieldCaption(Attached)) then
                                exit;

                    _NameFile := FileMgt.BLOBImport(TempBlob, '*.*');
                    _NameFile := FileMgt.GetFileName(_NameFile);

                    if _NameFile = '' then
                        exit;

                    Rec.Attached := TempBlob.Blob;
                    Rec.Validate("Attached Name", _NameFile);
                    Rec."Attached Date" := Today;

                    CurrPage.SaveRecord;
                end;
            }
            action("&Export")
            {
                Caption = '&Export';
                Ellipsis = true;
                Image = Export;

                trigger OnAction()
                var
                    _NameFile: Text[100];
                begin

                    Rec.CalcFields(Attached);

                    if Rec.Attached.HasValue then begin
                        TempBlob.Blob := Rec.Attached;
                        if Rec."Attached Name" = '' then
                            _NameFile := '*.*'
                        else
                            _NameFile := Rec."Attached Name";

                        FileMgt.BLOBExport(TempBlob, _NameFile, true);
                    end;
                end;
            }
            action(Delete)
            {
                Caption = 'Delete';
                Ellipsis = true;
                Image = CancelAttachment;

                trigger OnAction()
                begin
                    Check_UserSetup;

                    Rec.CalcFields(Attached);
                    if Rec.Attached.HasValue then
                        if Confirm(MSG001, false, Rec."Document Name") then begin
                            Clear(Rec.Attached);
                            Rec.Validate("Attached Name", '');
                            Rec."Attached Date" := 0D;

                            CurrPage.SaveRecord;
                        end;
                end;
            }
        }
    }

    var
        FileMgt: Codeunit "File Management";
        TempBlob: Record TempBlob temporary;
        MSG001: Label 'Are you sure you want to delete the %1 Report attachments?';
        MSG002: Label 'Do you want to replace the existing %1?';
        AppTemplateExists: Boolean;
        MSG003: Label 'You do not have permission to Rec. Modify. Please contact your administrator.';

    local procedure Check_UserSetup()
    var
        _UserSetup: Record "User Setup";
    begin
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_General Counsel Admin.", true);
        if not _UserSetup.FindSet then
            Error(MSG003);
    end;
}

