report 50023 "DK_Address Label"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKAddressLabel.rdl';
    Caption = 'Address Label';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "DK_Report Buffer")
        {
            DataItemTableView = SORTING("USER ID", "OBJECT ID", "Entry No.");
            column(FirstAddress; TEXT0)
            {
            }
            column(FirstAdderss2; TEXT1)
            {
            }
            column(FirstPosdCode; TEXT2)
            {
            }
            column(FirstCustName; TEXT3)
            {
            }
            column(SecondAddress; TEXT4)
            {
            }
            column(SecondAddress2; TEXT5)
            {
            }
            column(SecondPostCode; TEXT6)
            {
            }
            column(SecondCustName; TEXT7)
            {
            }

            trigger OnAfterGetRecord()
            var
                _Contract: Record DK_Contract;
                _AddressNo: Integer;
                _First: Boolean;
            begin
            end;

            trigger OnPreDataItem()
            var
                _Contract: Record DK_Contract;
                _AddressNo: Integer;
                _First: Boolean;
            begin
                Header.SetRange("USER ID", UserId);
                Header.SetRange("OBJECT ID", REPORT::"DK_Address Label");
                if Header.FindSet then
                    Header.DeleteAll;

                _AddressNo := 1;

                _Contract.Reset;
                _Contract.SetRange("User ID Filter", UserId);
                _Contract.SetRange("Selected Contract", true);
                if _Contract.FindSet then begin
                    _First := true;
                    repeat
                        _Contract.CalcFields("Cust. Address", "Cust. Address 2", "Cust. Post Code");

                        if _First = true then begin
                            Header.Init;
                            Header."USER ID" := UserId;
                            Header."OBJECT ID" := REPORT::"DK_Address Label";
                            Header."Entry No." := _AddressNo;
                            Header.TEXT0 := _Contract."Cust. Address";
                            Header.TEXT1 := _Contract."Cust. Address 2";
                            if _Contract."Cust. Post Code" <> '' then
                                Header.TEXT2 := StrSubstNo(PostCodeText, _Contract."Cust. Post Code");
                            if _Contract."Main Customer Name" <> '' then
                                Header.TEXT3 := StrSubstNo(CustNameText, _Contract."Main Customer Name");
                            Header.Insert;
                            _AddressNo += 1;
                            _First := false;
                        end else begin
                            Header.TEXT4 := _Contract."Cust. Address";
                            Header.TEXT5 := _Contract."Cust. Address 2";
                            if _Contract."Cust. Post Code" <> '' then
                                Header.TEXT6 := StrSubstNo(PostCodeText, _Contract."Cust. Post Code");
                            if _Contract."Main Customer Name" <> '' then
                                Header.TEXT7 := StrSubstNo(CustNameText, _Contract."Main Customer Name");
                            Header.Modify;

                            _First := true;
                        end;
                    until _Contract.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CustNameText: Label '%1';
        PostCodeText: Label 'Post %1';
}

