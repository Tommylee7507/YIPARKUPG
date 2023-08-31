page 50263 "DK_Sales Contract Card"
{
    Caption = 'Contract Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Contract;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control154)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                        Editable = false;
                        ShowMandatory = true;

                        trigger OnAssistEdit()
                        begin
                            Rec.AssistEdit(Rec);
                        end;
                    }
                    field("Supervise No."; Rec."Supervise No.")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field("Contract Type"; Rec."Contract Type")
                    {
                        Editable = false;
                    }
                    field("Group Contract No."; Rec."Group Contract No.")
                    {
                        Editable = false;
                        Enabled = Rec."Contract Type" = Rec."Contract Type"::Sub;
                    }
                    field("Contract Date"; Rec."Contract Date")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field("Main Customer No."; Rec."Main Customer No.")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field("Main Customer Name"; Rec."Main Customer Name")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Editable = false;
                        Lookup = false;
                    }
                    group(Control93)
                    {
                        ShowCaption = false;
                        field("Cemetery Code"; Rec."Cemetery Code")
                        {
                            Editable = false;
                            Importance = Additional;
                            ShowMandatory = true;

                            trigger OnValidate()
                            var
                                _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                                _UnitPrice: Decimal;
                                _AdminExpenseLedger: Record "DK_Admin. Expense Ledger";
                                _Cemetery: Record DK_Cemetery;
                            begin
                                if Rec."Cemetery Code" <> '' then begin
                                    if (Rec."Contract Type" = Rec."Contract Type"::General) or
                                        ((Rec."Contract Type" = Rec."Contract Type"::Group) and (Rec."Admin. Expense Option" = Rec."Admin. Expense Option"::"Per Group")) or
                                        ((Rec."Contract Type" = Rec."Contract Type"::Sub) and (Rec."Admin. Expense Option" = Rec."Admin. Expense Option"::"Per Contract")) then begin

                                        if _Cemetery.Get(Rec."Cemetery Code") then begin
                                            Clear(_AdminExpenseMgt);
                                            _UnitPrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(Rec."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::General, Rec."Contract Date");
                                            Rec."General Amount" := _AdminExpenseMgt.GetContractAdminExpense(Rec."Cemetery Code", _UnitPrice, Rec."Management Unit");
                                            if _Cemetery."Landscape Architecture" then begin
                                                Clear(_AdminExpenseMgt);
                                                _UnitPrice := _AdminExpenseMgt.GetCurrAdminExpensePrice(Rec."Cemetery Code", _AdminExpenseLedger."Admin. Expense Type"::Landscape, Rec."Contract Date");
                                                Rec."Landscape Arc. Amount" := _AdminExpenseMgt.GetContractAdminExpense(Rec."Cemetery Code", _UnitPrice, Rec."Management Unit");
                                            end else begin
                                                Rec."Landscape Arc. Amount" := 0;
                                            end;
                                        end else begin
                                            Rec."General Amount" := 0;
                                            Rec."Landscape Arc. Amount" := 0;
                                        end;
                                    end;
                                end else begin
                                    Rec."General Amount" := 0;
                                    Rec."Landscape Arc. Amount" := 0;
                                end;
                            end;
                        }
                        field("Cemetery No."; Rec."Cemetery No.")
                        {
                        }
                        field("Landscape Architecture"; Rec."Landscape Architecture")
                        {
                        }
                    }
                    group(Control107)
                    {
                        ShowCaption = false;
                        field("General Expiration Date"; Rec."General Expiration Date")
                        {
                            Editable = false;
                        }
                        field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
                        {
                            Editable = false;
                        }
                        field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
                        {

                            trigger OnDrillDown()
                            begin
                                Rec.OpenAdminExpeseLedger(0);
                            end;
                        }
                        field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
                        {

                            trigger OnDrillDown()
                            begin
                                Rec.OpenAdminExpeseLedger(1);
                            end;
                        }
                        field("Management Unit"; Rec."Management Unit")
                        {
                            Editable = false;
                        }
                    }
                }
                group(Control155)
                {
                    ShowCaption = false;
                    field("Litigation Evaluation"; Rec."Litigation Evaluation")
                    {
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                    group(Memo)
                    {
                        Caption = 'Memo';
                        // field(WorkMemo; WorkMemo)////zzz
                        // {
                        //     Editable = false;
                        //     MultiLine = true;

                        //     trigger OnValidate()
                        //     begin
                        //         Rec.SetWorkMemo(WorkMemo);
                        //     end;
                        // }
                    }
                }
            }
            group("Group Contract")
            {
                Caption = 'Group Contract';
                Editable = Rec."Contract Type" = Rec."Contract Type"::Group;
                Visible = Rec."Contract Type" <> Rec."Contract Type"::General;
                field("Admin. Expense Option"; Rec."Admin. Expense Option")
                {
                    Editable = false;
                }
                field("Group Estate Code"; Rec."Group Estate Code")
                {
                    Importance = Additional;
                }
                field("Group Estate Name"; Rec."Group Estate Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
            }
            group(Cemetery)
            {
                Caption = 'Cemetery';
                Visible = false;
                field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
                {
                    Importance = Additional;
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Cemetery Dig. Code"; Rec."Cemetery Dig. Code")
                {
                    Importance = Additional;
                }
                field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
                {
                }
                field("Cemetery Class"; Rec."Cemetery Class")
                {
                    Editable = false;
                }
                field("Cemetery Landscape Archit."; Rec."Cemetery Landscape Archit.")
                {
                }
                field("Cemetery Size"; Rec."Cemetery Size")
                {
                }
                field("Cemetery Size 2"; Rec."Cemetery Size 2")
                {
                }
            }
            group(Amounts)
            {
                Caption = 'Amounts';
                group(Control76)
                {
                    ShowCaption = false;
                    field("Cemetery Amount"; Rec."Cemetery Amount")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field("Cemetery Class Dis. Rate"; Rec."Cemetery Class Dis. Rate")
                    {
                        Importance = Additional;
                    }
                    field("Cemetery Class Discount"; Rec."Cemetery Class Discount")
                    {
                    }
                    field("Cemetery Discount"; Rec."Cemetery Discount")
                    {
                        Editable = false;
                    }
                    field("General Amount"; Rec."General Amount")
                    {
                        // CaptionClass = ComFunction.GetCaptionWithContract('1');////zzz
                        Editable = false;
                    }
                    field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                    {
                        // CaptionClass = ComFunction.GetCaptionWithContract('2');////zzz
                        Editable = false;
                    }
                    field("Bury Amount"; Rec."Bury Amount")
                    {
                        Editable = false;
                    }
                    field("Deposit Amount"; Rec."Deposit Amount")
                    {
                        Editable = false;
                    }
                    field("Contract Amount"; Rec."Contract Amount")
                    {
                        Editable = false;
                    }
                    field("Total Contract Amount"; Rec."Total Contract Amount")
                    {
                        Style = AttentionAccent;
                        StyleExpr = TRUE;
                    }
                    field("Rece. Remaining Amount"; Rec."Rece. Remaining Amount")
                    {
                        Editable = false;
                    }
                }
                group(Control77)
                {
                    ShowCaption = false;
                    field("Payment Amount"; Rec."Payment Amount")
                    {
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                    {
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("Etc. Amount"; Rec."Etc. Amount")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Etc. Discount"; Rec."Etc. Discount")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Allow Ston"; Rec."Allow Ston")
                    {
                    }
                    field("Sales Amount"; Rec."Sales Amount")
                    {
                        Editable = false;
                        Visible = false;
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
                        Editable = false;
                    }
                    field("Alarm Period 1"; Rec."Alarm Period 1")
                    {
                        Editable = false;
                    }
                    field("Sended Alarm 1"; Rec."Sended Alarm 1")
                    {
                    }
                    field("Alarm Period 2"; Rec."Alarm Period 2")
                    {
                        Editable = false;
                    }
                    field("Sended Alarm 2"; Rec."Sended Alarm 2")
                    {
                    }
                    field("Transfer Litigation"; Rec."Transfer Litigation")
                    {
                    }
                    field("Transfer Date"; Rec."Transfer Date")
                    {
                    }
                    field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
                    {
                    }
                    field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
                    {
                        Editable = false;
                    }
                    field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
                    {
                        Editable = false;
                    }
                }
            }
            group(Contacts)
            {
                Caption = 'Contacts';
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                    AssistEdit = false;
                    Caption = 'Mobile No.';
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                    AssistEdit = false;
                    Caption = 'Phone No.';
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. E-Mail"; Rec."Cust. E-Mail")
                {
                    AssistEdit = false;
                    Caption = 'E-Mail';
                    DrillDown = false;
                    Lookup = false;
                }
                field("Address Confirmation"; Rec."Address Confirmation")
                {
                    Editable = false;
                }
                field("Cust. Post Code"; Rec."Cust. Post Code")
                {
                    AssistEdit = false;
                    Caption = 'Post Code';
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Address"; Rec."Cust. Address")
                {
                    AssistEdit = false;
                    Caption = 'Address';
                    DrillDown = false;
                    Lookup = false;
                    MultiLine = true;
                }
                field("Cust. Address 2"; Rec."Cust. Address 2")
                {
                    AssistEdit = false;
                    Caption = 'Address 2';
                    DrillDown = false;
                    Lookup = false;
                }
            }
            group(Associate)
            {
                Caption = 'Associate';
                field("Contact Target"; Rec."Contact Target")
                {
                }
                group("Main Associate")
                {
                    Caption = 'Main Associate';
                    field("Main Associate No."; Rec."Main Associate No.")
                    {
                        Caption = 'No.';
                    }
                    field("Main Associate Name"; Rec."Main Associate Name")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Main Associate Mobile No."; Rec."Main Associate Mobile No.")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Main Associate Phone No."; Rec."Main Associate Phone No.")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Main Associate Post Code"; Rec."Main Associate Post Code")
                    {
                        AssistEdit = false;
                        Caption = 'Post Code';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Main Associate Address"; Rec."Main Associate Address")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Main Associate Address 2"; Rec."Main Associate Address 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
                group("Sub Associate")
                {
                    Caption = 'Sub Associate';
                    field("Sub Associate No."; Rec."Sub Associate No.")
                    {
                        Caption = 'No.';
                    }
                    field("Sub Associate Name"; Rec."Sub Associate Name")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Sub Associate Mobile No."; Rec."Sub Associate Mobile No.")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Sub Associate Phone No."; Rec."Sub Associate Phone No.")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Sub Associate Post Code"; Rec."Sub Associate Post Code")
                    {
                        AssistEdit = false;
                        Caption = 'Post Code';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Sub Associate Address"; Rec."Sub Associate Address")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Sub Associate Address 2"; Rec."Sub Associate Address 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
            }
            group("Joint Tenancy")
            {
                Caption = 'Joint Tenancy';
                group("Joint Tenancy 2")
                {
                    Caption = 'Joint Tenancy 2';
                    field("Customer No. 2"; Rec."Customer No. 2")
                    {
                        Caption = 'Customer No.';
                        Editable = false;
                    }
                    field("Customer Name 2"; Rec."Customer Name 2")
                    {
                        Caption = 'Customer Name';
                        Editable = false;
                    }
                    field("Cust. Mobile No. 2"; Rec."Cust. Mobile No. 2")
                    {
                        Caption = 'Customer Mobile No.';
                    }
                }
                group("Joint Tenancy 3")
                {
                    Caption = 'Joint Tenancy 3';
                    field("Customer No. 3"; Rec."Customer No. 3")
                    {
                        Caption = 'Customer No.';
                        Editable = false;
                    }
                    field("Customer Name 3"; Rec."Customer Name 3")
                    {
                        Caption = 'Customer Name';
                        Editable = false;
                    }
                    field("Cust. Mobile No. 3"; Rec."Cust. Mobile No. 3")
                    {
                        Caption = 'Customer Mobile No.';
                    }
                }
            }
            group("Allow Membership Printing")
            {
                Caption = 'Allow Membership Printing';
                Editable = false;
                field("Allow Employee No."; Rec."Allow Employee No.")
                {
                    Importance = Additional;
                }
                field("Allow Employee Name"; Rec."Allow Employee Name")
                {
                }
                field("Allow Mem. Printing DateTime"; Rec."Allow Mem. Printing DateTime")
                {
                }
            }
            group("Revocation Contract")
            {
                Caption = 'Revocation Contract';
                field("Revocation Register"; Rec."Revocation Register")
                {
                }
                field("Revocation Date"; Rec."Revocation Date")
                {
                }
                field("Revocation Amount"; Rec."Revocation Amount")
                {
                    Editable = false;
                }
                field("Been Transp. Type"; Rec."Been Transp. Type")
                {
                }
                field("Revocation Document No."; Rec."Revocation Document No.")
                {
                }
                field("Revocation Employee No."; Rec."Revocation Employee No.")
                {
                    Importance = Additional;
                }
                field("Revocation Employee Name"; Rec."Revocation Employee Name")
                {
                }
            }
            group("Etc.")
            {
                Caption = 'Etc.';
                field("Before Cemetery Code"; Rec."Before Cemetery Code")
                {
                }
                field("Overdue Sticker"; Rec."Overdue Sticker")
                {
                }
                field("Overdue Sticker Date"; Rec."Overdue Sticker Date")
                {
                }
            }
            part("Counsel General Line"; "DK_Counsel General Subform")
            {
                Caption = 'Counsel General Line';
                SubPageLink = "Contract No." = FIELD("No."),
                              Type = CONST(General),
                              "Delete Row" = CONST(false);
            }
            group(CRM)
            {
                Caption = 'CRM';
                field("CRM Key"; Rec."CRM Key")
                {
                    Importance = Additional;
                }
                field("CRM SalesPerson Code"; Rec."CRM SalesPerson Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("CRM SalesPerson"; Rec."CRM SalesPerson")
                {
                }
                field("CRM External Sales Code"; Rec."CRM External Sales Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("CRM External Sales"; Rec."CRM External Sales")
                {
                }
                field("CRM Funeral Hall Code"; Rec."CRM Funeral Hall Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("CRM Funeral Hall"; Rec."CRM Funeral Hall")
                {
                }
                field("CRM Funeral Service Code"; Rec."CRM Funeral Service Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("CRM Funeral Service"; Rec."CRM Funeral Service")
                {
                }
                field("CRM Channel Vendor No."; Rec."CRM Channel Vendor No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("CRM Channel Vendor"; Rec."CRM Channel Vendor")
                {
                }
                field("CRM Sales Type Seq"; Rec."CRM Sales Type Seq")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("CRM Sales Type"; Rec."CRM Sales Type")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control37; "DK_Counsel Contents Factbox")
            {
                Provider = "Counsel General Line";
                SubPageLink = "Contract No." = FIELD("Contract No."),
                              Type = FIELD(Type),
                              "Dev. Target Doc. No." = FIELD("Dev. Target Doc. No."),
                              "Dev. Target Doc. Line No." = FIELD("Dev. Target Doc. Line No."),
                              "Line No." = FIELD("Line No.");
            }
            part(Control94; "DK_Cemetery Detail Factbox")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            part(Control129; "DK_Interest Cemetery Log")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            systempart(Control54; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        WorkMemo := Rec.GetWorkMemo;
        GetSocialSecurityNoDisplay;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Contract Date" := WorkDate;
        FunctionSetup.Get;
        Rec."Management Unit" := FunctionSetup."Management Unit";
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Date Filter", 0D, Today);
        Rec.FilterGroup(0);
    end;

    var
        // ContractMgt: Codeunit "DK_Contract Mgt.";////zzz
        // ComFunction: Codeunit "DK_Common Function";////zzz
        FunctionSetup: Record "DK_Function Setup";
        WorkMemo: Text;
        gSocialSecurityNo: Text[30];
        MSG001: Label 'The NAS server folder was not specified in the Function settings. Please contact your administrator.';
        MSG002: Label 'The %1 could not be found in this Contract Document.';
        MSG003: Label 'Would you like to request approval for the selected contracts?';
        MSG004: Label 'No contract selected.';
        MSG005: Label 'Request for approval has been completed.';
        MSG006: Label 'Please enter your Contract No first';
        MSG007: Label 'No contract found.';

    local procedure AddressLookup()
    var
        // _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";////zzz
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin
        // Clear(_DK_KoreanRoadAddrMgt);////zzz

        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress("Associate Address","Associate Address 2","Associate Post Code",_TmpText,_TmpCode);////zzz
    end;

    local procedure CementeryPaymentRun()
    var
    // _CemeteryPaymentConfirm: Report "DK_Cemetery Payment Confirm";////zzz
    begin
        // _CemeteryPaymentConfirm.SetParm("No.");////zzz
        // _CemeteryPaymentConfirm.RunModal;////zzz
    end;

    local procedure GetSocialSecurityNo()
    var
        _DK_Customer: Record DK_Customer;
    begin
        Clear(gSocialSecurityNo);
        if _DK_Customer.Get(Rec."Main Customer No.") then begin
            gSocialSecurityNo := _DK_Customer.GetSSNSSNCalculated;
        end;
    end;

    local procedure GetSocialSecurityNoDisplay()
    var
        _DK_Customer: Record DK_Customer;
    begin
        Clear(gSocialSecurityNo);
        if _DK_Customer.Get(Rec."Main Customer No.") then begin
            gSocialSecurityNo := _DK_Customer.GetSSN;
        end;
    end;
}

