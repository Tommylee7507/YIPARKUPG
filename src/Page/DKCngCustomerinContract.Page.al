page 50221 "DK_Cng. Customer in Contract"
{
    Caption = 'Change Customer in Contract';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Cng. Cust. in Contract";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit(Rec);
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    Lookup = false;
                }
                field(Status; Rec.Status)
                {
                }
            }
            group("Main Customer Information")
            {
                Caption = 'Main Customer Information';
                group(Current)
                {
                    Caption = 'Current';
                    Editable = false;
                    field("Cur. Main Customer No."; Rec."Cur. Main Customer No.")
                    {
                        Caption = 'No.';
                    }
                    field("Cur. Main Name"; Rec."Cur. Main Name")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Main Address"; Rec."Cur. Main Address")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Main Address 2"; Rec."Cur. Main Address 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Main Phone No."; Rec."Cur. Main Phone No.")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Main Mobile No."; Rec."Cur. Main Mobile No.")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Main E-mail"; Rec."Cur. Main E-mail")
                    {
                        AssistEdit = false;
                        Caption = 'E-mail';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
                group(Change)
                {
                    Caption = 'Change';
                    field("Cng. Main Customer No."; Rec."Cng. Main Customer No.")
                    {
                        Caption = 'No.';
                    }
                    field("Cng. Main Name"; Rec."Cng. Main Name")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Main Address"; Rec."Cng. Main Address")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Main Address 2"; Rec."Cng. Main Address 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Main Phone No."; Rec."Cng. Main Phone No.")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Main E-mail"; Rec."Cng. Main E-mail")
                    {
                        AssistEdit = false;
                        Caption = 'E-mail';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Main Mobile No."; Rec."Cng. Main Mobile No.")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
            }
            group("Customer 2 Information")
            {
                Caption = 'Customer 2 Information';
                group(Control57)
                {
                    Caption = 'Current';
                    Editable = false;
                    field("Cur. Customer No. 2"; Rec."Cur. Customer No. 2")
                    {
                        Caption = 'No.';
                    }
                    field("Cur. Customer Name 2"; Rec."Cur. Customer Name 2")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Address 2"; Rec."Cur. Customer Address 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Address 2 2"; Rec."Cur. Customer Address 2 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Phone No. 2"; Rec."Cur. Customer Phone No. 2")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Mobile No. 2"; Rec."Cur. Customer Mobile No. 2")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer E-mail 2"; Rec."Cur. Customer E-mail 2")
                    {
                        AssistEdit = false;
                        Caption = 'E-mail';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
                group(Control58)
                {
                    Caption = 'Change';
                    field("Cng. Customer No. 2"; Rec."Cng. Customer No. 2")
                    {
                        Caption = 'No.';
                    }
                    field("Cng. Customer Name 2"; Rec."Cng. Customer Name 2")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Address 2"; Rec."Cng. Customer Address 2")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Address 2 2"; Rec."Cng. Customer Address 2 2")
                    {
                        AssistEdit = false;
                        Caption = 'Addres 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Phone No. 2"; Rec."Cng. Customer Phone No. 2")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Mobile No. 2"; Rec."Cng. Customer Mobile No. 2")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer E-mail 2"; Rec."Cng. Customer E-mail 2")
                    {
                        AssistEdit = false;
                        Caption = 'E-mail';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
            }
            group("Customer 3 Information")
            {
                Caption = 'Customer 3 Information';
                group(Control60)
                {
                    Caption = 'Current';
                    Editable = false;
                    field("Cur. Customer No. 3"; Rec."Cur. Customer No. 3")
                    {
                        Caption = 'No.';
                    }
                    field("Cur. Customer Name 3"; Rec."Cur. Customer Name 3")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Address 3"; Rec."Cur. Customer Address 3")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Address 2 3"; Rec."Cur. Customer Address 2 3")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Phone No. 3"; Rec."Cur. Customer Phone No. 3")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer Mobile No. 3"; Rec."Cur. Customer Mobile No. 3")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cur. Customer E-mail 3"; Rec."Cur. Customer E-mail 3")
                    {
                        AssistEdit = false;
                        Caption = 'E-mail';
                        DrillDown = false;
                        Lookup = false;
                    }
                }
                group(Control61)
                {
                    Caption = 'Change';
                    field("Cng. Customer No. 3"; Rec."Cng. Customer No. 3")
                    {
                        Caption = 'No.';
                    }
                    field("Cng. Customer Name 3"; Rec."Cng. Customer Name 3")
                    {
                        AssistEdit = false;
                        Caption = 'Name';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Address 3"; Rec."Cng. Customer Address 3")
                    {
                        AssistEdit = false;
                        Caption = 'Address';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Address 2 3"; Rec."Cng. Customer Address 2 3")
                    {
                        AssistEdit = false;
                        Caption = 'Address 2';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Phone No. 3"; Rec."Cng. Customer Phone No. 3")
                    {
                        AssistEdit = false;
                        Caption = 'Phone No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer Mobile No. 3"; Rec."Cng. Customer Mobile No. 3")
                    {
                        AssistEdit = false;
                        Caption = 'Mobile No.';
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Cng. Customer E-mail 3"; Rec."Cng. Customer E-mail 3")
                    {
                        AssistEdit = false;
                        Caption = 'E-mail';
                        DrillDown = false;
                        Lookup = false;
                    }
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
            systempart(Control51; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Released)
            {
                Caption = 'Released';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'The information entered for the change will be modified in the selected contract.';

                trigger OnAction()
                var
                    _CngCustinContract: Codeunit "DK_Cng. Cust. in Contract";
                begin

                    _CngCustinContract.SetRelease(Rec);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Date" := WorkDate;
    end;
}

