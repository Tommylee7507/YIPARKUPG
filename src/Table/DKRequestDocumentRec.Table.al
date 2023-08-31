table 50062 "DK_Request Document Rec."
{
    Caption = 'Required Documents Received';
    DataCaptionFields = "Document Name","Attached Name","Attached Date";

    fields
    {
        field(1;"Table ID";Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(2;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(3;"Source Line No.";Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(4;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(6;"Document Name";Text[50])
        {
            Caption = 'Document Name';
            DataClassification = ToBeClassified;
        }
        field(7;Attached;BLOB)
        {
            Caption = 'Attached';
            DataClassification = ToBeClassified;
        }
        field(8;"Attached Name";Text[100])
        {
            Caption = 'Attached Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Attached Date";Date)
        {
            Caption = 'Attached Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"Attached User ID";Text[50])
        {
            Caption = 'Attached User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;Mandatory;Boolean)
        {
            CalcFormula = Lookup("DK_Request Doc. Setup".Mandatory WHERE ("Line No."=FIELD("Line No."),
                                                                          "Document Name"=FIELD("Document Name")));
            Caption = 'Mandatory';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Table ID","Source No.","Source Line No.","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        _RevocationContract: Record "DK_Revocation Contract";
    begin

        case "Table ID" of
          DATABASE::"DK_Revocation Contract":begin
            _RevocationContract.Reset;
            _RevocationContract.SetRange("Document No.", "Source No.");
            if _RevocationContract.FindSet then begin
               if not (_RevocationContract.Status in [_RevocationContract.Status::Open,
                                                 _RevocationContract.Status::Released]) then
                  Error(MSG001,
                        _RevocationContract.FieldCaption(Status),
                        _RevocationContract.Status);
            end;
          end;
        end;
    end;

    var
        MSG001: Label 'Attachments can not be changed in the current %1. %1:%2';
}

