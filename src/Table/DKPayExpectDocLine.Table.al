table 50112 "DK_Pay. Expect Doc. Line"
{
    // *DK32 : 20200715
    //   - Modify Function : Payment Target - OnValidate()

    Caption = 'Payment Expect Docment Line';

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
        }
        field(3; "Payment Target"; Option)
        {
            Caption = 'Payment Target';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Deposit,Contract Amount,Remaining Amount,General,Landscape Architecturee,Service';
            OptionMembers = Blank,Deposit,Contract,Remaining,General,Landscape,Service;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _PayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
                _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
            begin
                if xRec."Payment Target" <> "Payment Target" then begin
                    CalcFields("Contract No.");

                    if "Contract No." = '' then
                        Error(MSG004, FieldCaption("Contract No."));

                    Validate("Cem. Services No.", '');
                    "Start Date" := 0D;
                    "Expiration Date" := 0D;
                    Amount := 0;
                    "Year Price" := 0;
                    "Add. Years" := 0;

                    if "Payment Target" in ["Payment Target"::General, "Payment Target"::Landscape] then begin

                        _Contract.Get("Contract No.");
                        _Contract.CalcFields("Admin. Expense Method");//DK32
                        _PayExpectDocHeader.Get("Document No.");//DK32
                        _PayExpectDocHeader.TestField("Document Date");//DK32

                        //>>DK32
                        if "Payment Target" = "Payment Target"::General then begin
                            if _Contract."General Expiration Date" = 0D then begin
                                if _Contract."Admin. Exp. Start Date" <> 0D then
                                    "Start Date" := _Contract."Admin. Exp. Start Date";
                            end else
                                "Start Date" := _Contract."General Expiration Date" + 1;
                        end else begin
                            _Contract.CalcFields("Landscape Architecture");
                            if not _Contract."Landscape Architecture" then
                                Error(MSG012);

                            if _Contract."Land. Arc. Expiration Date" = 0D then begin
                                if _Contract."Admin. Exp. Start Date" <> 0D then
                                    "Start Date" := _Contract."Admin. Exp. Start Date";
                            end else
                                "Start Date" := _Contract."Land. Arc. Expiration Date" + 1;
                        end;
                        //<<DK32
                    end;
                end;
            end;
        }
        field(4; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Diff: Decimal;
                _LineTotal: Decimal;
                _CemeteryServices: Record "DK_Cemetery Services";
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _Contract: Record DK_Contract;
                _AdminExpenseType: Option;
                _ResultApplyAmount: Decimal;
                _ResultDiffAmount: Decimal;
            begin
                if xRec.Amount <> Amount then begin
                    if Amount <> 0 then begin

                        CalcFields("Contract No.");

                        case "Payment Target" of
                            "Payment Target"::Blank,
                            "Payment Target"::Service:
                                begin
                                    Error(MSG006, FieldCaption("Payment Target"), "Payment Target"::Blank);
                                end;
                            "Payment Target"::General,
                            "Payment Target"::Landscape:
                                begin

                                    CalcFields("Contract No.");
                                    if _Contract.Get("Contract No.") then begin

                                        //>>DK32
                                        if "Payment Target" = "Payment Target"::General then begin
                                            if _Contract."General Expiration Date" = 0D then begin
                                                if _Contract."Admin. Exp. Start Date" <> 0D then
                                                    "Start Date" := _Contract."Admin. Exp. Start Date";
                                            end else
                                                "Start Date" := _Contract."General Expiration Date" + 1;

                                            _AdminExpenseType := 0;
                                        end else begin
                                            _Contract.CalcFields("Landscape Architecture");
                                            if not _Contract."Landscape Architecture" then
                                                Error(MSG012);

                                            if _Contract."Land. Arc. Expiration Date" = 0D then begin
                                                if _Contract."Admin. Exp. Start Date" <> 0D then
                                                    "Start Date" := _Contract."Admin. Exp. Start Date";
                                            end else
                                                "Start Date" := _Contract."Land. Arc. Expiration Date" + 1;

                                            _AdminExpenseType := 1;
                                        end;
                                        //<<DK32


                                        if "Start Date" <> 0D then begin
                                            "Expiration Date" := _AdminExpenseMgt.GetCalcAdminExpenseEndingDateForAmount("Contract No.", _AdminExpenseType, Amount, "Period Amount", "Diff. Amount", 0D, false);
                                            "Befor Expiration Date" := "Expiration Date";
                                        end;
                                    end;
                                end;
                            else begin
                                _Contract.Get("Contract No.");
                                if Amount > _Contract."Pay. Remaining Amount" then
                                    Error(MSG008, _Contract.TableCaption, _Contract.FieldCaption("Pay. Remaining Amount"), _Contract."Pay. Remaining Amount");
                            end;
                        end;
                    end else begin
                        if "Payment Target" in ["Payment Target"::General, "Payment Target"::Landscape] then begin
                            "Expiration Date" := 0D;
                            //>>DK32
                            "Period Amount" := 0;
                            "Diff. Amount" := 0;
                            //<<DK32
                        end;
                    end;
                end;
            end;
        }
        field(5; "Cem. Services No."; Code[20])
        {
            Caption = 'Cem. Services No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payment Target" = CONST(Service)) "DK_Cemetery Services"."No." WHERE("Contract No." = FIELD("Contract No."),
                                                                                                     Status = CONST(Release),
                                                                                                     "Receipt Amount Date" = FILTER(0D),
                                                                                                     "Pay. Expect Doc. No." = CONST(''));

            trigger OnValidate()
            var
                _CemeteryServices: Record "DK_Cemetery Services";
            begin
                if "Cem. Services No." <> xRec."Cem. Services No." then begin

                    if "Cem. Services No." <> '' then begin
                        if "Payment Target" <> "Payment Target"::Service then
                            Error(MSG002, FieldCaption("Payment Target"), "Payment Target"::Service);

                        if _CemeteryServices.Get("Cem. Services No.") then
                            Validate(Amount, _CemeteryServices.Amount - _CemeteryServices."Receipt Amount");

                    end else begin
                        Validate(Amount, 0);
                    end;

                    CalcFields("Field Work Main Cat. Name", "Field Work Sub Cat. Name");
                end;
            end;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Start Date" <> "Start Date" then begin
                    if "Start Date" <> 0D then
                        if not ("Payment Target" in ["Payment Target"::General, "Payment Target"::Landscape]) then
                            Error(MSG001, FieldCaption("Payment Target"), "Payment Target"::General, "Payment Target"::Landscape);
                end;
            end;
        }
        field(7; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseType: Option;
            begin
                if xRec."Expiration Date" <> "Expiration Date" then begin
                    if "Expiration Date" <> 0D then begin
                        if not ("Payment Target" in ["Payment Target"::General, "Payment Target"::Landscape]) then
                            Error(MSG001, FieldCaption("Payment Target"), "Payment Target"::General, "Payment Target"::Landscape);


                        case "Payment Target" of
                            "Payment Target"::General, "Payment Target"::Landscape:
                                begin
                                    if "Payment Target" = "Payment Target"::General then begin
                                        _AdminExpenseType := 0;
                                    end else begin
                                        _AdminExpenseType := 1;
                                    end;
                                    CalcFields("Contract No.");
                                    Validate("Period Amount", _AdminExpenseMgt.GetCalcAdminExpenseAmountForEndingDate("Contract No.", _AdminExpenseType, "Expiration Date", 0D, false));
                                end;
                        end;
                    end else begin
                        Amount := 0;
                    end;

                end;
            end;
        }
        field(9; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Add. Years"; Integer)
        {
            Caption = 'Add. Years';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                /*
                IF xRec."Add. Years" <> "Add. Years" THEN BEGIN
                  IF "Add. Years" <> 0 THEN BEGIN
                    IF NOT ("Payment Target" IN ["Payment Target"::General,"Payment Target"::Landscape]) THEN
                      ERROR(MSG007, FIELDCAPTION("Payment Target"), "Payment Target"::General,"Payment Target"::Landscape);
                
                    "Expiration Date" := CALCDATE(STRSUBSTNO('<+%1Y>',"Add. Years"), "Start Date")-1;
                  END ELSE BEGIN
                    "Expiration Date" := 0D;
                  END;
                
                  Amount := "Year Price" * "Add. Years";
                END;
                */

            end;
        }
        field(12; "Contract No."; Code[20])
        {
            CalcFormula = Lookup("DK_Pay. Expect Doc. Header"."Contract No." WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Contract No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Year Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Year Price';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."Year Price" <> "Year Price" then
                    Amount := "Year Price" * "Add. Years";
            end;
        }
        field(15; "Field Work Main Cat. Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Cemetery Services"."Field Work Main Cat. Name" WHERE("No." = FIELD("Cem. Services No.")));
            Caption = 'Field Work Main Cat. Name';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                _FieldWorkMainCategory: Record "DK_Field Work Main Category";
            begin
            end;
        }
        field(16; "Field Work Sub Cat. Name"; Text[30])
        {
            CalcFormula = Lookup("DK_Cemetery Services"."Field Work Sub Cat. Name" WHERE("No." = FIELD("Cem. Services No.")));
            Caption = 'Field Work Sub Cat. Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Period Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount in Period';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Diff. Amount" := Amount - "Period Amount";
            end;
        }
        field(18; "Diff. Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Diff. Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Befor Expiration Date"; Date)
        {
            Caption = 'Befor Expiration Date';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                _AdminExpenseType: Option;
            begin
            end;
        }
        field(20; "UnAssgin Date"; Date)
        {
            CalcFormula = Lookup("DK_Pay. Expect Doc. Header"."UnAssgin Date" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'UnAssgin Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Assgin Date"; Date)
        {
            CalcFormula = Lookup("DK_Pay. Expect Doc. Header"."Assgin Date" WHERE("Document No." = FIELD("Document No.")));
            Caption = 'Assgin Date';
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
        key(Key2; "Payment Target")
        {
        }
        key(Key3; "Start Date")
        {
        }
        key(Key4; "Expiration Date")
        {
        }
        key(Key5; "Cem. Services No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckHeader;
        CheckLine;
    end;

    trigger OnInsert()
    begin
        CheckHeader;
    end;

    trigger OnModify()
    begin
        CheckHeader;
        CheckLine;
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        MSG001: Label 'You cannot specify a value. Can be specified only if %1 is %2 or %3.';
        MSG002: Label 'You cannot specify a value. Can be specified only if %1 is %2.';
        MSG003: Label 'cannot modify or delete this line.';
        MSG004: Label 'The %1 is not specified.';
        MSG005: Label 'Cemeteries covered by this contract are not included in the %1.';
        MSG006: Label 'If the %1 is %2, you cannot specify a value.';
        MSG007: Label 'You can specify a value only if the %1 is a %2 or %3.';
        MSG008: Label 'You cannot specify an amount greater than %2 %3 in %1.';
        MSG009: Label 'The value exists in %1.';
        MSG012: Label 'You cannot select it.';

    local procedure CheckHeader()
    var
        _PayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
    begin

        _PayExpectDocHeader.Get("Document No.");
        _PayExpectDocHeader.CheckDocument;

        if _PayExpectDocHeader."UnAssgin Date" <> 0D then
            Error(MSG009, _PayExpectDocHeader.FieldCaption("UnAssgin Date"), _PayExpectDocHeader."UnAssgin Date");

        if _PayExpectDocHeader."Assgin Date" <> 0D then
            Error(MSG009, _PayExpectDocHeader.FieldCaption("Assgin Date"), _PayExpectDocHeader."Assgin Date");

        if _PayExpectDocHeader."Pay. Receipt Doc. No." <> '' then
            Error(MSG009, _PayExpectDocHeader.FieldCaption("Pay. Receipt Doc. No."), _PayExpectDocHeader."Pay. Receipt Doc. No.");
    end;

    local procedure CheckLine()
    begin

        if "Source No." <> '' then
            Error(MSG003, FieldCaption("Source No."), "Source No.");
    end;

    procedure CalcTotalAmount(var PayExpectDocLine: Record "DK_Pay. Expect Doc. Line"; LastPayExpectDocLine: Record "DK_Pay. Expect Doc. Line"; var TotalAmount: Decimal)
    var
        TempPayExpectDocLine: Record "DK_Pay. Expect Doc. Line";
    begin
        TempPayExpectDocLine.CopyFilters(PayExpectDocLine);

        TempPayExpectDocLine.SetRange("Document No.", PayExpectDocLine."Document No.");
        TempPayExpectDocLine.CalcSums(Amount);

        TotalAmount := TempPayExpectDocLine.Amount;
    end;
}

