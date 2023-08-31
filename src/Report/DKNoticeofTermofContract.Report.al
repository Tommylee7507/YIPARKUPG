report 50007 "DK_Notice of Term. of Contract"
{
    RDLCLayout = './src/layout/DKNoticeofTermofContract.rdl';
    WordLayout = './src/layout/DKNoticeofTermofContract.docx';
    Caption = 'Notice of Term. of Contract';
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
            column(ComInfor_Name; ComInfor.Name)
            {
            }
            column(ComInfor_Address; CompAddr)
            {
            }
            column(ComInfor_PostCode; ComInfor."Post Code")
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
            column(CemeterySize; "Cemetery Size")
            {
            }
            column(DepositAmount; "Deposit Amount")
            {
            }
            column(ContractAmount; "Contract Amount")
            {
            }
            column(RemainingAmount; "Remaining Amount")
            {
            }
            column(ContractDate_Year; Format("Contract Date", 0, '<Year4>'))
            {
            }
            column(ContractDate_Month; Format("Contract Date", 0, '<Month,2>'))
            {
            }
            column(ContractDate_Day; Format("Contract Date", 0, '<Day,2>'))
            {
            }
            column(DepositReceiptDate_Year; Format("Deposit Receipt Date", 0, '<Year4>'))
            {
            }
            column(DepositReceiptDate_Month; Format("Deposit Receipt Date", 0, '<Month,2>'))
            {
            }
            column(DepositReceiptDate_Day; Format("Deposit Receipt Date", 0, '<Day,2>'))
            {
            }
            column(PayContractReceDate_Year; Format("Pay. Contract Rece. Date", 0, '<Year4>'))
            {
            }
            column(PayContractReceDate_Month; Format("Pay. Contract Rece. Date", 0, '<Month,2>'))
            {
            }
            column(PayContractReceDate_Day; Format("Pay. Contract Rece. Date", 0, '<Day,2>'))
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
            column(WorkDate_Year; Format(WorkDate, 0, '<Year4>'))
            {
            }
            column(WorkDate_Month; Format(WorkDate, 0, '<Month,2>'))
            {
            }
            column(WorkDate_Day; Format(WorkDate, 0, '<Day,2>'))
            {
            }

            trigger OnAfterGetRecord()
            var
                _ReportPrtHisLitigation: Codeunit "DK_Report Printing";
            begin

                Clear(CustomerAddr);
                Clear(CustomerPhone);

                DK_Contract.CalcFields("Cust. Address", "Cust. Address 2", "Cust. Mobile No.", "Cust. Phone No.");

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
                _ReportPrtHisLitigation.InsertPrintingHistory(DK_Contract, DocumentNo, REPORT::"DK_Notice of Term. of Contract",
                                                              EmployeeNo, EmployeeName, EmployeeMobileNo, 0D);
            end;

            trigger OnPreDataItem()
            begin
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

