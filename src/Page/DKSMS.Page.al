page 50082 DK_SMS
{
    // 
    // DK34: 20201026
    //   - Add Text Constants: ReagreeMSG
    //   - Rec. Modify Function: SetMessageType

    Caption = 'SMS';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_SMS;
    SourceTableView = SORTING("Department Code", "Line No.");

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control19)
                {
                    ShowCaption = false;
                    field("Line No."; Rec."Line No.")
                    {
                        Editable = false;
                    }
                    field(Type; Rec.Type)
                    {
                        Editable = Rec."Line No." = 0;
                        Enabled = Rec."Line No." = 0;

                        trigger OnValidate()
                        begin
                            SetMessageType;
                        end;
                    }
                    field(Description; Rec.Description)
                    {
                    }
                    field("Biz Talk Tamplate No."; Rec."Biz Talk Tamplate No.")
                    {
                    }
                    field(MessageType; MessageType)
                    {
                        Caption = 'Define Message';
                        Editable = false;
                        MultiLine = true;
                    }
                }
                group(Control16)
                {
                    ShowCaption = false;
                    group(Message)
                    {
                        Caption = 'Message';
                        field("Short Message"; Rec."Short Message")
                        {
                            MultiLine = true;
                            ShowCaption = false;

                            trigger OnValidate()
                            var
                                _CommonFunction: Codeunit "DK_Common Function";
                            begin
                            end;
                        }
                    }
                    field("SMS Length"; Rec."SMS Length")
                    {
                        Caption = 'Length';
                    }
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        //"Department Code" := GetDepartmentCode;
    end;

    trigger OnOpenPage()
    begin
        SetMessageType;
    end;

    var
        MSG001: Label 'The message length exceeds 2000 bytes. Only messages of 2000 bytes or less can be sent.';
        MessageType: Text[2000];
        GeneralMSG: Label '%1:Customer Name, %2:Cemetery No., %3:General Expiration Date, %4:Landscape Expiration Date, %5: General Non-Payment, %6: Landscape Non-Payment, %7: TODAY, %8: General Start Date, %9: Landscape Start Date, %10: Bank Account NH, %11: Bank Account IBK, %12: General Expiration Date (atfer 5 Year), %13: General Payment (5 Year), %14: Landscape Expiration Date (atfer 5 Year), %15: Landscape Payment (5 year), %16: General Expiration Date (atfer 1 Year), %17: General Payment (1 Year), %18: Landscape Expiration Date (atfer 1 Year), %19: Landscape Payment (1 year), %20: General Expiration Date (atfer 2 Year), %21: General Payment (2 Year), %22: Landscape Expiration Date (atfer 2 Year), %23: Landscape Payment (2 year), %24:Total (5 Year), %25:Total (1 Year), %26:Total (2 Year)';
        ServiceMSG: Label '%1: Applicant Name,%2: Field Work Main Category,%3: Field Work Sub Category,%4: Process Date,%5: Process Content';
        VehicleMSG: Label '%1: Vehicle No.,%2: Vehicle Name,%3: Repair Date,%4: Repair Item Type,%5: Receiver';
        RemAmountMSG: Label '%1: Customer Name,%2: Cemetery No.,%3: Contract Amount,%4: Remaining Amount,%5: Pay. Remaining Amount,%6:Remaining Due Date';
        FieldWorkMSG: Label '%1: Applicant Name,%2: Field Work Main Category,%3: Field Work Sub Category,%4: Process Content';
        PurchContractMSG: Label '%1: Purhcase Contract Title,%2: Contract Date To,%3: Contract Amount, %4: Department, %5: Contrct Content';
        CustRequestMSG: Label '%1: Applicant Name,%2: Field Work Sub Category,%3:Receipt Date,%4: Process Date,%5: Process Content';
        ReceiptMSG: Label '%1: Depositor,%2: Payment,%3: Cemetery No.,%4: Payment Target,%5: Process Content';
        PaymentExpensePGMSG: Label '%1: Applicant Name,%2: Cemetery No.,%3: Amount,%4: Expiration Date,%5: Link URL';
        PaymentExpenseVAMSG: Label '%1: Applicant Name,%2: Cemetery No.,%3: Virtual Account No.,%4: Bank Name,%5: Account Holder,%6: Amount,%7: Expiration Date';
        ReagreeMSG: Label '%1: Name, %2: Type, %3: Today, %4: Personal Data concu. Date, %5: Mobile No.';

    local procedure GetDepartmentCode(): Code[20]
    var
        _Employee: Record DK_Employee;
    begin

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then
            exit(_Employee."Department Code");
    end;

    local procedure SetMessageType()
    begin

        case Rec.Type of
            Rec.Type::General:
                begin
                    MessageType := GeneralMSG;
                end;
            Rec.Type::Service:
                begin
                    MessageType := ServiceMSG;
                end;
            Rec.Type::Vehicle:
                begin
                    MessageType := VehicleMSG;
                end;
            Rec.Type::RemAmount:
                begin
                    MessageType := RemAmountMSG;
                end;
            Rec.Type::FieldWork:
                begin
                    MessageType := FieldWorkMSG;
                end;
            Rec.Type::PurchContract:
                begin
                    MessageType := PurchContractMSG;
                end;
            Rec.Type::CustRequest:
                begin
                    MessageType := CustRequestMSG;
                end;
            Rec.Type::Receipt:
                begin
                    MessageType := ReceiptMSG;
                end;
            Rec.Type::PaymentExpectPG:
                begin
                    MessageType := PaymentExpensePGMSG;
                end;
            Rec.Type::PaymentExpectVA:
                begin
                    MessageType := PaymentExpenseVAMSG;
                end;
            Rec.Type::ReagreeInfo:
                begin
                    MessageType := ReagreeMSG;
                end;
        end;

        CurrPage.Update;
    end;
}

