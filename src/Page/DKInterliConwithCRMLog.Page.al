page 50229 "DK_Interli. Con. with CRM Log"
{
    Caption = 'Interli. Contract with CRM Log';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interlink Con. with CRM Log";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Data Type"; Rec."Data Type")
                {
                }
                field("Data Date"; Rec."Data Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                    TableRelation = DK_Contract;
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Contract Date"; Rec."Contract Date")
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
                }
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                }
                field("Customer No. 3"; Rec."Customer No. 3")
                {
                }
                field("Customer Name 3"; Rec."Customer Name 3")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    TableRelation = DK_Cemetery;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Management Unit"; Rec."Management Unit")
                {
                }
                field("Cemetery Amount"; Rec."Cemetery Amount")
                {
                }
                field("Cemetery Class Dis. Rate"; Rec."Cemetery Class Dis. Rate")
                {
                }
                field("Cemetery Class Discount"; Rec."Cemetery Class Discount")
                {
                }
                field("General Amount"; Rec."General Amount")
                {
                }
                field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                {
                }
                field("Bury Amount"; Rec."Bury Amount")
                {
                }
                field("Cemetery Discount"; Rec."Cemetery Discount")
                {
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                }
                field("Rece. Remaining Amount"; Rec."Rece. Remaining Amount")
                {
                }
                field("Deposit Receipt Date"; Rec."Deposit Receipt Date")
                {
                }
                field("Pay. Contract Rece. Date"; Rec."Pay. Contract Rece. Date")
                {
                }
                field("Remaining Due Date"; Rec."Remaining Due Date")
                {
                }
                field("Remaining Receipt Date"; Rec."Remaining Receipt Date")
                {
                }
                field("Alarm Period 1"; Rec."Alarm Period 1")
                {
                }
                field("Send Alarm Date/Time 1"; Rec."Send Alarm Date/Time 1")
                {
                }
                field("Alarm Period 2"; Rec."Alarm Period 2")
                {
                }
                field("Send Alarm Date/Time 2"; Rec."Send Alarm Date/Time 2")
                {
                }
                field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
                {
                }
                field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
                {
                }
                field("CRM SalesPerson Code"; Rec."CRM SalesPerson Code")
                {
                    Visible = false;
                }
                field("CRM SalesPerson"; Rec."CRM SalesPerson")
                {
                }
                field("CRM External Sales Code"; Rec."CRM External Sales Code")
                {
                    Visible = false;
                }
                field("CRM External Sales"; Rec."CRM External Sales")
                {
                }
                field("CRM Funeral Hall Code"; Rec."CRM Funeral Hall Code")
                {
                    Visible = false;
                }
                field("CRM Funeral Hall"; Rec."CRM Funeral Hall")
                {
                }
                field("CRM Funeral Service Code"; Rec."CRM Funeral Service Code")
                {
                    Visible = false;
                }
                field("CRM Funeral Service"; Rec."CRM Funeral Service")
                {
                }
                field("CRM Channel Vendor No."; Rec."CRM Channel Vendor No.")
                {
                    Visible = false;
                }
                field("CRM Channel Vendor"; Rec."CRM Channel Vendor")
                {
                }
                field("Revocation Register"; Rec."Revocation Register")
                {
                }
                field("Revocation Date"; Rec."Revocation Date")
                {
                }
                field("General Expiration Date"; Rec."General Expiration Date")
                {
                }
                field("Land. Arc. Expiration Date"; Rec."Land. Arc. Expiration Date")
                {
                }
                field("Before Cemetery No."; Rec."Before Cemetery No.")
                {
                }
                field("Associate Name"; Rec."Associate Name")
                {
                }
                field("Associate Mobile No."; Rec."Associate Mobile No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Associate Mobile No." <> '' then begin
                            if not CommFun.CheckValidMobileNo(Rec."Associate Mobile No.") then
                                Error(MSG001, Rec.FieldCaption("Associate Mobile No."));
                        end;
                    end;
                }
                field("Associate Phone No."; Rec."Associate Phone No.")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Associate Phone No." <> '' then begin
                            if not CommFun.CheckValidPhoneNo(Rec."Associate Phone No.") then
                                Error(MSG001, Rec.FieldCaption("Associate Phone No."));
                        end;
                    end;
                }
                field("Associate E-Mail"; Rec."Associate E-Mail")
                {

                    trigger OnValidate()
                    var
                        _MailMgt: Codeunit "Mail Management";
                    begin
                        if Rec."Associate E-Mail" <> '' then
                            _MailMgt.ValidateEmailAddressField(Rec."Associate E-Mail");
                    end;
                }
                field("Associate Post Code"; Rec."Associate Post Code")
                {
                }
                field("Associate Address"; Rec."Associate Address")
                {
                }
                field("Associate Address 2"; Rec."Associate Address 2")
                {
                }
                field(Memo; Rec.Memo)
                {
                }
                field("Record Del"; Rec."Record Del")
                {
                }
                field("Applied Date"; Rec."Applied Date")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        CommFun: Codeunit "DK_Common Function";
        MSG001: Label 'The value specified for %1 is not valid. %1 is only a (0~9) and ''-''.';
}

