page 50249 "DK_Interlink Con. with CRM Log"
{
    Caption = 'Interlink Con. with CRM Log';
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
                field(Status; Rec.Status)
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
                field("Total Contract Amount"; Rec."Total Contract Amount")
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
                field("CRM SalesPerson Code"; Rec."CRM SalesPerson Code")
                {
                }
                field("CRM SalesPerson"; Rec."CRM SalesPerson")
                {
                }
                field("CRM External Sales Code"; Rec."CRM External Sales Code")
                {
                }
                field("CRM External Sales"; Rec."CRM External Sales")
                {
                }
                field("CRM Funeral Hall Code"; Rec."CRM Funeral Hall Code")
                {
                }
                field("CRM Funeral Hall"; Rec."CRM Funeral Hall")
                {
                }
                field("CRM Funeral Service Code"; Rec."CRM Funeral Service Code")
                {
                }
                field("CRM Funeral Service"; Rec."CRM Funeral Service")
                {
                }
                field("CRM Key"; Rec."CRM Key")
                {
                }
                field("CRM Channel Vendor No."; Rec."CRM Channel Vendor No.")
                {
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
                }
                field("Associate Phone No."; Rec."Associate Phone No.")
                {
                }
                field("Associate E-Mail"; Rec."Associate E-Mail")
                {
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
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Man. Fee hike Exemption Date"; Rec."Man. Fee hike Exemption Date")
                {
                }
                field("Management Unit"; Rec."Management Unit")
                {
                }
                field("Man. Fee Exemption Date"; Rec."Man. Fee Exemption Date")
                {
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Group Contract No."; Rec."Group Contract No.")
                {
                }
                field("Admin. Expense Option"; Rec."Admin. Expense Option")
                {
                }
                field("CRM Contract Type"; Rec."CRM Contract Type")
                {
                }
                field("CRM Admin. Expense Option"; Rec."CRM Admin. Expense Option")
                {
                }
                field("Etc. Amount"; Rec."Etc. Amount")
                {
                }
                field("Etc. Discount"; Rec."Etc. Discount")
                {
                }
                field("Sales Amount"; Rec."Sales Amount")
                {
                }
                field("Revocation Amount"; Rec."Revocation Amount")
                {
                }
                field("Close Amount"; Rec."Close Amount")
                {
                }
                field("Associate Relationship"; Rec."Associate Relationship")
                {
                }
                field("Contract Publish"; Rec."Contract Publish")
                {
                }
                field("Remaining Publish"; Rec."Remaining Publish")
                {
                }
                field("CRM Sales Type Seq"; Rec."CRM Sales Type Seq")
                {
                }
                field("CRM Sales Type"; Rec."CRM Sales Type")
                {
                }
                field("Record Del"; Rec."Record Del")
                {
                }
                field("Applied Date"; Rec."Applied Date")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control82; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

