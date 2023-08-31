page 50076 "DK_Item Shipment"
{
    // 
    // DK34: 20201110
    //   - Add Field: "Item Type"

    Caption = 'Item Shipment';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Posted Purchase Receipt";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Item Name"; Rec."Item Name")
                {
                    Editable = false;
                }
                field("Item Type"; Rec."Item Type")
                {
                }
                field("Qty. to Receipt"; Rec."Qty. to Receipt")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Receipt Time"; Rec."Receipt Time")
                {
                }
                group(Control32)
                {
                    ShowCaption = false;
                    field("Item Main Cat. Code"; Rec."Item Main Cat. Code")
                    {
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Item Main Cat. Name"; Rec."Item Main Cat. Name")
                    {
                    }
                    field("Item Sub Cat. Code"; Rec."Item Sub Cat. Code")
                    {
                        Importance = Additional;
                    }
                    field("Item Sub Cat. Name"; Rec."Item Sub Cat. Name")
                    {
                    }
                    field("Location Code"; Rec."Location Code")
                    {
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Location Name"; Rec."Location Name")
                    {
                    }
                }
            }
            group("Shipment Information")
            {
                Caption = 'Shipment Information';
                group(Control31)
                {
                    ShowCaption = false;
                    field("Shipment Type Code"; Rec."Shipment Type Code")
                    {
                        Importance = Additional;
                    }
                    field("Shipment Type"; Rec."Shipment Type")
                    {
                    }
                    field("Shipment Date"; Rec."Shipment Date")
                    {
                    }
                    field("Qty. to Ship"; Rec."Qty. to Ship")
                    {
                    }
                    field("Qty. Shipped"; Rec."Qty. Shipped")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field(Inventory; Rec.Inventory)
                    {
                        Editable = false;
                    }
                    field("Total Shipment"; Rec."Total Shipment")
                    {
                    }
                }
                field("Working Group Code"; Rec."Working Group Code")
                {
                    Importance = Additional;
                }
                field("Working Group"; Rec."Working Group")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field(Employee; Rec.Employee)
                {
                }
                field("Use Area"; Rec."Use Area")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Total Inventory"; Rec."Total Inventory")
                {
                }
            }
            part(Line; "DK_Item Shipment Subform")
            {
                Caption = 'Line';
                SubPageLink = "Document No." = FIELD("Document No."),
                              "Document Line No." = FIELD("Line No."),
                              "Entry Type" = CONST(Receipt);
                ToolTip = 'The item line from which the QR code was generated.';
            }
        }
        area(factboxes)
        {
            part(Control15; "DK_Posted Picture Factbox")
            {
                SubPageLink = "Table ID" = CONST(50057),
                              "Source No." = FIELD("Document No."),
                              "Source Line No." = FIELD("Line No.");
            }
            systempart(Control27; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Rec.setPost() then
                        Message(MSG001);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //IF Inventory <> 0 THEN
        //  "Shipment Date" := WORKDATE;
    end;

    trigger OnAfterGetRecord()
    var
        _Employee: Record DK_Employee;
    begin
        //IF Inventory <> 0 THEN
        //  "Shipment Date" := WORKDATE;

        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then
            Rec.Validate("Employee No.", _Employee."No.");
    end;

    var
        MSG001: Label 'The post is completed.';
}

