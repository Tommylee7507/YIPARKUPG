page 50141 "DK_Publish Ad. Exp. Line Detai"
{
    AutoSplitKey = true;
    Caption = 'Publish Admin. Exp. Line Detail';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Publish Admin. Exp. Doc. Li";

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
                    Importance = Additional;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Document Date"; Rec."Document Date")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ShowMandatory = true;
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    ShowMandatory = true;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    DrillDown = false;
                    Lookup = false;
                    LookupPageID = Navigate;
                }
                field("Estate Code"; Rec."Estate Code")
                {
                    Importance = Additional;
                }
                field("Estate Name"; Rec."Estate Name")
                {
                }
                field("Unit Price Type Code"; Rec."Unit Price Type Code")
                {
                    Importance = Additional;
                }
                field("Unit Price Type Name"; Rec."Unit Price Type Name")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Payment Due Date"; Rec."Payment Due Date")
                {
                }
            }
            group(Details)
            {
                Caption = 'Details';
                group(Control17)
                {
                    ShowCaption = false;
                    field("Prepayment From Date 1"; Rec."Prepayment From Date 1")
                    {
                        Editable = false;
                    }
                    field("Prepayment To Date 1"; Rec."Prepayment To Date 1")
                    {
                    }
                    field("General Amount"; Rec."General Amount")
                    {
                        Editable = false;
                    }
                }
                group(Control39)
                {
                    ShowCaption = false;
                    field("Non-Payment From Date 2"; Rec."Non-Payment From Date 2")
                    {
                        Enabled = false;
                    }
                    field("Non-Pay. Land. Arc. Amount"; Rec."Non-Pay. Land. Arc. Amount")
                    {
                    }
                    field("Prepayment From Date 2"; Rec."Prepayment From Date 2")
                    {
                        Editable = false;
                    }
                    field("Prepayment To Date 2"; Rec."Prepayment To Date 2")
                    {
                    }
                    field("Landscape Arc. Amount"; Rec."Landscape Arc. Amount")
                    {
                        Editable = false;
                    }
                }
            }
            group(Customer)
            {
                Caption = 'Customer';
                field("Check Customer Infor."; Rec."Check Customer Infor.")
                {

                    trigger OnValidate()
                    begin
                        // CheckHeaderReleased("Document No.");////zzz
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = NOT Rec."Check Customer Infor.";

                    trigger OnAssistEdit()
                    begin
                        //AddressLookup;////zzz
                    end;
                }
                field(Address; Rec.Address)
                {
                    Editable = NOT Rec."Check Customer Infor.";
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = NOT Rec."Check Customer Infor.";
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = NOT Rec."Check Customer Infor.";
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    Editable = NOT Rec."Check Customer Infor.";
                }
                field("Check Cust. User ID"; Rec."Check Cust. User ID")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Check Cust. DateTime"; Rec."Check Cust. DateTime")
                {
                    Importance = Additional;
                }
            }
            group("Recetip Bank Information")
            {
                Caption = 'Recetip Bank Information';
                Editable = NOT Rec."Check Customer Infor.";
                Enabled = NOT Rec."Check Customer Infor.";
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account Code"; Rec."Account Code")
                {
                    Editable = Rec."Account Type" = Rec."Account Type"::General;
                }
                group(Control55)
                {
                    ShowCaption = false;
                    field("Bank Code"; Rec."Bank Code")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Bank Account No."; Rec."Bank Account No.")
                    {
                    }
                    field("Account Holder"; Rec."Account Holder")
                    {
                    }
                }
                field("Pay. Expect Doc. No."; Rec."Pay. Expect Doc. No.")
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
            part(Control22; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control31; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Custmer Card")
            {
                Caption = 'Custmer Card';
                Enabled = Rec."Customer No." <> '';
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Customer Card";
                RunPageLink = "No." = FIELD("Customer No.");
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CheckHeaderStatusReleased;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.CheckHeaderStatusReleased;
    end;

    var
        MSG001: Label '%1 for this Document is %2. This function only works if %3.';

    local procedure AddressLookup()
    var
        _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin

        Clear(_DK_KoreanRoadAddrMgt);
        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Rec.Address, Rec."Address 2", Rec."Post Code", _TmpText, _TmpCode);////zzz
    end;

    local procedure CheckHeaderReleased(pDocNo: Code[20])
    var
        _PubAdminExpDoc: Record "DK_Publish Admin. Expense Doc.";
    begin

        _PubAdminExpDoc.Get(pDocNo);

        if _PubAdminExpDoc.Status = _PubAdminExpDoc.Status::Open then
            Error(MSG001, _PubAdminExpDoc.FieldCaption(Status),
                          _PubAdminExpDoc.Status::Open,
                          _PubAdminExpDoc.Status::Released);
    end;
}

