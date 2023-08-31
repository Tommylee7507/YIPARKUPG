page 50096 "DK_Request Doc. Rec. Factbox"
{
    Caption = 'Request Document Rec.';
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
            action(Reset)
            {
                Caption = 'Reset';
                Image = AddAction;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _RevContract: Record "DK_Revocation Contract";
                begin

                    _RevContract.DelRequestDocumentRec(Rec."Source No.");

                    _RevContract.Reset;
                    _RevContract.SetRange("Document No.", Rec."Source No.");
                    _RevContract.SetFilter("Contract Type", '<>%1', _RevContract."Contract Type"::Deposit);
                    _RevContract.SetFilter("Contract No.", '<>%1', '');
                    if _RevContract.FindSet then begin
                        _RevContract.SetRequestDoc;
                        //END ELSE BEGIN
                        //  MESSAGE(MSG003, _RevContract.FIELDCAPTION("Contract Type"), _RevContract."Contract Type"::Deposit);
                    end;

                    CurrPage.Update;
                end;
            }
            action("&Import")
            {
                Caption = '&Import';
                Ellipsis = true;
                Image = Import;

                trigger OnAction()
                var
                    _NameFile: Text[1024];
                begin

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
        MSG003: Label 'There is no required document for the %2.';
}

