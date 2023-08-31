page 50250 "DK_Change Status Cemetery List"
{
    Caption = 'Change Status Cemetery List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Status';
    SourceTable = DK_Cemetery;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Estate Name"; Rec."Estate Name")
                {
                }
                field("Estate Type"; Rec."Estate Type")
                {
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Cemetery Option Name"; Rec."Cemetery Option Name")
                {
                }
                field("Unit Price Type Name"; Rec."Unit Price Type Name")
                {
                }
                field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
                {
                }
                field("Tree Type Name"; Rec."Tree Type Name")
                {
                }
                field(Class; Rec.Class)
                {
                }
                field("Landscape Architecture"; Rec."Landscape Architecture")
                {
                }
                field(Size; Rec.Size)
                {
                }
                field("Corpse Size"; Rec."Corpse Size")
                {
                }
                field("Size 2"; Rec."Size 2")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("No. of Corpse"; Rec."No. of Corpse")
                {
                }
                field("Position Row"; Rec."Position Row")
                {
                }
                field("Position Column"; Rec."Position Column")
                {
                    ToolTip = 'Start from the left';
                }
                field(Stone; Rec.Stone)
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control28; "DK_Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50004),
                              "Source No." = FIELD("Cemetery Code");
            }
            part(Control27; "DK_Interest Cemetery Log")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            part(Control26; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
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
            action("Change Status Unsold")
            {
                Caption = 'Change Status Unsold';
                Enabled = UnsoldVisible;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Select a graveyard from the list to change its Status value.';
                Visible = UnsoldVisible;

                trigger OnAction()
                begin
                    ChangeStatusUnsold;
                end;
            }
            action("Change Status Been")
            {
                Caption = 'Change Status Been';
                Enabled = NOT UnsoldVisible;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Select a graveyard from the list to change its Status value.';
                Visible = NOT UnsoldVisible;

                trigger OnAction()
                begin
                    ChangeStatusBeenTransported;
                end;
            }
        }
    }

    var
        MSG001: Label 'Please select %1.';
        UnsoldVisible: Boolean;
        BeenVisible: Boolean;
        MSG002: Label 'Are you sure you want to change it?';
        MSG003: Label 'The change has been completed.';


    procedure SetParam(pStatus: Option Unsold,Been)
    begin

        if pStatus = pStatus::Unsold then begin
            UnsoldVisible := false;
        end else begin
            UnsoldVisible := true;
        end;
    end;

    local procedure ChangeStatusUnsold()
    var
        _Cemetery: Record DK_Cemetery;
    begin

        CurrPage.SetSelectionFilter(_Cemetery);
        if _Cemetery.IsEmpty then
            Error(MSG001, _Cemetery.TableCaption);

        if not Confirm(MSG002, false) then exit;

        if _Cemetery.FindSet then begin
            _Cemetery.ModifyAll(Status, _Cemetery.Status::Unsold);

            Message(MSG003);
        end;

        CurrPage.Update;
    end;

    local procedure ChangeStatusBeenTransported()
    var
        _Cemetery: Record DK_Cemetery;
    begin

        CurrPage.SetSelectionFilter(_Cemetery);
        if _Cemetery.IsEmpty then
            Error(MSG001, _Cemetery.TableCaption);

        if not Confirm(MSG002, false) then exit;

        if _Cemetery.FindSet then begin
            _Cemetery.ModifyAll(Status, _Cemetery.Status::BeenTransported);

            Message(MSG003);
        end;

        CurrPage.Update;
    end;
}

