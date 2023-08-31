page 50233 "DK_Litigation Performance" ////zzz
{
    // // #1976 : 20200624
    // //   - Add Globals(variable) : TotalLegalAmount, TotalDelayAmount
    // //   - Add Field : TotalLegalAmount, TotalDelayAmount
    // //   - Rec. Modify Function : TotalCalculation
    // //                       Insert_Qualitative
    // //                       Insert_Quantitative
    // // 
    // // #2199 : 20201008
    // //   - Add Field : DATE1, DATE2
    // //   - Rec. Modify function : Insert_Qualitative, Insert_Quantitative
    // // 
    // // DK34 : 20201117
    // //   - Rec. Modify Field: "SHORT TEXT4"
    // //   - Rec. Modify Var: EmployeeFilter -> DepartmentFilter
    // //   - Add Function: DepartmentFilter_onvalidate
    // // 
    // // #2288: 20201211
    // //   - Rec. Modify Function: Insert_Quantitative

    // Caption = 'Litigation Performance';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // PageType = Worksheet;
    // SourceTable = "DK_Report Buffer";
    // SourceTableTemporary = true;

    // layout
    // {
    //     area(content)
    //     {
    //         group(Control22)
    //         {
    //             ShowCaption = false;
    //             group(Control23)
    //             {
    //                 ShowCaption = false;
    //                 field(TypeOption; TypeOption)
    //                 {
    //                     Caption = 'TitleOption';
    //                     OptionCaption = 'Quantitative,Qualitative';

    //                     trigger OnValidate()
    //                     begin
    //                         TypeOption_Onvaildate;
    //                     end;
    //                 }
    //                 field(PaymentStartDate; PaymentStartDate)
    //                 {
    //                     Caption = 'Payment Start Date';

    //                     trigger OnValidate()
    //                     begin
    //                         StartDate_Onvalidate;
    //                     end;
    //                 }
    //                 field(PaymentEndDate; PaymentEndDate)
    //                 {
    //                     Caption = 'Payment End Date';

    //                     trigger OnValidate()
    //                     begin
    //                         EndDate_Onvalidate;
    //                     end;
    //                 }
    //             }
    //             field(cDepartmentFilter; Rec.DepartmentFilter)
    //             {
    //                 Caption = 'Departmente';

    //                 trigger OnLookup(var Text: Text): Boolean
    //                 var
    //                     _Employee: Record DK_Employee;
    //                     _EmployeeList: Page "DK_Employee List";
    //                     _Department: Record DK_Department;
    //                 begin
    //                     _Department.Reset;
    //                     _Department.FilterGroup(2);
    //                     _Department.SetRange(Blocked, false);
    //                     _Department.FilterGroup(0);

    //                     if PAGE.RunModal(0, _Department) = ACTION::LookupOK then begin
    //                         if _Department.Code <> '' then begin
    //                             if Text = '' then
    //                                 Text := _Department.Code
    //                             else
    //                                 Text := Text + '|' + _Department.Code;
    //                         end;
    //                         exit(true);
    //                     end;
    //                 end;

    //                 trigger OnValidate()
    //                 begin
    //                     DepartmentFilter_Onvalidate;
    //                 end;
    //             }
    //             field(CustomerFilter; Rec.CustomerFilter)
    //             {
    //                 Caption = 'Customer';
    //                 TableRelation = DK_Contract."No." WHERE(Status = CONST(FullPayment));

    //                 trigger OnValidate()
    //                 begin
    //                     CustomerFilter_Onvalidate;
    //                 end;
    //             }
    //             field(CemeteryFilter; Rec.CemeteryFilter)
    //             {
    //                 Caption = 'Cemetery';
    //                 TableRelation = DK_Cemetery;

    //                 trigger OnValidate()
    //                 begin
    //                     CemeteryFilter_Onvalidate;
    //                 end;
    //             }
    //         }
    //         repeater(Group)
    //         {
    //             Editable = false;
    //             field("Entry No."; Rec."Entry No.")
    //             {
    //                 Caption = 'No.';
    //             }
    //             field("SHORT TEXT0"; Rec."SHORT TEXT0")
    //             {
    //                 Caption = 'Cemetery';
    //             }
    //             field("SHORT TEXT1"; Rec."SHORT TEXT1")
    //             {
    //                 Caption = 'Rating';
    //             }
    //             field("SHORT TEXT2"; Rec."SHORT TEXT2")
    //             {
    //                 Caption = 'Customer';
    //             }
    //             field(DECIMAL0; Rec.DECIMAL0)
    //             {
    //                 Caption = 'Cemetery Size';
    //             }
    //             field(DATE1; Rec.DATE1)
    //             {
    //                 Caption = 'General Start Date';
    //             }
    //             field(DATE2; Rec.DATE2)
    //             {
    //                 Caption = 'General Expiration Date';
    //             }
    //             field(DATE3; Rec.DATE3)
    //             {
    //                 Caption = 'Land. Arc. Start Date';
    //             }
    //             field(DATE4; Rec.DATE4)
    //             {
    //                 Caption = 'Land. Arc. Expiration Date';
    //             }
    //             field(DECIMAL2; Rec.DECIMAL2)
    //             {
    //                 Caption = 'Payment Amount';
    //             }
    //             field(DECIMAL1; Rec.DECIMAL1)
    //             {
    //                 Caption = 'Non-Payment General Amount';
    //             }
    //             field(DECIMAL3; Rec.DECIMAL3)
    //             {
    //                 Caption = 'General Litigation Amount';
    //             }
    //             field(DECIMAL4; Rec.DECIMAL4)
    //             {
    //                 Caption = 'Non-Payment Land. Arc. Amount';
    //             }
    //             field(DECIMAL6; Rec.DECIMAL6)
    //             {
    //                 Caption = 'Land. Arc. Litigation Amount';
    //             }
    //             field(DECIMAL7; Rec.DECIMAL7)
    //             {
    //                 Caption = 'Accumulation Excrement';
    //             }
    //             field(DECIMAL8; Rec.DECIMAL8)
    //             {
    //                 Caption = 'Reduction Amount';
    //             }
    //             field(DECIMAL9; Rec.DECIMAL9)
    //             {
    //                 Caption = 'Legal Amount';
    //             }
    //             field(DECIMAL10; Rec.DECIMAL10)
    //             {
    //                 Caption = 'Delay Interest Amount';
    //             }
    //             field(DECIMAL11; Rec.DECIMAL11)
    //             {
    //                 Caption = 'Advance Payment Amount';
    //             }
    //             field(DECIMAL12; Rec.DECIMAL12)
    //             {
    //                 Caption = 'MTG Amount';
    //             }
    //             field(DECIMAL13; Rec.DECIMAL13)
    //             {
    //                 Caption = 'TotalAmount';
    //             }
    //             field(DECIMAL14; Rec.DECIMAL14)
    //             {
    //                 Caption = 'Recovery Rate';
    //             }
    //             field(DATE0; Rec.DATE0)
    //             {
    //                 Caption = 'Payment Date';
    //             }
    //             field("SHORT TEXT3"; Rec."SHORT TEXT3")
    //             {
    //                 Caption = 'Payment Type';
    //             }
    //             field(TEXT1; Rec.TEXT1)
    //             {
    //                 Caption = 'Recovery Type';
    //             }
    //             field("LONG TEXT0"; Rec."LONG TEXT0")
    //             {
    //                 Caption = 'Remarks';
    //             }
    //             field(CODE0; Rec.CODE0)
    //             {
    //                 Caption = 'Contract No.';
    //                 Visible = false;
    //             }
    //             field("SHORT TEXT4"; Rec."SHORT TEXT4")
    //             {
    //                 Caption = 'Department';
    //             }
    //         }
    //         group(Control36)
    //         {
    //             ShowCaption = false;
    //             fixed(Control37)
    //             {
    //                 ShowCaption = false;
    //                 group("Total Non-Payment General Amount")
    //                 {
    //                     Caption = 'Total Non-Payment General Amount';
    //                     field(TotalNonGenPayment; TotalNonGenPayment)
    //                     {
    //                     }
    //                 }
    //                 group("Total General Payment")
    //                 {
    //                     Caption = 'Total General Payment';
    //                     field(TotalGeneralPayment; TotalGeneralPayment)
    //                     {
    //                     }
    //                 }
    //                 group("Total Landscape Payment")
    //                 {
    //                     Caption = 'Total Landscape Payment';
    //                     field(TotalLandPayment; TotalLandPayment)
    //                     {
    //                     }
    //                 }
    //                 group("Total Reduction")
    //                 {
    //                     Caption = 'Total Reduction';
    //                     field(TotalReduction; TotalReduction)
    //                     {
    //                     }
    //                 }
    //                 group("Total Legal Amount")
    //                 {
    //                     Caption = 'Total Legal Amount';
    //                     field(TotalLegalAmount; TotalLegalAmount)
    //                     {
    //                     }
    //                 }
    //                 group("Total Delay Interest Amount")
    //                 {
    //                     Caption = 'Total Delay Interest Amount';
    //                     field(TotalDelayAmount; TotalDelayAmount)
    //                     {
    //                     }
    //                 }
    //                 group("Total Advance Payment")
    //                 {
    //                     Caption = 'Total Advance Payment';
    //                     field(TotalAdvAmount; TotalAdvAmount)
    //                     {
    //                     }
    //                 }
    //                 group("Total Amount")
    //                 {
    //                     Caption = 'Total Amount';
    //                     field(TotalAmount; TotalAmount)
    //                     {
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(Inquiry)
    //         {
    //             Caption = 'Inquiry';
    //             Image = "Action";
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin
    //                 SetFilterDelete;
    //                 DataInquiry;
    //             end;
    //         }
    //         action("View Contract Doucment")
    //         {
    //             Caption = 'View Contract Doucment';
    //             Image = View;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin
    //                 ViewLitigationContract;
    //             end;
    //         }
    //     }
    // }

    // trigger OnOpenPage()
    // begin
    //     SetData;
    // end;

    // var
    //     DepartmentFilter: Text[50];
    //     PaymentStartDate: Date;
    //     PaymentEndDate: Date;
    //     CustomerFilter: Code[20];
    //     CemeteryFilter: Code[20];
    //     MSG001: Label 'The date is empty.';
    //     TypeOption: Option Quantitative,Qualtitative;
    //     TotalGeneralPayment: Decimal;
    //     TotalLandPayment: Decimal;
    //     TotalAdvAmount: Decimal;
    //     TotalAmount: Decimal;
    //     TotalReduction: Decimal;
    //     PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    //     TotalNonGenPayment: Decimal;
    //     TotalLegalAmount: Decimal;
    //     TotalDelayAmount: Decimal;


    // procedure SetFilterDelete()
    // begin
    //     Rec.Reset;
    //     Rec.DeleteAll;
    // end;


    // procedure SetData()
    // begin
    //     Clear(PaymentStartDate);
    //     Clear(PaymentEndDate);
    //     Clear(DepartmentFilter);
    //     Clear(CustomerFilter);
    //     Clear(CemeteryFilter);
    //     Clear(TypeOption);

    //     TypeOption := TypeOption::Quantitative;
    //     PaymentStartDate := WorkDate;
    //     PaymentEndDate := WorkDate;
    // end;


    // procedure DataInquiry()
    // begin
    //     SetFilterDelete;

    //     if (PaymentStartDate <> 0D) and (PaymentEndDate = 0D) then
    //         Error(MSG001);

    //     if (PaymentStartDate = 0D) and (PaymentEndDate <> 0D) then
    //         Error(MSG001);

    //     Clear(TotalNonGenPayment);
    //     Clear(TotalGeneralPayment);
    //     Clear(TotalLandPayment);
    //     Clear(TotalAdvAmount);
    //     Clear(TotalAmount);
    //     Clear(TotalReduction);
    //     //>>#1976
    //     Clear(TotalLegalAmount);
    //     Clear(TotalDelayAmount);
    //     //<<#1976
    //     if TypeOption = TypeOption::Quantitative then
    //         Insert_Quantitative
    //     else
    //         Insert_Qualitative;

    //     if Rec."Entry No." > 0 then begin
    //         Rec.SetCurrentKey("Entry No.");
    //         Rec.Ascending(true);
    //         Rec.FindFirst;
    //     end;
    // end;


    // procedure Insert_Quantitative()
    // var
    //     _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    //     _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    //     _EntryNo: Integer;
    //     _Contract: Record DK_Contract;
    // begin

    //     PaymentReceiptDocument.Reset;
    //     PaymentReceiptDocument.SetRange(Posted, true);
    //     PaymentReceiptDocument.SetRange("Missing Contract", false);
    //     PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
    //     PaymentReceiptDocument.SetRange(Litigation, true);
    //     PaymentReceiptDocument.SetFilter("Payment Type", '<>%1', PaymentReceiptDocument."Payment Type"::DebtRelief);
    //     PaymentReceiptDocument.SetRange("MTG Amount", 0);

    //     if PaymentStartDate <> 0D then
    //         PaymentReceiptDocument.SetRange("Posting Date", PaymentStartDate, PaymentEndDate);

    //     if DepartmentFilter <> '' then
    //         PaymentReceiptDocument.SetFilter("Department Code", DepartmentFilter);

    //     if CemeteryFilter <> '' then
    //         PaymentReceiptDocument.SetRange("Cemetery Code", CemeteryFilter);

    //     //PaymentReceiptDocument.FILTERGROUP(-1);
    //     //PaymentReceiptDocument.SETFILTER("Reduction Amount",'<>%1',0);
    //     //PaymentReceiptDocument.SETFILTER("Delay Interest Amount",'<>%1',0);
    //     //PaymentReceiptDocument.SETFILTER("Legal Amount",'<>%1',0);
    //     //PaymentReceiptDocument.SETFILTER("Advance Payment Amount",'<>%1',0);
    //     if PaymentReceiptDocument.FindSet then begin
    //         repeat
    //             _PaymentReceiptDocLine.Reset;
    //             _PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Document No.");
    //             if _PaymentReceiptDocLine.FindSet then begin
    //                 repeat
    //                     _EntryNo += 1;
    //                     Init;
    //                     Rec."USER ID" := UserId;
    //                     Rec."OBJECT ID" := PAGE::"DK_Litigation Performance";
    //                     Rec."Entry No." := _EntryNo;
    //                     Rec.CODE0 := PaymentReceiptDocument."Contract No.";
    //                     Rec."SHORT TEXT0" := PaymentReceiptDocument."Cemetery No.";
    //                     Rec."SHORT TEXT1" := Format(PaymentReceiptDocument."Litigation Evaluation");
    //                     if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
    //                         _Contract.CalcFields("Cemetery Size");
    //                         Rec."SHORT TEXT2" := _Contract."Main Customer Name";
    //                         Rec.DECIMAL0 := _Contract."Cemetery Size";
    //                     end;

    //                     Rec.DECIMAL7 := Sum_PaymentDivisionAmount(PaymentReceiptDocument."Contract No.", PaymentEndDate);
    //                     Rec.DECIMAL8 := PaymentReceiptDocument."Reduction Amount";
    //                     Rec.DECIMAL9 := PaymentReceiptDocument."Legal Amount";
    //                     //>>#2288
    //                     Rec.DECIMAL10 := PaymentReceiptDocument."Delay Interest Amount" + PaymentReceiptDocument."Liti. Delay Interest Amount";
    //                     //<<
    //                     Rec.DECIMAL11 := PaymentReceiptDocument."Advance Payment Amount";
    //                     Rec.DECIMAL13 := PaymentReceiptDocument.Amount;

    //                     //‰Â“‚ˆ« Œ³Ÿ µÕ Š¨—­ “‚ˆ« —­ 
    //                     if _PaymentReceiptDocLine."Document No." = 'PRD0149575' then begin
    //                         Rec.DECIMAL13 := 2700000;
    //                     end;


    //                     Rec.DECIMAL12 := PaymentReceiptDocument."MTG Amount";
    //                     Rec.DECIMAL2 := Rec.DECIMAL13 - Rec.DECIMAL9 - Rec.DECIMAL10 - Rec.DECIMAL11;


    //                     if _PaymentReceiptDocLine."Payment Target" = _PaymentReceiptDocLine."Payment Target"::General then begin
    //                         Rec.DECIMAL1 := _PaymentReceiptDocLine."Bef. Non-Pay. Amount";
    //                         Rec.DECIMAL3 := Rec.DECIMAL1 - Rec.DECIMAL2;
    //                         TotalGeneralPayment += Rec.DECIMAL2;

    //                         // >> #2199
    //                         DATE1 := _PaymentReceiptDocLine."Start Date";
    //                         DATE2 := _PaymentReceiptDocLine."Expiration Date";
    //                         // <<
    //                     end else begin
    //                         Rec.DECIMAL4 := _PaymentReceiptDocLine."Bef. Non-Pay. Amount";
    //                         Rec.DECIMAL6 := Rec.DECIMAL4 - Rec.DECIMAL2;

    //                         TotalLandPayment += Rec.DECIMAL2;
    //                         // >> #2199
    //                         Rec.DATE3 := _PaymentReceiptDocLine."Start Date";
    //                         Rec.DATE4 := _PaymentReceiptDocLine."Expiration Date";
    //                         // <<
    //                     end;

    //                     //˜ˆŒ÷ = „Ïõ¯€¦/˜ˆŒ÷„Ô‹ÝŽ¸
    //                     if (DECIMAL1 + Rec.DECIMAL4) > 0 then
    //                         Rec.DECIMAL14 := ((DECIMAL2 + Rec.DECIMAL5) / (DECIMAL1 + Rec.DECIMAL4)) * 100;

    //                     Rec.DATE0 := PaymentReceiptDocument."Payment Date";
    //                     Rec."SHORT TEXT3" := Check_PaymentType(PaymentReceiptDocument);
    //                     Rec.TEXT1 := PaymentReceiptDocument."Withdraw Mothed";
    //                     "LONG TEXT0" := PaymentReceiptDocument."Litigation Ramark";
    //                     // >> DK34
    //                     Rec."SHORT TEXT4" := PaymentReceiptDocument."Department Name";
    //                     // <<

    //                     Rec.Insert;
    //                     ;

    //                     TotalNonGenPayment += Rec.DECIMAL1;


    //                     TotalReduction += Rec.DECIMAL8;
    //                     TotalAdvAmount += Rec.DECIMAL11;
    //                     TotalAmount += Rec.DECIMAL13;
    //                     //>>#1976
    //                     TotalLegalAmount += Rec.DECIMAL9;
    //                     TotalDelayAmount += Rec.DECIMAL10;
    //                 //<<#1976

    //                 until _PaymentReceiptDocLine.Next = 0;
    //             end;
    //         until PaymentReceiptDocument.Next = 0;
    //         //TotalCalculation;
    //     end;
    // end;


    // procedure Insert_Qualitative()
    // var
    //     _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    //     _EntryNo: Integer;
    //     _Contract: Record DK_Contract;
    // begin

    //     PaymentReceiptDocument.Reset;
    //     PaymentReceiptDocument.SetRange(Posted, true);
    //     PaymentReceiptDocument.SetRange("Missing Contract", false);
    //     PaymentReceiptDocument.SetRange(Litigation, true);
    //     PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
    //     PaymentReceiptDocument.SetFilter("MTG Amount", '<>%1', 0);

    //     if PaymentStartDate <> 0D then
    //         PaymentReceiptDocument.SetRange("Posting Date", PaymentStartDate, PaymentEndDate);

    //     if DepartmentFilter <> '' then
    //         PaymentReceiptDocument.SetFilter("Department Code", DepartmentFilter);

    //     if CemeteryFilter <> '' then
    //         PaymentReceiptDocument.SetRange("Cemetery Code", CemeteryFilter);

    //     if PaymentReceiptDocument.FindSet then begin
    //         repeat
    //             _EntryNo += 1;
    //             //PaymentReceiptDocument.CALCFIELDS("Cemetery No.");
    //             Init;
    //             Rec."USER ID" := UserId;
    //             Rec."OBJECT ID" := PAGE::"DK_Litigation Performance";
    //             Rec."Entry No." := _EntryNo;
    //             Rec.CODE0 := PaymentReceiptDocument."Contract No.";
    //             Rec."SHORT TEXT0" := PaymentReceiptDocument."Cemetery No.";
    //             Rec."SHORT TEXT1" := Format(PaymentReceiptDocument."Litigation Evaluation");
    //             if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
    //                 _Contract.CalcFields("Cemetery Size");
    //                 Rec."SHORT TEXT2" := _Contract."Main Customer Name";
    //                 Rec.DECIMAL0 := _Contract."Cemetery Size";
    //             end;
    //             Rec.DECIMAL11 := PaymentReceiptDocument."Advance Payment Amount";
    //             Rec.DECIMAL12 := PaymentReceiptDocument."MTG Amount";
    //             Rec.DECIMAL13 := PaymentReceiptDocument."Final Amount";
    //             Rec.DATE0 := PaymentReceiptDocument."Payment Date";
    //             Rec."SHORT TEXT3" := Check_PaymentType(PaymentReceiptDocument);
    //             Rec.TEXT1 := PaymentReceiptDocument."Withdraw Mothed";
    //             "LONG TEXT0" := PaymentReceiptDocument."Litigation Ramark";
    //             // >> DK34
    //             Rec."SHORT TEXT4" := PaymentReceiptDocument."Department Name";
    //             // <<

    //             _PaymentReceiptDocLine.Reset;
    //             _PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Document No.");
    //             _PaymentReceiptDocLine.SetRange("Payment Target", _PaymentReceiptDocLine."Payment Target"::General,
    //                                             _PaymentReceiptDocLine."Payment Target"::Landscape);
    //             if _PaymentReceiptDocLine.FindSet then
    //                 repeat
    //                     if _PaymentReceiptDocLine."Payment Target" = _PaymentReceiptDocLine."Payment Target"::General then begin
    //                         // >> #2199
    //                         DATE1 := _PaymentReceiptDocLine."Start Date";
    //                         DATE2 := _PaymentReceiptDocLine."Expiration Date";
    //                         // <<
    //                         TotalGeneralPayment += Rec.DECIMAL2;
    //                     end else begin
    //                         // >> #2199
    //                         Rec.DATE3 := _PaymentReceiptDocLine."Start Date";
    //                         Rec.DATE4 := _PaymentReceiptDocLine."Expiration Date";
    //                         // <<
    //                         TotalLandPayment += Rec.DECIMAL2;
    //                     end;
    //                 until _PaymentReceiptDocLine.Next = 0;

    //             Rec.Insert;
    //             ;




    //             TotalReduction += Rec.DECIMAL8;
    //             TotalAdvAmount += Rec.DECIMAL11;
    //             TotalAmount += Rec.DECIMAL13;

    //             //>>#1976
    //             TotalLegalAmount += Rec.DECIMAL9;
    //             TotalDelayAmount += Rec.DECIMAL10;
    //         //<<#1976
    //         until PaymentReceiptDocument.Next = 0;
    //     end;

    //     PaymentReceiptDocument.Reset;
    //     PaymentReceiptDocument.SetRange(Posted, true);
    //     PaymentReceiptDocument.SetRange("Missing Contract", false);
    //     PaymentReceiptDocument.SetRange("Document Type", PaymentReceiptDocument."Document Type"::Receipt);
    //     if PaymentStartDate <> 0D then
    //         PaymentReceiptDocument.SetRange("Posting Date", PaymentStartDate, PaymentEndDate);

    //     if DepartmentFilter <> '' then
    //         PaymentReceiptDocument.SetFilter("Department Code", DepartmentFilter);

    //     if CemeteryFilter <> '' then
    //         PaymentReceiptDocument.SetRange("Cemetery Code", CemeteryFilter);
    //     PaymentReceiptDocument.SetRange("Payment Type", PaymentReceiptDocument."Payment Type"::DebtRelief);
    //     if PaymentReceiptDocument.FindSet then begin
    //         repeat
    //             _EntryNo += 1;
    //             Init;
    //             Rec."USER ID" := UserId;
    //             Rec."OBJECT ID" := PAGE::"DK_Litigation Performance";
    //             Rec."Entry No." := _EntryNo;
    //             Rec.CODE0 := PaymentReceiptDocument."Contract No.";
    //             Rec."SHORT TEXT0" := PaymentReceiptDocument."Cemetery No.";
    //             Rec."SHORT TEXT1" := Format(PaymentReceiptDocument."Litigation Evaluation");
    //             if _Contract.Get(PaymentReceiptDocument."Contract No.") then begin
    //                 _Contract.CalcFields("Cemetery Size");
    //                 Rec."SHORT TEXT2" := _Contract."Main Customer Name";
    //                 Rec.DECIMAL0 := _Contract."Cemetery Size";
    //             end;
    //             Rec.DECIMAL8 := PaymentReceiptDocument."Reduction Amount";
    //             TotalReduction += Rec.DECIMAL8;
    //             Rec.DATE0 := PaymentReceiptDocument."Payment Date";
    //             Rec.DECIMAL11 := PaymentReceiptDocument."Advance Payment Amount";
    //             Rec.DECIMAL12 := PaymentReceiptDocument."MTG Amount";
    //             Rec.DECIMAL13 := PaymentReceiptDocument."Final Amount";
    //             Rec."SHORT TEXT3" := Check_PaymentType(PaymentReceiptDocument);
    //             Rec.TEXT1 := PaymentReceiptDocument."Withdraw Mothed";
    //             "LONG TEXT0" := PaymentReceiptDocument."Litigation Ramark";
    //             // >> DK34
    //             Rec."SHORT TEXT4" := PaymentReceiptDocument."Department Name";
    //             // <<

    //             _PaymentReceiptDocLine.Reset;
    //             _PaymentReceiptDocLine.SetRange("Document No.", PaymentReceiptDocument."Document No.");
    //             _PaymentReceiptDocLine.SetRange("Payment Target", _PaymentReceiptDocLine."Payment Target"::General,
    //                                             _PaymentReceiptDocLine."Payment Target"::Landscape);
    //             if _PaymentReceiptDocLine.FindSet then
    //                 repeat
    //                     if _PaymentReceiptDocLine."Payment Target" = _PaymentReceiptDocLine."Payment Target"::General then begin
    //                         // >> #2199
    //                         DATE1 := _PaymentReceiptDocLine."Start Date";
    //                         DATE2 := _PaymentReceiptDocLine."Expiration Date";
    //                         // <<
    //                         TotalGeneralPayment += Rec.DECIMAL2;
    //                     end else begin
    //                         // >> #2199
    //                         Rec.DATE3 := _PaymentReceiptDocLine."Start Date";
    //                         Rec.DATE4 := _PaymentReceiptDocLine."Expiration Date";
    //                         // <<
    //                         TotalLandPayment += Rec.DECIMAL2;
    //                     end;
    //                 until _PaymentReceiptDocLine.Next = 0;

    //             Rec.Insert;
    //             ;



    //             TotalReduction += Rec.DECIMAL8;
    //             TotalAdvAmount += Rec.DECIMAL11;
    //             TotalAmount += Rec.DECIMAL13;

    //             //>>#1976
    //             TotalLegalAmount += Rec.DECIMAL9;
    //             TotalDelayAmount += Rec.DECIMAL10;
    //         //<<#1976
    //         until PaymentReceiptDocument.Next = 0;
    //     end;

    //     //TotalCalculation;
    // end;


    // procedure CalcLitigationAmount("Non-Pay": Decimal; Payment: Decimal): Decimal
    // begin

    //     if "Non-Pay" = 0 then
    //         exit(0);

    //     exit("Non-Pay" - Payment);
    // end;


    // procedure Check_PaymentType(pPaymentReceiptDocument: Record "DK_Payment Receipt Document"): Text
    // begin

    //     with pPaymentReceiptDocument do begin
    //         if Rec."Payment Type" = Rec."Payment Type"::Bank then
    //             exit("Bank Account Name")
    //         else
    //             exit(Format("Payment Type"));
    //     end;
    // end;

    // local procedure TotalCalculation()
    // begin

    //     Clear(TotalNonGenPayment);
    //     Clear(TotalGeneralPayment);
    //     Clear(TotalLandPayment);
    //     Clear(TotalAdvAmount);
    //     Clear(TotalAmount);
    //     Clear(TotalReduction);
    //     //>>#1976
    //     Clear(TotalLegalAmount);
    //     Clear(TotalDelayAmount);
    //     //<<#1976
    //     CalcSums(DECIMAL1);
    //     CalcSums(DECIMAL2);
    //     CalcSums(DECIMAL5);
    //     CalcSums(DECIMAL8);
    //     CalcSums(DECIMAL11);
    //     CalcSums(DECIMAL13);
    //     //>>#1976
    //     CalcSums(DECIMAL9);
    //     CalcSums(DECIMAL10);
    //     //<<#1976
    // end;


    // procedure Sum_PaymentDivisionAmount(pContractNo: Code[20]; pEndDate: Date): Decimal
    // var
    //     _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    // begin

    //     _PaymentReceiptDocument.Reset;
    //     _PaymentReceiptDocument.SetRange("Contract No.", pContractNo);
    //     _PaymentReceiptDocument.SetRange(Division, true);

    //     if pEndDate <> 0D then
    //         _PaymentReceiptDocument.SetFilter("Posting Date", '<=%1', pEndDate);

    //     if _PaymentReceiptDocument.FindSet then begin
    //         _PaymentReceiptDocument.CalcSums(Amount);
    //         exit(_PaymentReceiptDocument.Amount)
    //     end else
    //         exit(0);
    // end;

    // local procedure StartDate_Onvalidate()
    // begin
    //     if PaymentEndDate <> 0D then begin
    //         if PaymentStartDate > PaymentEndDate then
    //             Error('');
    //     end;

    //     SetFilterDelete;
    // end;

    // local procedure EndDate_Onvalidate()
    // begin
    //     if PaymentStartDate <> 0D then begin
    //         if PaymentStartDate > PaymentEndDate then
    //             Error('');
    //     end;

    //     SetFilterDelete;
    // end;

    // local procedure EmployeeFilter_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;

    // local procedure CustomerFilter_Onvalidate()
    // begin
    //     if CemeteryFilter <> '' then
    //         CemeteryFilter := '';

    //     SetFilterDelete;
    // end;

    // local procedure CemeteryFilter_Onvalidate()
    // begin
    //     if CustomerFilter <> '' then
    //         CustomerFilter := '';

    //     SetFilterDelete;
    // end;

    // local procedure TypeOption_Onvaildate()
    // begin
    //     SetFilterDelete;
    // end;


    // procedure ViewLitigationContract()
    // var
    //     _Contract: Record DK_Contract;
    //     _LitigationContract: Page "DK_Litigation Contract";
    // begin
    //     if _Contract.Get(CODE0) then begin
    //         Clear(_LitigationContract);
    //         _LitigationContract.LookupMode(true);
    //         _LitigationContract.SetTableView(_Contract);
    //         _LitigationContract.SetRecord(_Contract);
    //         _LitigationContract.RunModal;
    //     end;
    // end;

    // local procedure DepartmentFilter_Onvalidate()
    // begin

    //     SetFilterDelete;
    // end;
}

