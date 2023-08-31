page 50020 "DK_Employee List"
{
    Caption = 'Employee List';
    CardPageID = "DK_Employee Card";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Employee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

