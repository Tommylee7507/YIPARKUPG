report 50030 "DK_Cemetry Ledger N"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/DKCemetryLedgerN.rdl';
    Caption = 'Cemetry Ledger N';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; DK_Contract)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Header_No; Header."No.")
            {
            }
            column(Header_SuperviseNo; Header."Supervise No.")
            {
            }
            column(H_ContractDate; Header."Contract Date")
            {
            }
            column(H_CemeteryNo; Header."Cemetery No.")
            {
            }
            column(H_CemeterySize; Header."Cemetery Size")
            {
            }
            column(H_MainCustName; Header."Main Customer Name")
            {
            }
            column(H_CustName2; Header."Customer Name 2")
            {
            }
            column(H_CustName3; Header."Customer Name 3")
            {
            }
            column(H_MainRegNo; RecCust01.GetSSNSSNCalculated)
            {
            }
            column(H_MainRegNo2; RecCust02.GetSSNSSNCalculated)
            {
            }
            column(H_MainRegNo3; RecCust03.GetSSNSSNCalculated)
            {
            }
            column(H_Address1; RecCust01.Address + ' ' + RecCust01."Address 2" + ' ' + RecCust01."Post Code")
            {
            }
            column(H_Address2; RecCust02.Address + ' ' + RecCust02."Address 2" + ' ' + RecCust02."Post Code")
            {
            }
            column(H_Address3; RecCust03.Address + ' ' + RecCust03."Address 2" + ' ' + RecCust03."Post Code")
            {
            }
            column(H_PhoneNo1; RecCust01."Phone No.")
            {
            }
            column(H_PhoneNo2; RecCust02."Phone No.")
            {
            }
            column(H_PhoneNo3; RecCust03."Phone No.")
            {
            }
            column(H_Email1; RecCust01."E-mail")
            {
            }
            column(H_Email2; RecCust02."E-mail")
            {
            }
            column(H_Email3; RecCust03."E-mail")
            {
            }
            column(H_Mobile1; RecCust01."Mobile No.")
            {
            }
            column(H_Mobile2; RecCust02."Mobile No.")
            {
            }
            column(H_Mobile3; RecCust03."Mobile No.")
            {
            }
            column(H_MainBirthday; RecCust01.Birthday)
            {
            }
            column(H_MainGender; Format(RecCust01.Gender))
            {
            }
            column(H_CemeteryDigName; Header."Cemetery Dig. Name")
            {
            }
            column(H_Cust2_Bdate_Gender; Cust2_Bdate_Gender)
            {
            }
            column(H_Cus3_Bdate_Gender; Cust3_Bdate_Gender)
            {
            }
            dataitem(Corpse; DK_Corpse)
            {
                DataItemLink = "Contract No." = FIELD("No.");
                DataItemTableView = SORTING("Contract No.", "Line No.") ORDER(Ascending);
                column(Cor_1; '1')
                {
                }
                column(Cor_CemeteryNo; Corpse."Cemetery No.")
                {
                }
                column(Cor_Name; Corpse.Name)
                {
                }
                column(Cor_RegNo; Corpse."Social Security No.")
                {
                }
                column(Cor_LayingDate; Corpse."Laying Date")
                {
                }
                column(Cor_DeathDate; Corpse."Death Date")
                {
                }
                column(Cor_DeathCause; Corpse."Death Cause")
                {
                }
                column(Cor_Relationship; Corpse.Relationship)
                {
                }
                column(Cor_DearhPlace; Corpse."Death Place")
                {
                }
                column(Cor_SubName; "Field Work Sub Cat. Name")
                {
                }
                column(Cor_Location; Corpse.Location)
                {
                }
                column(Cor_BirthDay; Corpse."Date Of Birth")
                {
                }
                column(Cor_Gender; Corpse.Gender)
                {
                }
            }
            dataitem(Line; "DK_Payment Receipt Doc. Line")
            {
                DataItemLink = "Contract No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE("Payment Target" = FILTER(General | Landscape));
                UseTemporary = true;
                column(Line_2; '2')
                {
                }
                column(Line_PaymentTarget; Line."Payment Target")
                {
                }
                column(Line_PaymentDate; Line."Payment Date")
                {
                }
                column(Line_StartDate; Line."Start Date")
                {
                }
                column(Line_ExpDate; Line."Expiration Date")
                {
                }
                column(Line_Amount; Line.Amount)
                {
                }
                column(Line_PaymentType; Line."Payment Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                _SocialSecurityNo: Text[20];
                _Year: Integer;
                _Month: Integer;
                _Day: Integer;
                _Gender: Integer;
                _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
            begin

                Cust2_Bdate_Gender := '';
                Cust3_Bdate_Gender := '';

                if RecCust01.Get(Header."Main Customer No.") then
                    RegNo1 := RecCust01.GetSSNSSNCalculated;


                if RecCust02.Get(Header."Customer No. 2") then begin
                    RegNo2 := RecCust01.GetSSNSSNCalculated;
                    Cust2_Bdate_Gender := Format(RecCust02.Birthday, 10, '<Year4>-<Month,2>-<Day,2>') + '/' + Format(RecCust02.Gender);
                end else begin
                end;



                if RecCust03.Get(Header."Customer No. 3") then begin
                    RegNo3 := RecCust01.GetSSNSSNCalculated;
                    Cust3_Bdate_Gender := Format(RecCust02.Birthday, 10, '<Year4>-<Month,2>-<Day,2>') + '/' + Format(RecCust03.Gender);
                end else begin
                end;



                CreateLine;
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
        Reportlbl = 'Cemetry Ledger';
        Cap01bl = 'Cap-01bl';
        Cap02bl = 'Cap-02bl';
        Cap03bl = 'Cap-03bl';
        Cap04bl = 'Cap-04bl';
        Cap05bl = 'Cap-05bl';
        Cap06bl = 'Cap06bl';
        Cap07bl = 'Cap07bl';
        Cap08bl = 'Cap08bl';
        Cap09bl = 'Cap09bl';
        Cap101lbl = 'Cap1-01lbl';
        Cap102lbl = 'Cap1-02lbl';
        Cap103bl = 'Cap1-03bl';
        Cap104bl = 'Cap1-04bl';
        Cap105bl = 'Cap1-05bl';
        Cap106bl = 'Cap1-06bl';
        Cap107bl = 'Cap1-07bl';
        Cap201bl = 'Cap2-01bl';
        Cap202bl = 'Cap2-02bl';
        Cap203bl = 'Cap2-03bl';
        Cap204bl = 'Cap2-04bl';
        Cap205bl = 'Cap2-05bl';
        Cap206bl = 'Cap2-06bl';
        Cap207bl = 'Cap2-07bl';
        Cap208bl = 'Cap2-08bl';
        Cap209bl = 'Cap2-09bl';
        Cap210bl = 'Cap2-10bl';
        Cap211bl = 'Cap2-11bl';
        Cap301bl = 'Cap3-01bl';
        Cap302bl = 'Cap3-02bl';
        Cap303bl = 'Cap3-03bl';
        Cap304bl = 'Cap3-04bl';
        Cap305bl = 'Cap3-05bl';
        Cap306bl = 'Cap3-06bl';
        Cap307bl = 'Cap307bl';
    }

    var
        RecCust01: Record DK_Customer;
        RecCust02: Record DK_Customer;
        RecCust03: Record DK_Customer;
        RegNo1: Text[30];
        RegNo2: Text[30];
        RegNo3: Text[30];
        Cust2_Bdate_Gender: Text[30];
        Cust3_Bdate_Gender: Text[30];

    local procedure CreateLine()
    var
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _AllExtraAmount: Decimal;
        _GeneralExtraAmount: Decimal;
        _LandExtraAmount: Decimal;
        _LineGeneralAmount: Decimal;
        _LineLandAmount: Decimal;
        _LineNo: Integer;
    begin
        Clear(_LineNo);

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.SetRange("Contract No.", Header."No.");
        if _PaymentReceiptDocument.FindSet then begin
            repeat
                _AllExtraAmount := 0;
                _GeneralExtraAmount := 0;
                _LandExtraAmount := 0;
                _LineGeneralAmount := 0;
                _LineLandAmount := 0;
                _PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount", "Line Admin. Expense");
                if (_PaymentReceiptDocument."Line General Amount" <> 0) and (_PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                    _AllExtraAmount := (_PaymentReceiptDocument."Legal Amount" +
                              _PaymentReceiptDocument."Delay Interest Amount") / 2;
                    _LineGeneralAmount += _PaymentReceiptDocument."Line General Amount" + _AllExtraAmount - _PaymentReceiptDocument."Reduction Amount 1";
                    _LineLandAmount += _PaymentReceiptDocument."Line Land. Arc. Amount" + _AllExtraAmount - _PaymentReceiptDocument."Reduction Amount 2";
                end;

                if (_PaymentReceiptDocument."Line General Amount" <> 0) and (_PaymentReceiptDocument."Line Land. Arc. Amount" = 0) then begin
                    _GeneralExtraAmount := _PaymentReceiptDocument."Legal Amount" +
                              _PaymentReceiptDocument."Delay Interest Amount";
                    _LineGeneralAmount += _PaymentReceiptDocument."Line General Amount" + _GeneralExtraAmount - _PaymentReceiptDocument."Reduction Amount 1";
                end;

                if (_PaymentReceiptDocument."Line General Amount" = 0) and (_PaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then begin
                    _LandExtraAmount := _PaymentReceiptDocument."Legal Amount" +
                              _PaymentReceiptDocument."Delay Interest Amount";
                    _LineLandAmount += _PaymentReceiptDocument."Line Land. Arc. Amount" + _LandExtraAmount - _PaymentReceiptDocument."Reduction Amount 2";
                end;

                _PaymentReceiptDocLine.Reset;
                _PaymentReceiptDocLine.SetRange("Document No.", _PaymentReceiptDocument."Document No.");
                _PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PaymentReceiptDocLine."Payment Target"::General, _PaymentReceiptDocLine."Payment Target"::Landscape);
                if _PaymentReceiptDocLine.FindSet then begin
                    repeat
                        _LineNo += 1;
                        Line.Init;
                        Line."Contract No." := Header."No.";
                        Line."Document No." := _PaymentReceiptDocument."Document No.";
                        Line."Line No." := _LineNo;
                        Line."Payment Target" := _PaymentReceiptDocLine."Payment Target";
                        Line."Payment Date" := _PaymentReceiptDocLine."Payment Date";
                        Line."Start Date" := _PaymentReceiptDocLine."Start Date";
                        Line."Expiration Date" := _PaymentReceiptDocLine."Expiration Date";

                        if _PaymentReceiptDocLine."Payment Target" = _PaymentReceiptDocLine."Payment Target"::General then
                            Line.Amount := _LineGeneralAmount
                        else
                            Line.Amount := _LineLandAmount;

                        Line."Payment Type" := _PaymentReceiptDocLine."Payment Type";
                        Line.Insert;
                    until _PaymentReceiptDocLine.Next = 0;
                end;
            until _PaymentReceiptDocument.Next = 0;
        end;
    end;
}

