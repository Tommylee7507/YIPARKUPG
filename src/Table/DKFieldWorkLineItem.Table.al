table 50075 "DK_Field Work Line Item"
{
    Caption = 'Field Work Line Item';
    DrillDownPageID = "DK_Field Work Item Subform";
    LookupPageID = "DK_Field Work Item Subform";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Used Assets Code"; Code[20])
        {
            Caption = 'Used Assets Code';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Item)) DK_Item."No." WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Vehicle)) DK_Vehicle."No." WHERE(Type = CONST(equipment),
                                                                                  Status = CONST(Confirmation))
            ELSE
            IF (Type = CONST(WorkGroup)) "DK_Work Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Item: Record DK_Item;
                _Vehicle: Record DK_Vehicle;
            begin
                ItemNoCheck(Rec);

                if xRec."Used Assets Code" <> "Used Assets Code" then begin

                    Quantity := 0;
                    "Cost Amount" := 0;
                    Amount := 0;

                    Insert_UsedAsset("Used Assets Code");
                end;
            end;
        }
        field(4; "Used Assets"; Text[50])
        {
            Caption = 'Used Assets';
            Editable = false;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Item,Vehicle,WorkGroup';
            OptionMembers = Item,Vehicle,WorkGroup;

            trigger OnValidate()
            begin

                if Rec.Type <> xRec.Type then begin
                    "Used Assets Code" := '';
                    "Used Assets" := '';
                    Quantity := 0;
                    "Cost Amount" := 0;
                    Amount := 0;

                    //Check_Type(Type);
                end;
            end;
        }
        field(9; Quantity; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                _FieldWorkHeader: Record "DK_Field Work Header";
            begin
                if xRec.Quantity <> Rec.Quantity then begin
                    CalcAmount;
                end;
            end;
        }
        field(10; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            MinValue = 0;

            trigger OnValidate()
            var
                _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
            begin
                if xRec."Cost Amount" <> Rec."Cost Amount" then begin
                    CalcAmount;
                end;
            end;
        }
        field(11; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(12; "Field Work Sub Cat. Code"; Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Field Work Sub Cat. Name"; Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Document Date"; Date)
        {
            CalcFormula = Lookup("DK_Field Work Header".Date WHERE("No." = FIELD("Document No.")));
            Caption = 'Document Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Document Status"; Option)
        {
            CalcFormula = Lookup("DK_Field Work Header".Status WHERE("No." = FIELD("Document No.")));
            Caption = 'Document Status';
            FieldClass = FlowField;
            OptionCaption = 'Open,Release,Post,Impossible';
            OptionMembers = Open,Release,Post,Impossible;
        }
        field(16; "Field Work Main Cat. Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Field Work Header"."Field Work Main Cat. Code" WHERE("No." = FIELD("Document No.")));
            Caption = 'Field Work Main Category Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Funeral Type Code"; Code[20])
        {
            CalcFormula = Lookup("DK_Field Work Header"."Funeral Type Code" WHERE("No." = FIELD("Document No.")));
            Caption = 'Funeral Type Code';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("No.", "Document No.");
        if _FieldWorkHeader.Status = _FieldWorkHeader.Status::Post then
            Error(MSG001, _FieldWorkHeader.FieldCaption(Status), _FieldWorkHeader.Status::Post);
    end;

    trigger OnInsert()
    begin

        TestField("Used Assets Code");
        TestField(Quantity);
        TestField("Cost Amount");
    end;

    trigger OnModify()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("No.", "Document No.");
        if _FieldWorkHeader.Status = _FieldWorkHeader.Status::Post then
            Error(MSG001, _FieldWorkHeader.FieldCaption(Status), _FieldWorkHeader.Status::Post);

        TestField("Used Assets Code");
    end;

    var
        MSG001: Label 'If the %1 is %2, it can not be Modify or deleted.';
        MSG002: Label 'You can not put an %2 whose %1 has not been decided.';
        MSG003: Label 'There is the same %1. Check the %2.';
        MSG004: Label 'You can not modify it because a %1 has been specified. Please check the %2.';

    local procedure CalcAmount()
    begin
        if "Cost Amount" = 0 then
            Amount := 0
        else
            Amount := Quantity * "Cost Amount";
    end;

    local procedure ItemNoCheck(pFieldWorkLine: Record "DK_Field Work Line Item")
    var
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
    begin

        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Document No.", pFieldWorkLine."Document No.");
        _FieldWorkLineItem.SetRange("Used Assets Code", pFieldWorkLine."Used Assets Code");
        if _FieldWorkLineItem.FindFirst then
            Error(MSG003, FieldCaption("Used Assets Code"), _FieldWorkLineItem."Line No.");
    end;

    procedure CalcTotalAmount(var pFieldWorkLineItem: Record "DK_Field Work Line Item"; pLastFieldWorkLineItem: Record "DK_Field Work Line Item"; var TotalAmount: Decimal)
    var
        TempFieldWorkLineItem: Record "DK_Field Work Line Item";
        _FieldWorkHeader: Record "DK_Field Work Header";
    begin
        /*
        TempFieldWorkLineItem.COPYFILTERS(pFieldWorkLineItem);
        
        TempFieldWorkLineItem.SETRANGE("Document No.", pFieldWorkLineItem."Document No.");
        TempFieldWorkLineItem.CALCSUMS(Amount);
        
        TotalAmount := TempFieldWorkLineItem.Amount;
        
        IF _FieldWorkHeader.GET(pFieldWorkLineItem."Document No.") THEN BEGIN
          _FieldWorkHeader.TotalAmount := TotalAmount + Aomunt - xRec.Amount;
          _FieldWorkHeader.MODIFY;
        END;
        */
        if _FieldWorkHeader.Get(pFieldWorkLineItem."Document No.") then begin
            _FieldWorkHeader.CalcFields("Line Amount");
            TotalAmount := _FieldWorkHeader."Line Amount";
        end;

    end;

    local procedure Insert_UsedAsset(pCode: Code[20])
    var
        _Item: Record DK_Item;
        _Vehicle: Record DK_Vehicle;
        _WorkGroup: Record "DK_Work Group";
    begin
        case Type of
            Type::Item:
                begin
                    if _Item.Get(pCode) then begin
                        Validate("Used Assets", _Item.Name);
                        Validate("Cost Amount", _Item.Price);
                    end else begin
                        "Used Assets" := '';
                        "Cost Amount" := 0;
                    end;
                end;
            Type::Vehicle:
                begin
                    if _Vehicle.Get(pCode) then begin
                        Validate("Used Assets", _Vehicle.Name);
                        Validate("Cost Amount", _Vehicle."Cost Amount");
                    end else begin
                        "Used Assets" := '';
                        "Cost Amount" := 0;
                    end;
                end;
            Type::WorkGroup:
                begin
                    if _WorkGroup.Get(pCode) then begin
                        Validate("Used Assets", _WorkGroup.Name);
                        Validate("Cost Amount", _WorkGroup."Cost Amount");
                    end else begin
                        "Used Assets" := '';
                        "Cost Amount" := 0;
                    end;
                end;
        end;
    end;

    local procedure Check_Type(pType: Integer)
    var
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
    begin
        if Type <> Type::WorkGroup then
            exit;

        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Document No.", "Document No.");
        _FieldWorkLineItem.SetRange(Type, _FieldWorkLineItem.Type::WorkGroup);
        if _FieldWorkLineItem.FindFirst then
            Error(MSG003, _FieldWorkLineItem.FieldCaption(Type), _FieldWorkLineItem."Line No.");
    end;
}

