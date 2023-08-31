page 50283 "DK_Other Service"
{
    Caption = 'Other Service';
    PageType = Document;
    SourceTable = "DK_Other Service";

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
                        Rec.AssistEdit(Rec);
                    end;
                }
                field(Date; Rec.Date)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                }
            }
            part(Line; "DK_Other Service Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("No.");
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
            systempart(Control15; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
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
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.SetReopen;
                end;
            }
        }
    }
}

