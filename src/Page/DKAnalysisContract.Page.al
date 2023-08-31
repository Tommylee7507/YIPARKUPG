page 50215 "DK_Analysis Contract"
{
    Caption = 'Analysis Contract';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = DK_Contract;

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(ContractTypeFilter; ContractTypeFilter)
                {
                    Caption = 'Type';
                    OptionCaption = 'All,Reservation,Temporary Contract';

                    trigger OnValidate()
                    begin

                        DataInquiry;
                        CurrPage.Update;

                        Message(MSG001);
                    end;
                }
            }
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                field("First Laying Date"; Rec."First Laying Date")
                {
                }
                field("Contract Date Check"; Rec."Contract Date Check")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Group Contract No."; Rec."Group Contract No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
                {
                }
                field("Cemetery Class"; Rec."Cemetery Class")
                {
                }
                field("Unit Price Type Name"; Rec."Unit Price Type Name")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                }
                field("Cemetery Size 2"; Rec."Cemetery Size 2")
                {
                    Visible = false;
                }
                field("Landscape Architecture"; Rec."Landscape Architecture")
                {
                }
                field("Cemetery Amount"; Rec."Cemetery Amount")
                {
                    ShowMandatory = true;
                }
                field("Cemetery Class Dis. Rate"; Rec."Cemetery Class Dis. Rate")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Class Discount"; Rec."Cemetery Class Discount")
                {
                }
                field("General Amount"; Rec."General Amount")
                {
                    CaptionClass = ComFunction.GetCaptionWithContract('1');
                }
                field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                {
                    CaptionClass = ComFunction.GetCaptionWithContract('2');
                }
                field("Bury Amount"; Rec."Bury Amount")
                {
                }
                field("Cemetery Discount"; Rec."Cemetery Discount")
                {
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    Editable = false;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Editable = false;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    Editable = false;
                }
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
                    Editable = false;
                }
                field("Deposit Receipt Date"; Rec."Deposit Receipt Date")
                {
                    Editable = false;
                }
                field("Pay. Contract Rece. Date"; Rec."Pay. Contract Rece. Date")
                {
                }
                field("Remaining Due Date"; Rec."Remaining Due Date")
                {
                }
                field("Alarm Period 1"; Rec."Alarm Period 1")
                {
                }
                field("Alarm Period 2"; Rec."Alarm Period 2")
                {
                }
                field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cust. E-Mail"; Rec."Cust. E-Mail")
                {
                }
                field("Cust. Post Code"; Rec."Cust. Post Code")
                {
                }
                field("Cust. Address"; Rec."Cust. Address")
                {
                }
                field("Cust. Address 2"; Rec."Cust. Address 2")
                {
                }
                field("CRM SalesPerson"; Rec."CRM SalesPerson")
                {
                    Visible = false;
                }
                field("CRM External Sales"; Rec."CRM External Sales")
                {
                    Visible = false;
                }
                field("CRM Funeral Hall"; Rec."CRM Funeral Hall")
                {
                    Visible = false;
                }
                field("CRM Funeral Service"; Rec."CRM Funeral Service")
                {
                    Visible = false;
                }
            }
            group(Total)
            {
                Caption = 'Total';
                fixed(Control14)
                {
                    ShowCaption = false;
                    group("No. Of Contract")
                    {
                        Caption = 'No. Of Contract';
                        field(RecCount; RecCount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group(Control12)
                    {
                        Caption = 'Payment Amount';
                        field(TotPaymentAmount; TotPaymentAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group(Control17)
                    {
                        Caption = 'Payment Amount';
                        field(TotDepositAmount; TotDepositAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group(Control19)
                    {
                        Caption = 'Payment Amount';
                        field(TotContractAmount; TotContractAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group(Control21)
                    {
                        Caption = 'Payment Amount';
                        field(TotRemainingAmount; TotRemainingAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group(Control23)
                    {
                        Caption = 'Payment Amount';
                        field(TotPayRemainingAmount; TotPayRemainingAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1100409027>")
            {
                Caption = 'Inquiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    DataInquiry;

                    if Rec.FindFirst then;

                    CurrPage.Update;
                end;
            }
            action("Show Contract")
            {
                Caption = 'Show Contract';
                Image = "Order";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Contract: Record DK_Contract;
                    _ContractCard: Page "DK_Contract Card";
                begin

                    _Contract.Reset;
                    _Contract.SetRange("No.", Rec."No.");
                    if _Contract.FindSet then begin

                        Clear(_ContractCard);
                        _ContractCard.LookupMode(true);
                        _ContractCard.SetTableView(_Contract);
                        _ContractCard.SetRecord(_Contract);
                        _ContractCard.Editable(false);
                        _ContractCard.RunModal;

                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        DataInquiry;
    end;

    var
        ContractTypeFilter: Option All,Reservation,TempContract;
        MSG001: Label 'Complate!';
        ComFunction: Codeunit "DK_Common Function";
        TotDepositAmount: Decimal;
        TotContractAmount: Decimal;
        TotRemainingAmount: Decimal;
        TotPaymentAmount: Decimal;
        TotPayRemainingAmount: Decimal;
        RecCount: Decimal;


    procedure DataInquiry()
    begin
        Clear(RecCount);
        Clear(TotDepositAmount);
        Clear(TotContractAmount);
        Clear(TotRemainingAmount);
        Clear(TotPaymentAmount);
        Clear(TotPayRemainingAmount);

        Rec.Reset;
        Rec.FilterGroup(2);
        case ContractTypeFilter of
            ContractTypeFilter::All:
                begin
                    Rec.SetFilter(Status, '%1|%2', Rec.Status::Reservation, Rec.Status::Contract);
                    //SETFILTER("Pay. Remaining Amount",'<>0');
                end;
            ContractTypeFilter::Reservation:
                begin
                    Rec.SetFilter(Status, '%1', Rec.Status::Reservation);
                    //SETFILTER(Status,'=%1', Status::TempContract);
                    //SETFILTER("Pay. Remaining Amount",'<>0');
                    //SETFILTER("Contract Amount",'=0');
                    //SETFILTER("Remaining Amount",'=0');
                end;
            ContractTypeFilter::TempContract:
                begin
                    Rec.SetFilter(Status, '%1', Rec.Status::Contract);
                    //SETFILTER(Status,'=%1', Status::TempContract);
                    //SETFILTER("Pay. Remaining Amount",'<>0');
                    //SETFILTER("Contract Amount",'<>0');
                end;

        end;
        Rec.FilterGroup(0);
        if Rec.FindSet then begin
            Rec.CalcSums(Rec."Deposit Amount", Rec."Contract Amount", Rec."Remaining Amount", "Payment Amount", "Pay. Remaining Amount");

            RecCount := Rec.Count;
            TotDepositAmount := Rec."Deposit Amount";
            TotContractAmount := Rec."Contract Amount";
            TotRemainingAmount := Rec."Remaining Amount";
            TotPaymentAmount := Rec."Payment Amount";
            TotPayRemainingAmount := Rec."Pay. Remaining Amount";
        end;
    end;
}