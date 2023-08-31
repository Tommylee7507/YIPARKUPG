page 50000 "DK_Function Setup"
{
    // 
    // DK34: 201029
    //   - Add Field: "Reagree To Provide Info Nos."
    //     : 20201104
    //   - Add Field: "Litigation Raw Progress Nos."

    Caption = 'Function Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Function Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Init. Visual Cemetery PW"; Rec."Init. Visual Cemetery PW")
                {
                }
                field("Admin. Expense Target"; Rec."Admin. Expense Target")
                {
                }
                field("Payment Expect Due Period"; Rec."Payment Expect Due Period")
                {
                }
                field("SMS Phone No."; Rec."SMS Phone No.")
                {
                }
                field("SMS Image Server TempFolder"; Rec."SMS Image Server TempFolder")
                {
                }
                field("Use SMS"; Rec."Use SMS")
                {
                }
                field("NAS Contract File Folder"; Rec."NAS Contract File Folder")
                {
                }
                field("QRCode URL"; Rec."QRCode URL")
                {
                }
                field("PG URL"; Rec."PG URL")
                {
                }
                field("Virtual Account ID"; Rec."Virtual Account ID")
                {
                    Editable = NOT rec."Use Virtual Account";
                    Enabled = NOT rec."Use Virtual Account";
                }
                field("Use Virtual Account"; Rec."Use Virtual Account")
                {
                }
                field("Biz Talk ID"; Rec."Biz Talk ID")
                {
                }
            }
            group(Contract)
            {
                Caption = 'Contract';
                field("Management Unit"; Rec."Management Unit")
                {
                }
            }
            group(Litigaion)
            {
                Caption = 'Litigaion';
                field("Delay Interest Rate"; Rec."Delay Interest Rate")
                {
                }
            }
            group(Project)
            {
                Caption = 'Project';
                field("Prevent Neg. Budget"; Rec."Prevent Neg. Budget")
                {
                }
            }
            group("Customer Request")
            {
                Caption = 'Customer Request';
                field("Receipt Type Code"; Rec."Receipt Type Code")
                {
                }
            }
            group(Alarm)
            {
                Caption = 'Alarm';
                field("Alarm Alternative"; Rec."Alarm Alternative")
                {
                }
                field("Alarm Send Period"; Rec."Alarm Send Period")
                {
                }
            }
            group("Number Series")
            {
                Caption = 'Number Series';
                field("Employee Nos."; Rec."Employee Nos.")
                {
                }
                field("Estate Group Nos."; Rec."Estate Group Nos.")
                {
                }
                field("Estate Nos."; Rec."Estate Nos.")
                {
                }
                field("Cemetery Nos."; Rec."Cemetery Nos.")
                {
                }
                field("Purchase Contract Nos."; Rec."Purchase Contract Nos.")
                {
                }
                field("Customer Nos."; Rec."Customer Nos.")
                {
                }
                field("Publish Admin. Expense Nos."; Rec."Publish Admin. Expense Nos.")
                {
                }
                field("Contract Nos."; Rec."Contract Nos.")
                {
                }
                field("Revocation Contract Nos."; Rec."Revocation Contract Nos.")
                {
                }
                field("Item Nos."; Rec."Item Nos.")
                {
                }
                field("Vehicle Nos."; Rec."Vehicle Nos.")
                {
                }
                field("Vendor Nos."; Rec."Vendor Nos.")
                {
                }
                field("Vehicle Header Nos."; Rec."Vehicle Header Nos.")
                {
                }
                field("Project Nos."; Rec."Project Nos.")
                {
                }
                field("Customer Requests Nos."; Rec."Customer Requests Nos.")
                {
                }
                field("Rece. Ship. Header Nos."; Rec."Rece. Ship. Header Nos.")
                {
                }
                field("Development Nos."; Rec."Development Nos.")
                {
                }
                field("Request Expesnsed Nos."; Rec."Request Expesnsed Nos.")
                {
                }
                field("Move The Grave Nos."; Rec."Move The Grave Nos.")
                {
                }
                field("Field Work Nos."; Rec."Field Work Nos.")
                {
                }
                field("Pay. Expect Nos."; Rec."Pay. Expect Nos.")
                {
                }
                field("Payment Receipt Nos."; Rec."Payment Receipt Nos.")
                {
                }
                field("Payment Cr. Memo Nos."; Rec."Payment Cr. Memo Nos.")
                {
                }
                field("Today Funeral Nos."; Rec."Today Funeral Nos.")
                {
                }
                field("Cem. Services Nos."; Rec."Cem. Services Nos.")
                {
                }
                field("Litigation Printing Nos."; Rec."Litigation Printing Nos.")
                {
                }
                field("Membership Printing Nos."; Rec."Membership Printing Nos.")
                {
                }
                field("Cng. Cust. In Contract Nos."; Rec."Cng. Cust. In Contract Nos.")
                {
                }
                field("Reagree To Provide Info Nos."; Rec."Reagree To Provide Info Nos.")
                {
                }
                field("Litigation Raw Progress Nos."; Rec."Litigation Raw Progress Nos.")
                {
                }
                field("Other Service Nos."; Rec."Other Service Nos.")
                {
                }
                field("KPI Target Nos."; Rec."KPI Target Nos.")
                {
                }
            }
            group("External DB Connect")
            {
                Caption = 'External DB Connect';
                field("SMS DB Con. Code"; Rec."SMS DB Con. Code")
                {
                }
                field("Virtual Accnt. DB Con. Code"; Rec."Virtual Accnt. DB Con. Code")
                {
                }
                field("Relationship DB Con. Code"; Rec."Relationship DB Con. Code")
                {
                }
            }
            group("CRM Interface")
            {
                Caption = 'CRM Interface';
                field("CRM Customer URL"; Rec."CRM Customer URL")
                {
                    Editable = NOT rec."Use CRM Interface";
                }
                field("CRM Contract URL"; Rec."CRM Contract URL")
                {
                    Editable = NOT rec."Use CRM Interface";
                }
                field("CRM Fr. Rel. URL"; Rec."CRM Fr. Rel. URL")
                {
                    Editable = NOT rec."Use CRM Interface";
                }
                field("Use CRM Interface"; Rec."Use CRM Interface")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control5; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("External DB Connection")
            {
                Caption = 'External DB Connection';
                Image = Database;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_External DB Con. Infor.";
            }
        }
    }

    trigger OnOpenPage()
    var
        _FunctionSetup: Record "DK_Function Setup";
    begin

        //Initial data generation
        _FunctionSetup.Reset;
        if not _FunctionSetup.Get then begin
            //Default
            _FunctionSetup.Init;
            _FunctionSetup.Insert;
            CurrPage.Update;
        end;
    end;
}

