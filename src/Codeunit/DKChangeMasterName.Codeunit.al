codeunit 50031 "DK_Change Master Name"
{
    // 
    // #2038 : 2020-07-20
    //   - Modify function: UpdateItemSubCategory
    // 
    // #2107 : 2020-08-18
    //   - Modify function: UpdateCemeteryNo


    trigger OnRun()
    begin
    end;

    var
        MSG001: Label 'If you change the name, all relevant information changes. Are you sure?';


    procedure UpdateCemeteryNo(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Contract: Record DK_Contract;
        _Corpse: Record DK_Corpse;
        _InterestCemeteryLog: Record "DK_Interest Cemetery Log";
        _CustomerRequests: Record "DK_Customer Requests";
        _DevTargetLine: Record "DK_Dev. Target Line";
        _TodayFuneral: Record "DK_Today Funeral";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _SelectedContract: Record "DK_Selected Contract";
        _LitigationLawsuitHistory: Record "DK_Litigation Lawsuit History";
        _PayExpectDocHeader: Record "DK_Pay. Expect Doc. Header";
        _CngCustinContract: Record "DK_Cng. Cust. in Contract";
        _ChangeEvaluationHistory: Record "DK_Change Evaluation History";
        _ReceiptedPGDocument: Record "DK_Receipted PG Document";
        _PayExpectProcessHistory: Record "DK_Pay. Expect Process History";
        _SMS: Record DK_SMS;
        _RelationshipFamily: Record "DK_Relationship Family";
        _CounselHistory: Record "DK_Counsel History";
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
        _ESkyData: Record "DK_E-Sky Data";
    begin

        if pCode = '' then
            exit;

        if pXRecName <> '' then begin
            if not Confirm(MSG001, false) then begin
                pName := pXRecName;
                exit;
            end;
        end;

        _Contract.Reset;
        _Contract.SetRange("Cemetery Code", pCode);
        if _Contract.FindSet then begin
            repeat
                _Contract."Cemetery No." := pName;
                _Contract.Modify(false);

                _CRMDataInterlink.OutboundContract(_Contract);
            until _Contract.Next = 0;
        end;

        _Corpse.Reset;
        _Corpse.SetRange("Cemetery Code", pCode);
        if _Corpse.FindSet then
            _Corpse.ModifyAll("Cemetery No.", pName, false);

        _InterestCemeteryLog.Reset;
        _InterestCemeteryLog.SetRange("Cemetery Code", pCode);
        if _InterestCemeteryLog.FindSet then
            _InterestCemeteryLog.ModifyAll("Cemetery No.", pName, false);

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Cemetery Code", pCode);
        if _CustomerRequests.FindSet then
            _CustomerRequests.ModifyAll("Cemetery No.", pName, false);

        _CustomerRequests.SetRange("Cemetery Code");
        _CustomerRequests.SetRange("Work Cemetery Code", pCode);
        if _CustomerRequests.FindSet then
            _CustomerRequests.ModifyAll("Work Cemetery No.", pName, false);

        _TodayFuneral.Reset;
        _TodayFuneral.SetRange("Cemetery Code", pCode);
        if _TodayFuneral.FindSet then
            _TodayFuneral.ModifyAll("Cemetery No.", pName, false);

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Cemetery Code", pCode);
        if _TodayFuneralLine.FindSet then
            _TodayFuneralLine.ModifyAll("Cemetery No.", pName, false);

        _FieldWorkLineCemetery.Reset;
        _FieldWorkLineCemetery.SetRange("Use Area Code", pCode);
        if _FieldWorkLineCemetery.FindSet then
            _FieldWorkLineCemetery.ModifyAll("Use Area", pName, false);

        _FieldWorkLedgerEntry.Reset;
        _FieldWorkLedgerEntry.SetRange("Cemetery Code", pCode);
        if _FieldWorkLedgerEntry.FindSet then
            _FieldWorkLedgerEntry.ModifyAll("Cemetery No.", pName, false);

        _SelectedContract.Reset;
        _SelectedContract.SetRange("Cemetery Code", pCode);
        if _SelectedContract.FindSet then
            _SelectedContract.ModifyAll("Cemetery No.", pName, false);

        // >> #2107

        _LitigationLawsuitHistory.Reset;
        _LitigationLawsuitHistory.SetRange("Cemetery Code", pCode);
        if _LitigationLawsuitHistory.FindSet then
            _LitigationLawsuitHistory.ModifyAll("Cemetery No.", pName, false);

        _PayExpectDocHeader.Reset;
        _PayExpectDocHeader.SetRange("Cemetery Code", pCode);
        if _PayExpectDocHeader.FindSet then begin
            repeat
                _PayExpectDocHeader."Cemetery No." := pName;
                _PayExpectDocHeader.Modify(false);

                _ReceiptedPGDocument.Reset;
                _ReceiptedPGDocument.SetRange("Pay. Expect Doc No.", _PayExpectDocHeader."Document No.");
                if _ReceiptedPGDocument.FindSet then begin
                    _ReceiptedPGDocument."Cemetery No." := pName;
                    _ReceiptedPGDocument.Modify(false);
                end;
            until _PayExpectDocHeader.Next = 0;
        end;

        _CngCustinContract.Reset;
        _CngCustinContract.SetRange("Cemetery Code", pCode);
        if _CngCustinContract.FindSet then
            _CngCustinContract.ModifyAll("Cemetery No.", pName, false);

        _ChangeEvaluationHistory.Reset;
        _ChangeEvaluationHistory.SetRange("Cemetery Code", pCode);
        if _ChangeEvaluationHistory.FindSet then
            _ChangeEvaluationHistory.ModifyAll("Cemetery No.", pName, false);

        _PayExpectProcessHistory.Reset;
        _PayExpectProcessHistory.SetRange("Cemetery Code", pCode);
        if _PayExpectProcessHistory.FindSet then
            _PayExpectProcessHistory.ModifyAll("Cemetery No.", pName, false);

        _SMS.Reset;
        _SMS.SetRange("Cemetery Code", pCode);
        if _SMS.FindSet then
            _SMS.ModifyAll("Cemetery No.", pName, false);

        _RelationshipFamily.Reset;
        _RelationshipFamily.SetRange("Cemetery Code", pCode);
        if _RelationshipFamily.FindSet then
            _RelationshipFamily.ModifyAll("Cemetery No.", pName, false);

        _CounselHistory.Reset;
        _CounselHistory.SetRange("Cemetery Code", pCode);
        if _CounselHistory.FindSet then
            _CounselHistory.ModifyAll("Cemetery No.", pName, false);

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.SetRange("Cemetery Code", pCode);
        if _PaymentReceiptDocument.FindSet then
            _PaymentReceiptDocument.ModifyAll("Cemetery No.", pName, false);

        _ESkyData.Reset;
        _ESkyData.SetRange("Cemetery Code", pCode);
        if _ESkyData.FindSet then
            _ESkyData.ModifyAll("Cemetery No.", pName, false);

        // <<
    end;


    procedure UpdateEstateGroupName(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Estate: Record DK_Estate;
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Estate.Reset;
        _Estate.SetRange("Group Code", pCode);
        if _Estate.FindSet then
            _Estate.ModifyAll("Group Name", pName, false);
    end;


    procedure UpdateEstateName(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Cemetery: Record DK_Cemetery;
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _CemeteryClassDiscount: Record "DK_Cemetery Class Discount";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _FieldWorkLineCemetery: Record "DK_Field Work Line Cemetery";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Cemetery.Reset;
        _Cemetery.SetRange("Estate Code", pCode);
        if _Cemetery.FindFirst then
            _Cemetery.ModifyAll("Estate Name", pName, false);

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetRange("Estate Code", pCode);
        if _CemeteryUnitPrice.FindFirst then
            _CemeteryUnitPrice.ModifyAll("Estate Name", pName, false);

        _CemeteryClassDiscount.Reset;
        _CemeteryClassDiscount.SetRange("Estate Code", pCode);
        if _CemeteryClassDiscount.FindFirst then
            _CemeteryClassDiscount.ModifyAll("Estate Name", pName, false);

        _FieldWorkLedgerEntry.Reset;
        _FieldWorkLedgerEntry.SetRange("Estate Code", pCode);
        if _FieldWorkLedgerEntry.FindSet then
            _FieldWorkLedgerEntry.ModifyAll("Estate Name", pName, false);

        _FieldWorkLineCemetery.Reset;
        _FieldWorkLineCemetery.SetRange("Use Area Code", pCode);
        if _FieldWorkLineCemetery.FindSet then
            _FieldWorkLineCemetery.ModifyAll("Use Area", pName, false);

        _FieldWorkLineCemetery.SetRange("Use Area Code");
        _FieldWorkLineCemetery.SetRange("Cemetery Estate Code", pCode);
        if _FieldWorkLineCemetery.FindSet then
            _FieldWorkLineCemetery.ModifyAll("Cemetery Estate Name", pName, false);
    end;


    procedure UpdateCemeteryConformation(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Cemetery: Record DK_Cemetery;
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _CemeteryClassDiscount: Record "DK_Cemetery Class Discount";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery Conf. Code", pCode);
        if _Cemetery.FindSet then
            _Cemetery.ModifyAll("Cemetery Conf. Name", pName, false);

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetRange("Cemetery Conf. Code", pCode);
        if _CemeteryUnitPrice.FindSet then
            _CemeteryUnitPrice.ModifyAll("Cemetery Conf. Name", pName, false);

        _CemeteryClassDiscount.Reset;
        _CemeteryClassDiscount.SetRange("Cemetery Conf. Code", pCode);
        if _CemeteryClassDiscount.FindSet then
            _CemeteryClassDiscount.ModifyAll("Cemetery Conf. Name", pName, false);
    end;


    procedure UpdateCemeteryOption(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Cemetery: Record DK_Cemetery;
        _CemeteryUnitPrice: Record "DK_Cemetery Unit Price";
        _CemeteryClassDiscount: Record "DK_Cemetery Class Discount";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Cemetery.Reset;
        _Cemetery.SetRange("Cemetery Option Code", pCode);
        if _Cemetery.FindSet then
            _Cemetery.ModifyAll("Cemetery Option Name", pName, false);

        _CemeteryUnitPrice.Reset;
        _CemeteryUnitPrice.SetRange("Cemetery Option Code", pCode);
        if _CemeteryUnitPrice.FindSet then
            _CemeteryUnitPrice.ModifyAll("Cemetery Option Name", pName, false);

        _CemeteryClassDiscount.Reset;
        _CemeteryClassDiscount.SetRange("Cemetery Option Code", pCode);
        if _CemeteryClassDiscount.FindSet then
            _CemeteryClassDiscount.ModifyAll("Cemetery Option Name", pName, false);
    end;


    procedure UpdateCustomer(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Contract: Record DK_Contract;
        _PublishAdminExpDocLi: Record "DK_Publish Admin. Exp. Doc. Li";
        _RevocationContract: Record "DK_Revocation Contract";
        _ESkyData: Record "DK_E-Sky Data";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;
        //‘´ ×„
        _Contract.Reset;
        _Contract.SetRange("Main Customer No.", pCode);
        if _Contract.FindSet then
            _Contract.ModifyAll("Main Customer Name", pName, false);
        //°…ˆ×—1
        _Contract.Reset;
        _Contract.SetRange("Customer No. 2", pCode);
        if _Contract.FindSet then
            _Contract.ModifyAll("Customer Name 2", pName, false);
        //°…ˆ×—2
        _Contract.Reset;
        _Contract.SetRange("Customer No. 3", pCode);
        if _Contract.FindSet then
            _Contract.ModifyAll("Customer Name 3", pName, false);

        _PublishAdminExpDocLi.Reset;
        _PublishAdminExpDocLi.SetRange("Customer No.", pCode);
        if _PublishAdminExpDocLi.FindSet then
            _PublishAdminExpDocLi.ModifyAll("Customer Name", pName, false);

        _RevocationContract.Reset;
        _RevocationContract.SetRange("Customer No.", pCode);
        if _RevocationContract.FindSet then
            _RevocationContract.ModifyAll("Customer Name", pName, false);

        _ESkyData.Reset;
        _ESkyData.SetRange("Main Customer No.", pCode);
        if _ESkyData.FindSet then
            _ESkyData.ModifyAll("Main Customer Name", pName, false);
    end;


    procedure UpdateItemMainCategory(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Item: Record DK_Item;
        _PurchaseLine: Record "DK_Purchase Line";
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _RequestExpensesLine: Record "DK_Request Expenses Line";
        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Item.Reset;
        _Item.SetRange("Item Main Cat. Code", pCode);
        if _Item.FindSet then
            _Item.ModifyAll("Item Main Cat. Name", pName, false);

        _PurchaseLine.Reset;
        _PurchaseLine.SetRange("Item Main Cat. Code", pCode);
        if _PurchaseLine.FindSet then
            _PurchaseLine.ModifyAll("Item Main Cat. Name", pName, false);

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Item Main Cat. Code", pCode);
        if _ItemLedgerEntry.FindSet then
            _ItemLedgerEntry.ModifyAll("Item Main Cat. Name", pName, false);

        _RequestExpensesLine.Reset;
        _RequestExpensesLine.SetRange("Item Main Cat. Code", pCode);
        if _RequestExpensesLine.FindSet then
            _RequestExpensesLine.ModifyAll("Item Main Cat. Name", pName, false);

        _PostedPurchaseReceipt.Reset;
        _PostedPurchaseReceipt.SetRange("Item Main Cat. Code", pCode);
        if _PostedPurchaseReceipt.FindSet then
            _PostedPurchaseReceipt.ModifyAll("Item Main Cat. Name", pName, false);
    end;


    procedure UpdateItemSubCategory(pMainCode: Code[20]; pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Item: Record DK_Item;
        _PurchaseLine: Record "DK_Purchase Line";
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _RequestExpensesLine: Record "DK_Request Expenses Line";
        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Item.Reset;
        _Item.SetRange("Item Main Cat. Code", pMainCode);
        _Item.SetRange("Item Sub Cat. Code", pCode);
        if _Item.FindSet then
            _Item.ModifyAll("Item Sub Cat. Name", pName, false);

        _PurchaseLine.Reset;
        _PurchaseLine.SetRange("Item Main Cat. Code", pMainCode);
        _PurchaseLine.SetRange("Item Sub Cat. Code", pCode);
        if _PurchaseLine.FindSet then
            _PurchaseLine.ModifyAll("Item Sub Cat. Name", pName, false);

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Item Main Cat. Code", pMainCode);
        _ItemLedgerEntry.SetRange("Item Sub Cat. Code", pCode);
        if _ItemLedgerEntry.FindSet then
            _ItemLedgerEntry.ModifyAll("Item Sub Cat. Name", pName, false);

        _RequestExpensesLine.Reset;
        _RequestExpensesLine.SetRange("Item Main Cat. Code", pMainCode);
        _RequestExpensesLine.SetRange("Item Sub Cat. Code", pCode);
        if _RequestExpensesLine.FindSet then
            _RequestExpensesLine.ModifyAll("Item Sub Cat. Name", pName, false);

        _PostedPurchaseReceipt.Reset;
        _PostedPurchaseReceipt.SetRange("Item Main Cat. Code", pMainCode);
        _PostedPurchaseReceipt.SetRange("Item Sub Cat. Code", pCode);
        if _PostedPurchaseReceipt.FindSet then
            _PostedPurchaseReceipt.ModifyAll("Item Sub Cat. Name", pName, false);
    end;


    procedure UpdateDepartment(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _PurchaseContract: Record "DK_Purchase Contract";
        _Employee: Record DK_Employee;
        _RequestExpensesHeader: Record "DK_Request Expenses Header";
        _PurchaseContractAuthority: Record "DK_Purchase Contract Authority";
        _Alarm: Record DK_Alarm;
        _DepartmentBoard: Record "DK_Department Board";
    begin

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        if pCode = '' then
            exit;

        _PurchaseContract.Reset;
        _PurchaseContract.SetRange("Department Code", pCode);
        if _PurchaseContract.FindSet then
            _PurchaseContract.ModifyAll("Department Name", pName, false);

        _Employee.Reset;
        _Employee.SetRange("Department Code", pCode);
        if _Employee.FindSet then
            _Employee.ModifyAll("Department Name", pName, false);

        _RequestExpensesHeader.Reset;
        _RequestExpensesHeader.SetRange("Department Code", pCode);
        if _RequestExpensesHeader.FindSet then
            _RequestExpensesHeader.ModifyAll("Department Name", pName, false);

        _PurchaseContractAuthority.Reset;
        _PurchaseContractAuthority.SetRange("Department Code", pCode);
        if _PurchaseContractAuthority.FindSet then
            _PurchaseContractAuthority.ModifyAll("Department Name", pName, false);

        _Alarm.Reset;
        _Alarm.SetRange("Recipient Code", pCode);
        if _Alarm.FindSet then
            _Alarm.ModifyAll("Recipient Name", pName, false);

        _DepartmentBoard.Reset;
        _DepartmentBoard.SetRange("Department Code", pCode);
        if _DepartmentBoard.FindSet then
            _DepartmentBoard.ModifyAll("Department Name", pName, false);
    end;


    procedure UpdateCounselLevel2(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _CounselHistory: Record "DK_Counsel History";
    begin

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        if pCode = '' then
            exit;

        _CounselHistory.Reset;
        _CounselHistory.SetRange("Counsel Level Code 2", pCode);
        if _CounselHistory.FindSet then
            _CounselHistory.ModifyAll("Counsel Level Name 2", pName, false);
    end;


    procedure UpdateLocation(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _PurchaseLine: Record "DK_Purchase Line";
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _PurchaseLine.Reset;
        _PurchaseLine.SetRange("Location Code", pCode);
        if _PurchaseLine.FindSet then
            _PurchaseLine.ModifyAll("Location Name", pName, false);

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Location Code", pCode);
        if _ItemLedgerEntry.FindSet then
            _ItemLedgerEntry.ModifyAll("Location Name", pName, false);

        _PostedPurchaseReceipt.Reset;
        _PostedPurchaseReceipt.SetRange("Location Code", pCode);
        if _PostedPurchaseReceipt.FindSet then
            _PostedPurchaseReceipt.ModifyAll("Location Name", pName, false);
    end;


    procedure UpdateShipmentType(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
    begin
        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _PostedPurchaseReceipt.Reset;
        _PostedPurchaseReceipt.SetRange("Shipment Type Code", pCode);
        if _PostedPurchaseReceipt.FindSet then
            _PostedPurchaseReceipt.ModifyAll("Shipment Type", pName, false);
    end;


    procedure UpdateWorkManager(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _CustomerRequests: Record "DK_Customer Requests";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Work Manager Code", pCode);
        if _FieldWorkHeader.FindSet then
            _FieldWorkHeader.ModifyAll("Work Manager Name", pName, false);

        _FieldWorkLedgerEntry.Reset;
        _FieldWorkLedgerEntry.SetRange("Work Manager Code", pCode);
        if _FieldWorkLedgerEntry.FindSet then
            _FieldWorkLedgerEntry.ModifyAll("Work Manager", pName, false);

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Work Manager Code", pCode);
        if _CustomerRequests.FindSet then
            _CustomerRequests.ModifyAll("Work Manager", pName, false);
    end;


    procedure UpdateWorkGroup(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _PostedPurchaseReceipt: Record "DK_Posted Purchase Receipt";
        _TodayFuneral: Record "DK_Today Funeral";
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _CustomerRequests: Record "DK_Customer Requests";
        _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Working Group Code", pCode);
        if _ItemLedgerEntry.FindSet then
            _ItemLedgerEntry.ModifyAll("Working Group Name", pName, false);

        _PostedPurchaseReceipt.Reset;
        _PostedPurchaseReceipt.SetRange("Working Group Code", pCode);
        if _PostedPurchaseReceipt.FindSet then
            _PostedPurchaseReceipt.ModifyAll("Working Group", pName, false);

        _TodayFuneral.Reset;
        _TodayFuneral.SetRange("Working Group Code", pCode);
        if _TodayFuneral.FindSet then
            _TodayFuneral.ModifyAll("Working Group Name", pName, false);

        _FieldWorkHeader.Reset;
        _FieldWorkHeader.SetRange("Work Group Code", pCode);
        if _FieldWorkHeader.FindSet then
            _FieldWorkHeader.ModifyAll("Work Group Name", pName, false);

        _FieldWorkLedgerEntry.Reset;
        _FieldWorkLedgerEntry.SetRange("Work Group Code", pCode);
        if _FieldWorkLedgerEntry.FindSet then
            _FieldWorkLedgerEntry.ModifyAll("Work Group", pName, false);

        _CustomerRequests.Reset;
        _CustomerRequests.SetRange("Work Group Code", pCode);
        if _CustomerRequests.FindSet then
            _CustomerRequests.ModifyAll("Work Group", pName, false);

        _FieldWorkSubCatDetail.Reset;
        _FieldWorkSubCatDetail.SetRange("Used Assets No.", pCode);
        if _FieldWorkSubCatDetail.FindSet then
            _FieldWorkSubCatDetail.ModifyAll("Used Assets No.", pName, false);
    end;


    procedure UpdatePaymentMethod(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _PaymentReceiptDocument: Record "DK_Payment Receipt Document";
    begin

        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _PaymentReceiptDocument.Reset;
        _PaymentReceiptDocument.SetRange("Payment Method Code", pCode);
        if _PaymentReceiptDocument.FindSet then
            _PaymentReceiptDocument.ModifyAll("Payment Method Name", pName, false);
    end;


    procedure UpdateTreeType(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Cemetery: Record DK_Cemetery;
    begin

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;
        if pCode = '' then
            exit;

        _Cemetery.Reset;
        _Cemetery.SetRange("Tree Type Code", pCode);
        if _Cemetery.FindSet then
            _Cemetery.ModifyAll("Tree Type Name", pName, false);
    end;


    procedure UpdateDepartmentMain(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _Department: Record DK_Department;
    begin
        if pCode = '' then
            exit;

        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;

        _Department.Reset;
        _Department.SetRange("Department Main Cat. Code", pCode);
        if _Department.FindSet then
            _Department.ModifyAll("Department Main Cat. Name", pName, false);
    end;


    procedure UpdateFieldWorkMainCat(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _TodayFuneral: Record "DK_Today Funeral";
        _ContractAmountLedger: Record "DK_Contract Amount Ledger";
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _CemeteryServices: Record "DK_Cemetery Services";
    begin
        /*
        IF pCode = '' THEN
          EXIT;
        
        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;
        
        _CustomerRequests.RESET;
        _CustomerRequests.SETRANGE("Field Work Main Cat. Code",pCode);
        IF _CustomerRequests.FINDSET THEN
          _CustomerRequests.MODIFYALL("Field Work Main Cat. Name",pName, FALSE);
        
        _TodayFuneral.RESET;
        _TodayFuneral.SETRANGE("Field Work Main Cat. Code", pCode);
        IF _TodayFuneral.FINDSET THEN
          _TodayFuneral.MODIFYALL("Field Work Main Cat. Name", pName, FALSE);
        
        _ContractAmountLedger.RESET;
        _ContractAmountLedger.SETRANGE("Field Work Main Cat. Code", pCode);
        IF _ContractAmountLedger.FINDSET THEN
          _ContractAmountLedger.MODIFYALL("Field Work Main Cat. Name", pName, FALSE);
        
        _FieldWorkHeader.RESET;
        _FieldWorkHeader.SETRANGE("Field Work Main Cat. Code", pCode);
        IF _FieldWorkHeader.FINDSET THEN
          _FieldWorkHeader.MODIFYALL("Field Work Main Cat. Name", pName, FALSE);
        
        _FieldWorkLedgerEntry.RESET;
        _FieldWorkLedgerEntry.SETRANGE("Work Main Cat. Code", pCode);
        IF _FieldWorkLedgerEntry.FINDSET THEN
          _FieldWorkLedgerEntry.MODIFYALL("Work Main Cat. Name", pName, FALSE);
        
        _TodayFuneralLine.RESET;
        _TodayFuneralLine.SETRANGE("Field Work Main Cat. Code", pCode);
        IF _TodayFuneralLine.FINDSET THEN
          _TodayFuneralLine.MODIFYALL("Field Work Main Cat. Name", pName, FALSE);
        
        _CemeteryServices.RESET;
        _CemeteryServices.SETRANGE("Field Work Main Cat. Code", pCode);
        IF _CemeteryServices.FINDSET THEN
          _CemeteryServices.MODIFYALL("Field Work Main Cat. Name", pName, FALSE);
          */

    end;


    procedure UpdateFieldWorkSubCat(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _CustomerRequests: Record "DK_Customer Requests";
        _TodayFuneral: Record "DK_Today Funeral";
        _ContractAmountLedger: Record "DK_Contract Amount Ledger";
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
        _FieldWorkLedgerEntry: Record "DK_Field Work Ledger Entry";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
        _CemeteryServices: Record "DK_Cemetery Services";
    begin
        /*
        IF pCode = '' THEN
          EXIT;
        
        //IF NOT CONFIRM(MSG001,FALSE) THEN BEGIN
        //  pName := pXRecName;
        //  EXIT;
        //END;
        
        _CustomerRequests.RESET;
        _CustomerRequests.SETRANGE("Field Work Sub Cat. Code",pCode);
        IF _CustomerRequests.FINDSET THEN
          _CustomerRequests.MODIFYALL("Field Work Sub Cat. Name",pName, FALSE);
        
        _TodayFuneral.RESET;
        _TodayFuneral.SETRANGE("Field Work Sub Cat. Code",pCode);
        IF _TodayFuneral.FINDSET THEN
          _TodayFuneral.MODIFYALL("Field Work Main Cat. Name", pName, FALSE);
        
        _ContractAmountLedger.RESET;
        _ContractAmountLedger.SETRANGE("Field Work Sub Cat. Code", pCode);
        IF _ContractAmountLedger.FINDSET THEN
          _ContractAmountLedger.MODIFYALL("Field Work Sub Cat. Name", pName, FALSE);
        
        _FieldWorkHeader.RESET;
        _FieldWorkHeader.SETRANGE("Field Work Sub Cat. Code", pCode);
        IF _FieldWorkHeader.FINDSET THEN
          _FieldWorkHeader.MODIFYALL("Field Work Sub Cat. Name", pName, FALSE);
        
        _FieldWorkLineItem.RESET;
        _FieldWorkLineItem.SETRANGE("Field Work Sub Cat. Code", pCode);
        IF _FieldWorkLineItem.FINDSET THEN
          _FieldWorkLineItem.MODIFYALL("Field Work Sub Cat. Name", pName, FALSE);
        
        _FieldWorkLedgerEntry.RESET;
        _FieldWorkLedgerEntry.SETRANGE("Work Sub Cat. Code", pCode);
        IF _FieldWorkLedgerEntry.FINDSET THEN
          _FieldWorkLedgerEntry.MODIFYALL("Work Sub Cat. Name", pName, FALSE);
        
        _TodayFuneralLine.RESET;
        _TodayFuneralLine.SETRANGE("Field Work Sub Cat. Code", pCode);
        IF _TodayFuneralLine.FINDSET THEN
          _TodayFuneralLine.MODIFYALL("Field Work Sub Cat. Name", pName, FALSE);
        
        _CemeteryServices.RESET;
        _CemeteryServices.SETRANGE("Field Work Sub Cat. Code",pCode);
        IF _CemeteryServices.FINDSET THEN
          _CemeteryServices.MODIFYALL("Field Work Sub Cat. Name", pName, FALSE);
          */

    end;


    procedure UpdateItem(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
    begin
        if pCode = '' then
            exit;

        _FieldWorkSubCatDetail.Reset;
        _FieldWorkSubCatDetail.SetRange("Used Assets No.", pCode);
        if _FieldWorkSubCatDetail.FindSet then
            _FieldWorkSubCatDetail.ModifyAll("Used Assets", pName, false);
    end;


    procedure UpdateVehicle(pCode: Code[20]; var pName: Text[50]; pXRecName: Text[50])
    var
        _FieldWorkSubCatDetail: Record "DK_Field Work Sub Cat. Detail";
    begin
        if pCode = '' then
            exit;

        _FieldWorkSubCatDetail.Reset;
        _FieldWorkSubCatDetail.SetRange("Used Assets No.", pCode);
        if _FieldWorkSubCatDetail.FindSet then
            _FieldWorkSubCatDetail.ModifyAll("Used Assets", pName, false);
    end;
}

