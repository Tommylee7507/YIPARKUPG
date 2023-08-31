page 50114 "DK_Field Work Sub Category"
{
    Caption = 'Field Work Sub Category';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Field Work Sub Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Work Blocked"; Rec."Work Blocked")
                {
                    Visible = WorkBlockedVisible;
                }
                field(Unit; rec.Unit)
                {
                    Visible = CemServicesVisible;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    Visible = CemServicesVisible;
                }
                field("Min Unit"; Rec."Min Unit")
                {
                    Visible = CemServicesVisible;
                }
                field("Min Amount"; Rec."Min Amount")
                {
                    Visible = CemServicesVisible;
                }
                field("Connect Size"; Rec."Connect Size")
                {
                    Visible = CemServicesVisible;
                }
                field(Remarks; Rec.Remarks)
                {
                    Visible = CemServicesVisible;
                }
                field("Work Group"; Rec."Work Group")
                {
                    Caption = 'Today Funeral Work Group';
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Item Category")
            {
                Caption = 'Item Category';
                Enabled = rec.Blocked <> TRUE;
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DK_Field Work Sub Cat. Detail";
                RunPageLink = "Field Work Sub Cat. Code" = FIELD(Code);
            }
        }
    }

    trigger OnOpenPage()
    begin

        CemServicesCheck;
    end;

    var
        CemServicesVisible: Boolean;
        WorkBlockedVisible: Boolean;


    procedure CemServicesCheck()
    var
        _FieldWorkMainCategory: Record "DK_Field Work Main Category";
    begin

        if _FieldWorkMainCategory.Get(rec."Field Work Main Cat. Code") then begin
            CemServicesVisible := false;
            WorkBlockedVisible := true;

            if _FieldWorkMainCategory."Cemetery Services" then begin
                CemServicesVisible := true;
                WorkBlockedVisible := false;
            end;
        end;
    end;
}

