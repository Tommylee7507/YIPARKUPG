table 50078 "DK_Field Work Sub Cat. Detail"
{
    Caption = 'Field Work Item';
    DataCaptionFields = "Field Work Sub Cat. Code";
    DrillDownPageID = "DK_Field Work Sub Cat. Detail";
    LookupPageID = "DK_Field Work Sub Cat. Detail";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;"Field Work Sub Cat. Code";Code[20])
        {
            Caption = 'Field Work Sub Cat Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Field Work Sub Category".Code WHERE (Blocked=CONST(false));
        }
        field(4;"Used Assets No.";Code[20])
        {
            Caption = 'Use Assets No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type=CONST(Item)) DK_Item."No." WHERE (Blocked=CONST(false))
                            ELSE IF (Type=CONST(Vehicle)) DK_Vehicle."No." WHERE (Type=CONST(equipment))
                            ELSE IF (Type=CONST(WorkGroup)) "DK_Work Group".Code WHERE (Blocked=CONST(false));

            trigger OnValidate()
            begin
                ItemNoCheck(Rec);

                if xRec."Used Assets No." <> "Used Assets No." then begin

                  "Item Cost Amount" := 0;

                  InsertUsedAssets("Used Assets No.");
                end;
            end;
        }
        field(5;"Used Assets";Text[50])
        {
            Caption = 'Used Assets';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6;"Item Cost Amount";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Lookup(DK_Item.Price WHERE ("No."=FIELD("Used Assets No.")));
            Caption = 'Item Cost Amount';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(7;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(8;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Item,Vehicle,Work Group';
            OptionMembers = Item,Vehicle,WorkGroup;

            trigger OnValidate()
            begin
                Check_WorkGroup;
            end;
        }
        field(9;"Vehicle Cost Amount";Decimal)
        {
            CalcFormula = Lookup(DK_Vehicle."Cost Amount" WHERE ("No."=FIELD("Used Assets No.")));
            Caption = 'Vehicle Cost Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"Work Group Cost Amount";Decimal)
        {
            CalcFormula = Lookup("DK_Work Group"."Cost Amount" WHERE (Code=FIELD("Used Assets No.")));
            Caption = 'Work Group Cost Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;Quantity;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1;"Field Work Sub Cat. Code","Code")
        {
            Clustered = true;
        }
        key(Key2;"Code")
        {
        }
        key(Key3;"Used Assets No.")
        {
        }
        key(Key4;"Used Assets")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code","Used Assets","Item Cost Amount")
        {
        }
    }

    trigger OnDelete()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        
        /*
        _FieldWorkHeader.RESET;
        _FieldWorkHeader.SETRANGE("Field Work Sub Cat. Code","Field Work Sub Cat. Code");
        _FieldWorkHeader.SETFILTER(Status,'<>%1',_FieldWorkHeader.Status::Post);
        IF _FieldWorkHeader.FINDSET THEN
          ERROR(MSG002,_FieldWorkHeader.TABLECAPTION);
        */

    end;

    var
        MSG001: Label 'There is the same %1. Check the %2.';
        MSG002: Label 'It becomes impossible to delete in use by %1.';

    local procedure ItemNoCheck(pFieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail")
    var
        _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
    begin

        _FieldWorkSubCatDetail.Reset;
        _FieldWorkSubCatDetail.SetRange("Field Work Sub Cat. Code",pFieldWorkSubCatDetail."Field Work Sub Cat. Code");
        _FieldWorkSubCatDetail.SetRange("Used Assets No.",pFieldWorkSubCatDetail."Used Assets No.");
        if _FieldWorkSubCatDetail.FindFirst then
          Error(MSG001,FieldCaption("Used Assets No."),_FieldWorkSubCatDetail.Code);
    end;

    local procedure InsertUsedAssets(pCode: Code[20])
    var
        _Item: Record DK_Item;
        _Vehicle: Record DK_Vehicle;
        _WorkGroup: Record "DK_Work Group";
    begin
        case Type of
          Type::Item:begin
            if _Item.Get(pCode) then
              "Used Assets" := _Item.Name
            else
              "Used Assets" := '';
          end;
          Type::Vehicle:begin
            if _Vehicle.Get(pCode) then
              "Used Assets" := _Vehicle.Name
            else
              "Used Assets" := '';
          end;
          Type::WorkGroup:begin
            if _WorkGroup.Get(pCode) then
              "Used Assets" := _WorkGroup.Name
            else
              "Used Assets" := '';
          end;
        end;

        Quantity := 1;
    end;

    local procedure Check_WorkGroup()
    var
        _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
    begin

        if Type <> Type::WorkGroup then
          exit;

        _FieldWorkSubCatDetail.Reset;
        _FieldWorkSubCatDetail.SetRange("Field Work Sub Cat. Code","Field Work Sub Cat. Code");
        _FieldWorkSubCatDetail.SetRange(Type,_FieldWorkSubCatDetail.Type::WorkGroup);
        if _FieldWorkSubCatDetail.FindFirst then
          Error(MSG001,_FieldWorkSubCatDetail.Type::WorkGroup,_FieldWorkSubCatDetail.Code);
    end;
}

