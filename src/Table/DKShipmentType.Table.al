table 50065 "DK_Shipment Type"
{
    Caption = 'Shipment Type';
    DrillDownPageID = "DK_Shipment Type";
    LookupPageID = "DK_Shipment Type";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdateShipmentType(Code,Name,xRec.Name);
            end;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    trigger OnModify()
    begin
        TestField(Code);
    end;

    var
        MSG001: Label 'You must select an existing %1.';

    procedure GetShipmentTypeCode(pShipmentText: Text): Text
    begin
        exit(GetShipmentTypeName(pShipmentText));
    end;

    procedure GetShipmentTypeName(pShipmentText: Text): Code[20]
    var
        _ShipmentType: Record "DK_Shipment Type";
        _ShipmentTypeWithoutQuote: Text;
        _ShipmentTypeFilterFromStart: Text;
        _ShipmentTypeFilterContains: Text;
    begin
        if pShipmentText = '' then
          exit('');

        if StrLen(pShipmentText) <= MaxStrLen(_ShipmentType.Code) then
          if _ShipmentType.Get(CopyStr(pShipmentText,1,MaxStrLen(_ShipmentType.Code))) then
            exit(_ShipmentType.Code);

        _ShipmentType.SetRange(Blocked,false);
        _ShipmentType.SetRange(Name,pShipmentText);
        if _ShipmentType.FindFirst then
          exit(_ShipmentType.Code);

        _ShipmentType.SetCurrentKey(Name);

        _ShipmentTypeWithoutQuote := ConvertStr(pShipmentText,'''','?');
        _ShipmentType.SetFilter(Name,'''@' + _ShipmentTypeWithoutQuote + '''');
        if _ShipmentType.FindFirst then
          exit(_ShipmentType.Code);
        _ShipmentType.SetRange(Name);

        _ShipmentTypeFilterFromStart := '''@' + _ShipmentTypeWithoutQuote + '*''';

        _ShipmentType.FilterGroup := -1;
        _ShipmentType.SetFilter(Code,_ShipmentTypeFilterFromStart);
        _ShipmentType.SetFilter(Name,_ShipmentTypeFilterFromStart);

        if _ShipmentType.FindFirst then
          exit(_ShipmentType.Code);

        _ShipmentTypeFilterContains := '''@*' + _ShipmentTypeWithoutQuote + '*''';

        _ShipmentType.SetFilter(Code,_ShipmentTypeFilterContains);
        _ShipmentType.SetFilter(Name,_ShipmentTypeFilterContains);

        if _ShipmentType.Count = 1 then begin
          _ShipmentType.FindFirst;
          exit(_ShipmentType.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_ShipmentType.TableCaption);

        Error(MSG001,_ShipmentType.TableCaption);
    end;
}

