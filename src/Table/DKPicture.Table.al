table 50024 DK_Picture
{
    Caption = 'Picture';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(5; Picture; BLOB)
        {
            Caption = 'Picture';
            Compressed = false;
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(6; Image; Media)
        {
            Caption = 'Image';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Person;
        }
        field(7; "Attached Name"; Text[100])
        {
            Caption = 'Attached Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Source No.", "Source Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure DeletePicture(pTableID: Integer; pSourceNo: Code[20]; pSourceLineNo: Integer)
    var
        _Picture: Record DK_Picture;
        _DK_Picture: Record DK_Picture;
        _DK_LandArchPicture: Record "DK_Land. Arch. Picture";
    begin

        _Picture.Reset;
        _Picture.SetRange("Table ID", pTableID);
        _Picture.SetRange("Source No.", pSourceNo);
        if pSourceLineNo <> 0 then
            _Picture.SetRange("Source Line No.", pSourceLineNo);
        if _Picture.FindFirst then
            _Picture.DeleteAll;


        //‘†µ
        if pTableID = DATABASE::"DK_Land. Arch. Picture" then begin
            _Picture.Reset;
            _Picture.SetRange("Table ID", DATABASE::"DK_Land. Arch. Picture");
            _Picture.SetRange("Source No.", pSourceNo);
            _Picture.SetFilter("Attached Name", '<>%1', '');
            if _Picture.FindLast then begin
                _Picture.CalcFields(Picture);
                if _DK_LandArchPicture.Get(_Picture."Source No.", _Picture."Source Line No.") then begin
                    //Picture
                    _DK_Picture.Reset;
                    _DK_Picture.SetRange("Table ID", DATABASE::DK_Cemetery);
                    _DK_Picture.SetRange("Source No.", _DK_LandArchPicture."Cemetery Code");
                    if _DK_Picture.FindSet then begin
                        _DK_Picture.Picture := _Picture.Picture;
                        _DK_Picture.Image := _Picture.Image;
                        _DK_Picture."Attached Name" := _Picture."Attached Name";
                        _DK_Picture.Modify(true);
                    end;
                    //Picture
                end;
            end;
        end;
    end;

    local procedure CheckModify()
    begin

        case "Table ID" of
            DATABASE::"DK_Purchase Line":
                begin

                end;
        end;
    end;
}

