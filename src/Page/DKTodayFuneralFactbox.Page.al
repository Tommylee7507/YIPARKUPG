page 50097 "DK_Today Funeral Factbox"
{
    Caption = 'Today Funeral Factbox';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Today Funeral";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Funeral Type"; Rec."Funeral Type")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                }
                field("Opening Time"; Rec."Opening Time")
                {
                }
                field(Applicant; Rec.Applicant)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Visible = false;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Visible = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Cemetery Digits"; Rec."Cemetery Digits")
                {
                }
                field(Size; Rec.Size)
                {
                }
                field("Working Group Code"; Rec."Working Group Code")
                {
                    Visible = false;
                }
                field("Working Group Name"; Rec."Working Group Name")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(New)
            {
                Caption = 'New';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Today Funeral Card";
                RunPageMode = Create;
            }
            action(Edit)
            {
                Caption = 'Edit';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Today Funeral Card";
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Date, WorkDate);
        Rec.FilterGroup(0);
    end;
}

