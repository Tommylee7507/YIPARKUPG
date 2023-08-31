page 50091 "DK_Dev. Target"
{
    // 
    // # 2107 - 2020-08-18
    //   - Delete Part: DK_Upload Cemetery

    Caption = 'Development Target';
    PageType = Document;
    SourceTable = "DK_Dev. Target Header";

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
                }
                field(Description; Rec.Description)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                group(Control17)
                {
                    ShowCaption = false;
                    field("Dev. Date From"; Rec."Dev. Date From")
                    {
                    }
                    field("Dev. Date To"; Rec."Dev. Date To")
                    {
                    }
                }
                field(Status; Rec.Status)
                {
                }
            }
            part(Lines; "DK_Dev. Target Subform")
            {
                Caption = 'Lines';
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
            part("Dev. Target Counsel (General)"; "DK_Counsel General Factbox")
            {
                Caption = 'Dev. Target Counsel (General)';
                Provider = Lines;
                SubPageLink = "Contract No." = FIELD("Contract No."),
                              Type = CONST(General),
                              "Dev. Target Doc. No." = FIELD("Document No."),
                              "Dev. Target Doc. Line No." = FIELD("Line No.");
            }
            part(Control23; "DK_Contract Detail Factbox")
            {
                Provider = Lines;
                SubPageLink = "No." = FIELD("Contract No.");
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
            action(Release)
            {
                ApplicationArea = Suite;
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                //// var
                ////     ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    Rec.SetReleased;
                end;
            }
            action(Reopen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re&open';
                Enabled = Rec.Status <> Rec.Status::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                //// var
                ////     ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    Rec.SetReOpen;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Dev. Date From" := WorkDate;
        Rec."Dev. Date To" := WorkDate;
    end;
}

