table 50082 "DK_Payment Method"
{
    // #DK36: 20211016
    //   - Add Field: "PG Code"

    Caption = 'Payment Method';
    DataCaptionFields = "Code",Name;
    DrillDownPageID = "DK_Payment Method";
    LookupPageID = "DK_Payment Method";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin

                if (xRec.Name <> Name) and (Name <> '') then
                  _ChangeMasterName.UpdatePaymentMethod(Code,Name,xRec.Name);
            end;
        }
        field(3;Blocked;Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(4;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Online Card,Card,Giro';
            OptionMembers = Online,Card,Giro;
        }
        field(100;"PG Code";Text[20])
        {
            Caption = 'PG Code';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Type,"Code")
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
        _PayReceiptDoc: Record "DK_Payment Receipt Document";
    begin

        _PayReceiptDoc.Reset;
        _PayReceiptDoc.SetRange("Payment Method Code",Code);
        if not _PayReceiptDoc.IsEmpty then
          Error(MSG001, TableCaption, Code, _PayReceiptDoc.TableCaption);
    end;

    trigger OnInsert()
    begin
        TestField(Code);
        TestField(Name);
    end;

    trigger OnModify()
    begin
        TestField(Code);
        TestField(Name);
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'The %2 %1 is in use by its %3 and can not be deleted.';
        MSG002: Label 'You must select an existing %1.';

    procedure GetCode(pType: Option;pPaymentMothedText: Text): Text
    begin
        exit(GetCodeOpenCard(pType, pPaymentMothedText));
    end;

    procedure GetCodeOpenCard(pType: Option;pPaymentMothedText: Text): Code[20]
    var
        _PaymentMothed: Record "DK_Payment Method";
        _Code: Code[20];
        _NoFiltersApplied: Boolean;
        _WithoutQuote: Text;
        _FilterFromStart: Text;
        _FilterContains: Text;
    begin
        if pPaymentMothedText = '' then
          exit('');

        if StrLen(pPaymentMothedText) <= MaxStrLen(_PaymentMothed.Code) then
          if _PaymentMothed.Get(pType, CopyStr(pPaymentMothedText,1,MaxStrLen(_PaymentMothed.Code))) then
            exit(_PaymentMothed.Code);

        _PaymentMothed.SetRange(Type, pType);
        _PaymentMothed.SetRange(Blocked,false);
        _PaymentMothed.SetRange(Name,pPaymentMothedText);
        if _PaymentMothed.FindFirst then
          exit(_PaymentMothed.Code);

        _PaymentMothed.SetCurrentKey(Name);

        _WithoutQuote := ConvertStr(pPaymentMothedText,'''','?');
        _PaymentMothed.SetFilter(Name,'''@' + _WithoutQuote + '''');
        if _PaymentMothed.FindFirst then
          exit(_PaymentMothed.Code);
        _PaymentMothed.SetRange(Name);

        _FilterFromStart := '''@' + _WithoutQuote + '*''';

        _PaymentMothed.FilterGroup := -1;
        _PaymentMothed.SetFilter(Code,_FilterFromStart);
        _PaymentMothed.SetFilter(Name,_FilterFromStart);

        if _PaymentMothed.FindFirst then
          exit(_PaymentMothed.Code);

        _FilterContains := '''@*' + _WithoutQuote + '*''';

        _PaymentMothed.SetFilter(Code,_FilterContains);
        _PaymentMothed.SetFilter(Name,_FilterContains);

        if _PaymentMothed.Count = 1 then begin
          _PaymentMothed.FindFirst;
          exit(_PaymentMothed.Code);
        end;

        if not GuiAllowed then
          Error(MSG002,_PaymentMothed.TableCaption);

        Error(MSG002,_PaymentMothed.TableCaption);
    end;
}

