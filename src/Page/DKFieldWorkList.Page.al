page 50115 "DK_Field Work List"
{
    Caption = 'Field Work List';
    CardPageID = "DK_Field Work";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Field Work Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Open | Release));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Work Time Spent"; Rec."Work Time Spent")
                {
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Source Cemetery No."; Rec."Source Cemetery No.")
                {
                }
                field("Funeral Type Name"; Rec."Funeral Type Name")
                {
                }
                field(TotalAmount; rec.TotalAmount)
                {
                }
                field("Work Manager Name"; Rec."Work Manager Name")
                {
                }
                field("Short Memo"; Rec."Short Memo")
                {
                    Caption = 'ˆÃˆÚ';
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Type"; Rec."Source Type")
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
                field("User ID"; Rec."User ID")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control12; "DK_Today Funeral Detail")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = rec."Source Type" = rec."Source Type"::Today;
            }
            part(Control14; "DK_Customer Requests Factbox")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = rec."Source Type" = rec."Source Type"::Request;
            }
            part(Control17; "DK_Cem. Services Factbox")
            {
                SubPageLink = "No." = FIELD("Source No.");
                Visible = rec."Source Type" = rec."Source Type"::Service;
            }
            systempart(Control29; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Completion)
            {
                Caption = 'Completion';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    _FieldWorkHeader: Record "DK_Field Work Header";
                    _FieldWorkPost: Codeunit "DK_Field Work - Post";
                begin
                    CurrPage.SetSelectionFilter(_FieldWorkHeader);
                    if _FieldWorkPost.Post(_FieldWorkHeader) then
                        Message(MSG001);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WorkMemoList := rec.GetWorkMemoCalculated();
    end;

    trigger OnOpenPage()
    begin

        if Rec.FindFirst then;
    end;

    var
        MSG001: Label 'The result is complete.';
        WorkMemoList: Text;
}

