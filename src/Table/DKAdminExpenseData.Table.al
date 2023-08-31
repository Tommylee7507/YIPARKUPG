table 50064 "DK_Admin. Expense Data"
{
    Caption = 'Admin. Expense Data';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Year Contract Starting Date"; Date)
        {
            Caption = 'Year Contract Starting Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcYearContractPeriod;
            end;
        }
        field(3; "Year Contract Ending Date"; Date)
        {
            Caption = 'Year Contract Ending Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcYearContractPeriod;

                if "Year Contract Ending Date" = "Admin. Expense Ending Date" then
                    "Include Diff. Amount" := true
                else
                    "Include Diff. Amount" := false;
            end;
        }
        field(4; "Admin. Expense Starting Date"; Date)
        {
            Caption = 'Admin. Expense Starting Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcAdminExpensePeriod;
            end;
        }
        field(5; "Admin. Expense Ending Date"; Date)
        {
            Caption = 'Admin. Expense Ending Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcAdminExpensePeriod;

                if "Year Contract Ending Date" = "Admin. Expense Ending Date" then
                    "Include Diff. Amount" := true
                else
                    "Include Diff. Amount" := false;
            end;
        }
        field(6; "Year Admin. Expense Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Year Admin. Expense Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcYearAdminExpenseAmount;
            end;
        }
        field(7; "Contract Size"; Decimal)
        {
            Caption = 'Contract Size';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(8; "Year Admin. Expense Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Year Admin. Expense Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcYearAdminExpenseAmount;
            end;
        }
        field(9; "Year Days"; Decimal)
        {
            Caption = 'Year Days';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(10; "Daily Admin. Expense Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Daily Admin. Expense Amount';
            DataClassification = ToBeClassified;
        }
        field(11; "Diff. Admin. Expense Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Diff. Admin. Expense Amount';
            DataClassification = ToBeClassified;
        }
        field(12; "Admin. Expense Period"; Decimal)
        {
            Caption = 'Admin. Expense Period';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(13; "Include Diff. Amount"; Boolean)
        {
            Caption = 'Include Diff. Amount';
            DataClassification = ToBeClassified;
        }
        field(14; "Pay. Admin. Expense Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Payment Admin. Expense Amount';
            DataClassification = ToBeClassified;
        }
        field(15; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = ToBeClassified;
        }
        field(16; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(17; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Admin. Expense Type"; Option)
        {
            Caption = 'Admin. Expense  Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Landscape Architecture';
            OptionMembers = General,Landscape;
        }
        field(20; "Non-Payment"; Boolean)
        {
            Caption = 'Non-Payment';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Source No.", "Source Line No.", "Admin. Expense Type", "Non-Payment", "Line No.", "Year Contract Starting Date", "Year Contract Ending Date", "Admin. Expense Starting Date", "Admin. Expense Ending Date")
        {
            Clustered = true;
        }
        key(Key2; "Year Contract Starting Date", "Year Contract Ending Date")
        {
        }
        key(Key3; "Admin. Expense Starting Date", "Admin. Expense Ending Date")
        {
        }
        key(Key4; "Contract Date")
        {
        }
        key(Key5; "Contract No.", "Source No.", "Source Line No.", "Admin. Expense Type")
        {
        }
        key(Key6; "Source No.", "Source Line No.", "Non-Payment")
        {
        }
    }

    fieldgroups
    {
    }

    local procedure CalcYearContractPeriod()
    begin
        if ("Year Contract Starting Date" <> 0D) and ("Year Contract Ending Date" <> 0D) then
            "Year Days" := "Year Contract Ending Date" - "Year Contract Starting Date" + 1
        else
            "Year Days" := 0;
    end;

    local procedure CalcAdminExpensePeriod()
    begin
        if ("Admin. Expense Starting Date" <> 0D) and ("Admin. Expense Ending Date" <> 0D) then
            "Admin. Expense Period" := "Admin. Expense Ending Date" - "Admin. Expense Starting Date" + 1
        else
            "Admin. Expense Period" := 0;
    end;

    local procedure CalcYearAdminExpenseAmount()
    begin

        "Year Admin. Expense Amount" := "Year Admin. Expense Price" * "Contract Size";
    end;


    procedure CalcAdminExpenseAmount()
    begin

        //Ÿ ýˆ«Š±(‰¦“ˆ)
        if "Year Days" <> 0 then
            "Daily Admin. Expense Amt" := Round("Year Admin. Expense Amount" / "Year Days", 1, '=');

        //Ÿýˆ«Š± ’ðŽ¸
        "Diff. Admin. Expense Amt" := "Year Admin. Expense Amount" - ("Daily Admin. Expense Amt" * "Year Days");

        //ýˆ«Š± “‹€ˆ €¦Ž¸
        "Pay. Admin. Expense Amt" := ("Daily Admin. Expense Amt" * "Admin. Expense Period");

        //¼ ÐŽÊ ‘Ž‡ßŸí ’ðŽ¸Š¨ ‰¦…!
        if "Include Diff. Amount" then
            "Pay. Admin. Expense Amt" += "Diff. Admin. Expense Amt";
    end;
}

