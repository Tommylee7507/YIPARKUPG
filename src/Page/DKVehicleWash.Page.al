page 50042 "DK_Vehicle Wash"
{
    Caption = 'Vehicle Wash';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = WHERE("Document Type" = FILTER(Wash),
                            Status = FILTER(Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Vehicle Document No."; Rec."Vehicle Document No.")
                {
                    Importance = Additional;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Wash Date"; Rec."Wash Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Released)
            {
                Caption = 'Released';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if _VehicleMag.VehiclePost(Rec) then
                        Message(MSG001);
                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        Rec."Wash Date" := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    var
        _VehicleMag: Codeunit "DK_Vehicle Management";
        MSG001: Label 'Confirmation is completed.';
}

