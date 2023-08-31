page 50224 "DK_Litigation Payment"////zzz
{
    // // 
    // // #2044 : 2020-07-23
    // //   - Rec. Modify Page Caption : ŒÁ‰½ ¯€¦—÷˜ -> ¯€¦ —÷˜(„Ì„ÏÀ)
    // // 
    // // DK34: 20201117
    // //   - Rec. Modify Page Caption : ¯€¦ —÷˜(„Ì„ÏÀ) -> ¯€¦ —÷˜(„Ì„ÏŠžŒ¡)
    // //   - Rec. Modify Function: DataInquiry(), SetData()
    // //   - Rec. Modify Field: Rec.TEXT7
    // //   - Rec. Modify Var: EmployeeFilter -> DepartmentFilter

    // Caption = 'Litigation Payment';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // PageType = Worksheet;
    // PromotedActionCategories = 'New,Process,Report,Export To Excel';
    // SourceTable = "DK_Report Buffer";
    // SourceTableTemporary = true;

    // layout
    // {
    //     area(content)
    //     {
    //         group(Option)
    //         {
    //             Caption = 'Option';
    //             group("Payment Date")
    //             {
    //                 Caption = 'Payment Date';
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
    //             field(DepartmentFilter; Rec.DepartmentFilter)
    //             {
    //                 Caption = 'Department';

    //                 trigger OnLookup(var Text: Text): Boolean
    //                 var
    //                     _Employee: Record DK_Employee;
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

    //                     /*
    //                     _Employee.RESET;
    //                     _Employee.FILTERGROUP(2);
    //                     _Employee.SETRANGE(Blocked,FALSE);
    //                     _Employee.FILTERGROUP(0);

    //                     IF PAGE.RUNMODAL(0,_Employee) = ACTION::LookupOK THEN BEGIN
    //                       IF _Employee."No." <> '' THEN BEGIN
    //                         IF Text = '' THEN
    //                           Text := _Employee."No."
    //                         ELSE
    //                           Text := Text+'|'+_Employee."No.";
    //                       END;
    //                       EXIT(TRUE);
    //                     END;
    //                     */

    //                 end;

    //                 trigger OnValidate()
    //                 begin
    //                     //EmployeeFilter_Onvalidate;
    //                     DepartmentFilter_Onvalidate;
    //                 end;
    //             }
    //             field(CustomerFilter; Rec.CustomerFilter)
    //             {
    //                 Caption = 'Main Customer';
    //                 TableRelation = DK_Contract."No.";

    //                 trigger OnValidate()
    //                 begin
    //                     CustomerFilter_Onvalidate;
    //                 end;
    //             }
    //             field(CemeteryFilter; Rec.CemeteryFilter)
    //             {
    //                 Caption = 'Cemetery';
    //                 TableRelation = DK_Cemetery."Cemetery Code";

    //                 trigger OnValidate()
    //                 begin
    //                     CemeteryFilter_Onvalidate;
    //                 end;
    //             }
    //         }
    //         repeater(Group)
    //         {
    //             field("Entry No."; Rec."Entry No.")
    //             {
    //                 Caption = 'Entry No.';
    //             }
    //             field(DATE0; Rec.DATE0)
    //             {
    //                 Caption = 'Payment Date';
    //             }
    //             field(TEXT0; Rec.TEXT0)
    //             {
    //                 Caption = 'Cemetry No.';
    //             }
    //             field(TEXT1; Rec.TEXT1)
    //             {
    //                 Caption = 'Main Customer Name';
    //             }
    //             field(TEXT2; Rec.TEXT2)
    //             {
    //                 Caption = 'Admin Type';
    //             }
    //             field(TEXT3; TEXT3)
    //             {
    //                 Caption = 'Payment Type';
    //             }
    //             field(TEXT4; TEXT4)
    //             {
    //                 Caption = 'Payment Method';
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
    //                 Caption = 'Landscape Arc. Start Date';
    //             }
    //             field(DATE4; Rec.DATE4)
    //             {
    //                 Caption = 'Landscape Arc. Expiration';
    //             }
    //             field(INTEGER0; Rec.INTEGER0)
    //             {
    //                 Caption = 'General Term';
    //             }
    //             field(INTEGER1; Rec.INTEGER1)
    //             {
    //                 Caption = 'Landscape Term';
    //             }
    //             field(DECIMAL0; Rec.DECIMAL0)
    //             {
    //                 Caption = 'General Amount';
    //             }
    //             field(DECIMAL1; Rec.DECIMAL1)
    //             {
    //                 Caption = 'Landscape Amount';
    //             }
    //             field(TEXT7; Rec.TEXT7)
    //             {
    //                 Caption = 'Department';
    //             }
    //             field(DECIMAL2; Rec.DECIMAL2)
    //             {
    //                 Caption = 'Reduction Amount';
    //             }
    //             field(DECIMAL3; Rec.DECIMAL3)
    //             {
    //                 Caption = 'Other Amount';
    //             }
    //             field(TEXT8; Rec.TEXT8)
    //             {
    //                 Caption = 'Withdraw Method';
    //             }
    //             field(TEXT9; Rec.TEXT9)
    //             {
    //                 Caption = 'Remark';
    //             }
    //         }
    //         group(Control32)
    //         {
    //             ShowCaption = false;
    //             fixed(Control34)
    //             {
    //                 ShowCaption = false;
    //                 group("Total Payment Amount")
    //                 {
    //                     Caption = 'Total Payment Amount';
    //                     field(TotalPaymentAmount; TotalPaymentAmount)
    //                     {
    //                         Editable = false;
    //                         ShowCaption = false;
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
    //                 DataInquiry;
    //             end;
    //         }
    //         action(cExportToExcel)
    //         {
    //             Caption = 'Export To Excel';
    //             Ellipsis = true;
    //             Image = ExportToExcel;
    //             Promoted = true;
    //             PromotedCategory = Category4;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin
    //                 ExportToExcel;
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
    //     GeneralAmount: Label 'General Amount';
    //     LandAmount: Label 'Land Accumulate Amount';
    //     AdminAmount: Label 'Amount';
    //     TotalPaymentAmount: Decimal;
    //     MSG002: Label 'Start Date cannot be greater than End Date.';

    // local procedure SetFilterDelete()
    // begin
    //     Rec.Reset;
    //     Rec.DeleteAll;
    // end;

    // local procedure SetData()
    // begin
    //     Clear(PaymentStartDate);
    //     Clear(PaymentEndDate);
    //     Clear(DepartmentFilter);
    //     Clear(CustomerFilter);
    //     Clear(CemeteryFilter);

    //     PaymentStartDate := CalcDate('<-CY>', WorkDate);
    //     PaymentEndDate := WorkDate;
    //     DepartmentFilter := '';
    //     CustomerFilter := '';
    //     CemeteryFilter := '';
    // end;


    // procedure DataInquiry()
    // var
    //     _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    //     _EntryNo: Integer;
    //     _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    //     _Contract: Record DK_Contract;
    // begin
    //     SetFilterDelete;

    //     if (PaymentStartDate <> 0D) and (PaymentEndDate = 0D) then
    //         Error(MSG001);

    //     if (PaymentStartDate = 0D) and (PaymentEndDate <> 0D) then
    //         Error(MSG001);

    //     _PaymentReceiptDocument.Reset;
    //     _PaymentReceiptDocument.SetRange(Posted, true);
    //     _PaymentReceiptDocument.SetRange("Missing Contract", false);
    //     _PaymentReceiptDocument.SetRange("Document Type", _PaymentReceiptDocument."Document Type"::Receipt);
    //     _PaymentReceiptDocument.SetFilter("Payment Type", '<>%1', _PaymentReceiptDocument."Payment Type"::DebtRelief);
    //     _PaymentReceiptDocument.SetCurrentKey("Payment Date");

    //     if PaymentStartDate <> 0D then
    //         _PaymentReceiptDocument.SetRange("Payment Date", PaymentStartDate, PaymentEndDate);

    //     if DepartmentFilter <> '' then
    //         _PaymentReceiptDocument.SetFilter("Department Code", DepartmentFilter);


    //     if CemeteryFilter <> '' then
    //         _PaymentReceiptDocument.SetRange("Cemetery Code", CemeteryFilter);

    //     if _PaymentReceiptDocument.FindSet then begin
    //         repeat
    //             _EntryNo += 1;
    //             _PaymentReceiptDocument.CalcFields("Line General Start Date", "Line General Expiration Date", "Line Land. Arc. Start Date", "Line Land. Arc. Exp. Date");
    //             _PaymentReceiptDocument.CalcFields("Line General Amount", "Line Land. Arc. Amount");
    //             Rec.Init;
    //             Rec."USER ID" := UserId;
    //             Rec."OBJECT ID" := PAGE::"DK_Litigation Payment";
    //             Rec."Entry No." := _EntryNo;
    //             Rec.DATE0 := _PaymentReceiptDocument."Payment Date";
    //             Rec.TEXT0 := _PaymentReceiptDocument."Cemetery No.";
    //             if _Contract.Get(_PaymentReceiptDocument."Contract No.") then
    //                 Rec.TEXT1 := _Contract."Main Customer Name";
    //             Rec.TEXT2 := Check_AdminType(_PaymentReceiptDocument);
    //             Rec.TEXT3 := Format(_PaymentReceiptDocument."Payment Type");
    //             Rec.TEXT4 := Check_PaymentType(_PaymentReceiptDocument);
    //             Rec.DATE1 := _PaymentReceiptDocument."Line General Start Date";
    //             Rec.DATE2 := _PaymentReceiptDocument."Line General Expiration Date";
    //             Rec.DATE3 := _PaymentReceiptDocument."Line Land. Arc. Start Date";
    //             Rec.DATE4 := _PaymentReceiptDocument."Line General Expiration Date";
    //             Rec.INTEGER0 := Calc_AdminDate(_PaymentReceiptDocument."Line General Start Date", _PaymentReceiptDocument."Line General Expiration Date");
    //             Rec.INTEGER1 := Calc_AdminDate(_PaymentReceiptDocument."Line Land. Arc. Start Date", _PaymentReceiptDocument."Line Land. Arc. Exp. Date");
    //             Rec.DECIMAL0 := _PaymentReceiptDocument."Line General Amount";
    //             Rec.DECIMAL1 := _PaymentReceiptDocument."Line Land. Arc. Amount";
    //             // >> DK34
    //             //TEXT7 := _PaymentReceiptDocument."Litigation Employee Name";
    //             Rec.TEXT7 := _PaymentReceiptDocument."Department Name";
    //             // <<
    //             Rec.DECIMAL2 := _PaymentReceiptDocument."Reduction Amount";
    //             Rec.DECIMAL3 := (_PaymentReceiptDocument."Legal Amount" + _PaymentReceiptDocument."Advance Payment Amount" + _PaymentReceiptDocument."Delay Interest Amount" +
    //                    _PaymentReceiptDocument."MTG Amount");
    //             Rec.TEXT8 := _PaymentReceiptDocument."Withdraw Mothed";
    //             Rec.TEXT9 := _PaymentReceiptDocument."Litigation Ramark";
    //             Rec.Insert;
    //             ;
    //         until _PaymentReceiptDocument.Next = 0;
    //     end;

    //     if _EntryNo > 0 then begin
    //         Rec.SetCurrentKey("Entry No.");
    //         Rec.Ascending(false);
    //         Rec.FindFirst;
    //     end;

    //     Rec.CalcSums(DECIMAL0);
    //     Rec.CalcSums(DECIMAL1);
    //     TotalPaymentAmount := Rec.DECIMAL0 + Rec.DECIMAL1;
    // end;


    // procedure Check_PaymentType(pPaymentReceiptDocument: Record "DK_Payment Receipt Document"): Text
    // begin
    //     with pPaymentReceiptDocument do begin
    //         case Rec."Payment Type" of
    //             Rec."Payment Type"::Bank:
    //                 begin
    //                     exit(pPaymentReceiptDocument."Bank Account Name");
    //                 end;
    //             Rec."Payment Type"::Card:
    //                 begin
    //                     exit(pPaymentReceiptDocument."Payment Method Name");
    //                 end;
    //             Rec."Payment Type"::Cash:
    //                 begin
    //                     exit(Format("Payment Type"::Cash));
    //                 end;
    //             Rec."Payment Type"::DebtRelief:
    //                 begin
    //                     exit(Format("Payment Type"::DebtRelief));
    //                 end;
    //             Rec."Payment Type"::Giro:
    //                 begin
    //                     exit(pPaymentReceiptDocument."Payment Method Name");
    //                 end;
    //             Rec."Payment Type"::OnlineCard:
    //                 begin
    //                     exit(pPaymentReceiptDocument."Payment Method Name");
    //                 end;
    //             Rec."Payment Type"::VirtualAccount:
    //                 begin
    //                     exit(Format("Payment Type"::VirtualAccount));
    //                 end;
    //         end;
    //     end;
    // end;

    // local procedure Check_AdminType(pPaymentReceiptDocument: Record "DK_Payment Receipt Document"): Text
    // var
    //     _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    // begin
    //     if pPaymentReceiptDocument."Line General Amount" <> 0 then
    //         exit(GeneralAmount);
    //     if pPaymentReceiptDocument."Line Land. Arc. Amount" <> 0 then
    //         exit(LandAmount);
    //     if (pPaymentReceiptDocument."Line General Amount" <> 0) and
    //       (pPaymentReceiptDocument."Line Land. Arc. Amount" <> 0) then
    //         exit(AdminAmount);
    // end;

    // local procedure Calc_AdminDate(pStartDate: Date; pEndDate: Date): Integer
    // var
    //     _RevocationContractMgt: Codeunit "DK_Revocation Contract Mgt.";
    // begin
    //     if (pStartDate = 0D) or (pEndDate = 0D) then
    //         exit;

    //     exit(_RevocationContractMgt.CalcContractPreiodMonth(pStartDate, pEndDate));
    // end;

    // local procedure StartDate_Onvalidate()
    // begin
    //     if PaymentEndDate <> 0D then begin
    //         if PaymentStartDate > PaymentEndDate then
    //             Error(MSG002);
    //     end;

    //     SetFilterDelete;
    // end;

    // local procedure EndDate_Onvalidate()
    // begin
    //     if PaymentStartDate <> 0D then begin
    //         if PaymentStartDate > PaymentEndDate then
    //             Error(MSG002);
    //     end;

    //     SetFilterDelete;
    // end;

    // local procedure EmployeeFilter_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;

    // local procedure CustomerFilter_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;

    // local procedure CemeteryFilter_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;

    // local procedure ExportToExcel()
    // var
    //     _DK_ReportMgt: Codeunit "DK_Report Mgt.";
    // begin
    //     _DK_ReportMgt.Page50224_ToExcel(Rec);
    // end;

    // local procedure DepartmentFilter_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;
}

