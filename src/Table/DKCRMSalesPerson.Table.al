table 50039 "DK_CRM SalesPerson"
{
    Caption = 'CRM SalesPerson';
    DrillDownPageID = "DK_CRM SalesPerson";
    LookupPageID = "DK_CRM SalesPerson";

    fields
    {
        field(1;"Code";Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001;"Creation Person";Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
        key(Key2;Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Name)
        {
        }
    }

    trigger OnDelete()
    var
        _Contract: Record DK_Contract;
    begin

        _Contract.Reset;
        _Contract.SetRange("CRM SalesPerson Code", Code);
        if not _Contract.IsEmpty then
          Error(MSG002, TableCaption, Code, _Contract.TableCaption);
    end;

    trigger OnInsert()
    begin
        TestField(Code);
        TestField(Name);

        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Name);
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        MSG001: Label 'You must select an existing %1.';
        MSG002: Label 'The %2 %1 is in use by its %3 and can not be deleted.';

    procedure GetSalesPersonCode(pSalePersonText: Text): Text
    begin
        exit(GetSalesPersonCodeOpenCard(pSalePersonText));
    end;

    procedure GetSalesPersonCodeOpenCard(pSalePersonText: Text): Code[20]
    var
        _SalesPerson: Record "DK_CRM SalesPerson";
        _SalesPersonWithoutQuote: Text;
        _SalesPersonFilterFromStart: Text;
        _SalesPersonFilterContains: Text;
    begin
        if pSalePersonText = '' then
          exit('');

        if StrLen(pSalePersonText) <= MaxStrLen(_SalesPerson.Code) then
          if _SalesPerson.Get(CopyStr(pSalePersonText,1,MaxStrLen(_SalesPerson.Code))) then
            exit(_SalesPerson.Code);

        _SalesPerson.SetRange(Blocked,false);
        _SalesPerson.SetRange(Name,pSalePersonText);
        if _SalesPerson.FindFirst then
          exit(_SalesPerson.Code);

        _SalesPerson.SetCurrentKey(Name);

        _SalesPersonWithoutQuote := ConvertStr(pSalePersonText,'''','?');
        _SalesPerson.SetFilter(Name,'''@' + _SalesPersonWithoutQuote + '''');
        if _SalesPerson.FindFirst then
          exit(_SalesPerson.Code);
        _SalesPerson.SetRange(Name);

        _SalesPersonFilterFromStart := '''@' + _SalesPersonWithoutQuote + '*''';

        _SalesPerson.FilterGroup := -1;
        _SalesPerson.SetFilter(Code,_SalesPersonFilterFromStart);
        _SalesPerson.SetFilter(Name,_SalesPersonFilterFromStart);

        if _SalesPerson.FindFirst then
          exit(_SalesPerson.Code);

        _SalesPersonFilterContains := '''@*' + _SalesPersonWithoutQuote + '*''';

        _SalesPerson.SetFilter(Code,_SalesPersonFilterContains);
        _SalesPerson.SetFilter(Name,_SalesPersonFilterContains);
        //_SalesPerson.SETFILTER("VAT Registration No.",_SalesPersonFilterContains);
        //_SalesPerson.SETFILTER("Phone No.",_SalesPersonFilterContains);
        //_SalesPerson.SETFILTER("E-mail",_SalesPersonFilterContains);

        if _SalesPerson.Count = 1 then begin
          _SalesPerson.FindFirst;
          exit(_SalesPerson.Code);
        end;

        if not GuiAllowed then
          Error(MSG001,_SalesPerson.TableCaption);

        Error(MSG001,_SalesPerson.TableCaption);
    end;
}

