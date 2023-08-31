page 50017 "DK_Cemetery Card"
{
    // *DK32 : 20200716
    //   - Add Field : "Admin. Expense Method"

    Caption = 'Cemetery Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Cemetery;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Estate Code"; Rec."Estate Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Estate Name"; Rec."Estate Name")
                {
                }
                field("Estate Type"; Rec."Estate Type")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Admin. Expense Method"; Rec."Admin. Expense Method")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                }
                field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Cemetery Option Code"; Rec."Cemetery Option Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Option Name"; Rec."Cemetery Option Name")
                {
                }
                field("Unit Price Type Code"; Rec."Unit Price Type Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Unit Price Type Name"; Rec."Unit Price Type Name")
                {
                }
                field("Cemetery Dig. Code"; Rec."Cemetery Dig. Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
                {
                }
                field("Tree Type Code"; Rec."Tree Type Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Tree Type Name"; Rec."Tree Type Name")
                {
                }
                field(Class; Rec.Class)
                {
                }
                field(Size; Rec.Size)
                {
                }
                field("Size 2"; Rec."Size 2")
                {
                }
                field("Corpse Size"; Rec."Corpse Size")
                {
                }
                field("Landscape Architecture"; Rec."Landscape Architecture")
                {
                }
                field(Stone; Rec.Stone)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("No. of Corpse"; Rec."No. of Corpse")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                }
            }
            group(Position)
            {
                Caption = 'Position';
                field("Position Row"; Rec."Position Row")
                {
                }
                field("Position Column"; Rec."Position Column")
                {
                    ToolTip = 'Start from the left';
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
            part(Control30; "DK_Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50004),
                              "Source No." = FIELD("Cemetery Code");
            }
            part(Control20; "DK_Interest Cemetery Log")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            part(Control40; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
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
            action(UnitPrice)
            {
                Caption = 'Unit Price';
                Image = Price;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Cemetery Unit Price";
            }
            action(Discount)
            {
                Caption = 'Discount';
                Image = Discount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Cemetery Class Discount";
            }
            action("Administrative Expense")
            {
                Caption = 'Administrative Expense';
                Image = JobPrice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Admin. Expense Setup";
            }
            action("Create New Cemetery")
            {
                Caption = 'Create New Cemetery';
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Upload Cemetery";
            }
            action("Change Cemetery Status")
            {
                Caption = 'Change Cemetery Status';
                Image = Status;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DK_Change Cemetery Status";
                RunPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            group(Action44)
            {
                action(Corpse)
                {
                    Caption = 'Corpse';
                    Image = BusinessRelation;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DK_Corpse List";
                    RunPageLink = "Cemetery Code" = FIELD("Cemetery Code");

                    // trigger OnAction() ////
                    // var
                    //     _Corpse: Page "DK_Corpse List";
                    //     _CorpseRec: Record DK_Corpse;
                    // begin
                    // end;
                }
            }
        }
    }
}

