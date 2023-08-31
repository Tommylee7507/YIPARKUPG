report 50005 "DK_Reminder 1st"
{
    RDLCLayout = './src/layout/DKReminder1st.rdl';
    WordLayout = './src/layout/DKReminder1st.docx';
    Caption = 'Reminder 1st';
    DefaultLayout = Word;
    //// PDFFontEmbedding = false;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DK_Contract; DK_Contract)
        {
            DataItemTableView = SORTING("No.");
            column(DocumentNo; DocumentNo)
            {
            }
            column(ContractNo; "No.")
            {
            }
            column(SuperviseNo; "Supervise No.")
            {
            }
            column(CemeteryCode; "Cemetery Code")
            {
            }
            column(CemeteryNo; "Cemetery No.")
            {
            }
            column(CemeteryStatus; "Cemetery Status")
            {
            }
            column(ContractDate; "Contract Date")
            {
            }
            column(ComInfor_Name; ComInfor.Name)
            {
            }
            column(ComInfor_Address; CompAddr)
            {
            }
            column(ComInfor_PostCode; ComInfor."Post Code")
            {
            }
            column(WorkDate_Year; Format(WorkDate, 0, '<Year4>'))
            {
            }
            column(WorkDate_Month; Format(WorkDate, 0, '<Month,2>'))
            {
            }
            column(WorkDate_Day; Format(WorkDate, 0, '<Day,2>'))
            {
            }
            column(MainCustomerName; DK_Contract."Main Customer Name")
            {
            }
            column(CustAddress; CustomerAddr)
            {
            }
            column(CustPhoneNo; CustomerPhone)
            {
            }
            column(EmpName; EmployeeName)
            {
            }
            column(DeptName; DepartmentName)
            {
            }
            column(EmpMobileNo; EmployeeMobileNo)
            {
            }
            column(EmpJobTitle; EmployeeJobTitle)
            {
            }
            column(RemainingDueDate_Year; Format("Remaining Due Date", 0, '<Year4>'))
            {
            }
            column(RemainingDueDate_Month; Format("Remaining Due Date", 0, '<Month,2>'))
            {
            }
            column(RemainingDueDate_Day; Format("Remaining Due Date", 0, '<Day,2>'))
            {
            }
            column(PayRemainingAmount; "Pay. Remaining Amount")
            {
                AutoFormatType = 1;
            }
            column(BankName_; BankName)
            {
            }
            column(BankAccountNo_; BankAccountNo)
            {
            }
            column(AccountHolder_; AccountHolder)
            {
            }
            column(AddPaymentDate_Year; Format(AddRemainingDueDate, 0, '<Year4>'))
            {
            }
            column(AddPaymentDate_Month; Format(AddRemainingDueDate, 0, '<Month,2>'))
            {
            }
            column(AddPaymentDate_Day; Format(AddRemainingDueDate, 0, '<Day,2>'))
            {
            }

            trigger OnAfterGetRecord()
            var
                _ReportPrtHisLitigation: Codeunit "DK_Report Printing";
            begin

                Clear(CustomerAddr);
                Clear(CustomerPhone);

                DK_Contract.CalcFields("Cust. Address", "Cust. Address 2", "Cust. Mobile No.", "Cust. Phone No.", "Cemetery Status");

                if DK_Contract."Cust. Address 2" <> '' then
                    CustomerAddr := DK_Contract."Cust. Address" + ' ' + DK_Contract."Cust. Address 2"
                else
                    CustomerAddr := DK_Contract."Cust. Address";

                if DK_Contract."Cust. Phone No." = '' then
                    CustomerPhone := DK_Contract."Cust. Mobile No."
                else
                    CustomerPhone := DK_Contract."Cust. Phone No.";



                Clear(_ReportPrtHisLitigation);
                DocumentNo := _ReportPrtHisLitigation.GetNewDocmentNo;
                _ReportPrtHisLitigation.InsertPrintingHistory(DK_Contract, DocumentNo, REPORT::"DK_Reminder 1st",
                                                              EmployeeNo, EmployeeName, EmployeeMobileNo, AddRemainingDueDate);

                "Reminder Date 1" := WorkDate;
                "Add. Remaining Due Date 1" := AddRemainingDueDate;
                Modify;
            end;

            trigger OnPreDataItem()
            begin
                //Check
                if AddRemainingDueDate = 0D then
                    Error(MSG006);
                if EmployeeNo = '' then
                    Error(MSG001);
                if EmployeeName = '' then
                    Error(MSG002);
                if DepartmentName = '' then
                    Error(MSG003);
                if EmployeeMobileNo = '' then
                    Error(MSG004, Employee.FieldCaption("Business Contacts"));


                if ComInfor.Get then
                    if ComInfor."Address 2" <> '' then
                        CompAddr := ComInfor.Address + ' ' + ComInfor."Address 2"
                    else
                        CompAddr := ComInfor.Address;

                //Reporting Filters
                DK_Contract.SetRange("User ID Filter", UserId);
                DK_Contract.SetRange("Selected Contract", true);
                //Reporting Filters
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    Caption = 'General';
                    field(AddRemainingDueDate; AddRemainingDueDate)
                    {
                        Caption = 'Add.Remaining Due Date';

                        trigger OnValidate()
                        begin
                            if AddRemainingDueDate = 0D then
                                Error(MSG006);

                            if AddRemainingDueDate <= Today then
                                Error(MSG009, Today);
                        end;
                    }
                    field(BankCode; BankCode)
                    {
                        Caption = 'Bank Code';
                        TableRelation = "DK_Receipt Bank Account".Code WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        var
                            _ReceiptBankAccount: Record "DK_Receipt Bank Account";
                        begin

                            _ReceiptBankAccount.Reset;
                            _ReceiptBankAccount.SetRange(Code, BankCode);
                            if _ReceiptBankAccount.FindSet then begin
                                BankName := _ReceiptBankAccount."Bank Name";
                                BankAccountNo := _ReceiptBankAccount."Bank Account No.";
                                AccountHolder := _ReceiptBankAccount."Account Holder";

                                if (BankName = '') or (BankAccountNo = '') or (AccountHolder = '') then
                                    Error(MSG008, _ReceiptBankAccount.TableCaption,
                                              _ReceiptBankAccount.FieldCaption(Code),
                                              _ReceiptBankAccount.Code,
                                              _ReceiptBankAccount.FieldCaption("Bank Name"),
                                              _ReceiptBankAccount.FieldCaption("Bank Account No."),
                                              _ReceiptBankAccount.FieldCaption("Account Holder"));
                            end;
                        end;
                    }
                    field(BankName; BankName)
                    {
                        Caption = 'Bank Name';
                        Editable = false;
                    }
                    field(BankAccountNo; BankAccountNo)
                    {
                        Caption = 'Bank Account No.';
                        Editable = false;
                    }
                    field(AccountHolder; AccountHolder)
                    {
                        Caption = 'Account Holder';
                        Editable = false;
                    }
                }
                group(Employee)
                {
                    Caption = 'Employee';
                    field(EmployeeNo; EmployeeNo)
                    {
                        Caption = 'Employee No.';
                        TableRelation = DK_Employee WHERE(Blocked = CONST(false));

                        trigger OnValidate()
                        begin
                            GetEmplyee;
                        end;
                    }
                    field(EmployeeName; EmployeeName)
                    {
                        Caption = 'Employee Name';
                        Editable = false;
                    }
                    field(DepartmentName; DepartmentName)
                    {
                        Caption = 'Department';
                        Editable = false;
                    }
                    field(EmployeeMobileNo; EmployeeMobileNo)
                    {
                        Caption = 'Employee Contacts';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            /*
            ReceiptBankAccount.RESET;
            ReceiptBankAccount.SETRANGE(Litigation, TRUE);
            ReceiptBankAccount.SETRANGE(Blocked, FALSE);
            IF ReceiptBankAccount.FINDSET THEN BEGIN
              BankName := ReceiptBankAccount."Bank Name";
              BankAccountNo := ReceiptBankAccount."Bank Account No.";
              AccountHolder := ReceiptBankAccount."Account Holder";
            
              IF (BankName = '') OR (BankAccountNo = '') OR (AccountHolder = '') THEN
                ERROR(MSG008, ReceiptBankAccount.TABLECAPTION,
                          ReceiptBankAccount.FIELDCAPTION(Code),
                          ReceiptBankAccount.Code,
                          ReceiptBankAccount.FIELDCAPTION("Bank Name"),
                          ReceiptBankAccount.FIELDCAPTION("Bank Account No."),
                          ReceiptBankAccount.FIELDCAPTION("Account Holder"));
            END ELSE BEGIN
              ERROR(MSG007, ReceiptBankAccount.TABLECAPTION,
                        ReceiptBankAccount.FIELDCAPTION(Litigation),
                        ReceiptBankAccount.FIELDCAPTION(Blocked));
            END;
            */

            //€ËŠ‹¬
            AddRemainingDueDate := CalcDate('<+30D>', WorkDate);

            Clear(ReportPrintingHistory);
            EmployeeNo := ReportPrintingHistory.GetEmployeeNo;
            GetEmplyee;

        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FunctionSetup.Get;
        if FunctionSetup."Litigation Printing Nos." = '' then
            Error(MSG005, FunctionSetup.TableCaption, FunctionSetup.FieldCaption("Litigation Printing Nos."));
    end;

    var
        ComInfor: Record "Company Information";
        DocumentNo: Code[20];
        EmployeeNo: Code[20];
        EmployeeName: Text[50];
        DepartmentName: Text[50];
        EmployeeMobileNo: Text[20];
        EmployeeJobTitle: Text[30];
        CompAddr: Text[200];
        CustomerAddr: Text[200];
        CustomerPhone: Text[30];
        Employee: Record DK_Employee;
        MSG001: Label 'You must specify a Employee No.';
        MSG002: Label 'Employee information is not name. Please contact your manager to update your employee information.';
        MSG003: Label 'Employee information is not Department. Please contact your manager to update your employee information.';
        MSG004: Label 'Employee information is not %1. Please contact your manager to update your employee information.';
        FunctionSetup: Record "DK_Function Setup";
        MSG005: Label '%2 is not specified in %1. Please contact your administrator to update your information.';
        ReceiptBankAccount: Record "DK_Receipt Bank Account";
        BankCode: Code[20];
        BankName: Text[20];
        BankAccountNo: Code[30];
        AccountHolder: Text[30];
        AddRemainingDueDate: Date;
        MSG006: Label 'You must specify a Add. Remaining Due Date';
        MSG007: Label 'The %1 does not exist. Check %2 and %3 in the %1.';
        MSG008: Label '%1 information is incorrect. %4 and %5 and %6 in %1 is required. %2:%3';
        MSG009: Label 'The Add. Remaining Due Date should be greater than today.';
        ReportPrintingHistory: Codeunit "DK_Report Printing";

    local procedure GetEmplyee()
    begin

        if Employee.Get(EmployeeNo) then begin
            EmployeeName := Employee.Name;
            DepartmentName := Employee."Department Name";
            EmployeeMobileNo := Employee."Business Contacts";
            EmployeeJobTitle := Employee."Job Title";
        end else begin
            EmployeeName := '';
            DepartmentName := '';
            EmployeeMobileNo := '';
            EmployeeJobTitle := '';
        end;
    end;
}

