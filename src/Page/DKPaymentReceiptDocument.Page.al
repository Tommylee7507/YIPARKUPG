page 50133 "DK_Payment Receipt Document"
{
    // 
    // #2232: 20201028
    //   - Rec. Modify Action: Action42
    // 
    // DK34: 20201030
    //   - Add Var: LitigationEditor
    //   - Add Function: CheckLitigationPermission
    //   - Rec. Modify Trigger: OnOpenPage()
    // 
    //     : 20201117
    //   - Delete Function: CheckLitigationPermission
    //   - Delete Var: LitigationEditor
    //   - Rec. Modify Trigger: OnOpenPage()
    //   - Add Field: "Department Code", "Department Name"

    Caption = 'Payment Receipt Document';
    PageType = Document;
    SourceTable = "DK_Payment Receipt Document";
    SourceTableView = WHERE(Posted = CONST(false),
                            "Document Type" = CONST(Receipt));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Payment Date"; Rec."Payment Date")
                {

                    trigger OnValidate()
                    begin

                        if Rec."Payment Date" <> xRec."Payment Date" then begin


                            if (Rec."Payment Date" <> 0D) and (Rec."Payment Date" > Today) then
                                Error(MSG013, Rec.FieldCaption("Payment Date"), Rec."Payment Date", Today);

                            CheckPaymentLine;
                            CheckCreateAuto;
                        end;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Enabled = Rec."Payment Type" <> Rec."Payment Type"::DebtRelief;

                    trigger OnValidate()
                    begin
                        if xRec.Amount <> Rec.Amount then begin
                            CurrPage.Update;
                            CheckCreateAuto;
                        end;
                    end;
                }
                field("Final Amount"; Rec."Final Amount")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Payment Type" <> Rec."Payment Type" then begin

                            case Rec."Payment Type" of
                                Rec."Payment Type"::OnlineCard:
                                    begin
                                        //ERROR(MSG008,FIELDCAPTION("Payment Type"),"Payment Type");
                                    end;
                                Rec."Payment Type"::VirtualAccount:
                                    begin
                                        Error(MSG008, Rec.FieldCaption("Payment Type"), Rec."Payment Type");
                                    end;
                                Rec."Payment Type"::DebtRelief:
                                    begin
                                        if Rec.Amount <> 0 then begin
                                            Message(MSG001, Rec.FieldCaption(Amount), Rec.FieldCaption("Debt Relief Amount"));
                                            Rec.Amount := 0;
                                        end else begin
                                            Message(MSG002, Rec.FieldCaption("Debt Relief Amount"));
                                        end;
                                    end;
                            end;
                            CheckCreateAuto;
                        end;
                    end;
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
                {
                    Visible = Rec."Pay. Expect Doc. No." <> '';
                }
                group(Control14)
                {
                    Editable = Rec."Before Document No." = '';
                    ShowCaption = false;
                    Visible = Rec."Payment Type" = Rec."Payment Type"::VirtualAccount;
                    field("Virtual Account No."; Rec."Virtual Account No.")
                    {
                        Editable = false;
                    }
                }
                group(Control29)
                {
                    Editable = Rec."Before Document No." = '';
                    ShowCaption = false;
                    Visible = Rec."Payment Type" = Rec."Payment Type"::Bank;
                    field("Bank Account Code"; Rec."Bank Account Code")
                    {
                        Caption = 'Bank Account Code';
                    }
                    field("Bank Account Name"; Rec."Bank Account Name")
                    {
                        Caption = 'Bank Account Name';
                        Editable = false;
                    }
                    field("Bank Account No."; Rec."Bank Account No.")
                    {
                        Caption = 'Bank Account No.';
                        Editable = false;
                    }
                }
                group(Control18)
                {
                    Editable = Rec."Before Document No." = '';
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Card) OR (Rec."Payment Type" = Rec."Payment Type"::OnlineCard) OR (Rec."Payment Type" = Rec."Payment Type"::Giro);
                    field("Payment Method Code"; Rec."Payment Method Code")
                    {
                        Caption = 'Payment Method Code';
                        Importance = Additional;
                    }
                    field("Payment Method Name"; Rec."Payment Method Name")
                    {
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;
                    field("Contract No."; Rec."Contract No.")
                    {
                        Enabled = NOT Rec."Missing Contract";

                        trigger OnValidate()
                        begin
                            if xRec."Contract No." <> Rec."Contract No." then
                                CheckCreateAuto;
                        end;
                    }
                    field("Cemetery No."; Rec."Cemetery No.")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Posting Date"; Rec."Posting Date")
                    {
                        ShowMandatory = true;
                    }
                    field(Litigation; Rec.Litigation)
                    {

                        trigger OnValidate()
                        begin
                            //IF xRec.Litigation <> Litigation THEN
                            //  CheckCreateAuto;
                        end;
                    }
                    field("Missing Contract"; Rec."Missing Contract")
                    {
                        Enabled = (Rec."Before Document No." = '') OR (Rec."Payment Type" = Rec."Payment Type"::Bank);

                        trigger OnValidate()
                        begin
                            if xRec."Missing Contract" <> Rec."Missing Contract" then
                                CheckCreateAuto;
                        end;
                    }
                    field(Depositor; Rec.Depositor)
                    {
                        Editable = NOT Rec."Missing Contract";
                        Enabled = NOT Rec."Missing Contract";

                        trigger OnValidate()
                        begin
                            if xRec.Depositor <> Rec.Depositor then
                                CheckCreateAuto;
                        end;
                    }
                    field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                    {
                        Editable = NOT Rec."Missing Contract";
                        Enabled = NOT Rec."Missing Contract";
                    }
                    field(Description; Rec.Description)
                    {
                        MultiLine = true;
                    }
                }
            }
            group("Payment Bill")
            {
                Caption = 'Payment Bill';
                Visible = (Rec."Payment Type" <> Rec."Payment Type"::None);
                group(Control71)
                {
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Cash) OR (Rec."Payment Type" = Rec."Payment Type"::Bank) OR (Rec."Payment Type" = Rec."Payment Type"::Giro) OR (Rec."Payment Type" = Rec."Payment Type"::VirtualAccount);
                    field("Issued Cash Receipts"; Rec."Issued Cash Receipts")
                    {
                    }
                    field("Issued Cash Rec. Date"; Rec."Issued Cash Rec. Date")
                    {
                        Caption = 'Issued Cash Receipts Date';
                        Editable = Rec."Issued Cash Receipts";
                        Enabled = Rec."Issued Cash Receipts";
                    }
                    field("Issued Cash Rec. Mobile"; Rec."Issued Cash Rec. Mobile")
                    {
                        Caption = 'Issued Cash Receipts Mobile No.';
                        Editable = Rec."Issued Cash Receipts";
                        Enabled = Rec."Issued Cash Receipts";
                    }
                    field("Cash Bill Approval No."; Rec."Cash Bill Approval No.")
                    {
                        Caption = 'Cash Bill Approval No.';
                        Editable = Rec."Issued Cash Receipts";
                        Enabled = Rec."Issued Cash Receipts";
                    }
                }
                group(Control66)
                {
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Cash) OR (Rec."Payment Type" = Rec."Payment Type"::Bank) OR (Rec."Payment Type" = Rec."Payment Type"::Giro) OR (Rec."Payment Type" = Rec."Payment Type"::VirtualAccount);
                    field("Issued TAX Bill"; Rec."Issued TAX Bill")
                    {
                    }
                    field("Issued TAX Bill Date"; Rec."Issued TAX Bill Date")
                    {
                        Editable = Rec."Issued TAX Bill";
                        Enabled = Rec."Issued TAX Bill";
                    }
                }
                group(Control9)
                {
                    Editable = Rec."Before Document No." = '';
                    ShowCaption = false;
                    Visible = (Rec."Payment Type" = Rec."Payment Type"::Card) OR (Rec."Payment Type" = Rec."Payment Type"::OnlineCard);
                    field("Card Approval No."; Rec."Card Approval No.")
                    {

                        trigger OnValidate()
                        begin
                            if xRec."Card Approval No." <> Rec."Card Approval No." then
                                CheckCreateAuto;
                        end;
                    }
                }
            }
            group(Control45)
            {
                Caption = 'Litigation';
                field(Division; Rec.Division)
                {

                    trigger OnValidate()
                    begin
                        //IF xRec.Division <> Division THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Legal Amount"; Rec."Legal Amount")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Legal Amount" <> "Legal Amount" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Advance Payment Amount"; Rec."Advance Payment Amount")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Advance Payment Amount" <> "Advance Payment Amount" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Delay Interest Amount"; Rec."Delay Interest Amount")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Delay Interest Amount" <> "Delay Interest Amount" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Liti. Delay Interest Amount"; Rec."Liti. Delay Interest Amount")
                {
                }
                field("Reduction Amount 1"; Rec."Reduction Amount 1")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Reduction Amount 1" <> "Reduction Amount 1" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Reduction Amount 2"; Rec."Reduction Amount 2")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Reduction Amount 2" <> "Reduction Amount 2" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Reduction Amount"; Rec."Reduction Amount")
                {
                }
                field("MTG Amount"; Rec."MTG Amount")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."MTG Amount" <> "MTG Amount" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Move The Grave"; Rec."Move The Grave")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Move The Grave" <> "Move The Grave" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Debt Relief Amount"; Rec."Debt Relief Amount")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Debt Relief Amount" <> "Debt Relief Amount" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Withdraw Mothed"; Rec."Withdraw Mothed")
                {

                    trigger OnValidate()
                    begin
                        //IF xRec."Withdraw Mothed" <> "Withdraw Mothed" THEN
                        //  CheckCreateAuto;
                    end;
                }
                field("Litigation Ramark"; Rec."Litigation Ramark")
                {
                    MultiLine = true;
                }
            }
            part(Line; "DK_Payment Rec. Doc. Line")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("Document No.");
            }
            group(Contract)
            {
                Caption = 'Contract';
                field("Contract Status"; Rec."Contract Status")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Litigation Employee No."; Rec."Litigation Employee No.")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Litigation Employee Name"; Rec."Litigation Employee Name")
                {
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Importance = Additional;
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Litigation Evaluation"; Rec."Litigation Evaluation")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Created Auto."; Rec."Created Auto.")
                {
                }
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
            part(Control37; "DK_Counsel General Factbox")
            {
                SubPageLink = "Contract No." = FIELD("Contract No.");
            }
            part(Control35; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            part(Control60; "DK_Cem. Services Factbox")
            {
                Provider = Line;
                SubPageLink = "No." = FIELD("Cem. Services No.");
            }
            systempart(Control25; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _PayRecePost: Codeunit "DK_Payment Receipt - Post";
                    _UserSetup: Record "User Setup";
                begin

                    // >> #2232
                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Pay. Posting Admin.", true);
                    if not _UserSetup.FindSet then
                        Error(MSG014);
                    //
                    //IF Rec."Contract No." = '20220830006' THEN
                    //  MESSAGE('S1');

                    Clear(_PayRecePost);
                    _PayRecePost.Post(Rec, true);

                    CurrPage.Close;
                end;
            }
            group(Action41)
            {
                action(CopyPostedDocument)
                {
                    Caption = 'Copy Posted Document';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _CopyPostedDocument: Report "DK_Copy Posted Document";
                    begin
                        if Rec."Document No." = '' then
                            exit;

                        Clear(_CopyPostedDocument);
                        _CopyPostedDocument.SetDocumentNo(Rec."Document No.");
                        _CopyPostedDocument.RunModal;


                        CurrPage.Update;
                    end;
                }
                action("Calculation of Admin. Expense")
                {
                    Caption = 'Calculation of Admin. Expense';
                    Image = CalculateBalanceAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _CalcAdminExpense: Page "DK_Calc. Admin. Expense";
                        _Contract: Record DK_Contract;
                        _AdminExpensePrice: Record "DK_Admin. Expense Price";
                    begin

                        if Rec."Contract No." = '' then
                            Error(MSG003);

                        _Contract.Reset;
                        _Contract.SetRange("No.", Rec."Contract No.");
                        if _Contract.FindSet then begin

                            if (Rec."Payment Date" <> 0D) and (Rec."Payment Date" <> Today) then
                                Message(MSG012, Rec.FieldCaption("Payment Date"), Rec."Payment Date");

                            Clear(_CalcAdminExpense);
                            _CalcAdminExpense.SetParameter(Rec."Payment Date");
                            _CalcAdminExpense.LookupMode(true);
                            _CalcAdminExpense.SetTableView(_Contract);
                            _CalcAdminExpense.SetRecord(_Contract);
                            _CalcAdminExpense.RunModal;
                        end else begin
                            Error(MSG004);
                        end;
                    end;
                }
                action("Calculation of Delay Interest")
                {
                    Caption = 'Calculation of Delay Interest';
                    Image = CalculateBalanceAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _Contract: Record DK_Contract;
                        _CalcDelayIntAmount: Page "DK_Calc. Delay Int. Amount";
                        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
                        _DelayInterestAmt: Decimal;
                    begin

                        if Rec."Contract No." = '' then
                            Error(MSG003);

                        // >> DK34

                        _Contract.Reset;
                        _Contract.SetRange("No.", Rec."Contract No.");
                        if _Contract.FindSet then begin
                            if (_Contract."General Expiration Date" = 0D) and (_Contract."Land. Arc. Expiration Date" = 0D) then
                                Error(MSG006);

                            if (_Contract."General Expiration Date" > Today) and (_Contract."Land. Arc. Expiration Date" = 0D) then
                                Error(MSG006);

                            if (_Contract."General Expiration Date" > Today) and (_Contract."Land. Arc. Expiration Date" > Today) then
                                Error(MSG006);

                            Clear(_CalcDelayIntAmount);
                            _CalcDelayIntAmount.SetParameter(Rec."Payment Date", Rec."Document No.");
                            _CalcDelayIntAmount.LookupMode(true);
                            _CalcDelayIntAmount.SetTableView(_Contract);
                            _CalcDelayIntAmount.SetRecord(_Contract);
                            _CalcDelayIntAmount.RunModal;
                        end else begin
                            Error(MSG004);
                        end;

                        /*
                        IF NOT Litigation THEN
                          ERROR(MSG007);
                        
                        _Contract.RESET;
                        _Contract.SETRANGE("No." ,"Contract No.");
                        IF _Contract.FINDSET THEN BEGIN
                        
                          //Ÿ‰¦ýˆ«Š± ‰œ‚‚
                          IF (_Contract."General Expiration Date" < "Payment Date") AND
                             (_Contract."General Expiration Date" <>0D) THEN
                              _DelayInterestAmt := _AdminExpenseMgt.CalcDelayInterestAmount(_Contract,"Payment Date",0);
                        
                          //‘†µýˆ«Š± ‰œ‚‚
                          IF (_Contract."Land. Arc. Expiration Date" < "Payment Date") AND
                             (_Contract."Land. Arc. Expiration Date" <>0D) THEN
                              _DelayInterestAmt += _AdminExpenseMgt.CalcDelayInterestAmount(_Contract,"Payment Date",1);
                        
                          "Delay Interest Amount" := _DelayInterestAmt;
                          Rec. Modify;
                        
                          IF "Delay Interest Amount" <> 0 THEN
                            MESSAGE(MSG005)
                          ELSE
                            MESSAGE(MSG006);
                        END ELSE BEGIN
                          ERROR(MSG004);
                        END;
                        */
                        //<<

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Created Auto." then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CheckCreateAuto;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //CheckCreateAuto;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _ContractNo: Code[20];
    begin

        Rec."Payment Date" := WorkDate;

        if Rec.GetFilter("Contract No.") <> '' then begin
            _ContractNo := Rec.GetRangeMin("Contract No.");

            if _ContractNo <> '' then
                Rec.Validate("Contract No.", _ContractNo);
        end;
    end;

    var
        MSG001: Label 'You can not specify a value for %1. Please specify a value for %2.';
        MSG002: Label 'Please specify a value for %1.';
        MSG003: Label 'Please enter your Contract No first';
        MSG004: Label 'No contract found.';
        MSG005: Label 'Delay interest calculation is completed.';
        MSG006: Label 'Delay interest did not occur.';
        MSG007: Label 'The calculation can not be Action.';
        MSG008: Label '%2 of %1 cannot be specified.';
        MSG009: Label 'This Document is related to a Payment Expect, so it cannot be Rec. Modify or delete. %1:%2';
        MSG010: Label '%1(%2)· „“(%3) €Ëú‘È ýˆ«Š±í Š»µ…—Ž·„Ÿ„¾. €¸ˆ«×  œ ÐŽÊŠ „“€Ø‘÷— ýˆ«Š± ‰œ‚‚Ž¸œ œ‰œ ‰È‹²…—Ž·„Ÿ„¾. ýˆ«Š± Ð‹Óß·œ ’ðœí ‰È‹²…›„Ÿ„¾.\\€¸‡í…… ’ðœ ‰È‹²‹ ‰½“—Ÿ× ýˆ«Š±ˆª Ð‹Ó—Ÿ“À„Ÿ€Ø?';
        MSG011: Label '†Ýží ¬œ ´ˆ‰—‡ž Œ÷‘ñ Š­í—³„Ÿ„¾.';
        MSG012: Label 'The Amount is calculated based on the  %1 entered in this Document. %1:%2';
        MSG013: Label 'You cannot specify a future date for %1. Today :%3';
        MSG014: Label 'You are not authorized. Please contact your administrator.';

    local procedure CheckCreateAuto()
    begin

        if Rec."Created Auto." then
            Error(MSG009, Rec.FieldCaption("Pay. Expect Doc. No."), Rec."Pay. Expect Doc. No.");
    end;

    local procedure CheckPaymentLine()
    var
        _PaymentReceiptDocLine: Record "DK_Payment Receipt Doc. Line";
    begin

        _PaymentReceiptDocLine.Reset;
        _PaymentReceiptDocLine.SetRange("Document No.", Rec."Document No.");
        _PaymentReceiptDocLine.SetFilter("Payment Target", '%1|%2', _PaymentReceiptDocLine."Payment Target"::General, _PaymentReceiptDocLine."Payment Target"::Landscape);
        if _PaymentReceiptDocLine.FindSet then begin
            Error(MSG011);
        end;
    end;
}

