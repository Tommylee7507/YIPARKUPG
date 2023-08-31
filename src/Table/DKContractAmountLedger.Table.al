table 50070 "DK_Contract Amount Ledger"
{
    Caption = 'Contract Amount Ledger';
    DataCaptionFields = "Contract No.",Type,"Ledger Type";
    DrillDownPageID = "DK_Contract Amount Ledger";
    LookupPageID = "DK_Contract Amount Ledger";

    fields
    {
        field(1;"Contract No.";Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Deposit,Contract Amount,Remaining Amount,Service,Refund';
            OptionMembers = Deposit,Contract,Remaining,Service,Refund;
        }
        field(4;"Ledger Type";Option)
        {
            Caption = 'Ledger Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'AR,Receipt';
            OptionMembers = AR,Receipt,Refund;
        }
        field(5;Date;Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(6;Amount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7;"Source No.";Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Payment Receipt Document"."Document No.";
        }
        field(8;"Source Line No.";Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(9;"Service No.";Code[20])
        {
            Caption = 'Service No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF (Type=CONST(Service)) "DK_Cemetery Services"."No.";

            trigger OnValidate()
            begin
                if xRec."Service No." <> "Service No." then begin

                  _CemServices.Reset;
                  _CemServices.SetRange("No.","Service No.");
                  if _CemServices.FindSet then begin
                    "Field Work Main Cat. Code" := _CemServices."Field Work Main Cat. Code";
                    "Field Work Main Cat. Name" := _CemServices."Field Work Main Cat. Name";
                    "Field Work Sub Cat. Code" := _CemServices."Field Work Sub Cat. Code";
                    "Field Work Sub Cat. Name" := _CemServices."Field Work Sub Cat. Name";
                  end;
                end;
            end;
        }
        field(10;"Document DateTime";DateTime)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Document Datetime" WHERE ("Document No."=FIELD("Source No.")));
            Caption = 'Document DateTime';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;"Field Work Main Cat. Code";Code[20])
        {
            Caption = 'Field Work Main Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Field Work Main Category".Code WHERE (Blocked=CONST(false),
                                                                      "Cemetery Services"=CONST(true));

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
            end;
        }
        field(12;"Field Work Main Cat. Name";Text[30])
        {
            Caption = 'Field Work Main Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Field Work Main Category".Code WHERE (Blocked=CONST(false),
                                                                      "Cemetery Services"=CONST(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
            end;
        }
        field(13;"Field Work Sub Cat. Code";Code[20])
        {
            Caption = 'Field Work Sub Cat. Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Field Work Sub Category".Code WHERE ("Field Work Main Cat. Code"=FIELD("Field Work Main Cat. Code"),
                                                                     Blocked=CONST(false));

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
            end;
        }
        field(14;"Field Work Sub Cat. Name";Text[30])
        {
            Caption = 'Field Work Sub Cat. Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DK_Field Work Sub Category".Code WHERE ("Field Work Main Cat. Code"=FIELD("Field Work Main Cat. Code"),
                                                                     Blocked=CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _FieldWorkSubCategory: Record "DK_Field Work Sub Category";
            begin
            end;
        }
        field(15;"Payment Type";Option)
        {
            Caption = 'Payment Type';
            OptionCaption = ' ,Bank Transfer,Credit Card,Cash,Giro,Onlie Credit Card,Virtual Account,Debt Relief';
            OptionMembers = "None",Bank,Card,Cash,Giro,OnlineCard,VirtualAccount,DebtRelief;
        }
        field(16;"Posting Date";Date)
        {
            CalcFormula = Lookup("DK_Payment Receipt Document"."Posting Date" WHERE ("Document No."=FIELD("Source No.")));
            Caption = 'Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17;"Cemetery No.";Text[30])
        {
            CalcFormula = Lookup(DK_Contract."Cemetery No." WHERE ("No."=FIELD("Contract No.")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18;Cancel;Boolean)
        {
            Caption = 'Cancel';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5000;"Creation Date";DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Contract No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;Type)
        {
        }
        key(Key3;"Ledger Type")
        {
        }
        key(Key4;Date)
        {
        }
        key(Key5;"Contract No.",Date)
        {
        }
        key(Key6;Date,"Ledger Type",Type,"Field Work Main Cat. Code","Payment Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _PaymentReceiptPost: Codeunit "DK_Payment Receipt - Post";
    begin
    end;

    trigger OnInsert()
    begin
        "Creation Date" := CurrentDateTime;
    end;

    var
        _CemServices: Record "DK_Cemetery Services";

    local procedure UpdateContract(pDel: Boolean)
    var
        _ContAmtLedger: Record "DK_Contract Amount Ledger";
        _Contract: Record DK_Contract;
        _TotalAmount: Decimal;
    begin

        if Rec."Ledger Type" <> Rec."Ledger Type"::Receipt then exit;

        if _Contract.Get(Rec."Contract No.") then begin

          _ContAmtLedger.Reset;
          _ContAmtLedger.SetCurrentKey("Contract No.",Date);
          _ContAmtLedger.SetRange("Contract No.", Rec."Contract No.");
          _ContAmtLedger.SetRange("Ledger Type", _ContAmtLedger."Ledger Type"::Receipt);
          _ContAmtLedger.SetRange(Type, Rec.Type);
          _ContAmtLedger.SetFilter("Line No.", '<>%1',Rec."Line No.");
          if _ContAmtLedger.FindLast then begin
              _ContAmtLedger.CalcSums(Amount);

             case Rec.Type of
                Rec.Type::Deposit:begin
                  _Contract."Deposit Receipt Date" := _ContAmtLedger.Date;
                  _Contract.Validate("Deposit Amount", _ContAmtLedger.Amount);
                    if not pDel then
                      _Contract.Validate("Deposit Amount", _Contract."Deposit Amount"+ Rec.Amount);
                end;
                Rec.Type::Contract:begin
                  _Contract."Pay. Contract Rece. Date" := _ContAmtLedger.Date;
                  _Contract.Validate("Deposit Amount");
                end;
                Rec.Type::Remaining:begin
                  _Contract.Validate("Deposit Amount");
                end;
              end;

              _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - (_ContAmtLedger.Amount + Rec.Amount));
          end else begin
              //Delete
              case Rec.Type of
                Rec.Type::Deposit:begin
                  if not pDel then begin
                    _Contract."Deposit Receipt Date" := Rec.Date;
                    _Contract.Validate("Deposit Amount", Rec.Amount);
                  end else begin
                    _Contract."Deposit Receipt Date" := 0D;
                    _Contract.Validate("Deposit Amount", 0);
                  end;
                end;
                Rec.Type::Contract:begin
                  if not pDel then begin
                    _Contract."Pay. Contract Rece. Date" := Rec.Date;
                  end else begin
                    _Contract."Pay. Contract Rece. Date" := 0D;
                    _Contract.Validate("Deposit Amount");
                  end;
                end;
                Rec.Type::Remaining:begin
                  _Contract.Validate("Deposit Amount");
                end;
              end;

              _Contract.Validate("Pay. Remaining Amount", _Contract."Payment Amount" - _ContAmtLedger.Amount);
          end;
          _Contract.Modify(true);
        end;
    end;
}

