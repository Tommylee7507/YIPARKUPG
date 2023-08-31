page 50021 "DK_Employee Card"
{
    Caption = 'Employee Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                    Importance = Additional;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Business Contacts"; Rec."Business Contacts")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
            group(Bank)
            {
                Caption = 'Bank';
                field("Bank Code"; Rec."Bank Code")
                {
                    Importance = Additional;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Caption = 'Bank';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Account Holder"; Rec."Account Holder")
                {
                }
            }
            group("Other System")
            {
                Caption = 'Other System';
                field("ERP User ID"; Rec."ERP User ID")
                {
                }
                field("Visual Cemetery PW"; Rec."Visual Cemetery PW")
                {
                    ExtendedDatatype = Masked;
                }
                field("Visual Cemetery Admin."; Rec."Visual Cemetery Admin.")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

