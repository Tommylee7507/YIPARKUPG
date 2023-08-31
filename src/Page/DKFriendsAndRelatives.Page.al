page 50304 "DK_Friends And Relatives"
{
    Caption = 'Friends And Relatives';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Friends And Relatives";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Relation No."; Rec."Relation No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                group(Control39)
                {
                    ShowCaption = false;
                    field(Status; Rec.Status)
                    {
                    }
                    field(Memo; Rec.Memo)
                    {
                        MultiLine = true;
                    }
                }
            }
            group("Customer Information")
            {
                Caption = 'Customer Information';
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Cust. Post Code"; Rec."Cust. Post Code")
                {
                }
                field("Cust. Address"; Rec."Cust. Address")
                {
                }
                field("Cust. Address 2"; Rec."Cust. Address 2")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cust. Type"; Rec."Cust. Type")
                {
                }
                field("Cust. E-Mail"; Rec."Cust. E-Mail")
                {
                }
                field("Cust. Birthday"; Rec."Cust. Birthday")
                {
                }
                field("Cust. Gender"; Rec."Cust. Gender")
                {
                }
                field("Cust. Company Post Code"; Rec."Cust. Company Post Code")
                {
                }
                field("Cust. Company Address"; Rec."Cust. Company Address")
                {
                }
                field("Cust. Compnay Address 2"; Rec."Cust. Compnay Address 2")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
            }
            group("Agreement on Personal Information")
            {
                Caption = 'Agreement on Personal Information';
                field("Cust. Personal Data"; Rec."Cust. Personal Data")
                {
                }
                field("Cust. Marketing SMS"; Rec."Cust. Marketing SMS")
                {
                }
                field("Cust. Marketing Phone"; Rec."Cust. Marketing Phone")
                {
                }
                field("Cust. Marketing E-Mail"; Rec."Cust. Marketing E-Mail")
                {
                }
                field("Cust. Per. Data Third Party"; Rec."Cust. Per. Data Third Party")
                {
                }
                field("Cust. Per. Data Referral"; Rec."Cust. Per. Data Referral")
                {
                }
                field("Cust. Per. Data Concu. Date"; Rec."Cust. Per. Data Concu. Date")
                {
                }
                field("Cust. Re. Prov. Info Send Date"; Rec."Cust. Re. Prov. Info Send Date")
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
            systempart(Control36; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action44)
            {
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.SetRelease;
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        rec.SetOpen;
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec."Contract No." <> '') and (Rec."Line No." <> 0) then begin
            if Rec.Status = Rec.Status::Open then begin
                Error(MSG001, Rec.FieldCaption(Status), Rec.Status::Open, Rec.Status::Release);
            end;
        end
    end;

    var
        MSG001: Label 'If %1 is %2, the window can not be closed. First change %1 to %3.';
}

