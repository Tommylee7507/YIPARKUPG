page 50264 "DK_Sales Contract List"
{
    Caption = 'Contract List';
    CardPageID = "DK_Sales Contract Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Contract;

    layout
    {
        area(content)
        {
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
                field("Customer No. 2"; Rec."Customer No. 2")
                {
                    Visible = false;
                }
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                    Visible = false;
                }
                field("Customer No. 3"; Rec."Customer No. 3")
                {
                    Visible = false;
                }
                field("Customer Name 3"; Rec."Customer Name 3")
                {
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    ShowMandatory = true;
                    Visible = false;
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
                    // CaptionClass = ComFunction.GetCaptionWithContract('1');////zzz
                }
                field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                {
                    // CaptionClass = ComFunction.GetCaptionWithContract('2');////zzz
                }
                field("Bury Amount"; Rec."Bury Amount")
                {
                }
                field("Cemetery Discount"; Rec."Cemetery Discount")
                {
                }
                field("Payment Amount"; Rec."Payment Amount")
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
                field("Pay. Remaining Amount"; Rec."Pay. Remaining Amount")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
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
                field("Associate Relationship"; Rec."Associate Relationship")
                {
                }
                field("Contact Target"; Rec."Contact Target")
                {
                }
                field("Main Associate No."; Rec."Main Associate No.")
                {
                }
                field("Main Associate Name"; Rec."Main Associate Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Main Associate Mobile No."; Rec."Main Associate Mobile No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Main Associate Phone No."; Rec."Main Associate Phone No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Main Associate Address"; Rec."Main Associate Address")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Main Associate Address 2"; Rec."Main Associate Address 2")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Sub Associate No."; Rec."Sub Associate No.")
                {
                }
                field("Sub Associate Name"; Rec."Sub Associate Name")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Sub Associate Mobile No."; Rec."Sub Associate Mobile No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Sub Associate Phone No."; Rec."Sub Associate Phone No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Sub Associate Address"; Rec."Sub Associate Address")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Sub Associate Address 2"; Rec."Sub Associate Address 2")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cust. Mobile No. 2"; Rec."Cust. Mobile No. 2")
                {
                    Visible = false;
                }
                field("Cust. Mobile No. 3"; Rec."Cust. Mobile No. 3")
                {
                    Visible = false;
                }
                field("Overdue Sticker"; Rec."Overdue Sticker")
                {
                    Visible = false;
                }
                field("Overdue Sticker Date"; Rec."Overdue Sticker Date")
                {
                    Visible = false;
                }
                field("Revocation Register"; Rec."Revocation Register")
                {
                    Visible = false;
                }
                field("Revocation Date"; Rec."Revocation Date")
                {
                }
                field("Revocation Amount"; Rec."Revocation Amount")
                {
                }
                field("Revocation Document No."; Rec."Revocation Document No.")
                {
                }
                field("Revocation Employee Name"; Rec."Revocation Employee Name")
                {
                }
                field("Transfer Litigation"; Rec."Transfer Litigation")
                {
                }
                field("Transfer Date"; Rec."Transfer Date")
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
                field("CRM Channel Vendor"; Rec."CRM Channel Vendor")
                {
                }
                field("CRM Sales Type"; Rec."CRM Sales Type")
                {
                }
                field("Last Daily Batch Run Date"; Rec."Last Daily Batch Run Date")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control64; "DK_Cemetery Detail Factbox")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            part(Control85; "DK_Interest Cemetery Log")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Date Filter", 0D, Today);
        Rec.FilterGroup(0);
    end;

    var
        ContractMgt: Codeunit "DK_Contract Mgt.";
        ComFunction: Codeunit "DK_Common Function";
        MSG001: Label 'The NAS server folder was not specified in the Function settings. Please contact your administrator.';
        MSG002: Label 'The %1 could not be found in this Contract Document.';
        MSG003: Label 'Would you like to request approval for the selected contracts?';
        MSG004: Label 'No contract selected.';
        MSG005: Label 'Request for approval has been completed.';
        MSG006: Label 'Please enter your Contract No first';
        MSG007: Label 'No contract found.';

    procedure SelectActiveContracts(): Text
    var
        _Contract: Record DK_Contract;
    begin
        exit(SelectInContractList(_Contract));
    end;

    procedure GetSelectionFilter(): Text
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        _Contract: Record DK_Contract;
    begin
        CurrPage.SetSelectionFilter(_Contract);
        // exit(SelectionFilterManagement.GetSelectionFilterForContract(_Contract));////zzz
    end;

    local procedure SelectInContractList(var pContract: Record DK_Contract): Text
    var
        ContractListPage: Page "DK_Contract List";
    begin

        ContractListPage.SetTableView(pContract);
        ContractListPage.LookupMode(true);
        // if ContractListPage.RunModal = ACTION::LookupOK then////zzz
        //     exit(ContractListPage.GetSelectionFilter);////zzz
    end;

    local procedure CementeryPaymentRun()
    var
        _CemeteryPaymentConfirm: Report "DK_Cemetery Payment Confirm";
    begin
        _CemeteryPaymentConfirm.SetParm(Rec."No.");
        _CemeteryPaymentConfirm.RunModal;
    end;
}

