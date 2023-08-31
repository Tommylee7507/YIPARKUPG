page 50039 "DK_Vehicle Operation"
{
    Caption = 'Vehicle Operation';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = WHERE("Document Type" = FILTER(Operation),
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
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Departure Date"; Rec."Departure Date")
                {
                }
                field("Arrival Date"; Rec."Arrival Date")
                {
                }
                field("Departure Time"; Rec."Departure Time")
                {
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                }
                field("Km Cumulative"; Rec."Km Cumulative")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Status; Rec.Status)
                {
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
            systempart(Control28; Notes)
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

        Rec."Departure Date" := WorkDate;
        Rec."Arrival Date" := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    var
        _VehicleMag: Codeunit "DK_Vehicle Management";
        MSG001: Label 'Confirmation is completed.';
}

