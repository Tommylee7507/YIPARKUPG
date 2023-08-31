page 50240 "DK_Litigation Counsel Statics"////zzz
{
    // // 
    // // #2044 : 2020-07-23
    // //   - Rec. Modify Page Caption : ŒÁ‰½ ‹Ý„Ì •ÔÐ -> ×„ ‹Ý„Ì •ÔÐ

    // Caption = 'Litigaion Counsel Statics';
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
    //         group(Option)
    //         {
    //             Caption = 'Option';
    //             field(StartDate; StartDate)
    //             {
    //                 Caption = 'Counsel Start Date';

    //                 trigger OnValidate()
    //                 begin
    //                     StartDate_Onvalidate;
    //                 end;
    //             }
    //             field(EndDate; EndDate)
    //             {
    //                 Caption = 'Counsel End Date';

    //                 trigger OnValidate()
    //                 begin
    //                     EndDate_Onvalidate;
    //                 end;
    //             }
    //             field(EmployeeFilter; Rec.EmployeeFilter)
    //             {
    //                 Caption = 'Employee Code';

    //                 trigger OnLookup(var Text: Text): Boolean
    //                 var
    //                     _Employee: Record DK_Employee;
    //                 begin
    //                     _Employee.Reset;
    //                     _Employee.FilterGroup(2);
    //                     _Employee.SetRange(Blocked, false);
    //                     _Employee.FilterGroup(0);

    //                     if PAGE.RunModal(0, _Employee) = ACTION::LookupOK then begin
    //                         if _Employee."No." <> '' then begin
    //                             if Text = '' then
    //                                 Text := _Employee."No."
    //                             else
    //                                 Text := Text + '|' + _Employee."No.";
    //                         end;
    //                         exit(true);
    //                     end;
    //                 end;

    //                 trigger OnValidate()
    //                 begin
    //                     EmployeeCode_Onvalidate;
    //                 end;
    //             }
    //             field(CounselType; Rec.CounselType)
    //             {
    //                 Caption = 'Counsel Type';
    //                 OptionCaption = ' ,Reception,Sending,Talk,SMS,Etc.,Mail,Law,Visit,Agree,Open Requst,All';

    //                 trigger OnValidate()
    //                 begin
    //                     CounselType_Onvalidate;
    //                 end;
    //             }
    //             field(ContactMethod; Rec.ContactMethod)
    //             {
    //                 Caption = 'Contact Method';
    //                 OptionCaption = ' ,Mobile,Home,Work,Etc.,Certification of Contents,All';

    //                 trigger OnValidate()
    //                 begin
    //                     ContactMethod_Onvalidate;
    //                 end;
    //             }
    //         }
    //         repeater(Group)
    //         {
    //             Editable = false;
    //             field("Entry No."; Rec."Entry No.")
    //             {
    //                 Caption = 'EntryNo';
    //                 Visible = false;
    //             }
    //             field(CODE0; Rec.CODE0)
    //             {
    //                 Caption = 'Employee Code';
    //                 Visible = false;
    //             }
    //             field("SHORT TEXT0"; Rec."SHORT TEXT0")
    //             {
    //                 Caption = 'Employee';
    //                 StyleExpr = ColorType;
    //             }
    //             field(INTEGER1; Rec.INTEGER1)
    //             {
    //                 Caption = 'TotalType';
    //                 Visible = false;
    //             }
    //             field("SHORT TEXT1"; Rec."SHORT TEXT1")
    //             {
    //                 Caption = 'Counsel Type';
    //             }
    //             field(DECIMAL0; Rec.DECIMAL0)
    //             {
    //                 Caption = 'Count';
    //                 StyleExpr = ColorType;
    //             }
    //             field(INTEGER0; Rec.INTEGER0)
    //             {
    //                 Caption = 'Color Type';
    //                 Visible = false;
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
    //             PromotedOnly = true;

    //             trigger OnAction()
    //             begin
    //                 SetFilterDelete;
    //                 //DataInquiry;
    //                 DataInquiry2;
    //             end;
    //         }
    //     }
    // }

    // trigger OnAfterGetRecord()
    // begin
    //     Check_ColorType;
    // end;

    // trigger OnOpenPage()
    // begin
    //     SetData;
    // end;

    // var
    //     EmployeeFilter: Text;
    //     CounselType: Option Blank,Reception,Sending,Talk,SMS,Etc,Mail,Law,Visit,Argee,OpenRequest,All;
    //     ContactMethod: Option Blank,Mobile,Home,Work,Etc,CoC,All;
    //     StartDate: Date;
    //     EndDate: Date;
    //     MSG001: Label 'You cannot enter only the start date.';
    //     MSG002: Label 'Start date cannot be greater than end date.';
    //     CounselHistory: Record "DK_Counsel History";
    //     EntryNo: Integer;
    //     TotalMSG: Label '%1 Total';
    //     ColorType: Text;
    //     TotalSumMSG: Label 'Total';
    //     TotalCount: Decimal;
    //     BlankText: Label 'Blank';

    // local procedure SetData()
    // var
    //     CounselHistory: Record "DK_Counsel History";
    // begin
    //     Clear(StartDate);
    //     Clear(EndDate);
    //     Clear(EmployeeFilter);
    //     Clear(CounselType);
    //     Clear(ContactMethod);
    //     Clear(EntryNo);

    //     EndDate := WorkDate;
    //     StartDate := CalcDate('<-CY>', EndDate);
    //     CounselType := CounselType::All;
    //     ContactMethod := ContactMethod::All;
    // end;

    // local procedure SetFilterDelete()
    // begin
    //     Rec.Reset;
    //     if Rec.FindSet then begin
    //         Rec.DeleteAll;
    //     end;
    // end;

    // local procedure DataInquiry2()
    // var
    //     _Employee: Record DK_Employee;
    //     _CounselHistory: Record "DK_Counsel History";
    //     _NewEntryNo: Integer;
    //     _TotalCount: Decimal;
    //     _GrandTotal: Decimal;
    // begin
    //     Clear(ColorType);
    //     Clear(EntryNo);
    //     Clear(TotalCount);

    //     if (StartDate = 0D) or (EndDate = 0D) then
    //         Error(MSG001);

    //     _Employee.Reset;

    //     if EmployeeFilter <> '' then
    //         _Employee.SetFilter("No.", EmployeeFilter);

    //     if _Employee.FindSet then begin
    //         repeat
    //             Clear(_TotalCount);

    //             _CounselHistory.Reset;
    //             _CounselHistory.SetRange(Type, CounselHistory.Type::Litigation);
    //             _CounselHistory.SetRange("Request Del", false);
    //             _CounselHistory.SetRange("Delete Row", false);
    //             _CounselHistory.SetRange(Date, StartDate, EndDate);
    //             _CounselHistory.SetRange("Employee No.", _Employee."No.");
    //             if ContactMethod <> ContactMethod::All then
    //                 _CounselHistory.SetRange("Contact Method", ContactMethod);
    //             if CounselType <> CounselType::All then
    //                 _CounselHistory.SetRange("Litigation Type", CounselType);

    //             if _CounselHistory.FindSet then begin

    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Blank, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Reception, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Sending, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Talk, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::SMS, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Mail, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Law, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Visit, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Etc, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::Agree, 0, 0);
    //                 _TotalCount += Insert_ReportBuffer2(_CounselHistory, _NewEntryNo, _Employee."No.", _Employee.Name, _CounselHistory."Litigation Type"::OpenRequest, 0, 0);

    //                 //‘ð°Š —³Ð
    //                 _NewEntryNo += 1;
    //                 Rec.Init;
    //                 Rec."OBJECT ID" := PAGE::"DK_Litigation Counsel Statics";
    //                 Rec."USER ID" := UserId;
    //                 Rec."Entry No." := _NewEntryNo;
    //                 Rec."SHORT TEXT0" := TotalSumMSG;
    //                 Rec.DECIMAL0 := _TotalCount;
    //                 Rec.INTEGER0 := 1; //–”†ã‹÷
    //                 Rec.INTEGER1 := 1; //—³Ð€ˆŠ¨
    //                 Rec.Insert;
    //                 _GrandTotal += _TotalCount;
    //             end;
    //         until _Employee.Next = 0;
    //     end;

    //     //“© —³Ð
    //     _NewEntryNo += 1;
    //     Rec.Init;
    //     Rec."OBJECT ID" := PAGE::"DK_Litigation Counsel Statics";
    //     Rec."USER ID" := UserId;
    //     Rec."Entry No." := _NewEntryNo;
    //     Rec."SHORT TEXT0" := TotalSumMSG;
    //     Rec.DECIMAL0 := _GrandTotal;
    //     Rec.INTEGER0 := 2; //Š®Š‹÷
    //     Rec.Insert;


    //     if _NewEntryNo > 0 then begin
    //         Rec.SetCurrentKey("Entry No.");
    //         Rec.Ascending(true);
    //         Rec.FindFirst;
    //     end;
    // end;

    // local procedure Insert_ReportBuffer2(var pRec: Record "DK_Counsel History"; var pEntryNo: Integer; pEmployeeNo: Code[20]; pEmployeeName: Text[50]; pLitigationType: Option; pColor: Integer; pTotal: Integer): Decimal
    // var
    //     _TotalCount: Decimal;
    //     _CounselHistory: Record "DK_Counsel History";
    // begin
    //     pEntryNo += 1;

    //     Rec.Init;
    //     Rec."OBJECT ID" := PAGE::"DK_Litigation Counsel Statics";
    //     Rec."USER ID" := UserId;
    //     Rec.INTEGER0 := pColor;   //‹÷‹Ý€ˆŠ¨
    //     Rec.INTEGER1 := pTotal;   //—³Ð€ˆŠ¨
    //     Rec."Entry No." := pEntryNo;
    //     Rec.CODE0 := pEmployeeNo;
    //     Rec."SHORT TEXT0" := pEmployeeName;

    //     case pLitigationType of
    //         CounselHistory."Litigation Type"::Blank:
    //             Rec."SHORT TEXT1" := BlankText;
    //         CounselHistory."Litigation Type"::Reception:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Reception);
    //         CounselHistory."Litigation Type"::Sending:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Sending);
    //         CounselHistory."Litigation Type"::Talk:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Talk);
    //         CounselHistory."Litigation Type"::SMS:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::SMS);
    //         CounselHistory."Litigation Type"::Etc:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Etc);
    //         CounselHistory."Litigation Type"::Mail:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Mail);
    //         CounselHistory."Litigation Type"::Law:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Law);
    //         CounselHistory."Litigation Type"::Visit:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Visit);
    //         CounselHistory."Litigation Type"::Agree:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::Agree);
    //         CounselHistory."Litigation Type"::OpenRequest:
    //             Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type"::OpenRequest);
    //     end;

    //     _CounselHistory.Reset;
    //     _CounselHistory.CopyFilters(pRec);
    //     _CounselHistory.SetRange("Litigation Type", pLitigationType);
    //     if _CounselHistory.FindSet then begin

    //         Rec.DECIMAL0 := _CounselHistory.Count;
    //     end;
    //     Rec.Insert;

    //     exit(Rec.DECIMAL0);
    // end;

    // local procedure Insert_TypeReportBuffer()
    // var
    //     _TotalCount: Decimal;
    // begin
    //     EntryNo += 1;

    //     Init;
    //     Rec."OBJECT ID" := PAGE::"DK_Litigation Counsel Statics";
    //     Rec."USER ID" := UserId;
    //     Rec."Entry No." := EntryNo;
    //     Rec.CODE0 := CounselHistory."Employee No.";
    //     Rec."SHORT TEXT0" := CounselHistory."Employee Name";
    //     Rec."SHORT TEXT1" := Format(CounselHistory."Litigation Type");
    //     Rec.DECIMAL0 := CounselHistory.Count;
    //     Rec.INTEGER0 := 0; //›‘ñ‹÷
    //     Rec.Insert;
    //     ;

    //     _TotalCount += Rec.DECIMAL0;

    //     EntryNo += 1;
    //     Init;
    //     Rec."OBJECT ID" := PAGE::"DK_Litigation Counsel Statics";
    //     Rec."USER ID" := UserId;
    //     Rec."Entry No." := EntryNo;
    //     Rec."SHORT TEXT0" := StrSubstNo(TotalMSG, CounselHistory."Employee Name");
    //     Rec.DECIMAL0 := _TotalCount;
    //     Rec.INTEGER0 := 1; //–”†ã‹÷
    //     INTEGER1 := 1;
    //     Rec.Insert;
    //     ;

    //     TotalCount += _TotalCount;
    // end;

    // local procedure Check_ColorType()
    // begin

    //     case INTEGER0 of
    //         1:
    //             ColorType := 'StandardAccent';
    //         2:
    //             ColorType := 'Attention';
    //         else
    //             ColorType := '';
    //     end;
    // end;

    // local procedure StartDate_Onvalidate()
    // begin
    //     if EndDate <> 0D then begin
    //         if StartDate > EndDate then
    //             Error(MSG002);
    //     end;

    //     SetFilterDelete;
    // end;

    // local procedure EndDate_Onvalidate()
    // begin
    //     if StartDate <> 0D then begin
    //         if StartDate > EndDate then
    //             Error(MSG002);
    //     end;

    //     SetFilterDelete;
    // end;

    // local procedure EmployeeCode_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;

    // local procedure CounselType_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;

    // local procedure ContactMethod_Onvalidate()
    // begin
    //     SetFilterDelete;
    // end;
}

