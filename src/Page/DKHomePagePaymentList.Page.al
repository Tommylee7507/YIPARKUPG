page 50312 "DK_HomePage Payment List"
{
    Caption = 'HomePage Payment List';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_HomePage Payment Entry";
    SourceTableView = WHERE(Status = FILTER(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("General Amount"; Rec."General Amount")
                {
                }
                field("Landscape Amount"; Rec."Landscape Amount")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Payment Method Name"; Rec."Payment Method Name")
                {
                }
                field("Card Approval No."; Rec."Card Approval No.")
                {
                }
                field("Receipt Bank Account"; Rec."Receipt Bank Account")
                {
                }
                field("Receipt Bank Account Desc."; Rec."Receipt Bank Account Desc.")
                {
                }
                field("Old Receipt No."; Rec."Old Receipt No.")
                {
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control19; "DK_Contract Detail Factbox")
            {
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
            action("Create Receipt Document")
            {
                Caption = 'Create Receipt Document';
                Enabled = ButtonControl;
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                Visible = ButtonControl;

                trigger OnAction()
                var
                    _BatchReceiptedPGVA: Codeunit "DK_Batch Receipted PG/VA";
                begin
                    CreateNewDocument;
                end;
            }
            action(Cancel)
            {
                Caption = 'Cancel';
                Enabled = ButtonControl;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = ButtonControl;

                trigger OnAction()
                var
                    _BatchReceiptedPGVA: Codeunit "DK_Batch Receipted PG/VA";
                begin
                    CancelDocument;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ButtonControl := false;
    end;

    trigger OnOpenPage()
    begin
        OpenPage();
    end;

    var
        ButtonControl: Boolean;

    local procedure OpenPage()
    var
        _UserSetup: Record "User Setup";
    begin
        if _UserSetup.Get(UserId) then begin
            if _UserSetup."DK_Home. Pay. Recpt. Admin." then
                ButtonControl := true
            else
                ButtonControl := false;
        end;
    end;

    local procedure CreateNewDocument()
    var
        _DK_HomePagePaymentEntry: Record "DK_HomePage Payment Entry";
        _DK_HomePagePaymentMgt: Codeunit "DK_HomePage Payment Mgt.";
    begin
        CurrPage.SetSelectionFilter(_DK_HomePagePaymentEntry);
        _DK_HomePagePaymentMgt.CreateNewDocument(_DK_HomePagePaymentEntry);
    end;

    local procedure CancelDocument()
    var
        _DK_HomePagePaymentEntry: Record "DK_HomePage Payment Entry";
        _DK_HomePagePaymentMgt: Codeunit "DK_HomePage Payment Mgt.";
    begin
        CurrPage.SetSelectionFilter(_DK_HomePagePaymentEntry);
        _DK_HomePagePaymentMgt.CancelDocument(_DK_HomePagePaymentEntry);
    end;
}

