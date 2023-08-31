page 50300 "DK_KPI Target Document"
{
    // 
    // DK34: 20201113
    //   - Create

    Caption = 'KPI Target Card';
    PageType = Document;
    SourceTable = "DK_KPI Target";

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
                field("OBJECT ID"; Rec."OBJECT ID")
                {
                    Importance = Additional;
                }
                field("Report Taget Name"; Rec."Report Taget Name")
                {
                    ShowMandatory = true;
                }
                field(Year; Rec.Year)
                {
                    ShowMandatory = true;
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
            part(Line; "DK_KPI Target Subform")
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
            systempart(Control16; Notes)
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
                var
                    _KPITargetMgt: Codeunit "DK_KPI Target Mgt.";
                begin
                    _KPITargetMgt.SetRelease(Rec);
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
                var
                    _KPITargetMgt: Codeunit "DK_KPI Target Mgt.";
                begin
                    _KPITargetMgt.SetReopen(Rec);
                end;
            }
        }
    }
}

