page 50041 "DK_Vehicle Repair"
{
    Caption = 'Vehicle Repair';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Vehicle Led. Entry Header";
    SourceTableView = WHERE("Document Type" = FILTER(Repair),
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
                field("Repair Type"; Rec."Repair Type")
                {
                }
                field("Repair Date"; Rec."Repair Date")
                {
                }
                group(Control20)
                {
                    ShowCaption = false;
                    field("Repair Item Type"; Rec."Repair Item Type")
                    {
                    }
                    field("Repair Item"; Rec."Repair Item")
                    {
                    }
                    field(Quantity; Rec.Quantity)
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
            group("Alarm Information")
            {
                Caption = 'Alarm Information';
                field(Notice; Rec.Notice)
                {

                    trigger OnValidate()
                    var
                        _Alarm: Record DK_Alarm;
                    begin
                        if Rec.Notice <> xRec.Notice then begin
                            if Rec.Notice = true then begin
                                if not Confirm(MSG002, false, _Alarm.TableCaption) then
                                    Rec.Notice := xRec.Notice
                                else
                                    Rec.InsertAlarm
                            end else begin
                                if not Confirm(MSG003, false, _Alarm.TableCaption) then
                                    Rec.Notice := xRec.Notice
                                else
                                    Rec.CancelAlarm;
                            end;
                        end;
                        CurrPage.Update;
                    end;
                }
                field("Recipient Type"; Rec."Recipient Type")
                {
                }
                field("Recipient Code"; Rec."Recipient Code")
                {
                    Importance = Additional;
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                }
                field("Alarm Division"; Rec."Alarm Division")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                group(Control30)
                {
                    ShowCaption = false;
                    field("Alarm Km"; Rec."Alarm Km")
                    {
                        Enabled = Rec."Alarm Division" = Rec."Alarm Division"::Km;
                    }
                    field("Alarm Date"; Rec."Alarm Date")
                    {
                        Enabled = Rec."Alarm Division" = Rec."Alarm Division"::Date;
                    }
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
            part(Control31; "DK_Alarm Factbox")
            {
                SubPageLink = "Source No." = FIELD("No."),
                              "Source Type" = CONST(Vehicle),
                              "Source Line No." = CONST(0);
                UpdatePropagation = Both;
            }
            systempart(Control19; Notes)
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
        Rec."Repair Date" := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    var
        _VehicleMag: Codeunit "DK_Vehicle Management";
        MSG001: Label 'Confirmation is completed.';
        MSG002: Label 'Data is generated from the %1.\Would you like to continue?';
        MSG003: Label 'The data created in the %1 is canceled.\Would you like to continue?';
}

