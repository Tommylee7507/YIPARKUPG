page 50004 "DK_Cemetery List"
{
    // *DK32 : 20200716
    //   - Add Field : "Admin. Expense Method"
    //   - Rec. Modify Function : OnAfterGetRecord()

    Caption = 'Cemetery List';
    CardPageID = "DK_Cemetery Card";
    DelayedInsert = true;
    Editable = false;
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
                field("Admin. Expense Method"; Rec."Admin. Expense Method")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
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
            part(Control8; "DK_Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50004),
                              "Source No." = FIELD("Cemetery Code");
            }
            part(Control18; "DK_Interest Cemetery Log")
            {
                SubPageLink = "Cemetery Code" = FIELD("Cemetery Code");
            }
            part(Control33; "DK_Contract Detail Factbox")
            {
                SubPageLink = "No." = FIELD("Contract No.");
            }
            systempart(Control6; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Unsold)
            {
                Caption = 'Unsold';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Cemetery: Record DK_Cemetery;
                    _UnsoldCemeteryList: Page "DK_Change Status Cemetery List";
                begin

                    _Cemetery.FilterGroup(2);
                    _Cemetery.SetRange(Status, _Cemetery.Status::Unsold);
                    _Cemetery.FilterGroup(0);

                    Clear(_UnsoldCemeteryList);
                    _UnsoldCemeteryList.LookupMode(true);
                    _UnsoldCemeteryList.SetTableView(_Cemetery);
                    _UnsoldCemeteryList.SetRecord(_Cemetery);
                    // _UnsoldCemeteryList.SetParam(0);////zzz
                    _UnsoldCemeteryList.RunModal;
                end;
            }
            action(BeenTransported)
            {
                Caption = 'BeenTransported';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _Cemetery: Record DK_Cemetery;
                    _UnsoldCemeteryList: Page "DK_Change Status Cemetery List";
                begin

                    _Cemetery.FilterGroup(2);
                    _Cemetery.SetRange(Status, _Cemetery.Status::BeenTransported);
                    _Cemetery.FilterGroup(0);

                    Clear(_UnsoldCemeteryList);
                    _UnsoldCemeteryList.LookupMode(true);
                    _UnsoldCemeteryList.SetTableView(_Cemetery);
                    _UnsoldCemeteryList.SetRecord(_Cemetery);
                    // _UnsoldCemeteryList.SetParam(1);////zzz
                    _UnsoldCemeteryList.RunModal;
                end;
            }
            separator(Action26)
            {
            }
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
            group(Action41)
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
                    // RunPageLink = "Cemetery Code" = FIELD("Cemetery Code");////zzz

                    // trigger OnAction()////zzz
                    // var
                    //     _Corpse: Page "DK_Corpse List";
                    //     _CorpseRec: Record DK_Corpse;
                    // begin
                    // end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>>DK32
        Rec.CalcFields("Admin. Expense Method");
        //<<DK32
    end;

    var
        MSG001: Label 'Please select %1.';
}

