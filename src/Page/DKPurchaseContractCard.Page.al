page 50012 "DK_Purchase Contract Card"
{
    Caption = 'Purchase Contract Card';
    DelayedInsert = false;
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Authorize';
    SourceTable = "DK_Purchase Contract";

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
                field(Title; Rec.Title)
                {
                }
                field("Contract Date"; Rec."Contract Date")
                {
                }
                group(Control12)
                {
                    ShowCaption = false;
                    field(Relation; Rec.Relation)
                    {
                    }
                    field("Vendor No."; Rec."Vendor No.")
                    {
                        Importance = Additional;
                    }
                    field("Vendor Name"; Rec."Vendor Name")
                    {
                    }
                }
                field(Notice; Rec.Notice)
                {

                    trigger OnValidate()
                    var
                        _Alarm: Record DK_Alarm;
                    begin
                    end;
                }
                field("Automatic Extension"; Rec."Automatic Extension")
                {

                    trigger OnValidate()
                    var
                        _AlarmMgt: Codeunit "DK_Alarm Mgt.";
                        _Alarm: Record DK_Alarm;
                    begin
                    end;
                }
                field(Status; Rec.Status)
                {
                }
            }
            part("Alarm Line"; "DK_Purchase Contract Alarm")
            {
                Caption = 'Alarm Line';
                SubPageLink = "Document No." = FIELD("No.");
            }
            part("DK_Purchase Contract Line"; "DK_Purchase Contract Line List")
            {
                Caption = 'Purchase Contract Line';
                SubPageLink = "Purchase Contract No." = FIELD("No.");
                UpdatePropagation = Both;
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
            part(Control16; "DK_Attched Files Factbox")
            {
                SubPageLink = "Table ID" = CONST(50011),
                              "Source No." = FIELD("No."),
                              "Source Line No." = CONST(0);
            }
            part(Control21; "DK_Alarm Factbox")
            {
                SubPageLink = "Source No." = FIELD("No."),
                              "Source Type" = CONST(PurchaseContract);
                UpdatePropagation = Both;
            }
            systempart(Control15; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Hold)
            {
                Caption = 'Hold';
                Enabled = Rec.Status <> Rec.Status::Hold;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetOpen;
                end;
            }
            action(Contract)
            {
                Caption = 'Contract';
                Enabled = Rec.Status <> Rec.Status::Contract;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetContract;
                end;
            }
            action(Cancel)
            {
                Caption = 'Cancel';
                Enabled = Rec.Status = Rec.Status::Contract;
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetCanceled;
                end;
            }
            separator(Action25)
            {
            }
            action(Authority)
            {
                Caption = 'Authority';
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Purchase Contract Authority";
                RunPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        _PurchaseContractAuthority: Codeunit "DK_Purchase Contract Authority";
    begin
        //IF "No." <> '' THEN
        //  _PurchaseContractAuthority.Check_Authority(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Department: Record DK_Department;
    begin
        Rec."Contract Date" := WorkDate;
    end;

    trigger OnOpenPage()
    var
        _PurchaseContractAuthority: Codeunit "DK_Purchase Contract Authority";
    begin
        //IF "No." <> '' THEN
        //  _PurchaseContractAuthority.Check_Authority(Rec);
    end;

    var
        MSG001: Label 'Do you want to change the Status of the %1?';
}

