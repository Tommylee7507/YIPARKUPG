page 50139 "DK_Publish Admin. Exp. Doc."
{
    Caption = 'Publish Admin. Expense Document';
    PageType = Document;
    SourceTable = "DK_Publish Admin. Expense Doc.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("From Date"; Rec."From Date")
                {
                    Editable = false;
                }
                field("To Date"; Rec."To Date")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                }
                group(Control21)
                {
                    ShowCaption = false;
                    field("Total Amount"; Rec."Total Amount")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Non-Pay. General Amount"; Rec."Non-Pay. General Amount")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("General Amount"; Rec."General Amount")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("No. of Line"; Rec."No. of Line")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("No. of Check Cust. Infor."; Rec."No. of Check Cust. Infor.")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("No. of UnCheck Cust. Infor."; Rec."No. of UnCheck Cust. Infor.")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Line; "DK_Publish Admin. Exp. Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
        area(factboxes)
        {
            part(Control8; "DK_Contract Detail Factbox")
            {
                Provider = Line;
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control18; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action25)
            {
                action(Released)
                {
                    Caption = 'Released';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _ChangedCustomerHistory: Record "DK_Changed Customer History";
                    begin

                        Rec.SetReleased;
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.SetReOpen;
                    end;
                }
            }
            group(Action26)
            {
                action("Create Publish Admin. Expense")
                {
                    Caption = 'Create Publish Admin. Expense';
                    Image = CalculateSalesTax;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _CreatePublishAdminEx: Report "DK_Create Publish Admin. Ex.";
                        _PublishAdminExpDocLi: Record "DK_Publish Admin. Exp. Doc. Li";
                        _PopupAction: Action;
                    begin

                        Rec.TestField("Document No.");
                        Rec.TestField(Status, Rec.Status::Open);

                        Rec.CalcFields("No. of Line");
                        if Rec."No. of Line" <> 0 then begin

                            _PublishAdminExpDocLi.Reset;
                            _PublishAdminExpDocLi.SetRange("Document No.", Rec."Document No.");
                            _PublishAdminExpDocLi.SetRange("Print Select", true);
                            if _PublishAdminExpDocLi.FindSet then
                                if not Confirm(MSG002, false) then
                                    exit
                                else
                                    if not Confirm(MSG001, false) then exit;

                            _PublishAdminExpDocLi.Reset;
                            _PublishAdminExpDocLi.SetRange("Document No.", Rec."Document No.");
                            if _PublishAdminExpDocLi.FindSet then
                                _PublishAdminExpDocLi.DeleteAll;

                            Rec."From Date" := 0D;
                            Rec."To Date" := 0D;
                            Rec.Description := '';
                            Rec.Modify;

                            Commit;
                        end;

                        Clear(_CreatePublishAdminEx);

                        _CreatePublishAdminEx.SetPrameter(Rec."Document No.");
                        _CreatePublishAdminEx.RunModal;

                        CurrPage.Update;
                    end;
                }
                action("Print Publish Admin. Expense")
                {
                    Caption = 'Print Publish Admin. Expense';
                    Image = PrintDocument;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error(MSG003);

                        RunPublishAdmin;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        Rec."Document Date" := WorkDate;
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    var
        MSG001: Label 'There is data on the current line. Deletes all data in the line. Do you want to continue?';
        MSG002: Label 'There is data on the current line. Deletes all data in the line. Do you want to continue?';
        MSG003: Label 'Print is possible only if the Status is Released.';

    local procedure RunPublishAdmin()
    var
        _BillLetter: Report "DK_Bill Letter";
    begin
        _BillLetter.Check_CustomerConfirm(Rec."Document No.");
        _BillLetter.SetParam(Rec."Document No.");
        _BillLetter.RunModal;
    end;
}

